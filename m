Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EF3BFE2B
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492704; cv=none; b=b/ofBRduHPV7kr6DXXjv3aAo4MvQuxGSDUQEPHQkl6jco1TPeqOFqVu6BuzFtF9rdOim/sGXbeDjUix8Xm29cxKSKCbFgodhmpufKR0sNOr7Gz21sobq4fehcpNrqnulWGT3hODS5TY7UctzmWQAvjVT0JqX3G38K4hhDbVhHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492704; c=relaxed/simple;
	bh=gYgpbQwid+zeosN9fxx4ZVu/NmtPxrtppMApx531ISo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nMhWEVAVy04gDDOqVdwHvutqDp87cNPO24ecM7RVaTLCRMdZoZJiXjOhWCQPLey/yqZ1olkpmG9Q3d+EfzogRLvK/DbnGPKrxdUdxibrfn0vW7Le7BAiv+X+8F8QvsgzHxzL9A9FRC1LHzBMedD4gaMg/TLRirogdfqndy1+vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLcvvVcg; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLcvvVcg"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7020a928eso5483638eec.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492701; x=1779097501; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNtnYVMANrnLr4lSW6h+0nLgJ21GJKWPkw/e25CEkqw=;
        b=LLcvvVcgPSHRyTfjeq3N+zCGr7b4WBu9vNctKaJaSClHgA27Rq7dsewR/54AUmMIck
         rxIoNNjnNaPfNzH7OqzeXyyxkzxHyTIMZgyI4kYUvJ+Y4E+RORU1CBD7VGwikLvH1D6H
         RTubjiCVI23QS6rU5X9On1/agGUsDZ4zW9kgdwsz1P2KjxhbPcWAUpx9bT5cYG/28upr
         qMwdaKjUKJOBTfSRiYy3QV7AdS46D0HB9ZyyusgUIUJw8WLvoc4XqrcnQJrlnHGhzo0x
         CLlNSes4+7mQGlONH6ihc+LQ6pPhoMUR9GGsUq+F3f704EL+3VjB3VP89J2fFt/M2Fks
         Qfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492701; x=1779097501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNtnYVMANrnLr4lSW6h+0nLgJ21GJKWPkw/e25CEkqw=;
        b=ZvcaFD/IOaghONE7c4oOCK3TnGAAujRs3t7idoKKBvWCFQlKjyydpZgGRVdHgQtU2A
         /z4LNZ2KTXVqVFLKRkiHf2mzkZ2NtS9h41AX38asZ5WnQ9A0a6RW2uxASI39d13xFe2Q
         +lLHJQYwINYyWHoLfZaNt4Lr6m3jihPad/ki7aMQPC5d0jhw9n7PhScUB7AWxsi39UGz
         j2kMayz2VJ4v7tAhnr0qCObJFAYopVNSslpae1Qiy0OylRyvaDznvyKH+yQDWsDEmgAh
         qnJO5meU4f86LQqPZixr1eko3WklUZLY/4/3Lg1OcJKk2DyCLDLDHELFQI0KGr3nO+Kv
         m5qQ==
X-Gm-Message-State: AOJu0Ywf5DZIqeqTZ+sYrqawdvWPIVmJJn0/ALAI9Ad58knRWXpcsxc2
	RPI8CLEEhkLi1I9UK5IA4pfHeoNzgA5cTlJiqPHvhxVT2G8iGGdCGYySg+0omG4S
X-Gm-Gg: Acq92OHwDQ4Li3jQy2SWV69FVYsTPBeQIOTdL+yPwqMPUtEl1GZt52aBsZrVHcmYZW5
	+D6ol36Qk0ir1AId4Z8096tG5PFaOjZ9Tzeh43jHpCberEyeb6gLL/FIRUXpiCg2Sr06C0DNMId
	2nmeiqJ8dawT9Rl7WYIz+x/bsMrxcNgFhtc4P62BVWwLJooXfRrAl24pvwBxfmRU7KOc2ME2hD7
	2LUriJVbmqx43FQDNgtsdYKzZGJp+267uW/PgPmm7qOdC3sKPAvO0dL6PjPCI1Xk9dBO0E9SagN
	/JAlQr5EOqJftlUmjW91Eg30fkFUSMGIbN4vfqVviBltinHsFIYAs/oHxP7DC2T1GoiTdPyPMHC
	QgvZlFeyyhZRBA0wKAXP+JAqOAVgdYuLLctNwNcvy2nkACBbT94gPjRGcBJu1AoDJ5d4I3mvBic
	uH/hOdkKLRzNsAWohWoxkPEceb7rXg
