Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925038F82
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738740625; cv=none; b=E2vCgXSFanOGCuzJaTIEX1/L1357ywI8yi0lWvShyzp4zMcltzbQ++EzFeoR11lPaWhhZg1pJ9JsyGQLcnVxGMrYAeoLf7dEV4LgYm7OGHswSE5hx3aXkczCFnVRT0P/QegQHT0VMqTQhyfJo0SrUbHeUlcryGtiVUlyvnDMDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738740625; c=relaxed/simple;
	bh=UA+T6o/otY2ydrs/6elcq+HdjINTVBzliRNgBoYBck4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQSHEm/OzbU8L3zae0C/6YXdhyiT3LdIFTjyq62nq1gqs3vu3w24+9dkzDIv4lutJpDqPSQmR3D6dV5R3lgjH/0nvVleYPZpFDHAwg9WGdg9BHBDUS0iw9NQDHEnFFfhUbggzDq8NrqOc2MV61xYN1gwfpxxfqpKwadmY4120cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=siiOFpia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imnrUaPb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="siiOFpia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imnrUaPb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4600114017B;
	Wed,  5 Feb 2025 02:30:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 02:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738740622; x=1738827022; bh=sChMCtxTYI
	psRmKx2VtB3EYBNsSby+sHbf9QP+iNdvc=; b=siiOFpiaMns+2An++xbRJ8uVjy
	LpYTHryVoHG/tCQkYVhH++b60JE1Pijo51lFyA6EFQ9iiKuVPL51VfwryUQk3t6v
	IVBU7oqxc6SeQiBYErLTvflW0m60arlrLJ75kBzKCexFn0kHEEQVAN+H2tovgBk3
	3lY1FdVMEFiL7ALRhq4Ly/RmibZaqskhH9GpEHs2CNLdsKv1xm/1z2Wh7Su4pLUf
	Zahs5s6/pKM29RfrEo1Zz0PBq1TFocAGmwHzr1S8nikOlqyzobzigto0vAxMtHq/
	Y6OoIjY4jdu9wAknjk3cuTsNhCzs6aeQtRbm/5fziLwxjYCynOp0YYWlOrvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738740622; x=1738827022; bh=sChMCtxTYIpsRmKx2VtB3EYBNsSby+sHbf9
	QP+iNdvc=; b=imnrUaPbVUokdcEdw4rBSl9YQamFph2LT2fZKezPu8/PRqvT7ga
	jrqtVJlMUP/WWyrccc/rtmpU9aadllV/X4+9iwntIOQ7ndm+6KOnmv34NAPb+Eb8
	JQ0vfk0EFe4hS1uZGzR0npii/HhR+ZXhhOoj+/A1t8OSBX6Nf1Xl4lj1twXxfRsU
	4hQjms/qsVa3JMxjWqdYrC1hGT7a4FOGxVJe1nI9BNLcPxMYvZd+9Qp6t2M1ujhz
	NkgmZgNnmpWN/twJ7zILt/6ZRjxD+0/t9NvSOPtQkAq4kwEEXYnpbU4ra+WERwl1
	dXBC1VlMr22LMaW6dLPYAkaOS/0AX4/v52g==
X-ME-Sender: <xms:jhOjZ-g6KozL_ciliPwcUdDSgo99B7wwZXzI4_ohPCnZkNuQDyvAqA>
    <xme:jhOjZ_CgvWRPqGCFuuMVld2JxRFOlyM4G26L5E6oBoG8s5qAbN0xzhyFrN_l5c5VI
    e7oI8tD3eKD8NMhCQ>
