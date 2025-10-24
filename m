Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844E22370D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287799; cv=none; b=dFbgnGjMiNd75ahPkBVNKSTOwPVQaSV0/QD7hCmeg8nau3F6NmCEmVUwbq4gX+OYPDmDVJ4KS6Pel6KeQovPhpQUrOeCKCJ5R+w5kGUknHhurk+sFaDL0h8j3ZPuikisADbzJ6f5vIy/afAFUN8nW69lomKKH0OhtqRD4kvd9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287799; c=relaxed/simple;
	bh=8ny7HcVpj05P8b/OydgM/RhHe5o9UgCxnK34zqi23qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de8szlwTMm+3tebWjg4DroA52dK6c294qgIrP8t0BaRuiO8P/obGv5VpliKiOK8rC4BVJpTEzhrwluKDm3CD9YRu/a7+SO8/W/Rz8e4gA+nckxO1Kav6dIITgxdqg47ObtohuU91ZjwcCscPWibEvgQQeQnY+T6p5irWM9j4mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bLYq2EGb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ycYYJ4+m; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bLYq2EGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ycYYJ4+m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D883AEC0271;
	Fri, 24 Oct 2025 02:36:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 02:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761287796; x=1761374196; bh=kyGEXZzWUE
	3GECEPvWCffX5NQurpj6BmEl0Y+ElkZFc=; b=bLYq2EGbPvmSg+A8o7vTUHdsRm
	B+qZHwX/WfWSQAm2RmKZKM0jGSL+++zLrut7tZjE5Wu6g3SWrxU2Z2CJD/G2tNet
	Y9OYVKjTmclYW5KXnRnxsoUyTxPtARDS/P0bw7KhC+HuttGuDLN84d2erulFCLfa
	fzfR4de88MSGP9EhD8z+OZzpPUosbirxkFqGWQ8GAmfnckwleDPWcVf4sCxXZ5Dw
	2yvRwnt6vSPtptYu6MQH/6lpfyvt5TO5vEwYkutM7i+oBLm7TMBt5BmqKWQuRQmy
	mbZeQescUF1mNycZDd6xmox0NY5zjxRiYs+NoXd6dpIv7pI1r4glpGspVuRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761287796; x=1761374196; bh=kyGEXZzWUE3GECEPvWCffX5NQurpj6BmEl0
	Y+ElkZFc=; b=ycYYJ4+mpW8UBn6hXuPRX/XzRhdkpAWCNDFK/qCQw4Iq2mLu5b+
	Gdbhb5F+XPxpNuNjoLRk+6NRpd3aTLPJ76b2oU9/Mr71SwJCai5WYIAUczDIBv20
	I/WneHy1HPgb8QpCb9Y3je5dq3n3HPTRCL3mqiRFzcS0Y08YAcmDWsKmQbAPqbSx
	hAsLB0yiXgsPbxMuAxNWTqu2r3NGlE5ifJP70QbzpwJ3yZXE6ILArdxghEMimzc+
	4pzXSmHbfyRyaI/tYtgDl04GgiyXsPgmY+ESPBwh4gREcEBgowTsm5nnbhgacwhp
	OqrIATq5i7dFFwrkLy+b9QRdY5jjclOsopg==
X-ME-Sender: <xms:dB77aA6WtszSt-UOpSNbC4ba-WlKk05oZzFRsLuh-hQAV7HEWSr2og>
    <xme:dB77aI44pRCtGzmiYnkZJI3H5iLxgzlbrLO9dBCMIaxDEPcYho-I9IUj6r77-XjTb
    Ep2wF_yosZdU3eo26ZXKcsMtEz2oKrQCTU4GQ0edHDz49GwIK9q>
X-ME-Received: <xmr:dB77aEe2-jt3iCEDOV9BRaoyt9b8qQGCsyFBdSbLQJscOfViRXWLnwaHbuqZ4OMHY8Erc7zxLTLduFBgDdq14opVeBQthc6dvqJI9k0zAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghlnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dB77aEB0Fz7G1reIzq0MSfniH0afMSDxvmWkcdxePHNx0XgVqpJahg>
    <xmx:dB77aP80r9p3B2r7ftuwoKymNkdFp0K_jMczD8SQjVX0mLLnrNxWwA>
    <xmx:dB77aHL44NGY6sgfax3o2pJ8Nng-GozX0Eci0zySd8h0T_NFKo7r7g>
    <xmx:dB77aAhIA-m5dGEw453thJs6BB-sNIxa1ayhyI79y50TrxbKx-mpCQ>
    <xmx:dB77aAvFnpOHuXcYxom9-s3A65rL12iqYgo3YsxliWxmW0Irga9Ky-OR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:36:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a68208a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:36:34 +0000 (UTC)
Date: Fri, 24 Oct 2025 08:36:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/3] ci: use Debian instead of deprecated i386/ubuntu
Message-ID: <aPseaeIPq29R1TZz@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-1-c19b61b03127@pks.im>
 <xmqqbjlxv6xa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjlxv6xa.fsf@gitster.g>

On Thu, Oct 23, 2025 at 10:56:01AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Ubuntu has ended support for 32 bit platforms and is not maintaining any
> > release anymore that has 32 bit support. But we still use i386/ubuntu in
> > our CI pipeline to test for compatibility with 32 bit systems, even
> > though that specific image does not receive updates anymore.
> >
> > Besides being end-of-life, this image also doesn't have all packages
> > available to it anymore. This creates problems with a subsequent patch,
> > where we're about to pull in cbindgen for generating Rust to C bindings.
> >
> > Drop the Ubuntu image and use Debian instead, which continues to
> > maintain its 32 bit port.
> 
> Thanks, this is long overdue.
> 
> Would this have nagative interactions with our recent tweak for
> sudo-rust vs sudo-C, which I thought was only releavant for Ubuntu?
> 
> I guess as long as i386/debian does not have /etc/alternatives/sudo
> we should be safe, and we also handle debian-* (presumably 64-bit)
> in the same case arm, so this should not be a new problem.  Just
> double checking.

Yup, exactly. Debian continues to use the old sudo implementation, and
it doesn't have /etc/alternatives/sudo at the current point in time.

Patrick
