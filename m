Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2E175A85
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960151; cv=none; b=Wt3W3bnXvxxIJeCsxUKKjwjNCg7sn1Q8GELi3Ab1OxYIDFudaByJCpq/UEBAIb7Qwpk4J3LwxXGm9DxtEk4IrvSIM5VsmhZmjORJWij0VvetM/zA6GwOxJ1zt26VIVABfWoJWVI5jYx787CLtbwS4Fs0LtyBcIUTiz3fGz2cNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960151; c=relaxed/simple;
	bh=UlqGJhxXcww5qZXMUpSwCX0L7XWn4TqhGQNa9gD8vDw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Lu4USyqjynBjNxVe/WleFJ89H9jyYnv4J4vvd8ii+jy4/ih8qUv5g5nochR0Jc6P3JhZs8egNT9zlXl2BEJd/JGkQVAwOlsIKs+Oy15TV20picBpUANxhstU0CG15kTmPYskjJzIo1ONRC3NKx7XlpHxbyQdGkgC3JHlNvsVlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnCd0hHY; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnCd0hHY"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-917bef0d531so1449196d6.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960149; x=1791564949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8nW8aIfIolVtWWCGhay99vTUbQcNXTudkAkEYf1m19c=;
        b=UnCd0hHYxSDi+MEx6FR89va0u+W3NP0bNjxOWPkAHKmq9aWoRp1IaUtI8VUkhSn3L7
         pDk2Bb/iMEpSNMNqzQGbWHhCyFjwYes7cAovCnanz0PLPf5wroKp/rhvDS9HcN0yByd6
         m/FFYdHRYWn1J5ICph8tBrrnVbG72a7DLeqlq4AWzZQvSoYkv4SBK9irp6MK1a2dxjve
         SnrwlaRB2FR7jAeTFtdvoMoTJwXjUkWANyo4us1tbOmYVbhVa5npI1QoBZ8lQStF0bfD
         t5jv+UoOs2U2+eLXquL1FPreuReO0+JQ6mRlRr/QZknG36RD7OF0jqC1HlYynRON04Ba
         MXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960149; x=1791564949;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8nW8aIfIolVtWWCGhay99vTUbQcNXTudkAkEYf1m19c=;
        b=umJAHW/rU2ILVH0YO1XLme4LK6BuGeY3q7bEc+OW4lh8SePq2paHbp+LvoAMjMKmdZ
         Ohh2Cv0xKAL42YoJflz6O0qp1J9kbsekw9idb4TaX7JAjspSUQiF0asQiG2Ebszmz9ld
         UnKijEIdsH7g6HeEeyIjOdIwB5C1Kp5beQ/8z5DHzCnroXTJdA1M7vL4V8Ohx+zT21Jr
         Hf8YFDMJdb6jkK2ElFH3TRXuJoST8U1r+IoM1uVDWfwqVyvCkQ8qYa2rLLOx8YUTrq5Z
         CKIEAi3nJP9EenlFd2RKTIzFhFwYqSal5z4uZVcVRKRdjS/aV/vGsqracoTIlXcGiDVj
         eKzg==
X-Gm-Message-State: AFq9FYJqkz80rwgkYYlmFl0dHKksAJqRATenj2xFFYu4M5GesFNI1z/j
	Luq0DobCgdkhERpbqxR16dHhYTpECIWcgGJuUdTzzNuNAJBnw+pJLAtyVRNoLw==