X-Received: by 2002:a05:7300:8623:b0:2e2:d94d:6186 with SMTP id 5a478bee46e88-2f548e95823mr9974828eec.11.1778492700366;
        Mon, 11 May 2026 02:45:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm12838905eec.25.2026.05.11.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:44:59 -0700 (PDT)
Message-Id: <717fc6758e0d02d5e2c1e1834c5f4b6d884393b5.1778492691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:50 +0000
Subject: [PATCH v6 4/5] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
--prune-merged (and from fetch --prune-merged), even with --force.
Useful for keeping a topic branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 ++++++
 Documentation/git-branch.adoc    | 10 ++++----
 builtin/branch.c                 | 31 +++++++++++++++++++++----
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..4662ef35c1 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.
+	Useful for topic branches you intend to develop further after
+	an initial round has been merged upstream. Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index a5e869270d..9807d3c218 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,15 +216,15 @@ Each _<remote>_ may be either the name of a configured remote
 	Delete the local branches that `--forked` would list for
 	the same _<remote>_ arguments, but only when the branch's
 	push destination remote-tracking branch (the branch `git push`
-	would update; see `branch_get_push` semantics) no longer
-	resolves locally. In other words: the branch was pushed
-	under some name on _<remote>_, and that name has since
-	been pruned upstream.
+	would update) no longer resolves locally. In other words:
+	the branch was pushed under some name on _<remote>_, and
+	that name has since been pruned upstream.
 +
 As a safety check, branches with commits not yet integrated into
 the remote's default branch are refused. With `--force` (or `-f`),
 delete them regardless. The currently checked-out branch in any
-worktree is always preserved.
+worktree is always preserved, as is any branch with
+`branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index d2f07cddd8..7b356e250e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -869,15 +869,18 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *push_ref;
 		const char *upstream;
 		const char *remote_name;
 		const char *slash;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
@@ -887,18 +890,38 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 		if (upstream &&
 		    string_list_has_string(&protected_default_refs, upstream)) {
 			const char *leaf = strrchr(upstream, '/');
-			if (leaf && !strcmp(leaf + 1, short_name))
+			if (leaf && !strcmp(leaf + 1, short_name)) {
+				strbuf_release(&key);
 				continue;
+			}
 		}
 
 		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
-		if (!push_ref)
+		if (!push_ref) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (refs_ref_exists(get_main_ref_store(the_repository),
-				    push_ref))
+				    push_ref)) {
+			strbuf_release(&key);
+			continue;
+		}
+		if (string_list_has_string(&protected_default_refs, push_ref)) {
+			strbuf_release(&key);
 			continue;
-		if (string_list_has_string(&protected_default_refs, push_ref))
+		}
+
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
 			continue;
+		}
+		strbuf_release(&key);
 
 		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
 		remote_name = push_ref + strlen("refs/remotes/");
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ca3d06a1ec..fabff84f16 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1915,4 +1915,44 @@ test_expect_success '--prune-merged spares branches whose push ref is the defaul
 	git -C pm-pushdefault rev-parse --verify refs/heads/topic
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one --track origin/one &&
+	git -C pm-optout branch two --track origin/two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
+	git -C pm-optout update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout update-ref -d refs/remotes/origin/two &&
+	git -C pm-optout branch --prune-merged origin 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success '--prune-merged --force still honours pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout-force" &&
+	git clone pm-upstream pm-optout-force &&
+	git -C pm-optout-force checkout -b one --track origin/one &&
+	test_commit -C pm-optout-force unpushed &&
+	git -C pm-optout-force checkout - &&
+	git -C pm-optout-force config branch.one.pruneMerged false &&
+
+	git -C pm-optout-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout-force branch --force --prune-merged origin &&
+
+	git -C pm-optout-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one --track origin/one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

