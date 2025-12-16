Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F3339B5A
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876192; cv=none; b=ZovpNLB2drr3E3HsfOz1SE8Y2ex/zBhJZ1AlhXfF2LzbOI0y1kPCvZAFK4A7w3+CZc6I4bHLCIdM2Zywm63ee1v6RDPgvpzETLHYP7ZmiRS9nohl2NxOJUAfWVtkNMKj+mcLfM3o6P8038auuQ2mabvZ2ZkDLxPmkiaMt409wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876192; c=relaxed/simple;
	bh=G4w4YRs2t9Nr0fuqznY3OaD1SzamCW4tG2Sn9GRHD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq8o4AsJUSloPwrCG+vZN+j7QsiNvkwzQgacHVtVcuDC2WU3BUAYtkzMwkuhtbx/ehm5qNG7Q9gbR1sKX+MsM4se6W9yd3CFk5w5PmIloiJ5nwXNKZhYUcJzbdmR/ZvRwNVGekNb0B4czc9jyTE4qMcwyBhNsBrK6/aP6sT9bH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mhlG/Ju2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVi2eeZf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mhlG/Ju2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVi2eeZf"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A7D71D0010E;
	Tue, 16 Dec 2025 04:09:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 16 Dec 2025 04:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765876189; x=1765962589; bh=eifEAggBd4
	0f0fThgf21daygLNpk8MT1vwtEyD3aFHs=; b=mhlG/Ju2S2K0eXVfXFAYG8Qa/o
	gKmo1XQ8p3Tkj/mq6XM+k1POoutf5XnOcxG4ydXXG9aYMb+4/EGJGNfY8B1Xul7Q
	K8Qp0bIVGCwnimYOIzgM37ZfE5FEt6WgxW2b6K2lGKezkzYzpJ9UiH+d7EK0zmuv
	RB63QUCjmlnxCbaa5SCFGP2cnpSy65Kit0SOEVq/YvIvVBXrgE6JfAipAzrXSMV9
	mMxmQmwuDyLnR6j24ElgsMPYE+7JPApsAUU9cTLG4utegBHh3WySzKwPtyebwzBo
	anteyL8FzeVocLh1LRAmGpzA9wzPai91dFpPjsz/awsNefKU7h2riW9G4YTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765876189; x=1765962589; bh=eifEAggBd40f0fThgf21daygLNpk8MT1vwt
	EyD3aFHs=; b=UVi2eeZfLHeQ+YwzRT+CBQgRYGKa/cH6rA+pbjzjLbSITlEkcWA
	zHNmMeSSrt4c40PuIe1ccvg7PFAo/3T/zujeEhDQwOcGGJekFF69OzOCX8gMg/YB
	bubLGj0TlSChCLWL50SgjqGOAdHauZWdygrgSLDpHjzsiXjBQNtMrewxMdBXKJSx
	OnR8HGXlsqXfAOeQe2S1LNbY+MynDodQ9JFsgWuXzEJHWtIPs7fYRTE/KaVkZ1cF
	P/IriH0A/O/HXqiJm0cVUzWRcpdBdn7Pz6AUIxA8Pm8P+/Ys3QCqyrxRLBS23dgu
	GK5//Id6Uz94zMJU6E/4Jur4y0BV45eP+yw==
X-ME-Sender: <xms:3CFBaSI2b-EzVxNesN6vCZknyQ-1bgiyaEsyS0r67dSrXbmBaidS3A>
    <xme:3CFBaZ1az9OG-JVVZhvRU08P2d3duyhWGlLM_E_AZJqzeuWho288e6bB0W0DFp9je
    ej3G5a8yud_MfPivGeHuDKSaqL1a32ZJ391g04bw_zc9TEojgQ2YP4>
X-ME-Received: <xmr:3CFBaeUo54vTmLkXZ27uyiBCqsw5xbvL2Av5va0UQjZdMV64I94MVk1u_Avj1Wk_zfo53tuXCepyMTPCcWo822x5QGFKbFoYvlLZBmWkbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtg
    homhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehs
    thgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhose
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:3CFBaTNrlIBtjdyukO4zRylcpvQh2lfanL02e5918vLto8n43wic-Q>
    <xmx:3CFBaZ1JahvJVjTz1PGPswDEriaz0KS-xzld2S6T7FtoR1lgmpfUxg>
    <xmx:3CFBafSA6_zww7s4xoC-t5nD9oDN-LZw3MjHDecGbRSYEr2elUAbog>
    <xmx:3CFBacmKQnzaUVijZOjD-3Upn9ycr4P0kQdl8MJ22IlHlISBV5Qlew>
    <xmx:3SFBaVWDeqgNTxms7vFNoMZ_fcP6viKhIMjK3QTEEWWQoO_ZqLz3ws9->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:09:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f56bd64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:09:46 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:09:43 +0100
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
Subject: Re: [PATCH v6 04/10] submodule: introduce
 extensions.submodulePathConfig
Message-ID: <aUEh14H242nm0NcE@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-5-adrian.ratiu@collabora.com>

