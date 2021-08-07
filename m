Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C475C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA1761042
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhHGPxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhHGPxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 11:53:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A995C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 08:53:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o185so16898807oih.13
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPJ8Jk5ihHvwAI+tCDvBkW9vlqM7wYE6NBcfuG28+ak=;
        b=izPJe5MVGFS5oOTaHeqbocu6ZZXdc+YXnsYI0qjRBKzA+qcWRXhplIdVzvkO5AnRrb
         a8C6e+C0xlgr6GPI2FLmUITAYtlWenSPN2NyqRdg5x+q91tY98b8y7N/8laSGY20kFgt
         00lKP/MrWm3VIUstfie8sc+0bHRRLvmYoKQnpXVNqQXCclvWLRQhdkCdTwtrdMsuPIqx
         X3wJyLLtbtJQ2dG6NVg+etmiKWEgZsImC0caAa0eHA3hCrH0zQHuoOWkkZ23xqTPywtg
         naZYcEyPhAWdgMpuXqGMt1rf7+Kw07yYhx+D2r35ULhc94UYDvdFUxXI5USLMr2FP5uk
         4k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPJ8Jk5ihHvwAI+tCDvBkW9vlqM7wYE6NBcfuG28+ak=;
        b=lBeoW8Jpshx3nXHW+M670fFMNHZx8DLjW/Wk4gBjj/uoQK77Hb/CKzbkJw2S8h0xlJ
         7v2yUdHq+fxYsdj+RDKgPY00T7+MmJmSaFzewnIMGtcXanQR5jsSGO9iMg80zZmd9Wz6
         /W6BBkjLXiZ1M2xffwVIbIGZaga6tBxLzKaJYoskrSWkXX2W+oW8Q1YhbvxxLDhL/PFg
         FXr5j08RWcGGEeOQKOabsCrRVvAFBRdDlZvXvFbt1lKX3Dg6BZ10N1tr7wyRT/toksPz
         Y1sA7lgM7mEfRyluvay2yt0ZIM5w6/3NCmCGIKtRCb0u7Zs4qE4lBMJ9aQyybTmFLyPX
         TVyA==
X-Gm-Message-State: AOAM532JPIaFlTYnPdohbYh73FrvGBxi96naxkQ1sSBYfG+/9qNFVEHM
        K4tgbvSiaYwWTa9VPQEoj80+latcBhtnVpeWRJg=
X-Google-Smtp-Source: ABdhPJyoJP73V2bKWVCHa2lyvY6FNzsL9gL6cCGTmXEvd7ig8cc48dAPIneuCFIH/Izkrfg/nXCkwr03atqqgllovQ8=
X-Received: by 2002:aca:902:: with SMTP id 2mr4701943oij.167.1628351595862;
 Sat, 07 Aug 2021 08:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzgtuf6r0.fsf@gitster.g>
In-Reply-To: <xmqqzgtuf6r0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Aug 2021 09:53:04 -0600
Message-ID: <CABPp-BGSB5K636sgfGwpaHeFUyGGnGcVVBHLg96m-Jf=gajmSg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/merge-strategy-docs (2021-08-05) 10 commits
>  - Update error message and code comment
>  - merge-strategies.txt: add coverage of the `ort` merge strategy
>  - git-rebase.txt: correct out-of-date and misleading text about renames
>  - merge-strategies.txt: fix simple capitalization error
>  - merge-strategies.txt: avoid giving special preference to patience algorithm
>  - merge-strategies.txt: do not imply using copy detection is desired
>  - merge-strategies.txt: update wording for the resolve strategy
>  - Documentation: edit awkward references to `git merge-recursive`
>  - directory-rename-detection.txt: small updates due to merge-ort optimizations
>  - git-rebase.txt: correct antiquated claims about --rebase-merges
>  (this branch is used by en/ort-becomes-the-default.)
>
>  Documentation updates.
>
>  Expecting a (hopefully final) reroll.

I'm not sure what you're expecting in another reroll.  No one has
commented on my v3 suggesting any issues and I'm not aware of any
remaining things to fix or include.

On my second-to-last reroll, v2, I got 4 comments on v2 -- a looks
good from each of you and Stolee and Dscho, and Ramsay pointing out an
issue with one of the commit messages.  So I fixed the commit message
in v3 and added Stolee's and Dscho's acks.  You already picked up v3.

Is there something specific you wanted to see?
