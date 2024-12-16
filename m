Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395920E038
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367486; cv=none; b=Hkkxe/0OoXdIHyqqIPJ5S+2gbpCVZbgiyYlrzYn9/6LxEihQtG6makH7OnKdF4g13fVipUxL3lyNDe8wC+HNUVCQs81W1ttC84cOLpJhsT0dbMazHJt4si6aY8n94Vaf1C0UWamrD5ujUozFItpJWaPo2bDlhhv3cri7e4lmvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367486; c=relaxed/simple;
	bh=pQgBGaG3lRxPgmTt/jE9VJu9X4iPfd9VMFBjrbINC70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnGHnz8/BD2PObJg2FjFJJSEH8dQKXM7hxD0B+GJBRyRQitzMHiBnWwvrca+CKYWEYDyqDVW2kzLMBFjK4uQEFeQCenN4mYwRzG3r2KrD/FDk8XriuBueyhel88r6lXwBoeR4v0RnTJAgVaNXYU9t+4FFwWqo6K+3EggLxvktBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSzpE/hc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSzpE/hc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso753216966b.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367482; x=1734972282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rty06NC7hnmumKMwmmrJr/mk37YTFLOxIExFq/Z5Ok=;
        b=MSzpE/hcYrWM+scVPKWr1apouB57MWELEm6nNLN2YbDgm4EpoF3nMwVBdA/eOlyjt5
         MFBvTxkNiN5TcHUxtlWVm+hdXuSK1D65L9x/c5OR70r7+yPNR4SgdQtC6z/pOUBZx5x3
         K5afVlHnwahcOqMFj+M6CqJ6sNHAzgR/hAKTcx9rb1Xay7Azvgx06rnM/5/e+t1eSfhM
         ePTzpSJ8l3/GT9qQFcu13MX7bWM4Nsy7vzJUaS+Gxgex0Zxq9d0Vdho2P3Y6nEugM+8O
         TJwii4/5kUSkC/C5/6wUkxS0a2gjFEEoegm4KV+EOEKRfLXsOIo+p5OMVmink6jBKf0v
         k7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367482; x=1734972282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rty06NC7hnmumKMwmmrJr/mk37YTFLOxIExFq/Z5Ok=;
        b=jACtL1p3lKDF68lGUqX56iXxPpXQPTlT0fV15rJhJZp7U/qSlr/saJVTi+Slp3ncgJ
         cu+ZgQJyM/VcgI+NoOXa2rs2EqIeqCJ9J5m/b9g9I6d3khhL15rYcxh4vuzUyqdh3h8F
         85OzP+gmQx6jJAMUDgl6f4MlNNDVpAUNAj+YhV31ilDieu9+pKVwSO1tq02EPyX+EQ/i
         e1sb9N08D/DmXVneSTDK7uKt1cZJLmnym6o43t47vzJ5qVyry+fwarrBysGvLmnfL1HZ
         XCf5mqmzADxYUDZw6GyJ1zSxlCz00MacwxJDDzbvbQwzgA02Mm7t0W8PIQ1C/cl2rfzV
         pRXA==
X-Gm-Message-State: AOJu0YyN2ZjUwe8Kz94CmM7eP5yA8apw4ORwfMx4IpUPWzpqw/D58U7i
	3SIN+1cz/JQzqZvtp7QSPN4MzBU4KXYgGjNyS56uDjfx6xEuISG5gui9AK1d
X-Gm-Gg: ASbGncsdIwnLtJJKlzB0z9OlJSruGO+75uAIlX1XRxl5+ff0gPs+KrBgayVjFO2KWMQ
	35f0md6H3mpcAr/AjJOkp2oU3PMe3VdbQ10uawkmqoVC/8rm6ctxuASQVrB4ZEvxgIs/nWF1yY8
	HbAxOPdXa8OTPL3I9udAzpgQoTc9qasfsU/dswfHKUMx7ujISiGigLjRwU7zK22ZWknqa8lPt3m
	zrAd18S71G7RkXXDNHI1HMUX4D7Npr9O0He8iQlLc1zjFTqsnmaxYNt4JA=
X-Google-Smtp-Source: AGHT+IHrqlytzxMTC4eCe1Kke4nwqRppMhkaTBZAn1oBxhxlg4PN1gAKkdRpIt6rOBfrnok1FPL6sQ==
X-Received: by 2002:a17:906:309a:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-aabdb885361mr28553766b.37.1734367481861;
        Mon, 16 Dec 2024 08:44:41 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:41 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:33 +0100
