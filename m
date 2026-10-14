Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5003385B9
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980133; cv=none; b=d8xr2BaECnJmKqVS9ttb2Cfqq5bh2awYsENpCmRzHNj3+unE1WFrXOPRgfrg4QPDJ9HGn2kDu1TzZOt9BBD240UpiKscIiS1/3r4bt8jZ+1EXE3LwD1/cmGQLTfhlFYTii+y/QFOf0By7ogtQMU84G+5a3iW4qdW/ZPZtijis50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980133; c=relaxed/simple;
	bh=XsYLKS3pYpIW1Iy6eETdjhfbn+vimfk6TXPrBgK73tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk5TB+unqPZYTHzGUC6lkdZljRLZDcP4B1tLKkTtyAqhbNCgpChyS8QiG7oIpSJc5KnA6pe8TBCb6hejQjLfhxXi7hUpkwH+wYSXlopO+w6oz0LaWwnAb0JRlc1C3oYK8wl7rfXRRKhY2vpPdWlDwPO6nE4tiqoMPJ6VYtBR1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EamzBBnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pFgrKPc8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EamzBBnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFgrKPc8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E9C39EC0326
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:15:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 14 Oct 2026 08:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791980130; x=1792066530; bh=o3qt+38rDq
	czq5cpfC7OG3tzDtekUIU7g7y03KYUhgc=; b=EamzBBnUfidMWBJlNWaa5/drYF
	Eeh5rXQAYJ1usqSOqeHLm7Am6HIbPg5pDmv3LAf+ymm+uUA+E0SqtOuguxD/aQEF
	IIq8vMHWFMmwrVsyI8i4jiRzejuV0gwZ20OqkQUnzzy24XaTC76zsHfDstV7x4yj
	2VOmVOLsJk9ZBhq5NyMabh8Tu1itVrn10CkNR6ZYN+micBbK3G1J46HZukuOWmtI
	+Y0JIz0jl1U3FFQhSBvn2o5W26A3BQwHKe+Q7RHOcMUNqUbU5cpvMOPJ6wDLvdLG
	BDb0hQRw4jqpPzX1K8uSl4OeR7EOVRDxrif2AQiy0HqWlKUn8wPpESI2mVNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791980130; x=1792066530; bh=o3qt+38rDqczq5cpfC7OG3tzDtekUIU7g7y
	03KYUhgc=; b=pFgrKPc8kGczuLjOSm+8kbIHKAFlv/Bkb1ilkRLy3w4Lckjp9oR
	xbwFtEGiOTkbQUt7XK6gVToq+jD9V20tqVIZlAR6l55IApPMBDcqOXr/czsnQQvi
	dwFa43ugJ5/tbYyGQl3C/1ErGXkHJla2WFmNOLRI96QgXqLxm3UjCkwXt3FRjZeS
	YZmSniogqRIpU7Yhvj19WUaRHPyM2pIoV6C6kIKflkLJbUfJrkIDo7LiPLPSAk7A
	tDoj+iN3eHgPIZJMKezgSxaWDrPqrCKOMVVdNrC7MN9STI4RySxVt8Zco3I+EmRe
	/8ZEyxTxxa/fcTxnMXw1Cp70yd3mKaztuxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791980130; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MH/b4dgJczETpwGXDgNzXwx1LkCyBGrKmtzskp44blsH0ir
	eujcRbSOBH12z+ANVwywpqWaXmnXyD2HgfnCfQYYabR3QWKuGdC7rzMBaIEleBNq
	JxXxVEvZwu8jEpI551GMfyk6iY3E5rCqsiqhrQZNrdv/Y7pKiBwKzE05i6YF20Op
	/K0sP7Ek7aFDm4aAcSHEhb8ph0FfBrvLGU5Dg6letcBPyQlKnD1dgsMB23doUoLz
	iMhaL/dPtMwvK3z5ljZB4lWcTtKvbzML2Aq1wx7NQ3VgQhS/+YBZ0ubQmY3RxI8S
	ZhMyc0tHyO3MkImXGjAxazS6/MvQjkAD93USG/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fKJ97v3f6dvXhuNjeiYwf1U+GNciZ5WvWA78+t4loDs=:XsYLKS3pYpIW1Iy6eETdjhfbn+vimfk6TXPrBgK73tQ=;
