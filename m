Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A662A1D8
	for <git@vger.kernel.org>; Sat, 17 May 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489185; cv=none; b=i2w1EpyLur0ci5+5geRg5nts5uKhJlQZrlRMT/F6lGfVI4yk5waQTG4IUp8obbmFOt9DsCS4+N4FczG/oSdvDjzuv2dDX8jBG+xnqwDa0xl+f8eF+hyliLf/ziZtymIpi8RvKxbkU6/5yaGMSReNTsAjKDlF3bBc5qvk7/BOnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489185; c=relaxed/simple;
	bh=azfmvrk833J+UYgy9LtM0GW/sZ+GRIOWc1BAxHuBVLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqBK82hd5ZF1wxWhCKDwPKMzQowSat81lvPUjL7c7snci57OAgUzOuP2e49eWLkc6jrPorxl5TTSPcFjMYFBujw0ZQsYTabQIFwix6k5Ggha8+D21umy84XcGT/AE2iNyGKPkwJY3ljLlj5MmIy2XXvvNyTyZy81Osj0nvANnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pB7rmY8L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJH5P5Ig; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pB7rmY8L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJH5P5Ig"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D07BC25400FC;
	Sat, 17 May 2025 09:39:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 17 May 2025 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747489182; x=1747575582; bh=lcFNbVUxoW
	MPLZuszmtx02JDuivmHNmHyRAY24sP+Jg=; b=pB7rmY8LOag2PMFT+4QuZ9/DtJ
	JrDqn5J9XcSzHD5toUTfNLslHePlu/xDAk1j9iol9/YPDO31xuFwYuvDx9dUxc09
	KYh0xZ37rJTpV1q2C6zLvj9ss48dm8teqEwauD33RzCxfE2kquY3UCiwJbhmSbRT
	0Z8tb6L2hhMreB5UBk5OkDU6xqxCWgdBP289sOZarlJT2WagBzcHiqgrgpYEjCbC
	lj51iDUzv7DEDz/LO/sKQYRUh2fa28y2nnCWzXTB7TsDEuuFD38Gp50Qdhvl6xC8
	xD/A5GqCAiOKI4EcCzznlaP+uz6lb/5blGYdS2adazZjMSgGSqTQ0nWU3DaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747489182; x=1747575582; bh=lcFNbVUxoWMPLZuszmtx02JDuivmHNmHyRA
	Y24sP+Jg=; b=JJH5P5IgHP3TNAuW8E7HjD+RVWmnH63z9N7Ivy0DRkS71T8cDn5
	BLICd4pSHAGuUpdaPVepltYYgcv3UUZzqFF1P+4m9TjeQs40PRVW+kNryG5nHHsp
	A8y5hWlENr8rqTPm7nT7Dna4wsea461byUZ/ZXuQULuCYsQPpmdBDN2KVTfE69v/
	1b8QLJP/LOLGLSQBZqS4bhpMDQpQu/xw/n4EW4c7T8mjZObgut0JgKOvdVmMXHED
	vAtr2jaCB+TJadsBsosTk8PaxEv43bcjo5jZfaX9ImdnpAmWoRQMxiVemvAmSktk
	w1hDLy0axmx0EI2ahbN2eYHdFfGgAS65GVQ==
X-ME-Sender: <xms:npEoaHGmlGOqDoSvhBdKL5Ts1JhUWns7AiBzrYfcTNmKG-f-z0HLhQ>
    <xme:npEoaEWA9ql0wfWGfu-YJi3nDaLPrkylAJHQ46zmNkbCGBn9GiAZKzYyHm94E7nSD
    Yh109vouKjEWR3zzQ>
X-ME-Received: <xmr:npEoaJLzLuIMQKgxN8fGWYASntkJybwLx1edJLLfpYXBLDeYhd-pDBB-ajuDAXYvNd8wGS4TujzAZ-yuA7KaAHouMsWOpl5jyWU7JSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudehjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehn
    rghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:npEoaFFNTuhg2BDc3a_n7UugKrzfudLByUkDB5PLHoWyHI_EGKzVaw>
    <xmx:npEoaNV1vQNBqu2jK_VoA-uN_aEkRvBXCfWrEbDHgOq_zEBzdNxP_w>
    <xmx:npEoaAMmy6Y-UNe-noKn5oo6ajiXWenOIx35xfOp1pH3qx3nu3Xp2A>
    <xmx:npEoaM1yB6BCmb7F8z1iwRacCxn0xMYjfsC6WnlFk1FeMiFQ6tmNZw>
    <xmx:npEoaNp9Net7IvT_Qcv5fwPr-Py-lObY0ADFojo9uA0cVqoQj15sv6kz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 09:39:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: nasamuffin@google.com,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] docs: replace git_config to repo_config
In-Reply-To: <20250516185516.52311-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 17 May 2025 00:25:16 +0530")
References: <aCeAIqwvEVOdrsMg@google.com>
	<20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
	<20250516185516.52311-3-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 17 May 2025 06:39:41 -0700
Message-ID: <xmqqwmafqrtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> This change updates the example in cmd_psuh to use repo_config and
> repo_config_get_string_tmp instead of the global git_config functions.
>
> While git_config() accesses global configuration via the_repository,
> using repo_config() makes use of the repo parameter passed to built-in commands.
> This is the preferred pattern in the Git codebase,
> as it respects repository-specific configuration (e.g., .git/config)
> and avoids relying on global state.

Again, do not start with "I did this, I did that".  The reason why
you needed to do such things is a lot more important.

    Since this document was written, the built-in API has been
    updated a few times, but the document was left stale.  Adjust to
    the current best practices by calling repo_config() on the
    repository instance the subcommand implementation receives as a
    parameter, instead of calling git_config() that used to be the
    common practice.

or something like that, perhaps.
