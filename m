Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC83D0BEC
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603698; cv=none; b=r5EYY/+J5WJPWDYLWgqYOe7wqwEcuwWKiR6Mza7oz8F9PH4sqwCMSAvTUhZy1PSAVfETuRKtyPwA5uGhpPTRJSW/maicKQeWrwv1diNE3etMrpSKSWnIQ7nS/peSn0xk5mgUZ1B2jy4NCkk0G0c7oDRXzvfdCigBTWU3KX3E4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603698; c=relaxed/simple;
	bh=igkw3bsIDT8XQPqfTwgB5iOjz+s6Yo8cAWizN3M78AI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EbdQzDHfi75rS21haeFe/brUcCUTLK40MZdIC4nHnPmYhP/46d5Anh50/MugGoRncvb6vBRIkDrGElDzLmEuO/JiHT1Wr3zXKjFc546QnsXyV1CPYDaG5mZtb37BbfsMEIIli/Rz1b+j32HO1mrLiX7kMVEwk2rgmYuRd074lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j3VOb3zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyCkRn+K; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j3VOb3zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyCkRn+K"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2FD81D0006C;
	Tue, 12 May 2026 12:34:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778603691; x=1778690091; bh=GnEl85eDQs
	Pi5hT7ksSu37WfiKhXtxSgzkME57fF46I=; b=j3VOb3zjFWcaE5KhLmxPmh1bDk
	h7dKRIb6n78wYl1yOvgDbkq8VFpmi8fGdvtLFlbdq5Ckh/ue4ibNIjZfWMEXbutb
	v0HE96KYa+T92ddgLP6BoV8oNEoO6G71Gtb4Z1zAN1CGayYASaI+4bpth4hNYqSG
	N75Rr8xUREi7JlJVwrTuQT0fG3I4qHefNkK7SqvTdudqw3XZo6nO3G1d9x7t7kkh
	NoeUB4Kv7cEuh1zvwhtQ4lvPnHuHDJ9m7veW1D3T/poDl23QR7YWOJvZigYS6Ylt
	DRsBQOidpTyhEaSfhXTtUj1dsJbv3MF1OycoZNOQsmIo133LNJ0Ey8yb+7Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778603691; x=1778690091; bh=GnEl85eDQsPi5hT7ksSu37WfiKhXtxSgzkM
	E57fF46I=; b=LyCkRn+K/7IR3XfK2AFRELtJr7JMQJ9WY3YUOtf+89FzMDv8NYK
	GtpvFTDNWYZCdZueOrGyfdJ5llATGcT0+IVnc8LUBgRP+9tpezgFo9gZ0RZN+dsC
	ttMZ3yWBhvGMYYsjO/LxeTwPePgxv1C0wxBIgkVs5EjqAzBtryOdQNsKjAvYqyEH
	lB+GKuaEmqY6ItLcRoloowpLXUWvApd0gbXYqpze4me2hHFP3savYFaYhHiktd2j
	oTaUYWeAUZrUSSzydgVMtz7CPQWnlGDAX+Q6g9BjcQbDprLXLngw35MZZJH8UimB
	NVuwD0aKDFN6hk/xyxYIqPQaaQSuO7uFmeg==
X-ME-Sender: <xms:q1YDaq6v0zlqk4G8B4dtnCM3jSY39pzF6b-eAWZQ9kTELNKyzkjwBQ>
    <xme:q1YDaq7hjgrAbbOp-ZcOgYtoX3qWKHeaW_i9abBipxhztGS9TiPNxmHKX2ltUwVTt
    R-Bg3w8CF9bLMyA_0mczQMClB841-aKIzB2NZahSPOe9l3cTDAa2A>
X-ME-Received: <xmr:q1YDaud46jtmrRGl4u5esVCCWij5LBOzPkQmyj5dgsSnmXfp7BzE8HTfZ3EkejI4PZSQzXihpObLK9snX6MRfsdAwSOPCwMtFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlsehuthhurdhfihdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q1YDamASicsGS2z1LnOkNIFHPgZSIHPyXXgLEi4aH5Z6reqpjn2exw>
    <xmx:q1YDap9IoK1lcPEmCr2FkW89ZSn97HNjUW_ufQ_nE7exJTEANYIv6Q>
    <xmx:q1YDapITqBGAugp3fF4CtcIBfiUjW1-seMU9mrHP7ZKxecA8IXHwDA>
    <xmx:q1YDaqiUqLSyHLpHSAAgE3MQirENnC8T-ULIK4B1EllY_qjqMLaiww>
    <xmx:q1YDan-fG3d72HUypSGPM0JGnoFPxlcG-a5RS3UGyAjTibvwb6Wl6RQ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:34:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] t0006: add support for approxidate test date
 adjustment
In-Reply-To: <20260512145430.13212-2-taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 12 May 2026 17:54:28 +0300")
References: <20250318180201.3653-1-taahol@utu.fi>
	<20260512145430.13212-1-taahol@utu.fi>
	<20260512145430.13212-2-taahol@utu.fi>
Date: Wed, 13 May 2026 01:34:50 +0900
Message-ID: <xmqqfr3wlh79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

>  check_approxidate() {
> +	old_date=$GIT_TEST_DATE_NOW
> +	GIT_TEST_DATE_NOW=$(($old_date${4:-+0}*60*60)); export GIT_TEST_DATE_NOW
> +	caption=$1
> +	if [ ! -z $4 ]; then
> +		caption="$caption; offset $4h"
> +	fi

As you are not doing the test-date-now adjustment when $4 is not
given, wouldn't it be a lot easier to read if you did something like

	old_date=$GIT_TEST_DATE_NOW
	if test -n "$4"
	then
		# the convention for $4 is a bit weird in that it 
		# comes with its own +/- operator in front.
		GIT_TEST_DATE_NOW=$(( $old_date $4 * 60 * 60 ))
		caption="$1; offset $4h"
	else
        	caption=$1
	fi

instead?  Other two minor points are

 - Documentation/SubmittingPatches prefers an explicit "test" over
   "[ ... ]", and have "then", "else", etc. on their own lines.

 - As you never "unset" GIT_TEST_DATE_NOW, you do not have to keep
   exporting it.  It is not like there are two variables (one for
   shell, the other for environment) and every time you set the
   shell one you need to export to reflect the value to the
   environment one.  Rather, a single "export" marks a shell
   variable and every time it changes value, it is updated in the
   environment as well.

>  	echo "$1 -> $2 +0000" >expect
> -	test_expect_${3:-success} "parse approxidate ($1)" "
> +	test_expect_${3:-success} "parse approxidate ($caption)" "
>  	test-tool date approxidate '$1' >actual &&
>  	test_cmp expect actual
>  	"
> +	GIT_TEST_DATE_NOW=$old_date; export GIT_TEST_DATE_NOW
>  }
>  
>  check_approxidate now '2009-08-30 19:20:00'
> @@ -182,6 +189,8 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
>  check_approxidate '10am noon' '2009-08-29 12:00:00'
> +check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
> +check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48
>  
>  check_approxidate 'last tuesday' '2009-08-25 19:20:00'
>  check_approxidate 'July 5th' '2009-07-05 19:20:00'
