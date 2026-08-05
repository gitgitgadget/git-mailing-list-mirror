Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFD346AE3
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965926; cv=none; b=lFSHxw4YZv027wUs8eneosSTJ2AP2OUouU61rl+UL8k14q1qMf+ucXlGCaT78mvTgKvy4QJNtO0d4m7TtfAJyBymbu+n1ch0E7b2x0gAp11bSIKbUuA6eouuEQH97QaalWaDY8+z/sS+bMaAmshBCzAzBGpKrCQP8GMrMPbQ2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965926; c=relaxed/simple;
	bh=MPlejsnVzBRzccgs9wNAiNiHVav4zc6Vf1duY506oC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VA8d8DVdrBGGgK3IhSNkv3TMGtKdbdXOJl+jZb2Nqr6etIxbXlKLTAJ+mHhEhpLJkU7WM4CDIYQkE/GSEo8LxREt8/bFh1hfCGcfjOn6IBaVl/CJPB6wfTMTQIhij2sJ/w93KXqz6Pt1/wsf/Tl04GlpwdJMXRPATi2D94XK0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nd9pMymS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8f8IRMn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nd9pMymS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8f8IRMn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9061B1D00163;
	Wed,  5 Aug 2026 17:38:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 17:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785965923; x=1786052323; bh=nN7mKErf7o
	asMQY+N9a0r2EqfJron+M300/ZjnlY564=; b=Nd9pMymSyt+hLUVqwX7CSfsq9E
	Izn10ACg2hDxHep+xgh8Ox+/MdeYBSybbiH3hUwxbOVseur6Z1q1wAvuJIxfgi4O
	0Y2ymkwKwsPM2nx0/5QqtrubclOg6q81bReGHylP6DyFnIEBt2vs3wgayHDhWzi7
	+59XUqMWT5WL7kk64gowTQQcrea0tQb8lpDzW9p1ValLAyM4JUm96m+570pGwktQ
	HB+Y+QXwir/TM8mU9fweaKTAQogSSJE3lns1mKyZQ1nte1JsLYWZJmOS5Lm+9O5m
	ycV/x8XyDpcArZTGZAXgoKFVijiJtoa+1Eimwqqyp7tdaaw824fstmMVeYqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785965923; x=1786052323; bh=nN7mKErf7oasMQY+N9a0r2EqfJron+M300/
	ZjnlY564=; b=Y8f8IRMn1CH+5KQ5zfZu0paG3V8YdwIKS2gvDrnaJZ/GTborIh+
	SXpdwEecaYy8QyZdJgnZvPHIsHJ+0pZ/t79iq/8TZjd+80znZFmxBGkvWTJh52o5
	VwMk770/4ni/ZS4M7cr9H5wP83txBta3aYFS3+tLvoTJX8pKe9U/GH2VIVlJXAIo
	PwYu5M6m/k+/OKmiu+bXPVSBRVWjXVk8BJ3Cf0nvPhhC/o5o0q+MOXIOkiPxsO5z
	sY8oBH2DA4oumVxDauc8H920JPBPLVhJmPDfTsBPmY9ZMTTfxOASIfwzYDUKCHfA
	n62Strihx5EPwmcR/2on5R9dgqWfYGCxuXA==
X-ME-Sender: <xms:Y61zarY4nT5LYn3twERvLZKDyoc9AtysqkV-iwJWe2Pc0to5mqd8_g>
    <xme:Y61zauHqHf1g5diHVy_0kF4ldaWeqU2c84RnmVcdC57X1QaSOHe6wxpOMOQmzznyQ
    crSvwOnr-_XdD_7xqjohkCIl9iPQda6sbf2sNO2FbPPtUJsAaouaQ>
