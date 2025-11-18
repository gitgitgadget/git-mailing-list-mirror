Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323A1A0B15
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507509; cv=none; b=NxoQ8u5On5a/5sIaO7lr24652NB6JIxD6x3ClnLZ5opcKsgEnQC2+4tQ4J2YUYz8+JtwqXGooZemKOBJd1Opeo7DSFcHehL5wZjAQqivUC7kiXarlIr+YMpvVCeUNehD+dkOAv4vi6bOVXCgIYb81BrfjPw9vIokVrOX0WbaetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507509; c=relaxed/simple;
	bh=UgpzsbjMwHGK3nY98PZ/CDZcjBbkNS/yFb2ldmppBDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4rWDPX9yWaNq2lwuh9EVAg27HIM9QeiN2GCu90vtxmv/lvPCLkWvnS6A/vu2srUPHOu2HHVcGqGPi2JIum3pUod7RDXq5munDcL5LOoqCyMP3mAB98ix/nq37QVqtOJmggNpDU1AQhsBIJDqcqOX3IeDFzIYEMNfkCT8PDYAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C7HIBy8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3B6M/Un; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7HIBy8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3B6M/Un"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 355AC14000D1;
	Tue, 18 Nov 2025 18:11:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 18:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763507502; x=1763593902; bh=Vz8uaAuETL
	tQH3Fk41/sozipuEL301ZJUT/d/FQFyQM=; b=C7HIBy8kOS0sa996cKOle+CvYp
	LBE9l/5r0+cYYjmUHL6iTRR0IqIjaDqN5rTaiOhbUmzV/wiunod7ZnKRAXGfHoNU
	UiCHTqA+M4f0ylqUzZC4eee9076TqJv8pscTeIoWQuQjLznmlr/YEiYVcEmFharX
	VnM6AiJdRrMtxobARlmxiX2p/Pq8+PTGpOxt1w54/YlZ2qaCzBHd0wyaltCxk91R
	GRXMQ2/wnC1UVeHaSwz1p9xbBJmXXegNfC+eNYq5UWh3tlkwh4koKzFkUUBwW7FY
	U8DbykvO9UmXXUWTbm7Qx+R0cNSimQGIidpLLqNc/prJDy0m1syD/263aMIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763507502; x=1763593902; bh=Vz8uaAuETLtQH3Fk41/sozipuEL301ZJUT/
	d/FQFyQM=; b=u3B6M/Uno+5a3KBNXhDYd/Lbn+AEqWmvtf763Vc1b3indCANGKE
	7ZKGuCuWX2N4GN6mKLZxknGw4wZu4ZuyG5Z9b9SkRZeTDZWtUieiQL2/wJSEFGCA
	HH2cvPJx2hTWYSohZehNre2Kdlamb/5AH2r0HuqJPQWSLDs/TbKspP4RsR8BvlDV
	0WsZ7Bbxgfxtn3F/ZDEtQoOujPVz2IDmT8BHZkMpIW2XF5ynEfTqUrQgp2z1Xr/1
	Q9GK7Eqqp4V0qtnHudqy6SfU+uwzRz84sSw8tp03Mrii0qhqAjagaA8fM4iPc1Nv
	qy7yBRsvglLUt6iAIoaOoPC0n2tYAYLVEIw==
X-ME-Sender: <xms:Lf0cabSHF3fbmmz9PkwuYeJSifUqPTKPv_tLkbJrWMLfGb7drEWKUQ>
    <xme:Lf0caaJX_mb-qPg9Xp5S3JlbnOHR6g2IeqmAGSboHUgtYSAd-6x6wBAEgTBOPbx5z
    dQkqwwe7fSa_y7SEbbYBvVMHTlQMIbGm9DEtPdvL42Vh-NZSGHNBv8>
X-ME-Received: <xmr:Lf0caYJTYXt95SRi8uvLGGRsallVEyCvZ7E2A58fnrR3Na3fvTQXfiofUHWUnc3Hnp0Oxidre-UmEeJB3t3bp--wgfPxREtNmzQv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdr
    phhluhhsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Lf0caVjDD0VZiQWIKmyRAjAYQK0FGYD6cNOpVOk88HkGnI03Ct5_JA>
    <xmx:Lf0caSNNybhe_4WSTFvpG0ObHKc_loRI_ndduBKh1xnQOVLZi7YTjQ>
    <xmx:Lf0caQoMwohNi-3jeFMM0odXUx_V2J9Uug-7JHpT1fNawOrU4kqeDA>
    <xmx:Lf0caU6iILkA0avrVyYDxVxGMA3J2ueoVYeJSrq6Ui7YYHY5-dFgrA>
    <xmx:Lv0caUMvMPtAi47FtlgDmmYhPF79TmHgymBwq5hGhWLXCGRmtcOVbpEu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 18:11:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  Ben
 Knoble <ben.knoble@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v5 00/10] Xdiff cleanup part2
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Tue, 18 Nov 2025 22:34:12
	+0000")
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 15:11:40 -0800
Message-ID: <xmqqms4jc4wj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v5:
>
>  * Remove the non-word 'signless', and rephrase that paragraph in
>    unambiguous-types.adoc
>  * Cast to char in xdiffi.c:get_indent() rather than changing the local
>    variable to uint8_t
> ...
>
> Ezekiel Newren (10):
>   doc: define unambiguous type mappings across C and Rust
>   xdiff: use ptrdiff_t for dstart/dend
>   xdiff: make xrecord_t.ptr a uint8_t instead of char
>   xdiff: use size_t for xrecord_t.size
>   xdiff: use unambiguous types in xdl_hash_record()
>   xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
>   xdiff: make xdfile_t.nrec a size_t instead of long
>   xdiff: make xdfile_t.nreff a size_t instead of long
>   xdiff: change rindex from long to size_t in xdfile_t
>   xdiff: rename rindex -> reference_index
>
>  Documentation/Makefile                        |   1 +
>  Documentation/technical/meson.build           |   1 +
>  .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
>  xdiff-interface.c                             |   2 +-
>  xdiff/xdiffi.c                                |  29 ++-
>  xdiff/xemit.c                                 |  28 +--
>  xdiff/xhistogram.c                            |   4 +-
>  xdiff/xmerge.c                                |  30 +--
>  xdiff/xpatience.c                             |  14 +-
>  xdiff/xprepare.c                              |  60 ++---
>  xdiff/xtypes.h                                |  15 +-
>  xdiff/xutils.c                                |  32 +--
>  xdiff/xutils.h                                |   6 +-
>  13 files changed, 336 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/technical/unambiguous-types.adoc

This round looks good to me.  Shall we mark it for 'next'?

Thanks.