X-ME-Received: <xmr:jhOjZ2F-9bfUlov_j6wlHHQX5wTPDgb2LPcNUqrMwC3_tQ-uaXHjT02nLdulhHvLXSLmc6jfNHNScS0XM9rBPAw9NzOWoBOigsrXwzSwlRBC9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jhOjZ3RhYccaidOR5LJeXcSWMzPG8ePDmYDNa4Z7F64nKL5pV4HzeA>
    <xmx:jhOjZ7x6OA1yIB78jdOyzngruj1Svf_lxlfKlAMPBNCRQcGNsOWfbg>
    <xmx:jhOjZ17Ghw1a8haJDKyttVcT2OpCnynWKNrzl3SMIb3-pVxwSVIM4A>
    <xmx:jhOjZ4x7TZTuWxsCPvD4HrQEJ_U7KHfJgq6VsvVdYQFcCSpj8rCyFQ>
    <xmx:jhOjZykqvEcAWMl0Q9L-3JmD-_qqj38f46KWMWEckKwzzRmfxt0Kme4K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:30:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5914d78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:30:19 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:30:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: David Aguilar <davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] difftool: eliminate use of global variables
Message-ID: <Z6MThg8oEEtx5xur@pks.im>
References: <20250204225501.597873-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204225501.597873-1-davvid@gmail.com>

On Tue, Feb 04, 2025 at 02:55:00PM -0800, David Aguilar wrote:
> Remove the 'USE_THE_REPOSITORY_VARIABLE' macro now that all state is
> passed to each function from callers.

I think this patch deserves to be split up into multiple patches, as
you're doing multiple things at once:

  - You remove global state located in "builtin/difftool.c", which is
    itself not required to drop `USE_THE_REPOSITORY_VARIABLE`.

  - You introduce `struct difftool_state` to encapsulate state.

  - You replace callsites for interfaces that depend on
    `the_repository`.

All of these changes are great from my point of view, but it's a bit
hard to follow. It doesn't necessarily have to be three commits, but it
would be great to split up the refactorings that introduce the struct
and the refactorings that adapt users of `the_repository`.

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 03a8bb92a9..cd1e5882e3 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -12,8 +12,6 @@
>   * Copyright (C) 2016 Johannes Schindelin
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "builtin.h"
>  
>  #include "abspath.h"
> @@ -36,18 +34,27 @@
>  #include "entry.h"
>  #include "setup.h"
>  
> -static int trust_exit_code;
> -
>  static const char *const builtin_difftool_usage[] = {
>  	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
>  	NULL
>  };
>  
> +struct difftool_state {
> +	int has_symlinks;
> +	int symlinks;
> +	int trust_exit_code;
> +};

Why do we have both `has_symlinks` and `symlinks`? The latter gets set
to `has_symlinks` anyway, so it's a confusing to have both.

Also, I think it would make sense to rename the struct to
`difftool_options`, as it tracks options rather than state.

> @@ -734,8 +750,9 @@ int cmd_difftool(int argc,
>  	};
>  	struct child_process child = CHILD_PROCESS_INIT;
>  
> -	git_config(difftool_config, NULL);
> -	symlinks = has_symlinks;
> +	if (repo)
> +		repo_config(repo, difftool_config, &dt_state);
> +	dt_state.symlinks = dt_state.has_symlinks;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
>  			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |

Okay, you're being careful in the case where we don't have a repository,
good.

> @@ -749,8 +766,8 @@ int cmd_difftool(int argc,
>  
>  	if (!no_index){
>  		setup_work_tree();
> -		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
> -		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
> +		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
> +		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);

Okay. Here you unconditionall deref the repository, but we would have
exited already if we had no repo with `!!no_index`.

> @@ -799,6 +816,6 @@ int cmd_difftool(int argc,
>  	strvec_pushv(&child.args, argv);
>  
>  	if (dir_diff)
> -		return run_dir_diff(extcmd, symlinks, prefix, &child);
> +		return run_dir_diff(repo, &dt_state, extcmd, prefix, &child);

This one is a bit curious. We never assert that we have a repo when
`dir_diff` is set. But we make `no_index` and `dir_diff` exclusive with
one another, and thus we know that we'll have called `setup_work_tree()`
at an earlier point, which causes us to die in case there is none.

Thanks for working on this!

Patrick