X-ME-Received: <xmr:Y61zanyC8pSJXiiHxkfSZEnKnP2k-SWgWG0bKk1OO7X-R-U9XVAawuhch4oATdAZeFVOCG0aZ8rUuizmZMv3jUIWUzZtxMKUNg>
X-ME-Proxy-Cause: dmFkZTEGj8v/nCaw5m8X8FS+PIg80ygz/nODx8p+IewDlndUXMk6S8KTWFZqnQJEmIIwwZ
    I9enHlMWwRhFg8SRv3bGfJOyrPSWCN4Q6ws3Dp7Iz7RxwvKz4eUM93/jwMwHTN6xMQA2X8
    ommSIXFTz5a4txDEcRK0ipmo41TvqeE48DsPs6E+JBCx8O/WrT72rS01bkGTsx0EunolwA
    hokWL45KaiLezo6cI1YjgxGIUJkCJ4nnEbHrW6EnqjqMY4YTS8nGY/tTDqxX9uHQCabT9q
    97mQUNSujtaREBVW5DP1JhKViO1fg6bQxc15LtM3d3ZR+1Q/BKAugqIGHyI6se5/rUh7JY
    my6d8Dv+AFKbMiVTHH2va8FtJotQG4m9Xj0SA3OzL1oJEZj++3N72+avs3qznzKHndIBGs
    OhlSMINha6PdcHvcaV264dtnTofaY63tu61Km2S6Uw27/IW5qOsog3ydRMbj4qO+MOVDAF
    9HMVAwVf+6WmdwHsyNs8XubcTtUbyn5XqUe1Fjk5clMQ6T/RBXXMKnamDeAOpbkAxdPajn
    lnlcSWs5eC2sNpaYvC1TPT6lZXwjJyDCB+pSo0Am3wEsI0h/N69h95vtOWpFDkCaiWJ68h
    KLr6CKBFrNpNGczflDBzRAK4aWK2qm18RMR25vCj/vOCMsCmGya90X7dRKiA
X-ME-Proxy: <xmx:Y61zaolmugIQh6DCaqsLfvdl8AgjuN6MeiJePzLakyAjB8s9nqXq9A>
    <xmx:Y61zaomNPlz9LIWOLa_s8qJg2lfmqlNg0RoN_lNsFX9eCyx2_Q22Tw>
    <xmx:Y61zaix4R1EIWUQrdUIquOGZU20x6psyO4C_i11iUbvehyzhaLe8mw>
    <xmx:Y61zalop_s8QN2J2MLu4-ocn38AypbMOEbBI8Hfiu5uR-kFiFtvnBA>
    <xmx:Y61zajnLNaOFlENvC16XvflxodabcNLvPBpf-imUnI7jH6LL-sAI1HSj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 17:38:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH 2/3] environment: clarify repository config getter
 documentation
In-Reply-To: <20260805115342.3939931-3-cat@malon.dev> (Tian Yuchen's message
	of "Wed, 5 Aug 2026 19:53:40 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260805115342.3939931-3-cat@malon.dev>
Date: Wed, 05 Aug 2026 14:38:41 -0700
Message-ID: <xmqqtsp8nt7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Update the comment above repository config getters to describe their
> common behavior.
>
> The getters handle repositories that are not fully initialized by
> returning the corresponding default values.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.h | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/environment.h b/environment.h
> index e7ec5b0437..30678257b5 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -175,18 +175,13 @@ int git_default_core_config(const char *var, const char *value,
>  			    const struct config_context *ctx, void *cb);
>  
>  /*
> - * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
> - * They check `repo->initialized` to prevent calling `repo_config_values()`
> - * before the repository setup is fully complete or in non-git environments.
> + * Getters for configuration variables in `struct repo_config_values`.
> + * These functions handle uninitialized repositories or non-git
> + * environments by returning appropriate default values.
>   */
>  int repo_protect_hfs(struct repository *repo);
>  int repo_protect_ntfs(struct repository *repo);
>  
> -/*

Two puzzlements.

 * Is the above comment block meant to apply to repo_ignore_case()
   in addition to repo_protect_ntfs() and repo_protect_hfs()?  If
   so, the blank line before repo_ignore_case() is a bit misleading.

 * The phrase "uninitialized repositories or non-Git environments"
   strongly hints that I can pass NULL to indicate that we are
   running in a non-Git environment.  However, the change in
   [PATCH 1/3] we just saw means I would get a segfault if I did so,
   does it not?

> - * Getter for the `ignore_case` field of `struct repo_config_values`.
> - * It checks `repo->initialized` to prevent calling repo_config_values()`
> - * before the repository setup is fully complete or in non-git environments.
> - */
>  int repo_ignore_case(struct repository *repo);
>  
>  int repo_trust_executable_bit(struct repository *repo);
