Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0CC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiBXXO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXXOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:14:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D029275797
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:14:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a25d387000000b006245d830ca6so1364616ybf.13
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=5zbsAes1rpAyeHofFaFLqYGGtlYpUu3aCekyDxT6dfg=;
        b=EOJkdMNIEFdHa9sXPkuaMMpu3NfNjYcwO9QZh8DTGDKA0BRCBSPftonc4e8AWssoK5
         v/NEeuMLpQUzNIP5Q2I5yjD/VoFH8P0T/WsmoZln8KnLtp1gIDj0PGBwN8Pu6SoXjECr
         NOua9MJMwd3uYkgKxzHkF8C/3qfiJ9NKqURA8Nu9r3riUBDgWpxV1kxFuNR6/+1E+DAo
         ka2woyvK87Qr4PgbVQ/hR6PR9221jF4EBr6MU66bZATxwH2jef4kx5+4Jgk5nTzXEV8J
         VimMRz+IDc9qNh5eCo1UOnwJmrgFV9BmbsMM6YV/T85CgUMyGrvFi7JrUDUwn9nBgJoD
         BsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=5zbsAes1rpAyeHofFaFLqYGGtlYpUu3aCekyDxT6dfg=;
        b=r13gmI9ORZpckJ0vncjpq7dc10qGwV3ZR7seJLNpzysERmEkBI/+6GEI4Y5jXMRASD
         rqg5rK2MWOFwpYNglYCwDzyeK6GrqjX6afTlbjNYULOCN3NZjsou4PCLJaI5CDkj8kOD
         b8exDQ5mvaCelCCulx57BQib75uIxLUrac8n/vYS6+0zB85DWyp8Tm51g92pyaMgkWsh
         mD5UPGu32NdgOUyBiGvBtwLammzBrvZKd7o5BLf7djLih6hRrKMd2UEeFgHWFzajdzUm
         hVCTa2ZYY3bmKASKqfcykxsmwzk1wzsh3qQpnVF9VjDX2ltX9DAicUP2NTAc3sF2GR6Y
         L+kA==
X-Gm-Message-State: AOAM531ZZSn3/DOG/3ehkR1AaD5JTJshL+a2tZ/KZHZ3ZntAf3FfJhYY
        JxzZ/TyHNsrdjLzlstV0uVdPwY12jxvjmXchake9
X-Google-Smtp-Source: ABdhPJy6FaC+toWPTWmug0uhKTJIUfi6yt9e5XceACt8mqO5Jtx7xKAbm/n1N07g+mCh1m+T+cC6KVuEyJW1q0k81AKq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6f8a:0:b0:622:1c0c:1ec6 with
 SMTP id k132-20020a256f8a000000b006221c0c1ec6mr4629433ybc.549.1645744463268;
 Thu, 24 Feb 2022 15:14:23 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:14:20 -0800
In-Reply-To: <20220224100842.95827-4-chooglen@google.com>
Message-Id: <20220224231420.2878760-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH v3 03/10] t5526: create superproject commits with test helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +# For each superproject in the test setup, update its submodule, add the
> +# submodule and create a new commit with the submodule change.
> +#
> +# This requires add_submodule_commits() to be called first, otherwise
> +# the submodules will not have changed and cannot be "git add"-ed.
> +add_superproject_commits() {
> +(
> +	cd submodule &&
> +	(
> +		cd subdir/deepsubmodule &&
> +		git fetch &&
> +		git checkout -q FETCH_HEAD
> +	) &&
> +		git add subdir/deepsubmodule &&
> +		git commit -m "new deep submodule"
> +	) &&

The indentation looks off. Also, no need for "-q".

> @@ -378,19 +387,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
>  '
>  
>  test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
> -	add_upstream_commit &&
> -	(
> -		cd submodule &&
> -		(
> -			cd subdir/deepsubmodule &&
> -			git fetch &&
> -			git checkout -q FETCH_HEAD
> -		) &&
> -		git add subdir/deepsubmodule &&
> -		git commit -m "new deepsubmodule" &&
> -		new_head=$(git rev-parse --short HEAD) &&
> -		check_sub $new_head
> -	) &&
> +	add_submodule_commits &&
>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules true &&

Hmm...I'm surprised that this still passes even when code is deleted but
the replacement is not added. What's happening here, I guess, is that
we're checking that nothing has happened. The test probably should be
rewritten but that's outside the scope of this patch set. So for now,
just add the add_superproject_commits call.

> @@ -402,10 +399,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
>  '
>  
>  test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
> -	git add submodule &&
> -	git commit -m "new submodule" &&
> -	new_head=$(git rev-parse --short HEAD) &&
> -	check_super $new_head &&
> +	add_superproject_commits &&
>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules false &&

add_superproject_commits without add_submodule_commits?

The rest looks good and overall this looks like a good idea to simplify
the test.
