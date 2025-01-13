Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CF24025F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792146; cv=none; b=FZV9EK0TJ9hbJJLwx+rE+qKZC/PD/uftNT6eD1y2qZ7c4+xJzTdyzPqchWAlHFhOBCBgLUbfgCZd2PZ1GdmRWb80QmiYlXObha0dgMGTkP7XIvjL8yN1mVUwbIbOZo5IqgqNzbHoKVOUPTdyByKG1RIWwMAK437H02xi/ZhABDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792146; c=relaxed/simple;
	bh=z0nR7j21GZbQuejbiOAYNsRuFhJUQyHdQiURi6UhOr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWzB0FIbgdHK1Z57NoJDKT++FGKdZbWIOBZv19b9LxJFZg7TnZnxoej3Zq2p32TKGVBuFq1Oo5/5gyGkCLi0BfAN00Z5l3kNyftaBAR6W0lTDmVOVnXJIx1Ix0eLkKp32XVTtVZBMF0PaM/FcNTLn4bNfco/ErkQ3PVnCCcYaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MwwsVK09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XC3vaP8y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwwsVK09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XC3vaP8y"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FEB5254021E;
	Mon, 13 Jan 2025 13:15:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jan 2025 13:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736792143; x=1736878543; bh=tYBTvMLWvx
	vz8jFPDZpmjV3jvaXtOKNTsiCUGND9hdw=; b=MwwsVK09jjuPRRLGfzzBGf5RXv
	Ja9xsGMF64i7e3rpy6x+PIbKrQHg3euEI5QoMj4irvJSfQ3MgcQmzZx0mgI0Qgii
	aaY96G79JBr7NOsdheSHW7sLYciBoilz1QQWai72r6NOCLyd5I3sK993HG/8h7v/
	41Pe9y6RDmmu4VIUpVATnNTrz5HPhhNMS03zkJUKwOkDyWN14+7e2vgUMJbhMP8a
	taBNGLOPY9oEWS9iOvNTq1/RCjaZLChb/m4QtyZzd82VMUFTaVWtCpmp9p+tgqEJ
	Gs3aki6trr1lfNUVvUuSw/dy6ttJZjCvQ8Z8IvvCK1d1mI9nB7qE3W4N0U8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736792143; x=1736878543; bh=tYBTvMLWvxvz8jFPDZpmjV3jvaXtOKNTsiC
	UGND9hdw=; b=XC3vaP8yBhfHyuWDiXZ4W9M/AHymqKllAGf9+lLPBjPG8K3aWUO
	/aFeZ/arWk9L6scksBTmh/ngRHI8w0tVgHDuJyaCUX1oaq06yu4Q4cpntr7Zg8CR
	rozrl813b/NGsyc5wM13OHYMVGfvG7JSOWWiyZ/z7TD7xDuTwMiXA+ldaZY/lfrU
	DBJoMpwJ6yhkG1pABnapKotIksKxuEXPnSwR0QxuOozGAv9pnBE+Ab1Lvmx8eIDq
	D+vl7nd68Og3OchykYV+YVtFxy2QSJV1jupMwAiRj7FLgFmjCzuD54kMaEVQCjdi
	vnGHjWQz/FouTFD4IYJDVvjER+2yQgsBD4Q==
X-ME-Sender: <xms:T1iFZ4xxmQ6xk7tRBKhBDJ3zg3ID4Fm5kl9ztBDh9nJcRvdFfMcLSQ>
    <xme:T1iFZ8Q8X3AFiFVuxMDLdc9KnnMw1ToGoN2dxhuyoXRHrbUfLaPHoUdgDN4aN9OA_
    DEacfb7W8qlpd6aWg>
X-ME-Received: <xmr:T1iFZ6VPNV3lPxhvnEC7rGm2tumM1Hi7SqS2yQrdeUP6CXyFVbnEu2UuJ97Abfdtq2o4yn4iqtib2D0TvUsftIIZPM8RLHE3VIeZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:T1iFZ2iTQFwyz5Xv16tPu_QsKH2ssh6SM66kQxb-jIbZ2IQ34Vk3kA>
    <xmx:T1iFZ6D3EZxgYZDVAS2u0gQYm2xYEcWSMO24DbEZ89yLW4ViFP8ziQ>
    <xmx:T1iFZ3LLhiA5iLG4FxlCCMDg4AjMWpwNKz_4HlET3YhSx8XEwzFHqQ>
    <xmx:T1iFZxCd4s-q-2Uz5U6It30tFLMvr-jdzUgg6C64YUro_1twPZz4hw>
    <xmx:T1iFZx4oeBiP35-DnJYVu6ZszFwGTPXeIbywzalBWtHI7X9Qy6YmRrSz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 13:15:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 0/2] object-name: fix a pair of object name
 resolution issues
In-Reply-To: <pull.1844.v3.git.1736788417.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Mon, 13 Jan 2025 17:13:35
	+0000")
References: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 10:15:41 -0800
Message-ID: <xmqqjzay8trm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * Readability improvement to the first patch, which fixes object name
>    resolution with refs containing a curly brace
>  * Fixed the second patch for cases like OBJ-COUNT-gHASH~13 and added a
>    couple test cases for that. Also, extended the commit message a bit to
>    discuss the cases brought up on the list.
>
> For the second patch, if folks want some open source examples where it could
> be triggered, I found two examples:
>
>  * lore.git: git cat-file -t master:random/path/major-gaffed
>  * git.git: git cat-file -t super-invalid~///\\.....@.lock-gfd0bba94e
>
> Elijah Newren (2):
>   object-name: fix resolution of object names containing curly braces
>   object-name: be more strict in parsing describe-like output
>
>  object-name.c       | 63 ++++++++++++++++++++++++++++++++++++++++++---
>  t/t1006-cat-file.sh | 31 +++++++++++++++++++++-
>  t/t6120-describe.sh | 24 +++++++++++++++++
>  3 files changed, 113 insertions(+), 5 deletions(-)
>

Although ...

>      +    Note that we'd prefer duplicating the special logic for "@^" characters
>      +    here, because if get_oid_basic() or interpret_nth_prior_checkout() or

... I suspect that you meant "we'd prefer not duplicating" here,
both patches look very good to me.

Thanks, will replace.
