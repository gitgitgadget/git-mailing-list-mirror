Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B63B960F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113732; cv=none; b=aBldTTpUE4a7Ow3engCuzvwgr5dtWtYHDrbEmtB1Npug9ZaQ8WnymX+12xEz5iPjEe5W0uslz8yoDlL6A2+FOurD/Gz1TqKlf9769PPp8k9K62S/RLBm91YOWi/owBOHswTCVZmUxKpU+4zBprCo75/LqOfPy5c8AVXOK6xTJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113732; c=relaxed/simple;
	bh=bFdtTka9pcZ6iBHhvaauaBFxbKIoOgFLIWkqCqoaAG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dnfCHoOpFfGXD9vIX8Ju3ZYCpJ2MOdlzqQzV30Vb/OtFmMFGVv9rP4E90+aM171R4Ai08FmlDyj3QVp2/uwjeCnkXnd8hASo7ESEeZIb/vp6gXw3VQWru4SA6jk2MN5hpX2rwOXMstp1Ty1mWXEUbPqa3Octk3+h7kHhieT/b/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gv0pB696; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y6z5GukM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gv0pB696";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y6z5GukM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D98E1D0018E;
	Mon,  9 Mar 2026 23:35:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 23:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773113729; x=1773200129; bh=bFdtTka9pc
	Z6iBHhvaauaBFxbKIoOgFLIWkqCqoaAG8=; b=gv0pB696aSlg3qaIgKrBvgbyOy
	1bqUQfcnoBXTtkz0BujT/vx4iPQ2i3jwUHGJUKwqlDGHJFtha9w/CG5kfo7/0QXF
	zHmjVn03niEMnEiCjaXCRCuDtL12BHZu/AC44Nlx7XKtfno3r9ZOYPEi8sMgxhyt
	6jcQ+F4Cw+EFJky0gUzuhXCmCmPVqwq1PJQqfvQIjACQyEeq6a2Ylwsvtwm9QHWZ
	Pp+M2OBRGuBmp42SwHGxh4J9kxIZjIlukB1IFrlzpgSZYYUcbuIjnuJqXrBC9rXv
	F4EWS5eLV9NSRDTYKQQunG/0oTkBsBf9U2i0oR7oYrWXx17hpqkxwhTC9g7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773113729; x=1773200129; bh=bFdtTka9pcZ6iBHhvaauaBFxbKIoOgFLIWk
	qCqoaAG8=; b=y6z5GukMH/i87vEf7Ne+Tszn2kocv1Sfx1eEWr9lGRmzhtnxQ90
	usflSt+YwJNAN4gACW+0JflesKy53FFrbfmqwyU4w0pbOojzAP53nKLCPSIIw46d
	IolV1UZwRAK+R9vdgvJKCoV34mcWsb/sU3wdbg5mmUHtDFl2+j+VAWJWFAO6rri3
	MMlnslG9JnclUg9a9NftAylZYohuvyfOMXQxv6Eub/DLooWGOMCpZ9L0pM45vPzE
	ghxOa9ll9qlgUq/KAYxB+Ewei/sLXYjEXWxS7zxXbkVTiaIsvIJNcT8DpFzJKMia
	nlDUE0T4wjrFFkBOaOUcdJypOQOz63uLrKg==
X-ME-Sender: <xms:gZGvaReyVP4PJRCaUr7m55ukELBC9lF3z-zthKkdma6UMnvW3cYAAg>
    <xme:gZGvaWM-c-QSOJx6IheONvtmo_BSyXp_TpbxmyD-VV3Y9HNNFcPPEsfBDfsexbvdy
    mXLZBPjDeZ2P-jA4YKmpK-4TqgowVFlAfLKvWA4UOk9X1OUN9C0N3U>
X-ME-Received: <xmr:gZGvafiPTJpxfaTZW-OyhDKaZBKPzFCS5-5uKXFNaaroAj34S9-2SHgoZ1S-c409UYtJ8eOv6_xeUP1zf14-7fsM89lvDp7XzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrghnshhimhgrrghnuhekiedvjeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gZGvaZ0qsh35bWXIqPiQvwwBg6V2vKyqNedJDX5RYtARzOzbIFzKag>
    <xmx:gZGvaZhoItPhW-eTDM1U8zn0FCwYgCpf0GCPwPk06UgTkKJpuRJVdQ>
    <xmx:gZGvaZdmVVqbPo9pDoOf4g_JNZyg6kuAkPUlYEAXk4FHz5WvN8ejaQ>
    <xmx:gZGvaclrpz0iiXB8VEgl_RtSmzflyQYXV3hJnH6PsNnEJuROs4fbLg>
    <xmx:gZGvaTBcTqGRVbq1p-8ctHUH8sYYlORkumksy3myBzTilKMMSLQWAs1i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 23:35:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mansi Singh <mansimaanu8627@gmail.com>
Subject: Re: [PATCH] t1900: add tests for git repo structure subcommand
In-Reply-To: <pull.2066.git.1773112159662.gitgitgadget@gmail.com> (Mansi Singh
	via GitGitGadget's message of "Tue, 10 Mar 2026 03:09:19 +0000")
References: <pull.2066.git.1773112159662.gitgitgadget@gmail.com>
Date: Mon, 09 Mar 2026 20:35:28 -0700
Message-ID: <xmqqsea8xsov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mansi Singh <mansimaanu8627@gmail.com>
>
> The t1900 test file covers git repo info thoroughly but has
> no tests for the git repo structure subcommand. Add basic
> tests to verify that:
>
> - git repo structure succeeds and produces no stderr output
> - git repo structure --format=keyvalue outputs expected keys
> - git repo structure --format=nul succeeds
> - git repo structure rejects an unknown format

Ask those who have worked on the relevant command to review by
adding them on the Cc: line.


