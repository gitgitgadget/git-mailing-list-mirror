Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08842D77E9
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937162; cv=none; b=VBeJMo4wAv3OLfWFK3h/hEAGbk+cExanI9ooY+7/mYPJj1QXFvC2L4ESUdPdulX2q2c/dLDkS9EishviB7LfOolW5mpPaNDQTtsT8OuADOhgp0PnN/dq7lPD7BTla4Oh6dx9fRZqCf0CyRVmyG28J9/txDjASNGwKPMil3QmhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937162; c=relaxed/simple;
	bh=pV3NAeypSSYk//piMaJ/OTEQZeEgBp3YnDdTsSwVkag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDgSQuWzMNSBRwUhr5xKCj5rCk/Gox+8XYyqUNokjvq1fBxcoRj19+PKNZuHbanYyWON5UtZfJ6ABW/cP1XDvDTcBB4jw+gzkBiWFfzaio54gmimChK4X2miYWxf8oK7I5Y5oqjKLBAjP29icDbzOI/PlK5afrKJMRoekVTVakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BkiXv4CM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZbFsO/yu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BkiXv4CM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZbFsO/yu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B37414001EA;
	Fri,  5 Dec 2025 07:19:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 07:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764937158; x=1765023558; bh=tqL8BPlEYe
	8SvaMSH3Ti8XZ/Be+C+himwaXieYyGSVk=; b=BkiXv4CMeJlR101Qf230/hoWe+
	tzLMFkMfZ5TTEeqxz7vm0a2GLQfTSeGR6dD6LlggmzlnhcKsRkNT0EUfVKgEq80y
	tVritpc1jwAO1vcU1aNsPX7a3Vti7kgR4rvM508yxZiFW/mJcZkOS9lTDZZp+50F
	mTawO15EIrzRzZIptkK5elmlAt5A6FWRIrZlV/pSxRpE0kHGinBOvmf2R382seBS
	ywJeMRGs+zW5knUrwSTdBOgt9FuKj9KTbBjtjmvMifICiIo4qz9ppPjHEUfzeceh
	3YW7YVePo6LY0BnT4dhnmiSdrwH6YihZxKw9PYI79h2mfeFDuDvBcQch+tSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764937158; x=1765023558; bh=tqL8BPlEYe8SvaMSH3Ti8XZ/Be+C+himwaX
	ieYyGSVk=; b=ZbFsO/yunUtuL3aSCmT0uMF26a6gx4iVFmkaAyQ9oUjQ1/oX4F2
	S6AlK6HrHeeIWmYT0/CCygLbiYLt5gowgnq+TEUdshKgC1QxSmY46Hrtk7+i5bAr
	1qeQNhnJww26MGP8CnvxfJ8pupBKC107gsjqMJTQuO+ReUDioGLL4qIqQ7S3yv/l
	CL4zvHwx7HIU8Mow/MIo+TgCxLtp8pVh49PAdyzgZ9zlvNCyhcgB/4SA/RKtbmQO
	S1xYfZuIRwNfd7n79bl0oh8jcWYWiGq78btWaqSal4V8YAp6JC3/6qj3OwUfyNG1
	XWCy+sqbaRLBFvi8+W39moEfva8PxXxDf8A==
X-ME-Sender: <xms:xs0yae94jlgtjDKp6exEpwbZ5PJGRVlC9ndtqvEAIoLE9WdyYIcZ8w>
    <xme:xs0yaaii1TCtSPiVWIFDwe3BK3xGMQC-eXmnU-PtusdNTZxi72K3AljueLwn-tD8l
    Ei5USWNFwD2BPzt5GqRSQwX4OB5dcuqjnQxoA3e1IU-GbpEP0XtrQ>
