Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B02E736A
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254265; cv=none; b=UM34sqdv3RzCJWkA7nqKzlZ+DVOYwK6yQHNlE2UfM9Qd22QA8NQh/VNS4ZyvdyjjEedNYrKQsAL2OThOdYF1+5/oeC1kuokzQgDitwzrSYn8LnqpXXT/J3RjczvEQd/PsaEgjSjINfbNW9FQTONd9xVs033bGPUXHq5OZx8JUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254265; c=relaxed/simple;
	bh=R2eMk8Ny0o2Wk9/HdNA+MjTX98Bnr7c0e08Bmn118PU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=noWT1pnb1ncdvtSZR5JRtAmm/AfbccvHoaqgVJByQ4ZVtNss0OQ80It/XaCgDUx/wm8G7gwdKYNPTPI9MhIiAyMGG5Y6sezEFhkbPfFvqptnWbW/E1OkijfASsDtnYIqwqLykkHTeCr4PC3vZqLuiVZKs8Qcr0/7gb8D7XUe8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mp89eoVc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmCyw2T5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mp89eoVc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmCyw2T5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41AB214000D0;
	Tue, 28 Jul 2026 11:57:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 11:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785254262; x=1785340662; bh=Cb+gK5PpYP
	vz6RvPKzcdFT5FzBhPyooX96HTJ/hqxwA=; b=mp89eoVc1yNhco+AL3Q17McRP+
	7r168EJ4GbAn/OtDPpmgJVEhFplq5bfqQSYg13Uhhw5JWuAjYxtakCSeCJsm3FMj
	ln7j4RY3rRHxZY1PB2/2AzcpYKMhrkyVWQvxK5YhTlc3QjfmyFbKqrEak5L95jaE
	krgYsmTK6Ww+5BT0v/y/w8S87Gd5fKohzr+oieoNDFsKhmq5BDhyUFgAMT97xLqF
	4cdygjbx8jJ7uVLHIFh5dJkrv4/YlLBWgIcrEHJ7H/1BNaSClSY/I7qg1nQ9jcfh
	C2VyS4c/e80Rq1lk7yRKYU+/t5Om1nTSoJ7ikQgNG7kKq1MJLENcXU6XlKlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785254262; x=1785340662; bh=Cb+gK5PpYPvz6RvPKzcdFT5FzBhPyooX96H
	TJ/hqxwA=; b=bmCyw2T57TdMipAE11S7jIaUH9bn6bEsiwtCh4yOQhJlkSSWiNW
	oxHm900bPYCw7JnV8MIjZfv2sux+h6iukSgAdox7mcY6P+pH/c3vSMIjDjZKeJnV
	8eu/CnK4K3SxuzIkPaTsnPM8yxeO/9iLsVm3HKds0WtjCO+MI9ORIcF8FJfMFQux
	XSKvzUo8rQe/p6NSxHWGVCBLGYVxvuOwIN/wk29ugCIzHD28Q76OAv2nGNQiX0C9
	skJRqTPNsy1wZXljH1izAvBWtCsRZSBJe/moLypH52EuTLpBF0I9io9Q+CAv4Zl9
	+OnOBdfvM6Co6DrjaI85Vhmw/MYgn+PVAtg==
X-ME-Sender: <xms:ddFoapumPVIJEe95Wa4zQ3_2hoqH_YdQ9C6e7PfEg_Br5NKRMdbFTA>
    <xme:ddFoaj9cdO4fRXODAr1DOpA7r5c-MF35m0JyPtITO5lzwe30mO8D0KjioVHakyrLd
    r_qrFUV6VJaS4sVKtwiHo6F4zhVhL2G4E_QP5mhjSCBW2CS8PoC>
X-ME-Received: <xmr:ddFoas2dlfMpQCc9SrRrGx9hZ4yaLs8zEd89Kj372L83DfRwY3fJ0d9gEmP1XWvAm_Zojs774RT7DxGFjYzF1sXPAXhAUf0pTg>
X-ME-Proxy-Cause: dmFkZTE3vL/M80ZT9aUpejZorsFLsnWIIgyVikTWPiBZ+8S0zlFRiihjGI8z85FPbb0vDZ
    Hjwq0A90N0O7pkcuxiFgVgnUeqonPSyUvSCI3NUtGoP6jx6cbZYEFS6dvqR3YuWgngYgJm
    AVRs3sLgHm1OINHuyVP3xVFcvjeviEHtNACZ+x/ZU/sK4nD3GzxoqohUS0yQDmUgJkVsJW
    j70nVpqtU/MZOeT6Ddz59w7AuOENSuqXA+FOlN3sNp8hSmen3yEUSMtAYv+JsUTaV7IoJW
    QaQvPuD2r7zP9XnGFSZXKDKZ7Gg1+b22d5OHFZZs0N1Ui4Xk7UyO36s+DRVOAwmk7TmSSy
    SHXGbd38/BwLvTn7JVowjzvYscf68G6MrM7RLiAJ6s2kEg3XTh6IaVxpv69GXGBHCTSPI6
    lG5RQq8fOIG8QQJG1Pia4SM4Uvckv5tEIp6le18EiELDQrcYqxY1VfrEWJ3FpqwmzdXS28
    bbizHPPnqLMLHsc/8TXsYJeW+rFV+1EEcdeSZc6Xrx26xJsmBim5HUu7n31htLzO0wYdcA
    TTyiSEfusGq6KMTy9BXTN+fM7CRtc46t/h1TCs7eIJF1K/ykH3WT39KO7gBEnRt5V3zkNQ
    ntx/er8iIEGDdsGLVjrdsoodCOtOysVZhikSIVPXIL9tevDnZnz4oEZPD5xg
