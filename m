Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC3156F4A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024435; cv=none; b=MtsWuIMEKrE2d24yJSJ0bNmQOF5QsPDpGf0h0gp4qXFnQ+I60P6yc2hC/KpFh6kCTA8WdkB3Vqvo5QwY+eGvyQzH5i+rFiKnPAZ87ULSDdNBlMw9PQPAcMYfqllnDt9Di1rGdEZL5l7Synx+rEhhVl4dgFNZwZSy+VantNURLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024435; c=relaxed/simple;
	bh=+QNn3t3YALbAa7JWVDPCrruvAcVL0a0TNtWtPxcoza0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AKBDI/7UnJ7AoFuOstWkMLuP5krNQJEclvoimik28J6MM+5YaZ2pxpKsbgOOlWjW5+PXd46Phqn2SFOlQMov9yNQeRR+JjKH1y7ENU8VHDavGEWHvEPcY8O0+HGhFlAEUeH8AStqCRfo4arU8ey3c8boCLsjCRzgfKlwRifpXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W6mul03q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QEuKC4qL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W6mul03q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEuKC4qL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E696B1D00027;
	Tue,  8 Jul 2025 21:27:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 08 Jul 2025 21:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752024431; x=1752110831; bh=6cQp6KaOlj
	HPIZebl4IkQv/+tDhmDU21QssVLJ28FK8=; b=W6mul03qdS6czlpU0GHkSBIDAm
	K/QUODjihlhkAT8EzQaiPTkYVjlczPN4BjsfQHXe7Bqnl027eUDlT4MyAaCUHtK9
	1J5YM0dTOj3xMI5uEMVt7vEwa7mtEJX6Z0Tx2IASHBASjrDh2/UdZCjp628jAoue
	GlS4A/elHDAzCzR4GctHaX13sDMAL8HfLO0vOCPooh7zDGF1SborYbA7OfCLmoVd
	GxrT2t5FrZAJgNoyCvO+TAdPm8eMb8118rusMV/YZyb8lq3Lrlv2eXp6WsT2QO1z
	CtaUFd8noqV3VxXhrpRrDWBNYJz9++DcIdXbYV9J6yjJP+flx0Otk1jDoxGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752024431; x=1752110831; bh=6cQp6KaOljHPIZebl4IkQv/+tDhmDU21Qss
	VLJ28FK8=; b=QEuKC4qLAaEHK4UfilMBv0oRTlMmNM7/raNb19nCuH3UbnWcWgs
	UFA/Iw7SNstcD7oeiXnYdxeLcQMlM2D9GhAE3SF5LudLKCFcywwEc3XUM4zc6/5H
	5ZQ6cmF7ncy8MQp2ETWEWdX/cWtokinH2oFpuj9eaMzaMV+duVPRFcZFq5KObkOl
	0ilvyFAcKI/LmjdO1QuzidFZ34Vtd3ls3Jdf2CwweQhXWnXkYQbN/Z70DDCF/iuV
	epXf9QvzwPFH2KNXJ4xMlkt8wt868+btV5WnqVTkgOjwCnkEkWw9QjON/QDpgtdT
	aumWDrEzSrTSj3RPVb0vOtKeebb2gshVsTw==
X-ME-Sender: <xms:b8VtaIyhUNEUacTU3YI_x6ahPFvApcF0-DBjVioI1lfRF4Fa_hCpuQ>
    <xme:b8VtaJ1szNCmQA_zdMTGz4fHkWwSxR0RXu4q7idgQTGVrDzl5Sn6EYQ_Bk8SBKGAu
    Bf9R9YMGHLmS7GaGQ>
X-ME-Received: <xmr:b8VtaAy7CmbIPOkSX9zEuBvaFEzqiK09gAXjuzlEWWZUxbqJFpE1R_H8BuTc9Zq1QL9vaHUNuWR3E2b9JyFb2THXkyAO8084iSIf-Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgv
    nhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b8VtaIFAYzUDAKRuyq_LEi4vkOHTPSMTDbad7G2CHfB3MtXNVufQBQ>
    <xmx:b8VtaLa8b46YGHSoHn4gqdEi0ArVRFq8dnS3oTcav_c5CyH_FyoxBA>
    <xmx:b8VtaCA5wUh_32hScwAGX7lBH4IfYqfpcqYRoh5lQItD4HPXmeoJHA>
    <xmx:b8VtaLkNgYtwSRopbAynUkyveSyzy5jiPCtTEpTCB-W88NaZMzfdcw>
    <xmx:b8VtaO9yeBpjX-DXqDNaAyk6CHlfgX6uQtgHJbanJJ8zc6gZRtEtd8Vb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 21:27:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 8 Jul 2025 14:56:50 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Date: Tue, 08 Jul 2025 18:27:09 -0700
Message-ID: <xmqqy0syp30y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> This series implements the plan to deprecate and remove support for
> core.commentChar=auto outlined in [1]. This feature has been the
> source of a couple of bug reports recently [2,3] and as explained in
> the first patch the design is tricky to fix.

FWIW, this fails some tests that expect "# commented lines" by
treating "auto" too literally.

https://github.com/git/git/actions/runs/16157263228/job/45602188411#step:10:2970

I wonder if our braincycles are better spent to actually perform the
"tricky"[*] fix than deprecating the feature and then perfecting the
deprecation process (which does not seem to be without cost either).

 - We can and should keep the "auto" magic and use '#' when it gets
   specified, if we really wanted to do this deprecation.  I am not
   a huge fan of it, though.

 - Or leave it as a known-broken feature in certain corner cases,
   which may motivate some future developers to tackle these
   "tricky" code paths.  If we were to go this route, the first step
   would be to document what works and what does not as "known
   limitations".  I am slightly more in favor of this than "we punt,
   because we cannot fix it", but not by a large margin.

So, I dunno.

Thanks.

[Footnote]

 * Essentially we would need to collect all information (like hook
   output and template files) before we produce our own message to
   be commented out because we need to know what symbol is
   available.  Such a change may mean a major reshuffling of some
   code paths (or worse, some code paths may have to be made to fail
   and retry).  As long as the damage is limited to the case where
   "auto" setting is used, such a "solution" is acceptable.
