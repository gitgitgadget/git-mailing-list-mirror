Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF2199FAC
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052234; cv=none; b=nQG05EoqJrxwFGzjbHoutgGLEFYIrnxwX8tyLhO+bumUyQb1wgZeSwVj34WalbAyb6AQMp4JQ4/LR+/A40DMTSUWx8FDCladLVa4GaCKhvKPV78vl0ThEAPcoJJdqkq9yCaZs4nr3sK0Vt7Dfd7SG6/N2I6qXHb1mqFfr/DL33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052234; c=relaxed/simple;
	bh=ns0vCjJUtRpVz4TXorcw3ye1vYw2HNML6PMJhmqf/I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2gUPn/ej0olHSOEcd/MAFVb0YIv0vZj2BVjZHEllnsAK23PJhUmc49puwK9vAqrWe81z8lmb44bkhjzrfJr3Fk0RVCzSYTLL5eNByC3M+fduMpeo/xNVjJ//dkQgvg7gzWk/H1dCa1lnznMvSj99xczNTY0OX72epEjdlJ8MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iy1oJwdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+CfYLw4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iy1oJwdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+CfYLw4"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E2B5713804A5;
	Wed,  4 Jun 2025 11:50:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 11:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749052230; x=1749138630; bh=sGC90ZGKYL
	n/cWJdthXEtbYjp+J3FX/gX3drnb+JIL8=; b=iy1oJwdI4ytT7YsFopKTyx/OeI
	ICEZDO09e66vbo73601UVx5ENcBSyj1c1vx13pWsRSdyDkDx07g8H8gKk9gtfQgJ
	dHVvdk0BP3ufuQ+5I4b4DXyQd9EGc+/T9KlsbyTSPelhXpTHsQOwVsVH+0QM27/0
	eVMf9PsOJxYNOCrW14Imm8jCDv8O5RqNgyyHhaeA8IUcUhcNXYIqajrwSVY106eU
	fywxZCN9btPsI3/On+w93dnfxEYVc9Ud4QGNt84MmCMli27esbvJhIqSe98nmvmQ
	Xr/lBkDUcExnthwGQB/IZ++QvcGZxwEtkv/UGvoLnwKFWCoaV1OScCnk1ddA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749052230; x=1749138630; bh=sGC90ZGKYLn/cWJdthXEtbYjp+J3FX/gX3d
	rnb+JIL8=; b=X+CfYLw4eEd9+SQH5nRpj8mNfPl1pT6mGRoDiRdaOIiRaCwSMHe
	yEQXAbZSZq+HbmObtmPK1PsL9KHx9s2Hv59WLa5ZIIg/CGgNcvSADybvairH2Ubs
	izZuaPJ0a4fCuJNtC+qyRU1Y6pnTwy67uw8rBxJZUTZ/uZB80uY5I/BF6Tsg9btY
	ngNebAAFBdSVlDebfOY5NDifBwWOhK1DX/z8JH5WqD2UOj/kMlxaNSgSPmDNRqeu
	ibT86P4VA2YSvkQrJLQkl/QmmfBhGgUIpZHB0sySCxi4010cFob74WhdJw7DlOUL
	mpLUumTUS/zYsiigkR+F2o3NjFS1nHEjvxQ==
X-ME-Sender: <xms:RmtAaPs0bySVCr_QNHZTPtfPcrsWnvJ55QV9v8mGZky-j12yvFnR4w>
    <xme:RmtAaActTTYNmTKtpU19Zr5Oc90HJOM2ElfORuJN3AUd2Ww3_KoSf_SZWngFIe77F
    sYsb200j_qvIb7X7w>
X-ME-Received: <xmr:RmtAaCzOJAHXgaNituK9DDvHHyMizCyOc2sArbLsjt6bcLcBg3pg7mXKrdo9ynVzUhOVFL-xQdjXqaB1myJqVLvqa6LQUsSkLwG1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehmhhesghhlrghnughiuhhmrdhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:RmtAaOO8Wgtv7B8H51fTqk9a-Z06_-gzxmS-ysD8gzQu5PW88lTOQg>
    <xmx:RmtAaP8i3pKgc3kXpeUlt4QcfrG6EEJJEGCoeVA4wIAJXxfKfccHhg>
    <xmx:RmtAaOWcAAILnPZVH-Tmuj2mJDb_8fvsYE8SzlKL6LbdkMwg18Bdsg>
    <xmx:RmtAaAcd8hKbw6cMe54-0mwSboNYQx7XgHwkhzeoePQA0EhHWxpq6g>
    <xmx:RmtAaEKg05xqT-XqCN2jW1Fd0v4q6yR_mSwVHG1RHrKWGN2UJLEtSmYx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 11:50:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mike Hommey <mh@glandium.org>,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] Fix unreachable-code warning with clang on Windows
In-Reply-To: <aD_3ahX2jyrtfvjq@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Jun 2025 09:36:10 +0200")
References: <20250603230646.2322671-1-mh@glandium.org>
	<20250603230646.2322671-4-mh@glandium.org> <aD_3ahX2jyrtfvjq@pks.im>
Date: Wed, 04 Jun 2025 08:50:28 -0700
Message-ID: <xmqq8qm7cxq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The function won't cause the error, but the macro will. So wouldn't it
> make more sense to wrap the macro itself in `NOT_CONSTANT`, like this:
>
>     #define create_ref_symlink(a, b) NOT_CONSTANT(-1)

That's clever ;-).


We cannot unfortunatel do the same at the site that the macro
NOT_CONSTANT() was invented for, though.


