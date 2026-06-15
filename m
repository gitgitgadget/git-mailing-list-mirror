Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D5408020
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542053; cv=none; b=IYcFP63Nf3ckttFFG5UQi0HkR1CrtSeh4dgm6EWU7AXRSKx+kAKjDeQ12DaJuWEJug0byCHNGzqRTvGAySOPvSss7Ja3bmFrww89UAF6JLA1n/zq1Fo59/uw61fVxtbL8tr3GLspH6u+T9uaO3tIm9YN4UEHUfv0IBT+q7YGUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542053; c=relaxed/simple;
	bh=NutoYXBg1C7XgbflVuG0jW+euBPKTNQMr3lJ1a/7C7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mYjJxEAt7Nwdxl+BFjBCGET2DQL4X7zSD16K9Ub6PRmLU1XWWtWeNdcX0LicX3R4MKjYvM4OO/4izlIKF2SURa45Cp3XnfRQZXc1lHwoK/jjHAAYTddDXzInnEHzMQoZ2aDRGm7hVeZQ6Amef74wwaXdknETJJe746Nr/CpN+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQWoyBJ7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQWoyBJ7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-306f36df4feso2460701eec.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542051; x=1782146851; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=kQWoyBJ7EKvPgUniejpqr+tbmApEbeRwvtCxC0dbNe9mQwo1QnZ0afXHCFQVCdW8Ko
         1eZBM8hKwb7pLkTdcLVuJzqwFIq08VWvya+k7twP58lEAhSMEV45f0zikU4+6nt8Qq50
         WYOpDX6iG5xioHp6GT8fOt8jmmXIebK9Oy2nf+nfk18iFaAf96lLxP2yUjK9/nEZ5ONU
         GqUmeIqHKOl8dGV1wikrF4ypQCoXT6yU2EPkEYiqBm9LbECjHVkP1Suqj3XHBo+aZNif
         QTcRUgtrmi0IP//5NjsVBavYHV7t0M2r/gjxam+PAs1npeZMyvo4O1LgEZ6lpCEqdSvQ
         p+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542051; x=1782146851;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=THFdyqUHNXQ/UDzG2tSS8edFEQOu+vgNl/7cJ39/htQY0zxrkd5D4UgBei88uF+V/R
         ZUtMudfyS7KffIL9CvRhet0Ya8Q3m3yCfyUxXa8Ln4exbmtIeN161sFLaPLSYaADCT7I
         DdOIYOp/pJX3zE1IuXhB0pEvJd3X7aKXSXTPXM3oKoq6EW5io5RowpsZjsLIWfDZDfS3
         VEEmbHMki+cC+3jctjQflzIFtd5a2TBKYeDQrQmv1+eLo6CnxqJVf9qWmPQ0G2/BwIAs
         ehx5t7elCsvmKGoFobasRk0xp8mGL3jxnvM96kf3SikJm980tmTA0aghltRvowbG7zFr
         SI0Q==
X-Gm-Message-State: AOJu0YzSuYqMJt3NMLYaDeZ/5xiDd+kAhJYXJIBrebBpUDTf5K9+gtcV
	aKMKmCjOvT3RI2sQM/LBrvQJdUNZL9eQMO7AIJhBgAc5mHWZiA+2VjL4XcyOWQ==
X-Gm-Gg: Acq92OEs8G34sMBk1+nrMFQ7ljLG6UFSAI3E16cUH5DGIwzsLWfFqsRm2mP/n6av5yg
	d4cYnl7+YqeXXItDb/aySklb1B7evvmyC6TDdcTCwNoMSuBJCHoio6EsUd6DYPGK1L5c22nHUNA
	mpt3vC4jM+vS5cfAeLUNk6KMr/YOTqsx6Jb8aFdAnZjTC6h09U2pjUwRHHgruzKdhnuZlCoRZzn
	p/U+nX6Voo6JYRWM5zV+bdB2WJBJn4WA8AMtJZH3WKtpqww/ZqTExlQBjsyI186sisTySeHqINP
	f542BBKLb+ViEW6XqR5jQ8cJ9ZKKlhYfc7ojq/L1G0T5HPEcIvJyAl09u16ZhRsyNK3C/SLki/M
	iU9A09eR5OcWxnRmRMiQOG1cUakDDT+MMvVYEUNf75ZqF4jFPv85W/daGhzrTFVvIkt6l8423OC
	lCf27/tmavSc2SysnxKRZ2cTy7
X-Received: by 2002:a05:7301:41b:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-30ba38076a8mr98838eec.11.1781542051468;
        Mon, 15 Jun 2026 09:47:31 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm15208657eec.25.2026.06.15.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:29 -0700 (PDT)
Message-Id: <e101dd2886ad0142480bc134911674d08812e42d.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:18 +0000
Subject: [PATCH v15 3/7] branch: let delete_branches skip unmerged branches on
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
 builtin/branch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a9be980aef..4c569d056a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -199,16 +200,20 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       int kinds, unsigned int flags)
 {
 	bool force = flags & DELETE_BRANCH_FORCE;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!skip_unmerged) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -235,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	int remote_branch = 0;
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -319,7 +325,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!skip_unmerged)
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

