Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F627FB0E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741273; cv=none; b=k5xWLkzAF2fv6XJljxF/k6zc4CkVxWIHMqRjEwcPvOBdUUAd+ZRGNYmohGgW4+bFW8Q+3s07D6QPfwL9CP/R++MfajvYKDuI1hfBWRH7iEXpLFw2P4UG/YEbX+wtKyEtFFqi7gxbaQQPLGcfo+cTLCeGvMr3npFfLwZLHvM2wR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741273; c=relaxed/simple;
	bh=CBDo69zovnoju+JTzDysKnl4yYUcPigSQEEnStabd4A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KoCIFa7RitmZwyNPM2qohAfOrt75HDw+DZTjkZ2ZMpHJYjimQ2BzltiMi0mA+gefiq+dgS3SFrdoKSVL+qhY+l8WhtxG15Ve/9htguY62QrEbCsjeXw5+AOvtoGRLtQ+6KmShXYl5HR3rPrLju3M5K8Y5ewt5iH/7P5zajeJ7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbNasmyr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbNasmyr"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d933da14f0so90801685a.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741269; x=1776346069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1taaMkKWWjg5Ks4QV+8X6dfNDagm+Zbc5TRhawoNaw=;
        b=cbNasmyrlvYXqG7RFnivXU8SA5zGztNRZl8/EmpcOoMcJsImEZ1/sJAChzGQGEeyyw
         kah41jVE6QrRAMdmv+5a4V+Gfb10EUmNJvOi98iOzZ9C1iVCSJV1nQHXU5qCj+kwuuZn
         o+F2AyCqMAwL99+iBp9T/0EaBwQAbtYlcpIZiuMKSmnJF5k75Q238LWTG5aVpDvN1B0q
         /gY5QzZp5YQYGSkFcfLnbmpA8Dyf9AGib+TmqIhjcMLQrs0SzSiDwRrh506R6U2/3P1E
         P3GS4J+my7TXGgjV+QTgQ05bigJyTKh/z5Jg66uDESkMaC7utm/yXZI3ZhahjUOZ6dVv
         vL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741269; x=1776346069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1taaMkKWWjg5Ks4QV+8X6dfNDagm+Zbc5TRhawoNaw=;
        b=CLtHwya1RnX1uk3fStkhnl/BxjSvBlBfpbrqnNNHgiYYNgkxBNLHF9Gcnwl/Z/Px2V
         hxPDXLaNop8pveJaEgRvXkTppsmAhZsZvrB5Jy035Ks4RCrAn3a1Ga0ai3HM1wZYWnQL
         GPx0Vd/98A7u/7wu9WhCyHjgRJsS3pfATDur8+5GG8DOZRTXLST0r6JtlC2KPFwD20d8
         CRdguZ8IoSaBSZbA3CJoQU3kEHiFJNuoZMbVLTS+PQOXsxEEPxD5x1BMAhybb3gp1jyj
         w/RtAsI9y/Y1vK2hWqC6UubrqcofhYYeUQZ2t72yEBPd03gy3Q6/47KDQ3Jp5q4yN9FM
         PA+w==
X-Gm-Message-State: AOJu0Yy5wTCadLdLAwiUgjxKG2PX/cETLEHwQwlKgKYbeXIiwLrxXrW6
	PW+ZMIEOugnSQ+XG3w4XiZoDrYuLDhcU5DGCEk0/r86oHAIyhTaXjkJA2lXY5Q==
X-Gm-Gg: AeBDieuZJ53BBxesnQGMzOlVW+1H1I1oEUEx0mw0VXuOF3v2u5+alCxmYE7YLV/CEnm
	Hhzh5VjbDCb6xVh1Wp0E15Va/HBEKCj+fEnM5T7xDKEyfJJt37XJkhBwO+GDXyW5dA1KMmgu1mI
	JKmqHJbpSc61pBRKAIvpX8/AnUZQEQFbLgAQ3rD5mo6i1XdTf5ABaMOLrD9VxQvrljdKoFvhxUQ
	4LtHW4GDg9vw0CkrPsFGvYkjL4f8g3z2VoLMbiG5fJLkULUAVyMjiNaobdLHbslY7hSvTy7ScLu
	eAUFBsRAXircm2EfGz3ORd91APffqVNcap9T31LucGVjIMcZuERGlTi5ko03RvBYQnOOzlCW568
	2Nm//6mhB1zpfeb0Tib5R/PP59OH103tmKrqMxI0PdpYryCE9IvDx2+R1Ws01VThZM6XFJcR34h
	EHwWkJe2WHIQn0zhRpSiAMiFcD22I=
X-Received: by 2002:a05:620a:2844:b0:8c5:310d:3b2d with SMTP id af79cd13be357-8d41dd3eedcmr3472259585a.33.1775741269307;
        Thu, 09 Apr 2026 06:27:49 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593333516sm191600586d6.6.2026.04.09.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:27:48 -0700 (PDT)
Message-Id: <284075600aeb1fc2711be72ca201de3efd81e365.1775741265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 13:27:42 +0000
Subject: [PATCH v7 1/4] stash: add --ours-label, --theirs-label, --base-label
 for apply
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

Allow callers of "git stash apply" to pass custom labels for conflict
markers instead of the default "Updated upstream" and "Stashed changes".
Document the new options and add a test.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc | 11 ++++++++++-
 builtin/stash.c              |  2 +-
 t/t3903-stash.sh             | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index b05c990ecd..6829ba1140 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -12,7 +12,7 @@ git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
-git stash apply [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
@@ -195,6 +195,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
+`--ours-label=<label>`::
+`--theirs-label=<label>`::
+`--base-label=<label>`::
+	These options are only valid for the `apply` command.
++
+Use the given labels in conflict markers instead of the default
+"Updated upstream", "Stashed changes", and "Stash base".
+`--base-label` only has an effect with merge.conflictStyle=diff3.
+
 `-k`::
 `--keep-index`::
 `--no-keep-index`::
diff --git a/builtin/stash.c b/builtin/stash.c
index 0d27b2fb1f..54bcb6ac73 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -44,7 +44,7 @@
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..dd47c1322a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,24 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git init conflict_labels &&
+	(
+		cd conflict_labels &&
+		echo base >file &&
+		git add file &&
+		git commit -m base &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		echo upstream >file &&
+		git add file &&
+		git commit -m upstream &&
+		test_must_fail git stash apply --ours-label=UP --theirs-label=STASH &&
+		grep "^<<<<<<< UP" file &&
+		grep "^>>>>>>> STASH" file
+	)
+'
+
 test_expect_success 'stash create reports a locked index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
gitgitgadget

