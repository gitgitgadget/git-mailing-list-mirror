Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0C1F03EF
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402197; cv=none; b=f7PSiOAEnKAEgdcXuU9lABbpw1PfayNVTxjcf12UC932XrLbb1zzo9Al10BjtKwSug0MwUk1II5E4Zi4CGpo4rxs8M5i0qIbcw3ntU421P7rsLR99+NeUUC1VDMpsNyMWy+kW+31F9+U4fAycqUxPlJNwEqkCuLtJQx71vmIt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402197; c=relaxed/simple;
	bh=8NaBB4RGDj5Cw3C9Qb9/7/SKpoPcHiF3AxhKttllL2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Au0PRgGxPHMp02AWxRVczkb2fzXKblRnc+QJCNB/30nUeZpTmFsq6doLCYaCyZPQHX4VOGBWmH6PzlOyE9UPDPiHXsulNZ2Lyncbd7XENHcdufesuLu83ZFp25VqY3oRP78o6UDL8HgYRm7O5O++0tyTEWPsEzHc069Wnp2VNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kPIUMf20; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMP/PvAK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kPIUMf20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMP/PvAK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 694E81140273;
	Fri, 11 Apr 2025 16:09:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 16:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744402193; x=1744488593; bh=8NaBB4RGDj
	5Cw3C9Qb9/7/SKpoPcHiF3AxhKttllL2I=; b=kPIUMf200x8WWfPbdwcRWVSLrB
	S6EiFa3Jk/0frX+lAxWsXhkX23RqCpSltST0nRvZck50K6IgVAUn/KwLoeC6bghh
	7IFxHB5spfNJrOrw0LdmC/um5BBWHtEIfAkwmf0XbYvdmGx3ggGoYW5hvOWM/LJA
	KalUFOgb7GC3Dd3PbelsFr6txJDTheqXOasXNu4bNwhH5GQWOH1SDY6rTIkSeNJ8
	65OsBFDTRRVou1vZkczdLizmKZsq0n8DNuBW2xdBvXDDsfpaWB4aOadZGv44iIsf
	C2q2xVD9H7zMYqTMEF4p/JwC3kAJmmx1MmSobUus1greevZ0xW7Fy5iy1ZkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744402193; x=1744488593; bh=8NaBB4RGDj5Cw3C9Qb9/7/SKpoPcHiF3Axh
	KttllL2I=; b=ZMP/PvAKltPZVUZWbabst71H4YYHoZzE4ZUwgc3AgIH/663egDW
	p484EK7xLRnpraHoF5r4LX9m57eDDBOoJlyLinSS+Rxt7ZJs13uvGI2Irl2R0say
	zT8wTT3W+TQ/0Qm5l5dwjHIdMB+YzDSeTbYAxOmOKcmsJ4erlDCoQhzFB7zOdeRx
	1kIjAz/aogkE2OUlEarN9/MKHs3b9500wdEZ8XELeV4J5REFj7P8+g3Ic/ldBnH7
	WfYgaYojhf038mjoEyeZz7PcWssvfl4tEWBwnFGYAtd32RRaB6cjrAu/hOGVXcok
	F166xRpRKN7OrNYJoKiNo5Bw2BzXo57YDvA==
X-ME-Sender: <xms:EXf5Z4O9rIwp2ZLQeJM2ONK95cOb39iqYW8hY3RywQoGVIl5NgOTiQ>
    <xme:EXf5Z-9-iq53OvMFN4rKJ6aX4FzgehRcHsiu6dt4KTGW8n2ZpAyTFAYd2wLCvvm4E
    5zVCRc6ql0vTLFzhw>
X-ME-Received: <xmr:EXf5Z_Qdt_z-gh8eH-EBJNa-pF9oyX2QHZZRIo1ub_d4d1-JiAPaGhcjBMstMLlWbmbvC8bwrvwhtEh9LdlyoQLJu5-yVP_wfDuV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:EXf5ZwtltJjMVgdXseYg6h9PVTk3dUlBIzDqOdmvAuRW69eMwxzSnw>
    <xmx:EXf5Zwes_gN9URj_4qclHoqNWPSZ-3cFc5a3EpMjXEr37TpdZwF7fw>
    <xmx:EXf5Z00lWKummAzSsy8gPddQ8DJY4hF_cJmlUcjD2CNJ_3WrXn8OCA>
    <xmx:EXf5Z0-hpMEOYS4GlcPHWIFeqao2VxnhK6sFbiGcbR58cT2Z5f8xOA>
    <xmx:EXf5Z7L387eZufs_o-0LL7fDkd168rbqmvukSvJF7UbV7L5dDVJP6lKr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 16:09:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
In-Reply-To: <20250411-pks-split-object-file-v2-1-2bea0c9033ae@pks.im>
	(Patrick Steinhardt's message of "Fri, 11 Apr 2025 11:29:50 +0200")
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
	<20250411-pks-split-object-file-v2-1-2bea0c9033ae@pks.im>
Date: Fri, 11 Apr 2025 13:09:51 -0700
Message-ID: <xmqq5xjampdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `safe_create_leading_directories()` function and its relatives are
> located in "object-file.c", which is not a good fit as they provide
> generic functionality not related to objects at all. Move them into
> "dir.c".

It may be debatable that <dir.c>, which has traditionally been a
collection of read-only operations (mostly for exclude/ignore
processing), is a good place to host "mkdir -p", but it certainly is
better than having it in <object-file.c>

Looking good.