X-ME-Proxy: <xmx:ddFoagC4cmXbER-52veWU8z57Vupf8lutobJzie-TTJNTtx97XFZ9Q>
    <xmx:ddFoagegYTlBwXWjBelAIrkgkhRxW_aXrch1-ZMnqPA_r1Cf8Wt26w>
    <xmx:ddFoal6uPLQ-8grzk3ZZDzkFLHNtoqISpXshcUSDfMU-dgZs81y00g>
    <xmx:ddFoarUM6s38nTsYFEOLdSgF9Ncuh3Xw-Dp5kByvq25OZsQxUMU67g>
    <xmx:dtFoarAT_SxceqYWupdLZ1qGGRgJobgYT2otYqkSGVI8P2hfRByIK3WO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 11:57:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t0014: factor out choice of deprecated commands
In-Reply-To: <20260728143726.GA41686@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jul 2026 10:37:26 -0400")
References: <20260728143653.GB11894@coredump.intra.peff.net>
	<20260728143726.GA41686@coredump.intra.peff.net>
Date: Tue, 28 Jul 2026 08:57:39 -0700
Message-ID: <xmqqwlufds3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We have a few tests related to aliasing deprecated commands which use
> "whatchanged" and "pack-redundant", as these are the only two deprecated
> commands we have. Let's pull those names into variables so that we can
> refactor the tests without relying on the specific names.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I pulled this into its own patch because it's so noisy, but it could be
> squashed with the subsequent one.

The knee-jerk reaction I got after reading the above explanation
before the morning caffeine fully taking effect and without looking
at [2/2] is "we may have parameterized the exact command names, but
I cannot tell what value this change has, as the fact that we have
exactly two deprecated commands is still hardcoded in the test".

If the point of this change is that even if we ever deprecated a
third command, this test does not need to care about it, then I can
understand it is perfectly fine to have the hardcoded "this test
uses two deprecated commands" while parameterizing which two
commands are used.  But then the log message may be a bit
misleading.  I dunno.

I am very sure that I will be enlightened when I read [2/2], though
;-)

>  t/t0014-alias.sh | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 5144b0effd..9d7c737355 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -27,17 +27,20 @@ test_expect_success 'looping aliases - internal execution' '
>  	test_grep "^fatal: alias loop detected: expansion of" output
>  '
>  
> +deprecated1=whatchanged
> +deprecated2=pack-redundant
> +
>  test_expect_success 'looping aliases - deprecated builtins' '
> -	test_config alias.whatchanged pack-redundant &&
> -	test_config alias.pack-redundant whatchanged &&
> +	test_config alias.$deprecated1 $deprecated2 &&
> +	test_config alias.$deprecated2 $deprecated1 &&
>  	cat >expect <<-EOF &&
> -	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
> -	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
> -	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
> -	  whatchanged <==
> -	  pack-redundant ==>
> +	${SQ}$deprecated1${SQ} is aliased to ${SQ}$deprecated2${SQ}
> +	${SQ}$deprecated2${SQ} is aliased to ${SQ}$deprecated1${SQ}
> +	fatal: alias loop detected: expansion of ${SQ}$deprecated1${SQ} does not terminate:
> +	  $deprecated1 <==
> +	  $deprecated2 ==>
>  	EOF
> -	test_must_fail git whatchanged -h 2>actual &&
> +	test_must_fail git $deprecated1 -h 2>actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -90,8 +93,8 @@ test_expect_success 'can alias-shadow via two deprecated builtins' '
>  	# some git(1) commands will fail... (see above)
>  	test_might_fail git status -h >expect &&
>  	test_file_not_empty expect &&
> -	test_might_fail git -c alias.whatchanged=pack-redundant \
> -		-c alias.pack-redundant=status whatchanged -h >actual &&
> +	test_might_fail git -c alias.$deprecated1=$deprecated2 \
> +		-c alias.$deprecated2=status $deprecated1 -h >actual &&
>  	test_cmp expect actual
>  '
