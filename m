Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C262144C3
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436290; cv=none; b=NMDlUlbg3eLoqL50nZ47oX174PjnpguOBFfUt7g9Jar0bjDg5+XW2ML4mhOEuqLA8khtxAaNKVHYXzSc9/v9Y6E/1MA0ht7y6WZWA1OuBl4kXZOCL8bt5EdRLrqXjAOqph66kDYLS4aSkO6eudvJUDFfjf900F6UYOs87DWM2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436290; c=relaxed/simple;
	bh=g5N+/trWCnnZPkzxzjZXamw4Zft2/X4SOI1UNDsaizw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CpximAWKmksYAIKQiwKzbUIEph3gRdUriGE4hFe3WL4x/DZjuSORWkV5r9uOF+ZY+6EBtJ2s6xOIF+0L+MQdccaEQLRpNfsOpRoa8uV1h/vlJwGjk7RMbb5q7q9w9RSSxMPg2l6wejxxxAjc2JIazVLdN7HcBqOSML1YQoMVhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDSG4LVZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDSG4LVZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913958ebf2so3575092f8f.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436286; x=1744041086; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=ZDSG4LVZU69TbCXtNENcO9fr5afaxKeE4EGglaV4tOzjsNgfsdVD3Smz7pw40bhwGT
         Gj8+RSnUTWf0CxZfCKhFRaiVIQ5J37RZqEFGdPsF1WAOdG3pXa2Uj31velaVuDjVjIwZ
         fPN7b+Tm0UlCsVa+KVjkgleNublmWKYMilV7BCjEW7KGql5ISSnaOGfp0nai3QHUwR6I
         Snwo0Qoatsi/w3PckJGbn18es4ZOJmbMGnOP5X3B/wTaat8oE0P7RAbN+haDvMGxq8Jq
         iHqwlN6mR03fKaVm6weuEDvyBCo7igQPxdejaU0az4IRc4vrn2K3KuyyegJfYVaPskYm
         6rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436286; x=1744041086;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDUFwTWnyfdEZ603Aon99l31Fux2UGQLEUtoIF0xayQ=;
        b=SUFtSm5lJQ4tiuh9J15+T0vX1hCs6Mto2IyV0AgrJfnfiIPBB0QWzEQyKC/c51T0vN
         sOMuLdxT6Hf64nBWgvzj+BCKfuI9VO5a4qcUM97jDkvwy8m74EhB+KyxAMJNm2rq7P1i
         ffEHXGz2uokU8ZyIqNVSIOU0DRscQc2Iox8dcials/10VzPKlNFJxvCT3+BdbBqULwg9
         LZKaq8Jpw2dioSXl/BuiruWEHnrq8zfYoFba7KnGYJc9RYBCZKrNWnov3lCER7ZFTWV+
         jVf+Q7Iarw2bPsCUngnOkWCYPROynWcLFWfiAQVj+rL8Pm8EAK2s83P+kYMtxO+/oqWP
         +9fQ==
X-Gm-Message-State: AOJu0YzN6EQWaWCfcoULLdcRKJIUMQJfsmPW7Lua17IMuz28RG7OPwqm
	1iXLRSCQaVbkogzTAVuRtq1Dun7aYFpnWFMtDPe/G7GvLvtya3tqJ0HMpA==
X-Gm-Gg: ASbGncujX7MTmJ2b1sA9pUXtWKsTl4y4gl4zImJn3ZiF2ULRkYIs1fsStapdAKjiCbL
	/8rgnA63fcIjc1h82hkOnxWTxw14qP3f2Ez7SPPHwYRwmAOzJQ+ki/1YwZ3SIjABEVQNbukl/Qq
	taCrlXxJ03P22MSyY/x/C0xr86SQmLGZFRJbei35JoYHY7MUFWc0nkrQE8JlZe9c7nIoeq/PzEf
	sD5Wr4gDhw/v0EK6lC6nYRvIR9QiQxjDweLFr9LuQpnHb1s0hU5Zcms/PzvXPb2TSLZTgoWA08H
	2piUvGwJKwuMSizhNh13RTRPcq8igGyz2EMd8YE7bndlGw==
