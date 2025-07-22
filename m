Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DE23814C
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183282; cv=none; b=UMUfFgDzMZ8Jf5GP79j+TB67c1mHaZAdFo3Q88JK5MBuI+jRvGK+MaNVg2/k95y25DmwVh/jAxXCPda1R7aA3OE4n3SlZPl7W/rmijULYTKQ2VEqFc2gZztLzlLZxJJJvbA0n7EhXsTEdeLaysY46RbeXGMgyhMg/PO6OrnvUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183282; c=relaxed/simple;
	bh=Rqj0zXJyDq9QrAuHgfWYhC/m6FOPMQaUyh4p58jeTWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXpNmCgAI3FFSqdZogWSQXzVl8zI+PMZBP2w1I+uFTznmZajtH3f8frRtWoC7nV/KQxvY+26YHeGFf5OUkgbg9mefkoUz99UzhVgUGWKVIppRFXEqaph+vcxpDxPft4NIrLKgGb8iECeqPhlLTASlA5jUZ7cmXRU2OwJs/roaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PDxuqL9O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvH66vbq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PDxuqL9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvH66vbq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E0641D0020E;
	Tue, 22 Jul 2025 07:21:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 22 Jul 2025 07:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183276;
	 x=1753269676; bh=UwZ+YUrmF1RGDjDMnyfHhx1XjBA+o20wnFFZ7goSlnc=; b=
	PDxuqL9OjfjNJqoq/l2OyGMV8eo9T8jD4FTlqviU6mqYzcZvJ7vaB5TBhpbJHKp1
	MMgzp8aAR3PVgIySpEdL4nF7zVaN2UvBxhJQZ80ongxYeDunG8z/0yoymuADBvKe
	TTQDyavx10BjWYXXigwr/90xpYhYuAQTUtns4LVh4vtRbS8sjEi/FRskjAM9jPxM
	EF7tFSLHWerOg+DsmLmhkyBchpdcW/V0TOiEvNo3BngNDJcTe8kHhq8/iTV5Mbxt
	lpbVm19SgOvEJT9fe9OTRjbT+xGJmAUdguMxYhxTHXz+ZbqMZhzWKdv7oz9QbPN5
	aA+ylA7jtVpdWvicw23skA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183276; x=
	1753269676; bh=UwZ+YUrmF1RGDjDMnyfHhx1XjBA+o20wnFFZ7goSlnc=; b=A
	vH66vbqFKBVtqeq0WmwTaPD01YgS6NkKA7swvnhV4oN9QNzAevAldy8Ds13FyQ33
	sKwaPmanKU/Lhr/REz3DREdzGtYGu1uDgfmMPq19qLHBjWGtNWVlV5sn30YawVf7
	czFEwRWnnb4Bhe1fh9nJp2Vwnjcv1/zomyoc3ehrH2TW9OrdPBFj3sw+GnvtAO+s
	3syDLxMNOlV+sUlKDoftVUM+/cGPDHiUpZDvqCSUkainTvUzR++ulpi3VZrpFz1m
	alknCKGI9YRfJKroScl//tw9ZwoOveJwqlj9rmNUAbDBwnmdWuN8PbSQszaDVpy+
	uCdxzv3EhjgxdbET9+WHA==
X-ME-Sender: <xms:LHR_aHkOAqyWGU8PgoiLDgAJ-3LSjlZGxsEHhXdPxucUqhPmccDgQQ>
    <xme:LHR_aLDVtY9cw7C7Qct2kqFhFdzVxKMPz15cb4UlcQbqwx_Q42b_z4-AfJxC3qZSY
    5L3C2LfF1TE8RD4ag>
X-ME-Received: <xmr:LHR_aPdkglSBbwDoZH6EIEFWthzAvexfUtyOBQ--w8bF0WOy1bdpiynHrwPLIh6Fgpqttld4gJ5HPZaKVGvC9NEGEf0Sty97_gx1JFrVjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LHR_aOJktVFP2mhv3s_Eq25SDcetdpPpD9oLtpALF1SoG-AiZ1tZHQ>
    <xmx:LHR_aKfrzlxeaozVtQquO99260WYsnCBrmV6p9fdfNcUqZR4-vylRA>
    <xmx:LHR_aN0SW1fz9wu-_zlg9s7uhler9FCqTprVWYJVwQ1hTZ2YcIc-DA>
    <xmx:LHR_aLiNR8DwB4hpS6W3XOYen3QD5h_p-2ofdDgTd8SzlfnpOyMxbQ>
    <xmx:LHR_aN0ahVwq8bOA5wQIC3TkcBLX7S5Pb_xwjcxUgHBFOPFBQzQH91GE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dace158f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:53 +0200
Subject: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
 Documentation/git-reflog.adoc |  1 +
 builtin/reflog.c              | 65 ++++++++++++++++++++++++++++++++++
 t/meson.build                 |  1 +
 t/t1421-reflog-write.sh       | 81 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 6ae13e772b8..798dbc0a00a 100644
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
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b00b3f9edc9..d0374295620 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -3,6 +3,8 @@
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
+#include "hex.h"
+#include "odb.h"
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
+	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
+	if (argc != 4)
+		usage_with_options(reflog_write_usage, options);
+
+	ref = argv[0];
+	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
+		die(_("invalid reference name: %s"), ref);
+
+	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
+	if (ret)
+		die(_("invalid old object ID: '%s'"), argv[1]);
+	if (!is_null_oid(&old_oid) && !odb_has_object(repo->objects, &old_oid, 0))
+		die(_("old object '%s' does not exist"), argv[1]);
+
+	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
+	if (ret)
+		die(_("invalid new object ID: '%s'"), argv[2]);
+	if (!is_null_oid(&new_oid) && !odb_has_object(repo->objects, &new_oid, 0))
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
index 1af289425d4..d68f5e24dbe 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -219,6 +219,7 @@ integration_tests = [
   't1418-reflog-exists.sh',
   't1419-exclude-refs.sh',
   't1420-lost-found.sh',
+  't1421-reflog-write.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
new file mode 100755
index 00000000000..e284f42178f
--- /dev/null
+++ b/t/t1421-reflog-write.sh
@@ -0,0 +1,81 @@
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
+test_expect_success 'nonexistent old object ID' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write refs/heads/something $(test_oid deadbeef) $ZERO_OID first 2>err &&
+		test_grep "old object .* does not exist" err
+	)
+'
+
+test_expect_success 'nonexistent new object ID' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog write refs/heads/something $ZERO_OID $(test_oid deadbeef) first 2>err &&
+		test_grep "new object .* does not exist" err
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
+		test_reflog_matches . refs/heads/something <<-EOF
+		$ZERO_OID $COMMIT_OID $SIGNATURE	first
+		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
+		EOF
+	)
+'
+
+test_done

-- 
2.50.1.465.gcb3da1c9e6.dirty