X-ME-Sender: <xms:YnLPau6v2WbLJ8OwtfYU1E-KG_E9MuWxq_1G-Xgss0aswTOjMTgcEA>
    <xme:YnLPavWz-aM4WRdNaxo29ISCUXthtrQ0w6HKbMrYL0Lu1-_52d1ITiF5TwvX-tKA2
    Gmm96hTMNi1KcjseU0IfnVrx9KtHrw4llMJ1NZxQQZBW0buEDBnSTQ>
X-ME-Received: <xmr:YnLPaq3FWblBL6y0imqZ8BfVVRY01jju0mDf-BwJ9iIGNQx_tQL_vw>
X-ME-Proxy-Cause: dmFkZTGNv28K0ioxrSzg0BNOHOPU5AC5Cu5/E7edQbZ47tFlTLkExmG66Oc4/9igvW0bOY
    QG159zeATZFipWxeGj9tbjyuiGD503f7Nl8uCp1CT/szJ3ucgOOdo7TLNQRLZzup35z80C
    lLO12RwBVJJiZMLY9S2FSHWwvnz0OEW9eO0iLcsc2CXDnRTQ0daIOKb453nx6FIVTL215b
    zqwxrjaicSw3PHxS+XKS5vsdwRbtQqqADdZeMFSDozMWBmtPXbOYMjMOyn5NylbvRmuV9o
    HvVsJ4cbTMFT8ujWZIAwmP+E6HgnBsJuzRu3OvByrepc8S6JMzsiWSPqO6Hei2HzzaHQZe
    V5dFdFXZbAYFKHsADyjCKmjp1D3WXzF4wfFfmadhg+HbFPC1WOlLg1JslmR4HtYiRoY4VR
    1/6/sW9ZXoPZhdPAv7AmEBmGJobFPgk+sxTTW9b01sEMNvO7iTFcAomWLo6sOhs9ClIXmi
    V1f8/nIx6v9ei90q5dRk/gVxA1CNZ8BWwD/8dx99hxyzIo7MtELYkxnC0P4scfWnMsKZXk
    EPa/olQ+18aRBQtV2pLrvSKhrpVq8pt+8sYWdpZtRjVpZDUXmZMhc93vMsIbBc2AXjBuhJ
    gyUdac/uT6LEZXmfXM8uphmq5Nme9wxt5469GKyJm3QqKFvwrQ89GfdLcAyg
X-ME-Proxy: <xmx:YnLPak0cGb1OkHWJPWzKi5tONhQWMd66Yl0gmI5IsHxD48lf02zy1Q>
    <xmx:YnLPal-2e1rYmf1Bu93ZzMft8pogpX4QRUjAxYZqol3sP8wR_oLLrw>
    <xmx:YnLPap2Bqzj0ljPesmdhJ2jmn6K7699nkKC3PQKZeMKK9JFQkLdEMw>
    <xmx:YnLPaq9HCEi447-z4r-FS8Mc-HuJT4TEOPoBpGH6p81Ag9dMnYl3Lg>
    <xmx:YnLPanUCv5SsjkDNcxrOmAz6CMX0ESbaeX-1zaKl8-H2_AhbARrwN1Cl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 08:15:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfeb6ed9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 12:15:27 +0000 (UTC)
Date: Wed, 14 Oct 2026 14:15:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v5 1/1] repo: add filtering options to "repo structure"
Message-ID: <as9yXVSdEh526Qi9@pks.im>
References: <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-4-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013172849.1109478-4-markchucarroll@fastmail.com>

