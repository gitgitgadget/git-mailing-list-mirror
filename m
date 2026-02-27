Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A20329378
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216392; cv=none; b=erIUSmHhTgpxukNhZQpoCKvOyE42Wb+cM7bFLWtMFYZtOGOqD3QsRTYTGiaBmzmhNgGHhZeDsVbddAq59xnse40dCXoeKRb4pd6ME2VOY8cFCnQtpMklmVDl2j2szqaEI53f2XW8bIonec/YoD7z97xxLn0XsM7yZy72pVgNs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216392; c=relaxed/simple;
	bh=zjn/zPzPVV3gOFNiUcbOe4rNCngZakM2QMYJ6qQ9viY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXHOTAq2+MP9R/W0x59AyaFIMeVemuftPrWRGgCvm0W4OoDL5HVVeq3vOfEshxCqvjRJvHM017TDPXuSVJA4qzJpw2t14BP398U9+7N9LGEQNjJT/Nvbd8zHK2+E9NTsbDplYc37SCJJp+NaFs9NwaQ47qO6CqrhLC2i3E1l7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nZBjH704; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ROqLOaSd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nZBjH704";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROqLOaSd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 309F27A020A;
	Fri, 27 Feb 2026 13:19:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 13:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772216390;
	 x=1772302790; bh=aGckFHeBG/h22SnRHdMnbdYqt31pQ/F6mVy8vRcPEtI=; b=
	nZBjH704IIQGM4eivEONJN+EuxsE1vWUOoVPg8ELu306UE0ppzV+80hEtZr4R4Bn
	fBrRhlFs4pvOTeW3L3SWueiq72toAVjkwYVb1E4DTRg5ydgWsjnjpVBEWKzvaKB4
	bRfbe/06OOFjCUCBJ01i/LrUxCspEvvHZIZg0ERlkUr6LElYRKOXssQJMphDMfuX
	uRshENYR6JMCGUaPr/m6DgdqQclnhUdgaJ2VpFDbTYVQhgca731/yrgJpradhKlT
	CG2/I9TEuN7+faNkYEZu8AQV3L4JCFYrAyAf9fXJKY3eOFQjfhoIT9OzESCGZFA4
	xlm8RXml4W+WbtQeSRHXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772216390; x=
	1772302790; bh=aGckFHeBG/h22SnRHdMnbdYqt31pQ/F6mVy8vRcPEtI=; b=R
	OqLOaSdXo5V03HbxehkcwirNtHKGPf5Ol7ZtmnsBiMXqG1K4tEPkuaacFP9Yf2uN
	TEr+ww59tbg9t03lgg/yaFNKHY1aTtpIo3b8a4H+rXx22MRrCNBe/zUQaAMt7Toj
	1yyuuL7wpWgEcN5nD1q0xBLkVMPgSr+VkU7Qt5lQrMcMKpEoTplWxfu+LH5mbbNQ
	k7RRhVtcGsMzrYqOLbLbiR4FEUUa1CSANEfzkIMPu2lubXKEpYJeu9F6C2qfVDhW
	eScC6dlxJq6laPRrt4mgHjvr96masnDax9Xqt2CvSP+fWholUeRS7shlOHoWw3aN
	r6jTWAwC+oCjK07PU33rg==
X-ME-Sender: <xms:ReChadQiLb1jvZyjji1YRk5PEvtQKM6HvRBT1sdHT7vyfHJ1WCIHXQ>
    <xme:ReChadwMIXDGu40WPYRmposI406vKtO0gWo9UsjG5W0jUBTKnrC2Np3qxaEx6hQ-j
    hCD10UBYsziLJq8If651TtyUs_tgMr_hxzqdMkUQkD8Ax0wStUveJU>
X-ME-Received: <xmr:ReChaX0vWoBm0J1cH7rhiG3nsz4TFxMD9szMO1FdasCM7Z7ELl9MvAj4BJOAsOZ02Ni_vjUeSd4HIzwYndFyFt5393gxUJwkvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhshhhrihhmrghlih
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ReChaT6UbLPVavY0Qg7C9weGntzAEbVdXioQgg4myEEYFB7IMo2ezA>
    <xmx:ReChaSUI1AwLsT2zX_jA73HTjA9iFKtSWPE3ajcx1C_gPpwoM8OY7g>
    <xmx:ReChaaADS9zKZxz7OEpTEIlcco3gA8l7jnjbexJEoVADEyDO-OJ2gA>
    <xmx:ReChaZ5endA4AFVyGj_-c5A5IfZ56lmuehNyAeht4G0HXO-ciTalpA>
    <xmx:RuChaZzPqujb8hhEZGgHB32IXwY9o7nx_iGqExq0ebPTpThq4g3X3TeF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 13:19:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] t3700: avoid suppressing git's exit code
In-Reply-To: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Fri, 27 Feb 2026 22:21:43 +0530")
References: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 27 Feb 2026 10:19:48 -0800
Message-ID: <xmqqv7fiqcaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> When piping the output of git ls-files into grep, the exit code of
> git ls-files is suppressed.
>
> Avoid this by redirecting the output of git ls-files to a file and
> then running grep on that file. This ensures that any crash in
> git ls-files will be caught by the test suite.
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/t3700-add.sh | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)

A few things that I noticed.

 * If "git foo | grep bar" was expecting to hide exit code from
   "git" and check the output (e.g., "git diff --exit-code | grep foo"),
   a mechanical conversion "git diff --exit-code >out && grep foo out"
   would change the meaning of the test and break it.  I did not check
   if this patch has such an unintended breakage, though.

 * Many of them do this:

        > -	git ls-files foo | grep foo
        > +	git ls-files foo >actual &&
        > +	grep foo <actual

   or this

        > -	! ( git ls-files foo1 | grep foo1 )
        > +	git ls-files foo1 >actual &&
        > +	! grep foo1 actual

    in which we might consider using "test_grep" (and "test_grep !")
    to help the developer who wants to debug a breakage in ls-files
    by highlighting what is unexpected in the output in their broken
    version.

 * A rewrite like this may want to be further broken down.

        > -	test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
        > +	test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&

   If "ls-files --stage" segfaults, "grep | wc" would not run, $()
   may exit with non-zero and turn into an empty string, but the
   final error diagnosis would be something unfathonable like

	test: -eq unary operator expected
	test: missing argument after '0'
   
   which would not help the person debugging the test very much.

