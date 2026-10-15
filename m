Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49198392811
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087426; cv=none; b=oU4B0jAyjyhfpedeiA68Z4uxsWZvgBMN3ZD0WR7RIEazz+/vtJ6NO+HxdEfNXewvqTaMiHTVnIsQe1AxuBkkLZWxIn5GCL1oKQBI/QnMk6maBNStpiDCQYcrGcoTGpfu7CDn8C3HSssGNnKVjmyOL6Bbj8Kx3NNrr7FnJ+SJTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087426; c=relaxed/simple;
	bh=pF64kygpsSmr5wsEZWF3g7UNwqMVwqETcKbPKNn32DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E91EQan1hmfwapOY7f244yp/dYQ5F3ljPF4L3I1uX/364sIfHSBONjd27r4cKBfEvYiblUPzoSyMJDSBo8XvEl/yrQN+uXPmuS8hMHCVL77UDDyNcoE9zCDzZkgQeSCa2p8LbcUodY4OhyfTuLhbiKT6GWgsOD9x2pzAF++hXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HGhnDhYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cgj1dLgt; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HGhnDhYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cgj1dLgt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E1201D00127
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:03:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 14:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792087420; x=1792173820; bh=RWLCgug8lo
	K1sYO0w7Yr9ZHbTLKc1D9eCmxPsA4D3/c=; b=HGhnDhYqFPLALa1l6G3hiz4FRs
	6uG79ZG/nzhaUcr6utaRrtsgCvUbwtOU0xMMMLOO0hgiiatnOr6wPcgzicQ8Y+se
	RsI9yzKvEkGP1l1qyiAwS7nQE4JL+ILJOUTU6li7ZEsuf3Yf4wBRk3C3FNpkwmEj
	uPvJluABaqXRJe890jx0wsyd7MKTQ2Nj2aqW3h6bJ1M80+aiHhdFuNdDPyKEfP2j
	baT26A9DrfYw7VVUVddyBmRlfrCI33oJz3cLHdTfkbrJ2grFwP5UyG4IVx3Mzy9D
	xpyHMY0YMZlC1nnp2E3wtamnSyDPMCiXFOV4m+8mFTBldF6KWXqOvQ4o0bqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792087420; x=1792173820; bh=RWLCgug8loK1sYO0w7Yr9ZHbTLKc1D9eCmx
	PsA4D3/c=; b=Cgj1dLgtM4ofgCu1IHntETOqfq5B7KEBUZn2saIfoT2DgQhoCLj
	U3L4O96yQh5vNFSlsK38GTZaMkD1UN1kbHEBcsazaBjCxOfXqaeH1jEFWXQMsbG/
	hCiNWfQl6Vfwz+m6sI1JhwalScFlGctPv8Bba5sFY/RLsvJomtE2KKZGYyjyTc5w
	07BQhaNbq0tCRlVRUumn0nKsx+d6wyWaA7pZPXa/PhP62XjFmvtvFIpw3LITijXZ
	oTSfiDkxnDffmvTOsvxM55pob4zHkYYt8yNXmb90IyTjHLx6qZM2rflkPExmoQw5
	MQBAyvIJaZscPJBS3B6CUy42xqc3ClsbXNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792087420; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:N7nXrLKjOIre9icCR0Z5zPcB8J9+bDTq5qUAvvHTVBrZeoo
	juRempaokC+Pmja59dJDrIiHpqJUdySEwroLFB4uAr65jGtFoIz1bObeby+t7l+Q
	jWgKNOtrEbAAd4Xj/DflBlFoJ6gI1VsX0gsxH3K/SoEM+wkORABk49HfQfWc3THe
	M/CdfmyrrDpgB5HK9p98f1OIyS5hcA48DIt1HeOTQjlBbku6AwMt1ckuJ05glGZt
	lNL5WR21DSxqlQlXBEsDpdEyAn2fDQfgOpfpJszYeMmNffGWB8QzuFiOnZiMFT4a
	NFjmktR4stgrsYD8Ynb72JYwAIhXQQKOc8bPqpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:T6+Iwq/qo+0En/kWWhPjz2LqsA136Tz/a/z3hFtZHNQ=:pF64kygpsSmr5wsEZWF3g7UNwqMVwqETcKbPKNn32DQ=;
X-ME-Sender: <xms:fBXRamFbWTYA6jAelhOSI6wZLMVs61U-_Q6Qa1pB0vWk8RUmP4lt2A>
    <xme:fBXRauP0veJytEWgsR7v7ym8-3f4vVoJtEAQ4e5-fzjFArxc_N0B6-DqXJPm8T1Sp
    W4DewYjDuLSmhz0zKQrL7SEmF2Kd1DZuTUmUnvlcB7nKUD7M_24F5w>
