Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CED21C199
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742452; cv=none; b=eg5JDZ8IjTs6pHUe5gtqWByVUn2v3kGbyOhPuZGnAJ8GhYkmAFeknuEVa3TzEm/w4q+H8TbCZHXLHKGoZwiv6AYusfxG3arIFxFaCzHM3YUT5+GeyoRniYJPzJTVJd19aqo08GyGcjg1BaASiYWxMaucq6/lUmE8ssE5FrkjxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742452; c=relaxed/simple;
	bh=dTMkc7fTSLRLIW8QEzzuJZURYqfHWikDw5kU0cagkdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hF1MncOyaoCetj+XT/tkfuzJRh+zW344QyYLryaJQRi/9iTJa6aeAMOLAM/ag85HFcddu7QbkPc9CscGcgqvRWizlhI1MM/WuJr3j3subUKXB9vO8lYQ6xxQHzGlKVJ7ai2ZY1rz/J32n3EPos4UydGNlTpQJa77HvqUnr0+tpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1hTg30e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1hTg30e"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6997f33e4so35587366b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742449; x=1734347249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nstbR1x/Ctx0E8lCauhKUrE1x/Cv1cSQvkF0rT8B7aE=;
        b=B1hTg30eV/w9covnBO3l4/TerLPUXOwLOg5dRcu1wbgk4bPkOz/bESRE2Jt3j63unp
         hcDDp/XNZICIn8qiDt8blbCPR005dY3L3+XnLxdgW/YN+BhMsNrJDbYCD+IHsBUhf9yD
         7F4wJuaWiEpYdawQnv4xCrtAebng5vS5TukzwLjDnewCgy1LGMw+kqZA2kIcsEi/m80O
         +/2JUbjRr4fejH5A0QnddUXJsl8P8P35JaQjz+3as6RmYVhSk/1CVp3z86LYWZFDO9By
         8dxLoVrO99jAcf834Neo6JQChJjauuJVnKpHkB5NJGQ8uRs0GMTRVoboOF7raD7iZzJg
         h8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742449; x=1734347249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nstbR1x/Ctx0E8lCauhKUrE1x/Cv1cSQvkF0rT8B7aE=;
        b=ve40iR2wVXooW/bZTKvKv3JOfIuQqaAHTTe7AE2iTzrK1hyJ1cRG8ZADIj9DxafWkZ
         2re7MHrG8fIr2SSMyeTRppg1j7kePs/9PFAVd0tZ7owALOL6PACMJjD/gLk4OtogGvCK
         dhbNjGclwIIyTqtXm4SR2GMfG9KcvxJIeM/0W9YiheYAjh+zWVUB4OytdIgzcr500brq
         5+TJdb6rJ7wJ1LtpXmdty3tO+WW/d2klwuBw06NFvIINODo3hByD90qJskuR+/JJAR+y
         u/02GjRZXorc3h0wakYzyIpt1RxfOencOGbDMGZn2QsVeb/2DGKpnn7bBGOufSd3BGhV
         c+aA==
X-Gm-Message-State: AOJu0YxwJBfq9tmBC1Xop2wJ3DMjYKX4KHyF+9KLQjG2ts1fjUk6kmYc
	UPzGmi9v+PEmfaMoHSmGO8mq18IKBWCa0zQj4kVjlwXaLMxAD2Plq5T8aS4Y
X-Gm-Gg: ASbGncvnlr3FZlvRiOaizF7Jehaa58LiHu9KlSikvab5SMHiMLK6kovoehU2cEqAwgc
	kyIRshYu9955v9opjOc2wwZoPZZv/6P5bLjmYEvSndYaIO0kGCMLQifshyyjNrOmbIJUpKUOjyr
	YT5QjBFqTsMx+28zfjYLx27vF107ZoLktbOknKKDPhokYlchtArpti2Hdsg5PqeLPweXzRYXGy/
	950KnXYSUcZGFsEViT+LXNjAMkbKP4kei6ZatjmKJonhMMw0Uvxj1pFV5tk7XM=
X-Google-Smtp-Source: AGHT+IFFUB3YSHykz4WghB0Xg+gTeIk8/WcqDxCzxDh0hfs9GamrS4nm2SV2FGu0/HZR+0JlqglrOA==
X-Received: by 2002:a17:907:75c2:b0:aa6:40a4:b13 with SMTP id a640c23a62f3a-aa640a40bdcmr1101085666b.59.1733742448704;
        Mon, 09 Dec 2024 03:07:28 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:21 +0100