X-Gm-Gg: AYBFou1zySPnGT+3lAQ/WRIBBJGl/qEjF64qScoN2CsVUvvjG18dDHEjUIr/x56UzCm
	rfxgwhs4g9AKxeXR96FhARM3Su277qrus9esjrmVFjphxxVrYsK+BL4syEJYrRJzdrRU06XU9fM
	FD7j1PzzxtPKwZFMH573EUrHn+dcYUS0guMihbX62eMA2NVwxXGyLvuoYn5l7k0UzuWn2m8D5qA
	br84Ad0ZCL3XZybxPOGxi/sVU5/tX/URGrMBVq50/AwtRUKVaV/OdnLMwXuR2emtPQxemOMNMfp
	bfMU7sQi6GnLAEbHPjSzHyKZSao/1iwmQNc4T7DXmM1DHCyWlU1dEJSiUcb8MoVKLhh5XkOTpqv
	sOy0Gtr0OyFZPIAitAl5seowjNSFsJ6JH8E73xweBUl1lsoz/3KNMCv9sDrBSRAYISQLh9IiGY7
	5cDfqkuLw8lCmJGNcLQb7oCMD7UL0sMP1IaOlkN6JlC3Hr/47jcw/pQv6N4q5d/d5bQbc3GViTi
	Kk=
X-Received: by 2002:a05:6214:d6f:b0:915:e732:33b4 with SMTP id 6a1803df08f44-917c009e2cfmr66137246d6.19.1790960148941;
        Fri, 02 Oct 2026 09:55:48 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.228.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91951dec5d5sm15530566d6.18.2026.10.02.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:55:48 -0700 (PDT)
Message-Id: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 16:55:47 +0000
Subject: [PATCH] branch: let --delete-merged default to every upstream
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Cleaning up every branch whose work has landed upstream required
typing '*/*' as the pattern.

Let a bare "git branch --delete-merged" consider every upstream. As
with "--merged" without a commit, this applies only when the option
comes last, so "git branch --dry-run --delete-merged" previews the
cleanup.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    branch: let --delete-merged default to every upstream
    
    A bare git branch --delete-merged now considers every upstream.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2428%2FHaraldNordgren%2Fbranch-delete-merged-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2428/HaraldNordgren/branch-delete-merged-default-v1
Pull-Request: https://github.com/git/git/pull/2428

 Documentation/git-branch.adoc |  6 ++++--
 builtin/branch.c              | 14 +++++++++++---
 t/t3200-branch.sh             | 25 ++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..4a91ae6879 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch [--dry-run] --delete-merged
 git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
@@ -202,14 +203,15 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
-`--delete-merged <pattern>`::
+`--delete-merged [<pattern>]`::
 	Delete local branches whose configured upstream matches
 	_<pattern>_, but only when their tip is reachable from that
 	upstream. In other words, the work on the branch has already
 	landed on the upstream it tracks, so the local copy is no longer
 	needed. _<pattern>_ may name a ref, a remote (using the branch its
 	`HEAD` points at), or a shell-style glob. The option can be
-	repeated to widen the upstream match.
+	repeated to widen the upstream match. Without _<pattern>_, every
+	upstream matches.
 	Optional _<branch-pattern>_ arguments limit which local branches
 	are considered, e.g. `git branch --delete-merged 'origin/*'
 	'topic-*'`.
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..f2a4e117dc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -39,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --delete-merged"),
 	N_("git branch [<options>] (--delete-merged <pattern>)... "
 	   "[<branch-pattern>...]"),
 	NULL
@@ -1029,9 +1030,16 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
-			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
-			PARSE_OPT_NONEG, parse_opt_strvec),
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "delete-merged",
+			.value = &delete_merged,
+			.argh = N_("pattern"),
+			.help = N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
+			.flags = PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
+			.callback = parse_opt_strvec,
+			.defval = (intptr_t) "**",
+		},
 		OPT_BOOL(0, "dry-run", &dry_run,
 			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..e60f4794c8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2133,9 +2133,28 @@ test_expect_success '--delete-merged result is independent of stacked branch nam
 	)
 '
 
-test_expect_success '--delete-merged requires a value' '
-	test_must_fail git -C forked branch --delete-merged 2>err &&
-	test_grep "requires a value" err
+test_expect_success '--delete-merged without a pattern matches every upstream' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch merged &&
+	(
+		cd repo &&
+		git branch --track local-topic main &&
+		git checkout --detach &&
+
+		git branch --dry-run --delete-merged &&
+
+		check_branches <<-\EOF &&
+		local-topic
+		main
+		merged
+		EOF
+
+		git branch --delete-merged &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
 '
 
 test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
