Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A153D0C5
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952386; cv=none; b=Fd/QKHf6ki8oRlgVjmgXYslmdx75clR0HkCgU13+NjefmEofCwapfP58gOZQGhQ37jxk1B4IMRKF160IqVPusYCsBRhaAhnroBKgpTGr6/yLu3HYiyFtInww8iAHm9pjyCdK1xdB5gYSRoJlXpWdWdqydZfXltKvwKBqImEgcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952386; c=relaxed/simple;
	bh=6QcgyH2AYQZRPwRuYE+4b+wfJGshr22UxQHsg96UdKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DFAkl5+3x7zABJKbTLH66cBm3gfq8q/G2SWdDsIFRHngCbWx2kJsLKmTRElcMmt6cKr7/I7vwh+MdsxR4yH26gCsXzYyA+6bzCs7AetB2dlBhPW1gQLLqm65QgQ0NM2rlWpv2vQqrAeYhCwKTz8HlVVnAs7rqGarvYDy//e1l78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SZTkR21e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o6q86Jc1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SZTkR21e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6q86Jc1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030D31400085;
	Wed,  9 Sep 2026 07:12:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 07:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952377;
	 x=1789038777; bh=XrmKDQc9oOKu80r2uMPDMno7rKjb7zATEz9aZI8AAuU=; b=
	SZTkR21eng7uR+2HnSib3cRp+4hRuCFDvp3Fq7nfHzClOe1FHjC3XG0Jo1FmnBoN
	I4luWM+lm7Nv5WvX+SqIKbb8wdnGkw91vx24DsTsbn9fpEx/PNKUCfy8MsELl5UX
	r08mDSKde3pyDIbWuHgmNxb8TdXscKALk6dYzRmNwftRJqQ2hlWLnov18XW4MF4Y
	HJLkaflDK0BQBwq5fOWKG357UzDBugpZ7NXd9eZDTvx/Db5QMltD2oIxAxy+WtU4
	SI0JcEsrO7YHEWUkfVl1Tu1rSXayj/GiJjw8EPfVuUHO1UNmSqf73s3/a5aD0kJn
	ovAOmwtWDRTaoJ85QqRYzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952377; x=
	1789038777; bh=XrmKDQc9oOKu80r2uMPDMno7rKjb7zATEz9aZI8AAuU=; b=o
	6q86Jc17sj46S3B5XwXxOdndp0kTVn98HaS5N+i4IzVYzLx0T8V1MH/MfWEcRoVW
	mKFSVzhdLDBYKyD6Mub0eWANNCBzd0JWY6hyAgJL0n/kipitUPqS9jLSYxEM/COD
	TKAgIhLKvVBp5gG49iY9nZe4Z2rcroRCA3USqFBK7hHU//nezEijKuVBYh+9cnLm
	scbtYMJtF3kQONu+rUsl0L2jt5iOu6aDzaPyw/wZHigsLl8L2bxF/cQsrTLtS+Tc
	GEEowuKgPfIWytYahoS8s2+AjU0nzcwRoV0pouV6UW2j5QOxy7q+UQ/vk1ZCcWY2
	5fJPJTN4zkrKhHZgSs+SQ==
X-ME-Sender: <xms:OT-haooqKmUHoA3FdwSlfrlnR2sljTqLuBGpmrvjiLEli6KoROnlFQ>
    <xme:OT-halrZkjsKg3bZMn2fDD-ddbdyYX2xjNZGq9rYljq9oR18kkJRrwTLey14wiqwm
    c6Du8FiDwb33yvMVnQX-9c1YZneZEzJlQYWspYkkSxdbVKb3lrVuTW3>
