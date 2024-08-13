Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B517A92F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541143; cv=none; b=G4bWKWMF71g0WD/k/x0b/7uUmvusCGOhFqk+uEGuXqKn3gWTweOz7ABJ/eBaaGzH54akdTFZ6snvOd9vGEBln8+0yJwxoW43RJmGHA66LtIRnQUev/yyYcXZd0CD+00yrQW0hcSetTElzBSDx+tNY80aVv8vIjv0Zt5EtDag92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541143; c=relaxed/simple;
	bh=IKsV6Xosl6H//ariSspeyq/e7oGtbNL43AgJ40WXjas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzsH4kqSEZ20e1zduiG3vPoza3VZzbHwT98SGHmdohS8k4BHSBzmkG2pOubLwhIpYwPao/gnFkT0IbONQ2H4gp4dXnRKU1X7Vdx6sQdXmC0+KJWXRQxTNttAPKlz0p4KQe3jQeblNP4TCZUfNlDDnJjYIHLICD/dHeTjFqe4lO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gPHcF45l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTm2AGzY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gPHcF45l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTm2AGzY"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2F251151B4B;
	Tue, 13 Aug 2024 05:25:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541140; x=1723627540; bh=+gOgIV7yPE
	caf1Ke6VwcnsKj6S5rk6ku/KjH8V+x3Os=; b=gPHcF45lHHVCJAvKcozC7CFDAX
	CE+YX51H646JP1URNQXdcJQcPZYBJGqdaksjtT149ejTEL9pZnCVKwKWzoSy7jyE
	sm2S+BhXNk1ldcbIXEcIhgdqN9AAItO8DrMjDm8h0aO6c8hohQ5nPG+zdvLKDkMg
	WL+y/dUweJscsIwhnzGSRSnDRRIuBv0kwgqoYwBb+eF7aA4u/kmjnXUkefVzeIQ6
	7MAQ4jT8o/ZN5tgYPIy4v12lkJvBRgDh2fuJ4KGMnfDE7zKg0j03RpfX89toLjyM
	LkcN5lmB66LCWaBT5GyVEt5L1yBfOrBxE2h5KPu07RG2WBlPHE4I+bIPSsbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541140; x=1723627540; bh=+gOgIV7yPEcaf1Ke6VwcnsKj6S5r
	k6ku/KjH8V+x3Os=; b=NTm2AGzYYl4m6+ensEQXytldLF+8/vu3RyzX2v4nkk4Y
	QK8NNk0GzxsGsOI7bglRmNQ8N4I/RnY0XceABBZOr4/tTY45kdQ41V3XbO3pUv70
	CUdOQtIQE5xPuysCExPd28I4UGGo5zWMH/WcpuGmGSsp4fnXk6+Kf6zMCWmaM0D/
	hcZZtPGXELYV713ARvDJsk5jTp/j8aEE+6QQafBdx5An10uJ4wjiG7OelaSYdZDm
	DVNjQkiEhs/R9IPtozqe4MDHJXLMbEl2ncV2viwfXrq1y19U26a+bdp5cpkH2xAZ
	uKW17v9wYAvzSU5xfDCOLynKHz2VGtHjVIsgx2LYcg==
X-ME-Sender: <xms:lCa7ZhQljgSv0DypZhk-OmDgU-PqxTh3zxdyq1ziVTa99ROoPLWFng>
    <xme:lCa7ZqzdO3S_x7UKinm7OUgmfgKsPFaPKbjFkaetetV05SBxoEaC4tvQ8j77coCE5
    cI7Hu5UoYFQE0JVWQ>
X-ME-Received: <xmr:lCa7Zm1ClsADtsLvE60ZIcUQ2D0gei3moZhzEm9RXlURcGNmvG_1NnIeBXBC79DMmS75P6jca8iQIlJHRmJW4JAPUa4bkPP6eDyWbjOO-fDS7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lCa7ZpCiBwfloX9zFAs3lL-6XY9XGs0wU_tVp5UJeE1um7fw2GF1tg>
    <xmx:lCa7ZqhbUdPFQHGTL6oJAaBvkLgSG38hhFN8C-vv_22DbD5syr9OeA>
    <xmx:lCa7ZtqSw8HImOT-RFnyhzk1TFQseDRzfvVFplHUTDScjNg9S_LCOA>
    <xmx:lCa7Zlj0yhWGjVRc5cq9KwfhDAlfxEP6Zon559ZzJeE7vhxm4Dz4oQ>
    <xmx:lCa7Zts1fRnwRdgW4UrKtoAgkIjRChmb39sVibBiIljS8ipxuKg_zjPQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2477563a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:23 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/20] path: hide functions using `the_repository` by
 default
Message-ID: <ZrsmkrbGYtfl2Mnc@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <b4e973a2804ba09149224a2e18a359717228607e.1723013714.git.ps@pks.im>
 <mc4omj4mi23fhmqp4xeafcluzf2iidp4uaf3h3gaxcalm3igvk@a7abzjynshfw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mc4omj4mi23fhmqp4xeafcluzf2iidp4uaf3h3gaxcalm3igvk@a7abzjynshfw>

On Fri, Aug 09, 2024 at 02:43:59PM -0500, Justin Tobler wrote:
> On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> > +# ifdef USE_THE_REPOSITORY_VARIABLE
> > +#  include "strbuf.h"
> > +#  include "repository.h"
> 
> Naive question, what is the purpose of providing the include statements
> here? Wouldn't they always already be included?

Not necessarily, no. Most headers only have a forward declaration of
`struct strbuf` and `struct repository`. For one this means that we
cannot access the strbuf contents like we do in the function definitions
in this header now. Second, it means that we cannot access `the_repository`.

Patrick
