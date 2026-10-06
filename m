Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F83783B5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265898; cv=none; b=lzR7ZV8r/cpTluYXmLJyE8Uphc4h8UFa55X0LXJRXFgS2hH+ZR7hEgv3PuEZDySOATdPI5sIReVJsVyVX3gSZbDZTQonyGaEsWctajWs+ScoB0aCB8RtbsTMFVUhKFs8wCKBk7y5NlYIR7E6wyVgqXGosA9tButV3T/9+NC+Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265898; c=relaxed/simple;
	bh=ILmwtPDKnHlTnvE1gt3PdjPyWoPzaz+q4Im93xPLhts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aih1N8vSVPOS2pahR5eyHE/Rz0iAX+KUNpKpKpe0tbSxfAxQNV7KcoduZzGjYmQ0jjAxI38stAWxdcsUvfS/8/ZTACLRh+H5keXc89N1IYX1q++GnyCJWw8FsiPH7EWaOJkEqUWJKl4Nj2ZCc6YMzgrATaWEurLAm1wVMsMH/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FArfQ4OP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wjhqT2QC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FArfQ4OP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjhqT2QC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 84C92EC0B9E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 01:51:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 06 Oct 2026 01:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791265894; x=1791352294; bh=S8y0zzQ5lS
	eNn3UbDmk2jO+U0IKL3Wi7YIRCmKYHor0=; b=FArfQ4OPMfQk3SGSlr8Tqo+MQl
	50CWdZFekZOTX4I99NlQpmlUvb8aBWTGOqSWP7TXEiI8GVCJYY2bu26UlSCbey49
	PjLSCJv5vO3Ab6Xvs7eZ5ZeWtqS91cJB9rmVc/51tLI0QPwi1YQXaFmeiIQLwFii
	oyP9YOhyK8ggtztchO97AFu2OOFHUyQvXBc1KjiS6hXrYLrAWBt/3DDZZRsymnJS
	kFb65Nr9FeZX95i3agLebApjy6DNDe+juTmLTjdSKHq3qh3ikpGbxaT/4Ik0UiNV
	HzdG2rUNyg7yr1f1XMSjwW/JjyFx1VIVy/v/Qhl7E4mESCzbwppdYLMdWYaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791265894; x=1791352294; bh=S8y0zzQ5lSeNn3UbDmk2jO+U0IKL3Wi7YIR
	CmKYHor0=; b=wjhqT2QCf3U1Wklleu8tVS+p5p2bCp05/jQcmkQ149nRzhUlVLk
	XVTvf4RI1cVMFtkuB4+qWCDzFby6tprR+1+dgTixEbbTzm13JLsr5vcLCtTLFGdk
	U+m2OWcGEcCD/GE90P/YssInSGo/N+kOLUp3YBbdj2krh5PKz/JD29VDs62tdpFh
	YG4DvueagAZHabso6SYFrKxx3zgy7DdYaKbXuliNZ6+AgM3xSmpqvVB+F+7zSNMj
	ywIk7ks1TB5ae33Uaa7VgIo6hv+qsqYzv4jgkxS+VvMGN7d9fIwSSxs0FOAt/dh6
	IDeucATID3HLsUGsoiYu0CNGB1RmWB/Yz4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791265894; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:feq1Q7kAMhcpneogdEeA94lyeaTVMGnq5lJNB06U9UA2374
	ClyqdzzBDZwQslMDRPoU03xQuyPqXJpDRSaEMktNKo06AKwPztS0JtaMe/W/Ac7D
	K67ePGOheu816AFI+m+sI0a7iWcqjW6Cb601a3ME3Ic6DerT1yyqxEFcCTU5FU/r
	/1IlvFiLtkIeaxSMxMLvUoLe7XKMXKLZdbJE2Zy8JxTNiK0quXAtpjUQTSptMRQA
	JMsAzrO7kd4nnSDKhN3YJpv5iHXy1TVgCL6nBZIV6y4KcVIed7/m3rvzsrdnTnQi
	3pGBYQHTqn2sUPxVmh4EIZD5ceyD7QfwSz+yyYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:taMg/bNkdEZ4qzhekPEfmQ/K1aPVE77UPimbAUf4fq8=:ILmwtPDKnHlTnvE1gt3PdjPyWoPzaz+q4Im93xPLhts=;
X-ME-Sender: <xms:ZozEajhZk3U8Tr-G44uZoHgmIm7v9CQxY7FMMp_liOKISLSyT5nKGA>
    <xme:ZozEandEV_NtIQ3yYeFLyNY0On7pHF1mK-iMKPaq05VCYuhrps0qCpKswkE7ebXCA
    eSmDNqmRSs5atz_sDVSPvUYNZs4Rny6_zltQ0ZmjUiDmXqCT5up>
