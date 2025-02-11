Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD41F9EC0
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274150; cv=none; b=VCBz6jr4Xe1ArJ7z7Bo+shwgkTgUGlfHwacUQaFbMff9JEDfZe8+MfcWTb+lWxuLx+oFCT4oiYRpbStq/rmoDBxyInkhRghMbIv+nGT56y+C+p/bVN5M/pmJC+ql0lFQYjViACLE2aG2Hh11s11JsRrAoDXErys6N90bM6WmXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274150; c=relaxed/simple;
	bh=yGwFJ7NSMDhJMrfMyXO1YyMXiFrdNJChmiH57Eg0JOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=COG7eb+8pwaMHZcGajzJRHG13doU2qqdiJU+zSqavPSrsOv8jWqzeyoJnHBDj29LqytYjU/qgMUSjOXMw/OcAyQSnm4LDOsjOE55+S5cIIRqmLcs87W+8MFQG+cE4/dHQSgNim42aacRmq1DsZg/49NW/d7u6ntYpcBrXBZiwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR08DyQ9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR08DyQ9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so5652950a12.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739274147; x=1739878947; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10AwvbDUMTvzg4F/nZ2RKGjd9ET+Q3dAKF8QmO2Qa34=;
        b=aR08DyQ9ehXQNGfikLlwuhMkgG2ETREOgA7Kulcd7uQ3P8fR8BHvjtSKAoMyflyBCt
         fmT4oAtw19qDLKUPDJIFQrI0nOShZSNBc3HSsQSB11h7dR5GrskvcA3ER+bP+MYKf5Yz
         xHA1Hr4ICJXiqgUf5H0L8t5Kv1OBigOuN1iRT3Er1FU4gkfplw0Tb6iGYYs7KNLpOQ+r
         0R4Ndk0lHLXjwcQwM1jOeCQQPpC667/2yQAJeUcUEEZEec6j8Co2GoQd2UFJ/5o22X0P
         EFGDSFzDrto8ZsNsColhF/KXoEsu1YaL6tdPEze/pInCtHns+TXr/1noi8oyuWt5QFWM
         u2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274147; x=1739878947;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10AwvbDUMTvzg4F/nZ2RKGjd9ET+Q3dAKF8QmO2Qa34=;
        b=QepTIWxNB3dOJVgWclNCNwLOB1PbLWvJY1LICK8TMvPg7+Ed7JkW/aY1JUYa+T9ini
         TST3ClMdP/ViVpdtuli4MjCNDcHcg/b8+lLXayVS0d6anZL16zuDfwnA6rhEuYr0qait
         QTRwaACIkcOSy9VGThkSMfnyhJvzSxzTOAnlWmQ+2lw1VJiYxOz5KJ7HwCQVaWbWZrKI
         J1hTjT0eAQd2yOGttkRwfkFDlAQB6T4dwFYk9alASUMWuMP+c3zsUAJt81mkySshgWgf
         K2xXyyjogrIbtOThQ8qoAfwlZ8CMklXGcHBsZCpaKhBJwCGt7lbT5zJzFNgyldmjUgXA
         8lNA==
X-Gm-Message-State: AOJu0YyUte4sDB83m7LgTT9Ln78drRMPHNO/3pOiXo0IgWCuGIqkdebF
	HvUTh4RY1Uppp9yw+Fw4+zfFcbLtr1dMgDJ73MTo3335FZuaPm91tEs7/lMI
X-Gm-Gg: ASbGnctZzs6gFSPJRfTMuaJ0u0c/T5YQo2YWp0JAkxjMd6cw8gvrxlV77T/m7385FNN
	MpqYewhlopTee4Jgk7r7qU8BRUpJczeLVA+KikSIwvApoTr5iDoPV7z8A+LEX9OPIqVzHxjTXCl
	8sxCcjTk4H5NqWHhy3qTtC0INuSb9AWVLF+PiC//TOTlCVyeVEnrLUKaFhOUAb62UAv3/hpPOQD
	IRM1cuviFG7RSVTtfGVcjKAmfvNF21mg6jvR0rtFDxC8QjzeeUs3LjVVHWWtpm2iS9jES4rv/1x
	AkpC0hkluK+MVDu1LJwD8g==
