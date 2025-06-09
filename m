Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF5A92E
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456998; cv=none; b=pzmMeu2GxhK3GlzhjWUd+rnm+v21TKuKTpXUo2yNOETrRsQqGOgUPMVtj39gYdgb3QwM0zqGSIP62JIa67mCqBJX1u6cIB9mifdglaszUQ57E6V8fe/j+VlJu1ihZ9N/egBqJ+dcsRz+oYUesRLqU25KFakdMtPPa7qWrVngLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456998; c=relaxed/simple;
	bh=s30IHeri4Jjx/yU1sH21kpM9lNCnugA/hGEpg4I1dy0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lbAeFdWHp/Sa9rhTUDpfzBI8y8Ni9fMqQKgLqtbzZQ0ntfmbouhQX+5GiVosvH8DIh+6IA4t9xBpAYFxg0OzdG8soUl+JK2yy67t5k6THr+3rq20UwLJH8gYL5BEo9vpX0J0bxalsb7UlGwGHXD8zCpCANh+Dycs4WaagSuCe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXm4dOND; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXm4dOND"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4530921461aso8189455e9.0
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749456993; x=1750061793; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9aGIC7EGkNs/XsBDIdS0ipkmyKT5EztTQjA/Bz+5fY=;
        b=EXm4dONDM3whQjU5PVIGSFPpk9LWcWgpqM16Rpb/+Xjg1p7ZM0UCgFYedrTsxRz5JT
         iRqA0ngTknDAylGQuObI2HC09eiHaWa7/wZBsK+baZZFYZLPP3MLYDWNISa0RAyQl1e7
         HtPbs+GJCvVO7FITqZc2ADWgw9IkqoUAQD0n0ILTRXig4Io0NKyfoZcE3WZlZZYCs812
         ztxCIsdaPF6tHpsDgukyMlxMf+TcphjHYis4/H0+D+mKR3YZ0imroX9hyVEqwI4bHAWE
         8gtbfcgQ49+zmVtHg9GO5UeLJNTzdsUKu3FhKcJkpCNPKcx23F//LH+EML+dFZ6GmzET
         gVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749456993; x=1750061793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9aGIC7EGkNs/XsBDIdS0ipkmyKT5EztTQjA/Bz+5fY=;
        b=eyC2DJMeo2rzzccOwL/e8aCJxSaa+ao0YdSg9wk+N7j7kDtkqcBRYLdIWQ8Qm35+Az
         laAaZXmgB/00iUFZG6CXb0NxzHyjLMcC4tbVYSKwQT648pUFA1/noqv1Tf9YE7YTyE+J
         qxf6acD+s3PCqqKxInd3TJjKRbU74tD4S+rKqE6rupXaREKK1Fb678f/xc5u08rU1OVu
         aMtY4I2VjklLvX7vkhHnxhg0cGzAjVo6LhUevhN0S5jdLBJt7BQbeh1Xc9rw2tPzblYL
         MuS1T3lnPukgwI7pp3/YOY3NKwol+9qKRhrS+cRgk4PbYbB/hdPFRlAM758Y8wMfryDx
         6UuA==
X-Gm-Message-State: AOJu0Yxges2iOA6mQfHmQ1VwvvLka+zSIjAJBPgDTcXjIcI0uqsdgy/1
	izo5ctSSXbZM3wOshX072YV2rv6NWWseqnPVxMb/Yk9Gzye54w4sdBjFAGJvbA==
X-Gm-Gg: ASbGncuApSP9w9x9PqwMosPEudDJ5d6dhTjfi81SRLs7bqOgXMaDkxhWyMYJ3BN2wAs
	cnVf60YR5ydnUHQeHrNXjfdTxiWR1wBvRhk4QYZ1QLe3HCisOyLbQaLPz1CWWshq8wJPoND+tb7
	qBQcFRQtGIp2iNdATm+dWeT+ImttktE41285tm0Gei1OWKoNb2DkUBFxEUZxY7/EAavmhZvE1al
	5MT+17EKbr9gt0k9T+KInYGYUu061+CP02FTwcvwTh9g5a0SkFrZmWE2nkFGbIljLz+UMcp1lm+
	cnZVUyq2OV5ZNL5O0vvc3VZgrv3OODtw9KLo7aV86KF16Z721vPwg3JYsMIWgg8=
