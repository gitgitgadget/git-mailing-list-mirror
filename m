Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350341FC7F3
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964707; cv=none; b=NUILN2QbKjjOtZkJniYYl2/GeiLTtkZ89BoUkkw+UeF7lMMmWEVzmasY8CE9gg96TeZ+WNI1S3ECpDx2c2w0lsZpHvcvnZC30GJ/T2QcPGHO1+1UyfcfNJr5fVERxHwKmIQW1wAGJ36vakjwwYsk/TW1M0pr0gI9hkfWVNzBWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964707; c=relaxed/simple;
	bh=FtEc4p/tOSKk4xkQN+8KAnqA8SwxgHTCb0AXsynsDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSLwGUaMbMmpLoOU9MTq1b+Rm9ISimTRQ4qakKjnBg8uWYZo4De3MM9cwig3RFey4TxDi2gioCIhcL5R8ZtecRXhy+S9TM048kwtYrtiANKydjuFjLb2rhtfFJIx85dFrh+0d1sbCpFiMcicn7SCR8cwyjUKRs/B6t61GKYmI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CvxRkeXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T/zI+AHf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CvxRkeXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/zI+AHf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18E9511401B8;
	Mon, 27 Jan 2025 02:58:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Jan 2025 02:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737964705; x=1738051105; bh=35MHbOjxt8
	PWvZn4yL8mjKNFvJuLWzVQIJ+fwqjE5Rw=; b=CvxRkeXeIcwJWOYggiRjMrJ5yc
	ncNkcKGlENehYECRYBorzvXc34ut8TP2hnYuu5xXJP1aOD5yhC84Bho6gS2A0Kjq
	fPH5Q/TpxKR53IKnPNe3BZUewGccRiwchW3C3Y7ILjVSsRfMU53yfJQNedfUn/fa
	RjT9Qlwg1svbFuAlVT5d18Gniqi5rH/OpNfSO4eGm+gLhuJitEYwgM9i/E2OffpS
	lLRbwT71QQwdqy+PkbktBvTBuyzJfjz+7TyL7zHZz3dBtvtfI0H7rj+szpcAqhqB
	H88mxKzWRguG1WtEIpMsYxlwjbtEDmwEs/hryFv/sS/Avcw0nxn+yjoSluXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737964705; x=1738051105; bh=35MHbOjxt8PWvZn4yL8mjKNFvJuLWzVQIJ+
	fwqjE5Rw=; b=T/zI+AHfO5XEd4PPoiCU8HupDxjdmhxJLwaa9a4iK9EZYOviEy/
	mjS2DRz9tTEpfOAMzqE+SIHc1K1Unt3eH28YzF3hyLnQujyHnzg2zIRoThK3RGze
	zBdvTgV0GFku2ILmX7xLWUCUyqFMRjZieM1ghYgHlsOeijfKmhnFOe0lWM0q8zUc
	tv9fetK4UA7xRvShW25O46QKKnaxv1E7H75vBflet6XNSB6W7fK4VIjukPYUyRom
	gzZtDh4DgiN4g5tPXOl5Q2kKM9WbsbH4rlk0G5qP0emvglgmKEyXqLq6nO2xUY8r
	mHzucTjDiXBJkjGMEOzjs6hfq908lx66n3w==
X-ME-Sender: <xms:oDyXZ8VOMeVvrpnIt7ADBUwBCX58d8a0A6ZFIhD9IduXaA2y9cLEjw>
    <xme:oDyXZwmkVZ6VMG42Ec-OZsPcpNiBliu_hPmjvU-JBrUJQ6-wE7HXmYsV4Jm21IPrk
    VT4D7x9u-W9QDtVJQ>
X-ME-Received: <xmr:oDyXZwZGg1k_xo-g2FS-YCBZc7H75FZjPf4QKbY4Hd3WiE3fqTdtOBcI3ChyZRKQvg-RHVWNkMC6QhL3P-pKcmCFn-_hxDZCf82edBNXRISr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeiiohhtthgvlhgsrghrthesthdqohhnlhhinhgvrdguvgdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:oDyXZ7WgORRVWQ6XQ0IPf31Du-veuzBLFQT9VZonaf6CL0aHdffJog>
    <xmx:oDyXZ2nPC7w7VkXaoy6aPrKKX4dnLLpUjVxfuw1T37VoHvUZ4oWSMg>
    <xmx:oDyXZwdCEnH9f6Q1WIQjKpoU8YSTe-LxBQED5IHcsxRI1QBSDrlv-Q>
    <xmx:oDyXZ4H4Ke9fkHkEU83hoRNlbT7V_OuwMR_6xfj1bVEamf5sgBLNYg>
    <xmx:oTyXZ4hBCLSkMZVw8TcMT7RFHSOye9UzGSrWjS7HciMTy_c2jGAPnk8q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:58:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1bcea100 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:58:23 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:58:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Reich <Zottelbart@t-online.de>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z5c8no4X_58AzdcY@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <08d7e79e-3a59-4163-be2b-97f0238142aa@t-online.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d7e79e-3a59-4163-be2b-97f0238142aa@t-online.de>

On Sat, Jan 25, 2025 at 09:45:21AM +0100, Christian Reich wrote:
> Greetings Patrick,
> 
> thx you for the patch. I build an own version of git for windows with this
> patch and it works as expected! *thumbsup*

Thanks for checking!

> But I see merge conflicts in git for windows main-branch:

This will be dealt with by the respective maintainers eventually. I've
already Cc'd Johannes for input, who is the Git for Windows maintainer.

Patrick
