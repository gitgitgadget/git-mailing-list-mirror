Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C7C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A40D22D6F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 11:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLELkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 06:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgLELiw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 06:38:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40CC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 03:38:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d3so7506351wmb.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y9myp7XP4RTYr5lLTugEGMTpUzBruKxyPk1fasRS54=;
        b=hTKI7Inc7TjQKvIXLmk6Hezvj8RSftT1wZgrLe7QHCUCqEh684vQRWbuk5OvwEAHUK
         VjsGtLNRC3hwzNi+EWstT+DmhDPqMHbChUB3lv7jQN8tgTM1U+gdLt3/BY1NvXo4FM+n
         jN7R3rhAI1Cz6qj9HBML+IiMFD8cVzG5odc/ecNzlGSqYtWAYpJ9ipWV4KwLdC5T3aEG
         L8XVCY5tT3KlC8Qow+nNbVLIbbbnnoitNGxMdwOKLyn3q0H7zOT1G+h8IDk4BAtcbtaC
         zX3NWnfmU5EJYw/XhzAvVrK8sz6bBBcqr4PHA2pLRf9ZXqTreHAMGTiGc7DFsp3VLhdm
         3EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y9myp7XP4RTYr5lLTugEGMTpUzBruKxyPk1fasRS54=;
        b=Hec5qy1nvv0CTGLfi8SU0QPVjxC75PFbwdrPusGaH3xj/AOORD4Fk6a6kNemzhpQW1
         u7Tvc1j0l/r+A2rHwib1TJBlOqL7VaJrj20D2S/+WaJ3MaCUKVZ8VWlsAu09eqkhKj8w
         K4hY2fymbwIURIF88mM/d8MSasI+0cJB6N+aKmHZ/6RLRMa4UyZ4zJlufVzltmLARSJt
         5rjrHobQ1mVO918j2Ls6027cHQwLhCp6seNSpBChlZSewLjA6uOVcjfmtWqSmRm80/MY
         siHrkMOi4Febopa2u7NHwSmQrz6/eb+nerhlyt0Fv0iF1rbDWTPsjyZg6dJ5ftfXTROQ
         PaHg==
X-Gm-Message-State: AOAM5316+e59dMJsCl5tG/WKUXOcZ/6m3twUGTGh93J0qqAQkk7d/dCG
        Ky8SeXtEgRFNHD9V1EWBEOfLezmX/faYJ6iQbsk=
X-Google-Smtp-Source: ABdhPJwcJweEaYjdfsg8L/ufawl4oBr9J5UqKZbjcJVPQqLrsWnxwAeOV+datPIRCyTU6KtvLgevFdBusKBl2BfAzoI=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr8866359wmc.55.1607168289478;
 Sat, 05 Dec 2020 03:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-12-felipe.contreras@gmail.com> <CABPp-BG0WWvk96T757WMx=004qVqkf+SU8m3cCZsb1feTZJ80Q@mail.gmail.com>
 <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
In-Reply-To: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Dec 2020 05:37:58 -0600
Message-ID: <CAMP44s3RcsFeE4qLC49GwipfxsB97c55TnxHK-dCGd3hEH5TVw@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] tentative: pull: change the semantics of --ff-only
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 10:01 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 5:39 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > We want --ff-only to make sense only when no --merge or --rebase option
> > > is specified.
> >
> > A lot of git commands have opposite options, and git allows them both
> > to be specified with the last one winning.  Thus, much like
> >   git log --patch --no-patch
> > mean show logs without patches and
> >   git log --no-patch --patch
> > means show logs with patches, I would similarly expect the following
> > two commands to have opposite behavior:
> >   git pull --merge --no-ff
> >   git pull --no-ff --merge
>
> Good point.
>
> Although I presume you meant --ff-only.
>
> Taking that into consideration it may be possible to make --ff-only
> work straightforwardly.
>
> Further changes to the code are needed though. In the meantime I'm
> sending a quick patch on top of this series.

Nevermind.

I have implemented the changes properly and v3 is ready with some
interesting improvements, but it is still not straightforward.

Currently "git pull --ff-only --merge" fails with:

  fatal: Not possible to fast-forward, aborting.

With the proposed change --merge would override --ff-only and make the
pull essentially --no-ff.

That's still a semantic change. So there's no way around that.

Cheers.

-- 
Felipe Contreras
