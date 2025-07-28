Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC426657B
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708149; cv=none; b=oPqCZnRsarT3CMRNRga7e62DAlvEyzovo9DKr8XR8+D3kVnJIj5ZrFQaaf2LWZtZbhltSzdiX93htfOxMSoDoGUT4DKyBUd+42TV/f6Z+Iz607S0upaquGcp5niAmiavA0SBRbQGjX0IHa1xeXAGYpd5njeqGhLrCRsE2op8QF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708149; c=relaxed/simple;
	bh=AU2jGIuJekN0JIGHhrclTUbWDp+wn8evSMXPG3szxfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO47l5zrCLcW3xyanS5VmHxhS8NUqrM6pBC0j3PA0a5c5VnLSQvq8l9cfBrFCbqJftjzthhPsK5U/3IxXj6Q9Qlf7/5HACLcjIBj85kBDQG3RSHfxFGpdT2qY4bFQqYISNTNqU8Dg8d2BtO86pgwfIDRFfQxiUwTEnn7ngYt724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RvhCqGIT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKF/5myt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RvhCqGIT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKF/5myt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7248A140009C;
	Mon, 28 Jul 2025 09:09:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Jul 2025 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753708146;
	 x=1753794546; bh=GYl2pp8f3Nf+phjmBwbCMbfC1BULvtBnU+VW+iNo8A8=; b=
	RvhCqGITCNpa1BDNRr/aL5axZ73QeueWH2fbqwe4PR4YrTWR0m8eeMAQMYOdnWN+
	6U5zi9xlUDceuA05OGHqFPOwAkrXS+2tD7mRlj3pc439rP6X7Q0ZKCTrMMSyHbEx
	gHpm8NCGN/1guM8NsvcGrs/jUARe/WOMn7ie1pZyESufidrHp6Vi27IGURE0LCBN
	1g6A8zG1k59/F1e7Iiw/LHMwp/HIYeshVOmAkgw7tCVr4J+i+G34QUU4MX/iBitw
	YSEnlP0KVjP3hAMC+GmGWNwl+zRfSONNW/I9g5qRQ+MhrHIJcKZYb05L7B7KOjTi
	dXXDj39HC/vTSbsTB3q0Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753708146; x=
	1753794546; bh=GYl2pp8f3Nf+phjmBwbCMbfC1BULvtBnU+VW+iNo8A8=; b=c
	KF/5myt1KHZIss0GdoB7jFkokoeN3890o/sOroH5LO0Iat4s2OpUvN34qcR4t7XB
	RKRokDalxlWeza54YAXX+NWGjy60/hEAMiQneh66s3DFq7qYmMZKo58nwzBQmDyT
	sJz6VvFkwxCPNo3SZ8JUkFvczeEYPZogDEeitTOtxR1hkZaKMMBUgdmasZeXjTrI
	Kuu6vD50+dEaWUfzepq/hALr6/Zi1bdUq6aece3GbU/H5fktMxutudCzPFsjMBSs
	eGDseutK6aJDJhNvbcKyQSHOwRgbhhPbzC7V5VwaSlTaYjI2ugLeBrXk7GIeU3R+
	Hm20PZVlDxrfov8jSK2zQ==
X-ME-Sender: <xms:cnaHaHmeTGlgn9vl4OjPgRJ5vJc2t2oIu35GJkJUvjJj95LbW_VMhA>
    <xme:cnaHaFY9dh_9LJjCcCBxdb3D9XU8G7TMZ7EAeNCwKdTSiPuSYij2UjGZdoLWp2Cxq
    tPZcnq-EGA6bPzA4A>
X-ME-Received: <xmr:cnaHaKNv25iES2HKNXavT6UKgsdg2aHn2mkFQ8pRiWCKs7Gfr9g3AYAaHcgidzCWVWU4UYcDYwf9PTuxdc_fjpEk_7v2TCK8esNWyfrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:cnaHaCYwQC1hIdZLdmIUT9TIdGS8FwmUYdE0x1BN3Z3OOuEgmj7XAg>
    <xmx:cnaHaA3yNJXq8L1qlkKVMKMFWw48N3K7zJHx2SHqJxcGArUMl9T6qA>
    <xmx:cnaHaAfR6QqXbDVUxpgeVpnxdzJyKPeujuffuj-AlySzukZ-xxml_g>
    <xmx:cnaHaJEw-5Yf08_MRc87hSN0qZnJ1TX39a47vQueUs_pX0EmS3RDsQ>
    <xmx:cnaHaGVE-3NWG6-FQXIBhF_0a7qqqKITneMLTxwSfjERnorC-fcIjl9D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:09:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddf41523 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 13:09:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Jul 2025 15:08:47 +0200
