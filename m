Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143974156DA
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053504; cv=none; b=SArjM9Pehilggdb+5XPDwUIH2GI/nYi1PKkoPxiB/66sgj/eooZCYVzQAnM3GQJHBxp53xogaou1I8crWatCY9aH1psTP+A6Ez6nc08cp1cMyzIXxszqVAJgtxO61OwfVdDhJ2ZFd5Vvzl4hUqYMKr/7P4+soSn/gTf5iN4Ibl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053504; c=relaxed/simple;
	bh=DFd5AJGwJatxxF6xl9s8IFFzSSnjCwMim0kF3iCbGVE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TXL0xqJC2l+Zj3IeimVAFNwNYzBCGW72pFEbQZeDl9E/zBAiGOkS3pLR4ttSzpWSPk+IQmZZ2YE0vxop8bbAspTv+YMrXJCbyDU36WHkUjmobLeANHDqw2VduqGDpUMIZ4ivNujJiAVQ7cHa8d6JoA71At/ucUfqRNqKy8/hiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed9R9+GD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed9R9+GD"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4281903a91.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053500; x=1784658300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AmN0E8K1U8ZY3t66cpRbA8aFDBHVzzl9/85stQtVtQM=;
        b=Ed9R9+GDTJmCoWAxVx2lwpfzuV4GvK8Ik6UXGFbqKb0FrDRwVZJhdoMRe3V/nQKClo
         cLUu6ODnrFlZ+BIjAgQOBPVxIhnBjNFMwMMJEWgx34MC27nImE3EHF56xW8BX4WrOdcH
         NHxeYTSiU+adhjPeGyWYjXE75F3VjUjQzGmjrzw+zRSlp4mQvLdc3FZ2FWgYprXTBlca
         ebcaaPUdYbvaZbfoUPNJ4hgiOIUUe4hfOmkrzencbdgNcyqq41Q2qlSmxADd1iv6S+UU
         KU5Pjvvtv0sEgtenn3l7ctJTGicI6s6irRmvrpir9aiOeD3HirJfTi/GXtVys+gjIEGK
         Zn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053500; x=1784658300;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmN0E8K1U8ZY3t66cpRbA8aFDBHVzzl9/85stQtVtQM=;
        b=IsVnhALINzKUFKD8qphSXjB1ZOQ39BurclQTTnPcyG3CVvFkw+EuSyNifalTMxze08
         BMhwWJromcyaowMSGkOB5uA0czIacn6uEektKm88p82t9aH5PwvtlEGpGAarVHHptOsV
         JINvjDaecjEpJmw404OvYwndAr+BvJ4X8jjK3viPCaSiYehCwSuW7p+F0cWnzZFp7tAX
         lyfAW0J+eucVpVYym02gv1acTofHiaHOQ1miAeXNBBqlhHM599UfgVbF3maSHL955F+V
         ev3bpFFj9w6n0tmeE9iQOY6UI41oEjVUCM0mjhRAJLR8INjQoPHAH5gMWwGMaYDkzybX
         7i7Q==
X-Gm-Message-State: AOJu0Yw5MvXlNJ+zwq4u3ImvCmk18s5p+J+Rz86DjGVR23WrMiRPp4dI
	oWGmSrnlKU74d6ktmKRTW2RAqaH3gaou9Ko9xmo5wpkwLSZrZvugvszzymqWlw==
X-Gm-Gg: AfdE7cmTY+WNlnCBnkNoUhmOKp6sC9Owhgf5z3LYgmb4a7ce0fjBOa+O5xd4jatjpEL
	QIRY6RX+FXBq6aOsFSUpx+iztlN2rki/d+eawa14rDigX7ShOfa7BVyA5XJz/i8YAkv5oh7mMkD
	ZsyHjuPfReA4d9MeuDiZKefYWgdCZkDclmVuFXhPFJky70ad3p5cPrAQj11N+Jex9dzG/IoTP3e
	xEpLAlw1yY7CJY8V0/iDNa4F6kvEm4yJVbcfEM5uoyLpL5r1p7SJAJ/RyNJjR99QkPAezi1xX17
	luDbuzqhiu2ZKVR7VKJde2Jv7VA0QlYxPPBuI/qQOJ3bg/NOUvXyzFRh7sq0HpFiklOk9HRW/Y4
	wtqqZpJwNaedxXuKQ57bcLEDUm7eRN5q3EKx5BXsQ97D5tdStbqHWYBg9+QTeZXxastm7g2WFsi
	V3iL1AXtU1aMU1W/g5XdFAOvUQPvQ=
X-Received: by 2002:a05:6a21:468a:b0:3bf:b68f:4682 with SMTP id adf61e73a8af0-3c11062ea08mr15282337637.7.1784053500431;
        Tue, 14 Jul 2026 11:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm35875001c88.4.2026.07.14.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:24:59 -0700 (PDT)
Message-Id: <0c4f3358e30c24fc909613c5f1aecf7b87b81236.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:49 +0000
Subject: [PATCH v19 3/7] branch: let delete_branches skip unmerged branches on
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
index e905a13a95..568ae817d6 100644
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

