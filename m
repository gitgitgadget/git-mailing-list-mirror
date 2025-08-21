Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5F335C7
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735320; cv=none; b=IUicunDvxtnpvRnB0AyAUjSfE68ppXK3aplxTklNw/wpH4l3GsQIzFTj9aKnLLTlmDk1WCsiXK4SeZzttQ40jLQOwHGxmu95bbBqQX0lgXd93cXEiA7JVZYhndALsOBHmBr8X2LeyNwLl5EgspGzvuMBOGrR0ruaqITtSM0qRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735320; c=relaxed/simple;
	bh=wpQV6aT0t6M0yvDPGJSEtHCuH/k7tr4UT1oYVKwetLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UAD7olRx23tX7ZlQ37gAJNLfo3R/x3Meeo0pn2aqwIFP0U8KwfFLu+Ej5SbOqSEHGdnn5ESTZO5F7yoVb9ynkubWYUN5cxnHAdo92fnPaaGPNKe5gHVkfJo75a1A4f8UwrX8mKZlEXGmt0SusfW4YAAGL8KQzzPXqLKg4G35eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O9nsllo9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fArhCCAT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O9nsllo9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fArhCCAT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0651A1D0019F;
	Wed, 20 Aug 2025 20:15:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 20 Aug 2025 20:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755735315; x=1755821715; bh=wpQV6aT0t6
	M0yvDPGJSEtHCuH/k7tr4UT1oYVKwetLg=; b=O9nsllo9bU0moCWqKqi51Kon49
	smaFRUPFCjhwAJcLY+MB3eQv97ooECMSlY2Mlg2ca0aCpywemsDEJA/CRR7FmtI/
	PwxP2jULHX4UzwoVvVCzV0ZqjlM63MZ7XLNsJ1DY/NS2Tc65WmXEgTec5uOEH/5b
	M1CBpBfTvDjRu5R1xzVX9s72zBzqV7/Kku6n6Ee8HtaFhaCnS7Iq5SLJn3UZWuSr
	9V7tB1ZMt84v4pycocd20SfpuxGLbCmt53sYmf5kXX+bhe93WewH/pi2ammvkFET
	saZxgmUgJeU0E9H2dZ3mcLbM9Bvi2YKJwk7cOshuqVAD+Hq7PRDCXfO3mmbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755735315; x=1755821715; bh=wpQV6aT0t6M0yvDPGJSEtHCuH/k7tr4UT1o
	YVKwetLg=; b=fArhCCATAbSrzD769mdAgbCzRyVkgc3LFn6Nfed5Ki8EFcZ+xAw
	zlAUUN0BxLNLmezPkX08LMPTcbWA36EqgPEqK9ZPBY9H5NenWnf6xTCADVcU5S+W
	jLY5s8j1LyXhegOmZWUspqBeVUZDssi9YvsZIAjn+38RCKj/puUf05nu3azyHW8F
	hBhS4X1a+JnpbDmsD0hlw2rDXYouaq+vyYYqeFrcKIx89WUyuXz8HxiHOOZb8WfG
	tuLJKMSH+9rJPSk/Y16eLSGJJQ9ANk5Jaaj3toJSGKY6pnAAaf4RGhLjCVlbzLCv
	xkS+A5b6xJO6sJPf9AXKZZVqPX+C/XysV3g==
X-ME-Sender: <xms:E2WmaD8PjgJO4jL6jYxW0gGBZKflUlPoBLqj5St2SpTEJPCXMVLO4A>
    <xme:E2WmaKQlLdZtInU1gv2qnye5N2Ut3jXeqq5je8Z48iJFGKoQhWD36NTpl1yscKiEq
    -gxFAv4-BrkjHF3tA>
X-ME-Received: <xmr:E2WmaNlsWoVtnrOjC2EtwU0aDcavCpWP6PivMMqc_TvPVb8wxL852n4feAkHsUcClk1IqTaV7_gB17RBAwJQ_mBjopGsiUXBdoMb9jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E2WmaCSEmDhEo9WE9CeIEVFVVWVfxV75Fwjlw7wmG35PgnsWTQqNjQ>
    <xmx:E2WmaDPpbncojZXG_VjFm3R5kcRWQQtdmdrI5IUKdvm6mKKfi0y5Nw>
    <xmx:E2WmaDUwrDzbPvY-OQsbnA_ImDUvHMPIjMa-1I0a1nwmNRjjpZPUtg>
    <xmx:E2WmaCcLqQor8f0oA1u-MOgLQRvnsrvkBVTQndPtJrdtW8VLGZPg9A>
    <xmx:E2WmaHpfXXy4ftD26l_0ZdEetAxSaVFqsPBO1CUZAJ1PFHwh3ZbyMi32>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:15:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 3/3] bulk-checkin: wire repository variable
In-Reply-To: <20250820225531.1212935-4-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 20 Aug 2025 17:55:31 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250820225531.1212935-4-jltobler@gmail.com>
Date: Wed, 20 Aug 2025 17:15:13 -0700
Message-ID: <xmqq8qjd7coe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The bulk-checkin subsystem depends on `the_repository`. Adapt functions
> and call sites to wire the repository variable where needed. The
> `USE_THE_REPOSITORY_VARIBALE` is still required as the
> `pack_compression_level` and `pack_size_limit_cfg` globals are still
> used.

Hmph.

I somehow expected that odb would know what repository it was
instanciated to work with, or in the worst case where in-core odb is
in theory sharable among multiple in-core repositories, at least
begin_odb_transaction() would take <repository, odb> pair and the
transaction would know for which repository the transaction is
working for.

Do we need bulk_checkin_packfile as a separate structure and pass it
around, or would these internal functions be better off passing an
instance of odb_transaction around and learn the repository from
odb->repo?