X-ME-Received: <xmr:OT-haiN1ryWp9IbcBTjADlnexFcniZxpSbJuo7f6Rdos-YSptuiM7e6fhfWmFWFPndEV9Q>
X-ME-Proxy-Cause: dmFkZTE31BQRuDLGKwoat+CuUvQutuLwqaZ9c+lKuHLZOOYOjlEjSahW26TnHtlPeD+y6L
    a6h8cT525AM2Yw2XPDjUVuz4BIhLDcjZ9JOJrmn+cYAY+mYoN7baTfdlgNaCiGrdO+y8L/
    Fsw0Yx/38tAPPAWaYGPaX53MrxRYdrtu21aftptwCIBGFecyUqx7vfuO8lLA9PeAFf7eZS
    SzYdxtGE3TOFeAqdDANmebiFfZYGbRqPrD4etitCRS6b0VgVyHeO+W3VwBtQVqZ9/0DgNt
    L+laMajeIMFF2n26xJ+77UWH2WZs5HEUlELStNTNj/sKgDx8EvMabUi1LSbOc21cIsb4cT
    b7NIRQP6pD6lWUyHA0jSO1zwbg2DLE01XkUK2Fl6Ptlc/eKStATb2xSq0gUZS9A25Cr8pE
    +kdEs9ZpRHeec4vF98Lj3Kzfz5SRLZnDHKMIwMcfl1LwfO9ZVhfCyz79D/fmISABCGMHgH
    eNkh+Eubs6xQEZddzEvv9WGBmpgZQpPIB7xDdxgZKCK332w+WiaxmUhW/Wg/dWE7PL/ZOQ
    41r7koaEzCftYPYV/6oiem8oMvm1oYurjks5yAlozhon6qEtc5LBQc9jSepNcGZUIwj7zo
    XXSOD9pkw9jTmnEOBLLxRx9oCjB1YrSWC547Bi27vWQ2GgfCoIemJStUwsFg
X-ME-Proxy: <xmx:OT-hauxfVt402r0C4mnNeE_4T86_wqwgQ2iFeo7bi2z4rwcqVshDFQ>
    <xmx:OT-hajsVxgdLoLrR4hx0JNzJt4NxKMah5M5GsU6-9M4pAf1oXbk2Ng>
    <xmx:OT-hav5ZZFEtnRDpxg-dhc9nWUcJUugmtqAlbfnZxA6m7XY5zwNYIA>
    <xmx:OT-haqSYp5KXYTyJ9MmMrEsuzcPmY221bmR59w1oofH_PCKoIIv9nQ>
    <xmx:OT-hahtFSJnmQuiXY8INWaDzu1GfvleJfMpE4UoKtnLCgpX1culCScG2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:12:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49a6e003 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:12:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/13] Fix inconsistent ref storage format terminology
Date: Wed, 09 Sep 2026 13:12:46 +0200
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw7CIBQFf6Vh7TUXSl+u/A/jAhAsGtsGWmLT9
 N+Fmhh3ujzJZOYsxGtntSeHbCFOB+tt38WR7zKiWtFdNdhL3IQhK7FBDpLDcPcwddbM4LQBP/Z
 ORM707iFGQFVTIzGvy4qSaBkiY59b4XR+bz/Jm1Zj0iaitUkxbxcCTdz/tUABAWvKuS4QuTHHi
 O/tg6RUYN+y6reMRVlZ5blqUIlC4ke2rusLQkMpJioBAAA=
X-Change-ID: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
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

Changes in v3:
  - Add breadcrumbs for the old names to our documentation.
  - Use `OPT_ALIAS()` instead of manually aliasing the options.
  - Fix a comment in one of our tests that still referred to the v1
    "--ref-storage=" option.
  - Print the correct environment variables in error messages.
  - Also rename GIT_TEST_DEFAULT_REF_FORMAT.
  - Don't adapt "ref-storage-format.adoc", as that documentation is also
    shared with commands that don't support URIs yet.
  - Link to v2: https://patch.msgid.link/20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im

