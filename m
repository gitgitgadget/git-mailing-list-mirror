Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26552472B6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300786; cv=none; b=JawIAjGOG+EvIUUMibTO6q15XBYNEdZibgAJ3RBs2bZ9HyA0YAU2Ny2A2kbZBLa77KiZ6K2zltHxsryOrjfqKmLfhoTuA52VELLOEjRwyzN2BL2PalgWXW8+jhwgxaMRWR2TBBkYuYSXe1ZQhV6KtZgA2lSLujVxFcAWd7TQ2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300786; c=relaxed/simple;
	bh=P0+noIkRnjcph3GJV0M85jTlcftszkJ13+E+gs/Ampg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFm91tq0XXDIgDztgegoKnhpX4f1CofGhbanp3IQcv0teGB87yidLMXcbi7uYWIEVCKEKepjOBzT46In+lmwblypfYOgBwu/94zKJZlfeoioFSKGgsnxtso6IKPZl3D634uT/tlBfjATeojSUH3dwYpxTOCO0Y3OoxX5gPEnS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JOObaEmI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF/MUgkl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JOObaEmI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF/MUgkl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DD7171D00101;
	Mon,  4 Aug 2025 05:46:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 05:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300783;
	 x=1754387183; bh=bG27w0nnnr3BRz9T4gxAaYbUYZ4lk6X4Uzm9knYBrkE=; b=
	JOObaEmIAdsQz/R3H4+icESV/9wCQjKqv+U6zdGBzkz99JjNq4LExtrqABJTvncw
	lAfMyMH3Yrkr5H0jhnOeN6b9ccqCxv3+BnnyQSfHxV6sXpak5uX2VeSizoNRLWLM
	NXoUqMb/6oFZq09KaAc+ns1e2kfMZoS7WoIISn55gtdIhtF+RjZfIy8uvdtA4Rnd
	zI3hMGnuqyKsJisu+oEG90v5inYkqjeDy0II8itFVeQnm4IKQGj63rBlo+asYwCX
	ksiWyAt0V1/Um7A+xiy3ZynVHFQhoeDWQNa+eJJ/2p1LGphcEwH8rQoegIcWFtHI
	V6sqLxvBwH4o4Vq7KzxcFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300783; x=
	1754387183; bh=bG27w0nnnr3BRz9T4gxAaYbUYZ4lk6X4Uzm9knYBrkE=; b=E
	F/MUgkl+jVJkcd0xD9v26gWW3sFZw3IOMxBAdD1OEo1gHzo2jRF9ZRhg6c5NYCLd
	tnsQ26FuzR9XfQHXBJ9yGdpmImRJtiDQhpvkNK8e3H57sSAmkUXT/Uqso65+7mTh
	B489G2knjE3VkqwSUxdE1BZjU5wsUSY4/9kZuoozZNDRB8B++Wh7oj7y3IvBu6FX
	71VdD0pZQwfPbxtiZr8yIjLHUnF4gfqxETxarWms6SbX+CFA8bye5wrtLx5QGFty
	fRtden0S9ZxuW98GVPajG1cjFgA9nNT8NhaA9P3h/FH/I1ZJVqC0BptOson3GG3O
	p4DZmdvZhaGxmFz+zN0Gg==
X-ME-Sender: <xms:b4GQaPvtW7RpzH3CHxK6RlmD9s5FH3GHtBWhukWsTNGA0PbwB5h5qA>
    <xme:b4GQaNWqdffvI_-Yz8RCGmvrPvZa2Pwydvh97BDqP6myaPdWZaAhZ5UWAArQtHyu9
    gqLDRSFqOWYbgNjVg>
X-ME-Received: <xmr:b4GQaCjQfVS9VMonpXX_iFubsMGrHNnOep7MOTK7wPYhv56k1RfxJvnIAiAxaZqxIs3VjKWVYaWp935RdySBDW9SC8bPtMF9mCOnS4Rz1TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:b4GQaNrA9RizKWGpW6gcK2qzb69jcJio1yQNzNacQ31b7WryR2wdyA>
    <xmx:b4GQaAGvgFKpzfrO9JRGCksn0s5Yxh5zRffvnr8AFeglUuDrM3OhuQ>
    <xmx:b4GQaK5l-LniPQFDcmqxnEr68JHuqtC3hSjT4peqZMhtqF7RVnQkEw>
    <xmx:b4GQaAeGUXK02eGxl8GSNyPcwiWJL_GuRBxHk00qMRwrZ1-IwYDVCQ>
    <xmx:b4GQaCy3B6_xNyf_qi2ls-ZaLqZw4RcceLD-bAWn8faeKGApEAFSXuR6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f1138f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:04 +0200
Subject: [PATCH v4 4/9] builtin/reflog: implement subcommand to write new
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-4-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
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
 builtin/reflog.c              |  65 +++++++++++++++++++++
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 128 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index c3801b82fb..34232a539a 100644
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
index b00b3f9edc..a1b4e02204 100644
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
index d052fc3e23..adcdf09e74 100644
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
index 0000000000..dd7ffa5241
--- /dev/null
+++ b/t/t1421-reflog-write.sh
@@ -0,0 +1,128 @@
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
+		test_commit initial &&
+		abbreviated_oid=$(git rev-parse HEAD | test_copy_bytes 8) &&
+		test_must_fail git reflog write refs/heads/something $abbreviated_oid $ZERO_OID old-object-id 2>err &&
+		test_grep "invalid old object ID" err &&
+		test_must_fail git reflog write refs/heads/something $ZERO_OID $abbreviated_oid new-object-id 2>err &&
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
2.50.1.723.g3e08bea96f.dirty

