Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A96C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8CB60FE6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhGEMCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhGEMCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:02:49 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CCC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:00:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l26so17886060oic.7
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pNUGSgpfgq662S1VGTNT4g20vd2J/lONZJvYplfD0g4=;
        b=C3JF7FIXynztbrqhDcvbEeCfU3370qcB6wA7nTkeXOZ9emK8x5kFJ+mMr0YdSvK+sK
         NjRLOXhbwijcaYiID82nRlpSNe/ODP1hQ3nsbb4t3P0p+RW41aQZqsHDk1qP/eB5jsJp
         aE470rO0kjTO44ZLHPiCXxiEtjdnz+MK0HQyLuIrdIjMhhqrhDg6k7XCaRyaVKlXg8Zk
         WqIasHbmEFG7aHEqhypAocVNm2ouEx2l5wjzoaH5TIN+fOSezp/JAqKFZIPu+Ag1a9qy
         bskb/R/abusiV9K4sBd1jT25jiRm+hPCAZQHh7JizBHL5wmNKv0FaYGMYbhjoTVko37M
         mhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pNUGSgpfgq662S1VGTNT4g20vd2J/lONZJvYplfD0g4=;
        b=HqBR9aBz8yoAGWmK0mmVFdKjfd+KkWna73U/jSmXg5ttzHSV4d5oM9gCQvioKd2qXi
         HzHmAaozMEVPs4lCBnmI1o8pDamd8ePsVXo8l6dPtsMqQd0Dgiirz21xeZ/sTt9/d9KO
         aAileS3L7n7A8dGN1tjGo1r5qXId3L+yVk9HdmJIkrJDFD563miuVWIytlvBOvGetlqJ
         ZnP0gTcYeouoklFxQFlNXLD3ylHszw6CjuC1SFBRNlpIDogyEPySIZeCz6cKzXXMIP1S
         bHCIHSW3Fd0s8HteYLxTJ1w8SS016W3/ANs9Np9v//8GT+VY+XIBq7nXZqQ7zcHh7Mu5
         LnIw==
X-Gm-Message-State: AOAM531dxU3Mff7iCVKCPrP1TeX1ogQKwY17+laFWHQJF0mhPy7fHST0
        vXBPR1MYY45tzG/2hAZFiaA=
X-Google-Smtp-Source: ABdhPJy2IvEbVedrYGx5itVe8K+VcniV1dyJMFV+99L8Vikya7du+MKTJANZT6Uc1G3MU0FYmk2LXA==
X-Received: by 2002:aca:f105:: with SMTP id p5mr9720744oih.148.1625486409220;
        Mon, 05 Jul 2021 05:00:09 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l3sm2681418oif.49.2021.07.05.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:00:08 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:00:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60e2f44749749_1b8e782081f@natae.notmuch>
In-Reply-To: <20210705044505.666977-1-alexhenrie24@gmail.com>
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
Subject: RE: [PATCH RFC] rebase: respect --ff-only option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

I don't see any value in doing `git rebase --ff-only`. What is the
difference with `git merge --ff-only`?

Presumably this isn't meant to to be called directly by the user, but
only by `git pull`, so it's trying to address my comment [1]:

  > You can also pass --rebase, --no-rebase, or --ff-only on the command
  > line to override the configured default per invocation.

  Can I?

    git -c pull.rebase=true pull --ff-only

  `--ff-only` doesn't seem to be overriding the configuration.

Passing --ff-only to `git rebase` doesn't solve the problem I was
pointing out, only half of it.

Sure, now this works:

  git -c pull.rebase=true pull --ff-only

But --ff-only is not really overriding anything, now you are passing the
problem along.

Consider it the other way around:

  git -c pull.ff=only pull --rebase

Is --rebase overriding anything?

No, now all these three fail:

  git -c pull.ff=only pull
  git -c pull.ff=only pull --rebase
  git -c pull.ff=only pull --merge

This is making the situation even worse.

Junio already made the same mistake [2], and I already pointed out why
that doesn't work [3].

This is what we want:

  1. git pull # fail by default unless it's a fast-forward
  2. git pull --merge # force a merge (unless it's a fast-forward)
  3. git pull --rebase # force a rebase (unless it's a fast-forward)

If you make `git rebase` honor --ff-only, and you make --ff-only the
default, then `git pull --rebase` will *always* fail (unless it's a
fast-forward).

We want this:

  git -c pull.ff=only pull --rebase

To *ignore* pull.ff=only, not honor it.

I already explored all the options, which is why I maintain that the
only reasonable option is an orthogonal configuration:

  pull.mode=fast-forward

Cheers.

[1] https://lore.kernel.org/git/60d7faaf5311a_b8dfe208bd@natae.notmuch/
[2] https://lore.kernel.org/git/xmqqy2irjy4f.fsf@gitster.c.googlers.com/
[3] https://lore.kernel.org/git/CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com/

-- 
Felipe Contreras
