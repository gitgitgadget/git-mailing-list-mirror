Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85124A06D
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771713; cv=none; b=g75vqzKRJ/xrXLWyEwsl61XydJZ5LDmrZAstU0nQBSPiVjG2HMT1Vr31/KqnSn5L1zuWpdES1aD6XozQoSj9/9OgpUJnbsWgA2jglOvh0rP8Z3KTx8AZUOcPNAqkCINSJvdU4e2uXFNrTib5KnU2dtjUBwdnj+LBsFyVFjMPpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771713; c=relaxed/simple;
	bh=gETAuZZsHxXebFGASRiGpePdmDa687xVWdorP6ra2uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIFu1AzXU1FhEyaeBRNMvHL7AXDc8e3J1eXwq+3ksdbrii9twWubgbrd5HzHkT6WAwMvdV7/ssdV7UzrgpZm2jSdK7JcsZF/uyVqNcfZfV/Znh+FLQT+3LY5yhdGlaD+4uPTCE24TtlpiPclfAAr2TIj60zv9nSWOhO8X+WJoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e8lUyrah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QiygV6Oz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e8lUyrah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QiygV6Oz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C57B1140005C;
	Thu, 21 Aug 2025 06:21:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 06:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755771710; x=1755858110; bh=/Ca2ayuZfu
	Tw3x177ghIqoP/4LYGfvMSJ/D1PTZUrSY=; b=e8lUyrahjotQ0ao+2fMZymp38g
	ZYP9MQcsoM4Ysxj0kHJVGnn2/qZu7TUn2xSlfXS4lrwecv7oJerg2UX0l3MoDWgX
	DJz3dmkc/wQ0ZzXDguvxuoPLps9mt5GZOklAktSlLAhGBAUP/sdmCvqK5v/vInEb
	2qeUKRb3kBgiYMRBUUyzr4/umvo6ISqtGyYltnB3+dsUjwSU438HiMP8S95uk7mH
	d7EraYubhejCBn89XKYcJqJhaDcw4IAd18WRk7jf6Ptcy9yr98e6PtoPMLfQkOqS
	igKYLnmSZdhCB/DuSSHa9lmvjCABOJrOanKnXsPSxIHyk6t+uUvNTCm8PzMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755771710; x=1755858110; bh=/Ca2ayuZfuTw3x177ghIqoP/4LYGfvMSJ/D
	1PTZUrSY=; b=QiygV6Oz7Z3ooQzBdkKTtM4NMHiuOofyk5cTpfV1J1s3rNr8J+P
	p0/PsTxfcEb9CpgP5JzEXqcyQuWd9sWEGFDpKcza0xxZxt2t+pdpNoUwGmPKm0x3
	gqxbvQH4dW29I7s1OSTlfIbS3B3xSefzHL36Vqx5C11dSM7cokYsAruA+CNGD9M5
	nAKAdlZNfHFhYt2LXQ6E7QgFdrDTrAG+UM56628/WSqdeC+qTKgfzf4aar75suOk
	5AbSzzD0Bso/LMgoIhw3MMUoS8hLxGLDcjeUATrkVrOCxSKHnl8ti2k+Ye/i+t47
	8Ji4nkERrdoVSYrq+BU0S37OWbVtSxK7dYg==
X-ME-Sender: <xms:PvOmaIOu9GFfeyPWXXdEHZT9tZXhDHy8s_b1TCVi_qbtHttVruQ-6w>
    <xme:PvOmaCMIOjk6y7aCwXW5VfFUs4f4CMeryi_iRppL80lkH_fLqh5pQYrgLIi2c4sed
    6dSdKWYjPu6-qcLog>
X-ME-Received: <xmr:PvOmaItsE0QiGl22JQDvCZ67fLsj7REEgtXePZvVpLu66lr-K3yTyfyj-vjI20R8UOEVZd2pDHqfkMVF2qExaPBZuOxIAu77GvscHybWFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PvOmaMWUT3SXQ8eI7EEkR-4-h_Rg8_RxayyQUqhZH68usNineB1IHA>
    <xmx:PvOmaAvXuAu3WQEKDPMAYTFRwOev3wXoJ1WaDgYDsT-YIuepLbHYMw>
    <xmx:PvOmaIV73kTYtmdOixXnMW8SDuNq2yUUtiDk_i9fKRWTRr31-_vfWA>
    <xmx:PvOmaDnWfs3_T4btTuxQlLV124t8jvGrqM1U8TuCxi82E1Pu_l3ElQ>
    <xmx:PvOmaHsek9RLUEOrstmWDapVmUCPp2kcETH5csUBgQySA5vJjzJJ4MW8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:21:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c53531ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:21:49 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:21:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 0/2] Add refs exists subcommand
Message-ID: <aKbzOuB0wL17Jhxb@pks.im>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821085246.929307-1-meetsoni3017@gmail.com>

On Thu, Aug 21, 2025 at 02:22:44PM +0530, Meet Soni wrote:
> This series introduces `git refs exists` as a modern replacement for
> `git show-ref --exists`, continuing the effort to consolidate commands
> under the `git refs` namespace.
> 
> The two patches are as follows:
> 
> 1. The first implements the `exists` subcommand. The small amount of
>    logic is duplicated from `show-ref` to avoid unnecessary abstraction.
> 
> 2. The second adds tests by refactoring the `show-ref --exists` tests
>    into a shareable helper, ensuring both commands are tested for
>    identical behavior.
> 
> Meet Soni (2):
>   builtin/refs: add 'exists' subcommand
>   t: add test for git refs exists subcommand
> 
>  Documentation/git-refs.adoc |  7 ++++
>  builtin/refs.c              | 48 +++++++++++++++++++++++++++
>  t/meson.build               |  3 +-
>  t/show-ref-exists-tests.sh  | 66 +++++++++++++++++++++++++++++++++++++
>  t/t1403-show-ref.sh         | 66 +------------------------------------
>  t/t1462-refs-exists.sh      | 22 +++++++++++++
>  6 files changed, 146 insertions(+), 66 deletions(-)
>  create mode 100644 t/show-ref-exists-tests.sh
>  create mode 100755 t/t1462-refs-exists.sh
> 
> 
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> prerequisite-patch-id: 235cc677f372e9571dade4313f8cfed4eab65f7f
> prerequisite-patch-id: d0cb9932dcf233b3a26e413514375191ede93c73
> prerequisite-patch-id: 9cb324ad34a786af110e9d3d47e4ca8aec240971
> prerequisite-patch-id: 0d74ac673c285c334adcc19b9ca2d4919563e804
> prerequisite-patch-id: 04c6d989f4130a063bc80f7dc9ce9a16d3459665
> prerequisite-patch-id: 95dafb2692da02d79c59cc2742258a915da25e88
> prerequisite-patch-id: f14c9a47038305eb3cfe8e9b649fa64065ada9cd
...

Feels like something went wrong here :)

What the cover letter doesn't mention explicitly is what the base of
this topic is. I assume it's probably v2.51.0 with ms/refs-list merged
into it?

Patrick
