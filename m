Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609991DF258
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987823; cv=none; b=ZDq6A7c06Mqq6Upxymbdu0TMFirQ49FVGX3t5mgQZs2erVkeQMNnA8u7Yhn9SyaMGaGMO7tcbYkjs6OQavhKcCX0uBIPSxWs+NPtkV84y0OXPHS67lUCSY0xxqispyi0n/eo6fzWY/hwELkfrQkSSJAlzoaReOSBuJLUJpJ9RtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987823; c=relaxed/simple;
	bh=IOHs6Yajdep6aF02fCYgGKy40eySXui7VgZN6VwT2SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWr5+N9owhY3+h/SDSaGqibkoTOK67IGCk++FPLoNl2CoGyb5CQbQ5UCKtFzZ1jkJMkllGFQmlg2bLb1npdtkmkuJfuQNwVlaeXsay68bAey/DpPYYpWnSpVNOl1rIjMp5Gs8u3jMOxMrwXzURHc9MdtIfnnVHfP7CUyaxm+xwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yDmue0pv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrD959G/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yDmue0pv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrD959G/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 951A6EC05F4;
	Tue, 24 Feb 2026 21:50:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 24 Feb 2026 21:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771987821; x=1772074221; bh=fZ7MxCp+RB
	sxHYNMgSGTqOV78+sHxbe5XUK0lSL5xeQ=; b=yDmue0pv64eMOY5Ui0jI5bjWqD
	wq0Dv2+fzyVshnaCpFf5U7QIX9Maj7p0bDbhwKEzROhJcUikLaw2hGG5oFHtJilF
	fBp4F1cgQrW2Gfby9eMkHm99CIAYO83OWGeEzEg/Dyh/evP7Ft5rYrEqxzgRNXXd
	nlhALuGPtsH0p2jSXe3mt0ErksnYqewLiodcgoABrOrWhUBOIb7lQm7lmjI/3bpo
	mSGAcTo9Fc3U3t2uomlMDTvIG9p7nM8rAf8FuO8BZa4g8GkWO8Jt+7o+XF8j9QZu
	hZWkA/JI3cS2Bd+TQ8Ty5uUyKenXUlgKzSpCoacb83FKEj81uvXKa9VaYglQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771987821; x=1772074221; bh=fZ7MxCp+RBsxHYNMgSGTqOV78+sHxbe5XUK
	0lSL5xeQ=; b=VrD959G/EVuz12znnpiOYjGqVCK4w/GsqpYZj6/XrAJmoOWzmxP
	ytBmAvwH1zH2PKKXZ6EKSky+YUupJ+mz5ErdmZY2/PR7sLzb1CRNtpPTxPaCsFKG
	Y5I/s64O7PBIC4PfhaKGW5FgqQZWf9s7/c5P/GLYrRpIW17cXQAj7anrdr6mfdDC
	Pq4dDDuWosd6eLm7ZVFtFK0GMZ2V/jkEAB/5ylPh8+W7DosJzg2IQ7WBkxEmmwD2
	jajfnip1KhEYifoB1H2rT9HZr4ZhDenJqDL2C+Hz/9y+BW1sNxdPLJ5xLYSfG8DH
	a5cwvNFWwJC4kiXj+Sr+cqP3f6rdh9gwsXw==
X-ME-Sender: <xms:bWOeac3FDV4UutXfGWr_gBfpeksANTSaC1Ta6baATOA8SUH9S5zPSw>
    <xme:bWOeaeEmvu2ptKZoOFEAgxgsMpXjhhiH4T7BIkFFRBs_v6cKhRfr6MA2Ej6UEUrj8
    ztBfngQf5uRkax3OwQX41nLaY3w_-hWioQWFZs85gZHlcXPvscvCA>
X-ME-Received: <xmr:bWOeaZ7BOnQOr9NVYgprrzhtp8E5fsrvJbnPpN6fNhyrHl7NWzEl7y2QFEbxZIvymsd4NbkWjMS03PJaM-ozteYTibRXnQvw4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bWOeaUtywKHnSNsTPH_wcuW9Uo5pDYnpFMUsdaSVLX05sdonin-UpQ>
    <xmx:bWOeaa5BBdoTfVOtcsAAU1acunlT_b-7Dj1JstbTbnf7IwSjnpf8BQ>
    <xmx:bWOeafWYPUw2sBtyKUW2OM4Bjvi67LZ3-h0UAnJVud2-Yx3sbSnOqw>
    <xmx:bWOeac9Rbc0ZAvJxlGy7gsW4tQM41yCZU5tgEJUYi0BCwk2M1BvwEw>
    <xmx:bWOeaVbZ5hrcUVulf8jnMMWQVtyDceI2tNFO3nUAvYnH9Hvs65IWUSGD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 21:50:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <e48c68ce-de45-4d45-8bd2-1307686a8910@gmail.com> (Tian Yuchen's
	message of "Wed, 25 Feb 2026 01:01:36 +0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
	<xmqq4in8quxn.fsf@gitster.g> <xmqqqzqcpatz.fsf@gitster.g>
	<5263825f-163c-43af-bac7-152d670919d9@gmail.com>
	<xmqqfr6soxjq.fsf@gitster.g> <xmqq7bs3piz7.fsf@gitster.g>
	<a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com>
	<xmqqwm03mfax.fsf@gitster.g>
	<e48c68ce-de45-4d45-8bd2-1307686a8910@gmail.com>
Date: Tue, 24 Feb 2026 18:50:19 -0800
Message-ID: <xmqq8qchcz9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>   1. Perhaps I took it literally, but as far as the original intent 
> goes, shouldn't 'read_gitfile_gently()' be solely responsible for 
> *opening a .git file and parsing the gitdir: <path> format*? However, it 
> currently executes 'stat()', checks 'S_ISDIR', checks 'S_ISREG', handles 
> missing components, and *then* attempts to parse. Do we need an 'enum 
> git_componet_type git_componet(cost char *path)' which returns pure 
> filesystem states, then parse it with 'parse_gitfile_format(const char 
> *path)'? I don't know.

Sorry, but I do not see what such a change buys us.

>   2. Let's say, when stat() encounters a EACCES when cheaking a 
> restricted sub-folder. Git funnels this into STAT_FAILED and 
> subsequently invokes die(), which calls exit().

Yes all this happens in repository set-up which should happen very
early in the process, no?


> I'm thinking of 
> libification: if a long running multi threaded git server encounters a 
> permission-denied directory, is killing the entire process the expected 
> behavior?

It is a bug in the way you wrote that multi-threaded git server, no?

We have the "_gently" variant for such a use case, and I do not
think we expect the normal single-process git start-up sequence
should be reused there.