Subject: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>
X-Mailer: b4 0.14.2

It was recently reported [1] that renaming a remote that has dangling
symrefs is broken. This issue can be trivially reproduced:

    $ git init repo
    Initialized empty Git repository in /tmp/repo/.git/
    $ cd repo/
    $ git remote add origin /dev/null
    $ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master
    $ git remote rename origin renamed
    $ git symbolic-ref refs/remotes/origin/HEAD
    refs/remotes/origin/master
    $ git symbolic-ref refs/remotes/renamed/HEAD
    fatal: ref refs/remotes/renamed/HEAD is not a symbolic ref

As one can see, the "HEAD" reference did not get renamed but stays in
the same place. There are two issues here:

  - We use `refs_resolve_ref_unsafe()` to resolve references, but we
    don't pass the `RESOLVE_REF_NO_RECURSE` flag. Consequently, if the
    reference does not resolve, the function will fail and we thus
    ignore this branch.

  - We use `refs_for_each_ref()` to iterate through the old remote's
    references, but that function ignores broken references.

Both of these issues are easy to fix. But having a closer look at the
logic that renames remote references surfaces that it leaves a lot to be
desired overall.

The problem is that we're using O(|refs| + |symrefs| * 2) many reference
transactions to perform the renames. We first delete all symrefs, then
individually rename every direct reference and finally we recreate the
symrefs. On the one hand this isn't even remotely an atomic operation,
so if we hit any error we'll already have deleted all references.

But more importantly it is also extremely inperformant. The number of
transactions for symrefs doesn't really bother us too much, as there
should generally only be a single symref anyway ("HEAD"). But the
renames are very expensive:

  - For the "reftable" backend we perform auto-compaction after every
    single rename, which does add up.

  - For the "files" backend we potentially have to rewrite the
    "packed-refs" file on every single rename in case they are packed.
    The consequence here is quadratic runtime performance. Renaming a
    100k references takes hours to complete.

Ideally we'd refactor the code to use a single transaction to perform
all the reference updates atomically. But unfortunately that does not
work in the case where you rename a remote so that it becomes nested
into itself, as that can lead to conflicting reference updates.

The next-best thing is to do it in two transactions: one to delete all
the references, and one to recreate the references and their reflogs.
This signicantly speeds up the operation with the "files" backend. The
following benchmark renames a remote with 10000 references:

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
      Range (min … max):   204.863 s … 247.699 s    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      2.103 s ±  0.036 s    [User: 0.360 s, System: 1.313 s]
      Range (min … max):    2.011 s …  2.141 s    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
      113.53 ± 6.87 times faster than rename remote (refformat = files, revision = HEAD~)

For the "reftable" backend we see a significant speedup, as well, but
given that we don't have quadratic runtime behaviour there it's way less
extreme:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      8.604 s ±  0.539 s    [User: 4.985 s, System: 2.368 s]
      Range (min … max):    7.880 s …  9.556 s    10 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      1.177 s ±  0.103 s    [User: 0.446 s, System: 0.270 s]
      Range (min … max):    1.023 s …  1.410 s    10 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)

While at it, fix the handling of symbolic/broken references by using
`refs_for_each_rawref()`. Add tests that cover both this reported issue
and tests that verify that nesting remotes into itself continues to work
with conflicting references.

One thing to note: with this change we cannot provide a proper progress
monitor anymore as we queue the references into the transactions as we
iterate through them. Consequently, as we don't know yet how many refs
there are in total, we cannot report how many percent of the operation
is done anymore. But that's a small price to pay considering that you
now shouldn't need the progress monitor in most situations at all
anymore.

[1]: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>

Reported-by: Han Jiang <jhcarl0814@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c  | 280 ++++++++++++++++++++++++++++++++++++------------------
 t/t5505-remote.sh |  71 ++++++++++++++
 2 files changed, 259 insertions(+), 92 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaeed..b1c55909184 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -3,7 +3,9 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "date.h"
 #include "gettext.h"
