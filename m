Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13143DA5D8
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651496; cv=none; b=o0SasGHavjaZlgMnJka+YizO+j0mhdx/FCeA6UZEXbZHpEHoz1vtIA3lcaH3vS+PwnFBbTJ2e7ex6o5dEwgjJFBDMGdu50NaoI3dL+DuK9f5eeIQst16sbyZebJXEMl5ZaPJVKq/nFHe5Xri937WuKf6aX0xdSA/mYtzjW4kXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651496; c=relaxed/simple;
	bh=hl1HafL+uojQv4VHPJ/cP9wvHL/NqMpVmToIHPhDA/s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dWbGQ7ezWAWWgPThxsDLDEhpkv9jXaYL6krme3RZFneXeLuChcbzw/aiPjppA0X3Uu9y9bBf3+T/pJ0yTSuuWuinlgXnz8DtZAGADmc92bfpSkzjCCfEmZB1LRckfuNnsItGpcRCEtgMuivxcMcYQKhdJnHojUs4TNqd1uDURo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0jtRNmW; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0jtRNmW"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1275910b930so4500560c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772651489; x=1773256289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+zeslNT5pjxPoI7KNYw8HK6QIL0wBxyveMW2PdemX0=;
        b=K0jtRNmWBjfIT+k99I5RVH/pR24bQHaVZ6/K3XLfACUw24BOhLw2AKWCg6hsKqMWOr
         QF6YrtGGCK9jqaZCTwWe7ct0XkAh8olmXlRxreQynp+gRXS16gqfcXryeATpHSwENqQw
         hGZwHAxdFPFzUFHNq6lVMQw2c5mWQ81bwU2WQWnoClzM4fav51Qjxa/5C+GgmccUZVOG
         o2Bxhz8nu3TTfHffKKzwJo6NPZAWybegWWDBhskeTwZfy4TpjWogPoqevkMuvE5S8eyB
         E/0Y26dImPRLWsPxV7up20mU8TvuaruTnoO5YGVb31ZyX5GqvV0UvsRlidrUjCArujjw
         55XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772651489; x=1773256289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+zeslNT5pjxPoI7KNYw8HK6QIL0wBxyveMW2PdemX0=;
        b=oYSwkw9ZEtJkkM1hgM1xovv91IsApoDTn6DR8oZHXZjSCOpoUecp1ttHc28ESsfNk7
         JvFLLveyuATtK5RwCVFNPPU0xHCOuMnVF56tXYyt61s+CPjJJub6yOl6IYTsTE/yL/VE
         mH+byoKe1IDff3Uq0tXCKOq6zDwyy1G8Cqa/E538qtvvJ0lcVzNslzv1TN9mNoQEvFYi
         RLr7ZzRqzZkwS7qUaoKBYzAfY207oGkNObGefqgQUJWWqjo8r4fPbcbEsEpe2V/WLoZM
         5Pmrvfl/MAKvzth2qJBhGDzt+9FagHxGR5mcrB/HLMn7CsswN5F7Y9WEseZmcRbGnt4h
         pO5g==
X-Gm-Message-State: AOJu0YzSv09GNZLso64Qe8RmfkkdeuDiCdi0eBD4fjKyuuZAcL8CJm4W
	qrTHlhmj08DOrIuAhWqb+Qx36WGqv0lT1H/Xjp3bDR6Hwfm03eb+G39hc6LTdpod
X-Gm-Gg: ATEYQzzYfgB3keaYxY9ptbfdPFwIn+Oo7VgBew9zEWis04TdKUOZps4+Y906Ckusbos
	nEwrXE4rcbpxRi3bqlQ4NRwgcZQl9bvmYrkaAHuk8E7L13V9w1FZsXXOwyvuGE6KFaEEKwN8vO+
	tY7NSL/8y6ZkSpK6gp34owOu4pSYTWvU6VXGmPMP7UlQOav1idEPqusqeXJj9vPZI1UUDkPK0tr
	Y818BnJ/utBr8kjf/rMLTFytsjaP8asuGumm9wBxYiYxsiPJ89QHomJVZigv40Fi4Y5Fktw3iAA
	gnzU8heWkHjDV+qUfNUt2QaXiSzLNXcGYsS0l8rOYuP1JeaU3HFGgSgr+0YiTnhoghYDoZkFteX
	N3HIGOJx0CpRqIwXPISf/QuyO4bceJWdj7cTTDUhJnq7Zr6WyVbvgcniR01q8Y87n3uAZETwEwO
	L4WwbrZf8gFkOjt/uxIjFHc34=
