Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126E32AAAB
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278964; cv=none; b=WzWSq6RvuUg37hDg5wMWZ75wlLvkq0Ikvvoq+l18LZ50lirsNxsvABniPpsHQP1kJF52NY2szkxz+nQyRZoCliv8QUO+MpuCUqkOnw2aZ5w3NPXh/WjXraihZp1qWAAc/6TBvvi7JmnKt5EXgleBhpNs9vdIvv7brol7MFWAUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278964; c=relaxed/simple;
	bh=0/uee5FcJmf6edOmf8HBeqlBX6UGyvm+CgmBJVUGZe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSYHgmloLmlrJCJvIj4GsRdg7SGvWWOy3nR5bYChp9J0RPtlWCKwCFG44RfrZjE+xJmRgRTx+qdIB5NcfwNjA/ySxQQC2Qe2hno+Us3+LZRBkQvttI/YlBTvSc7MKEYI3HVyYo0LB+iN37fXzjYS+Zp9S2SsCSzt225kK4YGhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FWIdTOg3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NW6Ukooa; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWIdTOg3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NW6Ukooa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 900C77A0481;
	Tue, 28 Jul 2026 18:49:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 18:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785278962; x=1785365362; bh=sxXP2C+cBX
	c1VzPQ1NxckZj+ResMNc9HtYuHTsUPBnk=; b=FWIdTOg3Plxb8WObiQK5CrU/pg
	Km+/sl5gSrzSrdIxaHdowbs4GJL1uYQi7+QDbj/4+xfoU99DQGotKEkxlFsfbUgq
	fXys6+YcL55ZBgHCps2e8tRs3JmHdxNPorXdVEKEMddDgNTpx3GchYQe0BbqjwUO
	5GDlDVEAfuMbvT3vnE6IfmK2Ougx6RyMoX/98NC2LmFbVtJK+ppObM6SUWlBdUQX
	ZixpUre2nYlgRLzYla0AqwLjvIeEv35Ut2QE2VMtXbZswa6978T0MG46gSWTiVGK
	h6fu4PCJ0+wR8LjM6kkbHBaj9R7dxHe0/2zx/4ADwmr0mLAhFxUC6WLmWz7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785278962; x=1785365362; bh=sxXP2C+cBXc1VzPQ1NxckZj+ResMNc9HtYu
	HTsUPBnk=; b=NW6UkooalcUGVpVJllIMpqK/KENUi+4ljM7VVTkjFSFYrtKoefL
	6ZWgtLe7nilIhe86dFQun2wUypkM7NnnqZMfLK/yuLrns0CKnLD0X/nx4sFcqnkY
	FelGkHMDpCGyWgnJoa2kO8dI0evQziRCMkcYs3gaf/Dpx4zSYF87k55Z18VkO734
	o68MzGsQvG9Ilf5d8n4otfImyUyjuqrT4jtUpg4mfR1k+KU68dZXrj5ZeVP300iC
	m3LOLiVLohjWTKz68Yuk+g7Fs8XCrCFyKvrG3WqJAEiwuLPIzi6wZRHkZ6szikv0
	N/kFwuSs4XMacikuHx3cjYowFUID6VXJZuQ==
X-ME-Sender: <xms:8jFpauighzHfPaU5eZgqUh8ymtkxJzOQUqU5HgAUumAYBXWHogVpNg>
    <xme:8jFpamCzXtpfRfJqqkk8N7DmJjWPcaf0pUDxSDCgIy9FSRldCGWxWzFgZsV6R-7hb
    A5RxDgR2E7N0_VttVH_vLun_2UXc01oYRnDcSrXF-AIxNjggWja>
X-ME-Received: <xmr:8jFparGt5BlN0lIMP3LitVeIYdjcKdZoNC7hsKW5hXfVTBOtl2BffHYyQFIEMaHkIhfrrJxK-SOYfUn7X_60r_mSzyAEHDn_Vw>
X-ME-Proxy-Cause: dmFkZTFICPEt4pY0yXs3HvcdT/LhVeS4gMOrnawOV24vf7Pywe9ijy/xbeTsTg605M5ij/
    2btEjWLHnc1W+XdWne2n2dbhRaCHaK77gzqfcTaoDa6QDPyhqK0p7Xbaxjt1Y+3+5Auyjz
    ZYTuEbmqjAAqaDge3qO8DzEXAxL6FxoDfI3n2SFXEDegF08VA4DxWfLaCdwukKEF+n+Mza
    Vul/MdCRwzgJIUKv1tCpB9v8paX2Hl/b2Rt48nPpVitdNWVMxEdJQzkfeX9zKQ+p5hJWVI
    VKc6TFpMgR3gEF4rwb9228w6KBiaL0ArqNDnaX2su9zwAX7tSz0ItwUWhSV1wdOAoBtkr1
    3BpTyDMKPRydyUSJxWf1TJnzHwB+gsriq5V5aWe+3E38n4rndJvSN5SvItfiXZRqc8el/F
    Bfi1KhOQ+CwYP178yXOTFL+yhY63qK8jo8MJ02j8hiAdjHFYI6xfMbyROAkc317Haievvr
    ijRzZKutmpWj2y3DKPDR935Rznvegt3NA4jkDMJyFuq3hBOVKPtMyEL/I1I+EI30GYRXD5
    0Qa4xzrjONTwkyG1dESufCkbxDHjriwtOp7f/Wx2GNOItd/wfanitpW9quG/gBP3GcyNXP
    Va5m99+JatuLXApV6s/Nfw66ZD55zNsmVARvorRkUs3nnVa1Wa7FO1m//9kg
X-ME-Proxy: <xmx:8jFpamIIt_BtouACq0loo5GhIKpxElZF_1iP6PzMZX4WK_UDFrQLHg>
    <xmx:8jFpannTD1Meya94hrEYhYeTMj_NscobZtKf6W7UHbfdFt9mRR7rJQ>
    <xmx:8jFpamQO3sWlVUqEPXnU3csxoXjBGkdsbicdO7wd5bPf_7Fqcj7vEg>
    <xmx:8jFpahIMlUSj9AvGixUL3iQz8kfp46apsECe_nwl2F60hjyFBXkFyg>
    <xmx:8jFpail7tgG2L3TPq-hY2G8uWabxVHwZa9hTJ6s9MOsokdMT7qNt1Xeg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:49:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] checkout -m: refine autostash fallback
In-Reply-To: <37becf38c2ef175a3dadcf750e2cca836942d83e.1784993669.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 25 Jul 2026
	15:34:29 +0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<37becf38c2ef175a3dadcf750e2cca836942d83e.1784993669.git.gitgitgadget@gmail.com>
Date: Tue, 28 Jul 2026 15:49:20 -0700
Message-ID: <xmqqwluebuhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When unpack_trees() fails under "git checkout -m", only create an
> autostash and retry if there are tracked local changes.  Without such
> changes, the fallback cannot help and merely repeats the same failure.
>
> Use the conflict result from apply_autostash_ref() to print a blank line
> before the branch-switch message, visually separating it from the
> conflict advice.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/checkout.c | 17 +++++++++++++----
>  t/t7201-co.sh      | 17 ++++++++++++++++-
>  2 files changed, 29 insertions(+), 5 deletions(-)

Thanks.  Will queue.
