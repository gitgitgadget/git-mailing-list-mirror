Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D62FC006
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937031; cv=none; b=IIbzOD9/1nRgs/5cHaCOe1yFWZxb1gmCwwEQEbQKgtGMWF+AXSDVhXdCfhmZrJJKhiTqmZMLDbYCSv7GJGvxrgS4VWWt2BxEBKWt0dGfCvbJmqcbWisvinvQxTn36KNUKpX3z3vAUbbWzwm6B0JfkNhGTDTNM4C1bxZtZC5CsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937031; c=relaxed/simple;
	bh=nV44V6db3F2KZ4jNB//4EEtmDdLQVxLjiHTHgGhiCLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRPAUpJ3jJLz7k6hGlwUzblhTb29RoeArOSqclDL+Vj5+z3klRWPmKL0K68zD04ZiSTqp0GuaOPahpO1wEOSsfZrqw+reB/srzE8gSwzpKH6PWPNdxw5Z2WgOpzlhdllFvgybD0hjMTDlfx2Mh5T2KeInBnm0jlcL+mwI72y1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JKS0nPJa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKJt+8GD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JKS0nPJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKJt+8GD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D7341EC05B5;
	Fri,  5 Dec 2025 07:17:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 05 Dec 2025 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764937025; x=1765023425; bh=pYl0hRWab6
	0IcyjCf8c8h71OUqwY4YKQjEOzBSYeuXI=; b=JKS0nPJaVkVWsVbL52QRMWhzJj
	HlJt9hkYu92k9+hhNl2SVmSwmhhi5dHDuOI+jN1KNIkyiqc+6wF6NTdNsbE1yGwn
	pdTW3pxsLS/up2d6uV0SmZhip3FAJxmGD40NJQKqo5JTf4rQoVcGPvEH0Q/xkGM3
	QmM2qbGVM7d9eW2lnvWJ3DSdPM8VjsXJQgYMQ0g9plE4We1HV0gc26bwqQGmOxrK
	IkyK79hMJa3TRS2yY0IVGSXcR2GM6xhlRByzA3L6a/YNAgPYy2LxDomVy41f8+d5
	lzRQfxLogUUQmAv1yFBn8iUbZOJPOana+9Z8ewa99/moBgo/0UH3b9V2qOzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764937025; x=1765023425; bh=pYl0hRWab60IcyjCf8c8h71OUqwY4YKQjEO
	zBSYeuXI=; b=WKJt+8GDUDae5g+CPuwaekUfZjhHEUAbJkbxDOlnann61VT2kGQ
	X0/Y3x+c6SEPqCH5po7XYWYrGgEgWCX51U6rnem/Wc084Pvl7uS0VrVICYfBifVL
	VIBttuz/qFjUZiHIP+aVq9D4/arDLkcvPqsECYpIDfQ2IIGp+ScREo5N91riWoK+
	6tu4WlsbIMAtaE4/KpIrc5prKjor6QX9k6IX0fAeOyFNC1UoO/N80h9Bfkobn8W2
	IS1HfV/hQSdhFt00s9vG7acHPu7FriI5ycTmUEFe+IpFCs9iEtZT2tEU7S2svczd
	VUd7qkcmqlwkDWcGGkkWSSmSjzoImWD/Rrg==
X-ME-Sender: <xms:Qc0yacSe9a0BaZCq-BSY_qqp2ohXZTgT7udtlNg6ObSNebIpEcHJ5w>
    <xme:Qc0yaZdzY5zYVy-nBRmVe42GQGxLG1UAm_gGXzxeCZ2U2YJMLmYrfuU4_Y32m1oe-
    oBEYDtc8hO00Bvt2lFVH-ojnqS5y0hvWuBq_91u_gudwL-SLYGc>
