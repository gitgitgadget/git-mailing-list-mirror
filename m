Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DF40EB8E
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921385; cv=none; b=TfE+K8EQV5gOMhw5JsJTBniUB4dH79BltxU1oniuQCbUwneYbmEMeShC+7zcpGSZ0Sd9BN88ze3rGJhbRz4vRs1a9g+t2a+kxCSbgC1A3h4CDHRQ2WfkWdmGmzfcCL5lFNko2s1AgYqsV/Pqlnkt7hTqYxR7qoNx4UGn0yOHXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921385; c=relaxed/simple;
	bh=w5sdqWSEAZIVQnbo46UE5UcLz/88iBb8Jnn82WM3TkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ez6E6Bm5kufWBAXWJSSoz777sUgdIGeTrb1Jj0Yd9j2wHyYzchWcbbdHKXVHoDFsGXAC0bicecZMEuOYyMdo6HAMu8sq8wdWrB3RSBsG5AU8a/2vYpb6YfmEjGe2xlsgz+ZZUBv1/FXmUWJUZtvX6FFG9OjcT8Jxg7FQJjZF9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONG5mW7F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONG5mW7F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce98cb8165so11283595ad.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921381; x=1785526181; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=ONG5mW7FmJ4yivGB7B8psAggIcoF9cwpRzpaymV5DD8EXqF0KnEHMcLQcZ7Q93S3w4
         Ji5sKzOz8fHTsIHvubKYYfuPq2o7igh3SHoqVfw8YOQGI+E9vOCdM4v0qTmo/H1vn5qU
         gqWCO2JEP7Kx/6KpSTebGO7XH+4GfZFkXEyGgLBKznguX7tjbwA6NAupKKsFyHpqsGWO
         pG+tpTpuK1k/FQf/TewdV0y13SpOGjpMsPs36xbub6H5milN83COJ6t6Xgv2Uyl87sBj
         X3nBWKkim9l60QK8A2IK7aArKT5oLcVA7Gd66ShdDVhTAvlnRYBlNRblftNICDTu/Ovo
         VAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921381; x=1785526181;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=eGv8/5D5fGoMg2PV7AUdVVbDvfirCdP+VEzP60iahH+VVT05O+2HYWS7SD7f95mZjj
         yFVaGbWIfck7V/r17dksduU7B6fAZ2L1suxBXrwGIxMAI/wqjOFtvizcncGgUDKfMj1S
         zpD0W4BL5UbqolATfvWGlEr/MkSHa35lk09R6BdHSMthhaPDS8SF/9IJVtt6W/02xjrj
         WGRE58oO5uzZmxoNbjL5VU2NKpMsurSlyPEWgvEcvoQAK4XDZRb7KimlngFd9suskv6o
         Pjq7P6VgRWCyIO1gU4IRZ8UWRMyOwMdvPsahNh/aVumEL578S8t6tzcN19wigDkG0oVt
         pFGw==
X-Gm-Message-State: AOJu0YwNfWAYHZTiMw6QWw/+ZaBkzmYEPC8uAUW8a/hEWvrIksW7gFiF
	FOBAHoBWJlZVsucCJsK8JQlu4TNtQDZpxoA+RHZgxvRzQZquiNMVAWCObcx7NzNZ
X-Gm-Gg: AR+sD13TqR7aDupI/cyN9O3VosjQRbIS1gBDubDrxCmk+Cmg2VZaYRKoCIHfSd39760
	1BQp7AtyQeFBFizhMl9DzGq7D3ojnKzovcmyBMQx8oNdjLjnyWowRcAux5jvrw0ccYacipqQ8q7
	fWnsx2GjCaD9PaGHlenSrpgeIcUNsnS8iIp5i+G0qwq8sfDUi69/mFuTGCu0YMe9fM0bP7DupRL
	3rQakRJAIsfqnpeFRZjEKVYqWvqXeVZeyDgVHI/fAebp5SmySFX2UQHHrc0F9kBbs/Xl7uRS7Uc
	K44N0LTj1JcmMMxtwJ6VnwdCDS4HNRWWy7gRq/gO8f1WAfjc+AQqXIHhbNVPOK9pFPB52J6Jskl
	eu+wuK++iaG0TDkBYSQCAnCh8FC3hdWjkvIFk73/hsECyOPpFSo5no9IPzzrtTdaGdmtaLpgL8p
	8tpvQQLQ==
X-Received: by 2002:a17:902:f543:b0:2ca:f417:396b with SMTP id d9443c01a7336-2cfd70c149bmr15905005ad.3.1784921381071;
        Fri, 24 Jul 2026 12:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm3483947eec.2.2026.07.24.12.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:40 -0700 (PDT)
Message-Id: <bb93303df348a5c6db3a7eafab2c1ea2c7fd2e40.1784921375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:31 +0000
Subject: [PATCH v22 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 09631f93f7..504117d1c3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -205,10 +206,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	}
 	if (!(flags & DELETE_BRANCH_FORCE) &&
 	    !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -315,7 +319,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

