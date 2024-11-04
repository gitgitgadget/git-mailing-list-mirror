Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C361632C5
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685911; cv=none; b=acFx5Izk6Zr3UfoLfcaQN862jldTYdYvNbiQg7mLWYjGnuZ3KByuHD3fMyFG3VhemaEVK8gRxDao8Ru64DJCVMecS6YXbIQ+bXcWqS9OXGnp4enTq40Ra1bn6RkeoiL1HoVdM+iu8KNRufzOYQsnYlh+pYW0s0nQ3lrTqqGmpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685911; c=relaxed/simple;
	bh=15x6caKqngZdkR502BVT0YRQ+Y6SKmE1PwveY8Wd/nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEbSNlT1G2W8f/XF174GetghqK108RaOfvaEysI5ZqGkUkCON+FSCggeT/Cv3nY9gLWYAhLDvMcaF+MbmzgcTuYCEKoE7yDh0hkEOe3XDu6Y5TUZtKfAHq6khVj7+jt9Jyfbq+DNF2+sa77trYF72WinHjeXpQUlDT56MU2HRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GJzR7Dzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHpxzw32; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJzR7Dzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHpxzw32"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C02BC25400DB;
	Sun,  3 Nov 2024 21:05:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 03 Nov 2024 21:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730685907; x=1730772307; bh=0+IAefbWFn
	i8693DbC44Le8NoEJoJsIzjdjLK5fBuII=; b=GJzR7DzlE+qEizqYpXXW+CjWW9
	L3ruhtiR7s8uTGJ6MKVoAn39J9xUDCBmFTy4MumDANXXro3dtersU6zGhVy2H6Pw
	Sl6UPfCkn6NRHvK2ACDTZ9dr1QzOIsqgwSYxjMvaHOFlDv3AslaB0X6ITM3JatV7
	c5TIG57VLCVJdqdnkRwhzPar/qfN7/IYwY9JJ6aupv1mnUeErJFQcxJ0hJ0Y0tST
	yYQfxrWPF4lscw4Dh3Kfl5xylLQEpMkzxTLHN5TW8lidpuUHAMCiMPUFRQ73AYBB
	ABmabgO6+454SfrxOlVxMcTLXxE5STJxwyufvPztLet6uyvW97e6nrJXZxyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730685907; x=1730772307; bh=0+IAefbWFni8693DbC44Le8NoEJoJsIzjdj
	LK5fBuII=; b=DHpxzw32jP0BWSM8ZAbnf7oMdfJlsJZv0tOdG+qW5r6wbB4dlkA
	EmZCevmQrCT6POvinOMIoBLgR3vXSUsAXEdZl3e2jFmFDXmDHHsvgSQroue1Fzbb
	d+qObDn5rlK8BaHZD1HSL4xivwrASXU2fXtQngOlvGrAHxtJ+h1s6GpkKpVyGOo/
	Hrf05TnBM5BLz+vM9BZohuyfrWmVdaeyxv9kWOokJPbudTd7K8vU2k/VB40+ig5d
	2J4uuCi8EhFSpbJ5Ig/usGTmKIQkZA5MGfpXDY4iiJK9q4PhXju1yqQtZ+so96Xx
	G89q/tlMPofMtFmpm6r089kVcGliCxGjACA==
X-ME-Sender: <xms:0ysoZ7rtmfNe5b8qM3WGNTRGlDYO5jstwFhHa2VKOs05AeJYWTKgbg>
    <xme:0ysoZ1pwjb-7orfxvZEvKTSJmdadCpKsHRa6p0sd1LobP2vfTXj_rCntw-lp76zVk
    sY9Q7GBQUPGGi3B9w>
X-ME-Received: <xmr:0ysoZ4MKgjgLBoTc28FIdCz526ca6ZLH6xIddVHzTgaMWm84MFF8wxQyIyuBZQPwmpXU21l6_ZcG4qN2tcT2eGD14Ah42Oxtf8DG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffje
    dvledtveejgfffudfhffduffdutdeuffdttdehueeifefggeeghffhffeikeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhinhguvgigqdhprggtkhdrtgifnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumh
    honhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegs
    hihtvggurghntggvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0ysoZ-6Xd3SCS9TSQSN5WOsQYKD_wCCojHUd1VUpLmzr4J4LAAKfPA>
    <xmx:0ysoZ65IF7nn_nZ2wnu6oR4pElgjDLFDfcq10TYpVKU3ADxqTOlQFg>
    <xmx:0ysoZ2jihB_gD0RUmgKykZVWVHFfw40YsYXWkEp_vCJBwQSQUO9FQw>
    <xmx:0ysoZ85neym2RwY31qU1NVfKwqeT9LIELArC9mJCC9bI1FrukByOxQ>
    <xmx:0ysoZ3s1pjFl8Pq0PwI52TAeSSmuRDqUixB91kaA0gIdbud45Urv1UJ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 21:05:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  hanyang.tony@bytedance.com,
  me@ttaylorr.com
Subject: Re: [PATCH v2 0/4] When fetching from a promisor remote, repack
 local objects referenced
In-Reply-To: <xmqq7c9jyhjb.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	03 Nov 2024 16:22:16 -0800")
References: <cover.1729792911.git.jonathantanmy@google.com>
	<cover.1730491845.git.jonathantanmy@google.com>
	<xmqq7c9jyhjb.fsf@gitster.g>
Date: Sun, 03 Nov 2024 18:05:05 -0800
Message-ID: <xmqq34k7ycry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> You may already have noticed this, but with this topic merged,
> 'seen' seems to start failing leak checker jobs e.g.
>
> https://github.com/git/git/actions/runs/11642458705
>   https://github.com/git/git/actions/runs/11642458705/job/32422074222#step:4:1964
>   https://github.com/git/git/actions/runs/11642458705/job/32422074132#step:4:1963

With this patch, t5300 no longer seems to leak (when the topic is
tested alone, at least).

 builtin/index-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git c/builtin/index-pack.c w/builtin/index-pack.c
index e4afd6725f..08b340552f 100644
--- c/builtin/index-pack.c
+++ w/builtin/index-pack.c
@@ -1821,6 +1821,7 @@ static void repack_local_links(void)
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack local links"));
 	strbuf_release(&line);
+	free(base_name);
 }
 
 int cmd_index_pack(int argc,
