Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E932561D9
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271012; cv=none; b=nM/HBJkNnk56RK9FcKin7zzMGQtW/l1pTxfkjclM1oI96fwZ1Q87L4hoSlPxbrC55VDzFttwPdgLd8K3iQrb5F6LOcFH9lyT+Mpls/CZItwc83LXiUVxOEx9bnTbeHzfuM/6h0XBPG6GrEQp3vL31dBqTgfoEFQzV/DGFeU/fIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271012; c=relaxed/simple;
	bh=Q8b0kzFftvRmXeZA2L+Bns0kU+CKsqq5yHKCBECPoi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqIhPg1n3txKQRxUAf3BAkW5d/u0/s28I8/Q7JFVC9+ew+NFfa3m0CZdyUPTrj1bXbrPGyq/hOMBK5gA2/0v1snttjT2Iw3F6S2yzcHbK1f5Ho9Bb0gr/tm5w6P16RxfQaQ2esdjsLkgTa2yG+tmASWjO64UWZRLzvcPkrckxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VWwZKn4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qen+abR6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWwZKn4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qen+abR6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 57B9FEC049C;
	Tue,  4 Nov 2025 10:43:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 10:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762271009; x=1762357409; bh=nSYnaFxKeC
	C/10wb7as1/lEeM6PP5U4kGFcswBm9iYE=; b=VWwZKn4P1OJ9gHHNm2ivebslLf
	LSFlBcrwyh7xNslaOecL5ir8J/SK0cczFkMY56948wy68KWgP/DUc6ct0stfqIPk
	1LhEp/xWRAhDtRgESmmkwt2KBHE+rTQ2o12J6jTiOuvweApUwSzRGrJav79qOHN/
	uN7KnrCEjkqh6+WbbIrb02MzQfYd7RGvSPS7/AWb1RNpnnINkNVjIjHWkkbDh2Fg
	iJWgXFX1GuyxyXiq4JgDG0rn778LYWItDVQANRP3sOnRmPjtp8vnnInFdo1WHPKi
	B+4kC9GfCLRCliVndQNEsltOm5xGXcEg8vdc6Ri4R/cK3IxsBDviD43goKIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762271009; x=1762357409; bh=nSYnaFxKeCC/10wb7as1/lEeM6PP5U4kGFc
	swBm9iYE=; b=Qen+abR6beru03dsdS83OIP31uCaSwXy1SH72oZbVgV3h3Olv9O
	0HhxpWy3KSSCxVN3RnNqTGVhwVyytwIMuFlvanURJtMUo3dBu8DlzG7nyXvmavSz
	b6WLh8tLWbfK6jR1WZ5SZYxYjygPALfjgEIhkjnU88urZXI0+mjRgVqO+3/LfYAG
	8o28XokhAfKC8dhM9t7ymmDoPlHqdEzr1Kf9rYbPPiGabvBnFjUFTJtKG7uUQXdP
	6qY5TnUCSVFpVVBLRxjWBFsEY/FpzNjaTR+sU7k6/c5Ek2ONAQmmMJk6/Gk8+dqw
	XkHl8qPAWL1AtKT2R9PWXIWsvF7b5w31rRw==
X-ME-Sender: <xms:IR8Kac4ZahXtqZsY4FQ8jfxhZ63GouWGkElRoFDNx-El6ZQk-H43YQ>
    <xme:IR8KaUz3cPo43Iv3gN5Bd8xOsmInji_a_1NeKktUoLlLtK8RlTzyBfoWLzIai1dR6
    rjjszuYtN3kSgV5_47F_j23-x4k4hcQgPgg76t_iGjeSUJBWXBY>
X-ME-Received: <xmr:IR8KaTwmaqVx-nCzMOW9CMBJdUaiFPlBRy7zYoE7FHzhJjpl19i95mFUpW6azRgdTCSI8WpW8F4eDySBuRmDmKea4Ctrsc5zGBVL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeeiheeuveffieejvdekgfdtveejuedufeekfffghefftdduveetlefgfeff
    gfegnecuffhomhgrihhnpeihuhgtkhdrphhsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:IR8KacxZfZmEGcAWnebOLIElmrUseFrCJWFaLClxsXICX9hRkhxk5g>
    <xmx:IR8KadZAMt55Q9ijU28aqp174MjLd1YxtxZ5i8JBA0kOwAbH7xOu4g>
    <xmx:IR8KadU46h47oQT2yDZbO0f5KxWe3ZaigSk3IwJKtwJVjrbsM8usPg>
    <xmx:IR8KabjYXgkhZTqC8Fy_AK4782u5R6NLVyRsgDMl4mrHuMj1zNa-Xg>
    <xmx:IR8KaQBz1YNOktJaQCRajdKgQDhWl6WTWWLDlIZQRyplfP58a-MkP0fI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 10:43:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2 0/5] maintenance: add an 'is-needed' subcommand
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
	(Karthik Nayak's message of "Tue, 04 Nov 2025 09:43:55 +0100")
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
	<20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
Date: Tue, 04 Nov 2025 07:43:27 -0800
Message-ID: <xmqqa511reg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This is based on top of master a99f379adf (The 27th batch, 2025-10-30)
> and is dependent on the following series:
>
>     - kn/refs-optim-cleanup
>     - ps/ref-peeled-tags

Yuck.  ps/ref-peeled-tags needed an update so kn/refs-optim-cleanup
that depends on it needs rebuilding on top (no action needed from
your side, but somebody is doing the necessary rebasing somewhere),
and then these five patches need to be queued on top, which will
require further shuffling when any of these two series need to be
updated again.

I expect that during the pre-release freeze things will be slowing
down, so I'll manage and survive ;-)

Will queue.  Thanks.
