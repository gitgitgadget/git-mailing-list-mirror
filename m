Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D1372ED5
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974108; cv=none; b=FILzM4WGWHUEE4oWP64m4ekIHWnF3zFFhyYY4GpQHTmvS2AdhCtI681XcleJmcdOwU5+W0aVp39QaLx6SclUdLQr9v9Dxz8CBDkge7p2KQ1hMcnMm2V69r9YuSrrw7e9lncq51/ktxbPaT6LVUWCHZ3ajUDM1eqn8hQNnph3md4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974108; c=relaxed/simple;
	bh=iTylPdsXvoVArrUuhHhK5F/zcRzLINal+fwwy0iX3cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfo455Yz8qrDOarFGHKRUkCm+/fBejDcsT3+noYwm4Jx0XP7NmC5dqtK0NdFeOGxL7y5OudJ5z+3mN/91KmsxLQFeMsLTPlspT85jjXMIz7TjAzFEFPNqpdUkAOdHgLMy6D0bzzFlu8RTe67wj8YTpJpGN0zrRuKTo6LUOjJQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Olx3bU2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yc820uN1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Olx3bU2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yc820uN1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AEB2EC0320
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:35:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 06:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791974106; x=1792060506; bh=9Itf5zPj1R
	Svlszqo74Q2NUOMjzsnNzs0vhia7jeSF0=; b=Olx3bU2YZcJgT2cBOh+4RvHW8Z
	SvdA5PhFKwCgACTQKVk7zp9tNOAXXBMf9DEqu5/7S3NCHB+hPz2D3F6UiDlmI0fW
	Bn+rffZQOdRqf6Rjw/VcjnfoEQn7DEV8L4nWSbVQtdlJh8lRpYukMhuLxpS48Dz8
	k5FQxJ8Islp8pVknxAPWIHYfP6iMAmdtsR5aafxjmYBMoDXmB2gT0VKakt20tkSN
	/2zqGoosoLLPaKlSM+tjnCMt2m9lDALPh9DoLQThnAyTb85WFKP8tjg8WSqizHPN
	IfEkan5X59LVxSW6btrdp8SrnsBkVKH3+51s1Yw98Ii5whctLvTw72INoixw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791974106; x=1792060506; bh=9Itf5zPj1RSvlszqo74Q2NUOMjzsnNzs0vh
	ia7jeSF0=; b=Yc820uN1HFkvMV0S+rns8pARq8sAKHV0DMofT/M59jV/moA7avJ
	FBVbN644KUvM2bv/Of8Zf6lqB6hVha7yu8D9+Cp37JihImtD1di/RAHT3uom5U1O
	gKExav6QaUCMYgyqXzjJiQER3Gznpf3KRQ5u8x0U/3GyDv0ybM0tPdGr/5WKZC3b
	B71IH6L88zIxypyzuLUAYElM7YMkzkVYecgzQX4lm9zRPn1bgyXWfPkG8d8z3SdV
	XAHo3b5CEogE69o5rVPah4dcpCnFODl0i4xP7cmt+pIbqIDUVCpzCZLPvW0SP5N9
	hErj9COUL7QOyI+FR8/xpeaO2ExXjrZJdXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791974106; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XDuZCEjtyqUCu8g1eCX8Rv8k1qA8yEyyguRG9cZhp5klncY
	aVWwAIKEwowTRhPmhuyqPcf5L+NSudvlzBZdz1qGteytpEFG3WrqI5G0fPhnLrv7
	BT82GxbtgPefGoQ41/nm18JIGxmkV526hzHfQgvtxic8pO17BLzNeOyCqLHIeuk4
	M3KPbzm4y1qu2AFfrka2s0oFR40HqnzhtGW07wjk0WECkF1GGgE/IBleYxGSEJZO
	u9HCU2kv2H+T2r4xu+O+HTmnI2B9jaYymeR44GzjdYnC/q7OyBWsV9yegviuWsVW
	b6zbwwz0tvoo5r+iGb4OxaGy4uXcb/KH2xDyFQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XaWdBDxPLFvHLIFhUpI7+NF6bqf3mKhtWUrMBkmwVek=:iTylPdsXvoVArrUuhHhK5F/zcRzLINal+fwwy0iX3cE=;
X-ME-Sender: <xms:2VrPah0xFGGX_0UsLOon_5tC44IyZiXZipnOQh08wTC3K3NAif30BQ>
    <xme:2VrPau_doQEzE-znXMCykxbm6DJ_xTjGZRXxb98n7aTCYzQjI_sWOS947JmmcDo0x
    amtRMBqqa8DJvBL5l9MtHiP0tCox9dnroR-Sr6ihUrDVx3qgZh4pQ>
