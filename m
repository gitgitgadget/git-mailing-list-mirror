Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B463175A5
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043960; cv=none; b=BNZjyKxoxu0uPNoJZ1hTqmGVwBWJ/aZ/vofbZLh66m57BW5lej0ZcXW8AqlqAZD26cwrYTJvd0/Mekw5XQGu5Md7W1uWsLMssQxQZm+b1Wyh9xLlWb4XWokruzWMmsWqluZmC+hoF7WKX4wR/z/h7K2VKZArJA7mFQm3CMJz60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043960; c=relaxed/simple;
	bh=KJZXj7QYTvV678PBMFzeGOa0LcIz0cINmr61FcxsVD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mp8V8Th+WSQ6pJxAiGgtUL4NH4dx5SoE+SkuoLLH1UHZC1HXUtFmcc1n4+AYaSA/QDuXLsgiOkB9d1LVS4/JHfw+ELNXzCc3uZeD35FSq7ShI3RXPS+qIVjFPdrWAEj0Lnpu1GG0SKWmqktfsOZ6RpVrMMy1ZYOvXJnn9qZdBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BzGSWdbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxAQSNvA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BzGSWdbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxAQSNvA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 439CF1140257;
	Wed,  4 Jun 2025 09:32:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 04 Jun 2025 09:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749043957; x=1749130357; bh=JMwQyn34is
	JxlMD+mjno+SDMfv6cfX84nOIJpCmkVZs=; b=BzGSWdbYPPu9YM8JdY09yipzsq
	g8h65w7zlNFvsaYOEcvszuE0dP+qGoGnT6Z3JE4NmKMk/lAPzycergzv6TSA0RaW
	SeQPSOohqkh+N0gN5wjBmg/o5kJfR89Em5EyBqs++2vUhy1C+FCUKSPcrygm/54h
	kBTYM8CY99KUJ1pABZgDjUyWgM7qBWhU6ofgGux9vfOOX9mCJ7Ga6nR18tttBGvM
	Lrtyz5WXsYUitAWj/fO5qfdWS3M2J2scfFaq2/AqJUgaEDolJ8blHNH8DA3a9+E0
	QQ4BkjX3ycsKJI59V13F3IqXZX3dOTcSknNkFJI0TLlsDAH7XHrMNpVWnK1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749043957; x=1749130357; bh=JMwQyn34isJxlMD+mjno+SDMfv6cfX84nOI
	JpCmkVZs=; b=MxAQSNvA3krPJlzrcYB9apmRWbFiTVZRB0OVigWz5lzVWzxA2vD
	YxLIgIZ7urdjDxUTxBQkvtXnB26xcOGxiqz+eX0hhn0bu/lU+JH0nW7JcCZRDCLo
	vAURcqUXKETp4ReZaK32hRFFTLZnAZ3s4/WBlyOfOG94UxrCfj4VbWohcVFUDq9k
	1eo/kRdzaImzBwdVw2k0EVvdhe1fCu2XtQbnwBKwxQ+jC8PPUW6aDRVmV3j5l1sl
	5T+mS7JT/A1waWcARCxJkk1RSoNtksWGWQFC9FhvPJzD9TR3/0jYfM7zZAZH8BSy
	aQ/7j7a+Pt/YsqRtGk+H09ozAUIaA+7bewA==
X-ME-Sender: <xms:9UpAaCBboaR_8DgDmbFREQpn-mBSEkgbu9EHr_mhAdqgh1wUfFxyxw>
    <xme:9UpAaMioCBpAzLK9HdtDsVmGrjVkoZ53mP7A1cJOYfHy-285V5_KqKSWqunjCdzDZ
    oGw2PofA2TxXVdv1g>
X-ME-Received: <xmr:9UpAaFnlE93gv6kHzj3erQBxKXx1yHyhEjthDb8JTz66Dve2sYak1oTZ8HLdvWPVJyhTZwJYBPvFkxQjO82mykZJLXQBVZQ2nfG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishestghhrh
    hishguohifnhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9UpAaAwJduKMMovSLMp3abNf1nB29S5gg1AHM4b_TrtwDF3b3rd4CQ>
    <xmx:9UpAaHRmtnMUOJ5FA2ZHr38V_SeVcrV7NivqRUjqvNzZneZkj0qibw>
    <xmx:9UpAaLZzjLCCvz3GwJ25EhaSTNzLhQTf2zr1e9LyPj7w5x2Grp8WSw>
    <xmx:9UpAaARaKE6WUgfrX1rVJ56UAuDq1uYKla8PmGNvHE18QOmeT_oubQ>
    <xmx:9UpAaGPJjt_geymY2vzrWql6LJLpIjtKD5CIlJBgpVS8ECsqOLAHLrQl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 09:32:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Down <chris@chrisdown.name>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,
  kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
In-Reply-To: <aD6cJxFXdGfN2XGc@chrisdown.name> (Chris Down's message of "Mon,
	2 Jun 2025 23:54:31 -0700")
References: <aCM5JY25NVPgyYRP@chrisdown.name>
	<CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
	<aCTI7VjK5QMht3ws@chrisdown.name> <xmqqy0uy4thk.fsf@gitster.g>
	<aCXqqj6gKc7-fjoF@chrisdown.name> <xmqqldqwya5p.fsf@gitster.g>
	<aCdT-UQtaaTQ8gyD@chrisdown.name> <aD6cJxFXdGfN2XGc@chrisdown.name>
Date: Wed, 04 Jun 2025 06:32:35 -0700
Message-ID: <xmqq4iwvfx8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Down <chris@chrisdown.name> writes:

> Looking at public dotfiles, many users already work around this with
> global shell aliases for "commit --signoff". This creates the exact
> problem

Users conciously using a general customization mechanism to express
specific intent like the above is one thing.  Project giving users a
tool that is specifically designed to casually set and forget before
even understanding the implications is another.

So no, anything that specifically targets commit.signoff would not
fall into the same category as end-users creating aliases for
themselves to use, I would have to say.  And we do not want to give
an impression that we give tools specifically designed to encourage
users making casual sign-offs.