X-ME-Received: <xmr:fBXRaofJO3M24QhX8ke3WJL0PswQO8xAOCnf5J-6jy0Zjiu7TaowDymkpuqsdBqP4QQ8mC_fTfJuN0uiTQhs9OXQPHRDA8cVKTBr>
X-ME-Proxy-Cause: dmFkZTFz8ONdp1IzccD/84WCK4icXxGXkV4M/UigdsACAKXzsVWolDwnxyDWm/7pFN23q4
    BoYz17I6zYfWvP8Jp/VfRUG/iyORBva+2WG2lxaRFf6hzlWaqT0be4XNz1l8ve+URlDTrd
    De8zNfrxPCiZ4Tx/quq8BLRWv5zeBvzjpKKY3hJq55GE30F9+gCsOrkOo77jQ4p8fVkatg
    32z0FetW0BBLZfWYZvpUyEdslNeXKbCUxaiD++gWoXYHACBu6/NTybOM9hmZlEMbn7wch7
    5UCv5VYYB9MkT0VbShRMMoqj6s4imnpkN3P71KUY2tt01LRQ2gj0pX7F0c2TLn9Rs63XrU
    uJKMqKtNjY2a51SAUsTLbL53D5eP7dU7+//UM50DDl/wtVX6rJNF0JQqNDsdjx9T9uOWt5
    9v4IKrVCkUbzzJqWvf7uk7OUXJFqH9GWHNVnv8svQuDnSUpv9E0U10dWsj6GMcKr2kho2b
    SAgv60BybQ5dB/n9ugVhntpqwLVunb3ph1axASNQ2TGDhVwEoP1HDy16WCPXF0cn9jw9BA
    NM3soj/GSvfEdfQqF9wHRTGXDC9txZKiJcRigpd9fyLwmThGTqYHmM+26/T5j8x5IBH60D
    95zNv49AtFlhPY91t0aht2u9w4qfU+RO91lo3jYtL9fHmWQ7N8vIddEMoudA
X-ME-Proxy: <xmx:fBXRartCmSe10vVLRI5yNqnQdyxsNJxp-tD6xcPLpxsPLcJDgEkQeA>
    <xmx:fBXRapkor3GKWEtCReVZ0LnyRWcj64_JRKmKLPllnWBpoBnK826mpw>
    <xmx:fBXRatwYFuVwNc8lZcqHb_acf1JJ_89YqcJMN9xsJmyTQxAFI5Vejg>
    <xmx:fBXRarOFx22hgNVInOSaSW8xsHJUaaSpd_i-Rlm-D25IeutMdAYcwA>
    <xmx:fBXRajdm0pL4_lVMXYtU8VeLcvtAos5kmUtxszykd8_QPYYCjFnzFCUy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 14:03:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Yoichi
 NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 5/5] worktree repair: avoid breaking unrelated .git
 file and gitdir
In-Reply-To: <015602168c8532c07b94c9f50925bf5d5a2ef7c8.1792012836.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Wed, 14 Oct 2026
	21:20:36 +0000")
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
	<015602168c8532c07b94c9f50925bf5d5a2ef7c8.1792012836.git.gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 11:03:38 -0700
Message-ID: <xmqq8q3yon7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/worktree.c b/worktree.c
> index 879941a977..86094307b1 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -640,7 +640,11 @@ int other_head_refs(struct repository *repo,
>  static const char *get_worktree_id(const char *dotgit_contents)
>  {
>  	const char *slash = find_last_dir_sep(dotgit_contents);
> -	if (!slash)
> +	const char *prefix = "/worktrees";
> +	int prefixlen = strlen(prefix);
> +	if (!slash ||
> +	    slash - dotgit_contents < prefixlen ||
> +	    strncmp(slash - prefixlen, prefix, prefixlen))
>  		return "";
>  	return slash + 1;

Just being curious, but slash is found by scanning dotgit_contents
for either '/' or '\'.  We make sure what comes before the slash
is "/worktree".

Could there be situations where this code needs to accept 

	"...\worktrees\my-worktree"

where slash points at the backslash before "my-worktree"?  Because
somebody wrote the pathname with backslash before the worktree name,
it would be natural to expect another backslash before the "worktrees"
constant, no?  For that matter, would this code need to also accept

	".../worktrees//my-worktree"

where three are extra/duplicated slashes (or backslashes)?  The
normal code paths to create these directories and records the path
to these directories should hopefully be using the canonical '/'
without unnecessary duplicate slashes, but (1) existing use of
find_last_dir_sep() might be a sign that we may have to deal with
backslashes, and (2) since this is about reparing a broken set-up,
it does not seem too far-fetched to attempt dealing with the above
two sample input, hence this question.

Thanks.