On Tue, Oct 13, 2026 at 01:28:51PM -0400, Mark C. Chu-Carroll wrote:
> index 84e012f83f..f45dea06d5 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -947,16 +953,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
> -	if (argc)
> -		usage(_("too many arguments"));
> -
> -	repo_init_revisions(repo, &revs, prefix);
> -
> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
>  	if (show_progress < 0)
>  		show_progress = isatty(2);
>  
> -	structure_count_references(&stats.refs, &revs, repo, show_progress);
> +	repo_init_revisions(repo, &revs, prefix);
> +	if (argc > 1) {
> +		argc = setup_revisions(argc, argv, &revs, NULL);
> +		included_revision_args = true;
> +		if (argc > 1)
> +			usage(_("too many arguments"));

Nit: it's not "too many arguments", it's unrecognized arguments here as
the number of arguments can theoretically be unlimited. Copying patterns
from other builtins:

	argc = setup_revisions(argc, argv, &revs, NULL);
	if (argc > 1)
		return error(_("unrecognized argument: %s"), argv[1]);

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 02cc2b594a..1d25ee14e5 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -140,10 +140,208 @@ test_expect_success SHA1 'repository with references and objects' '
[snip]
> +test_expect_success 'filter by object type' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 1005 &&
> +		git tag -a foo -m bar &&
> +
> +		oid="$(git rev-parse HEAD)" &&
> +		git update-ref refs/remotes/origin/foo "$oid" &&
> +		git checkout -b grobble &&
> +		test_commit_bulk --ref=refs/heads/grobble 20 &&
> +		git checkout master &&
> +		test_commit_bulk 20 &&
> +		# Also creates a commit, tree, and blob.
> +		git notes add -m foo &&
> +
> +		cat >expect <<-\EOF &&
> +		objects.commits.count=0
> +		objects.trees.count=0
> +		objects.blobs.count=1006
> +		objects.tags.count=0
> +		objects.commits.inflated_size=0
> +		objects.trees.inflated_size=0
> +		objects.blobs.inflated_size=11962
> +		objects.tags.inflated_size=0
> +		objects.commits.disk_size=0
> +		objects.trees.disk_size=0
> +		objects.blobs.disk_size=21022
> +		objects.tags.disk_size=0
> +		objects.commits.max_size=0
> +		objects.commits.max_size_oid=0000000000000000000000000000000000000000
> +		objects.trees.max_size=0
> +		objects.trees.max_size_oid=0000000000000000000000000000000000000000
> +		objects.blobs.max_size=13
> +		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
> +		objects.tags.max_size=0
> +		objects.tags.max_size_oid=0000000000000000000000000000000000000000
> +		objects.commits.max_parents=0
> +		objects.commits.max_parents_oid=0000000000000000000000000000000000000000
> +		objects.trees.max_entries=0
> +		objects.trees.max_entries_oid=0000000000000000000000000000000000000000
> +		EOF
> +		git repo structure --format=lines --objects --all --filter=object:type=blob >actual 2>err &&
> +		test_grep "^objects" actual >actual.objects &&
> +		test_cmp expect actual.objects &&
> +		test_must_be_empty err
>  	)
>  '
>  
> +
>  test_expect_success SHA1 'lines and nul format' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&

There's a trailing newline being added here.

> @@ -186,13 +384,13 @@ test_expect_success SHA1 'lines and nul format' '
>  		git repo structure --format=lines >out 2>err &&
>  
>  		test_cmp expect out &&
> -		test_line_count = 0 err &&
> +		test_must_be_empty err &&
>  
>  		git repo structure --format=nul >out 2>err &&
>  		tr "\012\000" "=\012" <out >actual &&
>  
>  		test_cmp expect actual &&
> -		test_line_count = 0 err &&
> +		test_must_be_empty err &&
>  
>  		# "-z", as a synonym to "--format=nul", participates in the
>  		# usual "last one wins" rule.
> @@ -200,7 +398,7 @@ test_expect_success SHA1 'lines and nul format' '
>  		tr "\012\000" "=\012" <out >actual &&
>  
>  		test_cmp expect actual &&
> -		test_line_count = 0 err
> +		test_must_be_empty err
>  	)
>  '
>  
> @@ -220,7 +418,7 @@ test_expect_success 'progress meter option' '
>  		GIT_PROGRESS_DELAY=0 git repo structure --no-progress >out 2>err &&
>  
>  		test_file_not_empty out &&
> -		test_line_count = 0 err
> +		test_must_be_empty err
>  	)
>  '

I'd drop these while-at-it changes. If you want to include them they
should be part of a preparatory commit.

But that's all I've got now, other than those nits I'm happy with this
version. Thanks!

Patrick
