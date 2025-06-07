Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BF4C81
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749330154; cv=none; b=pmoXMb8+Tn7gldROFuIjwG3YPNL7jn6+AWQRdXBcQFj1Hf4umPguuPTU8mRALugKykg1vwIfCFxyDtT6btBOwAFt7JrKFssO3vBhECRRysjbaiZtJ6kMqWDawvHe2Sxm/3v5CZ7iNktdY2IplFuNmI3bJNrGy9Y5aX+PfaE7OKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749330154; c=relaxed/simple;
	bh=6OnU3nx/9Bf0RDU286VObe4caQx4LBgtY2cqld/gGU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UQXMBFcE7UNIQN8zEFhHQIKYV9TeAYOhL2qWfFLoapiTyVYcgZvNoR7cgjDkipoi+83vsvE7MdXfJAmw80wtZ9tEfMtRQSC3Ul9fqTmjSxKYfthIbqM56uOj/Q/Ch0Znw+IY+vQkLL0cMSSr45xqlUBszl6KZeuEizPPD07pYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SBfkEX2v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omuf6ip0; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SBfkEX2v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omuf6ip0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FB3F11400AA;
	Sat,  7 Jun 2025 17:02:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 07 Jun 2025 17:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749330151; x=1749416551; bh=6OnU3nx/9B
	f0RDU286VObe4caQx4LBgtY2cqld/gGU8=; b=SBfkEX2vH+5YJleBhrM/EQV2b7
	bVDgPmQIXIem3PE+jDiUDcl3RAVzkG1tvJ3pXfw3Pr70KHZ0/hdwobkeQf8elnWj
	1GcHsFNdUnB/p/lu1qcZboVcfg/gXtufoM8/KMnmZUQYqfhxgJw3y7oKococi2uu
	1uIeCB0S4eOo/V2CnfNtijGfD7iySJIBXZZvopHtzbzjR9BYt/mJpNQYFEqOZYG9
	uLAU3tcQrZdN6y2o1mHh50rbShj0eZl1EIhTtKdLaDQfjyQbdVi/tw4+zSC9i/bQ
	b0lCZgp+yJfdGbo2XVKLr8RkUnJPMpmmY7FLngk6Tt3kb1wf7/NiWGV0c85A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749330151; x=1749416551; bh=6OnU3nx/9Bf0RDU286VObe4caQx4LBgtY2c
	qld/gGU8=; b=omuf6ip023wSO5Ac8aSOkg8JILdkC5/ybTroUkfiRlsplKp7vFE
	qqwmrdgAu+zYEC9Dn7ZpWplzz3E1xDWCfs3zjHl/BZ4TT20zxcyMo+5X7lqo89/K
	IKRZIps5rQqxrA9YzzmiYdcHqalWvWaKC1KYF8gwGxKlrfw0zmokFw/nn8i3jDPz
	l1UF/yN6b7EZigAKinmnjvR6J2vMwYJxNonyt8jPI0qghSp84d2y1FXbFJZ5/KmB
	IOJO3U9atg4Hc4BB8+NxGC+WeRdQYfz5y4vy1PlcS+PxQ2DpxA7AqsXViLRuJz7B
	+nxwoj/0fJbzQeXG2lJYulxeDdXYGLg7dqw==
X-ME-Sender: <xms:5qhEaAhtnx7_6u52z5MRtFRzVOVomPXAh09xXo1fx_BtmZhoQVtKbA>
    <xme:5qhEaJC4LAF2H_wPr5WuUWAFNGBDGsTEyUiyNC7FO9QqNKR5QApJ3BN9vxJ4adXl5
    NBLbaddiZLLlpMVuQ>
X-ME-Received: <xmr:5qhEaIFN_KlFN2b18b8AWIZBjmYtSnmA4h7E2PoPClmhsFjaY4Ui5v47gb-8BS2zugKmBYo6yneJNIzEK1rxS-71YjqScuEP7FB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdejtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsvggsrghsthhirghnsegsrhgvrghkphhoihhnthdrtggtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:56hEaBRS3qP5JO4FLmNGkvCAGKnqriQ0RrL2_F6Wr4AbU8uezigTIg>
    <xmx:56hEaNyuGsINDg9MGA4-CeIWTxcW5PCtJgGD_gCGLUFsr99oGLcw5Q>
    <xmx:56hEaP63LBrtLuea8OlXZlYSdMhbcCsdkYkFV_Qc5NRTgUoXLUa27w>
    <xmx:56hEaKwcHqe7WCVI4bziCZYQqyKpsUf4I3Ukie6zJlrz2Fkfqbk0uA>
    <xmx:56hEaMS70EP9MoREUAvWlUpw4ANoyg3ByHGG0Xd8V2Izob2OxoSnXP5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jun 2025 17:02:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl*
 macros.
In-Reply-To: <xmqqcybg1orc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Jun 2025 15:36:23 -0700")
References: <20250606165718.HOiC2U4X@breakpoint.cc>
	<xmqqplfg1sym.fsf@gitster.g> <20250606220455.jhicNLuK@breakpoint.cc>
	<xmqqcybg1orc.fsf@gitster.g>
Date: Sat, 07 Jun 2025 14:02:29 -0700
Message-ID: <xmqqmsajxo2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This seems to break Windows rather badly.

https://github.com/git/git/actions/runs/15511228119/job/43672455770#step:4:92

I'll eject it from my tree for now.

