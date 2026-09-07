Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88946C858
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780018; cv=none; b=gBjx9nH4CC7NE4yIi0HXrVi1vY4Bn1hrJmdMcfkXP/c/qytzzh5+aTWSVZQxhSU6DZAXw1lBIM00Ydc01l/JY96GrTKPty7HYUTje6O/wvMsGUruRoC/kPyDAzws5ScKENiedIggW9mruNC5CjtfiaF5a38zxdUV0iPXvFSxwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780018; c=relaxed/simple;
	bh=TNaVvSpi7KWLuV0htrXXruqdgjo8B5paX+z2/fRIIts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rbN4O71KZdQTiSfeOA8k3+btDzRvmMVKjmdq3VeRyB2a3lxaqE4R6N3LnHFkjnWO+cFC5e7nYx0HRBPJelGd/TQxC8zQiBTuNLVtEB27Yl8OU8mlkDKiU7eY1WiZ0sLuc3OiJuXq1YD7Lqz9KAc473Jx/zwb00EkyESqWYiqzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cCn51icD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlPbQ0tB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cCn51icD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlPbQ0tB"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A8A514001EF;
	Mon,  7 Sep 2026 07:20:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Sep 2026 07:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780010;
	 x=1788866410; bh=CEtPufEfn2yYqnJMDVmh3P5RYg+YBMSchRBmhxFWjYQ=; b=
	cCn51icDoTG7/oHDZD7KPriq7z+Cowyga5jjsrtObQKSWgEBoJg7MhgutkzPHz1Q
	7QCWsjd6GXloHJC3NOaNuB5YH/YAbsre8bPDrd9lCy6PGNSRy8+H387YVpI/rWA3
	8YRtZxQjFSPKpnxNZimtv8Qsi8osxXzhLtV5bjVI/gsOyk8/0KmvfC75wxovloV9
	ypEVTlDh+PqdeLTOwZpv4oQ5+1wT/CX/l8ZuNdPHh8cH9KHlL4r5q0d/roF3D3QR
	zoiVf3EngMlimNProQEwvPPEv9rmqGun7GmN61qULFGdaOTGHDQaoi/9KKdGxwZ5
	FPeu7m6HAAQK5oWYTYYBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780010; x=
	1788866410; bh=CEtPufEfn2yYqnJMDVmh3P5RYg+YBMSchRBmhxFWjYQ=; b=U
	lPbQ0tBK41VlIHF2f0fHSPnYMocBJ5auTnwtOtx5AU39i2I/HwkgdxQuzRvubMWu
	aTOYoyPBSc8BuyMA+rgHZigcMvKDBV/qpq8kmNXXZYY+/hw56sx2hyByc6iwqJwU
	Arx+KbOFfrIlaX7YzQFIwjaXko0x2sVr30CK3RPo53V7p9cIeeoqlUCsfMA6Xg8u
	xDLNsWkUgivR6Wez8L2cfUQ8OGzRwPvQ+q/vGp6NIML/DuCrylRVsHY4nWS0oATq
	S2TW4mkDu9pyH3evu3WVi+vBhQWHDRmmuCF8X/c6gY/Jeveb/kCLls4W07uaIeJw
	QBEnYFiysaN/rOwR2YrgA==
X-ME-Sender: <xms:6p2eauQadE8NQU26UUL_rFSNTMBXyh_N7XI0aznYFBBpxA0mV2fxBg>
    <xme:6p2earNCmliX2Jpak_pLiMRs4Kxyar7Y_ntjOOJoripVZV9BsK385gmSVG4GLUlms
    JgBQCayYtc3YTWUOcxYF3rJ6A-2fT8gx2jqBeuS55gkQZZwRBB5cQ>
X-ME-Received: <xmr:6p2eapNAHT2mCW79wjMiDXLctZmshL-LEnTYZLTPO6NxURBjOx2UBg>
X-ME-Proxy-Cause: dmFkZTEZ02C07Vj7YLBPXPMiJ9SuS2bwt98Yrm9dbZeUaONIAmOOoKzA+YpyhTppDKW2BD
    AxRzcC83KPfr7RwMIII9i2H+zC4Nfb2jbl43jpowKWo4lUZzQ8CmO8AUUa+J7dbhkXtj2X
    E9itAV8uhfFbUAHVEF+qk/0z1GpePhpFZsNS0Pfsc3mNfI6mgcIke6pOn8rmQAu4QdKOyg
    4q+CdtjrNXiAfBz99NXRWMywDuXNdwCVJeEAcc6N/niBhfnWotI0GtGQSWE/o45dQoWeb+
    576Ay8MWlhye+Wz9j0AO815nPSiGHp37MJMDwWG1pQYa1qumR/Jr+CACuY8Ms4ZsLY+lMR
    7GRwwkzWL1QNAvTT8huoRFluIX9gQQypNu1/SHXChhnnDmq/meXvxGAGAI890W25kGOlOU
    AP+hLDufaQQGiMC0bk6150a9AmsA+o9VC6lbpwBLMuuNLJrdz6EE2e/r/Elb54ugElX1fr
    q67ifyupVZoXP/hVt/zLHL5ZYaZQIAAPdF5GdXWMJvUD5vohwQwrgpip+Vw07CdgrkHLOz
    VVeNzBXI5u+kfCnTPbEXsv17x/+k9DBs5SpMukaRHfGHL4e1V90iQqm2+O8l6pn+hyvmYA
    NSBBBun2K3OuWPolVLLfdoR4hvz4SuAoc0reOfdXDAf96iErMkuqQIFwBFmQ
X-ME-Proxy: <xmx:6p2eajsUxzff-BOQzyfb7NbL6L9L4vIe0735Xw8bZjyyJar9SAbA4Q>
    <xmx:6p2earUattYw8TGvaGxSJIpfdstMStxMPy8supXSvwWZlAugKiF6LQ>
    <xmx:6p2eajt-9aZSVXJdyqXoCQWgDWZVrA3ttnm7l5L7H_5-vwV0xgs_-w>
    <xmx:6p2eavXKJpwFs-xxC6SIiQ_bTqxWwJ0xirbVXT_GozMSubGeQIThgA>
    <xmx:6p2earMqoKBhl-y6_6FH337vOb1SC4HOOliaNcJGi-tTUbMw5R4-7-CL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ed53cc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/11] Fix inconsistent ref storage format terminology
Date: Mon, 07 Sep 2026 13:18:34 +0200
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBBGr0Jm7ZgpVkRW3sOwAJzKaPhJC0RCe
 ndbvIDLl7y879vAsRV2UCQbWF7EydAHSA8JNG3VPxnlERhSSjO6ksZa4/h2OPdiVrRs0E2DrYJ
 nBttVE1KTK1PTKc8uCkJlDI589oV7+WM31y9uppiNRisxse4XFhW9/9cWhYSUK635TKSNuQX9K
 B2U3vsvaZpn190AAAA=
X-Change-ID: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

back when we gained support for reftables we of course introduced the
ability to control the reference storage format that is used by newly
created repositories. This infrastructure has grown over time, and
unfortunately without a lot of consistency:

  - The command line parameter to specify the ref storage format is
    called "--ref-format=", while the corresponding repository extension
    is called "refStorage".

  - In most cases we refer to the "ref storage format" in our docs, so
    calling it "--ref-format=" is inconsistent with them.

  - It is possible to override the ref storage format via an environment
    variable that is called "GIT_REFERENCE_BACKEND", which is not even
    remotely consistent with anything else.

  - There is also an "object format", but that format does not control
    how we store objects but rather whether we use SHA1 or SHA256.

So in summary, it's a huge mess.

This problem is about to become even worse though, as we're soon going
to introduce an object storage extension. This extension is the
equivalent to the ref storage extension, and of course we also want
users to be able to control which object storage format new repositories
are using. But we cannot properly name that parameter without creating
even more inconsistencies:

  - "--object-format=" would match "--ref-format=", but that parameter
    name is already taken to specify the hash function.

  - "--object-storage=" would be a good fit, but be inconsistent with
    "--ref-format=". Asking the user to execute `git init
    --ref-format=reftable --object-format=sha256 --object-storage=foo`
    just feels extremely awkward.

So this patch series aims to clean up this huge mess that we (well, to a
large extent I) have created, by bringing consistency to our command
line switches, environment variables and config options to all use "ref
storage format" instead. And that also paves the way for the eventual
"object storage format" switches.

As a cherry on top, this patch series also extends the
"--ref-storage-format=" switch to allow URIs in the form of
"files://foo/bar" to bring it in line with all the other ways to specify
the ref storage format that already allow for URIs.

Changes in v2:
  - Based on Junio's feedback I've renamed all of this to instead be
    called "ref storage format".
  - Link to v1: https://patch.msgid.link/20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (11):
      builtin/init: rename "--ref-format=" to "--ref-storage-format="
      builtin/clone: rename "--ref-format=" to "--ref-storage-format="
      builtin/refs: rename "--ref-format=" to "--ref-storage-format="
      builtin/submodule: rename "--ref-format=" to "--ref-storage-format="
      builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage-format"
      help: rename "default-ref-format" to "default-ref-storage-format"
      refs: expose function to parse reference URIs
      setup: refactor how we configure the ref storage format
      setup: rename ref storage format environment variables
      setup: rename "init.defaultRefFormat" to "init.defaultRefStorageFormat"
      setup: allow "git init --ref-storage-format=" to specify a payload

 Documentation/BreakingChanges.adoc     |   2 +-
 Documentation/config/feature.adoc      |   2 +-
 Documentation/config/init.adoc         |   6 +-
 Documentation/git-clone.adoc           |   2 +-
 Documentation/git-init.adoc            |   9 +-
 Documentation/git-refs.adoc            |   6 +-
 Documentation/git-rev-parse.adoc       |   2 +-
 Documentation/git-submodule.adoc       |   8 +-
 Documentation/git.adoc                 |  14 +--
 Documentation/ref-storage-format.adoc  |   8 +-
 builtin/clone.c                        |  18 ++--
 builtin/fetch.c                        |   2 +-
 builtin/init-db.c                      |  21 ++---
 builtin/refs.c                         |  11 ++-
 builtin/rev-parse.c                    |   2 +-
 builtin/submodule--helper.c            |  24 +++--
 contrib/completion/git-prompt.sh       |   2 +-
 environment.h                          |   1 +
 git-submodule.sh                       |  20 ++--
 help.c                                 |   2 +-
 refs.c                                 |  23 +++++
 refs.h                                 |   4 +
 setup.c                                | 164 ++++++++++++++++++---------------
 setup.h                                |   2 +-
 t/perf/p1401-ref-store-tombstones.sh   |   4 +-
 t/perf/perf-lib.sh                     |   4 +-
 t/t0001-init.sh                        | 126 +++++++++++++------------
 t/t0610-reftable-basics.sh             |  34 +++----
 t/t0611-reftable-httpd.sh              |   2 +-
 t/t1400-update-ref.sh                  |   2 +-
 t/t1419-exclude-refs.sh                |  16 ++--
 t/t1423-ref-backend.sh                 |  62 +++++++++----
 t/t1460-refs-migrate.sh                |  54 +++++------
 t/t1500-rev-parse.sh                   |   8 +-
 t/t1900-repo-info.sh                   |   6 +-
 t/t5510-fetch.sh                       |  14 +--
 t/t5601-clone.sh                       |   6 +-
 t/t7424-submodule-mixed-ref-formats.sh |  30 +++---
 t/test-lib.sh                          |   8 +-
 39 files changed, 413 insertions(+), 318 deletions(-)

