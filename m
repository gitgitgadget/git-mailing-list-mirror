Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F522DF71D
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693580; cv=none; b=XkhPsgZPOyJidwKkuS4CopNNLUPM1d1InW3XYWETepTNBas4cplpbEQPtGvWr28Jk+XaWQspFN7MDlgqU533/kJYAWd6yCHJ5QTieXns6zKhWeKfZj3GqyEK1tWJ2cX1P5l3hZ3k+iVT+PSrWhobwIipsPJTGh99DUv2yhY1gRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693580; c=relaxed/simple;
	bh=QntCL539zi/vlMi8+2dIihU2MfRXZI/6jW6zC3kVvdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0v8fxjzOLronleGDkb37O2V+dlnNfNHg8PWHQvCcAp+UPre9Z9n9OutGk4pSAxt+EoVEhsS5uENEoiKtU5WSWLP5DT0l7C3An1I23G2gcrdSkHHmvJEyczRodPStSjkuKLC1yjNk/h9S4NRCgq9CG/l3XKikMtRp4qQea3xHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uuDfY6RO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGudu+LR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uuDfY6RO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGudu+LR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50A947A01D2;
	Fri, 12 Sep 2025 12:12:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 12 Sep 2025 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757693577; x=1757779977; bh=lH/ts2OBSI
	bXbGtY1P1iWO+Z3N77DWtTtbw2UYgp748=; b=uuDfY6ROjRM3yXIBrdqwNigvFB
	v1AJAcVfzWnjQ6BHPlf5PmWOKv0ttFM17G0M6Z3zDvvxw/scMGcZAlLvsIJOvz8p
	OAq9KdUnVPgB7ml0REzV8JJpQxyGalIb1DINmu500DIbpoasihoOE3Fgnvo3QHZG
	4yT1rMUDXXUXEy9HJjr84fYA61DTE6s08T0DlzZD2gNR7tM2nSsVsWjxAGdcdKkQ
	KnQ0Kxpb/3V0Gt6mLaLGFEfNwlsdZlrIz3P5IckZeLxdNXGUHmDmjjp2DtaZST6T
	AIPf2zzqGvwydFhThTBRflZ8HN8q4ne/dp+nqiMVTqx2fBC1xv2i3qcxUdvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757693577; x=1757779977; bh=lH/ts2OBSIbXbGtY1P1iWO+Z3N77DWtTtbw
	2UYgp748=; b=nGudu+LRFfUDQIUU4Y/k4GAaPjDvpd0e4N8CJqfePKRYRtjuGM1
	vOid5oTJacXr99facPha6fFd9CKSkWX6NjDuWG3Umqxd7ZK76nCfWPsbaTGAnGnJ
	O7RpdxkIOYFbDQj8hayU0kmuI718A5F4hfJ61vn0E79kK6CKQYip98wHRUBDck7w
	h5SlCxtf6hy0Wo15BwD3fpyovPe056cCWOjXjmd8XvJ+1fUgbAOUsztcazHQTeBR
	Rh6ITwSGEV31BUn6UZzkHfg11Zr8cuxaNls0i4I3VZFE2cEwPoHYZ4+JaUiyeLLu
	3u7/WmC7775kq/osy1cmKzIAmP+Rfp5IUMQ==
X-ME-Sender: <xms:iEbEaP3nY9uU6S7N6HEP19Gt8PoAUwjJQPvoZ0nPWXmDvhWzhoZKYw>
    <xme:iEbEaGhv9rcS6w6mAtOjus_dTgVDgZkJS3w0qQsT25Mlg9pAMbvhKvq1_InZWsZd3
    2ak6YRJP1DH2ie2Lg>
X-ME-Received: <xmr:iEbEaAVP0oN0C6smppSIwezfDruGc7GB6863OozGr_O0pWpqRAz1VhmiA3FACEE7lxhSFc6iFXLVF0HJ2OyRnD96LOx1AFe0ks2n_ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iEbEaFXym6g0pd4ZmWuQoxBiVWi80RoSmzLVaXa6DK1cs0AW4iJQ4A>
    <xmx:iEbEaAirqpEKFkQPWJN1jG5R7MS2hNormm1WEZHdFwsmpLa8s2EfjQ>
    <xmx:iEbEaAZ5vARPWfpaE1jHuR8ilJD3Z6Ep_-_g_xoJdCTutrK_0NZq7g>
    <xmx:iEbEaNrvUB30whV4-JLSy6l816yyTn2PctC3Lan7ViPg85KaAB_hVQ>
    <xmx:iUbEaDa5AIPyJDz95_Tl_LCh2cXuC2LPMhfvkdu5378ila3WHiq_VaJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:12:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/7] sparse-checkout: add 'clean' command
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Fri, 12 Sep 2025 10:30:04
	+0000")
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 09:12:55 -0700
Message-ID: <xmqq348rodiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> NEW: This series is rebased on a recent master to remove dependence on the
> updates to the global variables used by the sparse-checkout system.
>
> When using cone-mode sparse-checkout, users specify which tracked
> directories they want (recursively) and any directory not part of the parent
> paths for those directories are considered "out of scope". When changing
> sparse-checkouts, there are a variety of reasons why these "out of scope"
> directories could remain, including:
>
>  * The user has .gitignore or .git/info/exclude files that tell Git to not
>    remove files of a certain type.
>  * Some filesystem blocker prevented the removal of a tracked file. This is
>    usually more of an issue on Windows where a read handle will block file
>    deletion.

The updated documentation was easeier to follow (even though I had a
"Huh?" moment with "Opportunistically" a bit).  Comparing with the
previous version (with my rebase to get rid of the dependence on the
other topic) and this one, I see a few more code paths have learned
to pass "struct repository *" pointers throughout the callchain,
which is very nice.

Will replace.  Thanks.
