Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C44A21
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067482; cv=none; b=DfPMki6EYjQlKfQyteW5+Q22duNIJzBWrvJGQhyRFbVdWb+HTyaOHbxQL8pC3kkPJefQ4TG+EL5NUBHIW5sYg7plt/qxao46VQLVkXYge4Paks97F9YJgKzDjVc5v+leIT9Q+w1voSZhzF4eyOHjeO1eFrjIVZMiM60gAVsFJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067482; c=relaxed/simple;
	bh=1Ro8Uj4YDQxpuAhucvys/CAfwnfMvnvz91xDyOoa19A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BqKAYp5WYqNlrkswn6MKIgp0Vo+S7pkTuL/CqmpFJ4j5EkYQ0ksG223Jpa7ofVA08UQMILkcsONAkdEfikVb0gf5ANenabCjO8Rtfawgn8YcUDhKd/EJjx0C5ucgiMNzn0mZctyDHrpAfQBhugdchqFeyXugiLV9l8pnuGkuP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhooZ4RN; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhooZ4RN"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so951679c88.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772067480; x=1772672280; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ULUPPof3mh9zbXIYly4jkYW7ZHcWyIxsKOi+RmJhCo=;
        b=BhooZ4RN/3/QkpluQMJTdGvHGcuOsAD6hfhp7b6GgiYoGCdMDsIYdbOw/3891inanO
         7fRzIjDJTLTiQ8y6mWP4eDwQmpCfT1hHpaxn57VOqqik+YltDXPEyaSqG3nHzzjI1cr8
         66VIOkU30y8JHUMs+KwgvgRRxZYCqiwiflxnCKNftu3W1mpIg0QmNLz//LZ6vKnvsLy1
         0qz44gwX9JC2wbNUBRpHF8/f7hV8o2ZjvqdX8gAWa/n3ac/25DN8IY4pYeaB/FdQvK1U
         CAY45nyJZ+qvR18CfMKw2Ob6FrOiTxXK2/PtZL5CuEGTbkJVqcC7T88oHUPFW1lLpRGD
         e7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772067480; x=1772672280;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ULUPPof3mh9zbXIYly4jkYW7ZHcWyIxsKOi+RmJhCo=;
        b=AX7Fyl+Ok5oymea4D7alFKPmOyrGORxk2QokgjHI4+z+6BXDziEiz6AHX9ICM4tL9r
         tfulQ/SMRbbd+MaSCs8wU37KXwkaNC7/KODNu0Dwcjn3Rp19AZTMan6solUkucJjNmep
         GVfDuLJKVY5OOxCjQJFyaCGWIPlDMBESMwDEz+NkdhsF6Q+T5bBJHi9ltFFaPWLvsHfn
         PkXbN7P7M7Tm73R5ylMXyzP0tAmSlz/k2q92Uc0NneSjReAUysxKHgQMsIkXZL0Jqvcg
         H2gBqoEIWEU7gutjj5AL2nKhHLVP072lKTuZfVd2Fq37Ggv8lJqJkvbrYx2ql29gzhc7
         iQWA==
X-Gm-Message-State: AOJu0YwUkBIq+nEhyVIXVvkGUgQNDfxBIk8bwOdaInqEzuqhig8FAXNz
	h6A9Ih1GaMWEZ18iAB9FLCJTzMRQsI5hmi7Ibc/i323vKTVBa/F0K0Aa1RH5BA==
X-Gm-Gg: ATEYQzyrxyURzrmN4h7NzjW57j26JtAjw7d4+qtTGPPmDKMuRffy/GWkHW5oGleRAZd
	sWJIaSJiy+xsmGI8gBWROeC8TJPbGQpdy+5gbdfzZIsse3ENUrOwzQaJwVSr340CbrypKnm5JOS
	HNOdCzqmDTOix4hCz5E3KMt72NqA1/cj9uiSnFeIp2Hhc09jAdi1/lpQlGecS2cYXjHAf1RzxdN
	RvATOUICzPhuECb+q5lFVMaIiEwO5h5hKaE8davo1UX0uQ5buTQBgD0Kr6D7fQ6E0wKX2qMn8n8
	MX7b40iQVjZpuG7MT/ryf8xy0P1uFtlQ8dn7uJ38mFMR62ZzWCxstRChaGUNvA32cxJVrjX85Wi
	dnyuHEr+zsPOVxF6ZxnT+AuUqAlnBXhnDe7lsKyTXgDTXOlB2k4PvvAjhbG6iAkpvF83S90A4D6
	9ZtsEs8KqPEVSpWKlXreOkE88S
X-Received: by 2002:a05:7022:6baa:b0:11a:3a1c:6c5c with SMTP id a92af1059eb24-1278693c1c9mr1283704c88.3.1772067480026;
        Wed, 25 Feb 2026 16:58:00 -0800 (PST)
Received: from [127.0.0.1] ([20.168.109.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32dabsm594391c88.11.2026.02.25.16.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:57:59 -0800 (PST)
Message-Id: <pull.2050.v2.git.1772067478775.gitgitgadget@gmail.com>
In-Reply-To: <pull.2050.git.1771911268805.gitgitgadget@gmail.com>
References: <pull.2050.git.1771911268805.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:57:58 +0000
Subject: [PATCH v2] t7605: use test_path_is_file instead of test -f
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi <mansimaanu8627@gmail.com>

From: Mansi <mansimaanu8627@gmail.com>

Replace old-style 'test -f' path checks with the modern
test_path_is_file helper in the merge_c1_to_c2_cmds block.

The helper provides clearer failure messages and is the
established convention in Git's test suite.

Signed-off-by: Mansi <mansimaanu8627@gmail.com>
---
    t7605: use test_path_is_file instead of test -f
    
    cc: Lucas Seiki Oshiro lucasseikioshiro@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2050%2FMansiSingh17%2Fgsoc-t7605-test-path-helpers-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2050/MansiSingh17/gsoc-t7605-test-path-helpers-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2050

Range-diff vs v1:

 1:  11724e9310 ! 1:  0a0c9de263 t7605: use test_path_is_file instead of test -f
     @@ Commit message
          The helper provides clearer failure messages and is the
          established convention in Git's test suite.
      
     -    These instances were found using:
     -      grep -rn "test -[efd]" t/ --include="*.sh"
     -
          Signed-off-by: Mansi <mansimaanu8627@gmail.com>
      
       ## t/t7605-merge-resolve.sh ##


 t/t7605-merge-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c38546..44de97a480 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
 	test 3 = $(git ls-tree -r HEAD | wc -l) &&
 	test 3 = $(git ls-files | wc -l)
 '

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