X-Google-Smtp-Source: AGHT+IHGL4veXvZ686b7aTVTDbuB+RLzMoxWLHPJ0BaxdvbTOSkKuHF2eq8RB22U4RPwlpjweQ4CPQ==
X-Received: by 2002:a05:6000:40cf:b0:39a:c80b:8283 with SMTP id ffacd0b85a97d-39c120e3ef7mr6626549f8f.31.1743436286243;
        Mon, 31 Mar 2025 08:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbc1889sm125278905e9.16.2025.03.31.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:25 -0700 (PDT)
Message-Id: <91398ffd1e12e42fe9c9233a6ec14c448dea79ae.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:16 +0000
Subject: [PATCH 5/8] merge, sequencer: switch recursive merges over to ort
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

More precisely, replace calls to merge_recursive() with
merge_ort_recursive().

Also change t7615 to quit calling out recursive; it is not needed
anymore, and we are in fact using ort now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                            |  9 ++-------
 sequencer.c                                | 23 ++++++++--------------
 t/t7615-diff-algo-with-mergy-operations.sh |  2 --
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ba9faf126aa..c0bbdab7104 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -39,7 +39,6 @@
 #include "rerere.h"
 #include "help.h"
 #include "merge.h"
-#include "merge-recursive.h"
 #include "merge-ort-wrappers.h"
 #include "resolve-undo.h"
 #include "remote.h"
@@ -750,12 +749,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		repo_hold_locked_index(the_repository, &lock,
 				       LOCK_DIE_ON_ERROR);
-		if (!strcmp(strategy, "ort"))
-			clean = merge_ort_recursive(&o, head, remoteheads->item,
-						    reversed, &result);
-		else
-			clean = merge_recursive(&o, head, remoteheads->item,
-						reversed, &result);
+		clean = merge_ort_recursive(&o, head, remoteheads->item,
+					    reversed, &result);
 		free_commit_list(reversed);
 		strbuf_release(&o.obuf);
 
diff --git a/sequencer.c b/sequencer.c
index b5d91fd3515..8bb49735891 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4319,20 +4319,13 @@ static int do_merge(struct repository *r,
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
 
-	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
-		/*
-		 * TODO: Should use merge_incore_recursive() and
-		 * merge_switch_to_result(), skipping the call to
-		 * merge_switch_to_result() when we don't actually need to
-		 * update the index and working copy immediately.
-		 */
-		ret = merge_ort_recursive(&o,
-					  head_commit, merge_commit, bases,
-					  &i);
-	} else {
-		ret = merge_recursive(&o, head_commit, merge_commit, bases,
-				      &i);
-	}
+	/*
+	 * TODO: Should use merge_incore_recursive() and
+	 * merge_switch_to_result(), skipping the call to
+	 * merge_switch_to_result() when we don't actually need to
+	 * update the index and working copy immediately.
+	 */
+	ret = merge_ort_recursive(&o, head_commit, merge_commit, bases, &i);
 	if (ret <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
@@ -4343,7 +4336,7 @@ static int do_merge(struct repository *r,
 		goto leave_merge;
 	}
 	/*
-	 * The return value of merge_recursive() is 1 on clean, and 0 on
+	 * The return value of merge_ort_recursive() is 1 on clean, and 0 on
 	 * unclean merge.
 	 *
 	 * Let's reverse that, so that do_merge() returns 0 upon success and
diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
index ac5863e788c..5822d02d517 100755
--- a/t/t7615-diff-algo-with-mergy-operations.sh
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -22,8 +22,6 @@ test_expect_success 'setup' '
 	git tag c2
 '
 
-GIT_TEST_MERGE_ALGORITHM=recursive
-
 test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
 	git reset --hard c1 &&
 	test_must_fail git merge -s recursive -Xdiff-algorithm=myers c2
-- 
gitgitgadget

