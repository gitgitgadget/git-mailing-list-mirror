Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA921B4224
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766378450; cv=none; b=rTv3EExaL6o3fmHiQ9xVRi0lc8Th+m53GxzAWmmgJnKOlNHdbf9TtK0MMaFmveYdgiRyNm1vEGow0sD9ZRnyVhZKzw5fZW1ylO14a034rNwiJBo+8wb68riAWxdIEt/IIMrqwJFNXX5Nb7ev5wP1cznm6EVlROetOODf+Lem2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766378450; c=relaxed/simple;
	bh=/yB3pCpaw9JzAEZm3t9zBXc6Dy2FD3Ta4LqBbpyYu/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRmrw61mEfNHMK1Us2mYo36pWAnEh+azCGoQQ0PL9kCgObX7ghom4n7z3drDbFda2DiIZfz4SX/qMUYoJk++glPU9OxFB1yUY1T6fWDXrfbS83G3+WeuJXNflDIeC/8DsvQLixkHOgqgcaMq6IQA0VFh67KZw2dSLQpBqKqUIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cihDlGOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsETUn+O; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cihDlGOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsETUn+O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A89A7A00BF;
	Sun, 21 Dec 2025 23:40:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 21 Dec 2025 23:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766378446; x=1766464846; bh=3ncW/D2V5z
	3KOHrwEJkIbykUSLRy64MloV/fdfw9SI8=; b=cihDlGOwIHVoIipxgznQ0u/F0F
	TPd1jM814+vPglGClYquMhJw2oyOeZaR5uufz0Sfs8FYhcNbI4rBnFl21LUwoUaS
	J2bcZOSmgoc+fkmzAiob3rKiYsG4zqkGluj+RM+cdAldO8T7r8bRiM+mnD3QptvC
	sxOxxBmVGqZFVzTVsXXfannt+RyKIEH5gr/9EBmySza07SLirXOhZFu7lyY8lrby
	gAGXGjEiN61w+NYL272P1ErFdaIX1lb7SRVot/vhotzWC0DWR/yIvSi3sT/ZjMec
	znjNZuY6PzGerQSj5B7+0MbzbeCV6baUvv6/5/JCQI0WENUqbS0MYHmIFIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766378446; x=1766464846; bh=3ncW/D2V5z3KOHrwEJkIbykUSLRy64MloV/
	fdfw9SI8=; b=SsETUn+O+4n//neN2mj5YfDyJqaSHUZt+LcfdD2hFQ50UEsux85
	KKQ4XkN/d7ZTAiS/negdlaYBj2ckosxI5qd1eCc2e6C6DCwgOOSbmhg10QSrRI7F
	FDIOS/g4mhbFsAD4oakNmMWHGO389hCU4SVwrzbwTLnwR2E2ugr3uiqDPZb/7QeY
	PiqcMDTKMwWeinz87C0iTal5PmbJrKQUg+ZvQm/L4WewtYUSDjW6J82jeWFUh3a2
	vUjpbYtrAjkNglz9ASou3nkiPaMpqPjGqOtiCMaOh9tJzmCxmnbuh8EZkKgcC9Xg
	yYpgvuYuIHVCbify0xSu+i7EZ76uaet/wPw==
X-ME-Sender: <xms:zstIaVCgfhoMVhJAWlaIGHnmdjaQBzGvPmS57HN1qt2ZdwWV1_WAlg>
    <xme:zstIaaji4JhvpQx-BxHWvuk19ZXtJiLz1DJMLW9O8txPH5C-x0MqTANKtE6ap7dGL
    dlCOK9Ofu7oin4bEwQ-4PV9gDCjnsf9qK3ZZaVfgtuyvyE_K4Ftvg>
X-ME-Received: <xmr:zstIaVl_LTRaOovZfhZ3D-TSToMe18ElNBSIkRYELCmh99CZFvlvDIfrmsjio6A-B1aTS43nPx_KEP2r6DXKnrbfiN_vRAl3SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehiedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tggvrghsvggsvghinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:zstIaeo89YSBamg1PuR6h-Npv3VeXrQ9Im4eGSwB9n-4R6s8kT-Z5A>
    <xmx:zstIaWFhHrJVkzUsUjQPHqv5lMc6bwr9c4DAjtHqPFT5xK1AZcUr9Q>
    <xmx:zstIaSzqblSGt_sUk59-53tReBKu3yfkrBjphkDruPzozT9WF_v4Ew>
    <xmx:zstIaTpQGCp79vPo5zGSGEfY6U9ZysYWB-cM1zW4qc5x90ycbQFSHA>
    <xmx:zstIadHu7lXF_SgBvrLI2vVbD5mOY7Y0DgTTp12nqVtR6kJ7cfLD7K_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 23:40:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Pasteley Absurda via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Pasteley Absurda <ceasebeing@gmail.com>
Subject: Re: [PATCH] checkout: add remoteBranchTemplate config for DWIM
 branch names
In-Reply-To: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
	(Pasteley Absurda via GitGitGadget's message of "Sun, 21 Dec 2025
	15:59:56 +0000")
References: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
Date: Mon, 22 Dec 2025 13:40:45 +0900
Message-ID: <xmqqtsxjruwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pasteley Absurda via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: pasteley <ceasebeing@gmail.com>
>
> Add checkout.remoteBranchTemplate to apply a template pattern when
> searching for remote branches during checkout DWIM and when creating
> remote branches with push.autoSetupRemote.
>
> Template uses printf-style placeholders (%s for branch name). For
> example, with "feature/%s", checking out "foo"
> searches for "origin/feature/foo" and creates local "foo"
> tracking it. Pushing with autoSetupRemote creates "origin/feature/bar"
> from local "bar".
>
> Useful when remote branches use prefixes but local branches don't.

It fells that this is presented backwards.  The usefulness of the
layout that names local branches deliberately differently from their
remote counterparts needs to be justified first.  Only after that,
we can consider adding extra mechanism to support such a layout.


Once "git checkout foo" is taught to do the same as "git checkout -b
extra-foo -t origin/foo", it would create

	[branch "extra-foo"] 
		remote = origin
		merge = refs/heads/foo

but the push side would need extra work, and that is why you needed
to muck with the push refspec.  But then what should happen when the
user is using "we do not bother remembering what branches to push
there; the remote repository remembers that for us", aka "matching
push"?

Most of the problems is what you are creating by using an unusual
layout to name local branches differently from the remote
counterpart.  You do not have to, and then all the problems you
created with that layout goes away, without this patch.

So, I am not sure if this is a good idea to begin with.  At least, I
am not yet convinced.

Thanks.

