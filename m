Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CC78F26
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638272; cv=none; b=qYmoFQlO3UECAZs5HkUYMZ1c1StVvQwYEFqDjyTHx9XBigxvu8NnHaLVHRET8Cqa+XdKLCiygrZM4/vC9+t9ifU7/Iiu04ynhb8tq9uiAnQHhYr3Sc4aDfdXjHffhsRXtDBM4+5OiS2GFsNy119xL8iCCeSbLA1EHtD+w6bCTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638272; c=relaxed/simple;
	bh=D+4Z7YdXmPraKsaM88XnRr2onLIJxEEvrCMGUooa/sM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNrMhPVS75l1lKkKOJY/OyjMvf5fvPbjJ2rPwhzfYI62dSGMX2HsH2QESdYgUPnTKesUMaq9V6A6ZZ1mVgcI02ndstqv0z1sjDWE1Ks3w/Mj14ZJF46i+Y47EIfksV/nmwGYFdSXnz22yrctoLkpHeh7HJ4IVeljhoy6CgJHWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gT7ujVGb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ukYKWuM2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gT7ujVGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukYKWuM2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 229881D00255;
	Wed,  4 Mar 2026 10:31:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 04 Mar 2026 10:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772638269; x=1772724669; bh=D+4Z7YdXmP
	raKsaM88XnRr2onLIJxEEvrCMGUooa/sM=; b=gT7ujVGbm6Gj4tnZxFFJVL5QY8
	q4nxwnl7+neRzVOyGjd7YsXiUG8+DjTxTOAYRGuVlLNCbTWJvL7KsJ1oqWPT0EtY
	won7RigaC8Wnlis4/lzQclNd6ItyT+lPMLQlRNlVXoKAibvOWxzHxoPJiwTOpLev
	VetpbHPp7DDfmss54bFDmkKcQXrygX+rI0Z9XR2eoL8DkXu1dH2kRIYSxNYeo9AC
	2NvgMnT4t/f2Cxrq3+aYMWRAt6gnIIxkGnKj/wpFIc/esL2375C3/GtgzrnUY5To
	eay1PI+qpTj8iB3o2IsknnilDQMlTSBBgR5YJdGQZvIY4OGjX/SIVKvC0eNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772638269; x=1772724669; bh=D+4Z7YdXmPraKsaM88XnRr2onLIJxEEvrCM
	GUooa/sM=; b=ukYKWuM2mGboSndI8mGqvyA0C2Vpwr633T5b3APtZJcKEf00/R/
	bMAXatA2P+CFIDVa9oM/ilx1gxQKXdPcDPhRiWhF/lvZR9bcej44slX/oDRcCZi5
	jI5Gcr0lqXrEQGRXkk5G2xzfDn94PeyJ45NjK0Zw8jyPegkiUtqH71yG8L/tFCTS
	R//vIL+LrcWkcqwdJbCS81SxvLC//rLant/7uYCr5ZTUFTif5v/DyUzFGk2tLTeO
	P0tuwpGKgT1da05pDCiugFfnvC4/k0I0DJndB2HksU6FmdPTHsLwdew/TTspw9nE
	vMnUkFBdic4B3vceRrI4xVYrz8+6kpedaaw==
X-ME-Sender: <xms:PVCoaax0yToYb1-41XBUTj8ZIdGFp1pzqrBW_C0TkyFl8PX46Atktg>
    <xme:PVCoadT1VyCpEi-Ug0Il3C-W1aw13PYOvzPmhMwUJThdmkIUPsFyWWsH1IX_zRfg4
    dgson1mNFzeC9S7nrRLosDM5Ta6bzxmjf9CM7NKJbzlV7nLGjKTq10>
X-ME-Received: <xmr:PVCoaRUxqrFI5Z5sxh275p9xahPNZV3RtbPsAuae-OikYu0MQihuDfbCe5MYpxXdoUSQJ__tkXxvAQoQiVE8-n0MnIn__XDbdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkuhhfoh
    hrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PVCoafbRC9zqO0njcHq0OvkWrtML2suAfAS8JrGn5VXsorHjQIoGhw>
    <xmx:PVCoaX2ftN8giTIpgFxoZFWjie8eoKo2CxCFm9IGX9Nurfp7fSkCZA>
    <xmx:PVCoaRiEBEMEcrhHdvvtYblSQPo4_j2z-q0fBG1azt1XT86zuhf5qg>
    <xmx:PVCoabbhpLXNhc2s9hxzxNZfn2rKP1RXmOiIhiz2nwhdzv_2l3Et6Q>
    <xmx:PVCoaY2jWAzg5RBjAtahdPfjLNbS4NIrq340Hu1qi8mstml9exkf5Q0f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 10:31:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] list-objects-filter: use
 oidmap_clear_with_free() for cleanup
In-Reply-To: <aafX6qva_badx_RM@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Mar 2026 07:57:46 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-4-kuforiji98@gmail.com>
	<xmqq7brtyids.fsf@gitster.g> <aafX6qva_badx_RM@pks.im>
Date: Wed, 04 Mar 2026 07:31:07 -0800
Message-ID: <xmqqjyvra9xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Agreed. But I think with the current status quo I'd rather drop this
> patch though as it may otherwise make the reader scratch their head why
> we do the exercise in the first place.

I do not think too strongly either way myself, but you may be right.

Unless we are dropping the "we optionally let you free the shell"
traditional interface, it is of questionable value to use the new
interface.

Thanks.

