Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E982459E0
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946086; cv=none; b=g9yRhYs9p0Ri8dMZMvz3JyPwb1pCoyxO+AkN/7rn3v5NsH1hMUUE+3IJWjgU3UuiwiT3rPcAJToTG0hoKn1KSobQIR/q19aUvOtI0KBuhni4U02ZnOo/3gJlTa3VNPjV4G74p+b6SYdZyjHHO5D8NJXb2r/2z1LrAWDvMv4JuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946086; c=relaxed/simple;
	bh=7P1zhqvyxeADd132WZimmPJcqotJkf1vh+GKIKelcDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sx98hgRJcqgD6PZPxFc73HYBfpItlGLeS719ICjH90tvG/UdgJWwX7I6KpcHUjD0ZE/IVAJgb+GMqiiwYyLAIABCoKJRIkUO/hnAMRI9h6nrrAp1Dd+2DA8je5d0DJU1JlA53iOHv/FUGYQ2i3+Y3Uh25d7zBTaxzo9p72L83xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S1hGcjBQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZEhG7rd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S1hGcjBQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZEhG7rd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C05201380155;
	Tue, 29 Apr 2025 13:01:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 13:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745946082; x=1746032482; bh=YDhezVznz/
	icJ8bDUet4bAVG9QnGaeO3D/mrBBQjL8w=; b=S1hGcjBQi1KgzN57biR6gQ9ji5
	f0loFTIX2ICbFn49e192nizCnKGboQ+DwjfR+MiiOgSDuElhKbKXj7i3ZYQPD8wE
	CHwZ9UXoZTxy6Wuh/lgy9fBKK/nyEe2Ll1QLus9JeqwCz7YCdLT4DA95Ctu/LFr/
	+lRrGXuzgDspjBy7fj6hfGSEVJmWQD7EeYSqG8d6pfBThMkO2RXUG2aHcFl962Vh
	QatQV7MX+3gdh5vWOXG8aV8KwiMjuq6uvldAGiXZ+FpR8g1wxJVro3/NLkXap0uS
	DpPdhJvviw52b6bHVzu4vuoPBrBk1XnJ7IXFljqdaK9Ta2ukVXWS8eoCEcZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745946082; x=1746032482; bh=YDhezVznz/icJ8bDUet4bAVG9QnGaeO3D/m
	rBBQjL8w=; b=rZEhG7rdDost7rcn06K8ieuS1mJSRPa/k0yUmGN0ec+HL0H0jTV
	Q7zKNPtGAqmAATuavfLHV7vR9JBjI+CbqTcbzihDwsqYW7Ie1kxQvMcDbxNp8ySi
	DvBQOfVuWbhVnmAD9maJHgT8eY2XhYJYtdi7EwhFCGkmOhninGgHpL37xcpg75kA
	dl+JW4EcEpH4lwa/j1xEG4AyReFDhwIF5T5TF1u4/m/4bUSf+fmemac2ZnjDkwPB
	BeWB5xKU35odsHvLec+YQUORV6gCiixlvJlRnCLDqrjMXntqRkbzUkJga1F7dl8E
	MhXJqci+PD1GFFJAt/GMXQozzEiO1+YredQ==
X-ME-Sender: <xms:4gURaAEIYRy33rTLw2MaRB_Yo3CYkKDsNHNG6CgYMywc_2j4z8QHhA>
    <xme:4gURaJVqY8kYZpJSEHbwD2xMgAE3f8PIVummdFzNWB14r796aexg4yztgcFToDKbL
    lT7thtL-aF-VCkJqg>
X-ME-Received: <xmr:4gURaKKX0n_C6UPi1nXxrLCj1srtfoeVM9VO5R92dNFSWoltTjy0Blkj8sWZzeyiVNg5qpit_j2NUhjndT2QwO3EB3jxL0t4A5FF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4gURaCGIISsytYK8lfssRjWcSVbHEZbsW3ffgI3pw04K9PoHNQQ7iA>
    <xmx:4gURaGVgRNZhab19R3LdbxFXWz-XluBcrV7hM-2eX50v5ZDCXn1MEA>
    <xmx:4gURaFNlup2BlhmAW_G6wr62huRLbtHgGW_r5_P3uQ0HJJT-YxboRQ>
    <xmx:4gURaN1Hh3RZu6LlUMxV1yAKPC3mgrSPL32y_DAFmQYvjJkKeOjNYw>
    <xmx:4gURaOAWGcC14MYGYfYCmay3sVVmPPI9_qcs3ZTuW1bgSHHca-ybO1LD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 13:01:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] tree-walk.h: fix incorrect API comment
In-Reply-To: <pull.1912.git.1745941503913.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Tue, 29 Apr 2025 15:45:03
	+0000")
References: <pull.1912.git.1745941503913.gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 10:01:21 -0700
Message-ID: <xmqqr01a6gwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When commit 50ddb089ff68 (tree-walk.c: remove the_repo from
> get_tree_entry(), 2019-06-27) added an extra parameter to
> get_tree_entry(), it did not fix the ordering comment about the meaning
> of the parameters.  Rather than just changing "third"->"fourth" and
> "fourth"->"fifth", give the paramemters meaningful names (or actually,
> just take the existing names from the get_tree_entry() definition in the
> tree-walk.c file) and strike the comment.

Please drop "and strike the comment" part.  The "oid" and "mode"
being out-parameters is significant for callers.

>  /**
>   * Find an entry in a tree given a pathname and the sha1 of a tree to
> - * search. Returns 0 if the entry is found and -1 otherwise. The third
> - * and fourth parameters are set to the entry's sha1 and mode respectively.
> + * search. Returns 0 if the entry is found and -1 otherwise.
>   */
> -int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
> +int get_tree_entry(struct repository *repo, const struct object_id *tree_oid,
> +		   const char *name, struct object_id *oid,
> +		   unsigned short *mode);
>  
>  /**
>   * Generate the full pathname of a tree entry based from the root of the
>
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3

	Find an entry with the "name" in a tree object "tree_oid",
	and return the the object name and the mode of the found
	entry via the "oid" and the "mode" parameters.  Return 0 if
	the entry is found, and -1 otherwise.

or something, perhaps.

Thanks.
