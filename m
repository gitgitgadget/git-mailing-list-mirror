Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB36149E1A
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693487; cv=none; b=Yvc7g2Z3/g1Ulf3tStOYcJwN9nU7DjyJstAtcUbPbzlvrS3e7oKj2Q+qFF0HHOfUwPCx05tF2o/TjIa/7naxMu6WIuZ7AEbShZNAxjLhZvADH6aAAWFAgAUgDBliM03nGPOISvQs3PHWYfbTKOg5zHMiyN+wznPbVj86Hj3iRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693487; c=relaxed/simple;
	bh=bS/O+sMWns/SU3Wtkjde4Yr4LIBYC6mFAwNGeAM8ZFk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CQWGHrPmzebmh6HNKDBrBeOgkieGW7TQYdVc72QoN+gawqfFaQsl3PRVKXqvGh45NGG6rphLcZDnTGw6AMfxAF4LSRDPb/j2fihs6J3QxD1H6sKldNcZyklDH5LxE1pqMf+w7uImDbb1Y9dl88ST1gHDL47mzyL7O9P0DxpeeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FTVPkPjt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1bLIJGBe; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FTVPkPjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1bLIJGBe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5247A1380627;
	Wed, 27 Nov 2024 02:44:44 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 02:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732693484;
	 x=1732779884; bh=bS/O+sMWns/SU3Wtkjde4Yr4LIBYC6mFAwNGeAM8ZFk=; b=
	FTVPkPjt//wYBAvnUFjgL+7pMyKgIgQI3DmhhdMy02hyqlVTc1Rbcfw/Upg+jSvD
	XuaGS/T1fOGm6FYYX4y9uhrp7Lv8yd3S/cIQIQ1PVy3HtFgB+a0fiqzOpmJE2A1g
	s077So1OdOhh/SV8q0VJHQlYlQuFNV2HsdP+IAa4USpxGs4PrGYqVrcTdegIzBIW
	stJUWa5bOf+u0CmJG0Ck6lqh5fkDbWdyaMHdfFV7GnvsQN06YeDal2A4yC9rnXMx
	+F988SkddCqLP3rv79yGAij+0pOrZklIUE0bGduia4Q4bLkQdaZrpp3llVih8jfF
	xcFuYWiX8ezrpD6PBFixBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732693484; x=
	1732779884; bh=bS/O+sMWns/SU3Wtkjde4Yr4LIBYC6mFAwNGeAM8ZFk=; b=1
	bLIJGBe5fg0CTZgk6ibySQRYKrWJ5dhVvZtwOinCLw+UEJPHSdHFx6+gfaoCDJYj
	vlufE3QrEYe7YxjRNgOoplkdJyZGANVQgtBveEyOKohdTGpXbViZzCi+U5ncg+eg
	dJFJ49yP7/DbOqi5YLJG4ZGR1jhPWL2aVb1SyfrShOaFRg0JOMS0dvbOOaTHJulp
	BJWiZ+8hEWpN360l/0MGvL6F3+HoISqu2rAePE/SYvUNzwvYntrEpgFAWdReiAWV
	aaF868xh4JGjwTl2l450kuuKFmpqWoFEYg8VOEoHzEGmqsKyUxhCtySz3rhdnngU
	X+IvIw7zbDCOhYVWwD5hQ==
X-ME-Sender: <xms:7M1GZ6292FCrc_fE4Au_tf0wQ5qZ975J7BAmal89AUYna1mzRfCmcqQ>
    <xme:7M1GZ9FMJFBHK89R1wh7bxG9wgh8T7ua1AoRhRbYhuQtpArjjFq0tYDEIiBfo5QLx
    aCYlF4ArIMcry7NjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:7M1GZy7ThMIxVEjtoki9_RtBl0wyMNWhfh-F1JJt8yUu7jPw-m65ew>
    <xmx:7M1GZ72qlP819NAWNfqk2F686JF3yBybqejzktw52DuimI4VO_8pNg>
    <xmx:7M1GZ9FEMuyKPUifRV4fuISOPzQRbnmlU7qrTpybL1_y35gt4BKo1g>
    <xmx:7M1GZ0-vzerO20jPnXATVEVH9WdAHJwUIpGijCwdHaX54eqelqek5w>
    <xmx:7M1GZxg7FEErhPV-Ff-G2Q6KT8k49wKwkg9n7m5FGEmg56o7fL_pbx4a>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 118DF780068; Wed, 27 Nov 2024 02:44:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 08:44:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "Taylor Blau" <me@ttaylorr.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <69d332a6-fee3-4801-b920-e16da730c1c7@app.fastmail.com>
In-Reply-To: 
 <80632934d135bc1a5cc2fca1a69f398b692a38ce.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
 <80632934d135bc1a5cc2fca1a69f398b692a38ce.1732618495.git.karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/10] packfile: pass `repository` to static function in the
 file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 26, 2024, at 11:57, Karthik Nayak wrote:
> Some of the static functions in the `packfile.c` access global
> variables, which can simply be avoiding by passing the `repository`

s/can simply be avoiding/can simply be avoided/