X-ME-Received: <xmr:ZozEagcZ3Yfq7LokCUdoF5pmtBix9gmEeKv96cRvwCYte5cjYmMkmurxvI8E_wiAkxMorA>
X-ME-Proxy-Cause: dmFkZTGH03yASWLhQfsQ600cZuy3wlmD7pLdi8MoKmaWkml0SbTsW9UYwr1nx0+t1OqW+5
    8VoRtjJU31Okfc3s/+bwkNurCNk8SydQrhwLRNZnbkCkuCTSqZl+a8N39XkZ69ZX1wPY64
    J0TRP6i2V6VXDhsog3KMHTagDgrmk7kSogm3+nt4i4lrnOEOYMuFJcOQG1QJ1sGxI6cGx2
    tjcqHoiV0oX5+IswqiL4LDiYlHzOEFuA/s1kr8hDv0+8rSJViCkLtTynnN/D1pSvvEtwy2
    F52Ei/vNozllXaZmBg2i+xBbnTdXy3JD2gK0XsZxviSAlIeYaKbytaT10BAX6nli3FucUz
    01JAwuuas9VnGT5fVHOeOo+wjkKo5I8Rw452uzblkNXbJCTyIdjuKJfckTw7NFHIOcOBu3
    2mEUZxZCPjuS83cq++3rxRZX30S4V5BCuxsdtWf1gsxomG8eTfAYX3BECWifvC51aHlE42
    ys5NdzjPADwlV8xmif5AVVYSivmh4PLbne+vtXksuQOB2rxy1o7boO0Bw6kpOtFBjzHRQV
    F4pSvb2B3PNdS8/3wjkCQ8FKqHA/+7uayPjVG9yS21CvbZ7xhdcuPX8Mwx91xJzXdlBsdW
    XUgJo7K+zkO15rNKlxpZFTDoUavuED79h3Y91DQKCBYqnpCo0O3sF4fpKRUQ
X-ME-Proxy: <xmx:ZozEap913oo0VadYuLbgW2N_Ftr2ncoqfuUKGxoy-nl9nDQy9NKRug>
    <xmx:ZozEaklqWrkyNTpeLqXUrc26JVwFkByDT8okU-Y4DFwE2y-YsVfZCg>
    <xmx:ZozEaj9Y2npqr0Zvm9FItH3cmhEox04N5fnF7dMksZDRfR4JrMdAiw>
    <xmx:ZozEaqk2J-TI6sfZzUwn1MOiJN3MwjdSzPvuflNYg2xBspuGfjYnZA>
    <xmx:ZozEaneJwwSEZuQF2tmJvXb3D8kUpcMEvqDml_PPtCPYncsUgaTh0z2B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 01:51:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6d90e6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 05:51:30 +0000 (UTC)
Date: Tue, 6 Oct 2026 07:51:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v2 1/1] repo: add filtering options to "repo structure"
Message-ID: <asSMX-K2qLsaXc3v@pks.im>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261005174045.1900391-1-markchucarroll@fastmail.com>
 <20261005174045.1900391-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005174045.1900391-2-markchucarroll@fastmail.com>

On Mon, Oct 05, 2026 at 01:40:44PM -0400, Mark C. Chu-Carroll wrote:
> Implement filtering for repo structure, imitating the mechanism
> used in "git log".

The message should give an explanation of what this change does, and
what the motivation behind it is.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index ed7d80c690..5cbdf8e727 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git repo info [--format=(lines|nul) | -z] [--all | <key>...]
>  git repo info --keys [--format=(lines|nul) | -z]
> -git repo structure [--format=(table|lines|nul) | -z]
> +git repo structure [--format=(table|lines|nul) | -z] [<include|^exclude>...]

I think we should probably have this be `[<revs>...]`.

