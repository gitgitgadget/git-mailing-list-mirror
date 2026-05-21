Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DF21B9F6
	for <git@vger.kernel.org>; Thu, 21 May 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370403; cv=none; b=VVh9naq4eWjLJpNfI7xDw7R/NFnL3Y1Mgrrz5ulnHXpX7PXR3RfNkVj7h5fWobBCFwCT5N9rXxzYZoUhaK5Ktd/GJlEqvmpfmWuyIi5OLWauQwwL/reeD2ZXYy/sHgSE132iwv4SYR6yLLR30GfJASMvSY3mVGdpcAnMY2pqz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370403; c=relaxed/simple;
	bh=gJSsbpbcHbsJv/PwiHyoqTOYEFq0EsXatktvsdp2rMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNLWJmO/XMC4IiPOvCepTusSXr+AZemWDSm2TSDZupX5FrbD9tSVNa6/q8TSHH0kEDEvgbHu+jL523dVAE/M/a/FbZ5jVn8b5pos0+5ppPhVwYWfN2z69TPKP2kkX19nY+dUvVCb/rPCF39tH2AJgpBWHdCU+kE+BHxAYqAJwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lWyO897m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkqqdxkd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lWyO897m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkqqdxkd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 643271D0008E;
	Thu, 21 May 2026 09:33:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 09:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779370401; x=1779456801; bh=SL36DASS+s
	WMPDipLyQlb51s6HpfVDGw43ZmKVCzGnU=; b=lWyO897mKFHeyEVSznx+GtuWTG
	f0tspvo1Fk1LxcVj277qTA+B58mC5w9ADO6wz7tQ8k8pfeO9Zjqi2YBnqgAxttIg
	NyRkow8BD9AIr6lXNGu6k7P2hEpmVGWHE3WYptfB7YHp+GApWFtbHx/yZyxwEPiN
	hmSppVrwKXZBOPS9ZL2t+ilkryPv5yG8x6/vOW3RyTX8k+gCLmOBT6/wddr89yfF
	fLXSkWFAKfyboegFDjqINH3Ocynfef7VMRk5SbZWKb6SoeyANEs0Uj2uDbo2kM7z
	Pp6pZ2+nLrtyud6Tll/EaQ72H0RzjY44ytBM4KydsDdx1iKMO0L10avYmTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779370401; x=1779456801; bh=SL36DASS+sWMPDipLyQlb51s6HpfVDGw43Z
	mKVCzGnU=; b=qkqqdxkd2SpisyJIeghVl3B3fFxC61rjOI0Xsd1hv1iyiCo7kjp
	wG2lm3E6ASaOd8O4hrNmWzqxuLqOknPYmDVBhzjP5j7IVijiGcRmJHiTCz7x2wu6
	xyn+vdlC20I1JIcKAlHsSY3fea/yid5CfftywxdsLlgx8dUehlhOusfB5zsWZMEX
	B/FiDTO38HxS6rIdDwehgbuz82lueBj02sfJHwdHNHd199lo+Q8skHptuzm0xUX4
	U26kdm3IggsMtQSS3PS6xDmfA+LzdC0/FCcC+OD6iMf/JxnCTwmwcmTysBTbJDPd
	t/g1H77fL8mjDIDdNjLu1oi+ahBRuWh8VLQ==
X-ME-Sender: <xms:oAkPakv6f--GKC0I7rUeb4KL0XBWnN2ZobO6LU7AuyJPAQn_mZUbTg>
    <xme:oAkPaoe0rx5V0m4Ih-T6gn06f0Z-cImdQwXphJuernskFnrNjnQviPlGLFlQ3KXDG
    2TRMiOo2xfstXHmpdW3IxRQ-llz7HTNTBE82lCHk66D1d5OX9bgww>
X-ME-Received: <xmr:oAkPakw1X9m-r2pkA0tXN6UzjtlXOZMZOkVu0wkt61nlJ3171ThGF0UOzciyDNJgE5NtPQUANCxJVgPPoF98gqAf_zc_B4uFww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oAkPamEHnPpryVYmUG8zq-om7LeYxs5GsD_-u4KgQ4fpKjGMEyxXLA>
    <xmx:oAkPagyAvXuzC0KK4pM-4dkxARwIeaNIzqMgcT7kJ25eCd_ipgwrbA>
    <xmx:oAkPavuaYLKCKpHdh6_X7lKPmN_r0x8HwWJJ7dQPRzla8qAHlTBRUQ>
    <xmx:oAkPal2Srs_oku3YBnKZY_rQW3kJadcYrfKjLD_41fW3CO6ng1j3YA>
    <xmx:oQkPatz9rzwoT7KimelxDx_FErwRVepwAmzM0U3E_N2qYZeacVvph7yi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 09:33:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/4] approxidate: tweak special date formats
In-Reply-To: <20260521105408.8222-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 21 May 2026 13:54:04 +0300")
References: <20260516151540.9611-1-taahol@utu.fi>
	<20260521105408.8222-1-taahol@utu.fi>
Date: Thu, 21 May 2026 22:33:19 +0900
Message-ID: <xmqqik8g28gw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> -static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
> +static void date_today(struct tm *tm, struct tm *now, int *num)
>  {
>  	if (tm->tm_hour == now->tm_hour &&
>  	    tm->tm_min == now->tm_min &&
>  	    tm->tm_sec == now->tm_sec)
>  		date_time(tm, 0);
> +	*num = 0;
>  	tm->tm_mday = -1;
>  	update_tm(tm, now, 0);
>  }

Hmph, what is this change about?  Does the lack of this clearing
break some test?

In any case, will queue.  It seems that we are getting to the point
of diminishing returns and better off declaring victory soonish?

> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index b187b1bfc4..9a76b84ed9 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -212,13 +212,14 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
>  check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
>  check_approxidate 'noon today' '2009-09-01 12:00:00' '+36 hours'
>  check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
> +check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
>  check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
>  check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
> -check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
>  check_approxidate 'tea last saturday' '2009-08-29 17:00:00'
>  check_approxidate 'tea last saturday' '2009-08-29 17:00:00' '-12 hours'
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
>  check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
> +check_approxidate 'January 5th today pm' '2009-01-30 12:00:00'
>  check_approxidate '10am noon' '2009-08-29 12:00:00'
>  check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
>  check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
>
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
