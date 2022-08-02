Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B40C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiHBVDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHBVDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:03:19 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B8745046
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:03:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10d845dcf92so18580318fac.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PoIRxaZLXJhUMKHTnDgzu7vEEfVyoGWqHAmnLIGbGNQ=;
        b=R07oOCI9b/KX83D/Wea9YyRe5RyO92bnM6nInEOJeBUP+FsTT2pGSvB00sinK084Kd
         +AlrIqdYqqh1PbiaAsclZ75ZlPRrGyANUCyBWcFswj2Dvfatk//zr5AunqwlZbNTIleT
         Fb9gsrEI9tL0a3imDdh85CoymMq8Z44bcRAS37fHm1II+zX4go+GyyAgUImYj8Oi5TB9
         GZ7K5mQ2G5r7V5RRj3c0PpL+MWUy4HMrADwHnBGSgYzYyogkpENBb/pnVRHdEE2odqb+
         H4D1fYTIIUYVXg+ZWDvt7ND3ZCmTyQUUVd7Ozl5Od083zsi7OGPlDmcqFb8HxpCWXvC8
         hccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PoIRxaZLXJhUMKHTnDgzu7vEEfVyoGWqHAmnLIGbGNQ=;
        b=xecmi7CU9usToGWnhgBfxb58OMFVNy1VAZGVdnTiM8X/Ep0NxJfeKJYwndl2BfJ6go
         l6OwaJjwIYaZ72W5cpYOPjTXi6Z117szWLykVHGTtUII7KuHxvtYoyf8ESB4phVOiaBn
         wHRug7Um0dnnMLJ/ubUCITRso3fcui5Wqp4lcBVHcrX9ZBFJ+rWoyGG/if5MoTGu2xrK
         8MjiLZa2dn2qwYrdAzgwGsyIJdiBJeqWe04+L9/jK0aIsxoMRPrqSQtvk4QnfiDrlnxc
         lJbuIZG+u8QBKeDJoS0lwaV6MObpjQTkIwM1ePU+6xvAVVmU5Bl1JuGWvpM92JOyz6IF
         X+Uw==
X-Gm-Message-State: ACgBeo1mjK6DX40ygaIfpT6KJePgzFmBjQlSJCSuI+Nmkqd+MC5hJU2C
        qIXdlnm8I+nHBAETx8iNboh+EgUQRz1q3wXoG0BZwQ==
X-Google-Smtp-Source: AA6agR6cNnSbjojFhavUHIa4qSvyAyu2Vx7UB1LI3FbcGl29oVNOgg229g7Bv9uIoGW23Y2SVcUoxe4Aqg+QXp14xDg=
X-Received: by 2002:a05:6870:8328:b0:10c:fdf5:3be2 with SMTP id
 p40-20020a056870832800b0010cfdf53be2mr573122oae.4.1659474198235; Tue, 02 Aug
 2022 14:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210020.3397249-1-calvinwan@google.com>
 <20220728211221.2913928-1-calvinwan@google.com> <xmqqpmhjjwo9.fsf@gitster.g>
In-Reply-To: <xmqqpmhjjwo9.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 2 Aug 2022 14:03:07 -0700
Message-ID: <CAFySSZCEWX22h1FBX65=eofNm+WU97DtL7P+11WFie72DQLDkg@mail.gmail.com>
Subject: Re: [PATCH v7] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -570,6 +574,8 @@ static const char *type_short_descriptions[] = {
> >               "CONFLICT (submodule history not available)",
> >       [CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
> >               "CONFLICT (submodule may have rewinds)",
>
> The other ones are semi sentences ...
>
> > +     [CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
> > +             "CONFLICT (submodule no merge base)"
>
> ... and this wants to become one, too, e.g. "submodule lacks merge
> base", perhaps?

lacks/missing both SGTM


>         if (is_null_oid(a) || is_null_oid(b))
>                 BUG(...);
>
> may be easier to read, perhaps?

ack

> I wonder where this overly deep indentation come from?  Can the
> .editorconfig file we ship with the project help?

It comes from me not properly indenting the line. I'll take a look at
the .editorconfig file.

> When we say "either merge commit %s" (where %s is 'b'---what they
> have as we saw earlier), do we need to mention what the value of 'a'
> is to the user, or is it redundant because we are absolutely sure
> that 'a' is what is checked out in the submodule?

We are absolutely sure that 'a' is the GITLINK to the submodule, but
if the user changes their local submodule without updating the reference,
it can result in errors like "not checked out" and "commits not present"
during the merge.

> > +                     strbuf_addf(&tmp, _("or update to an existing commit which has merged those changes"));
>
> "those changes" means "a..b"?  Again, I just want to make sure that
> the user in this situation knows "the other end" of the range when
> they are told only about 'b'.

Correct. Based on what I said above, it might be worthwhile to mention
'a' as well since that information could also help the user in those cases.
I'm thinking something like this:

"go to submodule ('sub' : 'a'), and either merge commit 'b'\n"
"go to submodule ('sub', 'a'), and either merge commit 'b'\n"
"go to submodule 'sub', commit 'a', and either merge commit 'b'\n"
