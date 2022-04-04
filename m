Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D9C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 07:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbiDDH1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiDDH1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 03:27:30 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8303616D
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 00:25:34 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-df02f7e2c9so9636226fac.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQvqxTdGyv6RqNwxDY/ynR+1hhG/RVjvZHqgKQb3qFY=;
        b=JAoKF6LQ4mqHRsBap3dciWvZDkfWENTHvO6G1FsOyjG1xd/9UfIjxUftid2yHMYv4d
         2ih07PtNK4V49B2T6OCehNOjv+pikJR8+2lo5FaGYuZOdq0r8uyyJaaPbLI+S6m2pBMJ
         Eduw25GZfGyhJJNfWXe+xqPfkqpa2KRMS8AtMezQHZyDeKoMlLIb0XysA042gthPm5I2
         OwmZEftM/5dBeABWNlFbcIAlrOnxHZiMkpcZ5O7nUg6DlRO7rj+xZv9urU0uWamsKZbu
         PBlnSbmDl8Gn4bo0XBhVES8DC2c/QFlY5jEM3QHOvNa3HPjY6nED+EGYADUuQKoqfte1
         WvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQvqxTdGyv6RqNwxDY/ynR+1hhG/RVjvZHqgKQb3qFY=;
        b=7c937gNwooekQgJfg7BNP4kfQEtkxy7pIkqtD/I3K34gjXeXkJZu8mJN6oYDmwtMBV
         R87CwoyiKIc1jgQU+M8OcP6xRisM6V0P3NWgNZbr8HsVGEEiY+U9LM9IzCZRnxFKXb+x
         LkHUXNFo/6Lir0e1bgBvcLtnmZ12WluaIsv60kLFcHDJ0ihqXYfXnQbFUxqwqhOqRuBs
         iEg80F6LNBLGOnw4mLrPJpGXe4fZ3zfAgeH7LQUcUpz5OfC4XQySY0JZ/u9LZqNxwQhG
         WElQdQ+lcFJp6Bm4KV5a0jkGi4GTMQ9A2vxC1hsbZc2wto3ey7da1suFBbi3Erddc+WC
         Cj6w==
X-Gm-Message-State: AOAM533/fWCG7BRTHJQdPUzxACNiNk4sQ7EEJ22IL17FPl8icZF1fCny
        IqNY0mBLtM4VlEUOMu0+AeJtInVHsttRxoU4LLo=
X-Google-Smtp-Source: ABdhPJzWP3U05p94d714XKa69mBw1QBY2mydncYS3nCyJTBTYXG52xIA2MDz+6DjIRvRXxEUXnJ7vSB/Fc3gJBHZ9m4=
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id
 ej19-20020a056870f71300b000d28adbaaebmr10196305oab.111.1649057133949; Mon, 04
 Apr 2022 00:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com> <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
 <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com> <22aadea2-9330-aa9e-7b6a-834585189144@github.com>
In-Reply-To: <22aadea2-9330-aa9e-7b6a-834585189144@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 4 Apr 2022 15:25:23 +0800
Message-ID: <CAJyCBOSQVA5oEW7_iKZW895ycQ4T=XAx422s4m+6VFDSDVeNMA@mail.gmail.com>
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 1, 2022 at 10:49 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 4/1/2022 8:49 AM, Shaoxuan Yuan wrote:> On Fri, Apr 1, 2022 at 5:28 AM Victoria Dye <vdye@github.com> wrote:
> >>
> >> Shaoxuan Yuan wrote:
> >>> Originally, moving a <source> directory which is not on-disk due
> >>> to its existence outside of sparse-checkout cone, "giv mv" command
> >>> errors out with "bad source".
> >>>
> >>> Add a helper check_dir_in_index() function to see if a directory
> >>> name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
> >>> such directories.
> >>>
> >>
> >> Hmm, I think this patch would fit better in your eventual "sparse index
> >> integration" series than this "prerequisite fixes to sparse-checkout"
> >> series. Sparse directories *only* appear when you're using a sparse index
> >> so, theoretically, this shouldn't ever come up (and thus isn't testable)
> >> until you're using a sparse index.
> >
> > After reading your feedback, I realized that I totally misused
> > the phrase "sparse directory". Clearly, this patch series does not
> > deal with sparse-
> > index yet, as "sparse directory" is a cache entry that points to a
> > tree, if sparse-index
> > is enabled. Silly me ;)
> >
> > What I was *actually* trying to say is: I want to change the checking
> > logic of moving
> > a "directory that exists outside of sparse-checkout cone", and I
> > apparently misused
> > "sparse directory" to reference such a thing.
>
> In the case of a full index (or an expanded sparse index, which is
> currently always the case for `git mv`), you detect a sparse directory
> by looking for the directory in the index, _not_ finding it, and then
> seeing if the cache entry at the position where the directory _would_
> exist is marked with the SKIP_WORKTREE bit.
>
> This works in cone mode and the old mode because I assume you've already
> checked for the existence of the directory, so if there _was_ any
> non-SKIP_WORKTREE cache entry within the directory, then the directory
> would exist in the worktree.
>
> (These are good details to include in the commit message.)

I read and think about this part a few times, but I'm still confused.

As Victoria pointed out earlier, and I quote, "Sparse directories *only* appear
when you're using a sparse index, so, theoretically, this shouldn't ever
come up (and thus isn't testable) until you're using a sparse index."
So I'm not so sure what do you mean by putting "full index" and "sparse
directory" together.

Thus, I go ahead and try to detect a directory that is outside of
sparse-checkout cone, without sparse-index enabled.

I found a problem that if you use cache_name_pos() to do this
detection, I imagined the following example (I'm trying to imitate an
output of "git ls-files -t"):

H a
H b
S d/file1
H e/file1

So in this index, I use cache_name_pos() to find a directory "c/". I imagine the
the value returned would be -3, which indicates this directory would be inserted
at index position 2. However, the cache entry at position 2 is
"d/file1", which is
marked with SKIP_WORKTREE, and this fact cannot guarantee that "c/" is
a sparse directory, since ''c/" is not in the index per se.

Probably I'm missing something, or I'm just dumb.

> Thanks,
> -Stolee

-- 
Thanks & Regards,
Shaoxuan
