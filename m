Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5C5221
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058362; cv=none; b=pqS2B9ncqBN/nHUC8PT7nwE5v0Nze++07PJGIkpvszlIKPC7mFK62828BF/gtFqc2J5HSaSupU8d2c2QbwY+z5YJzE8UXs550JuVLucf1GXzjjUpnl9AqMJcj86x8goRXa9xiNuvKzYxbJA5WRf6iV9F9oRl8oTuTGKY1Pq/DKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058362; c=relaxed/simple;
	bh=7B4CuSiDMRRsze1AbxDFakQ8JDhqKL6NU+bSt2baseg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hlGbHU3cshxM7B946UuUXE9huNB1LS/7yUfZbjL54CZVuJwmOsH+7o+RROr8EQVbKg0YiD6ezftR7Td8UHTqCRtTQUYHxsx9OHad0UTtvJgOuZfj+EYJLxiuQcjWHrXbsA+NjyKD26DTSA7a7AW5BHVf7xAaoWP0+9hgG/SL8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=RziM2ugx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpfKEevs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="RziM2ugx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpfKEevs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E98613801EC;
	Wed, 16 Oct 2024 01:59:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 01:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729058360;
	 x=1729144760; bh=7B4CuSiDMRRsze1AbxDFakQ8JDhqKL6NU+bSt2baseg=; b=
	RziM2ugxtNX+4uXn+JCASma72bJg23tHh2G8Gq06FYywZCnG58w7pRhOiAfUmy7k
	s1qf6LT43/49X8nE9MMxmarXLf7RdrFz8xiGli7iJd7Rz8MlplAShqDzWIuNvzut
	bfVU7nCGNx5cUQ8Q1RCUO4Mrbt6VPrh5KtyKA5VgSLv6yIBalWaeWA6HImgfPOrK
	BNbpYuzj7aI4Sc9aeQkgBd8lzcSHiVtec+CY1sAZQjGTvWwUOCRx5SQrxk0y8J4Y
	iNfRxYLvCDs9jn81sdRuxKgtszOE7NFn5R4PpVVfLoys9vnRIFRMBRarhyBVgn0a
	PCznHOMBKXk31u0syrbv+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729058360; x=
	1729144760; bh=7B4CuSiDMRRsze1AbxDFakQ8JDhqKL6NU+bSt2baseg=; b=G
	pfKEevs71w+7AX3zk2U6wCTenoNwW79bQZ/3cqWu/9UClxY7jroLfUnz1ULOCYiN
	I29KjHhUwAXgXpmZm3Kxb2YlY3esOKsBH6y4ZhItILLO4iS75USAOxkve4uoSFGk
	xyihshLKvdzSI3zsL8ml0t/0nzPJMiU4jrSjtMUK0bRMqhgzLGVAkxq+iz/qyPa1
	3Bl3UOvUkeLMpgjLSyRV6zzlBv3p5APvCh+WWVIOCZNLKmlWtZXmbUu0s6ozaG6z
	m7LzxE9bSGFcv5UTfT/sqjWOtJPs23mjZ8ibKylR19PaZHfPUAIOxLu5A7I/ZKsO
	K5S0a0YBV6Mmls8lFJhXw==
X-ME-Sender: <xms:OFYPZ0iMVPOoCevL2wqd07U7zvhy4FvXHPmK3F-Nc83F8xEexsY6Bw>
    <xme:OFYPZ9CGXpu8FjXvp2jXwWyFlScLNpe38UhDZSAsaV0fShKt_9_9ElrH1FdV6VgE6
    GkXHo8wE9AWQd7Xzw>
X-ME-Received: <xmr:OFYPZ8GefrMpRsohIRBRKG5ojxNM05qc7PyMEbA0KTdwqCF9AS-Zt_C0nsSV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
    jeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuh
    drihhoqeenucggtffrrghtthgvrhhnpeffueektdeigfejhfehhfegleeigeduvdevueej
    jefhgedtvdeihfejtedukeejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:OFYPZ1RqWixi49yxSBe5e-HEtLKcF4fkRrp4qwkySGpeff5ZJvB5wQ>
    <xmx:OFYPZxyCujdFZo51-wa_r46toxVGu-rFpVE6zDW1W7NKedv1TPzgiQ>
    <xmx:OFYPZz4qBQaHgPP5MH4EhfOe0bywoK_FJvLX55zjPnp5hJC3PAsr5w>
    <xmx:OFYPZ-xB7Fs_xu5v9XvmtFIw6k_rb1qAbbwBjU_s5yakukxwdTE-Uw>
    <xmx:OFYPZzuicwaPVjekYGGNf2LT1egF2JJf46M5I_XfH-JtCy7s8hO2pFx3>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 01:59:18 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 16:59:17 +1100
Message-Id: <D4X017IIV17C.3G44QS1AYGJP@jamesliu.io>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/10] t/lib-gpg: fix setup of GNUPGHOME in MinGW
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <cc94f6fa64805e0bc45fc18445c3e99d2f5ca9ed.1728992306.git.ps@pks.im>
In-Reply-To: <cc94f6fa64805e0bc45fc18445c3e99d2f5ca9ed.1728992306.git.ps@pks.im>

On Tue Oct 15, 2024 at 10:45 PM AEDT, Patrick Steinhardt wrote:
> In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
> point to a test-specific directory. This is done by using "$PWD/gpghome"
> as value, where "$PWD" is the current test's trash directory.
>
> This is broken for MinGW though because "$PWD" will use Windows-style
> paths that contain drive letters. What we really want in this context is
> a Unix-style path, which we can get by using `$(pwd)` instead. It is
> somewhat puzzling that nobody ever hit this issue, but it may easily be
> that nobody ever tests on Windows with GnuPG installed, which would make
> us skip those tests.

Thanks for the explanation! I didn't know "$PWD" and "$(pwd)" would
behave differently under MinGW.

