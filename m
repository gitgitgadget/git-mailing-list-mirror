Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026B231853
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580749; cv=none; b=qJjYG3F09ulRedddEo+YjEvXYhKzOVtx/To4wkZe/uOIhio8Z1lf3krXLm06jh0U+HWnG1WpAP/gE971UnT44EQsEbJ1fkSuMY48Vz5E05lVSQso202gIvn65CWMoYtY4jLRvB26iy9tRhbHPk+bUb2L4g1asP8HajyRok4S6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580749; c=relaxed/simple;
	bh=RcBXrmr7O6OM2OxbROqEkiA8mmeWx2pb3pIxM+J6Poo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB5iMtz2tv5eJCdevdmAdLufql8jAy6/5G9rDk2vTQ3FLuh/4xC8l9KHOXAMGjsW9uZ0unqAwWQED47rTSvu7KQJ9dgQdlWEK6nGY9jHaUByYSa8ZjS3HsnpjP6n1lMNVemIBspxaieD1vpaTzxKsiLQkqE5uhswNDg8+KtN1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FFRQmsRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMGgKlOE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FFRQmsRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMGgKlOE"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8580C14002E2;
	Tue, 15 Jul 2025 07:59:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 07:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752580746; x=1752667146; bh=GMGcJ1CNoq
	1LZqFIlQfPC0N2y4APR9vC3CwSyVZQAb4=; b=FFRQmsROCx78Snd/Tw9Eb7SOA4
	xGERtquFsNbMYaV2HkN99sGmsnoxxrQBP0w/gt/zv2iid0qRxEMfkSaDGwZApH5m
	A82pTCsy8vEHc/IR1/JTTN0zGCMQmsE5G1TpAW81gPDC03K60zE2uv3kuKSwPAhp
	j78INci0H1ERb1B0tZRHkQFHMlkRd24UYXOtZGPV4WgcT/eAbHx1MlXt5nTj3pP+
	naf2h7scQ+OQOzEpsp/lJv3Og3VT5x2iZ2qxJXNmqhUcMpkc01LMp6Z3CldeZFog
	x7iBa/tZGDtwCTALi/eJNcIAd+4SOnmtQlC44YAtkwWO4S3UfVrpMTN0M06Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752580746; x=1752667146; bh=GMGcJ1CNoq1LZqFIlQfPC0N2y4APR9vC3Cw
	SyVZQAb4=; b=WMGgKlOExBhvdCrXN2XKYYFFF9bh89Xhkyok4O/GPMw/kTgWjBI
	ShkJTYh+BvTVcc6H/m+sC5RxC9H/BOdypru/FSxB6Kelq7pVxzcgzvdyGJCUQE2I
	h0q5d1kEH/39MkwrEhLkKcxZN5YScTvV04S7Id8jTs0PcEZwUpuMOsOv37trlZfL
	NsV5Fks+gjoiom1WEgF8y9YbHXaMTiRkvJt8d8zS+FMGj8FLpmPTkXO/OGGXqfhw
	UR/Np3savMSxIebHkKYYXuD4tPCfUoa9T/0mieYjPbMAB9M4RyTVZCOQh4fLuzNe
	cfDKgRNx+L3rmvjCAXhCmlgyQ+yqHunEKXA==
X-ME-Sender: <xms:ikJ2aLTOQIjHvvLcuwbrtgiY7_8zWNMNOAWNkI8MaGeu_Djz69jANw>
    <xme:ikJ2aAmP8irEt95yhD9YQxEuYOvx2V1kxIjTkBp_vUhkb1tuO59VMt1thaC_tbn2X
    iV06m_stkmXkDymyA>
