Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7928643C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779344; cv=none; b=MWo4aHFexgBpXws9PGh4IqHBMSnhIZWR+sn9Zo26LXhfBFfuqB7vp2sSmOmRGm6hWSyh3UWe2l8njWWTHamo/sWhudsyVhasW51MkcysqlCsT3BzxWZZ99ptv/gJkD33nvSKWTVEvPHv87ZPgMm46w2JLv9TSrM/mNkXiYEHwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779344; c=relaxed/simple;
	bh=1it5grLaBJRlukg4BjFccHedZt6/2WkbXQC9I9/YqwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJEbAiHQRx33rQ1ojHCM5xUYyo+51qfPtnTa5c28TBi4ir4+SC51RKlSpNiHMu18BrRwmPB/s45+eR1A9Ecr4lAg5YYMze/WVN7eSokmkIwbb/HxhSJZ5Po30o4O0X3xbXJTjDWohbMBp9dSijpB9jJxJ/tBg54h3Ap3R4Al6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kFnLRnKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6aulota; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kFnLRnKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6aulota"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EE2A7A0A7A;
	Tue, 29 Jul 2025 04:55:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Jul 2025 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779340;
	 x=1753865740; bh=ENw3IS3bKIInOgyJp9n8kT7nfXMHWMyjGg/9dlaPkdY=; b=
	kFnLRnKvUnT24+SCWOAiHs981ae2Du/8YIAXI/0gQ9CND45UfGOotHZ6GAhE6iZr
	x3IQwXYfOueTMoUVBoxPFs9AjLfbqfpLLBl48+HeTFiPTKgo4jgZBdCxPjncN5HS
	00cGSlyDNutIXg8AijVoTIRCnOYom0ifWmUSbgTFtDaWUwQFJICQGrtKnVxOYA07
	Mu2CL7osYs6guryTifytms6Qyeaob25RIgz8zm2gycdAl9GGAnfh5/YuTBjCdVlU
	acOL7BBdLkbgvUnBI2f1Cz9soMlSn3YxSuLCfyvyBwjIecxiEDAAPo7/GUcMMD2f
	XPLhy6pltjiWDH+rLfs5bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779340; x=
	1753865740; bh=ENw3IS3bKIInOgyJp9n8kT7nfXMHWMyjGg/9dlaPkdY=; b=F
	6aulota59GvedkUQYyarj91w9oSENMYUq8JwUhYccQ6DtECpLOJDSMMaOice/5nz
	LIZoui1pXlUIwdgnVbeaPgGQ/mQXAiDjymY9uxX7KDFAZe8rjd4ZBXrXLmy4DuDE
	AkrxvzZasiocGojbYyiEU/6K3trB5qhwr1Mil8shs9ejnUsbyPbxht4gE1K16ak0
	slXzzxW0Kfdk/cYF785Ejvj8bLF/srEd1ndhYK5imEXX96zKhsYqXPhRuDkYv0HA
	yRuvMyYtGwRF2MnPtv7gHcG6qw8A+s/Slg2A2v1H4p3l/iNZviJnI87on0950IaP
	Xgsd9Fy5lq2xpqwJj+Y/Q==
X-ME-Sender: <xms:i4yIaE58NjA64o4ft1YKFSLimXSS7_4r3ZmKH1gP4Cm9FSSq9jDxPA>
    <xme:i4yIaCzW5j1CsEZRxbvCDQCPjT-G0cG31w-Cwv0DV3PFBcPEJXnYlE8-mscGkGISX
    bKkLfFq4BiuObe9gw>
X-ME-Received: <xmr:i4yIaDNu0WUUy5fsNpUwb0SSrMvMICfZwvnK08sItgkNcRuVUa64xCRWVhvJg69K1Nbn5a_B2__I0f7OUSNIS8U6Q2ZdgQgTpE9ji2JnJ5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:i4yIaIntsdXkS2-Q5ChTP83n21fo4gO3hVq8Yuua42MTz-SpeGN4Gg>
    <xmx:i4yIaITvGLKuH9yieJ-OwTcl5HDYoEY4MaCA9N2e4FJgg1xU5j4xjw>
    <xmx:i4yIaHWPhUo9Fwali4UyI2Sqz0uAEUsBXWMiGFpTu3sRILkomXYcyg>
    <xmx:i4yIaMIZaedHyGv6Fzv5_cV5I_2_zU7t1j3PLD1hpLNDfoh4W5vK-Q>
    <xmx:jIyIaDtFIH9j1JOeWlzwpKAankDNmRwqH5nSIU4dTwE0zcqhmcDFClKx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8470425e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:22 +0200
