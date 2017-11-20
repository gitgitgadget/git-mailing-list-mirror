Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE0220A40
	for <e@80x24.org>; Mon, 20 Nov 2017 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdKTVr0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:47:26 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:46775 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdKTVrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:47:24 -0500
Received: by mail-io0-f196.google.com with SMTP id q64so4426820iof.13
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ntVapyjZBzpBj67i0yKDt5tI8IM9A50TvpGlMfBnvxk=;
        b=oyXgYLHJB9kM1owbC8wk5W3/4VCfw+BK7YDjas3uueW/t7xKTlTgsr0iVKK/XGRrhX
         IoshqEaPQL2EgCA3xiMO60LrV9u9/gBXB97TQv/MwiqgKQW68xyjT7DP4OWkP+nOxVKY
         LnFmJIAu9MMV9oBdWhxR9Sn38DsaH4pCoTnGy7U9C+EBszqdmX5Ge8KfaqqG2kp8DWKX
         /4Rtu8fvnXbrUt6o5s6NLyORqS5N7ixbF2eIFJairVZJ5MLZYxuSIbM+++sd/FzsW0fE
         nrCUwoNr2dbyw7T3OAxpkwm9ehLcyqH/kYTfGsDD97uQNgxwB0T7evpSPUEvKbdCEgjp
         o31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ntVapyjZBzpBj67i0yKDt5tI8IM9A50TvpGlMfBnvxk=;
        b=EF2gynwz32nMyvHendQNTuRzw87Mcft6iCuIl12CFk4xIG6oSu4hFZUY9I/eTgTwED
         aaDAW2qB6AWMZ+mDYQhw+LQWWo9Ocu8XhVVkt87JlctqPrJxefwUqYRR3ty+l+1qKoPT
         jhTkLLlitN8s2rf42PFh2FYvisWa3xxoimqCJsxKVfrckBIofhR1V7BH6dnzbsbj4BF5
         TSQsTHrrEHJHjVRmTfWPlpf2iRzXk1XPXOOsFP2POVwKfUKIF5PRIDDn3VLl4qDthjb+
         jQmXMTYhe3PnWFDCVg+aZvdlRJoPx4zGbmduGKbRKNm0+skfgnqSbhlnreZR8vPE9qEZ
         gUgA==
X-Gm-Message-State: AJaThX6U9MpIEEuzFlkWan1AjlzZzXnwUzhORLLCShQ2YPZq4VrdXssJ
        O4r+BBaW0mdh7XCWmsKJXhTyig==
X-Google-Smtp-Source: AGs4zMZVSVkm0HSWr/aDjyebZH5pdmXxLKxNNyuS31WM0ls16iuP0EcxW6TkRIy4PHOwnJXG48DATg==
X-Received: by 10.107.190.198 with SMTP id o189mr15734972iof.18.1511214443236;
        Mon, 20 Nov 2017 13:47:23 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id 16sm5571876itw.38.2017.11.20.13.47.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 13:47:22 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:47:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/8] ssh test: make copy_ssh_wrapper_as clean up after
 itself
Message-ID: <20171120214720.GA92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> Simplify by not allowing the copied ssh wrapper to persist between
> tests.  This way, tests can be safely reordered, added, and removed
> with less fear of hidden side effects.
> 
> This also avoids having to call setup_ssh_wrapper to restore the value
> of GIT_SSH after this battery of tests, since it means each test will
> restore it individually.
> 
> Noticed because on Windows, if `uplink.exe` exists, the MSYS2 Bash
> will overwrite that when redirecting via `>uplink`.  A proposed test
> wrote a script to 'uplink' after a previous test created uplink.exe
> using copy_ssh_wrapper_as, so the script written with '>uplink' had
> the wrong filename and failed.
> 
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thanks to Dscho for tracking this subtle issue down.
> 
>  t/t5601-clone.sh | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 86811a0c35..9d007c0f8d 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -306,21 +306,20 @@ test_expect_success 'clone checking out a tag' '
>  	test_cmp fetch.expected fetch.actual
>  '
>  
> -setup_ssh_wrapper () {
> -	test_expect_success 'setup ssh wrapper' '
> -		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
> -			"$TRASH_DIRECTORY/ssh$X" &&
> -		GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
> -		export GIT_SSH &&
> -		export TRASH_DIRECTORY &&
> -		>"$TRASH_DIRECTORY"/ssh-output
> -	'
> -}
> +test_expect_success 'set up ssh wrapper' '
> +	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
> +		"$TRASH_DIRECTORY/ssh$X" &&
> +	GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
> +	export GIT_SSH &&
> +	export TRASH_DIRECTORY &&
> +	>"$TRASH_DIRECTORY"/ssh-output
> +'
>  
>  copy_ssh_wrapper_as () {
>  	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
> +	test_when_finished "rm -f ${1%$X}$X" &&
>  	GIT_SSH="${1%$X}$X" &&
> -	export GIT_SSH
> +	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\""

All the escaping!

Patch looks good.

>  }
>  
>  expect_ssh () {
> @@ -344,8 +343,6 @@ expect_ssh () {
>  	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
>  }
>  
> -setup_ssh_wrapper
> -
>  test_expect_success 'clone myhost:src uses ssh' '
>  	git clone myhost:src ssh-clone &&
>  	expect_ssh myhost src
> @@ -432,12 +429,14 @@ test_expect_success 'ssh.variant overrides plink detection' '
>  '
>  
>  test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	GIT_SSH_VARIANT=plink \
>  	git clone "[myhost:123]:src" ssh-bracket-clone-variant-3 &&
>  	expect_ssh "-P 123" myhost src
>  '
>  
>  test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	GIT_SSH_VARIANT=tortoiseplink \
>  	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
>  	expect_ssh "-batch -P 123" myhost src
> @@ -449,9 +448,6 @@ test_expect_success 'clean failure on broken quoting' '
>  		git clone "[myhost:123]:src" sq-failure
>  '
>  
> -# Reset the GIT_SSH environment variable for clone tests.
> -setup_ssh_wrapper
> -
>  counter=0
>  # $1 url
>  # $2 none|host
> -- 
> 2.15.0.448.gf294e3d99a
> 

-- 
Brandon Williams
