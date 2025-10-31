Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816981F4C87
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890749; cv=none; b=LRt2JxvnwFTlZr41wkIn4eulEf33tpVTHpmVYPOhCybZgFPm+vN+YQhoUVeOP8X1zT3egek/Z6T5kd4u0ItTwEcujLdO+j2xaORTaPqNZcthHj+X3BU7TQoi5g2UDGVntrwkRLAp0/ezhu0AgMYQMwO5Yd/TmSo7zLU1KdfdXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890749; c=relaxed/simple;
	bh=X4xZHN11V1/FNDMabqL1U2v9cynaevOFdhmgbln99Fc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/c9PEhxii/W+Q7+6EvPEB2DAh9ERJMpoyXSkZjgQUuklHKkexWs1TJLP47a48RVPEw5x/xcMMW/olbYuglCBZWe13pUdnEVzORbTiyOvKn9RIRaHVrzaux1uPSbxTCxIf/GPYJFb14keifjzgj01VkWGIkorl7GintgraQpYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d/Td3U2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbBXlSLj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d/Td3U2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbBXlSLj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 569DCEC00C5;
	Fri, 31 Oct 2025 02:05:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761890741;
	 x=1761977141; bh=WMJCGeVHz0E6q+A4fYJRq0Shrc7//qtaTCK+JhAU4P8=; b=
	d/Td3U2teyS/phHBv8vrZSg6SUcMdYtCdU0NT+dJKvoe3bJU/PN5KCUGOx6HPwwN
	pGl4fL7hmxYrt8O2wh5OL6olzWfPVbYJRKjUTtv4kyKMf6jHoMjHGLuKRPxr/zNb
	bQkzCPuxJs8E8wv1pseOG4RjA0y7f3tPbQDWdi5wpjSx6GUOoMwqh4OYobLyg2zt
	oE/dPhR1bho95cJwNlqY8QSTxMwUCPxaro7ZUX4o+Z3i5VozcDiQl7fk4AcQ4YOH
	pHchQ7lG00Sau4UnCQCSWl4EcMGhvYHh6iSJ8l7DgO2O1ACU5YNATyGyv57U3m6b
	l4Tmj7P/1T5z9VknO+4KiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761890741; x=1761977141; bh=W
	MJCGeVHz0E6q+A4fYJRq0Shrc7//qtaTCK+JhAU4P8=; b=PbBXlSLjMoGCfmJjM
	D8WS7I/Qsk0cPsX354DQH8h48ok20hM4QB1JRMGiLqfdILXh2VLH/uHibG+h/wgD
	QHBifgUtolq12/o3qp0qGoh00Jhg6CyTJ8NRQXZsEGISL2JTAFwAuQyNtyx586sn
	AKSIEB/Q24vT7FuIoSatkdEaPQuDoHej2tQx4hXxFIg49yeZ07MtP7kDH14jBPxm
	Vacrdq310+7ROxxg3oboLMEQarKPa82vYge7N/LErqXJa34xnu9W4/52odoBFH27
	DZKqDR2fJiN74Wc9+JXOntJBjWulD+9t3IhhLAN/v9zaxMBkCzcm904AaYc0D770
	kNZMA==
X-ME-Sender: <xms:tFEEaaWu9q81McWxncR30Ff3fD02A23rbHysIQN7faWv2OW8Zc8v-w>
    <xme:tFEEadlaOwZKwd4MxfCPahd2UiJfGJwSAWEsXAD1F6TveeFGHi5k9J9kudD12yA4X
    X94HL9vjRdk6UWfA6ol067eKszwEkvPweWyusSpZFFBeL91OSLh_w>
X-ME-Received: <xmr:tFEEaTay2laStJGf6Ioo4CPnEQRx8qoZbHBjBxXA1fBG-17-ZnYma87_mO7-3gMVkdd86vVgDoEAFhWtB5zY2NsMcg_7zWDwaCVvAPiIz5j6AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephedvheehgfeffeeljefgteekudejtdeuueduveegjeehleetffdvfeelhedvheehnecu
    ffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:tFEEaQNzIm7MRNEz2eLBDHsrdqcNZcwyrYoedOPQPGwWLObVCY42hA>
    <xmx:tVEEaQbgBCY65-j1sM7_62QiQtc2Ly_S2yk75J4a8HEMzPf9v4Zkjg>
    <xmx:tVEEaW0Ud5kn8gV40O6ZUuruXrQtHjt_qTNt3isPnKKd0bz0jW9jcg>
    <xmx:tVEEaeezdDbRecOYeWQ8IKKGRliWIp72LwMvQld2Ysgn_3x3VenUXA>
    <xmx:tVEEaUJU9YZfIHbBHn1iTmuezcXP5IhJYG5UZMgLveC1ADzDh1pRlaq0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:05:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9557f41 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:05:38 +0000 (UTC)
Date: Fri, 31 Oct 2025 07:05:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQRRrvSoZQxH2-nw@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
 <xmqq8qgvfyq0.fsf@gitster.g>
 <aQM07BQrGJocPKea@pks.im>
 <aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQPbMZpYZJQH_Fd6@fruit.crustytoothpaste.net>

On Thu, Oct 30, 2025 at 09:40:01PM +0000, brian m. carlson wrote:
> On 2025-10-30 at 09:50:36, Patrick Steinhardt wrote:
> > For now that Rust version is 1.49, and that's enforced by our CI. The
> > reason for this specific version is that it's the target version for the
> > gcc-rs folks, so it may help currently-unsupported platforms to get
> > support earlier.
> 
> As I mentioned a couple of times, gcc-rs uses the standard library of
> Rust 1.49 since that's what it's targeting, and as a result it will not
> support any platforms that Rust 1.49 didn't support since there isn't
> standard library support for those platforms in that version.  It's like
> trying to use a 2009 version of glibc and expecting it to work on
> RISC-V, which was released in 2010—it simply won't.
> 
> That's why I was very clear at the Contributor's Summit that the message
> we must send to platforms that do not have Rust is that they need to
> port LLVM and target Rust that way, since that is the surest path to
> success and to being able to get the necessary standard library changes
> for things to work properly.  gcc-rs may be a viable solution in the
> future, but it is not now, and absent substantial advances and an
> order-of-magnitude faster development, it is unlikely to meet that
> standard in time for Git 3.0.

It seems like there is good progress in gccrs, and it seems like the
speed is picking up a bit. They also recently said that it shouldn't be
that complicated to move to 1.80 once the 1.49 baseline is implemented,
so that makes me more amenable towards picking a more recent Rust version
[1].

> So given that, I would propose that we target Rust 1.63 in conjunction
> with my proposal.  I can send a patch to that effect later on.

I might've missed it, but why 1.63 in particular? Happy to defer the
discussion until you post the patch though. I mostly want to make sure
that we pick the version with intent.

Thanks!

Patrick

[1]: https://lwn.net/Articles/1040197/
