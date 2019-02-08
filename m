Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEB21F453
	for <e@80x24.org>; Fri,  8 Feb 2019 00:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBHARP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 19:17:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34955 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBHARO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 19:17:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id z18so1810018wrh.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJKSYTBkZkjklyQc1JF5YAFxfbQS6A1qW/MloQw6Bvc=;
        b=VLYdhFdVDBFeG5dl24Vjzm2Cm1d03+T+ZnEtFCRiLixfIGzT3eeTxDlDg24ktKvMqy
         kHsWr98WYAwHlIrBO9tKyr7Pge7Rxyijnjehnz4TOJ5wdagn4PMbutNWugtaHcGf++dz
         8XU0aVBrMb1LlZnHFM6P+c3L1mD9B0W4vci3bF1DKWrfXcBdF7N3zz7qNZxhk9EI14It
         X+kyWaz3h5e6DZ+vk9uiKLL/xdnknVtvygvcDGTDbyQiYGs9LRay47HuiTjoor9Ptta+
         z6ew9uHMFAQn7x/10qK5Hwc/e1Rg4yfB7P2hVTquTo4O+4Ovnz/IHeM+Csr/D8LcaJ/c
         JV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJKSYTBkZkjklyQc1JF5YAFxfbQS6A1qW/MloQw6Bvc=;
        b=ZvRnynm5Els+7qhCGdMNszYX+iBVZKXpuI20eE1QPBv4JVsgdvhUDg5GkcLE/Y9esO
         Gd8GE8k5crSdOt0BQNFeJ6OZY3D9Pza5gd9SVmO5Mq1TsMilnAaO+1537kecBzaOy36B
         rpNdnSdQc0mrC9+J+FX7H/5Yco3Z+cB8NY1/izCVNZnH+D2N9BuI5hycUKOBmf4cIzNS
         JYFe66aKf/qWC5rBR7vFzy1JvJHlaaNwSf9Q0KVdd+CgTgQZdZbwYI9GLZVMWxat8oup
         YBE8VnBOQAgCHrHE0VGN1jSOJefSwhM3kqtBQs3/jNviIqEUT9AvV3Ev1SNSHM53+KLV
         hgxA==
X-Gm-Message-State: AHQUAuYGuipn8Ng1oJfAnrBXQO5PbvWdpGfY2XsJifT91rvhmsbYHrf8
        DUeX0cNC9+D3QjdgZuPciy8=
X-Google-Smtp-Source: AHgI3Ia9oeMAKK7tUtxiNf72Fgv6m5bwPnbqeNDgdj26z7M5spIq48mQM5267kVacuQSt7F4UHdk3g==
X-Received: by 2002:adf:c70f:: with SMTP id k15mr14044928wrg.155.1549585033082;
        Thu, 07 Feb 2019 16:17:13 -0800 (PST)
Received: from szeder.dev (x4db57a12.dyn.telefonica.de. [77.181.122.18])
        by smtp.gmail.com with ESMTPSA id r12sm990530wrt.76.2019.02.07.16.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 16:17:12 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:17:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] ci: clear and mark MAKEFLAGS exported just once
Message-ID: <20190208001710.GS10587@szeder.dev>
References: <20190207183736.9299-1-szeder.dev@gmail.com>
 <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
 <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
 <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
 <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
 <xmqqd0o3mac5.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0o3mac5.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 03:45:46PM -0800, Junio C Hamano wrote:
> Clearing it once upfront, and turning all the assignment into
> appending, would future-proof the code even more, to prevent
> mistakes the previous one fixed from happening again.
> 
> Also, mark the variable exported just once at the beginning.  There
> is no point in marking it exported repeatedly.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     >> So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where you `export
>     >> MAKEFLAGS`, I'd simply append a `=`).
> 
>     This time in proper patch form.

Makes sense, and the patch looks good to me.

>  ci/lib.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index cee51a4cc4..288a5b3884 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -74,6 +74,9 @@ check_unignored_build_artifacts ()
>  	}
>  }
>  
> +# Clear MAKEFLAGS that may come from the outside world.
> +export MAKEFLAGS=
> +
>  # Set 'exit on error' for all CI scripts to let the caller know that
>  # something went wrong.
>  # Set tracing executed commands, primarily setting environment variables
> @@ -101,7 +104,7 @@ then
>  	BREW_INSTALL_PACKAGES="git-lfs gettext"
>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> -	export MAKEFLAGS="--jobs=2"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=2"
>  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
>  then
>  	CI_TYPE=azure-pipelines
> @@ -126,7 +129,7 @@ then
>  	BREW_INSTALL_PACKAGES=gcc@8
>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> -	export MAKEFLAGS="--jobs=10"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>  	test windows_nt != "$CI_OS_NAME" ||
>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
>  else
> @@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
>  	;;
>  esac
>  
> -export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> +MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> -- 
> 2.21.0-rc0
> 