+#include "ident.h"
 #include "parse-options.h"
 #include "path.h"
 #include "transport.h"
@@ -612,36 +614,148 @@ static int add_branch_for_removal(const char *refname,
 struct rename_info {
 	const char *old_name;
 	const char *new_name;
-	struct string_list *remote_branches;
-	uint32_t symrefs_nr;
+	struct ref_transaction *tx_create;
+	struct ref_transaction *tx_delete;
+	struct progress *progress;
+	uint32_t progress_nr;
+	struct strbuf *buf1, *buf2, *buf3, *err;
+	struct strbuf *new_refname;
+	uint64_t index;
 };
 
-static int read_remote_branches(const char *refname, const char *referent UNUSED,
-				const struct object_id *oid UNUSED,
-				int flags UNUSED, void *cb_data)
+static void renamed_refname(struct rename_info *rename,
+			    const char *refname,
+			    struct strbuf *out)
+{
+	strbuf_reset(out);
+	strbuf_addstr(out, refname);
+	strbuf_splice(out, strlen("refs/remotes/"), strlen(rename->old_name),
+		      rename->new_name, strlen(rename->new_name));
+}
+
+static int rename_one_reflog_entry(const char *old_refname UNUSED,
+				   struct object_id *old_oid,
+				   struct object_id *new_oid,
+				   const char *committer,
+				   timestamp_t timestamp, int tz,
+				   const char *msg, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-	int flag;
-	const char *symref;
-
-	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
-	if (starts_with(refname, buf.buf)) {
-		item = string_list_append(rename->remote_branches, refname);
-		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						 refname, RESOLVE_REF_READING,
-						 NULL, &flag);
-		if (symref && (flag & REF_ISSYMREF)) {
-			item->util = xstrdup(symref);
-			rename->symrefs_nr++;
-		} else {
-			item->util = NULL;
-		}
+	struct strbuf *identity = rename->buf1;
+	struct strbuf *name = rename->buf2;
+	struct strbuf *mail = rename->buf3;
+	struct ident_split ident;
+	const char *date;
+	int error;
+
+	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
+		return -1;
+
+	strbuf_reset(name);
+	strbuf_add(name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_reset(mail);
+	strbuf_add(mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	strbuf_reset(identity);
+	strbuf_addstr(identity, fmt_ident(name->buf, mail->buf,
+					  WANT_BLANK_IDENT, date, 0));
+
+	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
+					      new_oid, old_oid, identity->buf, msg,
+					      rename->index++, rename->err);
+
+	return error;
+}
+
+static int rename_one_reflog(const char *old_refname,
+			     const struct object_id *old_oid,
+			     struct rename_info *rename)
+{
+	struct strbuf *message = rename->buf1;
+	int error;
+
+	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
+		return 0;
+
+	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 old_refname, rename_one_reflog_entry, rename);
+	if (error < 0)
+		return error;
+
+	/*
+	 * Manually write the reflog entry for the now-renamed ref. We cannot
+	 * rely on `rename_one_ref()` to do this for us as that would screw
+	 * over order in which reflog entries are being written.
+	 *
+	 * Furthermore, we only append the entry in case the reference
+	 * resolves. Missing references shouldn't have reflogs anyway.
+	 */
+	strbuf_reset(message);
+	strbuf_addf(message, "remote: renamed %s to %s", old_refname,
+		    rename->new_refname->buf);
+
+	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
+					      old_oid, old_oid, git_committer_info(0),
+					      message->buf, rename->index++, rename->err);
+	if (error < 0)
+		return error;
+
+	return error;
+}
+
+static int rename_one_ref(const char *old_refname, const char *referent,
+			  const struct object_id *oid,
+			  int flags, void *cb_data)
+{
+	struct rename_info *rename = cb_data;
+	struct strbuf *new_referent = rename->buf1;
+	const char *ptr = old_refname;
+	int error;
+
+	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
+	    !skip_prefix(ptr, rename->old_name, &ptr) ||
+	    !skip_prefix(ptr, "/", &ptr)) {
+		error = 0;
+		goto out;
 	}
-	strbuf_release(&buf);
 
