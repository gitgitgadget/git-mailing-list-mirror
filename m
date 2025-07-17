Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0929ACCB
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749379; cv=none; b=O7CFA4qCld0yDzWe2mgbF6gV/EnHI8W+XXCqEDRcvWkF3l3p06JfoeUEFtkt2ZPQrYwVv7HVx2D02IrPVHdCi3oT5uAbDI1+d/7vfyNpTU74f59AyVCoxUffUxV4oms+l/Y/mKRg1uKn8GvteFlKpX61XDjRLMY6iGw0/HqbLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749379; c=relaxed/simple;
	bh=Fcyb2L2cwQEvWPle/TC/8Eus45Wn1YJ6O2RdEtzONQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvoescuFrycnnwinlVS3vF4cEee7A4pnDBIEvZ7Q/0yHsS1B2Qcu2dnlMcTEJNKh0fb//LzrEyi9kVwZttcmDwl1hmT6rSES9w1RKZozicJDGmBqOFAijwI2z1YdhaNW9d9JB837skwrktymxOWql7uQGsiqnIuV6q0+zeF3BE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Db/8CazF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MB5dlA0p; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Db/8CazF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MB5dlA0p"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C85A7A0200
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 06:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749373;
	 x=1752835773; bh=IUsPu0vqUXYwr+YYzFDmJ47YVsnP2gyXWSKKKpEwiCc=; b=
	Db/8CazF4wrNsZHLqCKYgw63UY5IfMZt+Dg71X1HfcQ4dvHqknBn4kAJ4HxxIEyn
	DuuIC+YWZg9GkdH/mpTfEFUFmuhOdQAX42LfgK2z6xp+RH0egUT/Unk8ifGHshLb
	PckklDtcff4rZbeqY/xVxXCEMRWftpNRub4ahWvshc7GDuLMIek6Wc6UcOTn8bZd
	V0qJGyX8uWJsBSLWhZyQeELY66mRxVCiSSfHTG5dUn2CzOCOTuVMBjJNJTJ4djrr
	kE62sBymKUGQJHdiHQO5TCU+o1gJ/gX3MWd19DtvTHNjNSWcTBDO2DzxFWzEHdnW
	3EW383Ib4Y7IJyo457UfgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749373; x=
	1752835773; bh=IUsPu0vqUXYwr+YYzFDmJ47YVsnP2gyXWSKKKpEwiCc=; b=M
	B5dlA0poAIf+0clgPDhyUn0GY7aqTqETyGS5OpxxbGdDhDQVijE23BNtmSTc6wvw
	TuU11hsWLjTgwsmv9PZ917f5yO13oD8tIaFRfbscK/EOMfXTBPWpbyKW5/ksZM/r
	/MxyywjNqIwLD+698EoIEj6UJxDQl4OtVU6G1sV1bD0VpmYeP/c4Hq0thSCNsoDK
	azv4jA7t4MjxV3JuSVVFeTRGwdmYUAlmyOGGc03l9w6cGynHY2F8JG7Iu/+feVaM
	TLOK3Zd7sZU7RicmgFwaqcDJtMUzAau/jgCJ9XvgjZsHUDFuuDFt0VNjhKY8D//x
	yKxfH9bPf1iv3xjNotczg==
X-ME-Sender: <xms:PdV4aGTBn2qpETKepdLerr0_LsxT4zQ1xexSzHCaFV1t_C69VJ8sxQ>
    <xme:PdV4aNyaF2rqcoW9bO4gQOK35sXtp0wuNv2C1DqTiLlz2EUpRbWDn3FpJQoTWAeSS
    pL9Q7m-Xet1w8kL9A>
X-ME-Received: <xmr:PdV4aNMYdFTmUc8wO70ePAm1EMGT3-cEUF5BWNY8KsbapsUFvobzpSCQyaHzyFrzsOLcUcpYOWVIp2rzlss5rsbgJDXZOjR2DHJQbtGkVuGi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgr
    thhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrth
    htvghrnhepteeuhfeiffduheekledthfefhfegfeetfeeiiedvueeltdekuedtgfegieet
    udehnecuffhomhgrihhnpegrrhhgshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:PdV4aEMZZcE5k-D0LtLR3AQO0TkliUska7TNgdc3AWaRMPigx4ihXQ>
    <xmx:PdV4aHTgLFKrUGHfWbFR0kWFX155oUvs7x-2m-P8Ka7AezpT5_Zezw>
    <xmx:PdV4aODSsuBiObJIQZLxA4qym6IxcjuU2QnPh2neEhq1DjSGzN2f1g>
    <xmx:PdV4aOiorNRu6i9DoFf3iwGeRDHy7RWsuFuWEK7JDCKLnh8MvT8nHw>
    <xmx:PdV4aPIUZUnSGbW85_nJR-Qfupk5NZtWk5oRn7fuKKrC_d1MJesKmB1->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e218a65 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:21 +0200