X-Google-Smtp-Source: AGHT+IErAunt4Wpv54E4DFRNvq3UE6TzdKtLgHOyWryCs6IOy/AIEFwfVO7G3Dj8cRRhX8zbmqhvog==
X-Received: by 2002:a05:6402:5214:b0:5dc:71f6:9723 with SMTP id 4fb4d7f45d1cf-5de9a4645eemr2620381a12.21.1739274146509;
        Tue, 11 Feb 2025 03:42:26 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:1c5e:95c2:ceaf:d3dc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de541fb84bsm7285560a12.54.2025.02.11.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:42:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 11 Feb 2025 12:42:18 +0100
Subject: [PATCH v2] builtin/refs: add '--skip-reflog' flag to bypass reflog
 migration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJk3q2cC/62OTQ6CMBCFr2K6dkwpPzWuvIdhUei0TAKtmSLRE
 O5uIR7B5ffy5b23ioRMmMTttArGhRLFkEGdT6IfTPAIZDMLJVUtldRQaQ2MLsFEns2MYKwFA24
 0HuYI5ENk3I0x+gT2xRT8z83VcJVN4xrraml6kUee2aT3ceDRZh4ozZE/x5+l2NO/TS8FFKBtJ
 V3ZVVjK7u4nQ+Olj5Not237AjFgpokMAQAA
X-Change-ID: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac
In-Reply-To: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7814; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=yGwFJ7NSMDhJMrfMyXO1YyMXiFrdNJChmiH57Eg0JOo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGerN6EXBVg+o+r4WONsHkpmJG8dtOJbE6F3F
 +Il2KxC2R3QpokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnqzehAAoJED7VnySO
 Rox/awYL+gNAZ0qR1B/yKqsMXLSTfe2ato1IZBlcSLOm1wRH7hHdQ1qm3W4FI1Qil7LAV2tPkDp
 R8y8JsxbgkikO/iSuMIFo2jE0ETFRlbfYPQCJo+Ejp0JqYhrk5lvSR03GsDEkPWUAM3SRuIqhIb
 /zwDMiar7VptIcNrcCb60exDVuFe1ouwaMxitLFshQeYme0X4oxPvJnLho6MdbodwXsrfVlpkb2
 vlguv6weprgM4Icp9PivNfEiD6qBx2KSXZRWwK4rf4zWhPZzqMzpI69780frqprGaD8I19gqk9g
 W8PQAITBeg0i1PYRFghdMii8F7ZkpKs4z9Vj4ryoClaZ6DKY6ICKE04I5SI38KdGgXdcXBLbsUl
 20AA9vxHGSGk4AXnfSWxryFUUv2n4cqiHRJfqnk1EnbrOe5DiZqMolA76Z0O/IJdo6BcCqa+Y3H
 u+aqTmtYM/RvSipcGB5P4Q3xCtpCEEkqQ6/11TeDVdm4Q3/PB0ucDpPZEes60btxqFc7ELm5Uc5
 Mo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-refs(1)' migrate subcommand, which transfers repositories
between reference backends, currently migrates reflogs by default as of
246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

While this behavior is desirable for most client-side repositories,
server-side repositories are not expected to contain reflogs. However,
due to historical reasons, some may still have them. This could be
caused, for example, by bugs, misconfiguration, or an administrator
enabling reflogs on the server for debugging purposes.

To address this, introduce the --skip-reflog flag, allowing users to
bypass reflog migration. This ensures that the repository ends up in the
expected state after migration.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Fix typo in commit mesasge and clarify the intent.
- Modify the test to use `test_line_count` and `test_must_be_empty`.
- Link to v1: https://lore.kernel.org/r/20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com
---
Range-diff versus v1:

