Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B690451997
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446422; cv=none; b=YLbft9IqX39egrCtqU8VJOHudDLSSuKXM1t4/9amsKZGRD4S8zYdPEW4EfWYYklNhvoRwTDo8Ws5K4MYvZI/VdvZAlvBOgo/jshvYghvqLxnz7+B0t9gP/UyeeizhCEQbVOD9nCdp4sfHP/5LVNYM8LwD+iK+Gji2TQPeC1eIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446422; c=relaxed/simple;
	bh=eEk7XfKYMCdthtRWDKkDFI8TlWdaZsEHj5J1+n8HxHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AqNj2IFUuOnsnUg9CEPYZZstbzX/AXRh7SpypAUeeLuax4G2z23c8zfz2qeM5zobP92SqDKU8HfQLYBwwmp9NHXrow8bH1jTphHUCJW97gvR7VYxegUxWWHkiChuE6ImlgrMd56DUfVA9FVcWbA+lgH0FkkYhuHBk4uHoePZRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaTEHCzR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaTEHCzR"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a34f7ebcedso19674861fa.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446411; x=1789051211; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o+Jl7cTFnZ+kFNnwevg37HswN8AIQhH3A0v/dqujMes=;
        b=MaTEHCzR2jP6Lp434VmHjE1SlFaw5idOtj00XO1xmf2tLNFEYp1PRotu1S6IYZ2fXj
         mXlkHOB2IdicC10bvmm2DiyyntF/vto12ui27mmLlIk9zE+KpD4JTxGFHBm+fbvdNtRo
         H9JN9/G1sU93+Rp/6k+ONxR9A6OiekcLuz28r4Y030d+9MKz5ZzmWnlrNLEy1oBusCgs
         FJzViUt5iDoeSkYrfaTpMXYFf7r/P6hT4GvWhTzZlQ7z8Ua6OLChWPniRFdmC761/XVO
         IWQOdt0tmyFT9flZR2pJIwcqc8dMO2xCbvCmAw4QCTWzZtHZrCXe03a5DGJpjkYU5Q1q
         nDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446411; x=1789051211;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+Jl7cTFnZ+kFNnwevg37HswN8AIQhH3A0v/dqujMes=;
        b=lc6nuXVtAxChOHXgy9T96LzFwUeQdH9E66ZNZyE0GLk5leK1Hc04++AB0d9k2HAt7y
         BtHBdlZdvkTrrn6cT+o1W0V67D9prG6OZL2x2BHO9frNCB5eCV0k3AxGY4JExiLa8cfh
         qX32EMKaodgoFsvEiG14h6qEmKNqYOL1qii/ExYwXO17PPcr5ct8nsadZNeMktS004A5
         AOpqQHnL5VxK5J4igdicr8tuEojnSy+lEAh5u1Oof0+nAFyRkEkJZy9LEsHu8RGtPsEE
         5ZGIC3KK0PZQP1tXKGDBaLC4acE0wPXEikFcSbWQfjPig724f5NjhTfvf17kAsoW6QfI
         iS8A==
X-Gm-Message-State: AFuF++naN2iCVHIURacg/zfxWMHHQWGF2gfkAR5Ev/OHhXSh5/MfEyxs
	yzbOKixN/mFn/+cCalpIqB6IsTcgzYGncfLGsrA9ZjPY5ZbiKTQ/3vMa0xSd6Cbe
X-Gm-Gg: AYBFou03eM8qy+R8oEeWnVRzk4uzYhEGFPOzmwT+3bqX8e/HLgiIBYfbTyhwvaleOTZ
	bAVvChUUOHfZAyhPOZIY6JHohM+2oYkyEpGt4c2Iw+gHRLvSKx/zbyXE4ZDsMRyFsd+khyTPTp0
	Vh/ZoaMHHZ6BH7WddNPvdXbiWOeqzNqPjIqWj6I9oq5BhngToFrtZ0oAx26TDc3LOSXgMXOfjfu
	BmakJNIWp32nHz30Pw1IQ29gQ3DcuxMcNpvqn6MtIZjtRJk4Bn3iQOWFU38IwoHRo4qW6RzFiPe
	tgMOY/acdGrkWCWahFyAfLgYGMLAO5SuE8p+/BbpciJmPT7IFi5O2mfGWjIojZNnIawvxYga7e6
	fR5nMRObQyP9pldBvt0vap0D5Xgbr0IKO1edfBsqRxlBEuYnOMBNfiQ6FVaj8eAOS5BuaHVBJpP
	QYlyorWGaSzkvk3YkRfhNJB1jOWTtyJH9AX4RQ1s3IB1J+2L0FYiu49cKXAU6MbyY2Aw==
X-Received: by 2002:a05:651c:a391:20b0:3a1:8558:56a2 with SMTP id 38308e7fff4ca-3a34fd41c70mr20736701fa.6.1788446410522;
        Thu, 03 Sep 2026 07:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.215.214])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705c3553sm47901fa.32.2026.09.03.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:40:09 -0700 (PDT)
Message-Id: <d18ff3ea9a018b6ae207bd4f3c7740b96b3197c0.1788446398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 14:39:58 +0000
Subject: [PATCH v5 2/2] checkout: separate autostash conflict advice from
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