X-ME-Received: <xmr:ikJ2aJ5cYjJoYBmJ18zDT9Wx-mS2LpOOfrxN70-WLqEdS6FQ0wEO87cnSgOIxO4XHa7qOjau7fVQo8aXjZc7HeqB4orZOFa6xgzqpWHVT-ERYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ikJ2aOi-max6h6pn1fBwrccy2dGHDOWl7rAW1MITC124hQryNfemZw>
    <xmx:ikJ2aOGzQ1upj4x9lQqdw7ryLeRWAO186VmOFknt_WuHc1wdQTKT7w>
    <xmx:ikJ2aMR6aDTPcfaIR1t8961SodV0dwdy2Xh7wtHHj3jg7a1K8Zzs7w>
    <xmx:ikJ2aDx7YcgsbLWm92HFZnSfR2qRzaEdqRZAZWqy_h-HKKb5yG2rsQ>
    <xmx:ikJ2aDXGe-5xxIw6eJcBmGaBtA9b6XgZJkvoQHlhNKhRFdbPfS2S6C4I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:59:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d71837a8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:59:04 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:59:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
Message-ID: <aHZChXPTbk_X6xDK@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714235231.10137-2-lucasseikioshiro@gmail.com>

On Mon, Jul 14, 2025 at 08:52:28PM -0300, Lucas Seiki Oshiro wrote:
> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name says. Over time,
> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriated command
> to place them.
> 
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics), returning them in a machine readable format
> following the syntax "field<LF>value<NUL>".
> 
> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
> 
> Also add entries for this new command in:
> 
> - the build files (Makefile, meson.build, Documentation/meson.build)
> - builtin.h
> - git.c
> - .gitignore
> - command-list.txt
> - Documentation

Nit: I don't really think it makes sense to have this bulleted list of
files you have changed unless you provide more context. We basically
already have a way more accurate version of this list 10 lines down in
the diffstat.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> new file mode 100644
> index 0000000000..6f8fe3f6ea
> --- /dev/null
> +++ b/Documentation/git-repo.adoc
> @@ -0,0 +1,54 @@
> +git-repo(1)
> +===========
> +
> +NAME
> +----
> +git-repo - Retrieve information about a repository
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git repo info [<key>...]
> +
> +DESCRIPTION
> +-----------
> +Retrieve information about the current repository in a machine-readable format.
> +
> +`git repo` will be the primary tool to query repository-specific information,

I think we should avoid making any promises how this command will evolve
in the future. I'd rather state what it does right now than to say what
it will eventually do.

> +such as metadata that currently can also be done by calling `git rev-parse` (see
> +linkgit:git-rev-parse[1]). `git repo` doesn't query information unrelated to the
> +current repository or that is already retrieved by a specialized command, for
> +example, `git config` (see linkgit:git-config[1]) or `git var` (see
> +linkgit:git-var[1]).
> +
> +This command returns the retrieved data following a null-terminated format with
> +this syntax:
> ++
> +----------------
> +key1<LF>value1<NUL>
> +key2<LF>value2<NUL>
> +...
> +----------------
> ++

One of the things I wonder is whether we should by default adapt those
tools to have human-readable format, e.g. in a way that it can be easily
added to git-bugreport(1). This would teach script authors that want to
use the command to use `git repo info --format=porcelain` right from the
start to have a machine-parseable output, and it would allow us to
iterate on the exact output format.

> diff --git a/builtin/repo.c b/builtin/repo.c
> new file mode 100644
> index 0000000000..a1787a3cc5
> --- /dev/null
> +++ b/builtin/repo.c
> @@ -0,0 +1,38 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +static int repo_info(int argc UNUSED,
> +		     const char **argv UNUSED,
> +		     const char *prefix UNUSED,
> +		     struct repository *repo UNUSED)
> +{
> +	return 0;
> +}
> +
> +int cmd_repo(int argc,
> +	     const char **argv,
> +	     const char *prefix,
> +	     struct repository *repo)
> +{
> +	parse_opt_subcommand_fn *fn = NULL;
> +	const char *const repo_usage[] = {
> +		"git repo info",
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_SUBCOMMAND("info", &fn, repo_info),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +
> +	if (fn) {
> +		return fn(argc, argv, prefix, repo);
> +	} else {
> +		if (argc) {
> +			error(_("unknown subcommand: `%s'"), argv[0]);
> +			usage_with_options(repo_usage, options);
> +		}
> +		return 1;

I think we need to print an error `if (!argc)`, as well. Otherwise the
user wouldn't know why `git repo` without any argumentsdoesn't do
anything.

Patrick