X-ME-Received: <xmr:xs0yafZqSiacPC_nYcYiDunUw32-fzMWzqE1RwyFYLrjAADCFiDhvmnlkmN77dSrRh3g1kYPmwEnsdCzsLMZ1ZkGw4qShbOjJmgRlCoFk3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrh
    hnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthho
    pegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:xs0yaf_LPkt9m97pIBh4colb-_GrNjDrgENTJhxkgwmxSvXEbUucjg>
    <xmx:xs0yaROMoux5aMNL7eZ9VZQcBsOOmA1Fcp1oP2v40Qc6ELdWHxHzjQ>
    <xmx:xs0yacGHkZE1TJHtlN-1R-SV5kERx88wKnqgTSgkFMtXEpy_0SV1Ng>
    <xmx:xs0yafxAcwhUr-dFL6C7sKoYZDcjO7sHC_HtxCcE-0zsr0uNyrq_bQ>
    <xmx:xs0yaSagG_d6J5aLIIt4VcgD2xuItC9yATXyJtwojA5Xf7-QleJjRxPN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:19:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 097185bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:19:15 +0000 (UTC)
Date: Fri, 5 Dec 2025 13:19:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
Message-ID: <aTLNwHpLUcy-WsZs@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119211030.2008441-5-adrian.ratiu@collabora.com>

On Wed, Nov 19, 2025 at 11:10:27PM +0200, Adrian Ratiu wrote:
> Add a submoduleEncoding extension which fixes filesystem collisions by
> encoding gitdir paths. At a high level, this implements a mechanism to
> encode -> validate -> retry until a working gitdir path is found.
> 
> Credit goes to Junio for coming up with this design: encoding is only
> applied when necessary, e.g. uppercase characters are encoded only on
> case-folding filesystems and only if a real conflict is detected.
> 
> To make this work, we rely on the submodule.<name>.gitdir config as the
> single source of truth for gitidir paths: the config is always set when

s/gitidir/gitdir/

> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 532456644b..4861d01894 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -73,6 +73,12 @@ relativeWorktrees:::
>  	repaired with either the `--relative-paths` option or with the
>  	`worktree.useRelativePaths` config set to `true`.
>  
> +submoduleEncoding:::
> +	If enabled, submodule gitdir paths are encoded to avoid filesystem
> +	conflicts due to nested gitdirs, case insensitivity or other issues.
> +	When enabled, the submodule.<name>.gitdir config is always set for
> +	all submodules and is the single point of authority for gitdir paths.
> +
>  worktreeConfig:::
>  	If enabled, then worktrees will load config settings from the
>  	`$GIT_DIR/config.worktree` file in addition to the

I think the fact that the submodule gitdir paths are encoded now is
secondary to this repository extension. The more important fact is that
this changes the source of truth where the submodule gitdir path is
actually derived from: before it was derived on the fly, whereas now it
is persisted in the gitconfig.

It follows that because the source of truth is now a persistent entry in
the configuration, other implementations can read it without having to
understand how exactly the value was computed in the first place. So an
implementation may arbitrarily change the algorithm it uses to derive
that path from now on, and it doesn't necessarily have to encode
anything.

So I'd propose to rename the extension and rephrase its description
accordingly. It could for example be called something along the lines of
"submodulePathConfig".

