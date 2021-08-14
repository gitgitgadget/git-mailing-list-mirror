Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830DC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBECA60F39
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhHNKWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbhHNKTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 06:19:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C78C06129F
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:19:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d16so1359130ljq.4
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if5Lp01Fh5VCTW+R6Nk/PcEt9EoMIiTitUkXLTTmcg8=;
        b=JmaP1W8HFbC6odLwKsLODM/WpL+DuW2AI0wDw0Ukw+xLp3BHv2qJ1qnUumCeXMyeCi
         uxKpezE/s4Zsl0n+wlc8SBakV/ex48e7sQe8EovivM1sfWvyFXqVMNkBvM0uzjMnq6vR
         zdez91deUnQND7IF3SjMyTDkwLlbSpS9U16MrY/pb6e7D0J7eQsIipvL0dNxC/b/b1RB
         S4fFhX98sDhFUhqncswadIXC2QeltwkRnEajF8x5DjbsV+ceomqFQ+WR7ywzvJYivn/Y
         +n9FWajnJn+xyBE1rwZ0CMSB9E8zf3WqeAdzTM8lpLH7E1b3rc3YFCutz1WuCJN8pjgq
         m/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if5Lp01Fh5VCTW+R6Nk/PcEt9EoMIiTitUkXLTTmcg8=;
        b=KUyPOatlDRxKgUKZd8I6lI/wgpeIYnFDfoyNVuGZEm30eg3fjM2afafPSOt4WWNGzo
         za3bVr29owX5BDdPW/I2llMcGCX/oQneZEecBRkSg9KruYbOeB2aNgiujTCjdBu835jQ
         xqvElW8d9vYf6w9TNr4sAVIBnLMzYq8SnnrtqRDHr33rsGtWXYg5iuw0P75tgP/KN6Jm
         cJOSEGxN5QyHsL4mjFJz8BO/i/s9/AuyAmsg30H5XMpxeKeCt/hFUxNTFLyUSVGYwOTH
         Ielxfzmc3DmBE6r7FqIQ8nNRLDNNG2hVakNkr/QKZ/pkzMRMvdgwCdZ8yr+hApEzaLrn
         eLjA==
X-Gm-Message-State: AOAM533F0sdA2qiH2g+Yf1JwObeWtixXsZctn5E+LMla5UDQ1Ry8/82g
        Fw1+c4lMB6Xset+0rGr6AMt3ceV74IScAUpTYMaahPovK38=
X-Google-Smtp-Source: ABdhPJySET9n747u0w8Qek7jgcSs8LZiW8WtOGzNUpbKhD+cXiJY9dCSA1UKNejYndPpClcZDlTrRK4EtfR4lzRV394=
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr5051469ljk.0.1628936349982;
 Sat, 14 Aug 2021 03:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <75911f47-1433-f0a4-7d46-f1fb2fd44cf4@rawbw.com>
In-Reply-To: <75911f47-1433-f0a4-7d46-f1fb2fd44cf4@rawbw.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 14 Aug 2021 03:18:59 -0700
Message-ID: <CAPx1Gvdb=rtjWmc1Qe5iZyuwSF+s-YO7G__VUZ=iZw3x4bAKCw@mail.gmail.com>
Subject: Re: 'git log' doesn't keep log of un-removed and then renamed directory
To:     Yuri <yuri@freebsd.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 14, 2021 at 2:21 AM Yuri <yuri@freebsd.org> wrote:
>
> In the FreeBSD ports tree I restored the previously removed directory
> math/dynare:
>
> 1. git checkout 3fb72e318f7be~1 -- math/dynare

[remaining complex shuffling action that mimics what's needed
in SVN, snipped]

Git is not SVN; do not expect it to behave *like* SVN.

In particular, Git does not have file history.  Git has only commits.

SVN has commits, but SVN commits contain file history.  In Git, the
commits *are* the history, and are the *only history*.  Each commit has
a full snapshot of every file, under the names you told Git to use, with
the contents that you told Git to save.

The command `git log science/dynare` tells Git: Look through
commits, one by one, and whenever there's a file whose name
starts with `science/dynare` that's different in *this* commit, vs the
previous one, tell me about this commit.  Since the old commits
have files named `math/dynare/something` instead, Git doesn't
tell you about them.

The `git log` command has a flag, `--follow`, that has a trick up its
sleeve (wait: does `git log` have sleeves? well, anyway). This trick
is a bit limited though. Let's say there's a README file in the
science/dynare/ directory, as of the latest commit.  If you run:

    git log --follow science/dynare/README

Git will look at *this* commit and find the file, and will look at this
commit's *parent* and *not* find the file, because the parent does
not have `science/dynare/README` in it.  But the parent does
have `math/dynare/README` in it *and that file exactly matches*
this commit's copy.  So `git log` will tell you about this commit and
say that the file was *renamed*.  From this point backwards,
`git log` will be looking, not for `science/dynare/README`, but
instead for `math/dynare/README`.

Unfortunately, the `--follow` trick only works on *one file*. But it
will let you know that if you re-run your `git log` with `math/dynare`
you can see what happened before the renaming.

A future `git log` really should be smarter about detecting the
whole-subtree renaming, and be able to follow it.  This won't
require any change in the repository, just a smarter `git log`.
But someone has to write that smarter `git log`.

Chris
