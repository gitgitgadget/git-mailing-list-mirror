Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F72236E0
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604501; cv=none; b=H7oJYQ8YFKVeoN7IHU9MfhCGbhFvRk5QGtO5iUrgL0QPFV/WiwMsxiaknoVRYde9S75DaXB+IiOPf+oRTDiF7KTDR3wE+YDtHP512sszv25I1FrfRczmxAH+XmKUun8HhpwuYroOAr1vTjbztz3zLmbdRTLnhSAcw4KMrJO8sww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604501; c=relaxed/simple;
	bh=wx5kgPUfvm1DHSg+z9PbBh2J1WU6r2dPpIaBfhpNUnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJelWn9zNdWjKqVEMYBs9AUNHmR3QkDnzpnIStvHZehNvZC12jCMM/T3pGG1BvLgWI3KsB2t9vUfBVU6H+KQprPYQ00XOpZ2RkF01BfT6R3ma3Ni9Uk34kgcHCQd513+/IS/UgNUqwjrG0XlIgZeUoOZxIAvoFhZ6ZYfATqRTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=og+3k34s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVyjuzNN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="og+3k34s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVyjuzNN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AF2441140124;
	Wed,  7 May 2025 03:54:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 May 2025 03:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746604498; x=1746690898; bh=5kEzObZdVb
	3zQEeg6xey49kmdgFj5g8DQOemladjpZ8=; b=og+3k34sXgAyrT20sVQLQsqs4K
	nvVb5WjkPxVcUfcrsARiYYJSULdMDPHx5u1yo3ef6qakxn/+QvDiuYm2kMF6yTY5
	tZQFaoYZ9j7AWUeYuDSwIsij7RDBWy6wl7SRAinTA5eUolz0HhjfeECF8hK9sgI5
	yjhu4P4D0B+02P1eIzphPrYJSF2PrhU3ePM1fdZ/lKCwZAFr1+ppG/GTXFR4+9If
	w2YjwDiPMiV1KoJaopwaZINfE4dYVP11q4nWr6uY8R9PxKiKdR4nIEc/efol+Z6c
	lpTWDR1+hqzjKJ3mUsAOUaZrgHj3isiTy+O8f0dtB9lD19IWHsWH+GoxMFDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746604498; x=1746690898; bh=5kEzObZdVb3zQEeg6xey49kmdgFj5g8DQOe
	mladjpZ8=; b=OVyjuzNN2ujWU8k56PcRI4nhp+BWM+5BKp6aQdhtTpxyLxIbmE7
	tyXsIJVvBMXV5P+BTO9dqNf1gQGeqeFFhw7v5rpVQwZBjhUVQ7iAce5ObvGLWwcA
	AKVjWhH6vO5UaSweVIYxalcJli/VwD+CQ+Y90wFCTKBjIuqH3lZ3ZCr9uWIq+9fv
	C4H+T29iOpRMFn4vwK45r3vwfJE1cUBlGMRPf+SnkgQA3DLXWy6XY1Dlp4yrGHmX
	Nt8tEi96auiISwQBYKbUX2zkdu2rcExBO4/F7ijjRpa8PhtkofieEtuBajgcS6Qw
	TrZAgPsSFHiaQ2fse5tMCSLFuxVkJ+OhEiw==
X-ME-Sender: <xms:0hEbaMiTpVSjREf_ceModdINhHE1_-fPiu4PyTk-tzKjsteHpU_klA>
    <xme:0hEbaFC4m8HLtKxT3tkWyp14UTShCJt2j_ugVcIQ0P0anCamlnhGRwXG9J-ovH5y1
    CrRhb_aMHlm65FwyA>
X-ME-Received: <xmr:0hEbaEGyBZjHDL-Tgw3WShtpBa-9KyyG6Ijq_Mf0VK4WzFM8dhlHuXDc3cGmIqBmFK6s3kXbGCW8Df0EvbsGmRvhc5WzuM6cutAAC-V86w5ZIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0hEbaNS3Ys-41nQJMmpaTLHDDWP9ScD-lfK-AQ-zEdGWudHwcwnkOg>
    <xmx:0hEbaJyB5In66QXMqLgMRaMw62J4RRH-GfFgY6HF_-lTrr_1kTYBPA>
    <xmx:0hEbaL7zc0cYN0Ja8utMeZueLjx5zKd9nZXK1ItLa8X5jhuX9s_MQQ>
    <xmx:0hEbaGwNIYORwgwzby4A2aRt-F0iKPku3pc81i5zzwMh4maMfdO34A>
    <xmx:0hEbaAuo0mc7QYilQ7-Tjg6EZAM_7_AVQGUsUNniKlafBnEpUIsxFKzz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:54:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cfc4b2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:54:53 +0000 (UTC)
Date: Wed, 7 May 2025 09:54:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 3/3] fix: use strvec_push_wrapper to prevent ubsan failure
Message-ID: <aBsR0CUusW0Fo4Ef@pks.im>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <a9cbca6bed308f2b563eca5d7707c6bc30aa4603.1746585203.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9cbca6bed308f2b563eca5d7707c6bc30aa4603.1746585203.git.gitgitgadget@gmail.com>

On Wed, May 07, 2025 at 02:33:23AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>

This looks like another fixup-style commit. I assume that all of this
really should be a single commit, as the latter two commits don't seem
to do anything new compared to the first commit.

Patrick