Subject: [PATCH v4 8/8] refs: add support for migrating reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-8-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11375;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=pQgBGaG3lRxPgmTt/jE9VJu9X4iPfd9VMFBjrbINC70=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwyxepYeYkXtZqfMNhkEjnMi19WRGTDjUi0
 fEOywu7NEaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 fwhZC/0R8l28qRhh25bIeyawY7LynGm1f8NcQ7yKLNs4tJvEADFqbIlmcwzFTuosRCksXkc8uBW
 +j98EJGHh63F3xPmf1j41/rz1/ts0WXQbgbKR1CRqDIW8QcjaYlvPjD2yXEJJuBcRapv3K95G1o
 2eCYOGBNTg90NmMaiG7uIEOfq/EZSEDtypr07AOBwiqbfxLxZBQWSBrYEM3suFiu5A5vNaBOKeR
 nC8vWq+F5++6FX3YYeR8j9UrUPVGClunOTk93yOt/vHZNJpR64vfJSPI09gdyV3HpPguikNy5Sw
 VWzf15mJZCPNMCOKsPnE/IIHkKxt6LHUWGffmDbjGDPbTrtzJvBQT4UveoTzMvZPPQ8L0DAmy5t
 p9CbHIQo6XHcZW/IFyrEYbAWulWh5p60h5MEtJHM/eL8kCjfkG+Zk81KAgo6Gop5okasJtcqZrh
 ALJdTiGFzcqtRxmpJVwwu41W6k/hF3rLdYKpzweKeuvGSqNIy0oRSfQ6FKYiivSTKhb1c=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs migrate` command was introduced in
25a0023f28 (builtin/refs: new command to migrate ref storage formats,
2024-06-06) to support migrating from one reference backend to another.

One limitation of the command was that it didn't support migrating
repositories which contained reflogs. A previous commit, added support
for adding reflog updates in ref transactions. Using the added
functionality bake in reflog support for `git refs migrate`.

To ensure that the order of the reflogs is maintained during the
migration, we add the index for each reflog update as we iterate over
the reflogs from the old reference backend. This is to ensure that the
order is maintained in the new backend.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-refs.txt |  2 -
 refs.c                     | 92 ++++++++++++++++++++++++++++++++--------------
 t/t1460-refs-migrate.sh    | 73 +++++++++++++++++++++++++-----------
 3 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index ce31f93061db5e5d16aca516dd3d15f6527db870..9829984b0a4c4f54ec7f9b6c6c7072f62b1d198d 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -57,8 +57,6 @@ KNOWN LIMITATIONS
 
 The ref format migration has several known limitations in its current form:
 
-* It is not possible to migrate repositories that have reflogs.
-
 * It is not possible to migrate repositories that have worktrees.
 
 * There is no way to block concurrent writes to the repository during an
diff --git a/refs.c b/refs.c
index 8b3882cff17e5e3b0376f75654e32f81a23e5cb2..5d541ddc41aa84905e688c92565aa18fbf55323b 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,7 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
+#include "ident.h"
 
 /*
  * List of all available backends
@@ -2673,6 +2674,7 @@ struct migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
+	struct strbuf sb;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2705,6 +2707,52 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	return ret;
 }
 
+struct reflog_migration_data {
+	unsigned int index;
+	const char *refname;
+	struct ref_store *old_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
+	struct strbuf *sb;
+};
+
+static int migrate_one_reflog_entry(struct object_id *old_oid,
+				    struct object_id *new_oid,
+				    const char *committer,
+				    timestamp_t timestamp, int tz,
+				    const char *msg, void *cb_data)
+{
+	struct reflog_migration_data *data = cb_data;
+	const char *date;
+	int ret;
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	strbuf_reset(data->sb);
+	/* committer contains name and email */
+	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+
+	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+					    new_oid, old_oid, data->sb->buf,
+					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
+					    data->index++, data->errbuf);
+	return ret;
+}
+
+static int migrate_one_reflog(const char *refname, void *cb_data)
+{
+	struct migration_data *migration_data = cb_data;
+	struct reflog_migration_data data = {
+		.refname = refname,
+		.old_refs = migration_data->old_refs,
+		.transaction = migration_data->transaction,
+		.errbuf = migration_data->errbuf,
+		.sb = &migration_data->sb,
+	};
+
+	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
+					migrate_one_reflog_entry, &data);
+}
+
 static int move_files(const char *from_path, const char *to_path, struct strbuf *errbuf)
 {
 	struct strbuf from_buf = STRBUF_INIT, to_buf = STRBUF_INIT;
@@ -2771,13 +2819,6 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 	return ret;
 }
 
-static int count_reflogs(const char *reflog UNUSED, void *payload)
-{
-	size_t *reflog_count = payload;
-	(*reflog_count)++;
-	return 0;
-}
-
 static int has_worktrees(void)
 {
 	struct worktree **worktrees = get_worktrees();
@@ -2802,8 +2843,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct ref_store *old_refs = NULL, *new_refs = NULL;
 	struct ref_transaction *transaction = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
-	struct migration_data data;
-	size_t reflog_count = 0;
+	struct migration_data data = {
+		.sb = STRBUF_INIT,
+	};
 	int did_migrate_refs = 0;
 	int ret;
 
@@ -2815,21 +2857,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 	old_refs = get_main_ref_store(repo);
 
-	/*
-	 * We do not have any interfaces that would allow us to write many
-	 * reflog entries. Once we have them we can remove this restriction.
-	 */
-	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0) {
-		strbuf_addstr(errbuf, "cannot count reflogs");
-		ret = -1;
-		goto done;
-	}
-	if (reflog_count) {
-		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
-		ret = -1;
-		goto done;
-	}
-
 	/*
 	 * Worktrees complicate the migration because every worktree has a
 	 * separate ref storage. While it should be feasible to implement, this
@@ -2855,17 +2882,21 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 *      This operation is safe as we do not yet modify the main
 	 *      repository.
 	 *
-	 *   3. If we're in dry-run mode then we are done and can hand over the
+	 *   3. Enumerate all reflogs and write them into the new ref storage.
+	 *      This operation is safe as we do not yet modify the main
+	 *      repository.
+	 *
+	 *   4. If we're in dry-run mode then we are done and can hand over the
 	 *      directory to the caller for inspection. If not, we now start
 	 *      with the destructive part.
 	 *
-	 *   4. Delete the old ref storage from disk. As we have a copy of refs
+	 *   5. Delete the old ref storage from disk. As we have a copy of refs
 	 *      in the new ref storage it's okay(ish) if we now get interrupted
 	 *      as there is an equivalent copy of all refs available.
 	 *
-	 *   5. Move the new ref storage files into place.
+	 *   6. Move the new ref storage files into place.
 	 *
-	 *   6. Change the repository format to the new ref format.
+	 *  7. Change the repository format to the new ref format.
 	 */
 	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
 	if (!mkdtemp(new_gitdir.buf)) {
@@ -2907,6 +2938,10 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
+	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+	if (ret < 0)
+		goto done;
+
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
 		goto done;
@@ -2982,6 +3017,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
+	strbuf_release(&data.sb);
 	return ret;
 }
 
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 1bfff3a7afd5acc470424dfe7ec3e97d45f5c481..f59bc4860f19c4af82dc6f2984bdb69d61fe3ec2 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -7,23 +7,44 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Migrate the provided repository from one format to the other and
+# verify that the references and logs are migrated over correctly.
+# Usage: test_migration <repo> <format> <skip_reflog_verify>
+#   <repo> is the relative path to the repo to be migrated.
+#   <format> is the ref format to be migrated to.
+#   <skip_reflog_verify> (true or false) whether to skip reflog verification.
 test_migration () {
-	git -C "$1" for-each-ref --include-root-refs \
+	repo=$1 &&
+	format=$2 &&
+	skip_reflog_verify=${3:-false} &&
+	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >expect &&
-	git -C "$1" refs migrate --ref-format="$2" &&
-	git -C "$1" for-each-ref --include-root-refs \
+	if ! $skip_reflog_verify
+	then
+	   git -C "$repo" reflog --all >expect_logs &&
+	   git -C "$repo" reflog list >expect_log_list
+	fi &&
+
+	git -C "$repo" refs migrate --ref-format="$2" &&
+
+	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
 	test_cmp expect actual &&
+	if ! $skip_reflog_verify
+	then
+		git -C "$repo" reflog --all >actual_logs &&
+		git -C "$repo" reflog list >actual_log_list &&
+		test_cmp expect_logs actual_logs &&
+		test_cmp expect_log_list actual_log_list
+	fi &&
 
-	git -C "$1" rev-parse --show-ref-format >actual &&
-	echo "$2" >expect &&
+	git -C "$repo" rev-parse --show-ref-format >actual &&
+	echo "$format" >expect &&
 	test_cmp expect actual
 }
 
 test_expect_success 'setup' '
-	rm -rf .git &&
-	# The migration does not yet support reflogs.
-	git config --global core.logAllRefUpdates false
+	rm -rf .git
 '
 
 test_expect_success "superfluous arguments" '
@@ -78,19 +99,6 @@ do
 			test_cmp expect err
 		'
 
-		test_expect_success "$from_format -> $to_format: migration with reflog fails" '
-			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
-			test_config -C repo core.logAllRefUpdates true &&
-			test_commit -C repo logged &&
-			test_must_fail git -C repo refs migrate \
-				--ref-format=$to_format 2>err &&
-			cat >expect <<-EOF &&
-			error: migrating reflogs is not supported yet
-			EOF
-			test_cmp expect err
-		'
-
 		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
@@ -141,7 +149,7 @@ do
 			test_commit -C repo initial &&
 			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
 				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERIFICATION &&
-			test_migration repo "$to_format" &&
+			test_migration repo "$to_format" true &&
 			test_oid 001 >expect &&
 			git -C repo rev-parse refs/heads/broken >actual &&
 			test_cmp expect actual
@@ -195,6 +203,27 @@ do
 			git -C repo rev-parse --show-ref-format >actual &&
 			test_cmp expect actual
 		'
+
+		test_expect_success "$from_format -> $to_format: reflogs of symrefs with target deleted" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo branch branch-1 HEAD &&
+			git -C repo symbolic-ref refs/heads/symref refs/heads/branch-1 &&
+			cat >input <<-EOF &&
+			delete refs/heads/branch-1
+			EOF
+			git -C repo update-ref --stdin <input &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: reflogs order is retained" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit --date "100005000 +0700" --no-tag -C repo initial &&
+			test_commit --date "100003000 +0700" --no-tag -C repo second &&
+			test_migration repo "$to_format"
+		'
 	done
 done
 

-- 
2.47.1

