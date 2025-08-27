Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC811DE4CA
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326161; cv=none; b=TPU0qBmiMdPTlzw0t5GtsnKZDM3kNh6hfB+b0ImL4anc0juYvA5IvMIOKB5FHRSEJBADXfJezEoEzdi3cEUjJZP9vALKSFUmmMdNwXgCjyL0RNNx6i795DgO2OnBU94zQXIejRT9aeKalYYMIaaTmIAivWfFtd6NSvTU//l8IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326161; c=relaxed/simple;
	bh=LxaugFSOG8vnvW2p4/9VS537aVJI+j9gAE5eOxB9X7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nII+Mmpqp+8ov5ia2Ql61SRMCiiC9OJ/UVbUFIvpgNhwNImhkqmDw65cP+duGQLMFNTR+QvHaSJSFT9L/BFhLEuEMubT2a/QPxwoTRzKl2MbTkgA2DpJBSmp2EEn3K+dSW2GXYkteAtFM+DeBc1SuBo8paKyeBS12WnKSGvzyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VhKCWy2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YrUBZB5U; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhKCWy2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YrUBZB5U"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 41AE01D0008E;
	Wed, 27 Aug 2025 16:22:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 27 Aug 2025 16:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756326157; x=1756412557; bh=aHKH0ER9mH
	boNIRMzdUP4VPVZwO6Q8eoIoLcHNBZMQg=; b=VhKCWy2aWxHhLCFYfrIAmSlvbv
	9DWrdVgfit5wJpwktCf/lbUfZPRf631JRjXz1LJCBQTkNm23nXB61McpzeNwlHsm
	TDeNJREuL2zUZSR4p+9MJRy8MW0hNJoSP+d4Nu6O8YBaszTDMP0kvB8VMXT3ngkE
	0uGae4gWOuO/kuNJ2kMvmho7TqpwXxoqSvTaW8rVpVnPMkLPw3Q8alr+f9hd4ISD
	Iu3nP9SKU8iznVFKAUmnISR1bUim5yvpX6dtPSEd1jMZMuPbDFFzFG0+Gzv3aYk1
	zCfnOVp3NVgpdF46J3WCyhvH/Y8HS8ZQG9AhW6FEaHpmCbzIEPtVrOFEeabg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756326157; x=1756412557; bh=aHKH0ER9mHboNIRMzdUP4VPVZwO6Q8eoIoL
	cHNBZMQg=; b=YrUBZB5U4Ddf/+tX+IYRURKo7s+ryv4M5NZurdqKad/zm0vEVbq
	V/HwVI/EXLMe+fPIKOJkSKapNtb/Hsi2ehzEtP8hzFnmJQXamuGdvjixBRgA4E3A
	wmw0NILb4DVgjIuaLv1QiMQrSp0KuUdleL7BtBao7beP4fPLCgGgoBgW59z/hOyM
	Fl0MgsC/1yEdTxEwS8dzp76OnwuI4QNfvybgUCaNx+BN7OJOEq/6I5YslXM+380x
	mu2w+RA3iMXQnuraNQXF7FjRCJ6Ln5tjIrC13qKyRKymD06YOcA+4deGT/7inOnb
	CGvq9nBdfzH/3W7GsTQYozpQTZZVakcXr0A==
X-ME-Sender: <xms:C2mvaKfGyxiM3WtdDerWcdPTMKa3UUT_808Rvq90tR3g7RANbC-e2g>
    <xme:C2mvaO-vXe-elTeuqh-W4Fs2or_VURsGMu43pBlA5GUbtQDVAPTcgwpGjS2WWWKtW
    1LGM47LiiT0BvosqQ>
X-ME-Received: <xmr:C2mvaKZy65XlL8_KNQGj917VJpE531mOX66Kmf13CqAibuCBOOvBdKiCRmJfzutNAn0DhNbiJ2QjckZbOUbshPisa4tJBE7i67m65AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:C2mvaOtNkZ-F6tcmTLnPlkPSNqlbBsdAq7-3KI5FC3RMQl7YM3cnyA>
    <xmx:C2mvaHaWremnHKUJJjlBJdSPkBwc_ntEEkF6Td7qHLIBVByTGSMgOQ>
    <xmx:C2mvaCRUnMUf31KgjyXbMLMnLGlAs2JwvOYyhTnHNiP6WhPeeFEjgw>
    <xmx:C2mvaCw8NNLkk5pakWQVNhj_08jgPLXVweJjEKXDLYlwJVxmU_CQSw>
    <xmx:DWmvaCtW594o3QmpIyTtGCULKeWcVao_bWqrKUverZ1VVtBPriJ2gyEj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 16:22:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: rsbecker@nexbridge.com,  'Elijah Newren' <newren@gmail.com>,
  'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "'brian m. carlson'"
 <sandals@crustytoothpaste.net>,  'Christian Brabandt' <cb@256bit.org>,
  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli Schwartz'
 <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,
  'Patrick Steinhardt' <ps@pks.im>,  'Sam James' <sam@gentoo.org>,  'Collin
 Funk' <collin.funk1@gmail.com>,  'Mike Hommey' <mh@glandium.org>,
  'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben
 Knoble'" <ben.knoble@gmail.com>,  'Ramsay Jones'
 <ramsay@ramsayjones.plus.com>,  'Ezekiel Newren'
 <ezekielnewren@gmail.com>,  'Josh Steadmon' <steadmon@google.com>,
  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aK9mx2XemppIaKVI@nand.local> (Taylor Blau's message of "Wed, 27
	Aug 2025 16:12:55 -0400")
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
	<030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
Date: Wed, 27 Aug 2025 13:22:34 -0700
Message-ID: <xmqqh5xszf91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (As an aside, I mentioned in my earlier email to Randall that I have a
> suspicion that Rust code will have fewer security issues than C code,
> and so the likelihood of needing to backport a security fix from Rust to
> C seems lower to me than having to simply patch old C code. Time will
> tell, I guess.)

Just like back when scripted Porcelains were rewritten in C, in 5
years, when a lot of the existing C code is rewritten, who among us
would care to backport or "simply patch" old C code?

This of course assumes that these platforms that lack Rust still
lack Rust after 5 years, yet still matters to the users, and the
vendor does not care to support Git themselves.  Maybe one of these
three conditions would change and make the problem go away ;-)