Subject: [PATCH v3 4/9] builtin/reflog: implement subcommand to write new
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-4-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

While we provide a couple of subcommands in git-reflog(1) to remove
reflog entries, we don't provide any to write new entries. Obviously
this is not an operation that really would be needed for many use cases
out there, or otherwise people would have complained that such a command
does not exist yet. But the introduction of the "reftable" backend
changes the picture a bit, as it is now basically impossible to manually
append a reflog entry if one wanted to do so due to the binary format.

Plug this gap by introducing a simple "write" subcommand. For now, all
this command does is to append a single new reflog entry with the given
object IDs and message to the reflog. More specifically, it is not yet
possible to:

  - Write multiple reflog entries at once.

  - Insert reflog entries at arbitrary indices.

  - Specify the date of the reflog entry.

  - Insert reflog entries that refer to nonexistent objects.

If required, those features can be added at a future point in time. For
now though, the new command aims to fulfill the most basic use cases
while being as strict as possible when it comes to verifying parameters.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc |   7 +++
 builtin/reflog.c              |  65 ++++++++++++++++++++++
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 126 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index c3801b82fb6..34232a539a7 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 git reflog [show] [<log-options>] [<ref>]
 git reflog list
 git reflog exists <ref>
+git reflog write <ref> <old-oid> <new-oid> <message>
 git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 git reflog drop [--all [--single-worktree] | <refs>...]
@@ -47,6 +48,12 @@ The "exists" subcommand checks whether a ref has a reflog.  It exits
 with zero status if the reflog exists, and non-zero status if it does
 not.
 
