Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF19C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiC2WuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiC2WuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:50:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946231AD86
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:48:39 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-deb9295679so13104424fac.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srE0vdL+MI3BH5Glm1HmIFh+Kqb01jPV2ydbOl6EWEc=;
        b=X+P9dWJHpz3ovfFpDGU2axlmOQj/40iPJmkGHW7bUseiPUD7mnhG8GPrr9L++2aEvT
         T/aYRv14nx3YvooBbez8cuaSRTf5DrQeFS0oSF5GD8t8USrRsUsRmCLjsATZNNR4DWtx
         qfvimgwCWuqj7y/nDoHWkPbYdy68PuXSgJq9Ip9BqKlRqfj934Yi/VaTuJczn6KGtltE
         XZApCiDRBn4hBBgWYRLmJU1Yj05p38EjWllBI5BRALzGoAm0o7h1bR40n4KMwPyAMFMz
         DlCAV+lWIsT2nj56RYw7ZhFVr201zjf868HWkruIlqxjysAjpPKgV/xoTFiq2F5oI1E/
         bRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srE0vdL+MI3BH5Glm1HmIFh+Kqb01jPV2ydbOl6EWEc=;
        b=ot8BJcMDu0KZJd0XAwSf8iDN7Cu2PJs1BYrQD2iSnmrWBnEalxQtutWPQettxYcr4y
         zxjrSlcWfYi6QHjGhbV152edEM5HZijIY3C3GHzcrMFT4r3h1kimJwDZm3A9GbYRLrOM
         mRbXLlEUik0GLHsM6DqOK3Qg2j7HWhEaB2hUBPnI30Ib28CLIhyEqc2BUngh9t++aNJU
         8NHITAq4gd4cTq7URLUDYSB55ReOLoY1iAHfxN3LZyWSI9M/ftlSLWMwp1aS69Q4YFko
         deVmiRMGdIFFK3zr7y/lF5ir+VOdz50X5M3OiTebYkImyvFNOMI53ikvmGVPVVv6Pjoo
         RVaw==
X-Gm-Message-State: AOAM530RTIk9IDI0rsldymVAaf94lPEiwISs0bXiJUc7muH4zkgiOsuH
        Qvp4KFmMAv7VDP5ISlqP3PUFSVRrPjzNSeBBCFdhpkqjwOQaUpaK
X-Google-Smtp-Source: ABdhPJyaKWMtb+Mkz/WvUEookH2OyiqQxkLIFujnL34T5tNRRv/V4qWK4YVfmxttKtozyruJv0YjNz3gCRMFwbbqW7M=
X-Received: by 2002:a05:6870:5705:b0:de:29e1:67f7 with SMTP id
 k5-20020a056870570500b000de29e167f7mr830926oap.213.1648594118756; Tue, 29 Mar
 2022 15:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-3-calvinwan@google.com> <xmqqy20sqtfe.fsf@gitster.g>
In-Reply-To: <xmqqy20sqtfe.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 29 Mar 2022 15:48:28 -0700
Message-ID: <CAFySSZB5aTAsYn=Oqd_hUCQu+X1+GCgpvscLYqk+qzGQc3sAVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] transfer.advertiseObjectInfo: add object-info config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It strikes me somewhat odd that this is the _first_ such capability
> that needs a variable here to control if it is advertised or not
> depending on the configuration file settings.

> In other words, "Why doesn't transfer.advertiseSID also have a
> similar thing in this file?" should be the first question that comes
> to any reviewers' mind.
It doesn't exist in protocol-caps.c, but instead in serve.c. Would be
a good discussion for whether the advertise function should be serve.c
or protocol-caps.c

> "If unset(yet), try to get_bool() and if it fails, set it to 0"

> So advertise_object_info becomes true only if transfer.advertiseObjectInfo
> is set to true?
This was the bug I introduced and will reroll