> @@ -56,9 +56,10 @@ supported:
>  `nul`:::
>  	Similar to `lines`, but using a _NUL_ character after each value.
>  
> -`structure [--format=(table|lines|nul) | -z]`::
> -	Retrieve statistics about the current repository structure. The
> -	following kinds of information are reported:
> +`structure [--format=(table|lines|nul) | -z] [<include|^exclude>...]::

Same here.

> @@ -66,6 +67,16 @@ supported:
>  * Total disk size of reachable objects by type
>  * Largest reachable objects in the repository by type
>  +
> +The set of objects counted can be filtered by specifying a
> +collection of query clauses to select which objects will be

s/query clauses/revisions/, which is a well-defined term. So with this
change I think we can drop most of the remaining paragraph, except for
the last sentence.

> +counted. These parameters follow the same syntax as the parameters
> +to similar commands like `git log`. Semantically, these parameters
> +are treated as a collection of include and exclude specifiers. Th
> +set of objects counted will consist of all objects reachable from
> +an object included by one of the include specifiers via a path that
> +does not include an object in an exclude clause. If no includes
> +are specified, then the include set is all reachable objects. 
> ++
>  The output format can be chosen through the flag `--format`. Three formats are
>  supported:
>  +
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..b3aca71298 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -946,12 +946,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
>  		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
>  		OPT_END()
>  	};
> +	struct setup_revision_opt s_r_opt;
> +	memset(&s_r_opt, 0, sizeof(s_r_opt));
> +	s_r_opt.def = "HEAD";
> +	s_r_opt.revarg_opt = REVARG_COMMITTISH;

This can be:

    struct setup_revision_opt s_r_opt = {
        .def = "HEAD",
        .revarg_opt = REVARG_COMMITTISH,
    };

But I wonder whether we want to pass it at all:

  - `.def` specifies the default, but do we even want to have one when
    the user has passed arguments?

  - `.revarg_opt` makes us treat it like a committish by default, but a
    user may for example want to figure out the size of all objects
    reachable from a specific tree, only.

So maybe we shouldn't be setting this at all and just pass `NULL` to
`setup_revisions()`?

> -	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
> -	if (argc)
> -		usage(_("too many arguments"));
> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);

Makes sense. Here we keep argv0 because of `setup_revisions()`' weird
calling convention. And we also ignore any unknown options so that we
can pass them along, too.

>  	repo_init_revisions(repo, &revs, prefix);
> +	if (argc > 1) {
> +		argc = setup_revisions(argc, argv, &revs, &s_r_opt);
> +		if (argc > 1)
> +			usage(_("too many arguments"));
> +	}
>  
>  	if (show_progress < 0)
>  		show_progress = isatty(2);

And then, if we have any additional parameters then we pass it on to
`setup_revisions()`.

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 02cc2b594a..eb2c595955 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -144,6 +144,90 @@ test_expect_success SHA1 'repository with references and objects' '
>  	)
>  '
>  
> +test_expect_success SHA1 'repository with references and objects, filtered' '
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
> + 		test_commit_bulk 20 &&
> +		# Also creates a commit, tree, and blob.
> +		git notes add -m foo &&
> +
> +		# git-rev-list(1) --disk-usage=human option printing the full
> +		# "byte/bytes" unit string instead of just "B".
> +		cat >expect <<-EOF &&
> +		| Repository structure      | Value      |
> +		| ------------------------- | ---------- |
> +		| * References              |            |
> +		|   * Count                 |      5     |
> +		|     * Branches            |      2     |
> +		|     * Tags                |      1     |
> +		|     * Remotes             |      1     |
> +		|     * Others              |      1     |
> +		|                           |            |
> +		| * Reachable objects       |            |
> +		|   * Count                 |   3.06 k   |
> +		|     * Commits             |   1.05 k   |
> +		|     * Trees               |   1.01 k   |
> +		|     * Blobs               |   1.01 k   |
> +		|     * Tags                |      1     |
> +		|   * Inflated size         |  16.04 MiB |
> +		|     * Commits             | 226.54 KiB |
> +		|     * Trees               |  15.81 MiB |
> +		|     * Blobs               |  11.68 KiB |
> +		|     * Tags                |    132 B   |
> +		|   * Disk size             | $(object_type_disk_usage all true) |
> +		|     * Commits             | $(object_type_disk_usage commit true) |
> +		|     * Trees               | $(object_type_disk_usage tree true) |
> +		|     * Blobs               |  $(object_type_disk_usage blob true) |
> +		|     * Tags                |    $(object_type_disk_usage tag) B   |
> +		|                           |            |
> +		| * Largest objects         |            |
> +		|   * Commits               |            |
> +		|     * Maximum size    [1] |    223 B   |
> +		|     * Maximum parents [2] |      1     |
> +		|   * Trees                 |            |
> +		|     * Maximum size    [3] |  32.29 KiB |
> +		|     * Maximum entries [4] |   1.01 k   |
> +		|   * Blobs                 |            |
> +		|     * Maximum size    [5] |     13 B   |
> +		|   * Tags                  |            |
> +		|     * Maximum size    [6] |    132 B   |
> +
> +		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
> +		[2] df6400c01440c329f1011669c4c26cc0c7852887
> +		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
> +		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
> +		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
> +		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
> +		EOF
> +
> +		git repo structure  >actual 2>actual-err &&
> +		cp actual /tmp/actual &&
> +		cp expect /tmp/expect &&
> +		test_cmp expect actual &&
> +		test_line_count = 0 actual-err &&
> +
> +		git repo structure grobble ^master >actual 2>actual-err &&
> +		cp actual /tmp &&
> +		cp actual-err /tmp &&
> +		test_grep "|     \* Commits             |    21     |" actual &&
> +		test_grep "|     \* Trees               |     2     |" actual &&
> +		test_grep "|     \* Commits             |  4.50 KiB |" actual &&
> +		test_grep "|     \* Trees               | 32.35 KiB |" actual &&
> +		test_grep "|     \* Blobs               | 11.68 KiB |" actual &&
> +		test_line_count = 0 actual-err
> +	)
> +'

I wonder whether we maybe want to have some additional tests that assert
that you can also pass e.g.:

  - A tree or blob.

  - Revision options, like for example `--all --filter=object:type=blob`.

To make the test a bit less repetitive we might also want to use
`--format=lines` and then only check for
"objects.*.{inflated,disk}_size" to exercise only the parts that matter
to this test.

Thanks!

Patrick
