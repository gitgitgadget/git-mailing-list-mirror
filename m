Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6BC1E7C28
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831724; cv=none; b=MqGpoOfwmRmIY4983FG6BuMmZS20TXICDmIx+wR42qcBHJQs4BtVEFy1YDwldrFKt8iUQOmUa8NhkWuxLU5mjCiIC9R08hSzJ0DGgPBfaXGIk7mseoW7+I0K+HRDGv20uOo1K0fBX65U4nVAau1v8Tu+s0fOlaZQYJyYY+4bRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831724; c=relaxed/simple;
	bh=MEnXj5mshuP9am6QxEeekhtUduAQ3AWwrEFU0knavD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gRLuiIXLkdCVG0Jn0VQiG3oG6UijgSrpQOd9LHXVBhrnrPrzSANgR0i0NRSe9p1BwB25CxXYGh+efITFz5VngqLndzD89UVGsY/RAfXBcu3Yo3JzaQ2b5bCI705VJYWZ8c7NceDntXk0+Vb/dLmtUOMr527tZBO9ibbzMlcvrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WtXL5iJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUJEZqQt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtXL5iJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUJEZqQt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6AAF1140221;
	Tue,  5 Nov 2024 13:35:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 05 Nov 2024 13:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730831720; x=1730918120; bh=fBK7W2hQn4
	Z2BqL0LF9+hy9/iQsLQICLoX72WJBMPjk=; b=WtXL5iJZGXZ1tIE9IoG/2c451W
	SFHVyKlQNN9HeZphE9PPhi2BUJD2cylxVbRmSQlOKspCX84CGXcS1HeENMa29lpR
	GysbI4z6oPf6EDaEpS2fF3wjdzXF0kUUkfvDMIPA0SPvj0/q0McL0FMBxM8x1kzC
	4SBsYJ8gj63S4PdKP1JZi2cw4ZZ8S2M+sVoje2VyvvYqo/Q7/M9rdze7ND31zESk
	XFcylOBrBak8y2aIvNJqM7nftYdq84RWGwc7KkKJzl3cWinDZVNkMVy8iLIOo/et
	YMeIlYngnz/Z//CjO/VQtcnsnLtYFEL1lbTb17Xp6obtuIZ0r4dPYgGvlJaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730831720; x=1730918120; bh=fBK7W2hQn4Z2BqL0LF9+hy9/iQsLQICLoX7
	2WJBMPjk=; b=SUJEZqQtvo6kuyYpf4l+AKMF9hUtRJScOkbfvDwZo56M1lg8Cc1
	uHZNVWrhff2NX4Wmcw6/DS40DtQBuGiv85e0/5frKCbVMpcrM2hzHfMWh5j5rkNX
	sPtTAa2oEmBdb6xTa04EwS69JAde5LvHaPB5Gd4UA46a4OTnX6OQ7qIUHVqh1tyF
	RJ2T7ptAMxXxuHq4w+jy6Dws8PouUT2z/7y32tkJKtEIF6s06QbPXRuOCNCF0jQg
	ZSbt65CmDah7ufbAYRScRLcrFZW1KXTCPb9Bx9KPp6KOqhlWohoMpZ6MLhtfg9iE
	s46cEJPft6LUVJeEFWHUgf+4CecT/ws9ysQ==
X-ME-Sender: <xms:aGUqZ55tTgc2q1r2-eaEaWeeT5m1Ls-skPrp5hlPtX6HAS4FZbhwDQ>
    <xme:aGUqZ268fuwqO8TgiJVXorTrOzylK3hBuvXtRd2gcyd9TD9LHVZBkHKapEJr9QHeu
    cTorQKiSoM2LD08mA>
X-ME-Received: <xmr:aGUqZwdnCaCBAwmCN1cwi87h0jxbFvYdYMNG7trZRb-DGl5nEuwYNwgwnvglmbBVLj69TxSS0Vv-3Tu6AsTrv9D5zlEkk0zIKITZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhrthhivgesmhgrgi
    hsihdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aGUqZyKU6Od84ale5XdU3tdPNvLKFUVogFZCiG_SM3Rnnel7RuW_tg>
    <xmx:aGUqZ9JiufqUm4XCkf4RsOYQDWaUh6OUVstbN0NWnwdxROODVZg_tQ>
    <xmx:aGUqZ7xbNgbbOgi9ufbxHKPlNOZ4HdHCLRp-HMhD_9McyftrR_QwkA>
    <xmx:aGUqZ5KIfYc2wUjQhkteOGXzSwproY6XcjSLXcqT7zlLZMmB9KNkgw>
    <xmx:aGUqZ938z3ssdTeBQ4e4amzGm67fOIPRow173O1Kh8LANgO8415TldYf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 13:35:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Makefile: don't remove configure on distclean
In-Reply-To: <76f4dfe6-3724-472b-9b42-c91926e61fd1@maxsi.org> (Jonas
	Termansen's message of "Tue, 5 Nov 2024 11:13:49 +0100")
References: <76f4dfe6-3724-472b-9b42-c91926e61fd1@maxsi.org>
Date: Tue, 05 Nov 2024 10:35:18 -0800
Message-ID: <xmqqldxxsf4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonas 'Sortie' Termansen <sortie@maxsi.org> writes:

> make distclean conventionally restores the extracted release tarball to
> its original distributed contents by cleaning the source code for
> distribution. However, the configure script is part of the distribution
> and should not be removed. This behavior is creating problems on my
> package infrastructure where configure-based packages have make
> distclean run afterwards and then the subsequent git build fails.

Without a target that truly cleans any build artifacts over what is
recorded in the commit to replace "make distclean", this is a
regression.  It seems people use "make reallyclean" or something for
that, perhaps?

> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 6f5986b66e..c488b914a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3723,7 +3723,6 @@ dist-doc: git$X
>  ### Cleaning rules
>  
>  distclean: clean
> -	$(RM) configure
>  	$(RM) config.log config.status config.cache
>  	$(RM) config.mak.autogen config.mak.append
>  	$(RM) -r autom4te.cache