On Sat, Dec 13, 2025 at 10:08:10AM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 532456644b..6ce1dcc98b 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -73,6 +73,14 @@ relativeWorktrees:::
>  	repaired with either the `--relative-paths` option or with the
>  	`worktree.useRelativePaths` config set to `true`.
>  
> +submodulePathConfig:::
> +	If enabled, the submodule.<name>.gitdir config is the single source of
> +	truth for submodule gitdir paths and is always set for new submodules.
> +	Git will error if a module does not have submodule.<name>.gitdir set.
> +	Existing pre-extension submodules need to be migrated by adding the
> +	missing config entries. This is done manually for now, e.g. for each
> +	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
> +
>  worktreeConfig:::
>  	If enabled, then worktrees will load config settings from the
>  	`$GIT_DIR/config.worktree` file in addition to the

Yup, makes sense.

> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
> index 0672d99117..4cf7424cda 100644
> --- a/Documentation/config/submodule.adoc
> +++ b/Documentation/config/submodule.adoc
> @@ -52,6 +52,13 @@ submodule.<name>.active::
>  	submodule.active config option. See linkgit:gitsubmodules[7] for
>  	details.
>  
> +submodule.<name>.gitdir::
> +	This sets the gitdir path for submodule <name>. It only works when
> +	`extensions.submodulePathConfig` is enabled, otherwise it does nothing.

This reads a tiny bit awkward. How about: "This configuration is only
respected when..."?

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3bc139ff9c..699ac32004 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -435,6 +435,52 @@ struct init_cb {
>  };
>  #define INIT_CB_INIT { 0 }
>  
> +static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
> +					     const char *submodule_name)
> +{
> +	const char *value;
> +	char *key;
> +
> +	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
> +		return -1;
> +
> +	 key = xstrfmt("submodule.%s.gitdir", submodule_name);
> +
> +	 /* Nothing to do if the config already exists. */

Nit: additional leading space.

> +static void create_default_gitdir_config(const char *submodule_name)
> +{
> +	struct strbuf gitdir_path = STRBUF_INIT;
> +
> +	/* The config is set only when extensions.submodulePathConfig is enabled */
> +	if (!the_repository->repository_format_submodule_path_cfg)
> +		return;
> +
> +	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
> +	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
> +		strbuf_release(&gitdir_path);
> +		return;
> +	}
> +
> +	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
> +	      "Please ensure it is set, for example by running something like: "
> +	      "'git config submodule.%s.gitdir .git/modules/%s'"),
> +	    submodule_name, submodule_name, submodule_name);
> +}
> +
>  static void init_submodule(const char *path, const char *prefix,
>  			   const char *super_prefix,
>  			   unsigned int flags)

Okay, here we populate the configuration if and only if the repository
extension is enabled. Makes sense.

> diff --git a/submodule.c b/submodule.c
> index f645372a18..85ca7ea0fb 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2570,30 +2570,39 @@ int submodule_to_gitdir(struct repository *repo,
>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  			      const char *submodule_name)
>  {
> -	/*
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
> -	 */
> -	repo_git_path_append(r, buf, "modules/");
> -	strbuf_addstr(buf, submodule_name);
> +	const char *gitdir;
> +	char *key;
> +	int ret;
> +
> +	/* If extensions.submodulePathConfig is disabled, continue to use the plain path */
> +	if (!r->repository_format_submodule_path_cfg) {
> +		repo_git_path_append(r, buf, "modules/%s", submodule_name);
> +		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
> +			die(_("refusing to create/use '%s' in another submodule's "
> +			      "git dir"), buf->buf);
> +
> +		return; /* plain gitdir is valid for use */
> +	}
> +
> +	/* Extension is enabled: use the gitdir config if it exists */
> +	key = xstrfmt("submodule.%s.gitdir", submodule_name);
> +	ret = repo_config_get_string_tmp(r, key, &gitdir);
> +	FREE_AND_NULL(key);
> +
> +	if (!ret) {
> +		strbuf_addstr(buf, gitdir);
> +
> +		/* validate because users might have modified the config */
> +		if (validate_submodule_git_dir(buf->buf, submodule_name))
> +			die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
> +			      "if it is unique or conflicts with another module"),
> +			    submodule_name, gitdir);
> +
> +		return; /* gitdir from config is valid for use */
> +	}
>  
> -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
> -		die(_("refusing to create/use '%s' in another submodule's "
> -		      "git dir"), buf->buf);
> +	die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
> +	      "Please ensure it is set, for example by running something like: "
> +	      "'git config submodule.%s.gitdir .git/modules/%s'"),
> +	    submodule_name, submodule_name, submodule_name, submodule_name);

I think the logic would flow a bit more naturally if we didn't have all
the early returns. Something like the following untested and uncompiled
code:

void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
			      const char *submodule_name)
{
	if (!r->repository_format_submodule_path_cfg) {
		/*
		 * If extensions.submodulePathConfig is disabled,
		 * continue to use the plain path.
		 */
		repo_git_path_append(r, buf, "modules/%s", submodule_name);
	} else {
		const char *gitdir;
		char *key;

		/* Otherwise, if the extension is enabled, we use the gitdir config. */
		key = xstrfmt("submodule.%s.gitdir", submodule_name);

		if (repo_config_get_string_tmp(r, key, &gitdir)) {
			die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
			      "Please ensure it is set, for example by running something like: "
			      "'git config submodule.%s.gitdir .git/modules/%s'"),
			    submodule_name, submodule_name, submodule_name, submodule_name);
		}

		strbuf_addstr(buf, gitdir);
		FREE_AND_NULL(key);
	}

	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
		die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
		      "if it is unique or conflicts with another module"),
		    submodule_name, gitdir);
	}
}

I think it would make sense to also hint at the extension in the error
message here so that users know _why_ we expect the key to be set.

Patrick
