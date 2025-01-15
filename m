Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305741DD526
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984114; cv=none; b=YWZItvbb83AxWEohWRjwdG6C/G9wAjeJBrNxWh14BI8U4KFuZYl4McpTN3nR+h4lXqDaPeGUOmDDn39yPL0Z/465bipwl7k1gAQy9MB1Zientz+pou8YzlaXh4xIb6m+Vqp2jKipQy8s/z8xWr4fjWhsInNp+5hCD33FFE1dg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984114; c=relaxed/simple;
	bh=MJytffihKH/qxpNrc2Pl3kPFiFamufdS8QM4dD/uMRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XND2gvGkoY9quWcBufnYk2S47kNq8hcznSvSPpt/W8BPG6J6o7r0rrLGP6C+KJSG+jThps6lDRIoJeGfJXbPmPSwC8SZXxUi8myfhpJUcS6+G3BIqYoPUhqleSFY567SrU3XkXg75HzkHHO/mpMGeykDCAKRZ3xg/hF6wC9/q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WyO0vJDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIQ6dVg3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WyO0vJDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIQ6dVg3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 213151140153;
	Wed, 15 Jan 2025 18:35:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jan 2025 18:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736984110; x=1737070510; bh=warX3k7tFJ
	hRymGPVQGOvThi6Y+ogzWxG/jFprQAzZQ=; b=WyO0vJDT2BbzyYfQeTLvUjoavP
	FUILcx/ywt3krIB3Pnz5uNdy/WYYRznagDRHqO+UZrq0cvoPooVh/CzGxL6EZ9ay
	Sn+FdMrlUs2VUcQMP6HBUS9h7IffPwRzGmzCXO0b7O+0P7SRciS0BaUQ9awhXLYT
	xSngavMXGjuhPNSzS+PuIHAL6g/vl8I8Bt/YjngtRSGJkAdhCKflGcapje7DfzIv
	mQDPXpBXdHaQ0n3a7o+cKFjd9AYPC44ouzYcBN7bcIFkq9Aw5SGxYRtumtUfZxw6
	APehuPHuzm5Txa9J0gsjIWAT7JUcOHO0i+NkRmDUoG6Yp85iYp30vZYnogwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736984110; x=1737070510; bh=warX3k7tFJhRymGPVQGOvThi6Y+ogzWxG/j
	FprQAzZQ=; b=EIQ6dVg3QWsYAVIXIgigmKJJpldICI2hFgsdyxBcSeZti4hPYfo
	75NJtOBwmN2qywPc2cVQchahz+Kcy99eAnJg84C74zPUkAD4Z00revTh0+AKmxTV
	dVuvpxCQECLFsVwR/18Se7cFGcRz1LiunSbFGv3rHg6DT2UQ8DVqhcbbNEa0UJvc
	AufawQfjBHuF9spJc7SVBN6Pgyi5v/KpeT/8k/Ydl0ISJewerzGd8f0wZjWHTAaE
	ipWKJ4qvHmafyGyghV9MzisNAENxobY/kSL3gkcNBl5tYJMyBWfBATsNayUS2HAE
	ONCe5++sTIo562HQSVJmRQzpp/DQFDxy64w==
X-ME-Sender: <xms:LUaIZz302mPnfD5HJpFsqcGCkskRo6cf78OAovYhBmi6NTaShAK_Ig>
    <xme:LUaIZyHo2pE_k-rIUK548kAZBust4uuZHdOVDDfIX2rjAcRLXVmxtbQFAv8IddXb7
    KBggDam0bwsFHwZlA>
X-ME-Received: <xmr:LUaIZz7Ujlr3Tux3U70djYC3QP_G83W6mpy_y3Chgd5DPAVypoOiM92gglTYmHxe1pTbzAYy3PUidTE4_90vSbIv2Hq0MMkPQcjH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehmtggvphhlsegtvghplhdrvghupdhrtghpth
    htohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LkaIZ41-i5PSiW7Y5cHecY4YqAW5WNO2e5w59lsn1OZN2e4I-xGa5Q>
    <xmx:LkaIZ2FUV1K4xnX3eNPsRL0PlPUXkExAbBDA3GxPvsGiAzAfsvB_aw>
    <xmx:LkaIZ5-vUO1pUykNPcNq0PuhXI9iPPpUEiwbIgwPGWpd1RlvWxj4qA>
    <xmx:LkaIZzkyVcSfIHXVdjR05APpWT00Ivibh53cMlE0WMB7vUiUY1bxeg>
    <xmx:LkaIZ77ikUddpiBsSCFDx3fSA1gNlUz_COnTzbqeu8c6niSI9mpnYevz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 18:35:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115222840.GB132248@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 17:28:40 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
	<xmqqa5brydz1.fsf@gitster.g>
	<20250115212952.GA96537@coredump.intra.peff.net>
	<xmqq1px3ybf7.fsf@gitster.g>
	<20250115222840.GB132248@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 15:35:08 -0800
