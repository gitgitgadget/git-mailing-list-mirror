Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729983F9D4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882142; cv=none; b=geMi5jUxVJypHs6YolcwswJtPhdI5I9+vyUsIcal1d7pO5F8UTJznGuCps03Qwa0lK0t/ydbhy5Dx84h1bcZrnfgnhhdtuVeecUOJa08RlOi3GUAdUHzhRMhk9iF3WdUi7pHanAHOf33Hhsi5L+gLgexa85oyuHb/xD+bCG4Bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882142; c=relaxed/simple;
	bh=a/cEGZ4Ov4MQhT+UHJ0kfoegnhYQHS9ZQ32oyLE3diA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLoe4sbEFXH659JruolFXd+buiCD6GQZyj0rSqUxTE/cFhtCwsEL256GVOZnSUTDMfaj3X5kTRCBLfADdOILPCoTl/NypiJ6qjzjrU1xRt0qQ5AUt0rcrAGoDaUinaLWnAVKiCCb+CZQbSiMgx2z+vDagu/LWvDzqF8xlEVi7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNxyzCtd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNxyzCtd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A58561A29B;
	Tue, 19 Mar 2024 17:02:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a/cEGZ4Ov4MQhT+UHJ0kfoegnhYQHS9ZQ32oyL
	E3diA=; b=WNxyzCtdsBerA/MOTy02oMKQ66uixP/vitCN5gIly0ofcd+cag/Yzm
	AjWDy8D5yK3bpTT6bCw36PZDpLwvZbMUPjMaL86VNIj/SqEws4W0f/7P8ZhecqOX
	E66uKVi9cD2WcpdzK5qSr2uRPixR0LJXGKTQj+ycJSW184g1hZ0MU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DF301A29A;
	Tue, 19 Mar 2024 17:02:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2525D1A298;
	Tue, 19 Mar 2024 17:02:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  pk@pks.im
Subject: Re: [GSOC][PATCH v2]userdiff: improve code quality and add
 JavaScript language driver.
In-Reply-To: <20240319101000.76767-1-sergiusnyah@gmail.com> (Sergius Nyah's
	message of "Tue, 19 Mar 2024 11:10:00 +0100")
References: <ZeWOhxBDvyjH8gW7@tanuki>
	<20240319101000.76767-1-sergiusnyah@gmail.com>
Date: Tue, 19 Mar 2024 14:02:10 -0700
Message-ID: <xmqqh6h2lyul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4E8AE32-E633-11EE-BABB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sergius Nyah <sergiusnyah@gmail.com> writes:

> This commit introduces several improvements to the codebase:
>
> - replace the use of `test_i18ngrep` with `test_grep` in
> `t/t4018-diff-funcname.sh` for better pattern matching and improved
> performance.
> - add a JavaScript language driver to enhance the functionality of the
> application.
> - clean up the code by removing trailing whitespaces and fix multiline
> comments in `t/t4034-diff-words.sh` and `userdiff.c`.

Doing too many unrelated things that may appear semi-related only
because they are about the same files?  Don't.

>
> Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
> ---
>  t/t4018-diff-funcname.sh | 14 +++++++-------
>  t/t4034-diff-words.sh    |  1 +
>  userdiff.c               | 23 ++++++++++++-----------
>  3 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index d35cce18a0..e6d2f1c215 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -119,8 +119,6 @@ do
>  	"
>  done
>
> -test_done
> -
>  test_expect_success 'identify builtin patterns in JavaScript' '
>  	# setup
>  	echo "function myFunction() { return true; }" > test.js &&
> @@ -136,9 +134,11 @@ test_expect_success 'identify builtin patterns in JavaScript' '
>  	git diff >output &&
>
>  	# check results
> -	test_i18ngrep "function myFunction() { return true; }" output &&
> -	test_i18ngrep "function myFunction() { return false; }" output &&
> -	test_i18ngrep "var myVar = function() { return false; }" output &&
> -	test_i18ngrep "var myVar = function() { return true; }" output
> +	test_grep "function myFunction() { return true; }" output &&
> +	test_grep "function myFunction() { return false; }" output &&
> +	test_grep "var myVar = function() { return false; }" output &&
> +	test_grep "var myVar = function() { return true; }" output
>  '
> -test_done
> \ No newline at end of file
> +
> +test_done
> +

To which version of Git source code are the above hunks meant to
apply?  Hopefully we do not have a test that says "test_done"
followed by another "test_expect_success" in our tree.

> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 74586f3813..cf2374af2c 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -328,6 +328,7 @@ test_language_driver dts
>  test_language_driver fortran
>  test_language_driver html
>  test_language_driver java
> +test_language_driver javascript
>  test_language_driver kotlin
>  test_language_driver matlab
>  test_language_driver objc

It is unclear what "clean-up" was done to this file, as claimed in
the proposed log message.  Puzzled...

> diff --git a/userdiff.c b/userdiff.c
> index bbe2bcb9a3..15342c8662 100644
> --- a/userdiff.c
> +++ b/userdiff.c
>
>  PATTERNS("javascript",
> -      /* Looks for lines that start with optional whitespace, followed
> -      * by 'function'* and any characters (for function declarations),
> -      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
> -      * and any characters (for function expressions).
> -      * Also considers functions defined inside blocks with '{...}'.
> -      */
> -      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
> -      /* This pattern matches JavaScript identifiers */
> -      "[a-zA-Z_$][0-9a-zA-Z_$]*"
> -      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
> -      "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),
> +	/*
> +	 * Look for lines that start with optional whitespace, followed
> +	 * by 'function' and any characters (for function declarations),
> +	 * or valid JavaScript identifiers, equals sign '=', 'function' keyword
> +	 * and any characters (for function expressions).
> +	 * Also consider functions defined inside blocks with '{...}'.
> +	 */
> +	 "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
> +	 /* Match JavaScript identifiers with this pattern */
> +	 "[a-zA-Z_$][0-9a-zA-Z_$]*"
> +	 "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
> +	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),

I do not see trailing whitespaces getting fixed, as claimed in the
proposed log message.  Puzzled, again...


