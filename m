Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BA5A0E7
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368738; cv=none; b=rLHEcMuw4P1wzBrTzW5hHrrfnifd6FOVwmo+oA+kID0m0goOKCSpEXEUEqEOUB4Eg7XGSXuCE8lWbcrBSBuz3q26xLaeNX+hDEYUNru7dMBW4Li4xXDaf1gcQOlxLPBlZuTXxMMXjCkBalICcVwD3HzBf7V5V/Wfu0gY0PIACvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368738; c=relaxed/simple;
	bh=J8OMvoQJjTY/D21mcWiDmuB3NvjrVu5wgCKgXj4CikE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JRXpg7OKWSw2k9Tbl+rTLhQSpyePHYGbu9F7zcF+3eXn2ryJeN9p01jR58yGZ+akqVa+G6Dq9LCCSgnDdqhuXMuez2vJqGdpSB/SgXpAsOwMs3wYwhgjsS+/P3kvdjxVOaaD0gwKPEj74JgmVNp+D8AiKkmeBJehvlT6EDl8mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=ODXTiM3s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVi0Mf8H; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="ODXTiM3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVi0Mf8H"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC69F138010C;
	Wed, 13 Mar 2024 18:25:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 13 Mar 2024 18:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710368735;
	 x=1710455135; bh=J8OMvoQJjTY/D21mcWiDmuB3NvjrVu5wgCKgXj4CikE=; b=
	ODXTiM3snFTUz+w1rE0eiyMLS7RKgOGRWdWskFZh0zS2wVMTWUezedX/SG4WP5eL
	83fwOZyE9PmKLFZzPoIOZHn8ye47ktd6KhbvvPTbq2DI1soD6oBFKIxSkwWTAKk7
	v1EES9rzBJrFTfkkiucy3o+ogp9bCcF30zHNtrDWIm45MOiKKZ2NiegA7vn1hN1U
	yA5bodrwIjHYHZrZlt/UnC9DoqLmXGHh7zV8+GcIkY+LDxuMJhy0xbMoBomzk0rw
	Np9VEWrE8mzMcefSp8CEFUuXTTzwPC2QX7w8plbjNATEDMxiuQNnd5y/t+PHeTp1
	Nuj9N6FhLf9xQvdfZHhMJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710368735; x=
	1710455135; bh=J8OMvoQJjTY/D21mcWiDmuB3NvjrVu5wgCKgXj4CikE=; b=S
	Vi0Mf8HKZJXl0tLVoB6253d8XnD0Fy/yS/3LFufNXXksl70zvMoyFm0yL3GOcGg2
	aup2CGQMaVVRk9KZUHGj6D662pkvJLI4eMjha3MEJ7ak86f86L75BVoTLrVgqpgt
	dhLGgaZ3nC1BPEH4boSYszv9ksanaXPBwCXYoyCJnBFM9qZGtKd38+rMVx4JBUnL
	5ORXKxZrmDP+dVZEdRRCklfc85FPP4/i36/0AqKsXi/6I4VDFZV+oEiPtSDvAUSC
	HakjSlBAsaZs0QnNhMWoi2H+KRYw3xOPMWjNeAznlxgDGvEqqnqERhyPO6dgjNzn
	myRkc5YXXKrVwBi4Fy10g==
X-ME-Sender: <xms:3yfyZXAy5QPUgJSz2-gTJDCiz8bw8iB-FOcsOP9o0Ll8MPCAzdpJvw>
    <xme:3yfyZdg1HXtOqCRSZ1fnPraqbiDYHH7xT8dfjyhZLaoVRI9fD1LSJQDn5CU2feWUo
    yPzIXO1SwyqqpbF2g>
X-ME-Received: <xmr:3yfyZSlVUJRZybhi3A5jQPMDcfShGfG7hIbbRT3aM7qNjgph5PaZRhtrTtAhHrM620FKXLx_8XAnWXX0xd7SWnBhV2LY6NOZlmk2T1zd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkvefuhffvofhfjgesth
    hqredtredtjeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghm
    vghslhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeffueektdeigfejhfehhfegleeige
    duvdevueejjefhgedtvdeihfejtedukeejheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:3yfyZZyEZqda47NkhUX1mL65HYM1ZBWivjU7WUGQVeKIL20Kx5wvPA>
    <xmx:3yfyZcRi3iXffG2-j2zGI-khdNYXSneQNggSIHNPSQDLSyR2pV-DbQ>
    <xmx:3yfyZcbBAnLj0gIQ10EE8DwJuzKysNk6aWs3TzP9kUmFrdon_NDQnw>
    <xmx:3yfyZdT2ac42Yi9s2bG3Gob_BC0c5GrH77ijeLtuhDj_-kXHiSVcfg>
    <xmx:3yfyZSMMjBmaiycGgpouxDpAVvZSHqEqmmOc4Rf0_nbrgMTI7DOhyg>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 18:25:33 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 09:25:31 +1100
Message-Id: <CZSZ4481T8CO.1QJYPPDQ24TS7@jamesliu.io>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] log: make the --oneline option work with -L
From: "James Liu" <james@jamesliu.io>
To: "Beat Bolli" <dev+git@drbeat.li>, "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.17.0
References: <20240313090841.36717-1-james@jamesliu.io>
 <xmqqr0geca36.fsf@gitster.g>
 <a675ab4d-7dde-4630-9de6-970f05225271@drbeat.li>
In-Reply-To: <a675ab4d-7dde-4630-9de6-970f05225271@drbeat.li>

On Thu Mar 14, 2024 at 5:08 AM AEDT, Beat Bolli wrote:

> There's also "--no-patch" to suppress the patch. It combines well with=20
> "--oneline".

Thanks! That's a good one to keep handy.