On Tue, Mar 29, 2022 at 3:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Currently, object-info is always advertised by the server. Add a
> > config option to optionally advertise it. A subsequent patch uses this
> > option for testing.
> >
> > ---
> >  Documentation/config/transfer.txt |  4 ++++
> >  protocol-caps.c                   | 11 +++++++++++
> >  protocol-caps.h                   |  6 ++++++
> >  serve.c                           |  2 +-
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> > index b49429eb4d..14892a3155 100644
> > --- a/Documentation/config/transfer.txt
> > +++ b/Documentation/config/transfer.txt
> > @@ -77,3 +77,7 @@ transfer.unpackLimit::
> >  transfer.advertiseSID::
> >       Boolean. When true, client and server processes will advertise their
> >       unique session IDs to their remote counterpart. Defaults to false.
> > +
> > +transfer.advertiseObjectInfo::
> > +     Boolean. When true or not set, server processes will advertise its
> > +     ability to accept `object-info` command requests
> > \ No newline at end of file
>
> Carefully proofread before sending your changes out ;-)
>
> By mimicking the style of the previous item more closely, i.e.
>
>         Boolean. When true, ... requests. Defaults to true.
>
> it would make it easier to read, I suspect.
>
> > diff --git a/protocol-caps.c b/protocol-caps.c
> > index bbde91810a..f290e3cca2 100644
> > --- a/protocol-caps.c
> > +++ b/protocol-caps.c
> > @@ -8,6 +8,9 @@
> >  #include "object-store.h"
> >  #include "string-list.h"
> >  #include "strbuf.h"
> > +#include "config.h"
> > +
> > +static int advertise_object_info = -1;
>
> It strikes me somewhat odd that this is the _first_ such capability
> that needs a variable here to control if it is advertised or not
> depending on the configuration file settings.
>
> In other words, "Why doesn't transfer.advertiseSID also have a
> similar thing in this file?" should be the first question that comes
> to any reviewers' mind.
>
> Perhaps we just invented a better way to handle such conditional
> capability, in which case we may want to port the existing ones that
> do not use the same arrangement over to the new way.  Even though it
> would be outside the scope of the series, it would be a good way to
> make sure we won't accumulate too much technical debt to leave some
> hint somewhere near here or in protoco-caps.h where this patch
> touches.  I cannot quite tell what is going on.
>
> > int object_info_advertise(struct repository *r, struct strbuf *value)
> > {
> >       if (advertise_object_info == -1 &&
> >           git_config_get_bool("transfer.advertiseObjectInfo", &advertise_object_info))
> >               advertise_object_info = 0;
> >       return advertise_object_info;
> > }
>
> "If unset(yet), try to get_bool() and if it fails, set it to 0"
>
> So advertise_object_info becomes true only if transfer.advertiseObjectInfo
> is set to true?
>
> It is inconsistent with what we read in the documentation, isn't it?
>
> > diff --git a/protocol-caps.h b/protocol-caps.h
> > index 15c4550360..36f7a46b37 100644
> > --- a/protocol-caps.h
> > +++ b/protocol-caps.h
> > @@ -5,4 +5,10 @@ struct repository;
> >  struct packet_reader;
> >  int cap_object_info(struct repository *r, struct packet_reader *request);
> >
> > +/*
> > + * Advertises object-info capability if "objectinfo.advertise" is either
> > + * set to true or not set
> > + */
> > +int object_info_advertise(struct repository *r, struct strbuf *value);
> > +
> >  #endif /* PROTOCOL_CAPS_H */
> > diff --git a/serve.c b/serve.c
> > index b3fe9b5126..fb4ad367a7 100644
> > --- a/serve.c
> > +++ b/serve.c
> > @@ -133,7 +133,7 @@ static struct protocol_capability capabilities[] = {
> >       },
> >       {
> >               .name = "object-info",
> > -             .advertise = always_advertise,
> > +             .advertise = object_info_advertise,
> >               .command = cap_object_info,
> >       },
> >  };
>
> This is a good step to add a test to see if the server does honor
> the (1) lack of (2) true set to and (3) false set to the
> configuration variable and sends (or does not send) the capability.
