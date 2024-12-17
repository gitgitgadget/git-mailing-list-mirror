Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E117BEA2
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466154; cv=none; b=csmvDIAh8JOQDAwWXtkUipejDwEaL+UWRcz1nLr7pGhCLyqpseKadJN9RURyVmYzMrfnAm6hBbDJAKGdS/Be4zq+zj2vBifpS2doufCnk6IPp5+WgjxunSybVltSQ2Lc+xxkNwsz2FW/QKZIP9vpciXTVtBk8H9W9PZJBuEWEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466154; c=relaxed/simple;
	bh=SYkxRy2MoWR/BaPIqWsqgtZCL5iV0ToWFGfstrJ9Qag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKdbdVoPVh/DE5jo40ot8uEk3S51PBG8SsmoQ4RrpdMR1/M3j8rSQWKCD1dzcbmVXXNRmNUuvNp1AkUM56Lxj9oznDBr57M2eUqEvYFMU1DUOg0f5kUySALCcoV4L9wB5l3vetu3/fsfqXsdIUo+tYJPa7PsHywMyZmBqjampb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DG0P9y3b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4l2Q10W; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DG0P9y3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4l2Q10W"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 30072114008D;
	Tue, 17 Dec 2024 15:09:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 17 Dec 2024 15:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734466151; x=1734552551; bh=tfYY55SL/E
	PY6axVeMjTFcLyiChrX0GaAfQp2GTUf2o=; b=DG0P9y3blKRiwjO9lcIAjhi1zW
	ADdp2qDTVxdbrbTPT+svqawxqIwB2z1IW11fdpS5h3+vsyp1VU+4BbD/OZD1G1WL
	ojpAHyVjRlFx4jW+GJ0sJKhzTM6BRUr+vJDGrGBvfSnj7uRPC25rEN2TCW6HDp3A
	SRc41GipGTux1AjL1d8EeG1k44YHdPB3XQha8vXhRi8TZIG1TaQDQpZLw0RGzOfA
	d87nRIACbWpklbGtVFFX3AJPeTS09laBDbEJEhvGVziL9eLD8qSaEW+9kNv7ujHv
	nyMZUJED/eUy6nQKTfSOUrwG6wfxcttJEK4HLmLEf6duP1ZXFxioJMrG2Vfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734466151; x=1734552551; bh=tfYY55SL/EPY6axVeMjTFcLyiChrX0GaAfQ
	p2GTUf2o=; b=u4l2Q10Wy1u7Q1u001YxQtUEVSeslH67n/vxd13pq80eZoN4YXN
	PVy2ezrEV60xYWRzpNje2DvKx0I57PqpzNJouzMUWAKGyMI96eIwiszLY+cXiAsz
	Yf6efMnPsyiusWVq66phdv2kZPN4MhHouxRWmQGiYYuFa/vBnH+3n1iDoH9P4AhB
	QqRy/TMMm6KobPp5c8qR57kHFojz9EzLsW7sNrsuwShe8Px7iV0NCPLzdfMCm/Uu
	A+StdmFiOBMowSLRKsCx+KmIJX5VI6+qE0VsHy99/szonwmSrIn5wHIxO/o5Py2g
	sT6B/3SAJtjceG3JeTWuh/dbajiWio6vXXA==
X-ME-Sender: <xms:ZtphZzF7tUIBrkMV7f17ePgvNzctHepczOJbFOVIiKYM1qkFgObDAA>
    <xme:ZtphZwWWFcsQya-oxcs7jZySRhxCn5O-927tBU2o9OC94GDqfzzAKXEcm17toprg5
    MQRrCt6JQNTApQUIQ>
X-ME-Received: <xmr:ZtphZ1K29XaR844eemlVtIQ_8ZgGYkSS7pkhoEfxL5-kVEPOlqzzf2gZGWp52XIDwoRbKQpYgJJ7kGUQBroRMpvni6RgbrrohOrW04o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZtphZxG559zykX0Ivmp5g3VCDkAmIyBnTe8UyQSbI3cFgHoMPb3-cg>
    <xmx:ZtphZ5XW3tQqY4jmWyeVVQwdpSt9HiMETsCvlZh3ltQxNGTfUrYVQA>
    <xmx:ZtphZ8PX7V-49CmREsPL_G-QSOz7cDMYZzlSaqelOg-khNxCZe40SA>
    <xmx:ZtphZ42hf_wWaH6szRk-EoDTDKq4rVTE2MmxufCLXWgGR_--GbrDLA>
    <xmx:Z9phZ3etB7wdmQ38pNB-cNaGgu01n7jjQlGYMMzp-AnnoQk6P9OkkJej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:09:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw_rename: do support directory renames
In-Reply-To: <pull.1839.git.1734439924842.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 17 Dec 2024 12:52:04
	+0000")
References: <pull.1839.git.1734439924842.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:09:08 -0800
Message-ID: <xmqqy10eysuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     This is not quite a critical bug fix for Git because (unlike Git for
>     Windows) it attempts _wrename() first. If that succeeds, we'll not
>     bother with the POSIX semantics.
>     
>     However, Git for Windows knows how to deal with symbolic links, and
>     _wrename() does not work for them. Therefore, that _wrename() call was
>     patched out there and we rely on the native Win32 API call to
>     SetFileInformationByHandle() to rename files and directories.
>     
>     It is that latter part that is at heart of this here bug fix: To be able
>     to call SetFileInformationByHandle(), we need a handle, and
>     CreateFileW() is what we use, for files, and crucially, also for
>     directories.
>     
>     So while it is not critical for Git to take this patch, it still is
>     important because that _wrename() call can fail, even when renaming
>     directories, and then we want the fallback to fail not because we tried
>     to obtain a handle using incorrect flags, but only because the actual
>     rename operation failed.
>     
>     This patch is based on ps/mingw-rename.

Thanks.

As this will be part of GfW 2.48 anyway (I presume), let me take it
and include it in my tree to keep the divergence between our trees
small.
