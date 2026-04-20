Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D933A70A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701209; cv=none; b=kLVc0D/RCpOYDXuyRt32HO25H/doOSNmYo4uyZKvyTO4ZbbsjcB6RLT8teXE/ZUqbihns3s8tpmASEz/oDmtZNKZ1VVquS7jt728RAZStr4YZZk+uRgltkG3wc+i7AjGN0jH/Zl8SQQfGnHj+K0om9ZHR5hwjXyfHgdE37NToXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701209; c=relaxed/simple;
	bh=FB1DlVLwYCK/xdipwYVxI0wXBYZzXw0uuKrLed5WYe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZRn7UZKQzdybcq8YFXOPAGPsBJ+BB6wR0wwRKrz6bqnh1h7Wv2kVfngaf/FJ70hh29XH8d2EQlLCekIVehdNGjOj842d32lzy0obOf6kRCW0ybGLRxnvjOSPpGenamwETIG/3mjM0bZ2FXVHwCx8OWfy/cMUzcwNW6cVmlfVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xVsOz4Tl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phcs+IuU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xVsOz4Tl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phcs+IuU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 964F4EC04A7;
	Mon, 20 Apr 2026 12:06:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 12:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776701206;
	 x=1776787606; bh=ZZYLedz9IG/Z26ci7VV3rRZ+K5EmYuJbbJXnI80TWTI=; b=
	xVsOz4TlXT0lkFsGZdgR2Q54aCjwGjfwpT4In3cI2rMvaBTFbANTZu69cYMOwqJ1
	4Kkhc1JQJcHbc6A6WnvhShfEJxNzTjxnsdz7jY3XDd4AcXyNcwPLi5tczUK5tfVe
	axwM+bLNC+vTjpwZhbXycqpHDjFUB0Rk24aoB5JuCNSaQqT2wsAumIHE71PWJ9m2
	OLVY+PaIKwTwNT6dHBWPQZhEu/4pKIc4jqfjrPeUyocFvxMOXDjoRuPOAHBG4iVo
	NqjMWZ/fAhONkyZzRe9KgJlW/F+zHXrOriQnQ5fRmV21dTpmEmBVt05aml0sGab8
	ofhXu2oiDb9kkyU8sEYLOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776701206; x=
	1776787606; bh=ZZYLedz9IG/Z26ci7VV3rRZ+K5EmYuJbbJXnI80TWTI=; b=p
	hcs+IuU+xaDCzUwMhGCozj8yy0zWiYWiE9RJufT3fXtHgdq//wEoBG6VNzyausTp
	2pnMFo2+f4uVpmMEf/ejv3exDMyRbxI9iFk1SAfpZaPajakzl2lbozHwFnNx89sy
	yR+9R89tiQ+eCIbsSIK8C1yCTYwVh2LOCqw/v0a39JRWVvWCPVB4aqjmKjTHFeW2
	pgpFGfD2xbEy5RmTi86Ch1UbNB6mr9W9uFEg22BJa9D0h2KdNZTztyJMetPQ18Yw
	C5oh4Ds/hltYhWKS5An29YkdomKEZu2PvIl4jSKvETa5A9jQM48D/AiwhG+bH5xf
	EIuqcCWErfwnObC5qMVug==
X-ME-Sender: <xms:Fk_maZ5H9dIBquXjKpl1uG7o0pl-fCTRSL3Ak0msfk1_7SpnRwnjaw>
    <xme:Fk_maZJ2PTlwY45lM_AOed36Zts3SL75AFZ6gOdor0kPIKAUWQ-OeFWWKFnCsT04i
    F3GDSe4HwpVBL9l7lLzQ2Rq-JZEvQwC13Bvg-0N-O1pnWsGxyI5>
X-ME-Received: <xmr:Fk_maSuEjm2C0RJkntOS0WoxH5eLUrLXLfJsN3ijpJIp1sm4OfAdpY1O5mROZUv6OcXeoCRmu_LI--Jmv3Sk-Vjmc0bnrvZAEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Fk_maYJWwGAfxlJwCOwCTYgVdMOfcrV3045enL0LHjJ-83pxPQjAGQ>
    <xmx:Fk_mab91KsPt-o9vDX56J1sHaFP8e_KG2To0W3UjXU06BlH3e4NmCQ>
    <xmx:Fk_maRwcP78ZZss511hQmrtX3jcDE5kcZfmu32zFF4MqVwUS57dLuQ>
    <xmx:Fk_maY57ysZ820Jm7JRyTwjPUQ4fkZ1uU_ANwfla5fhbofICSBjVEg>
    <xmx:Fk_maW_vB2DNDuZKzUmEElfdNIaqbAq7CUCxCgeqfuGXdg2hgPdC5_vS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 12:06:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
In-Reply-To: <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev> (Tian Yuchen's
	message of "Sun, 19 Apr 2026 02:20:41 +0800")
References: <20260418164736.2367523-2-mroik@delayed.space>
	<fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
Date: Mon, 20 Apr 2026 09:06:44 -0700
Message-ID: <xmqqv7dlr4yz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <cat@malon.dev> writes:

> I think the space complexity here could be reduced a little. After all, 
> since we’re only retrieving a few commits, there’s no need to load the 
> entire reversed commit history into memory.

Does "we're only retrieving a few commits" come from the fact that
the command example is "log --reverse -3"?  

 - What should happen when you give "git log --reverse=before"
   without "--max-count=3"?

 - What should happen without "--max-count" but other limiting
   options, like "--author=Tian" or "--min-parents=2"?

It might be that the right way to look at this new feature is not
that "we are changing where reverse is applied", but "count limit is
applied much later than usual", which may mean at the UI level, it
may not be good at the conceptual level to sell this as an extension
to the "--reverse" option?  I dunno.