Changes in v2:
  - Based on Junio's feedback I've renamed all of this to instead be
    called "ref storage format".
  - Link to v1: https://patch.msgid.link/20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (13):
      parse-options: allow for hidden aliases
      builtin/init: rename "--ref-format=" to "--ref-storage-format="
      builtin/clone: rename "--ref-format=" to "--ref-storage-format="
      builtin/refs: rename "--ref-format=" to "--ref-storage-format="
      builtin/submodule: rename "--ref-format=" to "--ref-storage-format="
      builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage-format"
      help: rename "default-ref-format" to "default-ref-storage-format"
      refs: expose function to parse reference URIs
      setup: refactor how we configure the ref storage format
      setup: rename ref storage format environment variables
      t: rename GIT_TEST_DEFAULT_REF_FORMAT
      setup: rename "init.defaultRefFormat" to "init.defaultRefStorageFormat"
      setup: allow "--ref-storage-format=" to specify a payload

 Documentation/BreakingChanges.adoc     |   2 +-
 Documentation/config/feature.adoc      |   2 +-
 Documentation/config/init.adoc         |   8 +-
 Documentation/git-clone.adoc           |  10 +-
 Documentation/git-init.adoc            |  12 ++-
 Documentation/git-refs.adoc            |   9 +-
 Documentation/git-rev-parse.adoc       |   5 +-
 Documentation/git-submodule.adoc       |  14 +--
 Documentation/git.adoc                 |  18 ++--
 builtin/clone.c                        |  17 ++--
 builtin/fetch.c                        |   2 +-
 builtin/init-db.c                      |  20 ++--
 builtin/refs.c                         |   9 +-
 builtin/rev-parse.c                    |   2 +-
 builtin/submodule--helper.c            |  21 ++--
 ci/run-build-and-tests.sh              |   2 +-
 contrib/completion/git-prompt.sh       |   2 +-
 environment.h                          |   1 +
 git-submodule.sh                       |  20 ++--
 help.c                                 |   2 +-
 parse-options.c                        |   4 +-
 parse-options.h                        |   5 +-
 refs.c                                 |  23 +++++
 refs.h                                 |   4 +
 setup.c                                | 175 +++++++++++++++++++--------------
 setup.h                                |   2 +-
 t/README                               |   4 +-
 t/perf/p1401-ref-store-tombstones.sh   |   4 +-
 t/perf/perf-lib.sh                     |   4 +-
 t/t0001-init.sh                        | 126 +++++++++++++-----------
 t/t0600-reffiles-backend.sh            |   4 +-
 t/t0601-reffiles-pack-refs.sh          |   4 +-
 t/t0602-reffiles-fsck.sh               |   4 +-
 t/t0610-reftable-basics.sh             |  38 +++----
 t/t0611-reftable-httpd.sh              |   2 +-
 t/t0612-reftable-jgit-compatibility.sh |   4 +-
 t/t0613-reftable-write-options.sh      |   4 +-
 t/t0614-reftable-fsck.sh               |   4 +-
 t/t1400-update-ref.sh                  |   2 +-
 t/t1419-exclude-refs.sh                |  16 +--
 t/t1423-ref-backend.sh                 |  62 +++++++++---
 t/t1460-refs-migrate.sh                |  54 +++++-----
 t/t1463-refs-optimize.sh               |   4 +-
 t/t1500-rev-parse.sh                   |   8 +-
 t/t1900-repo-info.sh                   |   6 +-
 t/t5510-fetch.sh                       |  14 +--
 t/t5601-clone.sh                       |   6 +-
 t/t7424-submodule-mixed-ref-formats.sh |  30 +++---
 t/test-lib-functions.sh                |   2 +-
 t/test-lib.sh                          |   8 +-
 50 files changed, 465 insertions(+), 340 deletions(-)

