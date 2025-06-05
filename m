Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADE20330
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159211; cv=none; b=IYf4+EIaR/bLbX5ZJxAHzGy1qf1dunTg8C/VDdNiTr5BhYOPRLb5wAzVqaq+ZRYET/0vvmqEUfi7N05TRRDbT0qZzjtxnSJKFn6rKgvfghCd20+ONNvi0RSQyDzNuPPUnSOgxzdHf+MRI7yfhxAY1zCLR74JHkJixmxA4MEfA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159211; c=relaxed/simple;
	bh=WlgJI4Q/rVLhLAAuMSx/4E/g+TqQRFjlQujYL1lzahI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6WCrevz/rw0TTlo+25cBedt4jytqMBTwiKaB4+kvc+NA4yAKBQHY8hH9TOQXC28hPlUUwYaDFzDlWA9p0PQwYGqF7BGcjc/6mUTogwkY0Mje4I5UT2p3HArW9bu6K0P0NT5gO15fO8UKzV15DW/DfCV0ahKpb3wSTZhvgIHiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l2/C6PZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mF81lQt3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l2/C6PZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mF81lQt3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D415114012C;
	Thu,  5 Jun 2025 17:33:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 05 Jun 2025 17:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749159208; x=1749245608; bh=z/XGg1Kcbn
	PhBvUxZ+mbcWcgdl1PT0UjEMMMiPJIVf8=; b=l2/C6PZ1eZ/9EYb+RXDJspPVzY
	ti1u38gTUEFApiylLgZ7dxc5IdL4cxhcVKi9i/TkAoMJz3DnEhlxgQYBH5NGvtWw
	MbXd443gxSECGjo8Uzzg/dtZ1WPMoQLDLIDvpviGuxSE4Ri5MNPV2q7zqmcmhC3r
	vz3zXjOlaLNMJorumLUm1Oq2pz/Xj+1iTwyWA93dDPCAyUS05LVk1JcH+2DJy+Gi
	LONg34w9M+woekN93AxojMXoMVz+d+e2GCM2HZ4CbLqbtaPh/7WhkIxD8MWPv292
	Qbp0z1wYQNR/TXLaXFk4exlgufICsmDX176bYDUXSV6quTvVxYKSIwVMUW4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749159208; x=1749245608; bh=z/XGg1KcbnPhBvUxZ+mbcWcgdl1PT0UjEMM
	MiPJIVf8=; b=mF81lQt3D0BQtSLktZPwn6/57L/YSd3oX0AXxhbgFNZSyr6giOB
	oFHD4/QlgueBh4oZTrB78tw9QG9iNKpzeT+URu2hHJxHM1xPXzgYdIlHxHVQu4CQ
	rjlQfCs4kM1V0H/PXsQTHnFwlciIQpPavwxuuDf91rHnufmAVrJgYWnPOauMKM0s
	/zHgIBjCYTJ/2Vb57vZU4KueP3w/RhQV1v1mMHEO8PrFuiX1WYPHwTehuHQKaUAW
	nUo/taeavg21meTZfxBhOomTa0zCXDvNdmwc+rVuRxQ2Qnt5o3vmWNSIt+urUYgw
	YgAjKBKfvUxZDShNyeXlAgHPq7zof8X1Odg==
X-ME-Sender: <xms:KA1CaPfoV58gRvXqySZwrMvIbFGf5iRlIHcjzQ5akgffb-g0hwkOTg>
    <xme:KA1CaFM3ZhEEkorsF7uaaToET8pG0bccMxKyTV6l6NAL3Au7KDS8NtGzwd7PLmOn7
    51V2uce8ED8KzgcmQ>
X-ME-Received: <xmr:KA1CaIh4HjBGGoonHsQvyceBK-HMsqM9xOnmdtB1bAzLKW2e74FZqR4DSdPLcTw39Yz980U4qcZ5faCH5gZKohWSRqSfh0FcgRU7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KA1CaA_uhi-I3HkSXygQC2quqavwud-pK6bCEnssxvZQv_CXROQr0g>
    <xmx:KA1CaLuabCr9o1Py6JjqPjV9VOzCHvtIZFz76IqSYQolbVn8LJWzfA>
    <xmx:KA1CaPF_jPJYlOM0171BgTRpzgIGcx86GplCx-1K29PSXxEUsAIacg>
    <xmx:KA1CaCORjuPW4XB58vmjnjqrdNLtgVMzT5iCwqQPQqEThVJpGgdHjw>
    <xmx:KA1CaL0WiDqEbzjZwYeMtt3Wd4_hvKHT9N_GC-LH1QKYlpSib7IQMsz7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 17:33:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: rsbecker@nexbridge.com,  'Patrick Steinhardt' <ps@pks.im>,
  git@vger.kernel.org,  'Todd Zullinger' <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
In-Reply-To: <f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org> (Johannes Sixt's
	message of "Thu, 5 Jun 2025 23:11:35 +0200")
References: <xmqqsekgn4gk.fsf@gitster.g>
	<007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
	<007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
	<aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g>
	<44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
	<010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>
	<aEFb0Sjj0Xuu-t7l@pks.im>
	<014201dbd658$4da75680$e8f60380$@nexbridge.com>
	<f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org>
Date: Thu, 05 Jun 2025 14:33:26 -0700
Message-ID: <xmqqikl97u1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Interesting. We have this in generate-tclindex.sh:
>
> ...
> else
>          echo >&2 "    * $TCL_PATH failed; using unoptimized loading"
>          rm -f $@
>          echo '# Autogenerated by git-gui Makefile' >lib/tclIndex
> ...
>
> This $@ was taken literally from the Makefile, ...

Good spotting.  It was right in front of all of us, and nobody
noticed X-<.  Certainly I didn't.