-	return 0;
+	renamed_refname(rename, old_refname, rename->new_refname);
+
+	if (flags & REF_ISSYMREF) {
+		/*
+		 * Stupidly enough `referent` is not pointing to the immediate
+		 * target of a symref, but it's the recursively resolved value.
+		 * So symrefs pointing to symrefs would be misresolved, and
+		 * unborn symrefs don't have any value for the `referent` at all.
+		 */
+		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						   old_refname, RESOLVE_REF_NO_RECURSE,
+						   NULL, NULL);
+		renamed_refname(rename, referent, new_referent);
+		oid = NULL;
+	}
+
+	error = ref_transaction_delete(rename->tx_delete, old_refname,
+				       oid, referent, REF_NO_DEREF, NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+	error = ref_transaction_update(rename->tx_create, rename->new_refname->buf, oid, null_oid(the_hash_algo),
+				       (flags & REF_ISSYMREF) ? new_referent->buf : NULL, NULL,
+				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
+				       NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+	error = rename_one_reflog(old_refname, oid, rename);
+	if (error < 0)
+		goto out;
+
+	display_progress(rename->progress, ++rename->progress_nr);
+
+out:
+	return error;
 }
 
 static int migrate_file(struct remote *remote)
@@ -730,7 +844,6 @@ static void handle_push_default(const char* old_name, const char* new_name)
 	strbuf_release(&push_default.origin);
 }
 