X-ME-Received: <xmr:Qc0yaVdn3tNdRzHPySPQa8tRDuIsfqraAp8sthk5mXp-Nrx0yElFdQDLt4xbBEZr7ZJINo7XQtwOaxMZ8czHXJ_r8CIMZF8uPiR2wYmO9sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    dttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggurh
    hirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopegsvghn
    rdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehruggrmhgriihiohesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Qc0yab1tDLRd-ippfYAknLBlHRfCUWEUJoxkUNXCDMaanSJgd4Rl3Q>
    <xmx:Qc0yaV9aA9vl6HYHUAQ8PaR4lbu09TnM6dYgJT6UEO7QkXDOdUHUEA>
    <xmx:Qc0yaY7v_cQC7tF4-W31VVt0lSF8gROV7zjQSQj1JQR5KKGTrH577A>
    <xmx:Qc0yaVv-cb0hqGI9v0_zW_tTY0uvFT4ASW_Wc5E79kreawCclGu5CA>
    <xmx:Qc0yaQ8zYQIbcTElJqwhcnhU2dL3W8d58lqHvvku3BwzgGsRhOWxjZ4->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:17:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 220ab93a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:17:03 +0000 (UTC)
Date: Fri, 5 Dec 2025 13:17:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/7] submodule: always validate gitdirs inside
 submodule_name_to_gitdir
Message-ID: <aTLNPKlDnsNzyZkC@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119211030.2008441-4-adrian.ratiu@collabora.com>

On Wed, Nov 19, 2025 at 11:10:26PM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2873b2780e..9914ca0786 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1780,23 +1776,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
>  		free(path);
>  	}
>  
> -	/*
> -	 * We already performed this check at the beginning of this function,
> -	 * before cloning the objects. This tries to detect racy behavior e.g.
> -	 * in parallel clones, where another process could easily have made the
> -	 * gitdir nested _after_ it was created.
> -	 *
> -	 * To prevent further harm coming from this unintentionally-nested
> -	 * gitdir, let's disable it by deleting the `HEAD` file.
> -	 */
> -	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0) {
> -		char *head = xstrfmt("%s/HEAD", sm_gitdir);
> -		unlink(head);
> -		free(head);
> -		die(_("refusing to create/use '%s' in another submodule's "
> -		      "git dir"), sm_gitdir);
> -	}
> -
>  	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
>  
>  	p = repo_submodule_path(the_repository, clone_data_path, "config");

Hm. This one is a bit puzzling to me. This seems to explicitly be a
check about a TOCTOU-style race, where a concurrent process might have
created the parent repository after our initial validation of the path.
We don't call `submodule_name_to_gitdir()` inbetween those two calls
though, so why is this not a concern anymore with the unified API?

> diff --git a/submodule.c b/submodule.c
> index 35c55155f7..8ef028f26b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2153,30 +2153,11 @@ int submodule_move_head(const char *path, const char *super_prefix,
>  
>  	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
>  		if (old_head) {
> -			if (!submodule_uses_gitfile(path))
> -				absorb_git_dir_into_superproject(path,
> -								 super_prefix);
> -			else {
> -				char *dotgit = xstrfmt("%s/.git", path);
> -				char *git_dir = xstrdup(read_gitfile(dotgit));
> -
> -				free(dotgit);
> -				if (validate_submodule_git_dir(git_dir,
> -							       sub->name) < 0)
> -					die(_("refusing to create/use '%s' in "
> -					      "another submodule's git dir"),
> -					    git_dir);
> -				free(git_dir);
> -			}
> +			absorb_git_dir_into_superproject(path, super_prefix);
>  		} else {
>  			struct strbuf gitdir = STRBUF_INIT;
>  			submodule_name_to_gitdir(&gitdir, the_repository,
>  						 sub->name);
> -			if (validate_submodule_git_dir(gitdir.buf,
> -						       sub->name) < 0)
> -				die(_("refusing to create/use '%s' in another "
> -				      "submodule's git dir"),
> -				    gitdir.buf);
>  			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
>  			strbuf_release(&gitdir);

The second case here makes sense to me, as we do call
`submodule_name_to_gitdir()`. But in the first branch of the condition
we retrieve the path directly, so we're not guarded by the validation
anymore, are we?

Patrick
