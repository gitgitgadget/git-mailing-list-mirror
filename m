Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5C7DA66
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715479; cv=none; b=UrK1ZtKlZYVCbjxQ4cAPPtyj+3Gak+R2TQukZBzhrJ3GH6sQNkrnfhbJ+eoQCTZ4y8jdA24DwvoG2K0oUXTAFozOiwd2tNr5ZGRTDW+mWt2qtkjrbMlVsAIl6w1CKwTEPBw1u4CbATrUCw4+QxpHfGLtZdVQmM95tvAPQcpxong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715479; c=relaxed/simple;
	bh=VxvIKvRHad/vTlH7HTG+4nmfl/6HPLv5FPhqkp5seaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAH3nd3K4JAbHwwXiZ0v4+w8+8al8j/9pc5OmVo5ZQoxq365iGTxJogE20ZP0xqK0H+MNGazVDWef/tWqajEFFrgvpPRj22iGcoMvp0jIsyCgnhBoqfNnYQuiPpqoPwD7PXhCombdMFdlZnvjWNrjNn4ti6IqcXTrecXyCvy4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ehbhcm1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO9HNYd7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ehbhcm1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO9HNYd7"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 179A11383375;
	Thu, 15 Aug 2024 05:41:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 05:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714876; x=1723801276; bh=VxvIKvRHad
	/vTlH7HTG+4nmfl/6HPLv5FPhqkp5seaA=; b=Ehbhcm1b4VviTmLtz5XnG9ND1B
	zD9+NV+Ir6lFY0Ef29HLY+YJSC92qSptwBRKgQrpFdKqbeozBZQS/AV3DzDZK+So
	Wx8dBrysmMESf/FZu0FmTeLLJJ75wfX/1ebLMYdlohu1VPF/wXiThpLcSG1iyw4g
	7VaT2mA5CizvQVnaPD2BZ8fSayrnr2Rw9lrBXBmHiGy/3xXP7rhlSmgt3XVEiEsW
	NNiLGIoiiKVRo3OTLOEOckiALKr+CAmwSnOBSasKaD0ozxc0EGSmdiVhY7L8V7uR
	TYA3IM7MOwHD1O0pmvk6EQbGR/0AdIj1JXgwkbbEXom/mO0Yr3E+vAT+sq5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714876; x=1723801276; bh=VxvIKvRHad/vTlH7HTG+4nmfl/6H
	PLv5FPhqkp5seaA=; b=cO9HNYd7T+Fth26pEXXVo9k+hcC7DFB8aZdsIYxnsHIW
	spDHPkHziQ5Hji5hPGf5y+ZESZsNQpLgB3HxaKln8Rgi02dF9apyHn0yqhjRlSU6
	TyVrvlPAyg4B4k/RGeYuhdgHgUGbSWi0xM0S4V1+xYDOj43T2nYmsLHxbdVf2gLy
	dD9x+JMPcdfshSxYey0QpT4Cl5SMBkX4uPAvtH5DoWhJEZ/4G+cb0UX6f90noKs3
	Xle4y2xFAJm4whdoqK0uQrR6fZ1UtDswTDQSOa76yFutduz9gp9OZeD2QPz2YGoh
	NCfyuSFl9xDmGWiis9y0kkxrAIleFxN3rswDsVITpQ==
X-ME-Sender: <xms:O829ZrmbXedyqfw9fh5Wj5iiFj1VAnkCY_RMehx73HbOySZflaEXqg>
    <xme:O829Zu2fReEt0R86iM9p7vWQVwSikcavu6gpKR5kaIu26TUsUuSlzQu-61r8l6Y1_
    ndSm5V0BJ29ZjzGCw>
X-ME-Received: <xmr:O829ZhpeMGTaVt3qmhockBsg26psuq4eE-D-hdU5k_SVnry8I3An-g8SmReMGiIzUg8rbizMVd5xZ_irro48Jlkd2bNaT7HfZkx08VHBBLf1BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PM29ZjnZ_q0faZmx0D3miDF1feXbFMeu5sWpMoyB_vZhTZXkPNP_HA>
    <xmx:PM29Zp13e_eVW1IVVEQeXYI7oA_2N7WFG0_UgegJOR9h-jZfbpMVDA>
    <xmx:PM29ZiuYqzgEneXsnl3aVNc8OVUH4VIOmC5-Eg9lH8AiVSTPLY9QHQ>
    <xmx:PM29ZtX9B1An7Yox8r6nEWQfOAnARjGULNimxq07fIBE6IlZHzFeRw>
    <xmx:PM29Ziy4gHpHnTXb65bGlhXb4CfG2NPMudLG2wTArbxubAA2h1Jy7CF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:41:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50e7d65d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:54 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:41:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 10/10] t-reftable-block: add tests for index blocks
Message-ID: <Zr3NOUA-Ok0wKodL@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-11-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-11-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:18PM +0530, Chandra Pratap wrote:
> In the current testing setup, block operations are left unexercised
> for index blocks. Add a test that exercises these operations for
> index blocks.

Again, the same remarks as for the preceding two patches apply here,
too.

Patrick