Subject: [PATCH 01/21] config: drop `git_config()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-1-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config()`. All callsites
are adjusted so that they use `repo_config(the_repository, ...)`
instead. While some callsites might already have a repository available,
this mechanical conversion is the exact same as the current situation
and thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/user-manual.adoc                 |  2 +-
 apply.c                                        |  2 +-
 archive-tar.c                                  |  2 +-
 archive-zip.c                                  |  2 +-
 archive.c                                      |  2 +-
 builtin/am.c                                   |  2 +-
 builtin/blame.c                                |  2 +-
 builtin/branch.c                               |  2 +-
 builtin/cat-file.c                             |  2 +-
 builtin/check-attr.c                           |  2 +-
 builtin/check-ignore.c                         |  2 +-
 builtin/check-mailmap.c                        |  2 +-
 builtin/checkout--worker.c                     |  2 +-
 builtin/checkout.c                             |  2 +-
 builtin/clean.c                                |  2 +-
 builtin/clone.c                                |  4 ++--
 builtin/column.c                               |  4 ++--
 builtin/commit-graph.c                         |  4 ++--
 builtin/commit-tree.c                          |  2 +-
 builtin/commit.c                               |  4 ++--
 builtin/config.c                               |  2 +-
 builtin/count-objects.c                        |  2 +-
 builtin/credential.c                           |  2 +-
 builtin/describe.c                             |  2 +-
 builtin/diff-files.c                           |  2 +-
 builtin/diff-index.c                           |  2 +-
 builtin/diff-tree.c                            |  2 +-
 builtin/diff.c                                 |  2 +-
 builtin/fast-export.c                          |  2 +-
 builtin/fast-import.c                          |  2 +-
 builtin/fetch.c                                |  4 ++--
 builtin/fmt-merge-msg.c                        |  2 +-
 builtin/fsck.c                                 |  2 +-
 builtin/fsmonitor--daemon.c                    |  2 +-
 builtin/gc.c                                   |  2 +-
 builtin/grep.c                                 |  2 +-
 builtin/hash-object.c                          |  2 +-
 builtin/help.c                                 |  4 ++--
 builtin/hook.c                                 |  2 +-
 builtin/index-pack.c                           |  2 +-
 builtin/interpret-trailers.c                   |  2 +-
 builtin/log.c                                  | 20 ++++++++++----------
 builtin/ls-tree.c                              |  2 +-
 builtin/merge-base.c                           |  2 +-
 builtin/merge-file.c                           |  2 +-
 builtin/merge-tree.c                           |  2 +-
 builtin/merge.c                                |  2 +-
 builtin/mktag.c                                |  2 +-
 builtin/multi-pack-index.c                     |  4 ++--
 builtin/mv.c                                   |  2 +-
 builtin/name-rev.c                             |  2 +-
 builtin/notes.c                                |  2 +-
 builtin/pack-objects.c                         |  2 +-
 builtin/patch-id.c                             |  2 +-
 builtin/pull.c                                 |  2 +-
 builtin/push.c                                 |  2 +-
 builtin/range-diff.c                           |  2 +-
 builtin/read-tree.c                            |  2 +-
 builtin/rebase.c                               |  2 +-
 builtin/receive-pack.c                         |  2 +-
 builtin/reflog.c                               |  2 +-
 builtin/refs.c                                 |  2 +-
 builtin/remote.c                               |  6 +++---
 builtin/repack.c                               |  2 +-
 builtin/replace.c                              |  2 +-
 builtin/rerere.c                               |  2 +-
 builtin/reset.c                                |  2 +-
 builtin/rev-list.c                             |  2 +-
 builtin/rev-parse.c                            |  4 ++--
 builtin/rm.c                                   |  2 +-
 builtin/shortlog.c                             |  2 +-
 builtin/show-branch.c                          |  2 +-
 builtin/show-ref.c                             |  2 +-
 builtin/sparse-checkout.c                      |  2 +-
 builtin/stash.c                                |  4 ++--
 builtin/stripspace.c                           |  2 +-
 builtin/submodule--helper.c                    |  8 ++++----
 builtin/symbolic-ref.c                         |  2 +-
 builtin/tag.c                                  |  2 +-
 builtin/unpack-file.c                          |  2 +-
 builtin/unpack-objects.c                       |  2 +-
 builtin/update-index.c                         |  2 +-
 builtin/update-ref.c                           |  2 +-
 builtin/var.c                                  |  4 ++--
 builtin/verify-pack.c                          |  2 +-
 builtin/worktree.c                             |  2 +-
 builtin/write-tree.c                           |  2 +-
 config.h                                       |  5 -----
 connect.c                                      |  2 +-
 contrib/coccinelle/config_fn_ctx.pending.cocci |  2 +-
 convert.c                                      |  2 +-
 fetch-pack.c                                   |  2 +-
 fsck.h                                         |  2 +-
 gpg-interface.c                                |  2 +-
 help.c                                         |  4 ++--
 http-fetch.c                                   |  2 +-
 http.c                                         |  2 +-
 imap-send.c                                    |  2 +-
 ls-refs.c                                      |  2 +-
 merge-ll.c                                     |  2 +-
 merge-ort.c                                    |  2 +-
 notes-utils.c                                  |  2 +-
 notes.c                                        |  2 +-
 pretty.c                                       |  2 +-
 refs/reftable-backend.c                        |  2 +-
 rerere.c                                       |  4 ++--
 revision.c                                     |  2 +-
 scalar.c                                       |  2 +-
 sequencer.c                                    |  2 +-
 setup.c                                        |  4 ++--
 t/helper/test-advise.c                         |  2 +-
 t/helper/test-config.c                         |  8 ++++----
 t/helper/test-read-cache.c                     |  2 +-
 t/helper/test-userdiff.c                       |  2 +-
 t/t4256/1/mailinfo.c                           |  2 +-
 t/t4256/1/mailinfo.c.orig                      |  2 +-
 trailer.c                                      |  4 ++--
 transport.c                                    |  2 +-
 118 files changed, 148 insertions(+), 153 deletions(-)

diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 8d00a9e8229..76969871176 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -4270,7 +4270,7 @@ So, look into `builtin/cat-file.c`, search for `cmd_cat_file()` and look what
 it does.
 
 ------------------------------------------------------------------
-        git_config(git_default_config);
+        repo_config(the_repository, git_default_config);
         if (argc != 3)
 		usage("git cat-file [-t|-s|-e|-p|<type>] <sha1>");
         if (get_sha1(argv[2], sha1))
diff --git a/apply.c b/apply.c
index a3804316fbd..d2381a157c0 100644
--- a/apply.c
+++ b/apply.c
@@ -50,7 +50,7 @@ static void git_apply_config(void)
 {
 	git_config_get_string("apply.whitespace", &apply_default_whitespace);
 	git_config_get_string("apply.ignorewhitespace", &apply_default_ignorewhitespace);
-	git_config(git_xmerge_config, NULL);
+	repo_config(the_repository, git_xmerge_config, NULL);
 }
 
 static int parse_whitespace_option(struct apply_state *state, const char *option)