+The "write" subcommand writes a single entry to the reflog of a given
+reference. This new entry is appended to the reflog and will thus become
+the most recent entry. The reference name must be fully qualified. Both the old
+and new object IDs must not be abbreviated and must point to existing objects.
+The reflog message gets normalized.
+
 The "delete" subcommand deletes single entries from the reflog, but
 not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
 reflog delete master@{2}`"). This subcommand is also typically not used
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b00b3f9edc9..a1b4e022041 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -3,6 +3,8 @@
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
+#include "hex.h"
+#include "object-store.h"
 #include "revision.h"
 #include "reachable.h"
 #include "wildmatch.h"
@@ -20,6 +22,9 @@
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
 
+#define BUILTIN_REFLOG_WRITE_USAGE \
+	N_("git reflog write <ref> <old-oid> <new-oid> <message>")
+
 #define BUILTIN_REFLOG_DELETE_USAGE \
 	N_("git reflog delete [--rewrite] [--updateref]\n" \
 	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
@@ -47,6 +52,11 @@ static const char *const reflog_exists_usage[] = {
 	NULL,
 };
 
+static const char *const reflog_write_usage[] = {
+	BUILTIN_REFLOG_WRITE_USAGE,
+	NULL,
+};
+
 static const char *const reflog_delete_usage[] = {
 	BUILTIN_REFLOG_DELETE_USAGE,
 	NULL
@@ -66,6 +76,7 @@ static const char *const reflog_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_LIST_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
+	BUILTIN_REFLOG_WRITE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
 	BUILTIN_REFLOG_DROP_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
@@ -392,6 +403,59 @@ static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
+			    struct repository *repo)
+{
+	const struct option options[] = {
+		OPT_END()
+	};
+	struct object_id old_oid, new_oid;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *tx;
+	const char *ref, *message;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, reflog_write_usage, 0);
+	if (argc != 4)
+		usage_with_options(reflog_write_usage, options);
+
+	ref = argv[0];
+	if (!is_root_ref(ref) && check_refname_format(ref, 0))
+		die(_("invalid reference name: %s"), ref);
+
+	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
+	if (ret)
+		die(_("invalid old object ID: '%s'"), argv[1]);
+	if (!is_null_oid(&old_oid) && !has_object(the_repository, &old_oid, 0))
+		die(_("old object '%s' does not exist"), argv[1]);
+
+	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
+	if (ret)
+		die(_("invalid new object ID: '%s'"), argv[2]);
+	if (!is_null_oid(&new_oid) && !has_object(the_repository, &new_oid, 0))
+		die(_("new object '%s' does not exist"), argv[2]);
+
+	message = argv[3];
+
+	tx = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
+	if (!tx)
+		die(_("cannot start transaction: %s"), err.buf);
+
+	ret = ref_transaction_update_reflog(tx, ref, &new_oid, &old_oid,
+					    git_committer_info(0),
+					    message, 0, &err);
+	if (ret)
+		die(_("cannot queue reflog update: %s"), err.buf);
+
+	ret = ref_transaction_commit(tx, &err);
+	if (ret)
+		die(_("cannot commit reflog update: %s"), err.buf);
+
+	ref_transaction_free(tx);
+	strbuf_release(&err);
+	return 0;
+}
+
 /*
  * main "reflog"
  */
@@ -405,6 +469,7 @@ int cmd_reflog(int argc,
 		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
 		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
+		OPT_SUBCOMMAND("write", &fn, cmd_reflog_write),
 		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
 		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
diff --git a/t/meson.build b/t/meson.build
index d052fc3e23d..adcdf09e740 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -220,6 +220,7 @@ integration_tests = [
   't1418-reflog-exists.sh',
   't1419-exclude-refs.sh',
   't1420-lost-found.sh',
+  't1421-reflog-write.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
new file mode 100755
index 00000000000..6cad64f40ab
--- /dev/null
+++ b/t/t1421-reflog-write.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+test_description='Manually write reflog entries'
+
+. ./test-lib.sh
+
+SIGNATURE="C O Mitter <committer@example.com> 1112911993 -0700"
+
+test_reflog_matches () {
+	repo="$1" &&
+	refname="$2" &&
+	cat >actual &&
+	test-tool -C "$repo" ref-store main for-each-reflog-ent "$refname" >expected &&
+	test_cmp expected actual
+}
+
+test_expect_success 'invalid number of arguments' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		for args in "" "1" "1 2" "1 2 3" "1 2 3 4 5"
+		do
+			test_must_fail git reflog write $args 2>err &&
+			test_grep "usage: git reflog write" err || return 1
+		done
+	)
+'
+
+test_expect_success 'invalid refname' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write "refs/heads/ invalid" $ZERO_OID $ZERO_OID first 2>err &&
+		test_grep "invalid reference name: " err
+	)
+'
+
+test_expect_success 'unqualified refname is rejected' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write unqualified $ZERO_OID $ZERO_OID first 2>err &&
+		test_grep "invalid reference name: " err
+	)
+'
+
+test_expect_success 'nonexistent object IDs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write refs/heads/something $(test_oid deadbeef) $ZERO_OID old-object-id 2>err &&
+		test_grep "old object .* does not exist" err &&
+		test_must_fail git reflog write refs/heads/something $ZERO_OID $(test_oid deadbeef) new-object-id 2>err &&
+		test_grep "new object .* does not exist" err
+	)
+'
+
+test_expect_success 'abbreviated object IDs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write refs/heads/something 12345 $ZERO_OID old-object-id 2>err &&
+		test_grep "invalid old object ID" err &&
+		test_must_fail git reflog write refs/heads/something $ZERO_OID 12345 new-object-id 2>err &&
+		test_grep "invalid new object ID" err
+	)
+'
+
+test_expect_success 'reflog message gets normalized' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		COMMIT_OID=$(git rev-parse HEAD) &&
+		git reflog write HEAD $COMMIT_OID $COMMIT_OID "$(printf "message\nwith\nnewlines")" &&
+		git reflog show -1 --format=%gs HEAD >actual &&
+		echo "message with newlines" >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'simple writes' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		COMMIT_OID=$(git rev-parse HEAD) &&
+
+		git reflog write refs/heads/something $ZERO_OID $COMMIT_OID first &&
+		test_reflog_matches . refs/heads/something <<-EOF &&
+		$ZERO_OID $COMMIT_OID $SIGNATURE	first
+		EOF
+
+		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
+		# Note: the old object ID of the second reflog entry is broken.
+		# This will be fixed in subsequent commits.
+		test_reflog_matches . refs/heads/something <<-EOF
+		$ZERO_OID $COMMIT_OID $SIGNATURE	first
+		$ZERO_OID $COMMIT_OID $SIGNATURE	second
+		EOF
+	)
+'
+
+test_expect_success 'can write to root ref' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		COMMIT_OID=$(git rev-parse HEAD) &&
+
+		git reflog write ROOT_REF_HEAD $ZERO_OID $COMMIT_OID first &&
+		test_reflog_matches . ROOT_REF_HEAD <<-EOF
+		$ZERO_OID $COMMIT_OID $SIGNATURE	first
+		EOF
+	)
+'
+
+test_done

-- 
2.50.1.619.g074bbf1d35.dirty

