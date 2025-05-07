Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA102147F8
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639568; cv=none; b=PtUCo+/TX8pyMyKKd9NP7hUUBJizwNAdbuuX5mBXhmiZ99enF9uVOWIRfoGVVFliMZgQAn7sq0XYaco4JrJqjVuet881HN8wjz1vaDiJKpDjHtbXB7+wcObQwaUav8Cr0l6o+KQTbuc3QIx24bbo9UVKAyRxz65USBo6KhoMKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639568; c=relaxed/simple;
	bh=bi4BMgdVAthBtL1CSU6FKIVHKCD1O5v2YLlkkvxkE68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwf2QHME9JXUcScflb6E+xTJcj4Sz+Kw5v000fyEqE3WhrYJtOIPN/wGnBEdBPuKZNdXDkrfkTfKye9mmayyW2J9BjCWNJaXpnUFP4iw3dYe3O5vJx65pJ/O4NVUO9F84RToB/82mIX3OiWJhWdZTRrlukTGEp+uiyXgxFZRcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T4k62J5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAE154jg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T4k62J5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAE154jg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CF3C1140184;
	Wed,  7 May 2025 13:39:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 13:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746639565; x=1746725965; bh=bi4BMgdVAt
	hBtL1CSU6FKIVHKCD1O5v2YLlkkvxkE68=; b=T4k62J5IU6ZJ1LztXG5x8dZLDU
	wNhq1PpGaiARiYXOQvLtBhHm5GapeI6BkC4CIDZOj9WDxpnHDxX8d1Vh2aXRRbqT
	HE/V2qNxhR9GSCyQ/oNnqHs2cW9kAUihhYV27YYoiQTQmX+Sb2474pIeDaPVW1Lp
	WI2+rUQLX1wtatBP7g8wXfvMp4rxfPtij9Rjrx4aC1KLm+4CsLo1l+FefNX3Hs7X
	d/RzciarhnHWECmBl99QPfL5HDwx4PM1AChmhA09oBjGewtEzMAsXK61moAw9EHc
	9+d8l+nFKDbWYUY/Nl0Eeq9PSMc9787u5CFc0PNFxBtFsBio/lPVz2yt/RcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746639565; x=1746725965; bh=bi4BMgdVAthBtL1CSU6FKIVHKCD1O5v2YLl
	kkvxkE68=; b=LAE154jgWJ7pw43tVGofXVD5+ikRcJ0DzK9blGETjCa7zyR9VNJ
	QAW4xv8FLbAmjoKnmszqGFaSCFN9AT7F+aw5PkKkbilj1Y8ktR8ws8BmYPtadm7H
	qJdHS/TscfTcv/XQx0yk1g4l2i96+ALQ/bbkTBB5DBuFTmOWwD8UIpSke7ZcN32B
	WbxY2K0bfwROkgA4FG+Vt18gOvEmOEFj2ge00NjlkCx92LH4HFW7Sy6uMp+bx7wr
	mhsoJeQyVPiPBpJeh63GW6BMseuEra+DkZcIC+0qgYc7iU4PILsW7SKpYAZg0DhU
	wfHIZzIzPvA7/5r4WdNUjIQ8m9CQoXzXx7A==
X-ME-Sender: <xms:zJobaEMDLqcfl209TcCrIZxJxw7X9hRDhn9No-8EfrL5B1QedgYtew>
    <xme:zJobaK-xP-nQI8xHbX55LXuphjZXz66k6-FrXQAbG7aLqmjsv2o-m8jlzhVGFK0yQ
    MdlQdUeniXsYmv_xQ>
X-ME-Received: <xmr:zJobaLQ5dhBIjaCPyjrAyh9iIWT6gSeL3o4EEtLHyIJhG7TqXqsmvRfSxJVFwbJK_6Ocz_fVzDBBlGvwwRJLmR3vLM454-TFQAZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgeslhhinhhugidr
    sggvrghuthihpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zJobaMu1Acm5CUEReQDZ5Hl5akQf9LH50qki_OKsS9Rt5cW4v1e4tg>
    <xmx:zJobaMeNdvzJV8VILNHywxkCkRdduCt0go14jQe5HITOBSb_TstOug>
    <xmx:zJobaA3ENcgHK95TC2WHDfy4XSTO9-11rB50KScAQYJKOVdqvJ521Q>
    <xmx:zJobaA-5oQEc1damTjW5m2fPDiPZn_VIWB9fRCf_LujnU--HBjE5DA>
    <xmx:zZobaFUGd7jEFJAcbKIQ9DDG9oNFsI4pcHKo--PSYZ9wTO8unLFLoXal>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:39:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Li Chen <me@linux.beauty>,  git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
In-Reply-To: <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net> (Phillip
	Wood's message of "Wed, 7 May 2025 11:17:33 +0100")
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
	<196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
	<xmqqv7qdk3yl.fsf@gitster.g>
	<196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
	<48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
Date: Wed, 07 May 2025 10:39:22 -0700
Message-ID: <xmqqselgcoc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> .... The existence and implementation of
> --signoff is largely a historical artifact - I'm not sure we'd make
> the same choices if we were thinking about adding it today.

Very well said.

> I'll take a proper look at the second patch tomorrow.

Thanks.