diff --git a/archive-tar.c b/archive-tar.c
index 249164ea77d..73b63ddc41b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -537,7 +537,7 @@ void init_tar_archiver(void)
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
-	git_config(git_tar_config, NULL);
+	repo_config(the_repository, git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
diff --git a/archive-zip.c b/archive-zip.c
index df8866d5bae..dbd90d9c3d4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -632,7 +632,7 @@ static int write_zip_archive(const struct archiver *ar UNUSED,
 {
 	int err;
 
-	git_config(archive_zip_config, NULL);
+	repo_config(the_repository, archive_zip_config, NULL);
 
 	dos_time(&args->time, &zip_date, &zip_time);
 
diff --git a/archive.c b/archive.c
index f5a9d45c8d3..2dd306a07a7 100644
--- a/archive.c
+++ b/archive.c
@@ -761,7 +761,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	int rc;
 
 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	describe_status.max_invocations = 1;
 	ctx.date_mode.type = DATE_NORMAL;
diff --git a/builtin/am.c b/builtin/am.c
index c9d925f7b96..a7e7cf1465a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2445,7 +2445,7 @@ int cmd_am(int argc,
 
 	show_usage_with_options_if_asked(argc, argv, usage, options);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	am_state_init(&state);
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 91586e6852b..71efeb7c7e6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -947,7 +947,7 @@ int cmd_blame(int argc,
 	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
-	git_config(git_blame_config, &output_option);
+	repo_config(the_repository, git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
diff --git a/builtin/branch.c b/builtin/branch.c
index c150131bd9f..08e50bf77b3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,7 +791,7 @@ int cmd_branch(int argc,
 	 * Try to set sort keys from config. If config does not set any,
 	 * fall back on default (refname) sorting.
 	 */
-	git_config(git_branch_config, &sorting_options);
+	repo_config(the_repository, git_branch_config, &sorting_options);
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2492a0b6f39..b9eb2bb3b92 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1095,7 +1095,7 @@ int cmd_cat_file(int argc,
 		OPT_END()
 	};
 
-	git_config(git_cat_file_config, NULL);
+	repo_config(the_repository, git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 7cf275b8937..51ed48ce437 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -119,7 +119,7 @@ int cmd_check_attr(int argc,
 	if (!is_bare_repository())
 		setup_work_tree();
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 7b7831d13a8..03033499cb0 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -159,7 +159,7 @@ int cmd_check_ignore(int argc,
 	int num_ignored;
 	struct dir_struct dir = DIR_INIT;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_ignore_options,
 			     check_ignore_usage, 0);
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index be2cebe1215..634626c6728 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -56,7 +56,7 @@ int cmd_check_mailmap(int argc,
 	int i;
 	struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, check_mailmap_options,
 			     check_mailmap_usage, 0);
 	if (argc == 0 && !use_stdin)
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index da9345a44b8..27a7d4f0409 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -132,7 +132,7 @@ int cmd_checkout__worker(int argc,
 					 checkout_worker_usage,
 					 checkout_worker_options);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, checkout_worker_options,
 			     checkout_worker_usage, 0);
 	if (argc > 0)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0a90b86a729..948ff7bdda7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1764,7 +1764,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	opts->prefix = prefix;
 	opts->show_progress = -1;
 
-	git_config(git_checkout_config, opts);
+	repo_config(the_repository, git_checkout_config, opts);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/clean.c b/builtin/clean.c
index 053c94fc6bd..5ee147c4acc 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -949,7 +949,7 @@ int cmd_clean(int argc,
 		OPT_END()
 	};
 
-	git_config(git_clean_config, NULL);
+	repo_config(the_repository, git_clean_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
diff --git a/builtin/clone.c b/builtin/clone.c
index 6d08abed37c..3c6d8529b6c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1001,7 +1001,7 @@ int cmd_clone(int argc,
 
 	packet_trace_identity("clone");
 
-	git_config(git_clone_config, NULL);
+	repo_config(the_repository, git_clone_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1242,7 +1242,7 @@ int cmd_clone(int argc,
 	 * re-read config after init_db and write_config to pick up any config
 	 * injected by --template and --config, respectively.
 	 */
-	git_config(git_clone_config, NULL);
+	repo_config(the_repository, git_clone_config, NULL);
 
 	/*
 	 * If option_reject_shallow is specified from CLI option,
diff --git a/builtin/column.c b/builtin/column.c
index ce6443d5fac..87dce3c6e53 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -42,9 +42,9 @@ int cmd_column(int argc,
 	/* This one is special and must be the first one */
 	if (argc > 1 && starts_with(argv[1], "--command=")) {
 		command = argv[1] + 10;
-		git_config(column_config, (void *)command);
+		repo_config(the_repository, column_config, (void *)command);
 	} else
-		git_config(column_config, NULL);
+		repo_config(the_repository, column_config, NULL);
 
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9df..c5cc601844c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -265,7 +265,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 
 	trace2_cmd_mode("write");
 
-	git_config(git_commit_graph_write_config, &opts);
+	repo_config(the_repository, git_commit_graph_write_config, &opts);
 
 	argc = parse_options(argc, argv, prefix,
 			     options,
@@ -347,7 +347,7 @@ int cmd_commit_graph(int argc,
 	};
 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	disable_replace_refs();
 	save_commit_buffer = 0;
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 31cfd9bd15d..2f1df28d413 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -125,7 +125,7 @@ int cmd_commit_tree(int argc,
 	};
 	int ret;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	show_usage_with_options_if_asked(argc, argv,
 					 commit_tree_usage, options);
diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64a..fcd829e04ec 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -207,9 +207,9 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
 	wt_status_prepare(the_repository, s);
 	init_diff_ui_defaults();
-	git_config(fn, s);
+	repo_config(the_repository, fn, s);
 	determine_whence(s);
-	s->hints = advice_enabled(ADVICE_STATUS_HINTS); /* must come after git_config() */
+	s->hints = advice_enabled(ADVICE_STATUS_HINTS); /* must come after repo_config() */
 }
 
 static void rollback_index_files(void)
diff --git a/builtin/config.c b/builtin/config.c
index 5efe2730106..af5d79eadc0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1091,7 +1091,7 @@ static int show_editor(struct config_location_options *opts)
 		die(_("editing stdin is not supported"));
 	if (opts->source.blob)
 		die(_("editing blobs is not supported"));
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	config_file = opts->source.file ?
 			xstrdup(opts->source.file) :
 			repo_git_path(the_repository, "config");
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f687647931e..433daff805a 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -106,7 +106,7 @@ int cmd_count_objects(int argc,
 		OPT_END(),
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
 	/* we do not take arguments other than flags for now */
diff --git a/builtin/credential.c b/builtin/credential.c
index 2e11b15dde3..52f172e80cb 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -16,7 +16,7 @@ int cmd_credential(int argc,
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	show_usage_if_asked(argc, argv, usage_msg);
 	if (argc != 2)
diff --git a/builtin/describe.c b/builtin/describe.c
index fbf305d7624..d7dd8139dec 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -623,7 +623,7 @@ int cmd_describe(int argc,
 		OPT_END(),
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
 	if (abbrev < 0)
 		abbrev = DEFAULT_ABBREV;
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 99b1749723b..ea91347ce23 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -31,7 +31,7 @@ int cmd_diff_files(int argc,
 
 	show_usage_if_asked(argc, argv, diff_files_usage);
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	repo_config(the_repository, git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 81c0bc8ed7c..522dacfc4cf 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -28,7 +28,7 @@ int cmd_diff_index(int argc,
 
 	show_usage_if_asked(argc, argv, diff_cache_usage);
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	repo_config(the_repository, git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index e31cc797fe1..49dd4d00ebf 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -124,7 +124,7 @@ int cmd_diff_tree(int argc,
 
 	show_usage_if_asked(argc, argv, diff_tree_usage);
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	repo_config(the_repository, git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index eebffe36ccf..9a89e25a982 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -486,7 +486,7 @@ int cmd_diff(int argc,
 		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	init_diff_ui_defaults();
-	git_config(git_diff_ui_config, NULL);
+	repo_config(the_repository, git_diff_ui_config, NULL);
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	repo_init_revisions(the_repository, &rev, prefix);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6a3a17a8cd9..17027b859e0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1327,7 +1327,7 @@ int cmd_fast_export(int argc,
 		usage_with_options (fast_export_usage, options);
 
 	/* we handle encodings */
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	repo_init_revisions(the_repository, &revs, prefix);
 	init_revision_sources(&revision_sources);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b1389c59211..607441e921b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3541,7 +3541,7 @@ static void git_pack_config(void)
 	else if (!git_config_get_int("transfer.unpacklimit", &limit))
 		unpack_limit = limit;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 }
 
 static const char fast_import_usage[] =
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 87a0cca7994..ea447c453d1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1995,7 +1995,7 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 	struct remote_group_data g;
 	g.name = name; g.list = list;
 
-	git_config(get_remote_group, &g);
+	repo_config(the_repository, get_remote_group, &g);
 	if (list->nr == prev_nr) {
 		struct remote *remote = remote_get(name);
 		if (!remote_is_configured(remote, 0))
@@ -2417,7 +2417,7 @@ int cmd_fetch(int argc,
 		free(anon);
 	}
 
-	git_config(git_fetch_config, &config);
+	repo_config(the_repository, git_fetch_config, &config);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3b6aac2cf7f..edb93c0b3a3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -53,7 +53,7 @@ int cmd_fmt_merge_msg(int argc,
 	int ret;
 	struct fmt_merge_msg_opts opts;
 
-	git_config(fmt_merge_msg_config, NULL);
+	repo_config(the_repository, fmt_merge_msg_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0084cf7400b..0ec6ca06e3b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -987,7 +987,7 @@ int cmd_fsck(int argc,
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	git_config(git_fsck_config, &fsck_obj_options);
+	repo_config(the_repository, git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
 
 	if (check_references)
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 0820e524f1a..469c62b555b 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1547,7 +1547,7 @@ int cmd_fsmonitor__daemon(int argc,
 		OPT_END()
 	};
 
-	git_config(fsmonitor_config, NULL);
+	repo_config(the_repository, fsmonitor_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_fsmonitor__daemon_usage, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index fab8f4dd4f7..d9e3b9d2ec3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -228,7 +228,7 @@ static void gc_config(struct gc_config *cfg)
 		cfg->repack_filter_to = owned;
 	}
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 }
 
 enum schedule_priority {
diff --git a/builtin/grep.c b/builtin/grep.c
index 39273d9c0fd..7982dda9a3b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1035,7 +1035,7 @@ int cmd_grep(int argc,
 	grep_prefix = prefix;
 
 	grep_init(&opt, the_repository);
-	git_config(grep_cmd_config, &opt);
+	repo_config(the_repository, grep_cmd_config, &opt);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index ddf281413a6..c3ad1e91c96 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -111,7 +111,7 @@ int cmd_hash_object(int argc,
 		vpath = vpath_free;
 	}
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	if (stdin_paths) {
 		if (hashstdin)
diff --git a/builtin/help.c b/builtin/help.c
index c257079cebc..d79ecd946a6 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -210,7 +210,7 @@ static enum help_format parse_help_format(const char *format)
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
 	/*
-	 * Please update _git_config() in git-completion.bash when you
+	 * Please update _repo_config() in git-completion.bash when you
 	 * add new help formats.
 	 */
 	die(_("unrecognized help format '%s'"), format);
@@ -706,7 +706,7 @@ int cmd_help(int argc,
 	}
 
 	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
+	repo_config(the_repository, git_help_config, NULL);
 
 	if (parsed_help_format != HELP_FORMAT_NONE)
 		help_format = parsed_help_format;
diff --git a/builtin/hook.c b/builtin/hook.c
index 672d2e37e84..044c27aa95d 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -55,7 +55,7 @@ static int run(int argc, const char **argv, const char *prefix,
 		strvec_push(&opt.args, argv[i]);
 
 	/* Need to take into account core.hooksPath */
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	hook_name = argv[0];
 	if (!ignore_missing)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0a5c8a1ac85..53f1a7cd71e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1917,7 +1917,7 @@ int cmd_index_pack(int argc,
 
 	reset_pack_idx_option(&opts);
 	opts.flags |= WRITE_REV;
-	git_config(git_index_pack_config, &opts);
+	repo_config(the_repository, git_index_pack_config, &opts);
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 44d8ccddc9d..3141c37b853 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -220,7 +220,7 @@ int cmd_interpret_trailers(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
diff --git a/builtin/log.c b/builtin/log.c
index 24a57c20a41..1bedc4ef355 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -659,10 +659,10 @@ int cmd_whatchanged(int argc,
 
 	log_config_init(&cfg);
 	init_diff_ui_defaults();
-	git_config(git_log_config, &cfg);
+	repo_config(the_repository, git_log_config, &cfg);
 
 	repo_init_revisions(the_repository, &rev, prefix);
-	git_config(grep_config, &rev.grep_filter);
+	repo_config(the_repository, grep_config, &rev.grep_filter);
 
 	rev.diff = 1;
 	rev.simplify_history = 0;
@@ -790,7 +790,7 @@ int cmd_show(int argc,
 
 	log_config_init(&cfg);
 	init_diff_ui_defaults();
-	git_config(git_log_config, &cfg);
+	repo_config(the_repository, git_log_config, &cfg);
 
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -799,7 +799,7 @@ int cmd_show(int argc,
 
 	memset(&match_all, 0, sizeof(match_all));
 	repo_init_revisions(the_repository, &rev, prefix);
-	git_config(grep_config, &rev.grep_filter);
+	repo_config(the_repository, grep_config, &rev.grep_filter);
 
 	rev.diff = 1;
 	rev.always_show_header = 1;
@@ -907,11 +907,11 @@ int cmd_log_reflog(int argc,
 
 	log_config_init(&cfg);
 	init_diff_ui_defaults();
-	git_config(git_log_config, &cfg);
+	repo_config(the_repository, git_log_config, &cfg);
 
 	repo_init_revisions(the_repository, &rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
-	git_config(grep_config, &rev.grep_filter);
+	repo_config(the_repository, grep_config, &rev.grep_filter);
 
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -952,10 +952,10 @@ int cmd_log(int argc,
 
 	log_config_init(&cfg);
 	init_diff_ui_defaults();
-	git_config(git_log_config, &cfg);
+	repo_config(the_repository, git_log_config, &cfg);
 
 	repo_init_revisions(the_repository, &rev, prefix);
-	git_config(grep_config, &rev.grep_filter);
+	repo_config(the_repository, grep_config, &rev.grep_filter);
 
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -2158,9 +2158,9 @@ int cmd_format_patch(int argc,
 	format_config_init(&cfg);
 	init_diff_ui_defaults();
 	init_display_notes(&cfg.notes_opt);
-	git_config(git_format_config, &cfg);
+	repo_config(the_repository, git_format_config, &cfg);
 	repo_init_revisions(the_repository, &rev, prefix);
-	git_config(grep_config, &rev.grep_filter);
+	repo_config(the_repository, grep_config, &rev.grep_filter);
 
 	rev.show_notes = cfg.show_notes;
 	memcpy(&rev.notes_opt, &cfg.notes_opt, sizeof(cfg.notes_opt));
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4d616dd5282..4ba84e51967 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -375,7 +375,7 @@ int cmd_ls_tree(int argc,
 	struct object_context obj_context = {0};
 	int ret;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 123c81515e1..8fde35c1751 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -167,7 +167,7 @@ int cmd_merge_base(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
 
 	if (cmdmode == 'a') {
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 9464f275629..3da4ca2c8cf 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -97,7 +97,7 @@ int cmd_merge_file(int argc,
 
 	if (startup_info->have_repository) {
 		/* Read the configuration file */
-		git_config(git_xmerge_config, NULL);
+		repo_config(the_repository, git_xmerge_config, NULL);
 		if (0 <= git_xmerge_style)
 			xmp.style = git_xmerge_style;
 	}
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cf8b06cadc7..99a6495fd52 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -683,7 +683,7 @@ int cmd_merge_tree(int argc,
 	if (argc != expected_remaining_argc)
 		usage_with_options(merge_tree_usage, mt_options);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
diff --git a/builtin/merge.c b/builtin/merge.c
index 18b22c0a26d..dc4cb8fb14d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1392,7 +1392,7 @@ int cmd_merge(int argc,
 		skip_prefix(branch, "refs/heads/", &branch);
 
 	init_diff_ui_defaults();
-	git_config(git_merge_config, NULL);
+	repo_config(the_repository, git_merge_config, NULL);
 
 	if (!branch || is_null_oid(&head_oid))
 		head_commit = NULL;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 27e649736cf..e078c97d032 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -98,7 +98,7 @@ int cmd_mktag(int argc,
 	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
-	git_config(git_fsck_config, &fsck_options);
+	repo_config(the_repository, git_fsck_config, &fsck_options);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index aa25b06f9d0..9a113f0f1f3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -143,7 +143,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
 
-	git_config(git_multi_pack_index_write_config, NULL);
+	repo_config(the_repository, git_multi_pack_index_write_config, NULL);
 
 	options = add_common_options(builtin_multi_pack_index_write_options);
 
@@ -290,7 +290,7 @@ int cmd_multi_pack_index(int argc,
 
 	disable_replace_refs();
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	if (the_repository &&
 	    the_repository->objects &&
diff --git a/builtin/mv.c b/builtin/mv.c
index 07548fe96ae..d43925097b4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -239,7 +239,7 @@ int cmd_mv(int argc,
 	struct strbuf pathbuf = STRBUF_INIT;
 	int ret;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index ff199638dee..74512e54a38 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -600,7 +600,7 @@ int cmd_name_rev(int argc,
 
 	mem_pool_init(&string_pool, 0);
 	init_commit_rev_name(&rev_names);
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 
 #ifndef WITH_BREAKING_CHANGES
diff --git a/builtin/notes.c b/builtin/notes.c
index a9529b1696a..17004cdb10e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1145,7 +1145,7 @@ int cmd_notes(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 	if (!fn) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5781dec9808..8c86ec2d89f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4924,7 +4924,7 @@ int cmd_pack_objects(int argc,
 
 	reset_pack_idx_option(&pack_idx_opts);
 	pack_idx_opts.flags |= WRITE_REV;
-	git_config(git_pack_config, NULL);
+	repo_config(the_repository, git_pack_config, NULL);
 	if (git_env_bool(GIT_TEST_NO_WRITE_REV_INDEX, 0))
 		pack_idx_opts.flags &= ~WRITE_REV;
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 26f04b0335d..a659f00531a 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -235,7 +235,7 @@ int cmd_patch_id(int argc,
 		OPT_END()
 	};
 
-	git_config(git_patch_id_config, &config);
+	repo_config(the_repository, git_patch_id_config, &config);
 
 	/* verbatim implies stable */
 	if (config.verbatim)
diff --git a/builtin/pull.c b/builtin/pull.c
index c593f324fe7..d13ed9b5176 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -999,7 +999,7 @@ int cmd_pull(int argc,
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
-	git_config(git_pull_config, NULL);
+	repo_config(the_repository, git_pull_config, NULL);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/push.c b/builtin/push.c
index 92d530e5c4d..d0794b7b305 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -598,7 +598,7 @@ int cmd_push(int argc,
 	};
 
 	packet_trace_identity("push");
-	git_config(git_push_config, &flags);
+	repo_config(the_repository, git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	push_options = (push_options_cmdline.nr
 		? &push_options_cmdline
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 32ddb6613fb..a563abff5fe 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -54,7 +54,7 @@ int cmd_range_diff(int argc,
 	struct object_id oid;
 	const char *three_dots = NULL;
 
-	git_config(git_diff_ui_config, NULL);
+	repo_config(the_repository, git_diff_ui_config, NULL);
 
 	repo_diff_setup(the_repository, &diffopt);
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index a8f352f7cd9..00eef756e67 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -168,7 +168,7 @@ int cmd_read_tree(int argc,
 	opts.src_index = the_repository->index;
 	opts.dst_index = the_repository->index;
 
-	git_config(git_read_tree_config, NULL);
+	repo_config(the_repository, git_read_tree_config, NULL);
 
 	argc = parse_options(argc, argv, cmd_prefix, read_tree_options,
 			     read_tree_usage, 0);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e90562a3b8a..0c3daa4b814 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1245,7 +1245,7 @@ int cmd_rebase(int argc,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	git_config(rebase_config, &options);
+	repo_config(the_repository, rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
 	gpg_sign = options.gpg_sign_opt ? "" : NULL;
 	FREE_AND_NULL(options.gpg_sign_opt);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7974d157eb9..82d516a42c4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2613,7 +2613,7 @@ int cmd_receive_pack(int argc,
 	if (!enter_repo(service_dir, 0))
 		die("'%s' does not appear to be a git repository", service_dir);
 
-	git_config(receive_pack_config, NULL);
+	repo_config(the_repository, receive_pack_config, NULL);
 	if (cert_nonce_seed)
 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acaf3e32c2..4312f3d34c9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -202,7 +202,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	git_config(reflog_expire_config, &opts);
+	repo_config(the_repository, reflog_expire_config, &opts);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1cc..c7ad0a2963a 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
 
-	git_config(git_fsck_config, &fsck_refs_options);
+	repo_config(the_repository, git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
 	worktrees = get_worktrees_without_reading_head();
diff --git a/builtin/remote.c b/builtin/remote.c
index 18843b6bf6c..ebd70bea3a1 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -353,7 +353,7 @@ static void read_branches(void)
 {
 	if (branch_list.nr)
 		return;
-	git_config(config_read_branches, NULL);
+	repo_config(the_repository, config_read_branches, NULL);
 }
 
 struct ref_states {
@@ -690,7 +690,7 @@ static void handle_push_default(const char* old_name, const char* new_name)
 		.origin = STRBUF_INIT,
 		.linenr = -1,
 	};
-	git_config(config_read_push_default, &push_default);
+	repo_config(the_repository, config_read_push_default, &push_default);
 	if (push_default.scope >= CONFIG_SCOPE_COMMAND)
 		; /* pass */
 	else if (push_default.scope >= CONFIG_SCOPE_LOCAL) {
@@ -1620,7 +1620,7 @@ static int update(int argc, const char **argv, const char *prefix,
 		strvec_push(&cmd.args, argv[i]);
 
 	if (strcmp(cmd.args.v[cmd.args.nr-1], "default") == 0) {
-		git_config(get_remote_default, &default_defined);
+		repo_config(the_repository, get_remote_default, &default_defined);
 		if (!default_defined) {
 			strvec_pop(&cmd.args);
 			strvec_push(&cmd.args, "--all");
diff --git a/builtin/repack.c b/builtin/repack.c
index b05ffe46239..dd1db282dac 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1230,7 +1230,7 @@ int cmd_repack(int argc,
 
 	list_objects_filter_init(&po_args.filter_options);
 
-	git_config(repack_config, &cruft_po_args);
+	repo_config(the_repository, repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
diff --git a/builtin/replace.c b/builtin/replace.c
index 5ff2ab723cb..3fe39e9df73 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -574,7 +574,7 @@ int cmd_replace(int argc,
 	};
 
 	disable_replace_refs();
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 1312e79d89f..a056cb791b4 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -66,7 +66,7 @@ int cmd_rerere(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
 
-	git_config(git_xmerge_config, NULL);
+	repo_config(the_repository, git_xmerge_config, NULL);
 
 	if (autoupdate == 1)
 		flags = RERERE_AUTOUPDATE;
diff --git a/builtin/reset.c b/builtin/reset.c
index dc50ffc1ac5..00492c19b06 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -377,7 +377,7 @@ int cmd_reset(int argc,
 		OPT_END()
 	};
 
-	git_config(git_reset_config, NULL);
+	repo_config(the_repository, git_reset_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4d0c460f186..034ea0a558a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -636,7 +636,7 @@ int cmd_rev_list(int argc,
 
 	show_usage_if_asked(argc, argv, rev_list_usage);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 490da33becc..44ff1b8342a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -734,7 +734,7 @@ int cmd_rev_parse(int argc,
 	/* No options; just report on whether we're in a git repo or not. */
 	if (argc == 1) {
 		setup_git_directory();
-		git_config(git_default_config, NULL);
+		repo_config(the_repository, git_default_config, NULL);
 		return 0;
 	}
 
@@ -769,7 +769,7 @@ int cmd_rev_parse(int argc,
 		/* The rest of the options require a git repository. */
 		if (!did_repo_setup) {
 			prefix = setup_git_directory();
-			git_config(git_default_config, NULL);
+			repo_config(the_repository, git_default_config, NULL);
 			did_repo_setup = 1;
 
 			prepare_repo_settings(the_repository);
diff --git a/builtin/rm.c b/builtin/rm.c
index a6565a69cfc..8c0da7a3ce7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -271,7 +271,7 @@ int cmd_rm(int argc,
 	struct pathspec pathspec;
 	char *seen;
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 60adc5e7a56..b91acf45c8f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -421,7 +421,7 @@ int cmd_shortlog(int argc,
 	if (nongit && !the_hash_algo)
 		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	shortlog_init(&log);
 	repo_init_revisions(the_repository, &rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 525b231d87e..1ab7db9d2ca 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -710,7 +710,7 @@ int cmd_show_branch(int ac,
 
 	init_commit_name_slab(&name_slab);
 
-	git_config(git_show_branch_config, NULL);
+	repo_config(the_repository, git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_args.nr) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 117709cb076..414e55b92d5 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -324,7 +324,7 @@ struct repository *repo UNUSED)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b27..8c333b3e2e1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1082,7 +1082,7 @@ int cmd_sparse_checkout(int argc,
 			     builtin_sparse_checkout_options,
 			     builtin_sparse_checkout_usage, 0);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/stash.c b/builtin/stash.c
index e2f95cc2ebc..821b58a14e5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -979,7 +979,7 @@ static int show_stash(int argc, const char **argv, const char *prefix,
 	int do_usage = 0;
 
 	init_diff_ui_defaults();
-	git_config(git_diff_ui_config, NULL);
+	repo_config(the_repository, git_diff_ui_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
@@ -2358,7 +2358,7 @@ int cmd_stash(int argc,
 	const char **args_copy;
 	int ret;
 
-	git_config(git_stash_config, NULL);
+	repo_config(the_repository, git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index e147f3ff92c..4a566cbc5de 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -55,7 +55,7 @@ int cmd_stripspace(int argc,
 
 	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
 		setup_git_directory_gently(&nongit);
-		git_config(git_default_config, NULL);
+		repo_config(the_repository, git_default_config, NULL);
 	}
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d8a6fa47e59..89ee09abea6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -649,7 +649,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		     "--ignore-submodules=dirty", "--quiet", "--",
 		     path, NULL);
 
-	git_config(git_diff_basic_config, NULL);
+	repo_config(the_repository, git_diff_basic_config, NULL);
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
@@ -1108,7 +1108,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	if (info->argc)
 		strvec_pushv(&diff_args, info->argv);
 
-	git_config(git_diff_basic_config, NULL);
+	repo_config(the_repository, git_diff_basic_config, NULL);
 	repo_init_revisions(the_repository, &rev, info->prefix);
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
@@ -2830,7 +2830,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 	};
 
 	update_clone_config_from_gitmodules(&opt.max_jobs);
-	git_config(git_update_clone_config, &opt.max_jobs);
+	repo_config(the_repository, git_update_clone_config, &opt.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 		NULL
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	track = git_branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 299d23d76a8..5c4623067c5 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -59,7 +59,7 @@ int cmd_symbolic_ref(int argc,
 		OPT_END(),
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
 	if (msg && !*msg)
diff --git a/builtin/tag.c b/builtin/tag.c
index 46cbf892e34..25f30e3f9be 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -546,7 +546,7 @@ int cmd_tag(int argc,
 	 * Try to set sort keys from config. If config does not set any,
 	 * fall back on default (refname) sorting.
 	 */
-	git_config(git_tag_config, &sorting_options);
+	repo_config(the_repository, git_tag_config, &sorting_options);
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 4360872ae07..ae871adc909 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -43,7 +43,7 @@ int cmd_unpack_file(int argc,
 	if (repo_get_oid(the_repository, argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	puts(create_temp_file(&oid));
 	return 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a69d59eb50c..26aa885da92 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -621,7 +621,7 @@ int cmd_unpack_objects(int argc,
 
 	disable_replace_refs();
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	quiet = !isatty(2);
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 0c1d4ed55be..2380f3ccd68 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1103,7 +1103,7 @@ int cmd_update_index(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 update_index_usage, options);
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	prepare_repo_settings(r);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1e6131e04ad..cb936643243 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -769,7 +769,7 @@ int cmd_update_ref(int argc,
 		OPT_END(),
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_update_ref_usage,
 			     0);
 	if (msg && !*msg)
diff --git a/builtin/var.c b/builtin/var.c
index ada642a9fe5..beeac12dccf 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -226,11 +226,11 @@ int cmd_var(int argc,
 		usage(var_usage);
 
 	if (strcmp(argv[1], "-l") == 0) {
-		git_config(show_config, NULL);
+		repo_config(the_repository, show_config, NULL);
 		list_vars();
 		return 0;
 	}
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	git_var = get_git_var(argv[1]);
 	if (!git_var)
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 34e4ed715f3..d9f66f5e767 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -81,7 +81,7 @@ int cmd_verify_pack(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, verify_pack_options,
 			     verify_pack_usage, 0);
 	if (argc < 1)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2dceeeed8bd..b1306248dec 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1448,7 +1448,7 @@ int cmd_worktree(int ac,
 		OPT_END()
 	};
 
-	git_config(git_worktree_config, NULL);
+	repo_config(the_repository, git_worktree_config, NULL);
 
 	if (!prefix)
 		prefix = "";
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index cfec044710a..3465c70a48a 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -43,7 +43,7 @@ int cmd_write_tree(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
diff --git a/config.h b/config.h
index 29a02774837..6b729fc6bbf 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline void git_config(config_fn_t fn, void *data)
-{
-	repo_config(the_repository, fn, data);
-}
-
 static inline void git_config_clear(void)
 {
 	repo_config_clear(the_repository);
diff --git a/connect.c b/connect.c
index e77287f426c..4b1dc65e5ce 100644
--- a/connect.c
+++ b/connect.c
@@ -1028,7 +1028,7 @@ static int git_proxy_command_options(const char *var, const char *value,
 static int git_use_proxy(const char *host)
 {
 	git_proxy_command = getenv("GIT_PROXY_COMMAND");
-	git_config(git_proxy_command_options, (void*)host);
+	repo_config(the_repository, git_proxy_command_options, (void*)host);
 	return (git_proxy_command && *git_proxy_command);
 }
 
diff --git a/contrib/coccinelle/config_fn_ctx.pending.cocci b/contrib/coccinelle/config_fn_ctx.pending.cocci
index 6d3d1000a96..54f09fcbcde 100644
--- a/contrib/coccinelle/config_fn_ctx.pending.cocci
+++ b/contrib/coccinelle/config_fn_ctx.pending.cocci
@@ -83,7 +83,7 @@ int fn(const char *C1, const char *C2,
 
 
 // The previous rules don't catch all callbacks, especially if they're defined
-// in a separate file from the git_config() call. Fix these manually.
+// in a separate file from the repo_config() call. Fix these manually.
 @@
 identifier C1, C2, D;
 attribute name UNUSED;
diff --git a/convert.c b/convert.c
index b5f7cf6306c..c7d6a85c226 100644
--- a/convert.c
+++ b/convert.c
@@ -1326,7 +1326,7 @@ void convert_attrs(struct index_state *istate,
 					 "eol", "text", "working-tree-encoding",
 					 NULL);
 		user_convert_tail = &user_convert;
-		git_config(read_convert_config, NULL);
+		repo_config(the_repository, read_convert_config, NULL);
 	}
 
 	git_check_attr(istate, path, check);
diff --git a/fetch-pack.c b/fetch-pack.c
index 01d3699c4b7..11344206f73 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1916,7 +1916,7 @@ static void fetch_pack_config(void)
 		}
 	}
 
-	git_config(fetch_pack_config_cb, NULL);
+	repo_config(the_repository, fetch_pack_config_cb, NULL);
 }
 
 static void fetch_pack_setup(void)
diff --git a/fsck.h b/fsck.h
index 0c5869ac34e..dd7df3d5b36 100644
--- a/fsck.h
+++ b/fsck.h
@@ -287,7 +287,7 @@ const char *fsck_describe_object(struct fsck_options *options,
 
 struct key_value_info;
 /*
- * git_config() callback for use by fsck-y tools that want to support
+ * repo_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
  */
 int git_fsck_config(const char *var, const char *value,
diff --git a/gpg-interface.c b/gpg-interface.c
index bdcc8c2a2ed..bc0c21ebab1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -25,7 +25,7 @@ static void gpg_interface_lazy_init(void)
 	if (done)
 		return;
 	done = 1;
-	git_config(git_gpg_config, NULL);
+	repo_config(the_repository, git_gpg_config, NULL);
 }
 
 static char *configured_signing_key;
diff --git a/help.c b/help.c
index 652efebf00c..db62cda4442 100644
--- a/help.c
+++ b/help.c
@@ -332,7 +332,7 @@ static int get_colopts(const char *var, const char *value,
 void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 {
 	unsigned int colopts = 0;
-	git_config(get_colopts, &colopts);
+	repo_config(the_repository, get_colopts, &colopts);
 
 	if (main_cmds->cnt) {
 		const char *exec_path = git_exec_path();
@@ -502,7 +502,7 @@ static void list_all_cmds_help_aliases(int longest)
 	struct cmdname_help *aliases;
 	int i;
 
-	git_config(get_alias, &alias_list);
+	repo_config(the_repository, get_alias, &alias_list);
 	string_list_sort(&alias_list);
 
 	for (i = 0; i < alias_list.nr; i++) {
diff --git a/http-fetch.c b/http-fetch.c
index 02ab80533f0..17b9fe4ff8c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -150,7 +150,7 @@ int cmd_main(int argc, const char **argv)
 
 	trace2_cmd_name("http-fetch");
 
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	if (packfile) {
 		if (!index_pack_args.nr)
diff --git a/http.c b/http.c
index 9b62f627dc5..d94e8f63b57 100644
--- a/http.c
+++ b/http.c
@@ -1315,7 +1315,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	http_is_verbose = 0;
 	normalized_url = url_normalize(url, &config.url);
 
-	git_config(urlmatch_config_entry, &config);
+	repo_config(the_repository, urlmatch_config_entry, &config);
 	free(normalized_url);
 	string_list_clear(&config.vars, 1);
 
diff --git a/imap-send.c b/imap-send.c
index f5a656ac71d..9b26c669c01 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1776,7 +1776,7 @@ int cmd_main(int argc, const char **argv)
 	int ret;
 
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, &server);
+	repo_config(the_repository, git_imap_config, &server);
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
diff --git a/ls-refs.c b/ls-refs.c
index e28c8413758..c47acde07f3 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -159,7 +159,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	strbuf_init(&data.buf, 0);
 	strvec_init(&data.hidden_refs);
 
-	git_config(ls_refs_config, &data);
+	repo_config(the_repository, ls_refs_config, &data);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
diff --git a/merge-ll.c b/merge-ll.c
index b2dc26da4fe..fafe2c91971 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -357,7 +357,7 @@ static void initialize_ll_merge(void)
 	if (ll_user_merge_tail)
 		return;
 	ll_user_merge_tail = &ll_user_merge;
-	git_config(read_merge_config, NULL);
+	repo_config(the_repository, read_merge_config, NULL);
 }
 
 static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr)
diff --git a/merge-ort.c b/merge-ort.c
index 473ff61e36e..49aa37a8f23 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5387,7 +5387,7 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 			free(value);
 		}
 	}
-	git_config(git_xmerge_config, NULL);
+	repo_config(the_repository, git_xmerge_config, NULL);
 }
 
 static void init_merge_options(struct merge_options *opt,
diff --git a/notes-utils.c b/notes-utils.c
index ac66b82dd31..6a50c6d5646 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -162,7 +162,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		c->refs_from_env = 1;
 		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
 	}
-	git_config(notes_rewrite_config, c);
+	repo_config(the_repository, notes_rewrite_config, c);
 	if (!c->enabled || !c->refs->nr) {
 		string_list_clear(c->refs, 0);
 		free(c->refs);
diff --git a/notes.c b/notes.c
index 97b995f3f2d..49393fbfd8d 100644
--- a/notes.c
+++ b/notes.c
@@ -1123,7 +1123,7 @@ void load_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}
 
-	git_config(notes_display_config, &load_config_refs);
+	repo_config(the_repository, notes_display_config, &load_config_refs);
 
 	if (opt) {
 		struct string_list_item *item;
diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a8..cee96b9d94d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -141,7 +141,7 @@ static void setup_commit_formats(void)
 	COPY_ARRAY(commit_formats, builtin_formats,
 		   ARRAY_SIZE(builtin_formats));
 
-	git_config(git_pretty_formats_config, NULL);
+	repo_config(the_repository, git_pretty_formats_config, NULL);
 }
 
 static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec1..5134781d52d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -386,7 +386,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.lock_timeout_ms = 100;
 	refs->write_options.fsync = reftable_be_fsync;
 
-	git_config(reftable_be_config, &refs->write_options);
+	repo_config(the_repository, reftable_be_config, &refs->write_options);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
diff --git a/rerere.c b/rerere.c
index 8bb97c98229..1ac2075144c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -879,7 +879,7 @@ static void git_rerere_config(void)
 {
 	git_config_get_bool("rerere.enabled", &rerere_enabled);
 	git_config_get_bool("rerere.autoupdate", &rerere_autoupdate);
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 }
 
 static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
@@ -1247,7 +1247,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 				       &cutoff_resolve, now);
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
 				       &cutoff_noresolve, now);
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
 	if (!dir)
 		die_errno(_("unable to open rr-cache directory"));
diff --git a/revision.c b/revision.c
index 0ca6a297a6b..ad63c100eb9 100644
--- a/revision.c
+++ b/revision.c
@@ -1636,7 +1636,7 @@ void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *section)
 	cb.exclusions = exclusions;
 	cb.section = section;
 
-	git_config(hide_refs_config, &cb);
+	repo_config(the_repository, hide_refs_config, &cb);
 }
 
 struct all_refs_cb {
diff --git a/scalar.c b/scalar.c
index 0dc79fa9fb0..3b713abca3c 100644
--- a/scalar.c
+++ b/scalar.c
@@ -713,7 +713,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 			    maintenance_str);
 	}
 
-	git_config(get_scalar_repos, &scalar_repos);
+	repo_config(the_repository, get_scalar_repos, &scalar_repos);
 
 	for (size_t i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
diff --git a/sequencer.c b/sequencer.c
index 67e4310edcf..df207f33e07 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -327,7 +327,7 @@ static int git_sequencer_config(const char *k, const char *v,
 void sequencer_init_config(struct replay_opts *opts)
 {
 	opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-	git_config(git_sequencer_config, opts);
+	repo_config(the_repository, git_sequencer_config, opts);
 }
 
 static inline int is_rebase_i(const struct replay_opts *opts)
diff --git a/setup.c b/setup.c
index 6f52dab64ca..91a3affdd8f 100644
--- a/setup.c
+++ b/setup.c
@@ -2339,7 +2339,7 @@ static int create_default_files(const char *template_path,
 	copy_templates(template_path);
 	git_config_clear();
 	repo_settings_reset_shared_repository(the_repository);
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	reinit = is_reinit();
 
@@ -2610,7 +2610,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * have set up the repository format such that we can evaluate
 	 * includeIf conditions correctly in the case of re-initialization.
 	 */
-	git_config(platform_core_config, NULL);
+	repo_config(the_repository, platform_core_config, NULL);
 
 	safe_create_dir(the_repository, git_dir, 0);
 
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 6967c8e25c6..77c15a46cfa 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -11,7 +11,7 @@ int cmd__advise_if_enabled(int argc, const char **argv)
 		die("usage: %s <advice>", argv[0]);
 
 	setup_git_directory();
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	/*
 	 * Any advice type can be used for testing, but NESTED_TAG was
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 75e028ab2a0..41ba8647900 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -32,10 +32,10 @@
  * 				ascending order of priority from a config_set
  * 				constructed from files entered as arguments.
  *
- * iterate -> iterate over all values using git_config(), and print some
+ * iterate -> iterate over all values using repo_config(), and print some
  *            data for each
  *
- * git_config_int -> iterate over all values using git_config() and print the
+ * git_config_int -> iterate over all values using repo_config() and print the
  *                   integer value for the entered key or die
  *
  * Examples:
@@ -218,10 +218,10 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "iterate")) {
-		git_config(iterate_cb, NULL);
+		repo_config(the_repository, iterate_cb, NULL);
 		goto exit0;
 	} else if (argc == 3 && !strcmp(argv[1], "git_config_int")) {
-		git_config(parse_int_cb, (void *) argv[2]);
+		repo_config(the_repository, parse_int_cb, (void *) argv[2]);
 		goto exit0;
 	}
 
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index e277dde8e71..b2da48eda05 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -19,7 +19,7 @@ int cmd__read_cache(int argc, const char **argv)
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
-	git_config(git_default_config, NULL);
+	repo_config(the_repository, git_default_config, NULL);
 
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(the_repository);
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 94c48ababbe..aa3a9894d25 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -41,7 +41,7 @@ int cmd__userdiff(int argc, const char **argv)
 
 	if (want & USERDIFF_DRIVER_TYPE_CUSTOM) {
 		setup_git_directory();
-		git_config(cmd__userdiff_config, NULL);
+		repo_config(the_repository, cmd__userdiff_config, NULL);
 	}
 
 	for_each_userdiff_driver(driver_cb, &want);
diff --git a/t/t4256/1/mailinfo.c b/t/t4256/1/mailinfo.c
index b395adbdf2a..39caeba8653 100644
--- a/t/t4256/1/mailinfo.c
+++ b/t/t4256/1/mailinfo.c
@@ -1214,7 +1214,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
-	git_config(git_mailinfo_config, mi);
+	repo_config(the_repository, git_mailinfo_config, mi);
 }
 
 void clear_mailinfo(struct mailinfo *mi)
diff --git a/t/t4256/1/mailinfo.c.orig b/t/t4256/1/mailinfo.c.orig
index 3281a37d518..b76eb866aae 100644
--- a/t/t4256/1/mailinfo.c.orig
+++ b/t/t4256/1/mailinfo.c.orig
@@ -1154,7 +1154,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
-	git_config(git_mailinfo_config, mi);
+	repo_config(the_repository, git_mailinfo_config, mi);
 }
 
 void clear_mailinfo(struct mailinfo *mi)
diff --git a/trailer.c b/trailer.c
index 310cf582dc3..911a81ed993 100644
--- a/trailer.c
+++ b/trailer.c
@@ -595,8 +595,8 @@ void trailer_config_init(void)
 	default_conf_info.where = WHERE_END;
 	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
 	default_conf_info.if_missing = MISSING_ADD;
-	git_config(git_trailer_default_config, NULL);
-	git_config(git_trailer_config, NULL);
+	repo_config(the_repository, git_trailer_default_config, NULL);
+	repo_config(the_repository, git_trailer_config, NULL);
 	configured = 1;
 }
 
diff --git a/transport.c b/transport.c
index c123ac1e38b..a246afd09fa 100644
--- a/transport.c
+++ b/transport.c
@@ -202,7 +202,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 
-	git_config(fetch_fsck_config_cb, &msg_types);
+	repo_config(the_repository, fetch_fsck_config_cb, &msg_types);
 	opts.fsck_msg_types = msg_types.buf;
 
 	ret = unbundle(the_repository, &data->header, data->fd,

-- 
2.50.1.465.gcb3da1c9e6.dirty