> diff --git a/submodule.c b/submodule.c
> index 8ef028f26b..07cb4694cf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2559,33 +2591,74 @@ int submodule_to_gitdir(struct repository *repo,
>  	return ret;
>  }
>  
> +static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
> +					     const char *submodule_name)
> +{
> +	char *key;
> +
> +	if (validate_submodule_encoded_git_dir(gitdir_path->buf, submodule_name))
> +		return -1;
> +
> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
> +	repo_config_set_gently(the_repository, key, gitdir_path->buf);
> +	FREE_AND_NULL(key);

I think a simple call to `free()` should be sufficient here. There is no
risk of it being used afterwards.

> +	return 0;
> +}
> +
>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  			      const char *submodule_name)
>  {
> +	const char *gitdir;
> +	char *key;
> +
> +	repo_git_path_append(r, buf, "modules/");
> +	strbuf_addstr(buf, submodule_name);
> +
> +	/* If extensions.submoduleEncoding is disabled, use the plain path set above */
> +	if (!r->repository_format_submodule_encoding) {
> +		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
> +			die(_("refusing to create/use '%s' in another submodule's "
> +			      "git dir"), buf->buf);
> +
> +		return; /* plain gitdir is valid for use */
> +	}
> +
> +	/* Extension is enabled: use the gitdir config if it exists */
> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
> +	if (!repo_config_get_string_tmp(r, key, &gitdir)) {
> +		strbuf_reset(buf);
> +		strbuf_addstr(buf, gitdir);
> +		FREE_AND_NULL(key);
> +
> +		/* validate because users might have modified the config */
> +		if (validate_submodule_encoded_git_dir(buf->buf, submodule_name))
> +			die(_("Invalid 'submodule.%s.gitdir' config: '%s' please check "
> +			      "if it is unique or conflicts with another module"),

Nit: error messages start with a lower-case character.

> +			    submodule_name, gitdir);
> +
> +		return;
> +	}
> +	FREE_AND_NULL(key);
> +
>  	/*
> -	 * NEEDSWORK: The current way of mapping a submodule's name to
> -	 * its location in .git/modules/ has problems with some naming
> -	 * schemes. For example, if a submodule is named "foo" and
> -	 * another is named "foo/bar" (whether present in the same
> -	 * superproject commit or not - the problem will arise if both
> -	 * superproject commits have been checked out at any point in
> -	 * time), or if two submodule names only have different cases in
> -	 * a case-insensitive filesystem.
> -	 *
> -	 * There are several solutions, including encoding the path in
> -	 * some way, introducing a submodule.<name>.gitdir config in
> -	 * .git/config (not .gitmodules) that allows overriding what the
> -	 * gitdir of a submodule would be (and teach Git, upon noticing
> -	 * a clash, to automatically determine a non-clashing name and
> -	 * to write such a config), or introducing a
> -	 * submodule.<name>.gitdir config in .gitmodules that repo
> -	 * administrators can explicitly set. Nothing has been decided,
> -	 * so for now, just append the name at the end of the path.
> +	 * The gitdir config does not exist, even though the extension is enabled.
> +	 * Therefore we are in one of the following cases:
>  	 */
> +
> +	/* Case 1: legacy migration of valid plain submodule names */
> +	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
> +		return;
> +
> +	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
> +	strbuf_reset(buf);
>  	repo_git_path_append(r, buf, "modules/");
> -	strbuf_addstr(buf, submodule_name);
> +	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
> +	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
> +		return;
>  
> -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
> -		die(_("refusing to create/use '%s' in another submodule's "
> -		      "git dir"), buf->buf);
> +	/* Case 3: Nothing worked: error out */
> +	die(_("Cannot construct a valid gitdir path for submodule '%s': "
> +	      "please set a unique git config for 'submodule.%s.gitdir'."),
> +	    submodule_name, submodule_name);

It feels somewhat fragile to me that we unconditionally handle these
cases and try to find old submodule directories. If the extension is
enabled I'd expect that the submodule configuration is the _only_ source
of truth.

May I propose that we instead always error out in case the submodule
configuration does not exist? In the best case we'd then give the user a
nice error message that tells them how to run the migration manually.

(Coming back from reading subsequent patches) Maybe what's putting me
off is that this function is seemingly used for two things:

  1. To derive the submodule path in case we know it should already
     exist.

  2. To compute the submodule path so we can end up writing it into the
     "submodule.*.gitdir" variable.

I think we should tell these two cases apart. In the first case I expect
that we never fall back to a computed name, but bail out in case the
configuration key does not exist. And in the second case it of course
makes sense to compute the actual path that we want to store in the
configuration.

Thanks!

Patrick