-
 static int mv(int argc, const char **argv, const char *prefix,
 	      struct repository *repo UNUSED)
 {
@@ -741,11 +854,15 @@ static int mv(int argc, const char **argv, const char *prefix,
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
-		old_remote_context = STRBUF_INIT;
-	struct string_list remote_branches = STRING_LIST_INIT_DUP;
-	struct rename_info rename;
-	int i, refs_renamed_nr = 0, refspec_updated = 0;
-	struct progress *progress = NULL;
+		old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
+	struct rename_info rename = {
+		.buf1 = &buf,
+		.buf2 = &buf2,
+		.buf3 = &buf3,
+		.new_refname = &old_remote_context,
+		.err = &err,
+	};
+	int i, refspec_updated = 0;
 	int result = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
@@ -756,8 +873,6 @@ static int mv(int argc, const char **argv, const char *prefix,
 
 	rename.old_name = argv[0];
 	rename.new_name = argv[1];
-	rename.remote_branches = &remote_branches;
-	rename.symrefs_nr = 0;
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1)) {
@@ -832,79 +947,60 @@ static int mv(int argc, const char **argv, const char *prefix,
 		goto out;
 
 	/*
-	 * First remove symrefs, then rename the rest, finally create
-	 * the new symrefs.
+	 * Note that we're using two transactions to rename the references:
+	 *
+	 *   - One transaction contains all deletions for references part of
+	 *     the old remote.
+	 *   - One transaction contains all creations of references and reflogs
+	 *     part of the new remote.
+	 *
+	 * This split is required to avoid conflicting ref updates when a
+	 * remote is being nested into itself or converted into its parent
+	 * directory.
+	 *
+	 * Unfortunately this means that the operation isn't atomic. But we
+	 * cannot avoid that, unless transactions learn to handle such
+	 * conflicts one day.
 	 */
-	refs_for_each_ref(get_main_ref_store(the_repository),
-			  read_remote_branches, &rename);
-	if (show_progress) {
-		/*
-		 * Count symrefs twice, since "renaming" them is done by
-		 * deleting and recreating them in two separate passes.
-		 */
-		progress = start_progress(the_repository,
-					  _("Renaming remote references"),
-					  rename.remote_branches->nr + rename.symrefs_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
-		struct strbuf referent = STRBUF_INIT;
+	rename.tx_delete = ref_store_transaction_begin(get_main_ref_store(the_repository),
+						       0, &err);
+	if (!rename.tx_delete)
+		goto out;
 
-		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->string,
-					   &referent))
-			continue;
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->string, NULL, REF_NO_DEREF))
-			die(_("deleting '%s' failed"), item->string);
+	rename.tx_create = ref_store_transaction_begin(get_main_ref_store(the_repository),
+						       0, &err);
+	if (!rename.tx_create)
+		goto out;
 
-		strbuf_release(&referent);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+	if (show_progress)
+		rename.progress = start_delayed_progress(the_repository,
+							 _("Renaming remote references"), 0);
 
-		if (item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addf(&buf2, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_rename_ref(get_main_ref_store(the_repository), item->string, buf.buf, buf2.buf))
-			die(_("renaming '%s' failed"), item->string);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+	result = refs_for_each_rawref(get_main_ref_store(the_repository),
+				      rename_one_ref, &rename);
+	if (result < 0)
+		die(_("renaming references failed: %s"), rename.err->buf);
 
-		if (!item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, item->util);
-		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf3);
-		strbuf_addf(&buf3, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
-			die(_("creating '%s' failed"), buf.buf);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	stop_progress(&progress);
+	result = ref_transaction_commit(rename.tx_delete, &err);
+	if (result < 0)
+		die(_("deleting old remote refs failed: %s"), rename.err->buf);
+
+	result = ref_transaction_commit(rename.tx_create, &err);
+	if (result < 0)
+		die(_("committing new remote refs failed: %s"), rename.err->buf);
+
+	stop_progress(&rename.progress);
 
 	handle_push_default(rename.old_name, rename.new_name);
 
 out:
-	string_list_clear(&remote_branches, 1);
+	ref_transaction_free(rename.tx_create);
+	ref_transaction_free(rename.tx_delete);
 	strbuf_release(&old_remote_context);
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
 	strbuf_release(&buf3);
+	strbuf_release(&err);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2701eef85e9..f4a407b022d 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1658,4 +1658,75 @@ test_expect_success 'forbid adding superset of existing remote' '
 	test_grep ".outer. is a superset of existing remote .outer/inner." err
 '
 
+test_expect_success 'rename handles unborn HEAD' '
+	test_when_finished "git remote remove unborn-renamed" &&
+	git remote add unborn url &&
+	git symbolic-ref refs/remotes/unborn/HEAD refs/remotes/unborn/nonexistent &&
+	git remote rename unborn unborn-renamed &&
+	git symbolic-ref refs/remotes/unborn-renamed/HEAD >actual &&
+	echo refs/remotes/unborn-renamed/nonexistent >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can nest a remote into itself' '
+	test_commit parent-commit &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent || true" &&
+	git remote add parent url &&
+	git update-ref refs/remotes/parent/branch $COMMIT_ID &&
+	test_when_finished "git remote remove parent/child" &&
+	git remote rename parent parent/child &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/child/branch\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can nest a remote into itself with a conflicting branch name' '
+	test_commit parent-conflict &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent || true" &&
+	git remote add parent url &&
+	git update-ref refs/remotes/parent/child $COMMIT_ID &&
+	test_when_finished "git remote remove parent/child" &&
+	git remote rename parent parent/child &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/child/child\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can unnest a remote' '
+	test_commit parent-child-commit &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent/child || true" &&
+	git remote add parent/child url &&
+	git update-ref refs/remotes/parent/child/branch $COMMIT_ID &&
+	git remote rename parent/child parent &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/branch\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename moves around the reflog' '
+	test_commit reflog-old &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_config core.logAllRefUpdates true &&
+	test_when_finished "git remote remove reflog-old || true" &&
+	git remote add reflog-old url &&
+	git update-ref refs/remotes/reflog-old/branch $COMMIT_ID &&
+	test-tool ref-store main for-each-reflog >actual &&
+	test_grep refs/remotes/reflog-old/branch actual &&
+	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-old/branch >reflog-entries-old &&
+	test_line_count = 1 reflog-entries-old &&
+	git remote rename reflog-old reflog-new &&
+	test-tool ref-store main for-each-reflog >actual &&
+	test_grep ! refs/remotes/reflog-old actual &&
+	test_grep refs/remotes/reflog-new/branch actual &&
+	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-new/branch >reflog-entries-new &&
+	cat >expect <<-EOF &&
+	$(cat reflog-entries-old)
+	$COMMIT_ID $COMMIT_ID $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1112912173 -0700	remote: renamed refs/remotes/reflog-old/branch to refs/remotes/reflog-new/branch
+	EOF
+	test_cmp expect reflog-entries-new
+'
+
 test_done

-- 
2.50.1.565.gc32cd1483b.dirty

