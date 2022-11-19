Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE76C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKSXo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 18:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKSXoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 18:44:25 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2C120BF
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:44:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k7so7580804pll.6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xej9AVBUvnhtrQ0Gf5ryAJoUTtMvMEtyrbCf0H5yXE=;
        b=Gww/rYJICDyIdzIkWLaXNzFjb6pQlqLdNmbe86XseYN9CxkKE0t07L4k1hsw49jVxi
         Z7hs6VBHt95QkwbhtFWuVA9p5hGCthMY5kMVM7jbnqiOEUJBz5kWG6rnZK7TKweHj6Al
         2Hd0b82ZQIYCKihMbnSN3JSFdNGtoQgXw8AewwOc3UJsJXmLeeP18dTupM2rb6TE/gii
         cpkUS0POvjnUMVg6zS3RKVMwTzrK5/PC60ucMxYupiS2IoZvGoaGrR0UDfoneZPRgLNd
         3eI4uZGOb6Q/XjQijr0DyjOqaVBdfrLXlI+klZnmzA3r+toC81LRYRE03NbwK68w+nqb
         TShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Xej9AVBUvnhtrQ0Gf5ryAJoUTtMvMEtyrbCf0H5yXE=;
        b=H24lXfaXtYRNIbha04anB3KodCG8aL7D5IQCvLk006h3uH/Em0V7LQ03DGthQOot6t
         8MzqEpAysiqblyOoXl13Arq1j1t1Kj2vc5mCBmKpKK2zsyAvgJElKq2STlnU9Y7RJOra
         Ji4htXgI75wXHvfCVZNhfYB2wNuy2Pu9nUpqPgpPhU5A9XfTLGOiAm6gyO4pSk3bVBPf
         K/7IxRgvUBxjCWSBUzniZPEn5mpFhrpLg6rqgpctm/kv2oCtdFCYnGAVCC/a2im3AuKc
         CggWddXV54qoIlG356Chc/+07E0SZ/5t/SiXxcs2C3HijJLsCh62R/UbIXupc3xtTMK+
         bS8g==
X-Gm-Message-State: ANoB5pkCdhdVVdTEYIXnvUn7mYAGQwcKL1Um/qs7E4lEY++fJqr452YM
        FbTqD7pcvFA7wcMupI+9oIscoGT59Sp7omu41ND7sq3GR3FHqQ==
X-Google-Smtp-Source: AA0mqf4GjaQxEQmUTH/RsWm8rPZX5BxBg48rPL0mco3M0waZga+OMTUTSaJVfB4jjpQMoJQKHtk7uiQyAt0UhA6tGO0=
X-Received: by 2002:a17:90b:3d90:b0:200:7cf7:3d79 with SMTP id
 pq16-20020a17090b3d9000b002007cf73d79mr19416587pjb.206.1668901464210; Sat, 19
 Nov 2022 15:44:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
 <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
 <CAPig+cSMoAoVW_NTidyN0rgTTY-FaQ49CAFQZhPyaYBsYu-RfA@mail.gmail.com>
In-Reply-To: <CAPig+cSMoAoVW_NTidyN0rgTTY-FaQ49CAFQZhPyaYBsYu-RfA@mail.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Sun, 20 Nov 2022 08:44:13 +0900
Message-ID: <CAF5D8-ujg3Tp2s2+eGMgZfXXcZEyRKreAj=EkG0KiMniKjoKBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-jump: invoke emacsclient
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 12:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Would it make sense to expand this to support the VISUAL and EDITOR
> environment variables too? For instance, since I want to use Emacs for
> all my editing needs, I have EDITOR set to reference emacsclient. So,
> if GIT_EDITOR is unset, then check VISUAL, and if that is unset, check
> EDITOR.

"git var GIT_EDITOR" does respect VISUAL and EDITOR environment variables.
See git-var(1) reference manual.

> Also, on macOS, I need to set EDITOR (or GIT_EDITOR or VISUAL) to the
> full path of emacsclient, but the regex used here is too tight to
> recognize that. Perhaps loosening it to just 'emacsclient' would be a
> good idea (as it seems unlikely to falsely match any other editor)?

It is a good idea. Thanks!
-- 
Yoichi NAKAYAMA
