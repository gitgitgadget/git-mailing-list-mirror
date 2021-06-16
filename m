Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D018C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA1A61356
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFPRmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFPRmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 13:42:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3975C06175F
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:40:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so4256031pjo.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aF77ms78jERLFuEgJmQrMpuFBi3Rv8fGRpbRLh+5RSg=;
        b=mPMLTVnwMus50J43Oba5lcjVtM4oKhUcZVoTsP9UcwRx1Um5rr2MVF6rAQ3cGhoxU0
         1mVbbzLydY/N1ANcARfCw9MrmwmPdJAUWOaopfmG6h/qjdsrfL2/AgvnjH3NpbOHSxIR
         7M/Z3rlECFFz5Y2tOcpvg+2h8GenhzY7eO4pMw26SI9eoQEULBGhM3uyUqFhyPVk9fzB
         HpxU7TcvPXu3AV5XNNFmHiXOZSdNuoPCmmb7u7TpXVpdjdZ337K5ghLcPLxrh6dATxny
         91R2gwG0Q1T6rSR+S75A9qWfUxC5RY2rA5M7V58zHViKJDunG2S1Cy97Cz5mrdZxjov7
         daYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aF77ms78jERLFuEgJmQrMpuFBi3Rv8fGRpbRLh+5RSg=;
        b=ewQK502MFaEyXz369uV4UcafBjtXu8KWVREt8b+qiBAKAKp47/oPtAwyShDDBizq+5
         X6N06RfafDI8sBCMt6Jps6MDHNDWwY8fLwNyuqlfhZUqgk+AuaxvShM7Ql8U12GFat7y
         NYFAxrTMHYFSdRjjihYUZlGyj8J4EeSp6wLP1d5l8JAevxYvle09rBxlZ4caxSKmdJnA
         6yPdsDR1SxUnbr/fa18WhSC7hgyF/0rsiACAAnNwVeMJaRWNMP/pXdS51A/bYOl0han7
         GUsVKGS8YBB8zjgRw7xvH1oan71ityIPmyQueBZ6t82vstBoIfNT7M5pgMM29ObAyKgo
         6+2A==
X-Gm-Message-State: AOAM530mOAUm2cAtYQMVgOAMvG8YCWDHhlqqDbgi7AcQxpzj0gALAL7k
        XO09xov8oY7dafV6l2RFMRQ=
X-Google-Smtp-Source: ABdhPJxRtLaVSSCQLgB7+rkj+dOZhBz7U5wZfxneq3QoEU0nhUsHuF5slR0UVOEKEbtctbgLdkyc8g==
X-Received: by 2002:a17:90a:ad98:: with SMTP id s24mr12236266pjq.211.1623865236331;
        Wed, 16 Jun 2021 10:40:36 -0700 (PDT)
Received: from generichostname ([172.92.1.94])
        by smtp.gmail.com with ESMTPSA id f18sm5894207pjq.48.2021.06.16.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:40:35 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:40:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Harrison McCullough <mccullough.harrison@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Error in bash completion
Message-ID: <YMo3j6mqiKBTTEbS@generichostname>
References: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harrison,

On Wed, Jun 16, 2021 at 09:44:38AM -0600, Harrison McCullough wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
> 2. Use the `__git_complete` function to add Bash tab completion for your custom
>    Bash function, e.g. `__git_complete ga git_add`
> 3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`
> 
> 
> What did you expect to happen? (Expected behavior)
> 
> Bash tab-completes the file path.
> 
> 
> What happened instead? (Actual behavior)
> 
> Bash tab-completes the file path but also displays an error:
> 
> $ ga fi-bash: [: -lt: unary operator expected
> le3.txt

This happened as a result of my changes at e94fb44042
(git-completion.bash: pass $__git_subcommand_idx from __git_main(),
2021-03-24) and 87e629756f (git-completion.bash: rename to
$__git_cmd_idx, 2021-04-22).

The tl;dr is that $__git_cmd_idx must be set to the index of the
git command you're executing (e.g. for `git add`, the index of `add`).
As a workaround for you, try setting __git_cmd_idx=0 where you define
ga().

Now, a question to the wider list: does git-completion.bash have a
public interface? I've been working off the assumption that any time a
user uses the internals, it's at their own risk. Is this a valid
assumption to make?

-Denton
