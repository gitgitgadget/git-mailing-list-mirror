Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B9C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0E20774
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uPSiI6hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKSdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSdC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:33:02 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C424C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:33:02 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so6445540qvt.10
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZsIuhoNkDIpi1iRyIETwbtRlSpO/DDEcceI8ySDan0=;
        b=uPSiI6hQL2WyMbzkIi341++FdnjQU7Xqs2+Z65C4FzMNlSnFLIiWxgBGoqSY/MDzMH
         EBHPFSC4ZMkpuZ6Lzbbx4fJ4p5ttbEBN9NpAQmTy4i2Yt9rH0LQnVecI+3+0Ay5Odhpw
         KjLY9cgN4R3gqFa/zJOCduRkcTkBNsy8DbY4iYwtxKKqPr6/AoDFHc5qVJ1q0jRMrFHk
         k3vbt0xlQs+gBjXqax6GrHQalSfIom2YLzOrh6wt0zZ3/GMgy8RRqk9370ZqlucNO50o
         OVT+uR++pqepIXFwN5mMVhHssGRTFteSD7nGlIu7583up6JtTUA8DSiYHsztpF5MHjc4
         LCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZsIuhoNkDIpi1iRyIETwbtRlSpO/DDEcceI8ySDan0=;
        b=q1WsioDGh+AAWPUnJFZUMQJjN9ADe67sy5LFOV+/pczgIg+OWtdAE8AjJYA53SVday
         z16bBPa/lt0b04IAUFBjqZxMPfpinAyQfEhh9zwCY0bHiomJXiXF4oC7DlVw0aJfUB7E
         rU5cqN8Iwnsxh8MM7qgwQsSH5y0H8CXGA93NIppijtAoCim60WN6E4gYCpny9gqc2xs2
         Hkxe7kAzwQM+Fg6U9N4keUxPErB4a6LGy0tGPEiJqKBIZLAfSXw19TYvqcndQBhw8Z8K
         bdEJgczhmNYhVJEF/xTg2strijisxwNlbiVkgUJ3LY5SWAHK/t4phGZu9yfXFNotOf7K
         VZOg==
X-Gm-Message-State: AOAM533uQHcV8v0fn9hL6bdxKytywrHYzruo0wHopZrqMLRJwGrJS90t
        BultSSOMdgy5fglqFxfiavU/YiDA9CTRtmnq
X-Google-Smtp-Source: ABdhPJyWPis83VmQwr8zvlUW0OvXgPcMKIFZGui608sqQtdoLErpDRLBIYcD/ym2R6pX95pblD5Yig==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr2764428qve.158.1597170781033;
        Tue, 11 Aug 2020 11:33:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id x50sm14699459qtb.10.2020.08.11.11.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:33:00 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:32:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
Message-ID: <20200811183258.GB33865@syl.lan>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200809174209.15466-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:
> Under normal circumstances, if a test author misspells a filename passed
> to test_cmp(), the error is quickly discovered when the test fails
> unexpectedly due to test_cmp() being unable to find the file. However,
> if the test is expected to fail, as with test_expect_failure(), a
> misspelled filename as argument to test_cmp() will go unnoticed since
> the test will indeed fail, but for the wrong reason. Make it easier for
> test authors to discover such problems early by sanity-checking the
> arguments to test_cmp(). To avoid penalizing all clients of test_cmp()
> in the general case, only check for missing files if the comparison
> fails.
>
> While at it, make test_cmp_bin() sanity-check its arguments, as well.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Notes:
>     This is a re-roll of [1] which was motivated by seeing Elijah fix[2]
>     several cases of bogus test_cmp() calls which perhaps could have
>     been detected earlier.
>
>     Changes since v1:
>
>     * take into account that some callers pass "-" (meaning standard
>       input) as an argument to test_cmp() (pointed out privately by
>       Junio)
>
>     * show the name of the missing file rather than a placeholder
>       (Shourya[3])
>
>     [1]: https://lore.kernel.org/git/20200809060810.31370-1-sunshine@sunshineco.com/
>     [2]: https://lore.kernel.org/git/7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com/
>     [3]: https://lore.kernel.org/git/20200809083227.GA11219@konoha/
>
> Interdiff against v1:
>   diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>   index 8d77deebd2..a12d6a3fc9 100644
>   --- a/t/test-lib-functions.sh
>   +++ b/t/test-lib-functions.sh
>   @@ -955,8 +955,8 @@ test_cmp() {
>    	test $# -eq 2 || BUG "test_cmp requires two arguments"
>    	if ! eval "$GIT_TEST_CMP" '"$@"'
>    	then
>   -		test -e "$1" || BUG "test_cmp 'expect' file missing"
>   -		test -e "$2" || BUG "test_cmp 'actual' file missing"
>   +		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
>   +		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
>    		return 1
>    	fi
>    }
>   @@ -990,8 +990,8 @@ test_cmp_bin() {
>    	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
>    	if ! cmp "$@"
>    	then
>   -		test -e "$1" || BUG "test_cmp_bin 'expect' file missing"
>   -		test -e "$2" || BUG "test_cmp_bin 'actual' file missing"
>   +		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
>   +		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
>    		return 1
>    	fi
>    }
>
>  t/test-lib-functions.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b791933ffd..a12d6a3fc9 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -952,7 +952,13 @@ test_expect_code () {
>  # - not all diff versions understand "-u"
>
>  test_cmp() {
> -	eval "$GIT_TEST_CMP" '"$@"'
> +	test $# -eq 2 || BUG "test_cmp requires two arguments"
> +	if ! eval "$GIT_TEST_CMP" '"$@"'
> +	then
> +		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
> +		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"

Not related to your patch, but I've seen this style of "x$1" in a few
places in test-lib-functions.sh. Why can't this be written as 'test "$1"
= -'?

> +		return 1
> +	fi
>  }
>
>  # Check that the given config key has the expected value.
> @@ -981,7 +987,13 @@ test_cmp_config() {
>  # test_cmp_bin - helper to compare binary files
>
>  test_cmp_bin() {
> -	cmp "$@"
> +	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
> +	if ! cmp "$@"
> +	then
> +		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
> +		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
> +		return 1
> +	fi
>  }
>
>  # Use this instead of test_cmp to compare files that contain expected and
> --
> 2.28.0.220.ged08abb693
>
Thanks,
Taylor
