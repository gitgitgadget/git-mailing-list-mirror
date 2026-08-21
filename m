Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C71DF980
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327712; cv=none; b=CGh7ZmnLnQa2KM1QOV72FY7/fGp/eg982AH1C7PTuHwCdmWBL51dyN9woGLvBuXfAnJrl4EEK32pVs3nhlvj5zt7QwhMS38oJnnQPpvcoy7/MglHkqsPIERB2XelEm2wuFhlE1yQ7FiE9dzNF2twSA45OIRqHtzSH/fky0rW1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327712; c=relaxed/simple;
	bh=Li0mBKNXrfdq7ikXNBoOiY+4s+9g4wuTwmB76T4fXjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRC6Ae4ThAsHdEe7nNAXngPWbJZVJV0PNXgjaCU9mDqVpymD4MMnSclMt8W8XiuHae98BFFdM6A61dH8VA550mZ41CyWQZfaslfk2VspUZOiTrBvGxK+bGzZ8gVgcN6oZ7tHe+y0RmsedjhU/KGa7v+KNmk9n3osg4Ifelk2YiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RG3/DUVp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmyrbRrM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RG3/DUVp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmyrbRrM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 765E71D00104;
	Fri, 21 Aug 2026 11:55:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 21 Aug 2026 11:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787327709;
	 x=1787414109; bh=54PrVwKZ2gN8vy1JSqK+sxUONGEGjTbxDhYnAICzdJc=; b=
	RG3/DUVpY5aeLPAKtoxNFSz+GSdz1PZ0pODUlHvzHS/kCsWn3ZCkiDQDc7NVI9J/
	7NvtABpoXpohaALcab2HX9WnFro6THCQva403a2nn64E+Jvv21JP8C16gFuPPJ9f
	RNZ7VNX1EcTu5HBQT8f2OG98hVZtrgUDHlypDaGwJrKg10JLMYs1m8lopTynkyXg
	pJPBbgY6uQ1V1ajxlMsJiL/9eM5G/xAxQSAUu6ieHgajhtSlK117BBOpdSeX1QLO
	eVT4ocztqfYVEXj9Dd0XrftcN0GXURagDl90n1MkRuMdOrNmPEcN0Wegw5VB2u3p
	7d943HjL3REuY8c1pJkf+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787327709; x=
	1787414109; bh=54PrVwKZ2gN8vy1JSqK+sxUONGEGjTbxDhYnAICzdJc=; b=A
	myrbRrMPghqyFhDUveCzFLuBW6krPFlldYTCkEc0pyImLfu9KMo+Uf+L6DiIWmvH
	c1mOuwRQzY2+gebgPzt85m2AcxpC1i7yAcjXC/BvGTaYwwdeWCkVuqWWPeX3W1zY
	thKMXEeVTMwk0vVBVsLU+XRW0BbgmMOII6AzybuZWJGYho/jm32u/Sd1OP57+T3V
	InAdREL/c0UYLyCpxqBgPJVD4EfnoK7qwW66b5C9GuEXlEHinjKY0vVLWP9+Hdrc
	aLFX0/RRINJtlaJqWBYfG4brNxLFnKHetmiSE+5xS1Benuqa5pqlTORt+LeitWIO
	spZpkUAKCtTn+Ui5DUi3w==
X-ME-Sender: <xms:3XSIaiDNfFEu8-HxMKNABHk7wYp9QJhvx_GJbtyG-TLPQaEPrtBWlg>
    <xme:3XSIajb9GsepqMjBDaDef-w7-T-mZ71SNmJyHvpkVHtwG-7IZpbF1hvL4--K1fYFC
    1YCccmnTKHbEPdoltGtOb-HqgrGRqzklWKemTDoXk2xa9ttm_hS9A>
X-ME-Received: <xmr:3XSIat7m1upv9rSorTpomyYf8_YompvVfNuaJyUFDko5Z-5WsSKKxgS8LmsJqH92jOST0Cj4bAvBsC04QMaEP2z3ndEMAEI7rQ>
X-ME-Proxy-Cause: dmFkZTEC6rFglHOt3tk1RV84He1b3y3IPJQjUSrSdhEKkPsbuoDiK+Rrv2ic+8kHEit7Ia
    V3upPeBlLBnbpdu0sAOGiv2X5Yk7nmeL+j+KHXSsnNuPGrQnB+WyphfP7XxqXZ/bcjDS8c
    xOCh1taPDuFsQNYyVSto8rflYosFdNU2H+9ATdd3Kb1Yv3T88BWfGVHvkAaI6sJGv8IKy6
    YMuALMACRdmuwwjpECDg0EaFhnab4u+5TzpGDrc5qOuuRWq+IuKp9VQirXvE6Y/F1xCHBg
    jUhojRx7mhnRZnCG1MJqE/K4b324DBfN+Xy/Efgvm9DIzZQc+Rx/BVtr2xyVpg1wUDGxGH
    RQ8DF9sKtITxORzbiVXRJnt4Jax0YVyhg3P+x9qu3bIVtQJ9i7BRtGGJt6zBjQyQHodrPH
    Mb08ruecB4tp8+kkmp3GssnXJZuAx8tQaXqtGv7mjUVv1G/v+FeEG1YLq1TccghbCE/mfx
    bC+l4npbemi4/sUIbu5TWMA0tj0DHtHKGE3a6NL+AVZI9BEbBW0n/JLpCEML3dh+LMFI60
    rW75f4ddbJARGQUfR9ndZYGs4jXsC26W4dhpRYKmUxGLRxH6R8z69vaJ4c3s2dH7Ek1ZfQ
    52pYt/21kDYlp+E6+hP2Y+x92o9BAtSm2Pkklb2qcND3lBmjMXj1qLSXydzQ
X-ME-Proxy: <xmx:3XSIasbqNO-SGzvk8W2YTc7yN0KqS5fFeSmO9vJjc0Dq5CENFOZrZQ>
    <xmx:3XSIakiXE7zAwGZ_Q8-2FxnMLXns7_idVNWYbBOGzU7-JlC1YttJYA>
    <xmx:3XSIal9znpiDGr6ClhAH9QW-qKoyINwd8p8JNc-njPtQ-_fpXE6-EQ>
    <xmx:3XSIanrB62qg5yWIjzi0SiR6Uvky70-aTZ9WIx7SBbEDIdpdqJSLqg>
    <xmx:3XSIatDJtBj4eAmMheH4fDSzpomdtjgMGUqoBUxkl_lDS-VMHEoXJSw5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 11:55:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: [PATCH v3] trailers: stop recognizing URLs as trailers
In-Reply-To: <V3_URLs_not_trailers.bfc@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 21 Aug 2026
	07:26:04 +0200")
References: <URLs_not_trailers.b13@msgid.xyz>
	<V3_URLs_not_trailers.bfc@msgid.xyz>
Date: Fri, 21 Aug 2026 08:55:07 -0700
Message-ID: <xmqqecfrqxic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> Notes (series):
>     Topic name (applied): trailers-no-urls
>     
>     Topic summary: Stop recognizing URLs in trailer blocks as trailers.
>     
>     § Link to v2
>     
>     https://lore.kernel.org/git/V2_URLs_not_trailers.bf3@msgid.xyz/
>     
>     § Changes in v2
>     
>     • Add Ack https://lore.kernel.org/git/20260821004248.GA296777@coredump.intra.peff.net/

That's a change in v3, and the only one.  v2 was already good so let
me mark it for 'next'.

Thanks.