X-ME-Received: <xmr:2VrPaqPLtpw9qJFZGNICay4eiUhcPEUNrI8Ga4XNc96PBQnt4kHZ0Q>
X-ME-Proxy-Cause: dmFkZTEQICkGBp5gbC6i7vO6Wcsi7XbaNtnX/kdZUiyMa38uNKlNkUGAS+qrDS1NgXI5BW
    IDQdhjmOtSzlniXdWrigfGUoesskkjR/ONEqnHzqvKUf3/dbtQGZ+RvMmphPAC5HB4qfaI
    NT+fnOwKwdDNfTq6yM8+vjHm8HQS11nuddiMzT1Pn310iAYbawgmZ7SX/53J+n2r7EJ9xm
    3KDco+P0jObTUQJiGW5Je1O9ojMb1Hl3+LvlgsqVw071Lm+g6UvH4bi16/UY8FxU+GnWv7
    Wcj/CR+DQZxz0b62swbmKGZIxjW5TOBUwrtmvbbKUP0sTpfPw8VW3kwMQToUNzMqYrNtc3
    uHZ/rpJ+I3nBKobc6yWFFUXgogTfSuUPrL/LNFxlV9pg9g04j9DYp4ZDjoHwlENVlf3bMF
    vpvDsGQ0IsyqCO/2RjXFoCUFLQPzHMUF9FwuuvZKTt4OvBbuLVueMkhhPGUTdDYxU9yOA6
    NSfY+tOjhEQ1tVB5l7PCCk18Yu2jnCyZgSALIADSTBnFInREwzJULUlG0+wZ+mXwLU82qy
    0M/NhZZLcdapRBeW0WenC8aFcmtSHMkJBydx34rMoXMGpS00TB/Y50/3HxeiFGDRKKY1Mv
    8pQshhp+hjt4tCOgWzpzQFYUzae6zXyl9j1B42xVfRJFQ9bH5jAWZClZrNjA
X-ME-Proxy: <xmx:2VrPaqdQro6xkQRWwO5kjUlvHl5lwWY4-mzizuDjoR_jC4pK4q4ozw>
    <xmx:2lrPahUeuL1EpAWGqyXSALmAEGBL-P0co_rrCl1mvoxcQp4fTqvBhw>
    <xmx:2lrPaqgGxCf_TosJSLoNyydRvHjsst6PTNANVu4qGw1kYQHJOkE5ZQ>
    <xmx:2lrPao8NizXVor2BIx6HDV18ARDtgixwe5DzFMJtSf1Chc2Xum7EkA>
    <xmx:2lrPak8nuTmYaah6iB0r2KgSP9kn1IJOOlX4I1_nXkKwJ1OP8WEwnTnS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 06:35:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0345857a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 10:35:02 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:34:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Message-ID: <as9a0znMFrbOm5s1@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>
 <20261014090746.GA1341124@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014090746.GA1341124@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 05:07:46AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 10:30:27AM +0200, Patrick Steinhardt wrote:
> 
> > We're about to fix that typo in the next commit, but this will also
> > uncover that the above test case is broken when running in SHA-256
> > repositories. The extracted objects are SHA-1 objects, so extracting
> > them into a SHA-256 repository is not going to yield anything good. So
> > once we fix the Fedora-based job to enable breaking changes, which will
> > make tests use SHA-256 by default, the test will break.
> > 
> > Fix this issue by adding the SHA1 prerequisite.
> 
> Does that mean we'll basically never run the test once Git 3.0 shifts to
> sha256 by default? I guess we'll have a sha1 ci job (like we have sha256
> today), but would that job actually hit all the other prereqs?
> 
> If we instead teach it to use its own repo, independent of the defaults,
> then we could run it everywhere (that allows all of the other prereqs).
> 
> Something like:
> 
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 768b0ff85d..3a5c01c475 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -187,6 +187,9 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
>  
>  test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
>  	'zip archive with files bigger than 4GB' '
> +	git init --object-format=sha1 big-file &&
> +	(
> +	cd big-file &&
>  	# Pack created with:
>  	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
>  	mkdir -p .git/objects/pack &&
> @@ -206,6 +209,7 @@ test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
>  	"$GIT_UNZIP" -t big.zip &&
>  	"$ZIPINFO" big.zip >big.lst &&
>  	test_grep $size big.lst
> +	)
>  '
>  
>  build_tree() {
> 
> 
> A real patch obviously would also indent the test body one level; I
> skipped that here to keep the diff readable.

Hmm. Yeah, I guess that wouldn't hurt.

Patrick