X-Received: by 2002:a05:7022:20d:b0:123:3a91:f563 with SMTP id a92af1059eb24-128b0cfd333mr2671227c88.8.1772651489085;
        Wed, 04 Mar 2026 11:11:29 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm22628073c88.5.2026.03.04.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:11:28 -0800 (PST)
Message-Id: <ae5269af0b08d75bcad38b0263debe4e23e479a8.1772651484.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:11:24 +0000
Subject: [PATCH 2/2] log: reject pickaxe options when combined with -L
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The previous commit fixed a crash when -G, -S, or --find-object was
used together with -L and rename detection.  However, these options
still have no effect on -L output: line-log uses its own
commit-filtering logic in line_log_filter() and never consults the
pickaxe machinery.  Rather than silently ignoring these options, reject
the combination with a clear error message.

This replaces the known-breakage tests from the previous commit with
tests that verify the rejection for all three options.  A future series
could teach line-log to honor these options and remove this restriction.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 builtin/log.c       |  4 ++++
 t/t4211-line-log.sh | 52 ++++++++-------------------------------------
 2 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..44e2399d59 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -317,6 +317,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->line_level_traverse && rev->prune_data.nr)
 		die(_("-L<range>:<file> cannot be used with pathspec"));
 
+	if (rev->line_level_traverse &&
+	    (rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
+		die(_("-L does not yet support -G, -S, or --find-object"));
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7acc38f72d..8ebc73d2d9 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -367,53 +367,19 @@ test_expect_success 'show line-log with graph' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for -L with -G/-S/--find-object and a merge with rename' '
-	git checkout --orphan pickaxe-rename &&
-	git reset --hard &&
-
-	echo content >file &&
-	git add file &&
-	git commit -m "add file" &&
-
-	git checkout -b pickaxe-rename-side &&
-	git mv file renamed-file &&
-	git commit -m "rename file" &&
-
-	git checkout pickaxe-rename &&
-	git commit --allow-empty -m "diverge" &&
-	git merge --no-edit pickaxe-rename-side &&
-
-	git mv renamed-file file &&
-	git commit -m "rename back"
-'
-
-test_expect_success '-L -G does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file -G "." >actual
-'
-
-test_expect_success '-L -S does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file -S content >actual
-'
-
-test_expect_success '-L --find-object does not crash with merge and rename' '
-	git log --format="%s" --no-patch -L 1,1:file \
-		--find-object=$(git rev-parse HEAD:file) >actual
-'
-
-test_expect_failure '-L -G should filter commits by pattern' '
-	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with -G is rejected' '
+	test_must_fail git log -L 1,1:a.c -G "pattern" 2>err &&
+	test_grep "does not yet support" err
 '
 
-test_expect_failure '-L -S should filter commits by pattern' '
-	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with -S is rejected' '
+	test_must_fail git log -L 1,1:a.c -S "pattern" 2>err &&
+	test_grep "does not yet support" err
 '
 
-test_expect_failure '-L --find-object should filter commits by object' '
-	git log --format="%s" --no-patch -L 1,1:file \
-		--find-object=$ZERO_OID >actual &&
-	test_must_be_empty actual
+test_expect_success '-L with --find-object is rejected' '
+	test_must_fail git log -L 1,1:a.c --find-object=HEAD 2>err &&
+	test_grep "does not yet support" err
 '
 
 test_done
-- 
gitgitgadget