Range-diff versus v2:

 -:  ---------- >  1:  0f7f8494b2 parse-options: allow for hidden aliases
 1:  0cebb933a4 !  2:  f837dbb9f2 builtin/init: rename "--ref-format=" to "--ref-storage-format="
    @@ Documentation/git-init.adoc: values are `sha1` and (if enabled) `sha256`.  `sha1
      Specify the given ref storage _<format>_ for the repository. The valid values are:
      +
      include::ref-storage-format.adoc[]
    + 
    ++`--ref-format=<format>`::
    ++Deprecated alias of `--ref-storage-format=<format>`.
    ++
    + `--template=<template-directory>`::
    + Specify the directory from which templates will be used.  (See the "TEMPLATE
    + DIRECTORY" section below.)
     
      ## Documentation/git.adoc ##
     @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., the value
    @@ builtin/init-db.c: int cmd_init_db(int argc,
     -			   N_("specify the reference format to use")),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    -+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_END()
      	};
      	int ret;
 2:  c170c3f889 !  3:  693dcc7a24 builtin/clone: rename "--ref-format=" to "--ref-storage-format="
    @@ Documentation/git-clone.adoc: or `--mirror` is given)
      
      Specify the given ref storage format for the repository. The valid values are:
      +
    + include::ref-storage-format.adoc[]
    + 
    ++`--ref-format=<format>`::
    ++Deprecated alias of `--ref-storage-format=<format>`.
    ++
    + `-j<n>`::
    + `--jobs=<n>`::
    + 	The number of submodules fetched at the same time.
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: int cmd_clone(int argc,
    @@ builtin/clone.c: int cmd_clone(int argc,
     -			   N_("specify the reference format to use")),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    -+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
      				N_("set config inside the new repository")),
      		OPT_STRING_LIST(0, "server-option", &server_options,
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone pro
      
      	# The cloned repositories should use the other ref format that we have
     -	# specified via `--ref-format`. The option should propagate to cloned
    -+	# specified via `--ref-storage`. The option should propagate to cloned
    ++	# specified via `--ref-storage-format`. The option should propagate to cloned
      	# submodules.
     -	git clone --ref-format=$OTHER_FORMAT --recurse-submodules \
     +	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
 3:  ce71f5c6de !  4:  ac7745edc0 builtin/refs: rename "--ref-format=" to "--ref-storage-format="
    @@ Documentation/git-refs.adoc: OPTIONS
      +
      include::ref-storage-format.adoc[]
      
    ++`--ref-format=<format>`::
    ++Deprecated alias of `--ref-storage-format=<format>`.
    ++
    + `--dry-run`::
    + 	Perform the migration, but do not modify the repository. The migrated
    + 	refs will be written into a separate directory that can be inspected
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refname,
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
     +			N_("specify the reference storage format to convert to"),
      			PARSE_OPT_NONEG),
    -+		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
    -+			N_("specify the reference storage format to convert to"),
    -+			PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_BIT(0, "dry-run", &flags,
      			N_("perform a non-destructive dry-run"),
      			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
 4:  576ae81258 !  5:  2971bd413c builtin/submodule: rename "--ref-format=" to "--ref-storage-format="
    @@ Documentation/git-submodule.adoc: location, and only the superproject's URL need
      URL in `.gitmodules`.
      +
     -If `--ref-format <format>`  is specified, the ref storage format of newly
    -+If `--ref-storage-format <format>`  is specified, the ref storage format of newly
    - cloned submodules will be set accordingly.
    +-cloned submodules will be set accordingly.
    ++If `--ref-storage-format <format>` or its deprecated alias `--ref-format
    ++<format>` is specified, the ref storage format of the newly cloned submodules
    ++will be set accordingly.
      
      `status [--cached] [--recursive] [--] [<path>...]`::
    + 	Show the status of the submodules. This will print the SHA-1 of the
     @@ Documentation/git-submodule.adoc: If you really want to remove a submodule from the repository and commit
      that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
      options.
    @@ Documentation/git-submodule.adoc: submodule with the `--init` option.
      registered submodules, and update any nested submodules within.
      
     -If `--ref-format <format>`  is specified, the ref storage format of newly
    -+If `--ref-storage-format <format>`  is specified, the ref storage format of newly
    - cloned submodules will be set accordingly.
    +-cloned submodules will be set accordingly.
    ++If `--ref-storage-format <format>` or its deprecated alias `--ref-format
    ++<format>` is specified, the ref storage format of the newly cloned submodules
    ++will be set accordingly.
      
      If `--filter <filter-spec>` is specified, the given partial clone filter will be
    + applied to the submodule. See linkgit:git-rev-list[1] for details on filter
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: static int checkout(int submodule_progress,
    @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
     -			   N_("specify the reference format to use")),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
    -+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_BOOL(0, "dissociate", &dissociate,
      			   N_("use --reference only while cloning")),
      		OPT_INTEGER(0, "depth", &clone_data.depth,
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
     -			   N_("specify the reference format to use")),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
    -+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_BOOL(0, "dissociate", &opt.dissociate,
      			   N_("use --reference only while cloning")),
      		OPT_INTEGER(0, "depth", &opt.depth,
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
     -			   N_("specify the reference format to use")),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
     +			   N_("specify the reference storage format to use")),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format, N_("format"),
    -+			     N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    ++		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
      		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
      			   N_("sets the submodule's name to the given string "
    @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'add submodules with
      	test_ref_format upstream/submodule "$OTHER_FORMAT"
      '
      
    -@@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'recursive clone propagates ref storage format' '
    - 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
    - 
    - 	# The cloned repositories should use the other ref format that we have
    --	# specified via `--ref-storage`. The option should propagate to cloned
    -+	# specified via `--ref-storage-format`. The option should propagate to cloned
    - 	# submodules.
    - 	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
    - 		upstream downstream &&
     @@ t/t7424-submodule-mixed-ref-formats.sh: test_expect_success 'clone submodules with different ref storage format' '
      
      	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
 5:  7e052492a5 !  6:  df63f371f0 builtin/rev-parse: rename "--show-ref-format" to "--show-ref-storage-format"
    @@ Documentation/git-rev-parse.adoc: The following options are unaffected by `--pat
     +--show-ref-storage-format::
      	Show the reference storage format used for the repository.
      
    ++--show-ref-format::
    ++	Deprecated alias of `--show-ref-storage-format`.
    ++
      
    + Other Options
    + ~~~~~~~~~~~~~
     
      ## builtin/rev-parse.c ##
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
 6:  860a12c036 =  7:  230e87bc3f help: rename "default-ref-format" to "default-ref-storage-format"
 7:  b2f66d143e =  8:  4e6e92f936 refs: expose function to parse reference URIs
 8:  0573eb69f6 =  9:  80f5e37350 setup: refactor how we configure the ref storage format
 9:  32167facdd ! 10:  20d5f660f8 setup: rename ref storage format environment variables
    @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., th
      	repositories will be set to this value. The default is "files".
      	See `--ref-storage-format` in linkgit:git-init[1].
      
    --`GIT_REFERENCE_BACKEND`::
    --    Specify which reference backend to be used along with its URI.
    --    See `extensions.refStorage` option in linkgit:git-config[1] for more
    --    details. Overrides the config variable when used.
    ++`GIT_DEFAULT_REF_FORMAT`::
    ++	Deprecated alias of `GIT_DEFAULT_REF_STORAGE_FORMAT`.
    ++
     +`GIT_REF_STORAGE_FORMAT`::
     +	Specify which ref storage format to use along with its URI.
     +	See `extensions.refStorage` option in linkgit:git-config[1] for more
     +	details. Overrides the config variable when used.
    ++
    + `GIT_REFERENCE_BACKEND`::
    +-    Specify which reference backend to be used along with its URI.
    +-    See `extensions.refStorage` option in linkgit:git-config[1] for more
    +-    details. Overrides the config variable when used.
    ++	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
      
      Git Commits
      ~~~~~~~~~~~
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
      				FREE_AND_NULL(discovery.format.ref_storage_payload);
      				discovery.format.ref_storage_format =
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    - 	 *   1. Explicit override via the command line, like in `git init
      	 *      --ref-storage-format=`.
      	 *
    --	 *   2. Explicit override via the environment with
    + 	 *   2. Explicit override via the environment with
     -	 *      GIT_REFERENCE_BACKEND.
    -+	 *   2. Explicit override via the environment with "GIT_REF_STORAGE_FORMAT"
    -+	 *      or its deprecated equivalent "GIT_REFERENCE_BACKEND".
    ++	 *      "GIT_REF_STORAGE_FORMAT".
      	 *
    - 	 *   3. Existing repository format. All the subsequent sources only
    +-	 *   3. Existing repository format. All the subsequent sources only
    ++	 *   3. Its deprecated equivalent "GIT_REFERENCE_BACKEND".
    ++	 *
    ++	 *   4. Existing repository format. All the subsequent sources only
      	 *      kick in when there is no repository yet.
      	 *
      	 *   4. The default ref storage format for new repositories as
     -	 *      configured via "GIT_DEFAULT_REF_FORMAT".
    -+	 *      configured via "GIT_DEFAULT_REF_STORAGE_FORMAT" or its
    -+	 *      deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
    ++	 *      configured via "GIT_DEFAULT_REF_STORAGE_FORMAT".
    ++	 *
    ++	 *   5. Its deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
      	 *
    - 	 *   5. The default ref storage format for new repositories as
    +-	 *   5. The default ref storage format for new repositories as
    ++	 *   6. The default ref storage format for new repositories as
      	 *      configured via "init.defaultRefFormat"
    -@@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    + 	 *
    +-	 *   6. Otherwise, we fall back to the default ref storage format
    ++	 *   7. Otherwise, we fall back to the default ref storage format
    + 	 *      compiled into Git.
      	 */
      	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
      		/* nothing to do */
    --	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
    -+	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
    -+		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
    ++	} else if ((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT))) {
    ++		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
    ++		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown ref storage format specified via %s: '%s'"),
    ++			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);
    + 	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
      		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    - 			die(_("unknown ref storage format specified via %s: '%s'"),
    --			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
    -+			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);
    +@@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
      	} else if (repo_fmt->version >= 0) {
      		ref_storage_format = repo_fmt->ref_storage_format;
      		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
    --	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
    -+	} else if (((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT")) ||
    -+		    (env = getenv("GIT_DEFAULT_REF_FORMAT")))) {
    ++	} else if ((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT"))) {
    ++		ref_storage_format = ref_storage_format_by_name(env);
    ++		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown ref storage format specified via %s: '%s'"),
    ++			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);
    + 	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
      		ref_storage_format = ref_storage_format_by_name(env);
      		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    - 			die(_("unknown ref storage format specified via %s: '%s'"),
    --			    "GIT_DEFAULT_REF_FORMAT", env);
    -+			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);
    - 	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
    - 		ref_storage_format = cfg.ref_storage_format;
    - 	} else {
     
      ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 -:  ---------- > 11:  bf4e73796a t: rename GIT_TEST_DEFAULT_REF_FORMAT
10:  feb6ab56d6 ! 12:  75d21c088f setup: rename "init.defaultRefFormat" to "init.defaultRefStorageFormat"
    @@ Documentation/config/init.adoc: endif::[]
      	Allows overriding the default ref storage format for new repositories.
      	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
      	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
    + 	precedence over this config.
    ++`init.defaultRefFormat`::
    ++	Deprecated alias of `init.defaultRefStorageFormat`.
    + 
    + init.defaultSubmodulePathConfig::
    + 	A boolean that specifies if `git init` and `git clone` should
     
      ## setup.c ##
     @@ setup.c: static int read_default_format_config(const char *key, const char *value,
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
      	if (!strcmp(key, "feature.experimental") &&
      	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    - 	 *      deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
    + 	 *   5. Its deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
      	 *
    - 	 *   5. The default ref storage format for new repositories as
    + 	 *   6. The default ref storage format for new repositories as
     -	 *      configured via "init.defaultRefFormat"
     +	 *      configured via "init.defaultRefStorageFormat" or its deprecated
     +	 *      equivalent "init.defaultRefFormat".
      	 *
    - 	 *   6. Otherwise, we fall back to the default ref storage format
    + 	 *   7. Otherwise, we fall back to the default ref storage format
      	 *      compiled into Git.
     
      ## t/t0001-init.sh ##
11:  b0c5523790 ! 13:  894675e619 setup: allow "git init --ref-storage-format=" to specify a payload
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    setup: allow "git init --ref-storage-format=" to specify a payload
    +    setup: allow "--ref-storage-format=" to specify a payload
     
         Reference storage backends can be configured with a payload via the
         "extensions.refStorage" config key and the "GIT_REF_STORAGE_FORMAT"
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/git-clone.adoc ##
    +@@ Documentation/git-clone.adoc: or `--mirror` is given)
    + 
    + `--ref-storage-format=<format>`::
    + 
    +-Specify the given ref storage format for the repository. The valid values are:
    ++Specify the given ref storage _<format>_ for the repository. Backends that
    ++require additional configuration accept a payload in the form
    ++`<format>://<payload>`, for example a connection string identifying the
    ++database that shall store the references. The valid values are:
    + +
    + include::ref-storage-format.adoc[]
    + 
    +
      ## Documentation/git-init.adoc ##
     @@ Documentation/git-init.adoc: values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
      include::object-format-disclaimer.adoc[]
    @@ Documentation/git-init.adoc: values are `sha1` and (if enabled) `sha256`.  `sha1
      include::ref-storage-format.adoc[]
      
     
    - ## Documentation/ref-storage-format.adoc ##
    -@@
    --`files`;; for loose files with packed-refs.
    -+`files[://<path>]`;; for loose files with packed-refs. The optional payload can
    -+be specified to change the root directory where references are created. A
    -+relative path will be resolved relative to the repository's common directory.
    - ifndef::with-breaking-changes[]
    - 	This is the default.
    - endif::with-breaking-changes[]
    --`reftable`;; for the reftable format.
    -+`reftable[://<path>]`;; for the reftable format. The optional payload can
    -+be specified to change the root directory where references are created. A
    -+relative path will be resolved relative to the repository's common directory.
    - ifdef::with-breaking-changes[]
    - 	This is the default.
    - endif::with-breaking-changes[]
    -
      ## builtin/clone.c ##
     @@ builtin/clone.c: int cmd_clone(int argc,
      	char *option_origin = NULL;
    @@ builtin/clone.c: int cmd_clone(int argc,
     -		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
      			   N_("specify the reference storage format to use")),
    --		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
    - 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    + 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
    - 				N_("set config inside the new repository")),
     @@ builtin/clone.c: int cmd_clone(int argc,
      	if (option_single_branch == -1)
      		option_single_branch = deepen ? 1 : 0;
    @@ builtin/init-db.c: int cmd_init_db(int argc,
     -		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
     +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
      			   N_("specify the reference storage format to use")),
    --		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
    -+		OPT_STRING_F(0, "ref-format", &ref_storage_format_uri, N_("format"),
    - 			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
    + 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
      		OPT_END()
    - 	};
     @@ builtin/init-db.c: int cmd_init_db(int argc,
      			die(_("unknown hash algorithm '%s'"), object_format);
      	}
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
      	const char *env;
      
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    - 	 *   6. Otherwise, we fall back to the default ref storage format
    + 	 *   7. Otherwise, we fall back to the default ref storage format
      	 *      compiled into Git.
      	 */
     -	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
     +		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
     +			die(_("unknown ref storage format specified via command line: '%s'"),
     +			    ref_storage_format_uri);
    - 	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
    - 		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
    + 	} else if ((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT))) {
      		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
    + 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
     @@ setup.c: int init_db(struct repository *repo,
      	    const char *real_git_dir,
      	    const char *worktree,

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260904-b4-pks-unify-ref-storage-format-0c81fb038671