X-Google-Smtp-Source: AGHT+IGuZ3qJn0Opbpa68o2lDA6uaHNlEaPYOkjoa2HBFxRI7BzbJZTXdyMG7mSwnP9L9BXrKfMt/Q==
X-Received: by 2002:a05:600c:8b57:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-452014d5243mr123522455e9.30.1749456992915;
        Mon, 09 Jun 2025 01:16:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229e0dcsm9172770f8f.15.2025.06.09.01.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:16:31 -0700 (PDT)
Message-Id: <pull.1989.v2.git.git.1749456990648.gitgitgadget@gmail.com>
In-Reply-To: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Jun 2025 08:16:30 +0000
Subject: [PATCH v2] revision: fix memory leak in prepare_show_merge()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In revision.c:prepare_show_merge(), we allocated an array in prune
but forget to free it. Since parse_pathspec is not responsible to
free prune, we should add `free(prune)` in the end of prepare_show_merge().

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    revision: fix memory leak in prepare_show_merge()
    
    In revision.c:prepare_show_merge(), we allocated an array in prune but
    forget to free it. Since parse_pathspec is not responsible to free
    prune, we should add free(prune) in the end of prepare_show_merge().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1989%2Fbrandb97%2Ffix-revision-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1989/brandb97/fix-revision-leak-v2
Pull-Request: https://github.com/git/git/pull/1989

Range-diff vs v1:

 1:  5d213e2c11c ! 1:  61a2d98dad9 revision: fix memory leak in prepare_show_merge()
     @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
       }
       
       static int dotdot_missing(const char *arg, char *dotdot,
     +
     + ## t/t7007-show.sh ##
     +@@ t/t7007-show.sh: test_expect_success 'show --graph is forbidden' '
     +   test_must_fail git show --graph HEAD
     + '
     + 
     ++test_expect_success 'show unmerged index' '
     ++    git reset --hard &&
     ++
     ++    git switch -C base &&
     ++    echo "base" > conflicting &&
     ++    git add conflicting &&
     ++    git commit -m "base" &&
     ++
     ++    git branch hello &&
     ++    git branch goodbye &&
     ++
     ++    git switch hello &&
     ++    echo "hello" > conflicting &&
     ++    git commit -am "hello" &&
     ++
     ++    git switch goodbye &&
     ++    echo "goodbye" > conflicting &&
     ++    git commit -am "goodbye" &&
     ++
     ++    git switch hello &&
     ++    test_must_fail git merge goodbye &&
     ++    git show --merge HEAD
     ++'
     ++
     + test_done


 revision.c      |  1 +
 t/t7007-show.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/revision.c b/revision.c
index 2c36a9c179ef..afee11119615 100644
--- a/revision.c
+++ b/revision.c
@@ -2060,6 +2060,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited = 1;
+	free(prune);
 }
 
 static int dotdot_missing(const char *arg, char *dotdot,
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index d6cc69e0f2cb..4eb824f2e39f 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -167,4 +167,28 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+test_expect_success 'show unmerged index' '
+    git reset --hard &&
+
+    git switch -C base &&
+    echo "base" > conflicting &&
+    git add conflicting &&
+    git commit -m "base" &&
+
+    git branch hello &&
+    git branch goodbye &&
+
+    git switch hello &&
+    echo "hello" > conflicting &&
+    git commit -am "hello" &&
+
+    git switch goodbye &&
+    echo "goodbye" > conflicting &&
+    git commit -am "goodbye" &&
+
+    git switch hello &&
+    test_must_fail git merge goodbye &&
+    git show --merge HEAD
+'
+
 test_done

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
