Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC544252B7
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889385; cv=none; b=bd+srMR1Q0p2YelScwEaJVjY9WJu19/Pd06SyOKkhzMZNs9vHAPLWNrAjML1YYTWgpL5WsXh5St6VxjczBeEL7kem50AJu5gzVpNYEz6XFThqf/pmNbyCKnCvsaz61sD0+ocAmr0tE+e9KRJgTWjNKh0lqwPo9bokcjVq6YfQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889385; c=relaxed/simple;
	bh=w5sdqWSEAZIVQnbo46UE5UcLz/88iBb8Jnn82WM3TkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nk5pOP+UvEteVyKBOv0HI8CIZYgTh1SNaFl0AxsAbw/PN9AhvsCe1h/5GQn1Ri25bU8NjndO85oK90qZ6gkGlRshNpyV0wQetKuyAJcwxLyGIYmaUUliydRTV4oh22NVBvli2JUHqUMOAqBYtBvORFMjHHtydBXNc3YLNvOSNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7UNOZCO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7UNOZCO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so210467b3a.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889384; x=1785494184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=i7UNOZCOKrRwwz34VcWoTnixgVO/+AGyKyc3wzPVNeAVRlNbKrSjDlNbnX/nzslS4A
         Dr3uy60enjwmM4na4Is2KR47oY+1vwGcxQo2skM41eGoLBWEf41quG9uet81/xxc8PFK
         U4HbgY1RwKu+EhPvSAR8ERNh+ojofdmB2+9ZyVc9VUoFD5M3Ma7abWlXGM6SdnTSiaUN
         FGQ6C/TOW+Q99LlWloH8XKLdEgtngSSPVa6yaATeLz7MFC7XOkNRrwBb9nf0cr+WW/MH
         D8MKq2+VkE7ssueloQIPpR5P4bZ0b5hF0m2DHHGYbbP+/4HqmNUH5BtrWzDajsR1IaUw
         j1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889384; x=1785494184;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=Jzuh70CsazMOFJdflTBXwl5iWqe2ws3uhvXeX/vlPg84DSdiPnp7tSkxPqwU3Sg+tr
         g6Qc1Ve+vqZjXPtqkWSF7HJai9g/8GiMThwUCB8FRCrCm/4uyxgf9rpr9QGWM0F4t67E
         wF+1zuznsaJCClNkxwBjM08T2WuxRr1xoIYR4W8qrt9GFLew9xKA6hGkcmNWQSc7DfRn
         0phy30UvRX48Gb6ClfHHuNrPaooJbC5RNjeSNoVeF3ZQFDjGRIDv7A8f0cvE5CGRVrV8
         2FRsCczOFNJiJQrPbSgBgXF1bEDqkz6kh+UMiskS7j4TTzcN+x1murJwD6LbZ1MZ+Bjd
         tWYg==
X-Gm-Message-State: AOJu0YwocDyPQU5ti0V84XSpQDA2441I8A8Dgp3ENjCS3+4ozxXQ6wz1
	d7+aU4e0qXPMEhHK+iZfF2eMP/VcospZ3VaL3DJXvW+agFQ6sWEW6L7dBCf3dA==
X-Gm-Gg: AR+sD10u0/0mgwqA9LCCz7sDa1HkjBxxKZhSz3pbZnwa+eyTF+HKEozJYJlqAf2b/om
	58AQwvUZjUWjMVhHu482SlGB4b8E2CsTPfjSZ3kc5BsqScnwV1zvTREVfxO5U5J+GSSI5OIShP5
	fqcpl4V4R6M7jKPOHqQiPMsSkz66QmugHDXc7yb/v+sj2JeYBEhhWfm7HX/dzO1j4kPUwZr4Og6
	rxkqmRT67lPdhu+b/iWxw+x488nVY/axR3KW6yOTQRrV/8BZrnMKT382Fgl6/fMPFHsH/jZ0v7H
	QW8L9FNLpsltHtjLrKHU9dJ7PO3/Amh4flW7pYtecX0j1PZWXgSCTjkeojEzmRFeqy8JvV8z9XM
	pbkv/NYxL7uRIbbfyBcPsTMWZRMOxuODwYeCWycG+f858jBc0dR4GaeupTPpUKlE40oGIySnc/9
	bzcw5Nhw==
X-Received: by 2002:a05:6a00:4b04:b0:84e:2722:5da4 with SMTP id d2e1a72fcca58-84e2b8aa729mr7111410b3a.20.1784889384025;
        Fri, 24 Jul 2026 03:36:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1728566dsm4461950b3a.18.2026.07.24.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:23 -0700 (PDT)
Message-Id: <bb93303df348a5c6db3a7eafab2c1ea2c7fd2e40.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:13 +0000
Subject: [PATCH v21 3/7] branch: let delete_branches skip unmerged branches on
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

