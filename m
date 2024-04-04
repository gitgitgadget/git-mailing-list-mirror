Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69F59B7F
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223579; cv=none; b=PyjfshE3PY1jeRA2bBGJshLixh0RzupCFRikcAbckpOym6obY2TyARdMg+GVmzyjSL9bVVaDyx9rQ0sul431FDOdkrU3zypU5ioLhWgyA8lnBc6g4AHC8AeCgvbH65rjZqmfQyQxPxQzOg2ENZF1FegHW8l8NWeP0QII8jW9wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223579; c=relaxed/simple;
	bh=/vQqJ4ZcyYmwncLD6dPYNN+bXZLBIhbd9X3L22MNoUI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Zkv87SnMmCcRBN2P8fJR405qOv1flQCh07szxCl4sYVxwhq/AbBPfmA1kq3O1X86qJdxQvUQgT7G3TohMGzcbOcCoTpTz+cNe2JmrYOu4D5fQz0MS28tmOH7P4zd+Zf8yIuEQ2kgPQYlqv3jROi7k+PDW6bVfr3qMnRgde/qWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY5EtnYs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY5EtnYs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4155819f710so5663275e9.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223575; x=1712828375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GlV+Km/hwg/e9W5geW7khwjFXM1pjm7NDw9gLZdZnto=;
        b=VY5EtnYssB94u0bE9+5VaJnOUG5WEc/Lqj3UoIjR7D9glAzrZpYsae9WY3jt/2dJVr
         GZ46pnVXj9XkVzUidVJjdB95mXCMcpLlGGf5Pz4kgoxJB5Vth2uWU2J01AOifL3CrXGL
         jyzUQ6IxVekYGyjcHeuJnoc+V4M5x/tPwSZOk1/XO2B9BU9yA3NVFMr+QkdNlcpvJAo8
         OL/O9nMHLhTOT4EDqESvbLmKSVbtMKeMfO7A0X7pLdV/DYxXAfpW+LRdeOlflzRnNlVK
         3Lj6Mbw7cT4Db+QVcb/AE8XnvQV9n+1aLjClAPTGovq5rmZWj0GFYu20eGKdiX22fwK/
         eZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223575; x=1712828375;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlV+Km/hwg/e9W5geW7khwjFXM1pjm7NDw9gLZdZnto=;
        b=ePSTvaTyiuob2T0l2ML8IHXJfugljkfHtgl5oCu0hEhUJMbxpmdhXnVKGVtpJnUp8C
         7r0DFGgbO2jHmYfqyFBF97ZJTiPco+SQQkyIEaCZV0E3jYJ3IsGMx+MMUCUz8bFzLoiQ
         cD2v3JYwOSN9KBeZV+avxrWKO1u5KwuuVTT3Fv1FjOyeMR5yjfYhPEIDqnbBwOwkJRkQ
         EV4y8VAg1okpmQ4/WWvGKBqCf/AZztRnYWrncchU7cKF7fD8uISX2fHhk6hwiS27Efoi
         v5FLU4awAG8oDjMWFvo/5V8P6ZLK2c+JHOa7ZSPFGuXkjQ0qj4pS0Q//HgWAXu8EDaZm
         7gzQ==
X-Gm-Message-State: AOJu0YyVTcwf3BzJP6txicfda6Hz0qaDpU0jSxUNSIjCoMkTbgtrneAA
	PcRApJ18A5xWBqeNXh1lFsbGQ1ZuDoX6aY6HRw9VdMiJO2B8qK8bb2pbdXeX
X-Google-Smtp-Source: AGHT+IGKbqPp8F9RIP8EN3XanE30ijnNmbNvaTHPGZHAGEaYoKilTe5N1Y/bKI5rl/d24Xaem2SUSQ==
X-Received: by 2002:a05:600c:5758:b0:414:22b5:c32c with SMTP id jw24-20020a05600c575800b0041422b5c32cmr1611565wmb.37.1712223574551;
        Thu, 04 Apr 2024 02:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b0041624540918sm2075221wmq.9.2024.04.04.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:39:33 -0700 (PDT)
Message-Id: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
From: "David Bimmler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Apr 2024 09:39:32 +0000
Subject: [PATCH] sequencer: honor signoff opt in run_git_commit
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
Cc: David Bimmler <david.bimmler@isovalent.com>,
    David Bimmler <david.bimmler@isovalent.com>

From: David Bimmler <david.bimmler@isovalent.com>

When rebasing interactively, --signoff would not take effect for commits
which conflict. That is, commits applying cleanly would be signed off,
but commits requiring intervention would miss the sign off trailer.

The reason is that run_git_commit did not check for the signoff replay
opt, and hence even though the option was picked up and passed
correctly, the actual committing dropped the ball.

The patch adds a test specifically for this case, as well as amending a
squash test which codified the broken behaviour.

Signed-off-by: David Bimmler <david.bimmler@isovalent.com>
---
    sequencer: honor signoff opt in run_git_commit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1707%2Fbimmlerd%2Fsignoff-conflicting-commits-in-rebase-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1707/bimmlerd/signoff-conflicting-commits-in-rebase-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1707

 sequencer.c                     |  2 ++
 t/t3428-rebase-signoff.sh       | 33 +++++++++++++++++++++++++++++++++
 t/t3437/expected-squash-message |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index fa838f264f5..16595e26a17 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1121,6 +1121,8 @@ static int run_git_commit(const char *defmsg,
 		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	else
 		strvec_push(&cmd.args, "--no-gpg-sign");
+	if (opts->signoff)
+		strvec_push(&cmd.args, "--signoff");
 	if (defmsg)
 		strvec_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index e1b1e947647..fcecdf41978 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -27,6 +27,13 @@ first
 Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
 EOF
 
+# Expected signed off message after resolving the conflict
+cat >expected-signed-after-conflict <<EOF
+update file on side
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
 # Expected commit message after rebase without --signoff (or with --no-signoff)
 cat >expected-unsigned <<EOF
 first
@@ -82,4 +89,30 @@ test_expect_success 'rebase -m --signoff fails' '
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	test_cmp expected-signed actual
 '
+
+test_expect_success 'rebase -i signs commits even if a conflict occurs' '
+	git branch -M main &&
+
+	git branch side &&
+	echo "b" >file &&
+	git add file &&
+	git commit -m"update file" &&
+	test_tick &&
+
+	git checkout side &&
+	echo "side" >file &&
+	git add file &&
+	git commit -m"update file on side" &&
+	test_tick &&
+
+	test_must_fail git rebase -i --signoff main &&
+
+	echo "merged" >file &&
+	git add file &&
+	git rebase --continue &&
+
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed-after-conflict actual
+'
+
 test_done
diff --git a/t/t3437/expected-squash-message b/t/t3437/expected-squash-message
index ab2434f90ed..d74af0bcf6b 100644
--- a/t/t3437/expected-squash-message
+++ b/t/t3437/expected-squash-message
@@ -48,4 +48,6 @@ edited 1
 edited 2
 
 edited 3
+
+Signed-off-by: Rebase Committer <rebase.committer@example.com>
 squashed

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
-- 
gitgitgadget
