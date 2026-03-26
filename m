Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94EC3F7A84
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527674; cv=none; b=Elv5YpJvIOC3+wt3vUZDKoqVnvY2YmrNANmFrpxtnt+nHT2U+PoTxPVRhCFi9WwXWnW5Gd+6d4sejlsCKXYFT2CJ0RpeemC3++XHKxIadzpdxRYa5Gunp4ia7+tUnWMXR4AOVaeT0jFkZ2KNUPYUTmBKzYmyIgrAg7xTecUR79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527674; c=relaxed/simple;
	bh=bJhU1h62Y7Kky65DdIOLczz+3MM08V7lXxfJvYAQk1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHn09KlivRctoKhR++fxoG2hCfEpz6oBUId8q57NYgsEWt5e/+igUFYEgbB9wgZZR09YBtMCWQKdlZ8IHUF4aysF2a7jbfDlwfmPq8lGBfzh3SSqdu8NRWkbj6Urnp7t47aADasaaI3fTXEJJ0wAyNBBCjI2roVfMbb+2cAjZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AJvfTW/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzKXhOaH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AJvfTW/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzKXhOaH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F22101D001EA;
	Thu, 26 Mar 2026 08:21:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 08:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527671; x=1774614071; bh=mwsQ7RmgYi
	D9MZTmJbpJJXA+PsEqW7YZG/yETmwmy20=; b=AJvfTW/oGw5h4+jdqdf27d1RCe
	ybivqckCxlPrpI+YnyKSEj2I1MPXACQqirAI8hJDUcGUR6eQL9eU47Epw2neAaO2
	V7WrTklUagBr9CGdJv+3BGxPtT4krj2U92//6DJEKtFepTMhxioxSSxIHxbjCg4V
	jXmYu4POcTUUccMWplXyCJjcXHbJgqruwC5UfU9wmZenqns+HXGa2vhMTw3xWZPf
	oapmKCsz+v+AwT5RGosLd8JXL9/JRt8ynMj0W8D0I7VkTkDIHWHXNQjy62Zh8Ai4
	eegFf4IqtNyG2xCVeu3LZnftk0udgoYFUaXvUJYUG/W+67X0BrOevPImKQ9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527671; x=1774614071; bh=mwsQ7RmgYiD9MZTmJbpJJXA+PsEqW7YZG/y
	ETmwmy20=; b=DzKXhOaH/KUb/vw22nGVbwDQtpfP0c/gcolJoO901qfRh0zXR7Z
	yx4+ChJ98QBHwSStrZ5hrboNYr7DUkJbqsgC6Hh9T51FRopOYhTfCo8Ej5MNR4u8
	uZhl6LjA94U1eePhcnAKWZxxBiD+wXkEayHIfML1jdifIS999tiQQpWknkWGcyeD
	gG+TeGYSptR8M5eGOZ2N3uf0Iba3YAZP0cGHsSzwedQadT7pYavCP2gHWIO9y6up
	mTPAWFUWiI4pguM4Ky+V04jbAasgz5jvLXUTCWGWT1KQnIrinvJEeMaluRnRto1b
	HW4stuWL5LN3EfndVCrjhJew7Zb9zc3a8QA==
X-ME-Sender: <xms:tyTFacSvYra0FANkygwfKaWOeeDm4r2mjigKKQRL2grzK9IDvBoxnA>
    <xme:tyTFacDybFG-752-Kqa_Amhd65IBL6EhO0e3omMFx2_IVqjT-SICTktOIQBDR_8R-
    tqK7WvA_V4aNUUPJMa7EF4H-NlDHAz7IEW1auNKPDCGZw2rRWBqvF4>
X-ME-Received: <xmr:tyTFacG3v8FK1Rx1Lc_GyDl_3BDt7bJtdzqo6WTGK8cBvkOQw1kDQySiTq5PGqML_4YXYgB6NekUhe6ZB7vThovn1lVCDTMisMonMh5RcG0PQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tyTFaWARVBD6up2TzyOPzTW5ZjZgRO--wOHHaWf8f2XYeuumsysjhw>
    <xmx:tyTFaUV6nAe-8btUdAqVN0BHf2NIh2Jkusm8yHQy_goQJCYQO7k-Ew>
    <xmx:tyTFaSptY7OmY3lIEBaBN4_5m225wKz-yI2NVhdAiH5SvWreYyvFhA>
    <xmx:tyTFaYSS-zcbHlqIyfGvZvpbFa5zcyQWjCZdDzlinEPgdtd-FIQMeQ>
    <xmx:tyTFaczaosoXh_N5dMOaKQf0HYODRTknqn8BS-zwBu9S-_N7Fb3ZZgI5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c4300ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:10 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 08/16] promisor-remote: remove the 'accepted' strvec
Message-ID: <acUks6pBmjgzN4M3@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-9-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-9-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:11AM +0100, Christian Couder wrote:
> In a previous commit, filter_promisor_remote() was refactored to keep
> accepted 'struct promisor_info' instances alive instead of dismantling
> them into separate parallel data structures.
> 
> Let's go one step further and replace the 'struct strvec *accepted'
> argument passed to filter_promisor_remote() with a
> 'struct string_list *accepted_remotes' argument.

Right, this is indeed something I was wondering about given that we now
effectively stored the remote name twice.

Patrick
