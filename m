Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BB376BEA
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373749; cv=none; b=LzsivCh6wH6N3h7KeTtFvsG+rFxymRiEVDD4EKJ5pIkZ5tK3WIUYec12/aLNviNMZBYYyD+qRE8vNhi/wfHfF/LSbGPwJaf2z+ocJ2CY8Y0n+aQ8TiWuaNIUFbTZJuco8tQdgfujYb7fn/FOyNddTktjzB8aT2E2nG1Jfq9EUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373749; c=relaxed/simple;
	bh=eEk7XfKYMCdthtRWDKkDFI8TlWdaZsEHj5J1+n8HxHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VjFf/6tz5y5D67JlqeXowFyApusM0qIKbdWs2oGR5bKt4OFrdLhhuUbzSwXl0TrZKJKoTkREsRkZZ+nQ2M5vOAG9lfTiJlkFbyCa3L6gX+xukZLOL0WiUA1fxeVo1va/stlYIPzwVpHTNiytH4SLH+duO8L17Vm/60xov/8IzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXXVrX9H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXXVrX9H"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9201076b3so17596295ad.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373747; x=1788978547; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o+Jl7cTFnZ+kFNnwevg37HswN8AIQhH3A0v/dqujMes=;
        b=UXXVrX9HQLKMe2EDxEWaW7vM32KSHukJ0EF/2efFYVjXG6OVDgU62hgpfVKm7lABoc
         bFg5CGNVhbcOjMW+PteTT0TKafsADxuUDvZCOAdXSW95essumkuMC1nsY3MXd8O3D7VM
         gg/2iCOKyfbBqJfC/XIArZYj8PDTndnepkQE35WoFXmflu2anaS1qYQnfAbYsNhB2dob
         bEgZrcE+4OHKhR3bJpAqTo2RspKbiHS1+PGinBsO413gewIDVpmOoZLZJ56ICxhpDApb
         BpyMsXu7HrZGY5i+SFJ29hFDfOyXDAXc2jdrYTcWutQMKElAgjntBnR8bInFKqIWGK8a
         13eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373747; x=1788978547;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+Jl7cTFnZ+kFNnwevg37HswN8AIQhH3A0v/dqujMes=;
        b=laAOKH9L5Ve5uLtFPp8e9wNvpsYhEI7kGj4Yu5jj1sNGTl7kU86e7UOy9VwNgDH1Wq
         FyS70qWe41Ab3ksChVtPhfC0tAc1GQoQ2u0eOlY5Rh9oltl5PhKNs+rFQs5yJD4pyFwt
         S9OWbD8fVYbljfdkjU+CJ6dS8pkvSwzrmTfPYbLYoDYcf5FB9wpSuDmzzusgG6IrT8Cz
         Jdd8W8ZRCl63gGopYkj8lVStAhJKeCnZtlbY+TQ5bTTyIE1SvF+ALSgAR0K2B7iDDYTx
         t7bKxEmvAvA6ph38Fhdgud/F4K1YgHX2us8FjbMRQz/DRpVh+5v0rHN7v4kKJyxJcDwb
         SvnQ==
X-Gm-Message-State: AFuF++khL/QasThi3Kfnzrypa9VARrpp1QH2OYfziKy4T4Lp/nxcZ4D+
	IqCPmQ2dBqF5rSz1QwCqZXO+3HKdY/BjDkpj7sYPFc1k/KvaYUVNCcoxWw22zb5R
