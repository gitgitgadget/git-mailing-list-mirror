Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68926535BA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777283; cv=none; b=ILh1v2Jkjc7JO3bcjCDjU2lswpyg7bW2ezUdgD5Mk7nTyo3XJ8lGR4Ddw7L6zX/CARC0Jg/dKLDMEJGFWev6pIERyHMr0K4CFW0SYboZUXqyXfulJnbGdxyZCGEr+PsBuyBkBor3xc3ksGEGS3JweJlNChjLm1ZelHfbXVlPc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777283; c=relaxed/simple;
	bh=FmjSm7ZK3qPwkNrrzNKuLIaLhM3BhZPGjOVa+wOulb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTYHn30T6wOCi/c2q9pHzhO5SLchPsa9JIbextRz/M4KjXITE590+z3FiQy7A0DU/M3soV5LCJHBY7P1uOXgM/0ImTLIacKleZietI1YGRresg1Jq8k7/E+Qfb48T+SVWOIXX7qwpXidRtU7sanWx9vgsNkAfzAfT9FSvL53eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0zFt/hf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0zFt/hf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso2996092a91.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710777281; x=1711382081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6Uo5gRiOdS5veOBIOXl8WmoDbtFK98mTYCEGqQcRps=;
        b=W0zFt/hf9dG7fBxq6dqky2McIJ1yA99ubwz1jUEM62tmU/67n7RjOixIVEp8SFCz53
         H5v8IlKhZXKb0T0SuPR9lEuSaTK9RuaWtzT3DZInknw5oZqmBmBgkYMKSst4KS3PJgBA
         OKeCXQqr+aAvEtB/2YRzrfaikuoOdFOg2HJTW7pCbW8juv93Nc7RWz3RMz9ZC1p8dyGp
         t8Mw6mBte/jy+Vsb93429vLfdJ7VlwBjzNvl+H3fUwOz7f9794rTCqQGcxsLmUcb1dQ4
         GB8TqOW+SnnMpTuzWtBmraMa9JeCDhmAdcc1pV0OrCRsL654JvZPs+YqwHEi+EspYY9Y
         vPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777281; x=1711382081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6Uo5gRiOdS5veOBIOXl8WmoDbtFK98mTYCEGqQcRps=;
        b=iajkQZN78DkHtmXZLx9KqxJrmOy+gtlHYnXprzwFFFj/bi9x8wY+t7e22cSUvhIhoo
         Y849n5D9z0U7r2Gcz9BQmUB+X3WVln+0bq/U7SL0gMgJvq+215k3uC/fS+Wa80W+8uKh
         yeh31gHyBohrwS0oIFP+IbFTNuXPLTC35csdVqn/gGJpFk/iqnTp5ezVo6JgMWQpyQE/
         FIrEA4+pvSyqJwTKAYbhAenhppm35uw3r4+rDvJeWQCc0Appv+6fXjsh9mEzZRcoyT4m
         PHxEF5KMKklrNFPcGEnh2msw8q5syFo8G+fhDa8whwnKdGo22uIv/hriMziePUMxS4jY
         6PyQ==
X-Gm-Message-State: AOJu0Yy2juLywG6PpiYVnlTNxCw5BpT9PRPBcYp7CmUGEgb+mMvbiY9/
	9tl+vqbZVUg8cJadBIMMjnGMPx5fzoX7VRz5WzHPjDlFAUxOzjc6lQ7AsiI9
X-Google-Smtp-Source: AGHT+IELXNh3SxchSyaekE8ruAQo0hZN2n2ddUtXGNsNZLYsruvGIN6NiC1edJrBmAr9MbAp88XMIw==
X-Received: by 2002:a17:90a:7785:b0:29e:2b58:ba55 with SMTP id v5-20020a17090a778500b0029e2b58ba55mr2302pjk.20.1710777280764;
        Mon, 18 Mar 2024 08:54:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id gd1-20020a17090b0fc100b0029beec8e86csm7844922pjb.36.2024.03.18.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:54:40 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 2/2] builtin/add: error out when passing untracked path with -u
Date: Mon, 18 Mar 2024 21:22:01 +0530
Message-ID: <20240318155219.494206-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when we pass a pathspec which does not match any tracked path
along side --update, it silently succeeds, unlike without --update. As
--update only touches known paths, match the pathspec against the index
and error out when no match found. And ensure that the index is fully
expanded before matching the pathspec. Also add a testcase to check
for the error.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/add.c         | 16 ++++++++++++++++
 t/t2200-add-update.sh |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..7ec5ea4a3e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -24,6 +24,7 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "sparse-index.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -536,6 +537,21 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			}
 		}
 
+		if (take_worktree_changes && pathspec.nr) {
+			int i, ret;
+			char *ps_matched = xcalloc(pathspec.nr, 1);
+
+			/* TODO: audit for interaction with sparse-index. */
+			ensure_full_index(&the_index);
+			for (i = 0; i < the_index.cache_nr; i++)
+				ce_path_match(&the_index, the_index.cache[i],
+					      &pathspec, ps_matched);
+
+			ret = report_path_error(ps_matched, &pathspec);
+			free(ps_matched);
+			if (ret)
+				exit(1);
+		}
 
 		if (only_match_skip_worktree.nr) {
 			advise_on_updating_sparse_paths(&only_match_skip_worktree);
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index c01492f33f..f6a9615d1b 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -65,6 +65,11 @@ test_expect_success 'update did not touch untracked files' '
 	test_must_be_empty out
 '
 
+test_expect_success 'error out when given untracked path' '
+	test_must_fail git add -u dir2/other 2>err &&
+	test_grep -e "error: pathspec .dir2/other. did not match any file(s) known to git" err
+'
+
 test_expect_success 'cache tree has not been corrupted' '
 
 	git ls-files -s |
-- 
2.44.0