Range-diff versus v1:

 1:  0b3491b5ff !  1:  6863d9ef8e builtin/init: rename "--ref-format=" to "--ref-storage="
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/init: rename "--ref-format=" to "--ref-storage="
    +    builtin/init: rename "--ref-format=" to "--ref-storage-format="
     
         Back when we gained support for reftables we of course introduced the
         ability to control the reference storage format that is used by newly
    @@ Commit message
             --object-storage=` just feels extremely awkward.
     
         Instead, this and subsequent patches will fix the mess by consistently
    -    referring to the ref storage format as "ref storage" throughout all
    -    options, environment variables and config settings. This new name much
    -    more closely indicates that it is about how we store data and finally
    -    brings consistency into this area. We will keep the old names working of
    -    course for the sake of backwards compatibility.
    +    referring to the ref storage format as such throughout all options,
    +    environment variables and config settings. This new name much more
    +    closely indicates that it is about how we store data and finally brings
    +    consistency into this area. We will keep the old names working of course
    +    for the sake of backwards compatibility.
     
         Start with git-init(1).
     
    @@ Documentation/config/init.adoc: endif::[]
      `init.defaultRefFormat`::
      	Allows overriding the default ref storage format for new repositories.
     -	See `--ref-format=` in linkgit:git-init[1]. Both the command line
    -+	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
    ++	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
      	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
      	precedence over this config.
      
    @@ Documentation/git-init.adoc: SYNOPSIS
      git init [-q | --quiet] [--bare] [--template=<template-directory>]
      	 [--separate-git-dir <git-dir>] [--object-format=<format>]
     -	 [--ref-format=<format>]
    -+	 [--ref-storage=<format>]
    ++	 [--ref-storage-format=<format>]
      	 [-b <branch-name> | --initial-branch=<branch-name>]
      	 [--shared[=<permissions>]] [<directory>]
      
    @@ Documentation/git-init.adoc: values are `sha1` and (if enabled) `sha256`.  `sha1
      include::object-format-disclaimer.adoc[]
      
     -`--ref-format=<format>`::
    -+`--ref-storage=<format>`::
    ++`--ref-storage-format=<format>`::
      Specify the given ref storage _<format>_ for the repository. The valid values are:
      +
      include::ref-storage-format.adoc[]
    @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., th
      	If this variable is set, the default reference backend format for new
      	repositories will be set to this value. The default is "files".
     -	See `--ref-format` in linkgit:git-init[1].
    -+	See `--ref-storage` in linkgit:git-init[1].
    ++	See `--ref-storage-format` in linkgit:git-init[1].
      
      `GIT_REFERENCE_BACKEND`::
          Specify which reference backend to be used along with its URI.
    @@ builtin/init-db.c: static int shared_callback(const struct option *opt, const ch
      	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
      	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
     -	   "         [--ref-format=<format>]\n"
    -+	   "         [--ref-storage=<format>]\n"
    ++	   "         [--ref-storage-format=<format>]\n"
      	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
      	   "         [--shared[=<permissions>]] [<directory>]"),
      	NULL
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      	int bare = startup_info->force_bare_repository ? 1 : -1;
      	const char *object_format = NULL;
     -	const char *ref_format = NULL;
    -+	const char *ref_storage = NULL;
    ++	const char *ref_storage_format_str = NULL;
      	const char *initial_branch = NULL;
      	int hash_algo = GIT_HASH_UNKNOWN;
      	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      			   N_("specify the hash algorithm to use")),
     -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
     -			   N_("specify the reference format to use")),
    -+		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage, N_("format"),
    ++		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
      		OPT_END()
      	};
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      
     -	if (ref_format) {
     -		ref_storage_format = ref_storage_format_by_name(ref_format);
    -+	if (ref_storage) {
    -+		ref_storage_format = ref_storage_format_by_name(ref_storage);
    ++	if (ref_storage_format_str) {
    ++		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
     -			die(_("unknown ref storage format '%s'"), ref_format);
    -+			die(_("unknown ref storage format '%s'"), ref_storage);
    ++			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
      	}
      
      	if (init_shared_repository != -1)
    @@ t/perf/p1401-ref-store-tombstones.sh: test_description="Tests performance of ref
      
      test_expect_success "setup" '
     -	git init --ref-format=reftable repo &&
    -+	git init --ref-storage=reftable repo &&
    ++	git init --ref-storage-format=reftable repo &&
      	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
      	for i in $(test_seq 8000)
      	do
    @@ t/perf/p1401-ref-store-tombstones.sh: test_perf "recreate refs after mass delete
      
      test_expect_success "setup asymmetric" '
     -	git init --ref-format=reftable repo2 &&
    -+	git init --ref-storage=reftable repo2 &&
    ++	git init --ref-storage-format=reftable repo2 &&
      	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
      	for i in $(test_seq 8000)
      	do
    @@ t/perf/perf-lib.sh: test_perf_create_repo_from () {
      	(
      		cd "$repo" &&
     -		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
    -+		"$MODERN_GIT" init -q --ref-storage="$refformat" --object-format="$objectformat" &&
    ++		"$MODERN_GIT" init -q --ref-storage-format="$refformat" --object-format="$objectformat" &&
      		test_perf_do_repo_symlink_config_ &&
      		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
      		if test -f .git/index.lock
    @@ t/t0001-init.sh: do
      	'
      
     -	test_expect_success "init with --ref-format=$format" '
    -+	test_expect_success "init with --ref-storage=$format" '
    ++	test_expect_success "init with --ref-storage-format=$format" '
      		test_when_finished "rm -rf refformat" &&
     -		git init --ref-format=$format refformat &&
    -+		git init --ref-storage=$format refformat &&
    ++		git init --ref-storage-format=$format refformat &&
      		echo $format >expect &&
      		git -C refformat rev-parse --show-ref-format >actual &&
      		test_cmp expect actual
    @@ t/t0001-init.sh: do
      	'
      
     -	test_expect_success "--ref-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
    -+	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_FORMAT" '
    ++	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
      		test_when_finished "rm -rf refformat" &&
     -		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-format=$format refformat &&
    -+		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
    ++		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
      		echo $format >expect &&
      		git -C refformat rev-parse --show-ref-format >actual &&
      		test_cmp expect actual
    @@ t/t0001-init.sh: do
      done
      
     -test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
    -+test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
    ++test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
      	test_when_finished "rm -rf refformat" &&
     -	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
    -+	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
    ++	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
      	echo reftable >expect &&
      	git -C refformat rev-parse --show-ref-format >actual &&
      	test_cmp expect actual
    @@ t/t0001-init.sh: for from_format in $backends
      		test_when_finished "rm -rf refformat" &&
     -		git init --ref-format=$from_format refformat &&
     -		git init --ref-format=$from_format refformat &&
    -+		git init --ref-storage=$from_format refformat &&
    -+		git init --ref-storage=$from_format refformat &&
    ++		git init --ref-storage-format=$from_format refformat &&
    ++		git init --ref-storage-format=$from_format refformat &&
      		echo $from_format >expect &&
      		git -C refformat rev-parse --show-ref-format >actual &&
      		test_cmp expect actual
    @@ t/t0001-init.sh: do
      		test_expect_success "re-init with different format fails ($from_format -> $to_format)" '
      			test_when_finished "rm -rf refformat" &&
     -			git init --ref-format=$from_format refformat &&
    -+			git init --ref-storage=$from_format refformat &&
    ++			git init --ref-storage-format=$from_format refformat &&
      			cat >expect <<-EOF &&
      			fatal: attempt to reinitialize repository with different reference storage format
      			EOF
     -			test_must_fail git init --ref-format=$to_format refformat 2>err &&
    -+			test_must_fail git init --ref-storage=$to_format refformat 2>err &&
    ++			test_must_fail git init --ref-storage-format=$to_format refformat 2>err &&
      			test_cmp expect err &&
      			echo $from_format >expect &&
      			git -C refformat rev-parse --show-ref-format >actual &&
    @@ t/t0001-init.sh: do
      done
      
     -test_expect_success 'init with --ref-format=garbage' '
    -+test_expect_success 'init with --ref-storage=garbage' '
    ++test_expect_success 'init with --ref-storage-format=garbage' '
      	test_when_finished "rm -rf refformat" &&
      	cat >expect <<-EOF &&
      	fatal: unknown ref storage format ${SQ}garbage${SQ}
      	EOF
     -	test_must_fail git init --ref-format=garbage refformat 2>err &&
    -+	test_must_fail git init --ref-storage=garbage refformat 2>err &&
    ++	test_must_fail git init --ref-storage-format=garbage refformat 2>err &&
      	test_cmp expect err
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'init: reinitializing reftable b
      
      	git -C repo for-each-ref >expect &&
     -	git init --ref-format=reftable repo &&
    -+	git init --ref-storage=reftable repo &&
    ++	git init --ref-storage-format=reftable repo &&
      	git -C repo for-each-ref >actual &&
      	test_cmp expect actual
      '
    @@ t/t0610-reftable-basics.sh: test_expect_success 'init: reinitializing reftable b
      test_expect_success 'init: reinitializing files with reftable backend fails' '
      	test_when_finished "rm -rf repo" &&
     -	git init --ref-format=files repo &&
    -+	git init --ref-storage=files repo &&
    ++	git init --ref-storage-format=files repo &&
      	test_commit -C repo file &&
      
      	cp repo/.git/HEAD expect &&
     -	test_must_fail git init --ref-format=reftable repo &&
    -+	test_must_fail git init --ref-storage=reftable repo &&
    ++	test_must_fail git init --ref-storage-format=reftable repo &&
      	test_cmp expect repo/.git/HEAD
      '
      
      test_expect_success 'init: reinitializing reftable with files backend fails' '
      	test_when_finished "rm -rf repo" &&
     -	git init --ref-format=reftable repo &&
    -+	git init --ref-storage=reftable repo &&
    ++	git init --ref-storage-format=reftable repo &&
      	test_commit -C repo file &&
      
      	cp repo/.git/HEAD expect &&
     -	test_must_fail git init --ref-format=files repo &&
    -+	test_must_fail git init --ref-storage=files repo &&
    ++	test_must_fail git init --ref-storage-format=files repo &&
      	test_cmp expect repo/.git/HEAD
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reftable repos
      test_expect_success 'clone: can clone reffiles into reftable repository' '
      	test_when_finished "rm -rf reffiles reftable" &&
     -	git init --ref-format=files reffiles &&
    -+	git init --ref-storage=files reffiles &&
    ++	git init --ref-storage-format=files reffiles &&
      	test_commit -C reffiles A &&
      	git clone --ref-format=reftable ./reffiles reftable &&
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reffiles into
      test_expect_success 'clone: can clone reftable into reffiles repository' '
      	test_when_finished "rm -rf reffiles reftable" &&
     -	git init --ref-format=reftable reftable &&
    -+	git init --ref-storage=reftable reftable &&
    ++	git init --ref-storage-format=reftable reftable &&
      	test_commit -C reftable A &&
      	git clone --ref-format=files ./reftable reffiles &&
      
    @@ t/t0611-reftable-httpd.sh: start_httpd
      
      test_expect_success 'serving ls-remote' '
     -	git init --ref-format=reftable -b main "$REPO" &&
    -+	git init --ref-storage=reftable -b main "$REPO" &&
    ++	git init --ref-storage-format=reftable -b main "$REPO" &&
      	cd "$REPO" &&
      	test_commit m1 &&
      	>.git/git-daemon-export-ok &&
    @@ t/t1400-update-ref.sh: do
      
      	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
     -		git init --ref-format=reftable repo &&
    -+		git init --ref-storage=reftable repo &&
    ++		git init --ref-storage-format=reftable repo &&
      		test_when_finished "rm -fr repo" &&
      		(
      			cd repo &&
    @@ t/t1423-ref-backend.sh: do
      		test_expect_success "$method: read from $to_format backend, $dir dir" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			(
      				cd repo &&
      				test_commit 1 &&
    @@ t/t1423-ref-backend.sh: do
      		test_expect_success "$method: write to $to_format backend, $dir dir" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			(
      				cd repo &&
      				test_commit 1 &&
    @@ t/t1423-ref-backend.sh: do
      		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
      			test_when_finished "rm -rf repo wt" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			(
      				cd repo &&
      				test_commit 1 &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format: migration to same format fails" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_must_fail git -C repo refs migrate \
      				--ref-format=$from_format 2>err &&
      			cat >expect <<-EOF &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			git -C repo worktree add wt &&
      			test_must_fail git -C repo refs migrate \
      				--ref-format=$to_format 2>err &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: unborn HEAD" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_migration repo "$to_format"
      		'
      
      		test_expect_success "$from_format -> $to_format: single ref" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			test_migration repo "$to_format"
      		'
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: bare repository" '
      			test_when_finished "rm -rf repo repo.git" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git clone --ref-format=$from_format --mirror repo repo.git &&
      			test_migration repo.git "$to_format"
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: dangling symref" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo symbolic-ref BROKEN_HEAD refs/heads/nonexistent &&
      			test_migration repo "$to_format" &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: broken ref" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
      				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERIFICATION &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: pseudo-refs" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo update-ref FOO_HEAD HEAD &&
      			test_migration repo "$to_format"
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: special refs are left alone" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo rev-parse HEAD >repo/.git/MERGE_HEAD &&
      			git -C repo rev-parse MERGE_HEAD &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: a bunch of refs" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      
      			test_commit -C repo initial &&
      			cat >input <<-EOF &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: dry-run migration does not modify repository" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo refs migrate --dry-run \
      				--ref-format=$to_format >output &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: reflogs of symrefs with target deleted" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo branch branch-1 HEAD &&
      			git -C repo symbolic-ref refs/heads/symref refs/heads/branch-1 &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: reflogs order is retained" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit --date "100005000 +0700" --no-tag -C repo initial &&
      			test_commit --date "100003000 +0700" --no-tag -C repo second &&
      			test_migration repo "$to_format"
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: stash is retained" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			(
      				cd repo &&
      				test_commit initial A &&
    @@ t/t1460-refs-migrate.sh: do
      		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
      			test_when_finished "rm -rf repo" &&
     -			git init --ref-format=$from_format repo &&
    -+			git init --ref-storage=$from_format repo &&
    ++			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			# we see that the repository contains reflogs.
      			git -C repo reflog --all >reflogs &&
    @@ t/t1460-refs-migrate.sh: done
      test_expect_success 'multiple reftable blocks with multiple entries' '
      	test_when_finished "rm -rf repo" &&
     -	git init --ref-format=files repo &&
    -+	git init --ref-storage=files repo &&
    ++	git init --ref-storage-format=files repo &&
      	test_commit -C repo first &&
      	test_seq -f "create refs/heads/ref-%d HEAD" 5000 |
      	git -C repo update-ref --stdin &&
    @@ t/t1460-refs-migrate.sh: test_expect_success 'multiple reftable blocks with mult
      test_expect_success 'migrating from files format deletes backend files' '
      	test_when_finished "rm -rf repo" &&
     -	git init --ref-format=files repo &&
    -+	git init --ref-storage=files repo &&
    ++	git init --ref-storage-format=files repo &&
      	test_commit -C repo first &&
      	git -C repo pack-refs --all &&
      	test_commit -C repo second &&
    @@ t/t1460-refs-migrate.sh: test_expect_success 'migrating from files format delete
      test_expect_success 'migrating from reftable format deletes backend files' '
      	test_when_finished "rm -rf repo" &&
     -	git init --ref-format=reftable repo &&
    -+	git init --ref-storage=reftable repo &&
    ++	git init --ref-storage-format=reftable repo &&
      	test_commit -C repo first &&
      
      	test_path_is_dir repo/.git/reftable &&
    @@ t/t1900-repo-info.sh: test_repo_info () {
      
      test_repo_info 'ref format files is retrieved correctly' \
     -	'git init --ref-format=files' 'format-files' 'references.format' 'files'
    -+	'git init --ref-storage=files' 'format-files' 'references.format' 'files'
    ++	'git init --ref-storage-format=files' 'format-files' 'references.format' 'files'
      
      test_repo_info 'ref format reftable is retrieved correctly' \
     -	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
    -+	'git init --ref-storage=reftable' 'format-reftable' 'references.format' 'reftable'
    ++	'git init --ref-storage-format=reftable' 'format-reftable' 'references.format' 'reftable'
      
      test_repo_info 'bare repository = false is retrieved correctly' \
      	'git init' 'nonbare' 'layout.bare' 'false'
    @@ t/t1900-repo-info.sh: test_expect_success 'values returned in order requested' '
      	layout.bare=false
      	EOF
     -	git init --ref-format=files ordered &&
    -+	git init --ref-storage=files ordered &&
    ++	git init --ref-storage-format=files ordered &&
      	git -C ordered repo info layout.bare references.format layout.bare >actual &&
      	test_cmp expect actual
      '
    @@ t/t5510-fetch.sh: test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing ref
      	test_when_finished rm -rf base repo &&
      	(
     -		git init --ref-format=reftable base &&
    -+		git init --ref-storage=reftable base &&
    ++		git init --ref-storage-format=reftable base &&
      		cd base &&
      		echo >file update &&
      		git add . &&
    @@ t/t5510-fetch.sh: test_expect_success REFFILES 'existing reference lock in repo'
      		cd .. &&
      
     -		git init --ref-format=files --bare repo &&
    -+		git init --ref-storage=files --bare repo &&
    ++		git init --ref-storage-format=files --bare repo &&
      		cd repo &&
      		git remote add origin ../base &&
      		touch refs/heads/foo.lock &&
    @@ t/t5510-fetch.sh: test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict
      	test_when_finished rm -rf base repo &&
      	(
     -		git init --ref-format=reftable base &&
    -+		git init --ref-storage=reftable base &&
    ++		git init --ref-storage-format=reftable base &&
      		cd base &&
      		echo >file update &&
      		git add . &&
    @@ t/t5510-fetch.sh: test_expect_success REFFILES 'D/F conflict on case sensitive f
      		cd .. &&
      
     -		git init --ref-format=files --bare repo &&
    -+		git init --ref-storage=files --bare repo &&
    ++		git init --ref-storage-format=files --bare repo &&
      		cd repo &&
      		git remote add origin ../base &&
      		mkdir refs/heads/foo &&
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'add existing reposi
      		cd parent &&
      		test_commit parent &&
     -		git init --ref-format=$OTHER_FORMAT submodule &&
    -+		git init --ref-storage=$OTHER_FORMAT submodule &&
    ++		git init --ref-storage-format=$OTHER_FORMAT submodule &&
      		test_commit -C submodule submodule &&
      		git submodule add ./submodule
      	)
 2:  fed94ab4c5 !  2:  d5b7ea9c18 builtin/clone: rename "--ref-format=" to "--ref-storage="
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/clone: rename "--ref-format=" to "--ref-storage="
    +    builtin/clone: rename "--ref-format=" to "--ref-storage-format="
     
         With the same reasoning as for git-init(1), rename "--ref-format=" to
    -    "--ref-storage=" and keep the old name as an alias.
    +    "--ref-storage-format=" and keep the old name as an alias.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/git-clone.adoc: or `--mirror` is given)
      	tree.
      
     -`--ref-format=<ref-format>`::
    -+`--ref-storage=<ref-format>`::
    ++`--ref-storage-format=<format>`::
      
      Specify the given ref storage format for the repository. The valid values are:
      +
    @@ builtin/clone.c: int cmd_clone(int argc,
      	struct string_list option_not = STRING_LIST_INIT_NODUP;
      	const char *real_git_dir = NULL;
     -	const char *ref_format = NULL;
    -+	const char *ref_storage = NULL;
    ++	const char *ref_storage_format_str = NULL;
      	const char *option_upload_pack = "git-upload-pack";
      	int option_progress = -1;
      	int option_sparse_checkout = 0;
    @@ builtin/clone.c: int cmd_clone(int argc,
      			   N_("separate git dir from working tree")),
     -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
     -			   N_("specify the reference format to use")),
    -+		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage, N_("format"),
    ++		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
      		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
      				N_("set config inside the new repository")),
    @@ builtin/clone.c: int cmd_clone(int argc,
      
     -	if (ref_format) {
     -		ref_storage_format = ref_storage_format_by_name(ref_format);
    -+	if (ref_storage) {
    -+		ref_storage_format = ref_storage_format_by_name(ref_storage);
    ++	if (ref_storage_format_str) {
    ++		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
     -			die(_("unknown ref storage format '%s'"), ref_format);
    -+			die(_("unknown ref storage format '%s'"), ref_storage);
    ++			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
      	}
      
      	if (option_mirror) {
    @@ builtin/clone.c: int cmd_clone(int argc,
      ## t/t0610-reftable-basics.sh ##
     @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reffiles into reftable repository' '
      	test_when_finished "rm -rf reffiles reftable" &&
    - 	git init --ref-storage=files reffiles &&
    + 	git init --ref-storage-format=files reffiles &&
      	test_commit -C reffiles A &&
     -	git clone --ref-format=reftable ./reffiles reftable &&
    -+	git clone --ref-storage=reftable ./reffiles reftable &&
    ++	git clone --ref-storage-format=reftable ./reffiles reftable &&
      
      	git -C reffiles rev-parse HEAD >expect &&
      	git -C reftable rev-parse HEAD >actual &&
     @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reftable into reffiles repository' '
      	test_when_finished "rm -rf reffiles reftable" &&
    - 	git init --ref-storage=reftable reftable &&
    + 	git init --ref-storage-format=reftable reftable &&
      	test_commit -C reftable A &&
     -	git clone --ref-format=files ./reftable reffiles &&
    -+	git clone --ref-storage=files ./reftable reffiles &&
    ++	git clone --ref-storage-format=files ./reftable reffiles &&
      
      	git -C reftable rev-parse HEAD >expect &&
      	git -C reffiles rev-parse HEAD >actual &&
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reftable into
      ## t/t1460-refs-migrate.sh ##
     @@ t/t1460-refs-migrate.sh: do
      			test_when_finished "rm -rf repo repo.git" &&
    - 			git init --ref-storage=$from_format repo &&
    + 			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
     -			git clone --ref-format=$from_format --mirror repo repo.git &&
    -+			git clone --ref-storage=$from_format --mirror repo repo.git &&
    ++			git clone --ref-storage-format=$from_format --mirror repo repo.git &&
      			test_migration repo.git "$to_format"
      		'
      
    @@ t/t5510-fetch.sh: test_expect_success "clone and setup child repos" '
      	git clone . bundle &&
      	git clone . seven &&
     -	git clone --ref-format=reftable . case_sensitive &&
    -+	git clone --ref-storage=reftable . case_sensitive &&
    ++	git clone --ref-storage-format=reftable . case_sensitive &&
      	(
      		cd case_sensitive &&
      		git branch branch1 &&
      		git branch bRanch1
      	) &&
     -	git clone --ref-format=reftable . case_sensitive_fd &&
    -+	git clone --ref-storage=reftable . case_sensitive_fd &&
    ++	git clone --ref-storage-format=reftable . case_sensitive_fd &&
      	(
      		cd case_sensitive_fd &&
      		git branch foo/bar &&
      		git branch Foo
      	) &&
     -	git clone --ref-format=reftable . case_sensitive_df &&
    -+	git clone --ref-storage=reftable . case_sensitive_df &&
    ++	git clone --ref-storage-format=reftable . case_sensitive_df &&
      	(
      		cd case_sensitive_df &&
      		git branch Foo/bar &&
    @@ t/t5601-clone.sh: test_expect_success 'clone --mirror does not repeat tags' '
      test_expect_success 'clone with files ref format' '
      	test_when_finished "rm -rf ref-storage" &&
     -	git clone --ref-format=files --mirror src ref-storage &&
    -+	git clone --ref-storage=files --mirror src ref-storage &&
    ++	git clone --ref-storage-format=files --mirror src ref-storage &&
      	echo files >expect &&
      	git -C ref-storage rev-parse --show-ref-format >actual &&
      	test_cmp expect actual
    @@ t/t5601-clone.sh: test_expect_success 'clone with garbage ref format' '
      	fatal: unknown ref storage format ${SQ}garbage${SQ}
      	EOF
     -	test_must_fail git clone --ref-format=garbage --mirror src ref-storage 2>err &&
    -+	test_must_fail git clone --ref-storage=garbage --mirror src ref-storage 2>err &&
    ++	test_must_fail git clone --ref-storage-format=garbage --mirror src ref-storage 2>err &&
      	test_cmp expect err &&
      	test_path_is_missing ref-storage
      '
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone pro
     +	# specified via `--ref-storage`. The option should propagate to cloned
      	# submodules.
     -	git clone --ref-format=$OTHER_FORMAT --recurse-submodules \
    -+	git clone --ref-storage=$OTHER_FORMAT --recurse-submodules \
    ++	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
      		upstream downstream &&
      	test_ref_format downstream "$OTHER_FORMAT" &&
      	test_ref_format downstream/submodule "$OTHER_FORMAT"
 3:  ca59e60c85 !  3:  253a0e1360 builtin/refs: rename "--ref-format=" to "--ref-storage="
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/refs: rename "--ref-format=" to "--ref-storage="
    +    builtin/refs: rename "--ref-format=" to "--ref-storage-format="
     
         With the same reasoning as for git-init(1), rename "--ref-format=" to
    -    "--ref-storage=" and keep the old name as an alias.
    +    "--ref-storage-format=" and keep the old name as an alias.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/git-refs.adoc: git-refs - Low-level access to refs
      --------
      [synopsis]
     -git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
    -+git refs migrate --ref-storage=<format> [--no-reflog] [--dry-run]
    ++git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]
      git refs verify [--strict] [--verbose]
      git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
      		   [(--sort=<key>)...] [--format=<format>]
    @@ Documentation/git-refs.adoc: OPTIONS
      
     -`--ref-format=<format>`::
     -	The ref format to migrate the ref store to. Can be one of:
    -+`--ref-storage=<format>`::
    ++`--ref-storage-format=<format>`::
     +	The ref storage format to migrate the ref store to. Can be one of:
      +
      include::ref-storage-format.adoc[]
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
      			"store all remote references on disk. Or you can alternatively\n"
      			"migrate your repository to use the 'reftable' backend with the\n"
     -			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
    -+			"following command:\n\n    git refs migrate --ref-storage=reftable\n\n"
    ++			"following command:\n\n    git refs migrate --ref-storage-format=reftable\n\n"
      			"Please keep in mind that not all implementations of Git support this\n"
      			"new format yet. So if you use tools other than Git to access this\n"
      			"repository it may not be an option to migrate to reftables.\n"));
    @@ builtin/refs.c
      
      #define REFS_MIGRATE_USAGE \
     -	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
    -+	N_("git refs migrate --ref-storage=<format> [--no-reflog] [--dry-run]")
    ++	N_("git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]")
      
      #define REFS_VERIFY_USAGE \
      	N_("git refs verify [--strict] [--verbose]")
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      	struct option options[] = {
     -		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
     -			N_("specify the reference format to convert to"),
    -+		OPT_STRING_F(0, "ref-storage", &format_str, N_("format"),
    ++		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
     +			N_("specify the reference storage format to convert to"),
      			PARSE_OPT_NONEG),
     +		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      		usage(_("too many arguments"));
      	if (!format_str)
     -		usage(_("missing --ref-format=<format>"));
    -+		usage(_("missing --ref-storage=<format>"));
    ++		usage(_("missing --ref-storage-format=<format>"));
      
      	format = ref_storage_format_by_name(format_str);
      	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
    @@ t/t1423-ref-backend.sh: do
      				test_commit 3 &&
      
     -				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				git refs migrate --dry-run --ref-storage=$to_format >out &&
    ++				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
      				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
      				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
      			)
    @@ t/t1423-ref-backend.sh: do
      				test_commit 3 &&
      
     -				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				git refs migrate --dry-run --ref-storage=$to_format >out &&
    ++				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
      				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
      
      				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
    @@ t/t1423-ref-backend.sh: do
      				test_commit 3 &&
      
     -				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				git refs migrate --dry-run --ref-storage=$to_format >out &&
    ++				git refs migrate --dry-run --ref-storage-format=$to_format >out &&
      				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
      
      				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
    @@ t/t1423-ref-backend.sh: do
      			test_commit 3 &&
      
     -			git refs migrate --ref-format=$to_format &&
    -+			git refs migrate --ref-storage=$to_format &&
    ++			git refs migrate --ref-storage-format=$to_format &&
      			git refs list >out &&
      			test_grep "refs/tags/1"	out &&
      			test_grep "refs/tags/2"	out &&
    @@ t/t1460-refs-migrate.sh: test_migration () {
      	fi &&
      
     -	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
    -+	git -C "$repo" refs migrate --ref-storage="$format" "$@" &&
    ++	git -C "$repo" refs migrate --ref-storage-format="$format" "$@" &&
      
      	git -C "$repo" for-each-ref --include-root-refs \
      		--format='%(refname) %(objectname) %(symref)' >actual &&
    @@ t/t1460-refs-migrate.sh: test_expect_success "missing ref storage format" '
      	test_must_fail git -C repo refs migrate 2>err &&
      	cat >expect <<-EOF &&
     -	usage: missing --ref-format=<format>
    -+	usage: missing --ref-storage=<format>
    ++	usage: missing --ref-storage-format=<format>
      	EOF
      	test_cmp expect err
      '
    @@ t/t1460-refs-migrate.sh: test_expect_success "unknown ref storage format" '
      	git init repo &&
      	test_must_fail git -C repo refs migrate \
     -		--ref-format=unknown 2>err &&
    -+		--ref-storage=unknown 2>err &&
    ++		--ref-storage-format=unknown 2>err &&
      	cat >expect <<-EOF &&
      	error: unknown ref storage format ${SQ}unknown${SQ}
      	EOF
     @@ t/t1460-refs-migrate.sh: do
      			test_when_finished "rm -rf repo" &&
    - 			git init --ref-storage=$from_format repo &&
    + 			git init --ref-storage-format=$from_format repo &&
      			test_must_fail git -C repo refs migrate \
     -				--ref-format=$from_format 2>err &&
    -+				--ref-storage=$from_format 2>err &&
    ++				--ref-storage-format=$from_format 2>err &&
      			cat >expect <<-EOF &&
      			error: repository already uses ${SQ}$from_format${SQ} format
      			EOF
     @@ t/t1460-refs-migrate.sh: do
    - 			git init --ref-storage=$from_format repo &&
    + 			git init --ref-storage-format=$from_format repo &&
      			git -C repo worktree add wt &&
      			test_must_fail git -C repo refs migrate \
     -				--ref-format=$to_format 2>err &&
    -+				--ref-storage=$to_format 2>err &&
    ++				--ref-storage-format=$to_format 2>err &&
      			cat >expect <<-EOF &&
      			error: migrating repositories with worktrees is not supported yet
      			EOF
     @@ t/t1460-refs-migrate.sh: do
    - 			git init --ref-storage=$from_format repo &&
    + 			git init --ref-storage-format=$from_format repo &&
      			test_commit -C repo initial &&
      			git -C repo refs migrate --dry-run \
     -				--ref-format=$to_format >output &&
    -+				--ref-storage=$to_format >output &&
    ++				--ref-storage-format=$to_format >output &&
      			test_grep "Finished dry-run migration of refs" output &&
      			test_path_is_dir repo/.git/ref_migration.* &&
      			echo $from_format >expect &&
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'status with mixed s
      	git -C main submodule add "file://$(pwd)/submodule" &&
      	git -C main commit -m "add submodule" &&
     -	git -C main/submodule refs migrate --ref-format=$OTHER_FORMAT &&
    -+	git -C main/submodule refs migrate --ref-storage=$OTHER_FORMAT &&
    ++	git -C main/submodule refs migrate --ref-storage-format=$OTHER_FORMAT &&
      
      	# The main repository should use the default ref format now, whereas
      	# the submodule should use the other format.
 4:  1fd412e727 !  4:  00a5bf641d builtin/submodule: rename "--ref-format=" to "--ref-storage="
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/submodule: rename "--ref-format=" to "--ref-storage="
    +    builtin/submodule: rename "--ref-format=" to "--ref-storage-format="
     
         With the same reasoning as for git-init(1), rename "--ref-format=" to
    -    "--ref-storage=" and keep the old name as an alias.
    +    "--ref-storage-format=" and keep the old name as an alias.
     
         Note that this commit is a bit more complex compared to the others as we
         also need to adapt the submodule helper for consistency. But overall,
    @@ Documentation/git-submodule.adoc: COMMANDS
      subcommands are available to perform operations on the submodules.
      
     -`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
    -+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage <format>] [--depth <depth>] [--] <repository> [<path>]`::
    ++`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
      	Add the given repository as a submodule at the given path
      	to the changeset to be committed next to the current
      	project: the current project is termed the "superproject".
    @@ Documentation/git-submodule.adoc: location, and only the superproject's URL need
      URL in `.gitmodules`.
      +
     -If `--ref-format <format>`  is specified, the ref storage format of newly
    -+If `--ref-storage <format>`  is specified, the ref storage format of newly
    ++If `--ref-storage-format <format>`  is specified, the ref storage format of newly
      cloned submodules will be set accordingly.
      
      `status [--cached] [--recursive] [--] [<path>...]`::
    @@ Documentation/git-submodule.adoc: If you really want to remove a submodule from
      options.
      
     -`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
    -+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
    ++`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
      +
      --
      Update the registered submodules to match what the superproject
    @@ Documentation/git-submodule.adoc: submodule with the `--init` option.
      registered submodules, and update any nested submodules within.
      
     -If `--ref-format <format>`  is specified, the ref storage format of newly
    -+If `--ref-storage <format>`  is specified, the ref storage format of newly
    ++If `--ref-storage-format <format>`  is specified, the ref storage format of newly
      cloned submodules will be set accordingly.
      
      If `--filter <filter-spec>` is specified, the given partial clone filter will be
    @@ builtin/clone.c: static int checkout(int submodule_progress,
      
      		if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
     -			strvec_pushf(&cmd.args, "--ref-format=%s",
    -+			strvec_pushf(&cmd.args, "--ref-storage=%s",
    ++			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
      				     ref_storage_format_to_name(ref_storage_format));
      
      		if (filter_submodules && filter_options->choice)
    @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clon
      		}
      		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
     -			strvec_pushf(&cp.args, "--ref-format=%s",
    -+			strvec_pushf(&cp.args, "--ref-storage=%s",
    ++			strvec_pushf(&cp.args, "--ref-storage-format=%s",
      				     ref_storage_format_to_name(clone_data->ref_storage_format));
      		if (clone_data->dissociate)
      			strvec_push(&cp.args, "--dissociate");
    @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
      			   N_("reference repository")),
     -		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
     -			   N_("specify the reference format to use")),
    -+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
     +		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
     +			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      		strvec_push(&child->args, "--require-init");
      	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
     -		strvec_pushf(&child->args, "--ref-format=%s",
    -+		strvec_pushf(&child->args, "--ref-storage=%s",
    ++		strvec_pushf(&child->args, "--ref-storage-format=%s",
      			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
      	strvec_pushl(&child->args, "--path", sub->path, NULL);
      	strvec_pushl(&child->args, "--name", sub->name, NULL);
    @@ builtin/submodule--helper.c: static void update_data_to_args(const struct update
      	}
      	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
     -		strvec_pushf(args, "--ref-format=%s",
    -+		strvec_pushf(args, "--ref-storage=%s",
    ++		strvec_pushf(args, "--ref-storage-format=%s",
      			     ref_storage_format_to_name(update_data->ref_storage_format));
      	if (update_data->filter_options && update_data->filter_options->choice)
      		strvec_pushf(args, "--filter=%s",
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      			   N_("reference repository")),
     -		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
     -			   N_("specify the reference format to use")),
    -+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
     +		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
     +			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
      			   N_("reference repository")),
     -		OPT_STRING(0, "ref-format", &ref_storage_format, N_("format"),
     -			   N_("specify the reference format to use")),
    -+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
     +		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
     +			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    @@ git-submodule.sh: cmd_add()
      			reference="$1"
      			;;
     -		--ref-format)
    -+		--ref-format|--ref-storage)
    ++		--ref-format|--ref-storage-format)
      			case "$2" in '') usage ;; esac
     -			ref_format="--ref-format=$2"
    -+			ref_storage="--ref-storage=$2"
    ++			ref_storage_format="--ref-storage-format=$2"
      			shift
      			;;
     -		--ref-format=*)
     -			ref_format="$1"
    -+		--ref-format=*|--ref-storage=*)
    -+			ref_storage="$1"
    ++		--ref-format=*|--ref-storage-format=*)
    ++			ref_storage_format="$1"
      			;;
      		--dissociate)
      			dissociate=$1
    @@ git-submodule.sh: cmd_add()
      		${branch:+"$branch"} \
      		${reference:+"$reference"} \
     -		${ref_format:+"$ref_format"} \
    -+		${ref_storage:+"$ref_storage"} \
    ++		${ref_storage_format:+"$ref_storage_format"} \
      		$dissociate \
      		${name:+"$name"} \
      		${depth:+"$depth"} \
    @@ git-submodule.sh: cmd_update()
      			rebase=$1
      			;;
     -		--ref-format)
    -+		--ref-format|--ref-storage)
    ++		--ref-format|--ref-storage-format)
      			case "$2" in '') usage ;; esac
     -			ref_format="--ref-format=$2"
    -+			ref_storage="--ref-storage=$2"
    ++			ref_storage_format="--ref-storage-format=$2"
      			shift
      			;;
     -		--ref-format=*)
     -			ref_format="$1"
    -+		--ref-format=*|--ref-storage=*)
    -+			ref_storage="$1"
    ++		--ref-format=*|--ref-storage-format=*)
    ++			ref_storage_format="$1"
      			;;
      		--reference)
      			case "$2" in '') usage ;; esac
    @@ git-submodule.sh: cmd_update()
      		$merge \
      		$checkout \
     -		${ref_format:+"$ref_format"} \
    -+		${ref_storage:+"$ref_storage"} \
    ++		${ref_storage_format:+"$ref_storage_format"} \
      		${reference:+"$reference"} \
      		$dissociate \
      		${depth:+"$depth"} \
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'add submodules with
      	git init upstream &&
      	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
     -	git -C upstream submodule add --ref-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
    -+	git -C upstream submodule add --ref-storage="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
    ++	git -C upstream submodule add --ref-storage-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
      	test_ref_format upstream/submodule "$OTHER_FORMAT"
      '
      
    +@@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone propagates ref storage format' '
    + 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
    + 
    + 	# The cloned repositories should use the other ref format that we have
    +-	# specified via `--ref-storage`. The option should propagate to cloned
    ++	# specified via `--ref-storage-format`. The option should propagate to cloned
    + 	# submodules.
    + 	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
    + 		upstream downstream &&
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'clone submodules with different ref storage format' '
      
      	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
      	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
     -	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
    -+	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
    ++	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
      	test_ref_format downstream/submodule "$OTHER_FORMAT"
      '
      
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive pull with
      	# submodules have different formats.
      	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
     -	git -C downstream submodule update --init --ref-format=$OTHER_FORMAT &&
    -+	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
    ++	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
      	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
      	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
      
 5:  8abcb5c6df !  5:  25cdb00f8c builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage"
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage"
    +    builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage-format"
     
         With the same reasoning as for git-init(1), rename "--show-ref-format"
    -    to "--show-ref-storage" and keep the old name as an alias.
    +    to "--show-ref-storage-format" and keep the old name as an alias.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/git-rev-parse.adoc: The following options are unaffected by `--pat
      	not specified, the default is "storage".
      
     ---show-ref-format::
    -+--show-ref-storage::
    ++--show-ref-storage-format::
      	Show the reference storage format used for the repository.
      
      
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      				continue;
      			}
     -			if (!strcmp(arg, "--show-ref-format")) {
    -+			if (!strcmp(arg, "--show-ref-format") || !strcmp(arg, "--show-ref-storage")) {
    ++			if (!strcmp(arg, "--show-ref-format") || !strcmp(arg, "--show-ref-storage-format")) {
      				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
      				continue;
      			}
    @@ contrib/completion/git-prompt.sh: __git_ps1 ()
      	local repo_info rev_parse_exit_code
      	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
     -		--is-bare-repository --is-inside-work-tree --show-ref-format \
    -+		--is-bare-repository --is-inside-work-tree --show-ref-storage \
    ++		--is-bare-repository --is-inside-work-tree --show-ref-storage-format \
      		--short HEAD 2>/dev/null)"
      	rev_parse_exit_code="$?"
      
    @@ t/perf/perf-lib.sh: test_perf_create_repo_from () {
      	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
      	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
     -	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
    -+	refstorage="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-storage)"
    ++	ref_storage_format="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-storage-format)"
      	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
      	mkdir -p "$repo/.git"
      	(
    @@ t/perf/perf-lib.sh: test_perf_create_repo_from () {
      	) &&
      	(
      		cd "$repo" &&
    --		"$MODERN_GIT" init -q --ref-storage="$refformat" --object-format="$objectformat" &&
    -+		"$MODERN_GIT" init -q --ref-storage="$refstorage" --object-format="$objectformat" &&
    +-		"$MODERN_GIT" init -q --ref-storage-format="$refformat" --object-format="$objectformat" &&
    ++		"$MODERN_GIT" init -q --ref-storage-format="$ref_storage_format" --object-format="$objectformat" &&
      		test_perf_do_repo_symlink_config_ &&
      		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
      		if test -f .git/index.lock
    @@ t/t0001-init.sh: test_expect_success 'init warns about invalid init.defaultRefFo
      	test_cmp expect err &&
      
     -	git -C repo rev-parse --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-ref-storage-format >actual &&
      	echo $GIT_DEFAULT_REF_FORMAT >expected &&
      	test_cmp expected actual
      '
    @@ t/t0001-init.sh: test_expect_success 'default ref format' '
      	) &&
      	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: do
      
      		echo $format >expect &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
     @@ t/t0001-init.sh: do
      		test_when_finished "rm -rf refformat" &&
    - 		git init --ref-storage=$format refformat &&
    + 		git init --ref-storage-format=$format refformat &&
      		echo $format >expect &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
    @@ t/t0001-init.sh: do
      
      		echo $format >expect &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
     @@ t/t0001-init.sh: do
      		test_when_finished "rm -rf refformat" &&
    - 		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
    + 		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
      		echo $format >expect &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
    @@ t/t0001-init.sh: do
      		test_when_finished "rm -rf refformat" &&
      		git init refformat &&
     -		git -C refformat rev-parse --show-ref-format >expect &&
    -+		git -C refformat rev-parse --show-ref-storage >expect &&
    ++		git -C refformat rev-parse --show-ref-storage-format >expect &&
      		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      done
    -@@ t/t0001-init.sh: test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
    +@@ t/t0001-init.sh: test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
      	test_when_finished "rm -rf refformat" &&
    - 	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
    + 	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
      	echo reftable >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.def
      	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
      	echo reftable >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success "init with feature.experimental=true" '
      	) &&
      	echo reftable >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success "init.defaultRefFormat overrides feature.ex
      	) &&
      	echo files >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.
      	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
      	echo files >expect &&
     -	git -C refformat rev-parse --show-ref-format >actual &&
    -+	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
     @@ t/t0001-init.sh: do
    - 		git init --ref-storage=$from_format refformat &&
    - 		git init --ref-storage=$from_format refformat &&
    + 		git init --ref-storage-format=$from_format refformat &&
    + 		git init --ref-storage-format=$from_format refformat &&
      		echo $from_format >expect &&
     -		git -C refformat rev-parse --show-ref-format >actual &&
    -+		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
     @@ t/t0001-init.sh: do
    - 			test_must_fail git init --ref-storage=$to_format refformat 2>err &&
    + 			test_must_fail git init --ref-storage-format=$to_format refformat 2>err &&
      			test_cmp expect err &&
      			echo $from_format >expect &&
     -			git -C refformat rev-parse --show-ref-format >actual &&
    -+			git -C refformat rev-parse --show-ref-storage >actual &&
    ++			git -C refformat rev-parse --show-ref-storage-format >actual &&
      			test_cmp expect actual
      		'
      	done
    @@ t/t0001-init.sh: test_expect_success 'init with includeIf.onbranch condition' '
      	git -c includeIf.onbranch:main.path=nonexistent init repo &&
      	echo $GIT_DEFAULT_REF_FORMAT >expect &&
     -	git -C repo rev-parse --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success 'init with includeIf.onbranch condition wit
      	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
      	echo $GIT_DEFAULT_REF_FORMAT >expect &&
     -	git -C repo rev-parse --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0001-init.sh: test_expect_success 're-init with includeIf.onbranch condition'
      	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
      	echo $GIT_DEFAULT_REF_FORMAT >expect &&
     -	git -C repo rev-parse --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'init: creates basic reftable st
      	test_path_is_file repo/.git/reftable/tables.list &&
      	echo reftable >expect &&
     -	git -C repo rev-parse --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'init: sha256 object format via
      	reftable
      	EOF
     -	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-object-format --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-object-format --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'init: sha256 object format via
      	reftable
      	EOF
     -	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
    -+	git -C repo rev-parse --show-object-format --show-ref-storage >actual &&
    ++	git -C repo rev-parse --show-object-format --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reftable repos
      	git clone repo cloned &&
      	echo reftable >expect &&
     -	git -C cloned rev-parse --show-ref-format >actual &&
    -+	git -C cloned rev-parse --show-ref-storage >actual &&
    ++	git -C cloned rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual &&
      	test_path_is_file cloned/file1
      '
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reffiles into
      	test_cmp expect actual &&
      
     -	git -C reftable rev-parse --show-ref-format >actual &&
    -+	git -C reftable rev-parse --show-ref-storage >actual &&
    ++	git -C reftable rev-parse --show-ref-storage-format >actual &&
      	echo reftable >expect &&
      	test_cmp expect actual &&
      
     -	git -C reffiles rev-parse --show-ref-format >actual &&
    -+	git -C reffiles rev-parse --show-ref-storage >actual &&
    ++	git -C reffiles rev-parse --show-ref-storage-format >actual &&
      	echo files >expect &&
      	test_cmp expect actual
      '
    @@ t/t0610-reftable-basics.sh: test_expect_success 'clone: can clone reftable into
      	test_cmp expect actual &&
      
     -	git -C reftable rev-parse --show-ref-format >actual &&
    -+	git -C reftable rev-parse --show-ref-storage >actual &&
    ++	git -C reftable rev-parse --show-ref-storage-format >actual &&
      	echo reftable >expect &&
      	test_cmp expect actual &&
      
     -	git -C reffiles rev-parse --show-ref-format >actual &&
    -+	git -C reffiles rev-parse --show-ref-storage >actual &&
    ++	git -C reffiles rev-parse --show-ref-storage-format >actual &&
      	echo files >expect &&
      	test_cmp expect actual
      '
    @@ t/t1460-refs-migrate.sh: test_migration () {
      	fi &&
      
     -	git -C "$repo" rev-parse --show-ref-format >actual &&
    -+	git -C "$repo" rev-parse --show-ref-storage >actual &&
    ++	git -C "$repo" rev-parse --show-ref-storage-format >actual &&
      	echo "$format" >expect &&
      	test_cmp expect actual
      }
    @@ t/t1460-refs-migrate.sh: do
      			test_path_is_dir repo/.git/ref_migration.* &&
      			echo $from_format >expect &&
     -			git -C repo rev-parse --show-ref-format >actual &&
    -+			git -C repo rev-parse --show-ref-storage >actual &&
    ++			git -C repo rev-parse --show-ref-storage-format >actual &&
      			test_cmp expect actual
      		'
      
    @@ t/t1500-rev-parse.sh: test_expect_success RUST 'rev-parse --show-object-format i
      '
      
     -test_expect_success 'rev-parse --show-ref-format' '
    -+test_expect_success 'rev-parse --show-ref-storage' '
    ++test_expect_success 'rev-parse --show-ref-storage-format' '
      	test_detect_ref_format >expect &&
     -	git rev-parse --show-ref-format >actual &&
    -+	git rev-parse --show-ref-storage >actual &&
    ++	git rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
     -test_expect_success 'rev-parse --show-ref-format with invalid storage' '
    -+test_expect_success 'rev-parse --show-ref-storage with invalid storage' '
    ++test_expect_success 'rev-parse --show-ref-storage-format with invalid storage' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
      	(
      		cd repo &&
      		git config extensions.refstorage broken &&
     -		test_must_fail git rev-parse --show-ref-format 2>err &&
    -+		test_must_fail git rev-parse --show-ref-storage 2>err &&
    ++		test_must_fail git rev-parse --show-ref-storage-format 2>err &&
      		test_grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}broken${SQ}" err
      	)
      '
    @@ t/t1500-rev-parse.sh: test_expect_success RUST 'rev-parse --show-object-format i
      ## t/t5601-clone.sh ##
     @@ t/t5601-clone.sh: test_expect_success 'clone with files ref format' '
      	test_when_finished "rm -rf ref-storage" &&
    - 	git clone --ref-storage=files --mirror src ref-storage &&
    + 	git clone --ref-storage-format=files --mirror src ref-storage &&
      	echo files >expect &&
     -	git -C ref-storage rev-parse --show-ref-format >actual &&
    -+	git -C ref-storage rev-parse --show-ref-storage >actual &&
    ++	git -C ref-storage rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_description='submodules handle mixe
      test_ref_format () {
      	echo "$2" >expect &&
     -	git -C "$1" rev-parse --show-ref-format >actual &&
    -+	git -C "$1" rev-parse --show-ref-storage >actual &&
    ++	git -C "$1" rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      }
      
 6:  b231264a6c !  6:  08a5f120a7 help: rename "default-ref-format" to "default-ref-storage"
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    help: rename "default-ref-format" to "default-ref-storage"
    +    help: rename "default-ref-format" to "default-ref-storage-format"
     
         When printing information about how specifically Git was built and what
         defaults it has we also print the default ref storage format used when
    @@ Commit message
         "reftable" backend.
     
         In preceding commits we have adapted "ref-format" parameters to be
    -    called "ref-storage" instead to resolve some conceptual mismatches. The
    -    build information is now the only place where we still refer to it as
    -    "default-ref-format".
    +    called "ref-storage-format" instead to resolve some conceptual
    +    mismatches. The build information is now the only place where we still
    +    refer to it as "default-ref-format".
     
    -    Rename the field to "default-ref-storage" instead.
    +    Rename the field to "default-ref-storage-format" instead.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
      #endif
      		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
     -		strbuf_addf(buf, "default-ref-format: %s\n",
    -+		strbuf_addf(buf, "default-ref-storage: %s\n",
    ++		strbuf_addf(buf, "default-ref-storage-format: %s\n",
      			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
      		strbuf_addf(buf, "default-hash: %s\n", hash_algos[GIT_HASH_DEFAULT].name);
      	}
    @@ t/t0001-init.sh: test_expect_success 'default ref format' '
      		git init refformat
      	) &&
     -	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
    -+	git version --build-options | sed -ne "s/^default-ref-storage: //p" >expect &&
    - 	git -C refformat rev-parse --show-ref-storage >actual &&
    ++	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
    + 	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
 7:  afb4c5bf04 =  7:  dca79435f2 refs: expose function to parse reference URIs
 8:  bfe1888fd4 !  8:  44c87d6aa1 setup: refactor how we configure the ref storage format
    @@ Commit message
         and makes the whole logic significantly easier to extend going forward.
     
         Note that the new logic intentionally changes the precedence order so
    -    that "GIT_REFERENCE_BACKEND" is now overridden by the "--ref-storage="
    -    command line option. This matches our usual precedence order, where
    -    explicit command line arguments override environment variables.
    +    that "GIT_REFERENCE_BACKEND" is now overridden by the
    +    "--ref-storage-format=" command line option. This matches our usual
    +    precedence order, where explicit command line arguments override
    +    environment variables.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
     +	 * storage format:
     +	 *
     +	 *   1. Explicit override via the command line, like in `git init
    -+	 *      --ref-storage=`.
    ++	 *      --ref-storage-format=`.
     +	 *
     +	 *   2. Explicit override via the environment with
     +	 *      GIT_REFERENCE_BACKEND.
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
     +	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
     +		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
     +		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    -+			die(_("unknown reference storage format specified via %s: '%s'"),
    ++			die(_("unknown ref storage format specified via %s: '%s'"),
     +			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
     +	} else if (repo_fmt->version >= 0) {
     +		ref_storage_format = repo_fmt->ref_storage_format;
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
     +	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
     +		ref_storage_format = ref_storage_format_by_name(env);
     +		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    -+			die(_("unknown reference storage format specified via %s: '%s'"),
    ++			die(_("unknown ref storage format specified via %s: '%s'"),
     +			    "GIT_DEFAULT_REF_FORMAT", env);
     +	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
     +		ref_storage_format = cfg.ref_storage_format;
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage
      	test_when_finished "rm -rf refformat" &&
      	cat >expect <<-EOF &&
     -	fatal: unknown ref storage format ${SQ}garbage${SQ}
    -+	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
    ++	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
      	EOF
      	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
      	test_cmp expect err
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage
      
     +test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
     +	test_when_finished "rm -rf refbackend" &&
    -+	git init --ref-storage=files refbackend &&
    ++	git init --ref-storage-format=files refbackend &&
     +	cat >expect <<-EOF &&
     +	fatal: attempt to reinitialize repository with different reference storage format
     +	EOF
 9:  87f271e84d !  9:  63a0e94d20 setup: rename ref storage format environment variables
    @@ Commit message
     
         With the same reasoning as for git-init(1), rename the environment
         variables GIT_REFERENCE_BACKEND and GIT_DEFAULT_REF_FORMAT to
    -    GIT_REF_STORAGE and GIT_DEFAULT_REF_STORAGE, respectively. The old names
    -    are kept as an alias to retain compatibility.
    +    GIT_REF_STORAGE_FORMAT and GIT_DEFAULT_REF_STORAGE_FORMAT, respectively.
    +    The old names are kept as an alias to retain compatibility.
    +
    +    While at it, fix indentation for `GIT_REF_STORAGE_FORMAT` docs to use
    +    tabs instead of spaces.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/config/init.adoc
     @@ Documentation/config/init.adoc: endif::[]
      `init.defaultRefFormat`::
      	Allows overriding the default ref storage format for new repositories.
    - 	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
    + 	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
     -	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
    -+	option and the `GIT_DEFAULT_REF_STORAGE` environment variable take
    ++	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
      	precedence over this config.
      
      init.defaultSubmodulePathConfig::
    @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., th
      	See `--object-format` in linkgit:git-init[1].
      
     -`GIT_DEFAULT_REF_FORMAT`::
    -+`GIT_DEFAULT_REF_STORAGE`::
    - 	If this variable is set, the default reference backend format for new
    +-	If this variable is set, the default reference backend format for new
    ++`GIT_DEFAULT_REF_STORAGE_FORMAT`::
    ++	If this variable is set, the default ref storage format for new
      	repositories will be set to this value. The default is "files".
    - 	See `--ref-storage` in linkgit:git-init[1].
    + 	See `--ref-storage-format` in linkgit:git-init[1].
      
     -`GIT_REFERENCE_BACKEND`::
     -    Specify which reference backend to be used along with its URI.
    -+`GIT_REF_STORAGE`::
    -+    Specify which ref storage to be used along with its URI.
    -     See `extensions.refStorage` option in linkgit:git-config[1] for more
    -     details. Overrides the config variable when used.
    - 
    +-    See `extensions.refStorage` option in linkgit:git-config[1] for more
    +-    details. Overrides the config variable when used.
    ++`GIT_REF_STORAGE_FORMAT`::
    ++	Specify which ref storage format to use along with its URI.
    ++	See `extensions.refStorage` option in linkgit:git-config[1] for more
    ++	details. Overrides the config variable when used.
    + 
    + Git Commits
    + ~~~~~~~~~~~
     
      ## environment.h ##
     @@
      #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
      #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
      #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
    -+#define GIT_REF_STORAGE_ENVIRONMENT "GIT_REF_STORAGE"
    ++#define GIT_REF_STORAGE_FORMAT_ENVIRONMENT "GIT_REF_STORAGE_FORMAT"
      
      /*
       * Environment variable used to propagate the --no-advice global option to the
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
      			 * for 'extensions.refStorage'.
      			 */
     -			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
    -+			ref_backend_uri = getenv(GIT_REF_STORAGE_ENVIRONMENT);
    ++			ref_backend_uri = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT);
     +			if (!ref_backend_uri)
     +				ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
      			if (ref_backend_uri) {
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
      				discovery.format.ref_storage_format =
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
      	 *   1. Explicit override via the command line, like in `git init
    - 	 *      --ref-storage=`.
    + 	 *      --ref-storage-format=`.
      	 *
     -	 *   2. Explicit override via the environment with
     -	 *      GIT_REFERENCE_BACKEND.
    -+	 *   2. Explicit override via the environment with "GIT_REF_STORAGE" or
    -+	 *      its deprecated equivalent "GIT_REFERENCE_BACKEND".
    ++	 *   2. Explicit override via the environment with "GIT_REF_STORAGE_FORMAT"
    ++	 *      or its deprecated equivalent "GIT_REFERENCE_BACKEND".
      	 *
      	 *   3. Existing repository format. All the subsequent sources only
      	 *      kick in when there is no repository yet.
      	 *
      	 *   4. The default ref storage format for new repositories as
     -	 *      configured via "GIT_DEFAULT_REF_FORMAT".
    -+	 *      configured via "GIT_DEFAULT_REF_STORAGE" or its deprecated
    -+	 *      equivalent "GIT_DEFAULT_REF_FORMAT".
    ++	 *      configured via "GIT_DEFAULT_REF_STORAGE_FORMAT" or its
    ++	 *      deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
      	 *
      	 *   5. The default ref storage format for new repositories as
      	 *      configured via "init.defaultRefFormat"
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
      	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
      		/* nothing to do */
     -	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
    -+	} else if (((env = getenv(GIT_REF_STORAGE_ENVIRONMENT)) ||
    ++	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
     +		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
      		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    - 			die(_("unknown reference storage format specified via %s: '%s'"),
    + 			die(_("unknown ref storage format specified via %s: '%s'"),
     -			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
    -+			    GIT_REF_STORAGE_ENVIRONMENT, env);
    ++			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);
      	} else if (repo_fmt->version >= 0) {
      		ref_storage_format = repo_fmt->ref_storage_format;
      		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
     -	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
    -+	} else if (((env = getenv("GIT_DEFAULT_REF_STORAGE")) ||
    ++	} else if (((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT")) ||
     +		    (env = getenv("GIT_DEFAULT_REF_FORMAT")))) {
      		ref_storage_format = ref_storage_format_by_name(env);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    - 			die(_("unknown reference storage format specified via %s: '%s'"),
    + 			die(_("unknown ref storage format specified via %s: '%s'"),
     -			    "GIT_DEFAULT_REF_FORMAT", env);
    -+			    "GIT_DEFAULT_REF_STORAGE", env);
    ++			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);
      	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
      		ref_storage_format = cfg.ref_storage_format;
      	} else {
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage
      '
      
     -test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
    -+test_expect_success 'init with GIT_DEFAULT_REF_STORAGE=garbage' '
    ++test_expect_success 'init with GIT_DEFAULT_REF_STORAGE_FORMAT=garbage' '
      	test_when_finished "rm -rf refformat" &&
      	cat >expect <<-EOF &&
    --	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
    -+	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_STORAGE: ${SQ}garbage${SQ}
    +-	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
    ++	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_STORAGE_FORMAT: ${SQ}garbage${SQ}
      	EOF
     -	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
    -+	test_must_fail env GIT_DEFAULT_REF_STORAGE=garbage git init refformat 2>err &&
    ++	test_must_fail env GIT_DEFAULT_REF_STORAGE_FORMAT=garbage git init refformat 2>err &&
      	test_cmp expect err
      '
      
     -test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
    -+test_expect_success 'GIT_REF_STORAGE refuses to reinitialize with different storage format' '
    ++test_expect_success 'GIT_REF_STORAGE_FORMAT refuses to reinitialize with different storage format' '
      	test_when_finished "rm -rf refbackend" &&
    - 	git init --ref-storage=files refbackend &&
    + 	git init --ref-storage-format=files refbackend &&
      	cat >expect <<-EOF &&
      	fatal: attempt to reinitialize repository with different reference storage format
      	EOF
     -	test_must_fail env GIT_REFERENCE_BACKEND=reftable git init refbackend 2>err &&
    -+	test_must_fail env GIT_REF_STORAGE=reftable git init refbackend 2>err &&
    ++	test_must_fail env GIT_REF_STORAGE_FORMAT=reftable git init refbackend 2>err &&
      	test_cmp expect err
      '
      
     @@ t/t0001-init.sh: test_expect_success 'init warns about invalid init.defaultRefFormat' '
      	test_cmp expect err &&
      
    - 	git -C repo rev-parse --show-ref-storage >actual &&
    + 	git -C repo rev-parse --show-ref-storage-format >actual &&
     -	echo $GIT_DEFAULT_REF_FORMAT >expected &&
    -+	echo $GIT_DEFAULT_REF_STORAGE >expected &&
    ++	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expected &&
      	test_cmp expected actual
      '
      
    @@ t/t0001-init.sh: test_expect_success 'init warns about invalid init.defaultRefFo
      	test_when_finished "rm -rf refformat" &&
      	(
     -		sane_unset GIT_DEFAULT_REF_FORMAT &&
    -+		sane_unset GIT_DEFAULT_REF_STORAGE &&
    ++		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      		git init refformat
      	) &&
    - 	git version --build-options | sed -ne "s/^default-ref-storage: //p" >expect &&
    + 	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
     @@ t/t0001-init.sh: test_expect_success 'default ref format' '
      backends="files reftable"
      for format in $backends
      do
     -	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '
    -+	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_STORAGE=$format" '
    ++	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_STORAGE_FORMAT=$format" '
      		test_when_finished "rm -rf refformat" &&
     -		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
    -+		GIT_DEFAULT_REF_STORAGE=$format git init refformat &&
    ++		GIT_DEFAULT_REF_STORAGE_FORMAT=$format git init refformat &&
      
      		if test $format = files
      		then
    @@ t/t0001-init.sh: do
      		test_config_global init.defaultRefFormat $format &&
      		(
     -			sane_unset GIT_DEFAULT_REF_FORMAT &&
    -+			sane_unset GIT_DEFAULT_REF_STORAGE &&
    ++			sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      			git init refformat
      		) &&
      
    @@ t/t0001-init.sh: do
      		test_cmp expect actual
      	'
      
    --	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_FORMAT" '
    -+	test_expect_success "--ref-storage=$format overrides GIT_DEFAULT_REF_STORAGE" '
    +-	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
    ++	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_STORAGE_FORMAT" '
      		test_when_finished "rm -rf refformat" &&
    --		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
    -+		GIT_DEFAULT_REF_STORAGE=garbage git init --ref-storage=$format refformat &&
    +-		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
    ++		GIT_DEFAULT_REF_STORAGE_FORMAT=garbage git init --ref-storage-format=$format refformat &&
      		echo $format >expect &&
    - 		git -C refformat rev-parse --show-ref-storage >actual &&
    + 		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      
     -	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
    -+	test_expect_success "reinit repository with GIT_DEFAULT_REF_STORAGE=$format does not change format" '
    ++	test_expect_success "reinit repository with GIT_DEFAULT_REF_STORAGE_FORMAT=$format does not change format" '
      		test_when_finished "rm -rf refformat" &&
      		git init refformat &&
    - 		git -C refformat rev-parse --show-ref-storage >expect &&
    + 		git -C refformat rev-parse --show-ref-storage-format >expect &&
     -		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
    -+		GIT_DEFAULT_REF_STORAGE=$format git init refformat &&
    - 		git -C refformat rev-parse --show-ref-storage >actual &&
    ++		GIT_DEFAULT_REF_STORAGE_FORMAT=$format git init refformat &&
    + 		git -C refformat rev-parse --show-ref-storage-format >actual &&
      		test_cmp expect actual
      	'
      done
      
    --test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
    -+test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_STORAGE" '
    +-test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
    ++test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOMAT" '
      	test_when_finished "rm -rf refformat" &&
    --	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
    -+	GIT_DEFAULT_REF_STORAGE=files git init --ref-storage=reftable refformat &&
    +-	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
    ++	GIT_DEFAULT_REF_STORAGE_FORMAT=files git init --ref-storage-format=reftable refformat &&
      	echo reftable >expect &&
    - 	git -C refformat rev-parse --show-ref-storage >actual &&
    + 	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
      
     -test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
    -+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefFormat" '
    ++test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefFormat" '
      	test_when_finished "rm -rf refformat" &&
      	test_config_global init.defaultRefFormat files &&
      
     -	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
    -+	GIT_DEFAULT_REF_STORAGE=reftable git init refformat &&
    ++	GIT_DEFAULT_REF_STORAGE_FORMAT=reftable git init refformat &&
      	echo reftable >expect &&
    - 	git -C refformat rev-parse --show-ref-storage >actual &&
    + 	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
     @@ t/t0001-init.sh: test_expect_success "init with feature.experimental=true" '
      	test_when_finished "rm -rf refformat" &&
      	test_config_global feature.experimental true &&
      	(
     -		sane_unset GIT_DEFAULT_REF_FORMAT &&
    -+		sane_unset GIT_DEFAULT_REF_STORAGE &&
    ++		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      		git init refformat
      	) &&
      	echo reftable >expect &&
    @@ t/t0001-init.sh: test_expect_success "init.defaultRefFormat overrides feature.ex
      	test_config_global init.defaultRefFormat files &&
      	(
     -		sane_unset GIT_DEFAULT_REF_FORMAT &&
    -+		sane_unset GIT_DEFAULT_REF_STORAGE &&
    ++		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      		git init refformat
      	) &&
      	echo files >expect &&
    @@ t/t0001-init.sh: test_expect_success "init.defaultRefFormat overrides feature.ex
      '
      
     -test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true" '
    -+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides feature.experimental=true" '
    ++test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides feature.experimental=true" '
      	test_when_finished "rm -rf refformat" &&
      	test_config_global feature.experimental true &&
     -	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
    -+	GIT_DEFAULT_REF_STORAGE=files git init refformat &&
    ++	GIT_DEFAULT_REF_STORAGE_FORMAT=files git init refformat &&
      	echo files >expect &&
    - 	git -C refformat rev-parse --show-ref-storage >actual &&
    + 	git -C refformat rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
     @@ t/t0001-init.sh: test_expect_success 'branch -m with the initial branch' '
      test_expect_success 'init with includeIf.onbranch condition' '
      	test_when_finished "rm -rf repo" &&
      	git -c includeIf.onbranch:main.path=nonexistent init repo &&
     -	echo $GIT_DEFAULT_REF_FORMAT >expect &&
    -+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
    - 	git -C repo rev-parse --show-ref-storage >actual &&
    ++	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
    + 	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
     @@ t/t0001-init.sh: test_expect_success 'init with includeIf.onbranch condition with existing direct
    @@ t/t0001-init.sh: test_expect_success 'init with includeIf.onbranch condition wit
      	mkdir repo &&
      	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
     -	echo $GIT_DEFAULT_REF_FORMAT >expect &&
    -+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
    - 	git -C repo rev-parse --show-ref-storage >actual &&
    ++	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
    + 	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
     @@ t/t0001-init.sh: test_expect_success 're-init with includeIf.onbranch condition' '
    @@ t/t0001-init.sh: test_expect_success 're-init with includeIf.onbranch condition'
      	git init repo &&
      	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
     -	echo $GIT_DEFAULT_REF_FORMAT >expect &&
    -+	echo $GIT_DEFAULT_REF_STORAGE >expect &&
    - 	git -C repo rev-parse --show-ref-storage >actual &&
    ++	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
    + 	git -C repo rev-parse --show-ref-storage-format >actual &&
      	test_cmp expect actual
      '
     
    @@ t/t1419-exclude-refs.sh: assert_jumps () {
      	local trace="$2"
      
     -	case "$GIT_DEFAULT_REF_FORMAT" in
    -+	case "$GIT_DEFAULT_REF_STORAGE" in
    ++	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      	files)
      		grep -q "name:jumps_made value:$nr$" $trace;;
      	reftable)
      		grep -q "name:reseeks_made value:$nr$" $trace;;
      	*)
     -		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    -+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
    ++		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
      	esac
      }
      
    @@ t/t1419-exclude-refs.sh: test_expect_success 'adjacent, non-overlapping excluded
      
      	test_cmp expect actual &&
     -	case "$GIT_DEFAULT_REF_FORMAT" in
    -+	case "$GIT_DEFAULT_REF_STORAGE" in
    ++	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      	files)
      		assert_jumps 1 perf;;
      	reftable)
      		assert_jumps 2 perf;;
      	*)
     -		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    -+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
    ++		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
      	esac
      '
      
    @@ t/t1419-exclude-refs.sh: test_expect_success 'several overlapping excluded regio
      
      	test_cmp expect actual &&
     -	case "$GIT_DEFAULT_REF_FORMAT" in
    -+	case "$GIT_DEFAULT_REF_STORAGE" in
    ++	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      	files)
      		assert_jumps 1 perf;;
      	reftable)
      		assert_jumps 3 perf;;
      	*)
     -		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    -+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
    ++		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
      	esac
      '
      
    @@ t/t1419-exclude-refs.sh: test_expect_success 'unordered excludes' '
      
      	test_cmp expect actual &&
     -	case "$GIT_DEFAULT_REF_FORMAT" in
    -+	case "$GIT_DEFAULT_REF_STORAGE" in
    ++	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      	files)
      		assert_jumps 1 perf;;
      	reftable)
      		assert_jumps 2 perf;;
      	*)
     -		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    -+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
    ++		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
      	esac
      '
      
    @@ t/t1423-ref-backend.sh: test_description='Test reference backend URIs'
      #   <cmd> is the git subcommand to be run in the repository.
      #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
     -#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
    -+#         if 'env', set the backend via the 'GIT_REF_STORAGE' env.
    ++#         if 'env', set the backend via the 'GIT_REF_STORAGE_FORMAT' env.
      run_with_uri () {
      	repo=$1 &&
      	backend=$2 &&
    @@ t/t1423-ref-backend.sh: run_with_uri () {
      	if test "$via" = "env"
      	then
     -		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
    -+		test_env GIT_REF_STORAGE="$uri" git -C "$repo" $cmd
    ++		test_env GIT_REF_STORAGE_FORMAT="$uri" git -C "$repo" $cmd
      	elif test "$via" = "config"
      	then
      		git -C "$repo" config set extensions.refStorage "$uri" &&
    @@ t/t1423-ref-backend.sh: run_with_uri () {
      #   <uri> is the new URI to be set for the ref storage.
      #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
     -#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
    -+#         if 'env', set the backend via the 'GIT_REF_STORAGE' env.
    ++#         if 'env', set the backend via the 'GIT_REF_STORAGE_FORMAT' env.
      #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
      test_refs_backend () {
      	repo=$1 &&
    @@ t/t1423-ref-backend.sh: test_refs_backend () {
      		if test "$via" = "env"
      		then
     -			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
    -+			test_env GIT_REF_STORAGE="$uri" test_must_fail git -C "$repo" refs list 2>err
    ++			test_env GIT_REF_STORAGE_FORMAT="$uri" test_must_fail git -C "$repo" refs list 2>err
      		elif test "$via" = "config"
      		then
      			git -C "$repo" config set extensions.refStorage "$uri" &&
    @@ t/t1423-ref-backend.sh: verify_files_exist () {
      
      	# verify that backend specific files exist.
     -	case "$GIT_DEFAULT_REF_FORMAT" in
    -+	case "$GIT_DEFAULT_REF_STORAGE" in
    ++	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      	files)
      		test_path_is_dir $refdir/refs/heads &&
      		test_path_is_file $refdir/HEAD;;
    @@ t/t1423-ref-backend.sh: verify_files_exist () {
      		test_path_is_file $refdir/reftable/tables.list;;
      	*)
     -		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    -+		BUG "unhandled ref format $GIT_DEFAULT_REF_STORAGE";;
    ++		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
      	esac
      }
      
    @@ t/t1423-ref-backend.sh: do
      		test_when_finished "rm -rf repo refdir" &&
      		mkdir refdir &&
     -		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
    -+		GIT_REF_STORAGE="${from_format}://$(pwd)/refdir" git init repo &&
    ++		GIT_REF_STORAGE_FORMAT="${from_format}://$(pwd)/refdir" git init repo &&
      		(
      			cd repo &&
      
    @@ t/t1423-ref-backend.sh: test_expect_success 'initializing repository with alt re
      	mkdir refdir &&
      	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
     -	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
    -+	GIT_REF_STORAGE=$BACKEND git init repo &&
    ++	GIT_REF_STORAGE_FORMAT=$BACKEND git init repo &&
      	verify_files_exist repo/.git refdir &&
      	(
      		cd repo &&
    @@ t/t1423-ref-backend.sh: test_expect_success 'cloning repository with alt ref dir
      
      	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
     -	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
    -+	GIT_REF_STORAGE=$BACKEND git clone source repo &&
    ++	GIT_REF_STORAGE_FORMAT=$BACKEND git clone source repo &&
      
      	git -C repo config get extensions.refstorage >actual &&
      	echo $BACKEND >expect &&
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_ref_format () {
      for OTHER_FORMAT in files reftable
      do
     -	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_FORMAT"
    -+	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_STORAGE"
    ++	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_STORAGE_FORMAT"
      	then
      		continue
      	fi
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'add submodules with
      	test_commit -C submodule submodule-initial &&
      	git init upstream &&
     -	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
    -+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE" &&
    - 	git -C upstream submodule add --ref-storage="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
    ++	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
    + 	git -C upstream submodule add --ref-storage-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
      	test_ref_format upstream/submodule "$OTHER_FORMAT"
      '
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone propagates ref storage format' '
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone pro
      	# ref format.
     -	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
     -	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
    -+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE" &&
    -+	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_STORAGE" &&
    ++	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
    ++	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
      
      	# The cloned repositories should use the other ref format that we have
    - 	# specified via `--ref-storage`. The option should propagate to cloned
    + 	# specified via `--ref-storage-format`. The option should propagate to cloned
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'clone submodules with different ref storage format' '
      	git -C upstream commit -m "upstream submodule" &&
      
      	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
     -	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
    -+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE" &&
    - 	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
    ++	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
    + 	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
      	test_ref_format downstream/submodule "$OTHER_FORMAT"
      '
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'status with mixed submodule ref storages' '
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'status with mixed s
      	# The main repository should use the default ref format now, whereas
      	# the submodule should use the other format.
     -	test_ref_format main "$GIT_DEFAULT_REF_FORMAT" &&
    -+	test_ref_format main "$GIT_DEFAULT_REF_STORAGE" &&
    ++	test_ref_format main "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
      	test_ref_format main/submodule "$OTHER_FORMAT" &&
      
      	cat >expect <<-EOF &&
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive pull with mixed formats' '
      	# submodules have different formats.
      	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
    - 	git -C downstream submodule update --init --ref-storage=$OTHER_FORMAT &&
    + 	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
     -	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
    -+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE" &&
    ++	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
      	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
      
      	# Update the upstream submodule as well as the owning repository such
    @@ t/test-lib.sh: export EDITOR
      export GIT_DEFAULT_HASH
     -GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
     -export GIT_DEFAULT_REF_FORMAT
    -+GIT_DEFAULT_REF_STORAGE="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
    -+export GIT_DEFAULT_REF_STORAGE
    ++GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
    ++export GIT_DEFAULT_REF_STORAGE_FORMAT
      
      # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
      GIT_TRACE_BARE=1
    @@ t/test-lib.sh: parisc* | hppa*)
      esac
      
     -case "$GIT_DEFAULT_REF_FORMAT" in
    -+case "$GIT_DEFAULT_REF_STORAGE" in
    ++case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
      files)
      	test_set_prereq REFFILES;;
      reftable)
      	test_set_prereq REFTABLE;;
      *)
     -	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
    -+	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_STORAGE"
    ++	echo 2>&1 "error: unknown ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT"
      	exit 1
      	;;
      esac
10:  01ba1710d3 ! 10:  e53d951d57 setup: rename "init.defaultRefFormat" to "init.defaultRefStorage"
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    setup: rename "init.defaultRefFormat" to "init.defaultRefStorage"
    +    setup: rename "init.defaultRefFormat" to "init.defaultRefStorageFormat"
     
         With the same reasoning as for git-init(1), rename the
    -    "init.defaultRefFormat" config option to "init.defaultRefStorage" and
    -    keep the old name as an alias.
    +    "init.defaultRefFormat" config option to "init.defaultRefStorageFormat"
    +    and keep the old name as an alias.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
      +
      Users that get immediate benefit from the "reftable" backend could continue to
     -opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
    -+opt-in to the "reftable" format manually by setting the "init.defaultRefStorage"
    ++opt-in to the "reftable" format manually by setting the "init.defaultRefStorageFormat"
      config. But defaults matter, and we think that overall users will have a better
      experience with less platform-specific quirks when they use the new backend by
      default.
    @@ Documentation/config/feature.adoc: reusing objects from multiple packs instead o
      default name-hash.
      +
     -* `init.defaultRefFormat=reftable` causes newly initialized repositories to use
    -+* `init.defaultRefStorage=reftable` causes newly initialized repositories to use
    ++* `init.defaultRefStorageFormat=reftable` causes newly initialized repositories to use
      the reftable format for storing references. This new format solves issues with
      case-insensitive filesystems, compresses better and performs significantly
      better with many use cases. Refer to Documentation/technical/reftable.adoc for
    @@ Documentation/config/init.adoc: endif::[]
      	and the `GIT_DEFAULT_HASH` environment variable take precedence over
      	this config.
     -`init.defaultRefFormat`::
    -+`init.defaultRefStorage`::
    ++`init.defaultRefStorageFormat`::
      	Allows overriding the default ref storage format for new repositories.
    - 	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
    - 	option and the `GIT_DEFAULT_REF_STORAGE` environment variable take
    + 	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
    + 	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
     
      ## setup.c ##
     @@ setup.c: static int read_default_format_config(const char *key, const char *value,
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
      	}
      
     -	if (!strcmp(key, "init.defaultrefformat")) {
    -+	if (!strcmp(key, "init.defaultrefstorage") ||
    ++	if (!strcmp(key, "init.defaultrefstorageformat") ||
     +	    !strcmp(key, "init.defaultrefformat")) {
      		ret = git_config_string(&str, key, value);
      		if (ret)
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
      	/*
      	 * Enable the reftable format when "features.experimental" is enabled.
     -	 * "init.defaultRefFormat" takes precedence over this setting.
    -+	 * "init.defaultRefStorage" takes precedence over this setting.
    ++	 * "init.defaultRefStorageFormat" takes precedence over this setting.
      	 */
      	if (!strcmp(key, "feature.experimental") &&
      	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    - 	 *      equivalent "GIT_DEFAULT_REF_FORMAT".
    + 	 *      deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
      	 *
      	 *   5. The default ref storage format for new repositories as
     -	 *      configured via "init.defaultRefFormat"
    -+	 *      configured via "init.defaultRefStorage" or its deprecated
    ++	 *      configured via "init.defaultRefStorageFormat" or its deprecated
     +	 *      equivalent "init.defaultRefFormat".
      	 *
      	 *   6. Otherwise, we fall back to the default ref storage format
      	 *      compiled into Git.
     
      ## t/t0001-init.sh ##
    -@@ t/t0001-init.sh: test_expect_success 'GIT_REF_STORAGE refuses to reinitialize with different stor
    +@@ t/t0001-init.sh: test_expect_success 'GIT_REF_STORAGE_FORMAT refuses to reinitialize with differe
      	test_cmp expect err
      '
      
     -test_expect_success 'init warns about invalid init.defaultRefFormat' '
    -+test_expect_success 'init warns about invalid init.defaultRefStorage' '
    ++test_expect_success 'init warns about invalid init.defaultRefStorageFormat' '
      	test_when_finished "rm -rf repo" &&
     -	test_config_global init.defaultRefFormat garbage &&
    -+	test_config_global init.defaultRefStorage garbage &&
    ++	test_config_global init.defaultRefStorageFormat garbage &&
      
      	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
      	git init repo 2>err &&
    @@ t/t0001-init.sh: do
      	'
      
     -	test_expect_success "init with init.defaultRefFormat=$format" '
    -+	test_expect_success "init with init.defaultRefStorage=$format" '
    ++	test_expect_success "init with init.defaultRefStorageFormat=$format" '
      		test_when_finished "rm -rf refformat" &&
     -		test_config_global init.defaultRefFormat $format &&
    -+		test_config_global init.defaultRefStorage $format &&
    ++		test_config_global init.defaultRefStorageFormat $format &&
      		(
    - 			sane_unset GIT_DEFAULT_REF_STORAGE &&
    + 			sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      			git init refformat
    -@@ t/t0001-init.sh: test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_STORAGE" '
    +@@ t/t0001-init.sh: test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOM
      	test_cmp expect actual
      '
      
    --test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefFormat" '
    -+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefStorage" '
    +-test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefFormat" '
    ++test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefStorageFormat" '
      	test_when_finished "rm -rf refformat" &&
     -	test_config_global init.defaultRefFormat files &&
    -+	test_config_global init.defaultRefStorage files &&
    ++	test_config_global init.defaultRefStorageFormat files &&
      
    - 	GIT_DEFAULT_REF_STORAGE=reftable git init refformat &&
    + 	GIT_DEFAULT_REF_STORAGE_FORMAT=reftable git init refformat &&
      	echo reftable >expect &&
     @@ t/t0001-init.sh: test_expect_success "init with feature.experimental=true" '
      	test_cmp expect actual
      '
      
     -test_expect_success "init.defaultRefFormat overrides feature.experimental=true" '
    -+test_expect_success "init.defaultRefStorage overrides feature.experimental=true" '
    ++test_expect_success "init.defaultRefStorageFormat overrides feature.experimental=true" '
      	test_when_finished "rm -rf refformat" &&
      	test_config_global feature.experimental true &&
     -	test_config_global init.defaultRefFormat files &&
    -+	test_config_global init.defaultRefStorage files &&
    ++	test_config_global init.defaultRefStorageFormat files &&
      	(
    - 		sane_unset GIT_DEFAULT_REF_STORAGE &&
    + 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
      		git init refformat
11:  a7911f38dc ! 11:  e9c61c7d06 setup: allow "git init --ref-storage=" to specify a payload
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    setup: allow "git init --ref-storage=" to specify a payload
    +    setup: allow "git init --ref-storage-format=" to specify a payload
     
         Reference storage backends can be configured with a payload via the
    -    "extensions.refStorage" config key and the "GIT_REF_STORAGE" environment
    -    variable, both of which accept a URI in the format
    +    "extensions.refStorage" config key and the "GIT_REF_STORAGE_FORMAT"
    +    environment variable, both of which accept a URI in the format
         "<format>://<payload>". The payload may contain backend-specific
         information, for example an alternate refs directory or which database
         references should be stored in.
     
    -    The `--ref-storage=` option of git-init(1) and git-clone(1) does not
    -    know about payloads though: its value is parsed as a plain format name,
    -    so backends that require a payload cannot be conveniently set up at
    -    initialization time via the command line.
    +    The `--ref-storage-format=` option of git-init(1) and git-clone(1) does
    +    not know about payloads though: its value is parsed as a plain format
    +    name, so backends that require a payload cannot be conveniently set up
    +    at initialization time via the command line.
     
         Teach the option to accept the same URI syntax. Also, document the
         optional payloads for both the "files" and "reftable" backends.
    @@ Documentation/git-init.adoc
     @@ Documentation/git-init.adoc: values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
      include::object-format-disclaimer.adoc[]
      
    - `--ref-storage=<format>`::
    + `--ref-storage-format=<format>`::
     -Specify the given ref storage _<format>_ for the repository. The valid values are:
     +Specify the given ref storage _<format>_ for the repository. Backends that
     +require additional configuration accept a payload in the form
    @@ Documentation/ref-storage-format.adoc
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: int cmd_clone(int argc,
    + 	char *option_origin = NULL;
    + 	struct string_list option_not = STRING_LIST_INIT_NODUP;
    + 	const char *real_git_dir = NULL;
    +-	const char *ref_storage_format_str = NULL;
    ++	const char *ref_storage_format_uri = NULL;
    + 	const char *option_upload_pack = "git-upload-pack";
    + 	int option_progress = -1;
    + 	int option_sparse_checkout = 0;
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 			 N_("any cloned submodules will be shallow")),
    + 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
    + 			   N_("separate git dir from working tree")),
    +-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
    + 			   N_("specify the reference storage format to use")),
    +-		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    ++		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
    + 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    + 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
    + 				N_("set config inside the new repository")),
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 	if (option_single_branch == -1)
      		option_single_branch = deepen ? 1 : 0;
      
    - 	if (ref_storage) {
    --		ref_storage_format = ref_storage_format_by_name(ref_storage);
    -+		ref_storage_format = ref_storage_format_by_uri(ref_storage, NULL);
    +-	if (ref_storage_format_str) {
    +-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
    ++	if (ref_storage_format_uri) {
    ++		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri, NULL);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    - 			die(_("unknown ref storage format '%s'"), ref_storage);
    +-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
    ++			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
      	}
    + 
    + 	if (option_mirror) {
     @@ builtin/clone.c: int cmd_clone(int argc,
      	 * their on-disk data structures.
      	 */
      	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
     -		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
    -+		GIT_HASH_UNKNOWN, ref_storage, NULL,
    ++		GIT_HASH_UNKNOWN, ref_storage_format_uri, NULL,
      		do_not_override_repo_unix_permissions,
      		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
      
     
      ## builtin/init-db.c ##
     @@ builtin/init-db.c: int cmd_init_db(int argc,
    - 	const char *ref_storage = NULL;
    + 	unsigned int flags = 0;
    + 	int bare = startup_info->force_bare_repository ? 1 : -1;
    + 	const char *object_format = NULL;
    +-	const char *ref_storage_format_str = NULL;
    ++	const char *ref_storage_format_uri = NULL;
      	const char *initial_branch = NULL;
      	int hash_algo = GIT_HASH_UNKNOWN;
     -	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
      	int init_shared_repository = -1;
      	const struct option init_db_options[] = {
      		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
    +@@ builtin/init-db.c: int cmd_init_db(int argc,
    + 			   N_("override the name of the initial branch")),
    + 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
    + 			   N_("specify the hash algorithm to use")),
    +-		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
    ++		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
    + 			   N_("specify the reference storage format to use")),
    +-		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    ++		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
    + 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    + 		OPT_END()
    + 	};
     @@ builtin/init-db.c: int cmd_init_db(int argc,
      			die(_("unknown hash algorithm '%s'"), object_format);
      	}
      
    --	if (ref_storage) {
    --		ref_storage_format = ref_storage_format_by_name(ref_storage);
    +-	if (ref_storage_format_str) {
    +-		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
     -		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    --			die(_("unknown ref storage format '%s'"), ref_storage);
    +-			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
     -	}
     -
      	if (init_shared_repository != -1)
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      	flags |= INIT_DB_EXIST_OK;
      	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
     -		      template_dir, hash_algo, ref_storage_format, initial_branch,
    -+		      template_dir, hash_algo, ref_storage, initial_branch,
    - 		      init_shared_repository, flags);
    +-		      init_shared_repository, flags);
    ++		      template_dir, hash_algo, ref_storage_format_uri,
    ++		      initial_branch, init_shared_repository, flags);
      
      	free(template_dir_to_free);
    + 	free(real_git_dir_to_free);
     
      ## setup.c ##
     @@ setup.c: static int read_default_format_config(const char *key, const char *value,
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
      
      static void repository_format_configure(struct repository_format *repo_fmt,
     -					int hash, enum ref_storage_format ref_storage_format)
    -+					int hash, const char *ref_storage_uri)
    ++					int hash,
    ++					const char *ref_storage_format_uri)
      {
      	struct default_format_config cfg = {
      		.hash = GIT_HASH_UNKNOWN,
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
      	 */
     -	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
     -		/* nothing to do */
    -+	if (ref_storage_uri) {
    -+		ref_storage_format = ref_storage_format_by_uri(ref_storage_uri, &ref_storage_payload);
    ++	if (ref_storage_format_uri) {
    ++		ref_storage_format = ref_storage_format_by_uri(ref_storage_format_uri,
    ++							       &ref_storage_payload);
     +		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    -+			die(_("unknown reference storage format specified via command line: '%s'"),
    -+			    ref_storage_uri);
    - 	} else if (((env = getenv(GIT_REF_STORAGE_ENVIRONMENT)) ||
    ++			die(_("unknown ref storage format specified via command line: '%s'"),
    ++			    ref_storage_format_uri);
    + 	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
      		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
      		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
     @@ setup.c: int init_db(struct repository *repo,
    @@ setup.c: int init_db(struct repository *repo,
      	    const char *worktree,
      	    const char *template_dir, int hash,
     -	    enum ref_storage_format ref_storage_format,
    -+	    const char *ref_storage_uri,
    ++	    const char *ref_storage_format_uri,
      	    const char *initial_branch,
      	    int init_shared_repository, unsigned int flags)
      {
    @@ setup.c: int init_db(struct repository *repo,
      	 */
      	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
     -	repository_format_configure(&repo_fmt, hash, ref_storage_format);
    -+	repository_format_configure(&repo_fmt, hash, ref_storage_uri);
    ++	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
      	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
      		die("%s", err.buf);
      
    @@ setup.h: int init_db(struct repository *repo,
      	    const char *worktree,
      	    const char *template_dir, int hash_algo,
     -	    enum ref_storage_format ref_storage_format,
    -+	    const char *ref_storage_uri,
    ++	    const char *ref_storage_format_uri,
      	    const char *initial_branch, int init_shared_repository,
      	    unsigned int flags);
      void initialize_repository_version(struct repository *repo,
     
      ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: done
    - test_expect_success 'init with --ref-storage=garbage' '
    + test_expect_success 'init with --ref-storage-format=garbage' '
      	test_when_finished "rm -rf refformat" &&
      	cat >expect <<-EOF &&
     -	fatal: unknown ref storage format ${SQ}garbage${SQ}
    -+	fatal: unknown reference storage format specified via command line: ${SQ}garbage${SQ}
    ++	fatal: unknown ref storage format specified via command line: ${SQ}garbage${SQ}
      	EOF
    - 	test_must_fail git init --ref-storage=garbage refformat 2>err &&
    + 	test_must_fail git init --ref-storage-format=garbage refformat 2>err &&
      	test_cmp expect err
     
      ## t/t1423-ref-backend.sh ##
    @@ t/t1423-ref-backend.sh: test_expect_success 'initializing repository with alt re
      	)
      '
      
    -+test_expect_success 'initializing repository with --ref-storage and payload' '
    ++test_expect_success 'initializing repository with --ref-storage-format and payload' '
     +	test_when_finished "rm -rf repo refdir" &&
     +	mkdir refdir &&
     +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
    -+	git init --ref-storage="$BACKEND" repo &&
    ++	git init --ref-storage-format="$BACKEND" repo &&
     +	verify_files_exist repo/.git refdir &&
     +
     +	git -C repo config get extensions.refstorage >actual &&
    @@ t/t1423-ref-backend.sh: test_expect_success 'initializing repository with alt re
     +	# Reinitializing the repository is fine when not specifying any format.
     +	git -C repo init &&
     +	# Reinitializing with the same backend is fine, too.
    -+	git -C repo init --ref-storage="$BACKEND" &&
    ++	git -C repo init --ref-storage-format="$BACKEND" &&
     +	# Reinitializing without a payload should fail.
    -+	test_must_fail git -C repo init --ref-storage="$(test_detect_ref_format)" 2>err &&
    ++	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)" 2>err &&
     +	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
     +	# Reinitializing with a different payload should fail, too.
    -+	test_must_fail git -C repo init --ref-storage="$(test_detect_ref_format)://$(pwd)/other" 2>err &&
    ++	test_must_fail git -C repo init --ref-storage-format="$(test_detect_ref_format)://$(pwd)/other" 2>err &&
     +	test_grep "attempt to reinitialize repository with different reference storage payload" err &&
     +
     +	git -C repo config get extensions.refstorage >actual &&

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671

