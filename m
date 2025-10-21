Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E2366
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080278; cv=none; b=JPZRicRmOoAPVYtXH4E5aKEI6anWemKnqnSrbB6T+9yp0Hp0cDQmloiHj5/yExT2u//oK5H2W7XJQjZG8GIwHY7a0+0msOeeDOoXMvgtJZ0j/yvcz3MS5xOuURUVC/HQx02KF3c7LW0l2rl4KpV9xJHDT1i4sVYQqqaFMp1Pf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080278; c=relaxed/simple;
	bh=rzGnkrUvJNvf9AOGD9Lff/BKfh/Hdto5seVISN0Ln0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5KJFkZYXMEhReOBb7zTswGtpr7KfpYT1hlkA75s142gvqxzfnB89gP5NwVewfBSgBxrvPsKFziotRWoDCFhxqkM6wwoYtpv0Pp3zaz947glHHXwM7Y3T14Hb8qWvxwtO3DEE3FSbHBlRqHbQseVh7OPaZVHY/CEbh/VfHX7AI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CkoCzzNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMsYYBp0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkoCzzNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMsYYBp0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0F727A012A;
	Tue, 21 Oct 2025 16:57:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 16:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761080275; x=1761166675; bh=uL91KfweEv
	uxxAty9Qfhskdnq//Bh/NqGo6HmapJlIE=; b=CkoCzzNj7JR6qs18EoRMx/ZCHf
	vWtOv+N5rk8er4LzQBXugRk7PTdVQiy+52IxXikno2xILhtUJ1DPR4GLBXkwkWFy
	SJwIG4254ce2ZKyuSv9m9TBVPDBDgNUt9XNmHSWOFOgVZnJkR6umyijP2/Sj7x9V
	UWE5Ttdofh7CSmBrxhUUYFw6OqS9yNgsgLkNO8FQZuR0HCCQ39tDHu/velQ3jzYR
	L4flW0vaO1h3D4roM5OLkHUu5JFRV4YVErew4S+/0DoBEghNFmdp6pGqLqKhqNNm
	OSyNpwGQulcvDAwOnQPvqAvgefylNKBql2thKbEYvAuPxeexfVu5buot0WYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761080275; x=1761166675; bh=uL91KfweEvuxxAty9Qfhskdnq//Bh/NqGo6
	HmapJlIE=; b=dMsYYBp0Qy62+oDOsVbAeUhvff4UzrDvvvVdL/60VFs/UMDGwnQ
	FRIfH4qvUIu/fKbmQNIEuGUhnLXsKDS/bOH4OE+4oC2Efa1pExUg7G6TiY3keGyJ
	dZLpp+bjguUS+tMnfifTYP4o8yb421+1sNdf2XYHgZBuC4fksAuy+qGRroXORzQH
	sWH8pLJOEWaKcnNmLLn+X/cMM9eK6yenCzl/XDvBe7yMy4/SL8q5cGudKMUC34Cj
	M/r+G22EqxBneWm92xVF65RmyneToq8Hadz0EeTyKClNXZiicKEe4lGSeKlgKWxT
	dDA5PmJ6DdeVyF9cP9t60VR1aDHzTCGOrcg==
X-ME-Sender: <xms:0_P3aEOvup2yLPSC7-1ATg8gyjxwnJuDbO5zba0SwhJGKIPJw4cfhg>
    <xme:0_P3aHi4ggXgrU0kNIGkWq6dGwVsVvj6YYV0rU7jLKfVnpQX0T9o_tRhLz-zlFA0D
    arZ9jVZt2eV25YFtck5i5_XQKVxKrgU_1drOVtemQ8RmvNWUAcUkg>
X-ME-Received: <xmr:0_P3aPuTqlxtSffLnFJ1E3nMZvxr6YJRKriREs10bdGVzsHVchNH8JsjXQ6R0dnDMZaqsV3Sy5bMi58U-wyP8lbY9IbfS1KjOelc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:0_P3aDiFbfsgylb6Szc0kP5lQkj820Lxj4wndWR3DOqhuIDmVYhu_w>
    <xmx:0_P3aNbgDy8bw3b8zmsFLuqWSaf7JY9Uk99C5BVeSvQ-vzll_5kbmQ>
    <xmx:0_P3aKZ2DQCqbfCfx6wzIcbD1xRVqI6JtTZZiyKcN6gnuATgjEJnYw>
    <xmx:0_P3aKwRHQf35FuRd2uaeFTGT3vCjGgXvnZb2qhOEY4AqcNOfQ98GQ>
    <xmx:0_P3aHfSzAtr8Gm-gn3wCXJ8PA-OQSpUFrUEoW_8Njr43VgXxRbmfbu->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 16:57:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 04/12] replay: parse commits before dereferencing them
In-Reply-To: <20251021-b4-pks-history-builtin-v5-4-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:52 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-4-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 13:57:54 -0700
Message-ID: <xmqqo6q0t1kd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When looking up a commit it may not be parsed yet. Callers that wish to
> access the fields of `struct commit` have to call `repo_parse_commit()`
> first so that it is guaranteed to be populated.
>
> We didn't yet care about doing so, because code paths that lead to
> `pick_regular_commit()` in "builtin/replay.c" already implicitly parsed
> the commits. But now that the function is exposed to outside callers
> it's quite easy to get this wrong.
>
> Make the function easier to use by calling `repo_parse_commit()`.

Two-and-half obvious questions.

 * With this change, can we lose the parse-commit call(s) from
   existing callers, or do the need to look at the in-core commit
   object themselves before calling this function so they need to
   have their parse-commit call(s) anyway?

 * Can new callers you plan to add decide without having an already
   parsed "pickme" commit object if they want to call this function,
   iow, can they decide to call or not to call this function without
   looking at the members of the commit structure?

 * Are existing callers prepared to see NULL returned from this
   function to signal an error?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/replay.c b/replay.c
> index 13d75d80543..c3628d2488b 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -90,6 +90,9 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>  	struct commit *base, *replayed_base;
>  	struct tree *pickme_tree, *base_tree;
>  
> +	if (repo_parse_commit(repo, pickme))
> +		return NULL;
> +
>  	base = pickme->parents->item;
>  	replayed_base = mapped_commit(replayed_commits, base, onto);
