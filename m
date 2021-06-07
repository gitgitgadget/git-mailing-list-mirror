Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF4C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC7161182
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFGV7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:59:46 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42662 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGV7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 17:59:44 -0400
Received: by mail-oi1-f177.google.com with SMTP id v142so19155621oie.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNp/1qaoXBSUvELPCMP0jeok90XlkxF9mJp0qkF88p4=;
        b=ZJaNiMBRgYTxWhEvXsJ2jPFN2p43tONKyjDUzboY76eM9y+IGWyXFRznjvF6AXBVIJ
         o9Ow9Na4wX9sUaUB4Wpx+gLzerHrARmvFOlSOfHtb6u6i3DRNflqZCwDSCCtAqVqNuF5
         a5rU1Qve696+ItIAF0sHhznsE4sSC/rKCGjlORSqHyFCnPJMaFeA/MJLCnEExZPRhV77
         qXKgvjp2rlWN0VaTJbCyFEYh7nFLxxSRHACohgT28mMx5S20BhzCnD/R76T6XSQTgt+/
         SlZ5EMah8zEEhZ8WY40CwXSBt+gu+C1LFIT/+Iv4AaYHDglNtRYHl36FPn7ITYKssIaj
         mIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNp/1qaoXBSUvELPCMP0jeok90XlkxF9mJp0qkF88p4=;
        b=gmY1/2e8oGTOAk43Xd82ijOewioAiOHANUlKVQiliuR7dxcKSjV8ZQ6ZdGo4ABpJ+t
         af1QOhm8CMkxnY/0L8hBbcRzThnu+8C1yCPYDxKNJLE+UFZBsoS7Yu0BNrTvRxvTSMHB
         sajdY3BXr7UilDDZiPYwGi1nCs77Gyr+ShCQawfayN2JxXJ1etn8SmfbRTMpRL4IXsS8
         0bv48vJ/zosJKsQSEpVEeLNREkWq9D9CE2IMzoeWNHSn/m58HuCsmPlqCmKOYcT50p1U
         qUz1L4QwyxjArR4sabtr31+tHlcvxzpIVDdZ9G94abjxj0KIs+5+EzL1/Yrgwl+Fo2+D
         Lzhw==
X-Gm-Message-State: AOAM531GA13V8gvhvNzf/YjUVdnCd/BWGV/7y+hCjRsO2mCJmualGKLU
        ZzSRoTaTLUsc1xJ66WNTZr2cGeSJQ9iaB48npWg=
X-Google-Smtp-Source: ABdhPJzojNiLYLc89VccUd/PjnOBtgCNh/UvcW9BuizSsD0EirdbSHDuK1uShj8byn1dSUpzCDM0+3UvqH/Q0MXISUQ=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr835804oiw.31.1623103002593;
 Mon, 07 Jun 2021 14:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BE-2s+0vOg+icJGBgR5X6BpoTieJd2KH39SbXW1WAA1Ew@mail.gmail.com>
 <60be93c64372d_db80d20887@natae.notmuch>
In-Reply-To: <60be93c64372d_db80d20887@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Jun 2021 14:56:31 -0700
Message-ID: <CABPp-BEY9=48NU8VtKs9qLDQ5zTkLKviq4KAXc39QYPBizjZ3w@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-filter-repo 2.32.0
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// Moving git-packagers to bcc in case this thread continues any further.

On Mon, Jun 7, 2021 at 2:46 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > The latest release of git-filter-repo, v2.32.0, is now available.  It
> > is comprised of 32 non-merge commits since v2.29.0, including 20
> > changes from five new contributors.
>
> Maybe provide a quick summary of what git-filter-repo is?

A tool for rewriting git history.  Think of it roughly as a
replacement for git-filter-branch (without the glaring safety or
performance issues), or as a more versatile bfg repo-cleaner.

Thanks for the tip; I'll include a synopsis in future release announcements.
