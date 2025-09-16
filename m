Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44028A1D5
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000357; cv=none; b=BMTtideaMfO5jLyDiSWOq80ND+TK24rCmnM7OiEKQVFio3kk6d19DqerMyqKny66zR3x/3zwlB1bVR44HpMmUEqC87lhPuhhm9/2ciKAoSDEUeIwb6UFo+jtIY1cWLieJgy4e7Dhz0wRsKCzxN7zlKG3T4uN1BWZuAgyhxxyz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000357; c=relaxed/simple;
	bh=clyJFokIT+9DYWElDYyjtR3Z73Q8ekvMNZC/fxV4NPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOOo5xC1Fmw2o86+mh+4ca/Fsj24NMMnHHYhigRitqTeSgcQ01dOU6gLvTWdu6cm2K3AgjiJnJ87u5dWa1QpzZx8t8hUPp+WC7PPGPa6T9AXO+kEyx8PhUc9sO2mxSiYBjfxQlIFfuB4fNsVWkkYMV+XMsk+WwDkFBEVdL9Se/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=raXlYDMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oBLTrAZB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="raXlYDMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBLTrAZB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 419FC7A01C6;
	Tue, 16 Sep 2025 01:25:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 01:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758000353; x=1758086753; bh=nQw2BU4dXE
	euw8Xhh0764xVU4psj0v/tPoAcLR04aIE=; b=raXlYDMimRfL/iiQQD1YTAYWcD
	emm7TVEtaQ5s34id/vZo+c/0l7dz2zs85e6j1uTK0Gq3OSXJzcvUi21sWLxQOdPV
	MSzqNOt9aFIBBN9g4t9r9WllQi2iWMNxuSwyAT7RNQ+TU5hC4FUBbXtFRCb50Eai
	C2Wuc5WwTJ75ehdVN+tiiYnKdmsIXPQdPono2uuP76DonGfcT+Zr/UOCP8CytYEO
	kTYJOCYykzT5tOrBl/4NXhBsFQiVwnUHs0sguTj8tmqGgNng5Zd49wLBNe82BR8k
	d8WHhwhGBHIE2aFisGPfxNDMH8K/9J5WcZEAmz7z+Qm72vEpRvj+KDUi4F9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758000353; x=1758086753; bh=nQw2BU4dXEeuw8Xhh0764xVU4psj0v/tPoA
	cLR04aIE=; b=oBLTrAZBqFmTMc8itUlFYzLJpvjFkW+KuNnO3h94FwYpsBL1S08
	Gf+yMmb3TcUH0zzin7GYZGlmUL6oO4sdespfLW4w91IjD7Y1cy21X5eSaYPSxo/1
	rfVtRmO28CfBQe7pjVTCge0+SdTs1yV1Y9kBejsYBD2m7CyqKxa3LEGCyIapd4Gv
	SbVAVth0vUC38coh2c1X9JMBrzgkcY4Aert8X3vR2GNKjO6j82dW6wRzBZoag82o
	C19sFfeRS3s5CpxhZbkpN4YoynNGrvpCXgUA43R67MlgMKz9LgA4Z5la36UYheoG
	KjVex7kcqxFdsZDFQeddnvL2rWv4Nnz9SRA==
X-ME-Sender: <xms:4PTIaCIUb3UdG5kOJ6Vf-D_0LFnanHJMMvpH5DWJSF23z6XQbugoPg>
    <xme:4PTIaCl5fSBnicUm2ijr_m-fBqiluxfcEQWm2g45pbNInC3QUJ073cIk8OSo7tMXY
    01VRIm9Y5UGQlkvnA>
X-ME-Received: <xmr:4PTIaDLcALQdXirL7xsGXdBMlCSYQQuljV4hQKKKzJZTMf4q2p2m1Z2FThKTzP4GD_EcsCONOq0KwwDN_YgaJiwgeNsmE9-WEytCDs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4PTIaH58wCpKFqUfgDIYq9GuPHP-ZQNjWJKvH_x8MFUFKxPaERBjzg>
    <xmx:4PTIaH1UJrvct9by9NNhQjLNHPeLTM25GXtgvRt1-zmhbqiDIKxkYA>
    <xmx:4PTIaNe9fnaruhVVnzNG4_5SE1zpu8P6Agdc5k4r77WYqGTx60xErA>
    <xmx:4PTIaNcCiMXxRHffABplCYciuU-vR-CZ78MQW6loWqk0h_mSduILXg>
    <xmx:4fTIaOvmjZ8_iKvl3X_OBt-5hUVMftJI-Vqpi0jUhAJWerktBRnBa2si>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 01:25:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 12 Sep 2025 18:55:07
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
Date: Mon, 15 Sep 2025 22:25:51 -0700
Message-ID: <xmqqzfavarz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes-upstreams.adoc
> similarity index 63%
> rename from Documentation/urls-remotes.adoc
> rename to Documentation/urls-remotes-upstreams.adoc
> index 9b10151198..1e9c56dc5f 100644
> --- a/Documentation/urls-remotes.adoc
> +++ b/Documentation/urls-remotes-upstreams.adoc
> @@ -91,6 +91,41 @@ git push uses:
> ...
> +The upstream is stored in `.git/config`, in the "remote" and "merge"
> +fields. For example, if `main`'s upstream is `origin/main`:
> +
> +```
> +[branch "main"]
> +   remote = origin
> +   merge = refs/heads/main
> +```

When running with AsciiDoc, this makes the build fail with

        ASCIIDOC git-fetch.html
    asciidoc: ERROR: urls-remotes-upstreams.adoc: line 111: illegal style name: branch "main"
    gmake: *** [Makefile:356: git-fetch.html] Error 1

The line #111 is the one that has [branch "main"] on it.

Curiously, USE_ASCIIDOCTOR=YesPlease would not suffer from the
issue.

cf. https://github.com/git/git/actions/runs/17743739238/job/50423820029#step:4:1395
