Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347D21F404
	for <e@80x24.org>; Tue, 28 Aug 2018 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeH1WtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:49:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38160 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeH1WtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:49:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so2525024wrc.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TFOgT13mry2aTqo1dLn6BZY4q53iawx3DWDWImZQAjw=;
        b=ET8+DusbYhFNSIFDGF2Dwghu12zAt7C6KYdS6BdfWpGirSZTxd7ZiuLOrEbqqHi7AA
         6IWnIdYSEAJdDS56iBw9VM0llgxjWQlKEHpWYP1kZBjsMqUgRhwn4cY0cUMHKNT/VgBW
         vQodOCjXzFn8Zd+MAfADMF+F6VlgLCywpBiPVh8HDTpuwwUqgXxv2T2ay8+qDT+NBPWC
         uT+5bMTmrhaUUO6cvNoCL9ULxAEueG6SxRioA3xtpLx5tmF6My+q7BUx94nGCAMRzEAF
         c/vDqP+Uyskn1cbiByL5S8i5/nKLEapp+1MYqD5boeuBLRRxfh5qedKQTjAd9Ryh5upZ
         pM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TFOgT13mry2aTqo1dLn6BZY4q53iawx3DWDWImZQAjw=;
        b=GH2ws7QYXnEb2iYqqfQiVtrUkc3GEfALM+X8yChr2W+FSH4ioPuqqoOdvlKY8hBgFm
         QrEzul2GQk3ExHyrB3J9NX/IAbgJEuPGOosLX2mtpd0YY+HCfsCwPFhieFCd9XO17E9/
         y1Hk+QRBa9NXEGhjJO/5zbmFnDdaFHpQdZO2FFjf1DdtGgQBM5CZENCi5O0ho8R0qbdk
         XruhxbR83sSuPbHq3xztyqzen/a+b1tGs1bvA2LdCpmuKinegV7yguFTir2Sk/IYxUbh
         /VmH8yL4KwRPWSS8a835fv25WNvBpPWyu1mSRG6fvEmYzJDj0+pPSO6Wj6+Th//fL5Ye
         I8Og==
X-Gm-Message-State: APzg51C9fXoDnMKJmVMDM811iVGqayAXoHPf+o6JRclb4eZTR8kDfwe4
        /CylQ1hkp+ahy5uOwAfAJ6g=
X-Google-Smtp-Source: ANB0VdbyVxx44IPqov25G3ECeVvczi2RemScVbCh5kjUoJkWq1HiX4fD9nEiflMESQXYCbocizuIPA==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr2054556wrp.85.1535482575561;
        Tue, 28 Aug 2018 11:56:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o33-v6sm3804703wrf.11.2018.08.28.11.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 11:56:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git directories
References: <20180827221257.149257-1-sbeller@google.com>
        <20180827221257.149257-2-sbeller@google.com>
Date:   Tue, 28 Aug 2018 11:56:14 -0700
In-Reply-To: <20180827221257.149257-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 27 Aug 2018 15:12:57 -0700")
Message-ID: <xmqqtvnefhgx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
> works with broken submodules, 2017-04-18), which tones down the case of
> "broken submodule" in case of a missing git directory of the submodule to
> be only a warning.

After seeing this warning, as we do not do any remedial action in
this codepath, the user with a repository in this state will keep
seeing the 'missing' message.  Wouldn't we want to give a hint in
addition (e.g. 'you can run "git submodule update $name" to
recover', or something like that)?

The MOVE_HEAD_FORCE codepath that follows this hunk is, eh, already
forcing to correct the situation, so there is no need to touch that,
which makes sense, if I understand correctly.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c                   | 16 ++++++++++++++++
>  t/t2013-checkout-submodule.sh |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13ed..689439a3d0c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1641,6 +1641,22 @@ int submodule_move_head(const char *path,
>  		} else {
>  			char *gitdir = xstrfmt("%s/modules/%s",
>  				    get_git_common_dir(), sub->name);
> +
> +			if (!is_git_directory(gitdir)) {
> +				/*
> +				 * It is safe to assume we could just clone
> +				 * the submodule here, as we passed the
> +				 * is_submodule_active test above (i.e. the
> +				 * user is interested in this submodule.
> +				 *
> +				 * However as this code path is exercised
> +				 * for operations that typically do not involve
> +				 * network operations, let's not do that for now.
> +				 */
> +				warning(_("Submodule '%s' missing"), path);
> +				free(gitdir);
> +				return 0;
> +			}
>  			connect_work_tree_and_git_dir(path, gitdir, 0);
>  			free(gitdir);
>  
> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index c69640fc341..82ef4576b91 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -81,7 +81,7 @@ test_expect_success 'setup superproject with historic submodule' '
>  	test_must_be_empty super1/.gitmodules
>  '
>  
> -test_expect_failure 'checkout old state with deleted submodule' '
> +test_expect_success 'checkout old state with deleted submodule' '
>  	test_when_finished "rm -rf super1 sub1 super1_clone" &&
>  	git clone --recurse-submodules super1 super1_clone &&
>  	git -C super1_clone checkout --recurse-submodules historic_state