1:  ce14d3d07e ! 1:  6b83089348 builtin/refs: add '--skip-reflog' flag to bypass reflog migration
    @@ Commit message
     
         The 'git-refs(1)' migrate subcommand, which transfers repositories
         between reference backends, currently migrates reflogs by default as of
    -    In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
    +    246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
    +
         While this behavior is desirable for most client-side repositories,
    -    server-side repositories typically don't use reflogs and the migration
    -    of these entries is unnecessary overhead.
    +    server-side repositories are not expected to contain reflogs. However,
    +    due to historical reasons, some may still have them. This could be
    +    caused, for example, by bugs, misconfiguration, or an administrator
    +    enabling reflogs on the server for debugging purposes.
     
    -    Add a '--skip-reflog' flag to the migrate subcommand to make reflog
    -    migration optional. This is particularly useful for server-side
    -    migrations where reflogs are not needed, improving migration performance
    -    in these scenarios.
    +    To address this, introduce the --skip-reflog flag, allowing users to
    +    bypass reflog migration. This ensures that the repository ends up in the
    +    expected state after migration.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/refs.c ##
    @@ t/t1460-refs-migrate.sh: do
     +			git init --ref-format=$from_format repo &&
     +			test_commit -C repo initial &&
     +			# we see that the repository contains reflogs.
    -+			test 2 = $(git -C repo reflog --all | wc -l) &&
    ++			git -C repo reflog --all >reflogs &&
    ++			test_line_count = 2 reflogs &&
     +			test_migration repo "$to_format" true --skip-reflog &&
     +			# there should be no reflogs post migration.
    -+			test 0 = $(git -C repo reflog --all | wc -l)
    ++			git -C repo reflog --all >reflogs &&
    ++			test_must_be_empty reflogs
     +		'
      	done
      done
---
 builtin/refs.c          |  3 +++
 refs.c                  |  8 +++++---
 refs.h                  |  5 ++++-
 t/t1460-refs-migrate.sh | 19 +++++++++++++++++--
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index a29f19583474518ee0942ea53c39cbdf9661c5e2..30be0254c14dd3d07693d70c25dddc9990756e9c 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		OPT_BIT(0, "dry-run", &flags,
 			N_("perform a non-destructive dry-run"),
 			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
+		OPT_BIT(0, "skip-reflog", &flags,
+			N_("skip migrating reflogs"),
+			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
 		OPT_END(),
 	};
 	struct strbuf errbuf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
--- a/refs.c
+++ b/refs.c
@@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
-	if (ret < 0)
-		goto done;
+	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
+		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+		if (ret < 0)
+			goto done;
+	}
 
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..ccee8fc6705e6e93a1c6234e7395180f8dfd815b 100644
--- a/refs.h
+++ b/refs.h
@@ -1157,8 +1157,11 @@ int is_pseudo_ref(const char *refname);
  *   - REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN: perform a dry-run migration
  *     without touching the main repository. The result will be written into a
  *     temporary ref storage directory.
+ *
+ *   - REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG: skip migration of reflogs.
  */
-#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN (1 << 0)
+#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN      (1 << 0)
+#define REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG (1 << 1)
 
 /*
  * Migrate the ref storage format used by the repository to the
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..28c0024a4c8cb8282bf586840265edba442f5056 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -9,14 +9,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 # Migrate the provided repository from one format to the other and
 # verify that the references and logs are migrated over correctly.
-# Usage: test_migration <repo> <format> <skip_reflog_verify>
+# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
 #   <repo> is the relative path to the repo to be migrated.
 #   <format> is the ref format to be migrated to.
 #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
+#   <...options> are other options be passed directly to 'git refs migrate'.
 test_migration () {
 	repo=$1 &&
 	format=$2 &&
 	skip_reflog_verify=${3:-false} &&
+	shift $(( $# >= 3 ? 3 : 2 )) &&
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >expect &&
 	if ! $skip_reflog_verify
@@ -25,7 +27,7 @@ test_migration () {
 	   git -C "$repo" reflog list >expect_log_list
 	fi &&
 
-	git -C "$repo" refs migrate --ref-format="$2" &&
+	git -C "$repo" refs migrate --ref-format="$format" $@ &&
 
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
@@ -241,6 +243,19 @@ do
 				test_cmp expect.reflog actual.reflog
 			)
 		'
+
+		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
+			# we see that the repository contains reflogs.
+			git -C repo reflog --all >reflogs &&
+			test_line_count = 2 reflogs &&
+			test_migration repo "$to_format" true --skip-reflog &&
+			# there should be no reflogs post migration.
+			git -C repo reflog --all >reflogs &&
+			test_must_be_empty reflogs
+		'
 	done
 done
 

---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac

Thanks
- Karthik