X-Gm-Gg: AYBFou3uUoPzWcO0SQ8aPyLIERptIN873a9hy7dyHaJs9uIh7jH8+5zgcZLK1fC8tZv
	2bn7GtEs/KRfE6ug6xi5l4z7A9pDH1EHTswxRLPvyPbqzdeUGAhGRXrANNJkxOBCqS+L58eLrrt
	1UVkup9OLNMFSjSOTVWD+qJwCNKYw5TDOA5PhqCiA8QUyB/7anEdaHl+EpLU14Ce1oZVPJOJyCf
	OdkhyC/iZ/g78uzosobCKsxiQdGCaIRuCu8p4Ru4dSWRDx2t0I18VlHU/b5PBmdFfGkHehjqkBd
	og0YsvA6PuoZETKGPK8rVsebUEHmpKJ+u5ehSRCZ0t2PNtvBaN00bkQZghpjv/rMLk8iSL6J4Um
	C4JMoaO8Xa89cb8hhRHn7LWHKH5OhI0c9TumSJvwI0AZUgWfkDPFlpoVT4VkzqQfnNtVhMistY2
	50KkBybV+7OX5kizF48vUoqPbez6JgK9915ru+/h2NpJ4/UgXnynwtYKg3+C3ISQ==
X-Received: by 2002:a17:902:fc4f:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2daec774106mr102854325ad.18.1788373746593;
        Wed, 02 Sep 2026 11:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.64.182.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd39e8e2sm16841495ad.33.2026.09.02.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:29:06 -0700 (PDT)
Message-Id: <935fa0a9ae69f269a8a79f213f02aa4ed1e8279b.1788373743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 18:29:03 +0000
Subject: [PATCH v4 2/2] checkout: separate autostash conflict advice from
 branch-switch message
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git checkout -m" stashes the user's local changes when it cannot
perform the checkout, and then applies the stash.  When applying the
stash results in conflicts, the advice on how to deal with them is
printed directly on top of the branch-switch message ("Switched to
branch ..."), making the two hard to tell apart.  Print a blank line
in between so that the advice and the branch-switch message are
visually distinct.

apply_autostash_ref() reports whether applying the stash resulted in
conflicts via its enum stash_apply_result return value, so only print
the blank line in the conflicted case.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/checkout.c | 15 +++++++++------
 t/t7201-co.sh      | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..c960f98287 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1166,6 +1166,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	int do_merge = 1;
 	int created_autostash = 0;
+	enum stash_apply_result autostash_res = STASH_APPLY_CLEAN;
 	struct strbuf old_commit_shortname = STRBUF_INIT;
 	struct strbuf autostash_msg = STRBUF_INIT;
 	const char *stash_label_base = NULL;
@@ -1237,12 +1238,12 @@ static int switch_branches(const struct checkout_opts *opts,
 				git_config_push_parameter(cfg.buf);
 				strbuf_release(&cfg);
 			}
-			apply_autostash_ref(the_repository,
-					    "CHECKOUT_AUTOSTASH_HEAD",
-					    new_branch_info->name,
-					    "local",
-					    stash_label_base,
-					    autostash_msg.buf);
+			autostash_res = apply_autostash_ref(the_repository,
+				    "CHECKOUT_AUTOSTASH_HEAD",
+				    new_branch_info->name,
+				    "local",
+				    stash_label_base,
+				    autostash_msg.buf);
 		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
@@ -1255,6 +1256,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
+	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
+		fputc('\n', stderr);
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	if (created_autostash) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0ddd1ad7aa..9ea9462914 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -236,10 +236,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
 	test_must_fail git checkout side 2>stderr &&
 	test_grep "Your local changes" stderr &&
 	git checkout -m side >actual 2>&1 &&
-	test_grep "resulted in conflicts" actual &&
-	test_grep "git stash drop" actual &&
-	test_grep "git stash pop" actual &&
-	test_grep "The following paths have local changes" actual &&
+	cat >expect <<-EOF &&
+	Your local changes are stashed, however applying them
+	resulted in conflicts.  You can either resolve the conflicts
+	and then discard the stash with "git stash drop", or, if you
+	do not want to resolve them now, run "git reset --hard" and
+	apply the local changes later by running "git stash pop".
+
+	Switched to branch ${SQ}side${SQ}
+	The following paths have local changes:
+	M	one
+	EOF
+	test_cmp expect actual &&
 	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
 	sed /^index/d actual >actual.trimmed &&
 	cat >expect <<-EOF &&
-- 
gitgitgadget
