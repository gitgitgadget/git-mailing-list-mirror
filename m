Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5D38384
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495657; cv=none; b=RFwvVqy+FegEnJwyh8fzCvmXaK3d7xdNtjqPtkiTti8D56lW3FeJWgzoyDALVQkR9QOP4roTVGQUMx68S6lHuovfZQttyl4DskSfB5PRVHwwdC6l1Zz30aNkfnjpRsRMouKjGE2toNB76cy5eOvd6UUXcqFpPgeIh3F1kOMbKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495657; c=relaxed/simple;
	bh=04yFxwxhN4ugEcxHdgXX5DIMtdyK761EIyKOq4t+2Ec=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YjotiMdiFj8TIKGQfOZxxMvwZA+CN2KB+ECxZVFkbedWzYj4kXPOqdet7vJsZhIJdDPNJTh5PmBAukCSVyx/ck3pNhWaP/sKJwIKiOMJwQCmHV4TkGjANHBs1vcoOHCHA+6zVI4QZtMVUgEWakw3mdLXECwOq/fTjuBGBl9+d1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NNWJIWiw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0Wi3VXhI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NNWJIWiw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Wi3VXhI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ACD62138398B;
	Fri,  6 Dec 2024 09:34:13 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 09:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733495653;
	 x=1733582053; bh=tJ/tHs5On/UO8TBOzQmL3MasXP6Nh2MgekBho2lIbWY=; b=
	NNWJIWiwi/3BOTwN5NTWD6ZXwbiLLytrXHlITRWf34OQ7QxY+OAPZ49+M2AMx2wH
	UdZhiMTudcekiZyMbv+7S3e0OLaTl15NAu1aNBVMUPU6zdakYsQjJcB+5MGKIQ7P
	bTcXn0TFCmJsHKPxu5H+pLFmXsFruR9hYCoCMdp23iCrDNH7o/dsB2rmWQ8VJq2w
	kf6zIMDEIxRCzSue9Thu68R/j0KZbrHG1Y1gvYFlus9LvIJEdFXtaKsWDrQn0UOt
	30gW11VeFB43CFKJv8/cvrS7APFeKcYi0ywN23HlnmXzq8qFHh8Hu1c8ra2RrlV4
	VP5W37IKdIHgff3uwWHLPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733495653; x=
	1733582053; bh=tJ/tHs5On/UO8TBOzQmL3MasXP6Nh2MgekBho2lIbWY=; b=0
	Wi3VXhIK8x5724ya3po5f4N88d3IV6Z2oY2SfT0/Xd9vLIp7YxFMIUgbU23y9v1N
	8UpC4Jit/PQduWA9MDfdjJNLNEB5VqCciJxtfO8+8SjJNyTphyi/gQnk+hJrvewQ
	Lg8p3CIRwhfINn3nPCk54CxlKkmQGZKId0of7Ad/JRnoKMuzlWAJVio/x4nryYj8
	sw/81rN7+IOwHhNFefEVUu9+qnVNqAmsa4t0uzuszx97Clh4dEYmod33w3499rL+
	7wv34QrEfFmlZu2lsl9AN/L67fA+Rwk36TEbCTcm4P72skg3F6KzDusrNXZ1zxfZ
	ugvrggVTL5ZBTHvSwShdA==
X-ME-Sender: <xms:ZQtTZ8P8uLCR7Vds-IgSQmG_zEwgsH4T6MX5f6mX18y0bEws9TCbQfg>
    <xme:ZQtTZy_tlNfePTNAqs0psgUSXvPzAQiVbClFLgGeiIaSXs5FJ4yzuul_zauUmQNbZ
    W9CP0mxNl3PwHz0FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfe
    dvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprggrrhhnihesvhgrlhhohhgrihdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZQtTZzSPNfi0N-bFaZnSkQCM1Do_Q07X7avIqG3TjEI4q80gCj7aHA>
    <xmx:ZQtTZ0sdSi6OQYDHQyi1xCxGWjT_4RuNOkYc2U7XS9-ONKzKv_FbDQ>
    <xmx:ZQtTZ0efR5PjbP4chsoSdDk40DDW0UJjkm5VNzpLV8AQBShAi-Es-w>
    <xmx:ZQtTZ4038_aa4_QDgmSbTuWhSFBmbbyKpJqbTATgzer878E0_iGEww>
    <xmx:ZQtTZz4Y_ZF5BhbYQQB5i2LnwjVVkcnMWzL_erhT7iu4gfQbDRJ5_cTd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 577B4780068; Fri,  6 Dec 2024 09:34:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 15:33:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Aarni Koskela" <aarni@valohai.com>, "Jeff King" <peff@peff.net>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>
In-Reply-To: 
 <20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
References: 
 <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
Subject: Re: [PATCH v2] object-name: fix reversed ordering with ":/<PATTERN>" revisions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024, at 13:28, Patrick Steinhardt wrote:
> Recently it was reported [1] that "look for the youngest reachable
> commit with log message that match the given pattern" syntax (e.g.
> ':/<PATTERN>' or 'HEAD^{/<PATTERN>}') started to return results in

But the regression is only for `:/`.  Not for `HEAD^{/}`.  I=E2=80=99m s=
orry
that I wasn=E2=80=99t clear in my previous message[1] since I didn=E2=80=
=99t establish
the context properly:

    I have indeed noticed that `HEAD^{/}` returns a sensible thing while
    `:/` does something strange like finding the root commit.

What I had noticed myself for a little while was that `HEAD^{/}` on
Git 2.47.0 did something that I wanted (and which is documented) while
`:/` behaved (behaves) weirdly.  I just shrugged that off since the
second syntax is more useful anyway (like Junio said).

=F0=9F=94=97 1: https://lore.kernel.org/git/Z1LtS-8f8WZyobz3@pks.im/T/#m=
0b68bb083d5ec6fddbc2af2ec5886a7a884d27ad