Message-ID: <xmqqldvbvefn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jan 15, 2025 at 02:11:56PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > And it uses code 129, even for "-h". I don't see any explicit rationale
>> > for that in the history; I think it goes back to the beginning of
>> > parse-options. It happens via the PARSE_OPT_HELP flag, but curiously we
>> > also trigger that for ambiguous options (which should exit with error).
>> > That might be a bug-in-waiting if we start handling PARSE_OPT_HELP
>> > differently.
>> 
>> There is another class of callers that are protected by the same
>> "argc == 2 && !strcmp(argv[1], "-h")" condition, and they call
>> usage.c:usage(), instead of calling usage_with_options().  These
>> calls (but not all calls to usage()) need to be updated to use a
>> similar helper, say, show_usage_and_exit_if_asked().  Sigh...
>
> Oof. And that uses vreportf(), which always writes to stderr. So more
> refactoring.

Yes, it's ugly ;-)

In any case, this is a result of my sweek in builtin/ for
usage_with_options().  The remaining

	if (argc == 2 && !strcmp(argv[1], "-h"))

are all protecting usage() call.

---- >8 ----
Subject: [PATCH] builtins: send help text to standard output

Using the show_usage_help_and_exit_if_asked() helper we introduced
earlier, fix callers of usage_with_options() that want to show the
help text when explicitly asked by the end-user.  The help text now
goes to the standard output stream for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c                | 3 +--
 builtin/branch.c            | 4 ++--
 builtin/checkout--worker.c  | 6 +++---
 builtin/checkout-index.c    | 6 +++---
 builtin/commit-tree.c       | 4 ++--
 builtin/commit.c            | 8 ++++----
 builtin/fsmonitor--daemon.c | 4 ++--
 builtin/gc.c                | 4 ++--
 builtin/ls-files.c          | 4 ++--
 builtin/merge.c             | 4 ++--
 builtin/rebase.c            | 6 +++---
 builtin/update-index.c      | 4 ++--
 t/t7600-merge.sh            | 2 +-
 13 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1338b606fe..0801b556c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2427,8 +2427,7 @@ int cmd_am(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv, usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..366729a78b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -784,8 +784,8 @@ int cmd_branch(int argc,
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_branch_usage, options);
 
 	/*
 	 * Try to set sort keys from config. If config does not set any,
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index b81002a1df..7093d1efd5 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -128,9 +128,9 @@ int cmd_checkout__worker(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(checkout_worker_usage,
-				   checkout_worker_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  checkout_worker_usage,
+					  checkout_worker_options);
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, checkout_worker_options,
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a81501098d..d928d6b5e3 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -250,9 +250,9 @@ int cmd_checkout_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_checkout_index_usage,
-				   builtin_checkout_index_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_checkout_index_usage,
+					  builtin_checkout_index_options);
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2ca1a57ebb..2efc224d32 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -119,8 +119,8 @@ int cmd_commit_tree(int argc,
 
 	git_config(git_default_config, NULL);
 
-	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage_with_options(commit_tree_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  commit_tree_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, commit_tree_usage, 0);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index ef5e622c07..4268915120 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1559,8 +1559,8 @@ struct repository *repo UNUSED)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_status_usage, builtin_status_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_status_usage, builtin_status_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1736,8 +1736,8 @@ int cmd_commit(int argc,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_usage, builtin_commit_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_commit_usage, builtin_commit_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 029dc64d6c..dabf190bbe 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1598,8 +1598,8 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_fsmonitor__daemon_usage, options);
 
 	die(_("fsmonitor--daemon not supported on this platform"));
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de2..5f831e1f94 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,8 +710,8 @@ struct repository *repo UNUSED)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_gc_usage, builtin_gc_options);
 
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 15499cd12b..9efe92b7c0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -644,8 +644,8 @@ int cmd_ls_files(int argc,
 	};
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  ls_files_usage, builtin_ls_files_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/merge.c b/builtin/merge.c
index 5f67007bba..95d798fc89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1300,8 +1300,8 @@ int cmd_merge(int argc,
 	void *branch_to_free;
 	int orig_argc = argc;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_merge_usage, builtin_merge_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_merge_usage, builtin_merge_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0498fff3c9..cb49323c44 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1223,9 +1223,9 @@ int cmd_rebase(int argc,
 	};
 	int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_rebase_usage,
-				   builtin_rebase_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_rebase_usage,
+					  builtin_rebase_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74bbad9f87..b0e2ad4970 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1045,8 +1045,8 @@ int cmd_update_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(update_index_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  update_index_usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index ef54cff4fa..2a8df29219 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'merge -h with invalid index' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git merge -h 2>usage
+		test_expect_code 129 git merge -h >usage
 	) &&
 	test_grep "[Uu]sage: git merge" broken/usage
 '
-- 
2.48.1-187-gd93ffc6ef3