Subject: [PATCH 7/7] refs: add support for migrating reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-7-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10371;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=dTMkc7fTSLRLIW8QEzzuJZURYqfHWikDw5kU0cagkdI=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nsXvzILlQNXVz1PPrLehe00AsNv/rOy6IU
 rx7CLo5e7qJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 fxXnC/sHEdPXy+Xf9yswAcq8TWlqUErU9WsRhC72gshfDuBNrb7QZg1vTErTWEa4A4d070UFhei
 wDQLWQMGiXXIk62aaGOaol9S1HgMuvZUjStZvQd5D1Nr1ShHjby1qx/BAuMePl1F7pMLl34coq5
 SclgrbqgJ65w9C69erCXTU/YP+J3Fu1FfSCMZRory5k9mve64yYagoyZg02Nq1GKqioAZV8PvC4
 Me9MXl4iiS6pNjKa+14bJy7d4+9NvM42+D8kv+OPvXgfKxVYs/S+JSnqidigQrpJ9uBBZuJC2bK
 QXjCBqXGT4wyNBjMpvZ0cYQmYRjxxTBO5vW9Yxp7HD297pjq0W5aj723/DmCwQlv0xMB326DPun
 wfcj8l/R9Kt/zJXivS+Rhv73b9WkCroNwwQeqfcN0KbXFkU7yNaaa5OF/v6an1MZ97xfZb5oeTF
 yKDtem+PAG+3b5ag5//tmfofs8aOBuwD0GVoxpa0rPWt67VQNngDWN/wx/DigBH0ir1jY=
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-refs.txt |  2 --
 refs.c                     | 81 ++++++++++++++++++++++++++++++++--------------
 t/t1460-refs-migrate.sh    | 73 ++++++++++++++++++++++++++++-------------
 3 files changed, 107 insertions(+), 49 deletions(-)

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
index 602a65873181a90751def525608a7fa7bea59562..4d10c7276391e8e85c66bd626bb0ecfec0941c6d 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,7 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
+#include "ident.h"
 
 /*
  * List of all available backends
@@ -2687,6 +2688,7 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 }
 
 struct migration_data {
+	unsigned int index;
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
@@ -2722,6 +2724,53 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	return ret;
 }
 
+struct reflog_migration_data {
+	unsigned int *index;
+	const char *refname;
+	struct ref_store *old_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
+};
+
+static int migrate_one_reflog_entry(struct object_id *old_oid,
+				    struct object_id *new_oid,
+				    const char *committer,
+				    timestamp_t timestamp, int tz,
+				    const char *msg, void *cb_data)
+{
+	struct reflog_migration_data *data = cb_data;
+	struct strbuf sb = STRBUF_INIT;
+	const char *date;
+	int ret;
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	/* committer contains name and email */
+	strbuf_addstr(&sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+
+	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+					    new_oid, old_oid, sb.buf,
+					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
+					    (*data->index)++, data->errbuf);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static int migrate_one_reflog(const char *refname, void *cb_data)
+{
+	struct migration_data *migration_data = cb_data;
+	struct reflog_migration_data data;
+
+	data.refname = refname;
+	data.old_refs = migration_data->old_refs;
+	data.transaction = migration_data->transaction;
+	data.errbuf = migration_data->errbuf;
+	data.index = &migration_data->index;
+
+	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
+					migrate_one_reflog_entry, &data);
+}
+
 static int move_files(const char *from_path, const char *to_path, struct strbuf *errbuf)
 {
 	struct strbuf from_buf = STRBUF_INIT, to_buf = STRBUF_INIT;
@@ -2788,13 +2837,6 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
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
@@ -2820,7 +2862,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct ref_transaction *transaction = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data;
-	size_t reflog_count = 0;
 	int did_migrate_refs = 0;
 	int ret;
 
@@ -2832,21 +2873,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
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
@@ -2868,8 +2894,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 *   1. Set up a new temporary directory and initialize it with the new
 	 *      format. This is where all refs will be migrated into.
 	 *
-	 *   2. Enumerate all refs and write them into the new ref storage.
-	 *      This operation is safe as we do not yet modify the main
+	 *   2. Enumerate all refs and reflogs and write them into the new ref
+	 *      storage. This operation is safe as we do not yet modify the main
 	 *      repository.
 	 *
 	 *   3. If we're in dry-run mode then we are done and can hand over the
@@ -2924,6 +2950,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
+	data.index = 1;
+	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+	if (ret < 0)
+		goto done;
+
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
 		goto done;
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

