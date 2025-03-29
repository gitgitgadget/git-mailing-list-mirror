Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97632B676
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743273410; cv=none; b=PW8pPyNftYKf9Ud9dKSME180L6WvT84hvTikig4dzzJH6IB16HHSXx+/80Z1uUe4SS2mUSYNVPW6jS0fuZR0dw+YpA70JbFiT113Jn2NV9w5RbFfizkt4ZtHLFfe1AX11V754mSToVYI5u6JoQFMzfAimOSheo4lobTiGWOck+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743273410; c=relaxed/simple;
	bh=+OOz9pDxzZOB1VYLiPOfHgPeskZ9rgRovNaSCugzKdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DnuIZmTlkt+yguSmYpFKfVBwkljRxM2C1F/FYgRdnwVvgKpOF/7ynEe+4NhZEMgNAjxoasqAjkXxZSVQmrXpEzVcJh7qfslCAH6O4LKuagqUEddoUJGMIrw6TIcW6VQGXeZut4m5g6ezIyr8KVGvAldSDcDPoPSFt5inx06g6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xHNI4V8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFQGhmJq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xHNI4V8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFQGhmJq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79B792540158;
	Sat, 29 Mar 2025 14:36:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 29 Mar 2025 14:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743273407; x=1743359807; bh=yeD1sk68ir
	nl3rirrrop3TKKum9w02sT50n1gCZ5B/k=; b=xHNI4V8/CV22fxxypPu7zE9A0Y
	yhySf1N/h77jDHbwghNUqlzRAVKcignGo2cVGD/Zv0IMfhpjLT4a3voRlaXaPAdQ
	OmsnC1L5RKZ2AkqqzVDpuOcvYSMBoP5hELHYQ4DzoPRCM7v9Z4gYPEu9xAvJ0zer
	Y4X+d+iV+3rO4ZvV4yj8I8oQlk9aN8X3ZBhLJXCzEO4R+jYFKZO8jpnXXrImSeSX
	34lMTc5BRA3Jp1UilN81nggVmJ2JMb6Ey0xwOO0m/7MO3b8Z+ryqhirOlGFIuXMY
	l8kRjRo1o8LCkW20NBkxUV/pdCEYG62lX32hxssrn/VTHb01Cmo+trl2JjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743273407; x=1743359807; bh=yeD1sk68irnl3rirrrop3TKKum9w02sT50n
	1gCZ5B/k=; b=eFQGhmJqzFYQBmT1KrOITSguDQahBOwduCdHdFyhrmc+pL56aBQ
	BQcs1irIf3bCWl9AI+sd++7OKmN92Dl6/pvRI0aql6S2eeEfHHdUtOqOptzn8XsP
	597pwfz262fo7u4WnoSnigg2pPGawSZ4T4g0mcUVOZYRSliuWMnkq6k94i8xzpJz
	v3u/EK0KHayuykzNZBa9qoGyxZ+RsXSIIZn4b//LgfjxOK5n2n4EySb+p/6RSCfb
	RDwufWRF6I0jaLR0GCm8RvU3vFXTE+4n7AvdFddy5AagjKRnqHqxutnEra2VC/a1
	aDspE8VlH/cAzb2mAxAoH/Y2pZeE5Pv/CXA==
X-ME-Sender: <xms:vz3oZ255ubWSQp8bzwwbMQiFrpBX4Yc3kIR88EBHjVAVivQAQsJecw>
    <xme:vz3oZ_6jb6A83MfquxjJcXI-sLVs3k2zjBOVbxv05YYBfp-k3TAzxjjD9s8o0ZlMK
    QcNBpFC4H5PLZ9Pww>
X-ME-Received: <xmr:vz3oZ1dfZwb3koGI6xuDjDVBxD2esHlfVxaLI5sqWG8RmjPSBZcVgsN2GHXGHnDsuZdf-_dRq1r3lypQ8gw9tQuIJqi-NHsXkb9J1Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhrghtvggrrh
    hnrghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vz3oZzIuwzQKwG6l0f8uzb254In75rlscPnaGvM_jmWPqHkTkDSatw>
    <xmx:vz3oZ6Jb9wDX3VafhIPx2P18TuM4Oc53vmzgdqEKFGpMojS9j9w--Q>
    <xmx:vz3oZ0ws5BtM5Xy5erAvj4OzMCIpIzgu2dtemXzNTs1gLQFkDWkhAw>
    <xmx:vz3oZ-K1oBD-HPpk_dcSeOKIwmUE3gt9X19kt5s9VkZpFCdvlAo_Mw>
    <xmx:vz3oZ_FeSvLIAtlqEeooAANwATaKahIa9S0euVSuR9f6CIskX_q1qpxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 14:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC PATCH v2] pathspec: fix sign comparison warnings
In-Reply-To: <aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com> (Arnav Bhate's
	message of "Sat, 29 Mar 2025 11:47:36 +0530")
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
	<aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com>
Date: Sat, 29 Mar 2025 11:36:45 -0700
Message-ID: <xmqqr02fd6pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnav Bhate <bhatearnav@gmail.com> writes:

> @@ -43,12 +42,12 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>  	 * mistakenly think that the user gave a pathspec that did not match
>  	 * anything.
>  	 */
> -	for (i = 0; i < pathspec->nr; i++)
> +	for (int i = 0; i < pathspec->nr; i++)
>  		if (!seen[i])
>  			num_unmatched++;
>  	if (!num_unmatched)
>  		return;
> -	for (i = 0; i < istate->cache_nr; i++) {
> +	for (unsigned int i = 0; i < istate->cache_nr; i++) {
>  		const struct cache_entry *ce = istate->cache[i];
>  		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>  		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))

Makes me wonder if it is a nicer solution for longer term to count
items in "struct pathspec" with unsigned, not signed int.  A local
variable that needs to hold the number of items plus an extra bit
that signals an invalid state (typically denoted by a negative
number) needs to be signed, but a member in a struct that records
number of items in an array in the same struct has no reason to be
of signed type, as the invalid state could just be represented by
the .item being NULL.

But let's leave it for later; it is not something we want to leave
GSoC students to handle.

> @@ -845,7 +844,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>  			 * - not-in-cone/bar*: may need expanded index
>  			 * - **.c: may need expanded index
>  			 */
> -			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
> +			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
>  			    path_in_cone_mode_sparse_checkout(item.original, istate))
>  				continue;
>  
> @@ -860,7 +859,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>  				 * directory name and the sparse directory is the first
>  				 * component of the pathspec, need to expand the index.
>  				 */
> -				if (item.nowildcard_len > ce_namelen(ce) &&
> +				if ((unsigned int)item.nowildcard_len > ce_namelen(ce) &&
>  				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
>  					res = 1;
>  					break;

These lines in these two hunks are way overly long already in the
original, and extra casts make the even worse.  Perhaps fold them
in the middle appropriately?
