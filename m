Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1EBC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 04:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F7F61C31
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 04:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhF1EzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 00:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhF1EzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 00:55:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F343C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 21:52:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so805784otg.9
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RXTtH3EMtnQwg9Gt4vhHzRBJIdjuh2SdYci467aJwk4=;
        b=rGithYkWN2WxuLyrMF1nykjjVp4gvXOh0Sq4JZYKylc2lrJ0iMfZzv3ffOzClMC4lS
         1OCT/OBKDR0QaLaig/pCbxlhBnpQGfZ/5XcgiFlM1J9h6k4VUySvGz3bhAJKuLXjzYm2
         z08/e3RWdz2n0Ac9d+2QhZZ2eYoTBJdEm48ilknVS/TgrIud36stmyYYHmi6kWgdTu+V
         G9DYJsQV9KH26mq3NV38MbcJQDe6567Ii0rffvDM6Z36L5mDVx+Ib9utJedecvfV75M/
         i3doFcGbPoiu2HlYjI5Q9NLtlPHfKn41deh/V3nR6Or5JWr71uGp87D0wSE61kKvb5HZ
         xzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RXTtH3EMtnQwg9Gt4vhHzRBJIdjuh2SdYci467aJwk4=;
        b=M3TSo3J09E1ovBIC2LE3TsNXiJ8mYSPyIXLk4L+/kacAzu3uiVfaN7bqPQR5GhZtmX
         wtUFTvHy3Zx/2cA+O/pe5AwPnQEGxzMsOX811LogGPolG83QE4yPoGWtOi1uoxmiw64d
         7gwiht6hlQF1XHSSWpxNJBl2mu40Pbq9Rv2Td2sqjII6+INimlZ5Fpb/IxWMY3oxurIo
         VRTv11l1aLug9rz+0/euC10it8sRYDJmaVDTK4GKB6n/Sqj/41yu15ozWr3nYBlcAEGd
         jw9UxNs52M+2U4b+6W3D9t4BKMZlKivj5Cuv9Ey+5mvwsQMXgEoNR1XIAuNx8K4ZoOKw
         Ye0A==
X-Gm-Message-State: AOAM532pdWXkbg2Fo36qBLHDFWHcMZGKn53VQIWbz9OaFJ92WBTZc6Ge
        8Alw2ajhjRRaN8bg+4IEKiM=
X-Google-Smtp-Source: ABdhPJwHHSxjGBHOMYRCJKYTwWwsrWkZxvZlcNOKNNMZukSYxuwEVMAIu5kEjZNjPayqKM/2t+h4iQ==
X-Received: by 2002:a05:6830:4a2:: with SMTP id l2mr3409703otd.267.1624855974307;
        Sun, 27 Jun 2021 21:52:54 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a22sm3281853otq.10.2021.06.27.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:52:53 -0700 (PDT)
Date:   Sun, 27 Jun 2021 23:52:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60d955a473187_aaf7e208f6@natae.notmuch>
In-Reply-To: <CAMMLpeQ9BVNHqk2p748+4+ufuWJ46fYUnVvMvwFPxh3N--ASPg@mail.gmail.com>
References: <20210628031642.699156-1-felipe.contreras@gmail.com>
 <CAMMLpeQ9BVNHqk2p748+4+ufuWJ46fYUnVvMvwFPxh3N--ASPg@mail.gmail.com>
Subject: Re: [PATCH] pull: introduce --merge option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Sun, Jun 27, 2021 at 9:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > The idea came after a comment from Linus Torvalds regarding what should
> > be the default mode of "git pull" and why [1].
> >
> > [1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/
> 
> Oh wow, I didn't realize that Linus gave his opinion on the subject
> back in 2013, and he suggested doing nearly exactly what we are trying
> to do now.

Indeed. I incorporated his feedback--along with the feedback of many
others--in my proposal.

I have been re-reading the old threads to write a blog post, and the
whole story starts from 2008. At this point I have probably read more
than one thousand emails, and I'm still far from done.

Actually now that I'm re-reading the draft, the first suggestion of
--merge came from Thomas Rast in 2009 [1] (I forgot).

Long story short: *everyone* (and I do mean everyone) is in favor making
ff-only the default. The disagreements come from how we get there.

> > ---no-rebase::
> > -       Override earlier --rebase.
> > +-m::
> > +--merge::
> > +       Force a merge.
> > ++
> > +Previously this was --no-rebase, but that usage has been deprecated.
> 
> I don't think --no-rebase should be "deprecated", at least not yet.

Deprecated means that we discourage people from using it. It doesn't
mean it's unsupported.

It's not obsolete.

> After all, the equivalent config option is still pull.rebase=false.

Yes, but the equivalent from the command line is:

  git pull --rebase=false

And that's still properly documented:

  -r, --rebase[=false|true|merges|preserve|interactive]

> Also, --merge doesn't necessarily force a merge because it does not
> imply --no-ff.

This is a bit of semantics that I have discussed before with Elijah, and
somehow I managed to convince him [2] that fast-forward can be used as
an adverb, and in fact it already is in plenty of the documentation.

Basically this:

  git merge --ff-only

Does a fast-forward merge. So it's a merge of a special kind. What kind?
The fast-forward kind.

> I would prefer to list --no-rebase, -m, and --merge
> together on the same line and leave the description alone.

I prefer to deprecate --no-rebase. Both --rebase=false and --merge are
less cumbersome alternatives.

But I'm not married to this. If other people want to keep --no-rebase at
the same level as the other two options, I would not object to it.

> But other than the documentation and the commit message, I like the
> idea here, and I think it will make Git a lot more user-friendly.

Good. And for the record I think if this patch is not merged, eventually
somebody else will send something along these lines, since I'm not the
first person to think of it, nor will I be the last.

Cheers.

[1] https://lore.kernel.org/git/200910201947.50423.trast@student.ethz.ch/
[2] https://lore.kernel.org/git/CABPp-BESMs1tuVoLFMy-BahSChFz7oANqTaeJShFa_zDbEnvBA@mail.gmail.com/

-- 
Felipe Contreras
