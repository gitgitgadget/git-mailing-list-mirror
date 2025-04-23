Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907312701C0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407832; cv=none; b=tm3fAax+mnEFLak+FkOi8fGhAOK7lLI7wuggjfqsTvW1MrdfU75ISkj2EA1l6umwYW2LJhgM2ggEPzkLIwXkyHoE/GND3ndx9jmTjt2VTka5/c3GtBhTNedQ0iEdJUpYEu6uHsHNLmio91qDvYn4oReJceJzTaG8OKXr1uLVdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407832; c=relaxed/simple;
	bh=ZFgghDgh2GqCUu55T5HJtRhgD7IYCIwt6TMLnlAiuWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CngITVJTohq3iWfbCU2WVzcqvP50U+PKKDBnYinaZvxdckpKaHEVvEyhQeitu/b5Grl4zdrGOK00hH+AeHJGjuTavpyZtXl+QK8PgypD/0rHBdXzeAgUJKqGnUZX5fQGkTaSjhvzxxuuB5KNb5SGDsK9ipllQqYOcVzXSI7gNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bopzfVos; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHGVN0Hu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bopzfVos";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHGVN0Hu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6532F11402E2;
	Wed, 23 Apr 2025 07:30:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 23 Apr 2025 07:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745407829; x=1745494229; bh=XmI3m1bXIF
	sDJtiyaborryq+a/ovF8Qn+ui83BzX9rU=; b=bopzfVosx7aQACwQbptPqBK5sG
	fuudA8WsKj/Vff+dgBP6U01wF4MDZxyEVZF3m6CuQ00qXbuwUR6mXQJgPsyGD6/j
	UyMPTUV0ZdsdGTy+j5RnW7VQqAZDRtya/5awnVrYO8vvvBrYkOY7KRKqzCJ9j1Lf
	dUjbeWfGl8sHS/MLra5Rhkl8aYYAqG3FHPFWsXaSjvydosLKufIdaM9b+mgtJhDD
	TC4EOgkFQGr3OyUB2t6W5BYzwZrky++n4gCEY6UE4m5k/GAsE04aLw7ZxrT74fDt
	0K94/9YKwP/BjnLmsM9x9vTtDJSl/Bu7Noxb4f7hFq5VOyJbWzyY0vGgWKeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745407829; x=1745494229; bh=XmI3m1bXIFsDJtiyaborryq+a/ovF8Qn+ui
	83BzX9rU=; b=NHGVN0HuONklbR7K/O0PVdNCnbuYKF+0EX07WOR/tHeUqahe/8D
	6CKvEyuuR/MYN4PXxGv7ZS8qS7N8SGPuhPHGb/2CDSQnBzYW+Z8RsDjjpNa05Mzl
	EaG8OIJUKS3fZmt7x/+u+jRi0zBZs1iQZaUKvGE0Vti8Pdu5yYxeB2DtkaaPvPlq
	zt3HhNJIiqM49QeBLz+oXSoJOvJNAdI7fZNyYsd5pu9FURMNmsYv1vzZiTl9E8rR
	3x+na8VQ2pe37urog0B4DPBUpLfyRPKGkOqgq59iwxnCg3q11XUOEsyOn++njdW7
	p2aV5/aM9FNd7q+gaM3zOe78Bjnuunnbx3w==
X-ME-Sender: <xms:VM8IaMRTLxlrY9ab1-F9J888RR7t0VGzMtFiX01M2jLdRgGW6e94Hg>
    <xme:VM8IaJzeDrep69_mX4kGbebRsDaMXWq5nMpiISOBwguzpA4NRbnMGxywYgvgEJ-Ug
    tu48yvByLcC-jrsIA>
X-ME-Received: <xmr:VM8IaJ1IhcQXeZ9z3LliNrsK1anKO9b2vodWOjteeDhXZMdleRtP7ez3mWKobroahjsW8GlhM7ZkKYDSCZ8IsCENpqqZyGwUu9F5cfgZCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeigeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:VM8IaABlnMcs1VXZJGSJwjljkv3x79UtUtbSXj7upIeskDO3hkiEtg>
    <xmx:VM8IaFjFmNjF3P_7qkcAUFfK_34aDLEpCnzOl7wxWj1f5DLjYVM9TQ>
    <xmx:VM8IaMqyXziQAfFX4_jXY7VOFtnXC0Q5mg6cl_TxCZYzt4gRpxV4IA>
    <xmx:VM8IaIgtNmx05-CbY83t5er87IToaN8nt9LiJZOVzK3Orbx0qt7I6Q>
    <xmx:Vc8IaIoVom7DigEUpf4Vf_fivN1HEk8xb3pDwCn-vFNfn5wGE4yMqAkz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:30:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dc43f03 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:30:25 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:30:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v5 6/6] makefile/meson: add 'check-headers' as alias for
 'hdr-check'
Message-ID: <aAjPUGJeOjQHpAKz@pks.im>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-6-d1e2be4b2078@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-6-d1e2be4b2078@gmail.com>

On Wed, Apr 23, 2025 at 10:15:39AM +0200, Karthik Nayak wrote:
> The 'hdr-check' target in Meson and makefile is used to check if headers
> can be compiled individually. The naming however isn't readable as 'hdr'
> is not a common shortforme for 'header', neither is it an abbreviation.
> 
> Let's introduce 'check-headers' as an alternative target for 'hdr-check'
> and add a `TODO` to deprecate the latter after 2 releases. Since this
> is an internal tool, we can use a shorter deprecation cycle.
> 
> Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
> also use 'check-headers'.

I wondered whether we also want to rename `coccicheck` to
`check-coccinelle` to match. But even if the answer would be "yes" I
don't think that this change would need to be part of this patch series.

Thanks!

Patrick
