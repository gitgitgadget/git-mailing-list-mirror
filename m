Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9439EF1C
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979153; cv=none; b=CAi/EuMZksvoIqu7x2ofxut9FfBmDa75whDee16gIjhfuavN5EQIV7nQ8UQJIxixQIfAZWsLbBsc9iK2aLQfmXLKkz72YJHavn8PS5I+WsKMMYDWKzLUsko6oh8zvyzZ9iSgw1ejKXlZEMYQnuTHUvVyBim4bHLVFuBw6NtrNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979153; c=relaxed/simple;
	bh=PVFgTwX2p4jaVVrIaUUQi/Sbwfmh/ev3/LdCuzX7+X4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HIS/qZ4lbm6u9SzSZwkZtMQ/ngX3vkHcZN87GC9yOMMYM4Mk1aGH39YXOF4DTnbNzRhdeEKyWTqt6VFENbelotn8OdshEL98y1I0iZrcIYQkQo0gclzIillK0SYwUnEDkK48ChQH+Z5BVPlaYAZqG/TtShP0kbAB6lsS4xDFLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6hu/S6r; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6hu/S6r"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a4c6081f9fso269033b6e.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979151; x=1785583951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=X6hu/S6rx83rL/t52fzuv2d07mG+5sdF/bqqA2YslVvNj1XU9fUkmJy1DeIMu1Ewr1
         vgeG5rDmYkteX9KwHYPQZ+qVKT6biTj7yvtsmVP7+HWxlOKkBBpFXpnTIv3SqJ2VTeeI
         IeSW2q/UySfIi0CzJ3OrhtnLdPiU06ugLB+IAFwQu0zA1qevIp4Woasuo2LzUHndK3qm
         N3CrtXng6CNSI9lN9QlFup78nIoD1ixRk/7RRf6O8yzJSEs6BvVppx9BSB+Np58fNZB7
         UiOBKZI1Lbql7xZb7ivf/uR2Te+haMp2EXiElkwO3KCpqNrSXm2pEAYcHvtwmMPZZjVM
         3OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979151; x=1785583951;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=rvnpLwXB2DwDfGCiTxekCLg0wRdOcS/zQQRQp/1vYwL3U1JFEXkn2yFrHKYFjZV0+D
         gNRMtoiZbDgIOvusbV1b+OHK9D4uT9peEjYsD0nXM8vn7gTTVGOWhaL17I4z88p1e79S
         09f5PU7/H1kfTVCBIoSkq0shAtOK6Zh46fU5NvKwquz/I9GEhRsdAP64CGF+wDJ7l+09
         n1tM6qtaJNzYYgQCAI/5MeilLQHKcMwPnzP1QEttu21sfRK6kXQkIeGSSzNutyShv6ag
         byAQiv99VYrgX1xdYpQbmdMQNi4Vp0BjGPLBZwvwRACzxBjRSVvqp7wjmxeG8aqnvaZq
         oaaQ==
X-Gm-Message-State: AOJu0YzoUwvlK/nWYEcEnt+xzYwJ8QQwjgES+YSzxj/+1DYcU94M48yk
	V6RoOwfe+I0Y1E3Cvl0T6qGOfc/DmN7EeR+VTCvTLGNC5v7AM+JI1Z0ki4BMWeJr
X-Gm-Gg: AR+sD13M3k4K7V9kXyP3dP0L++SK5I/4IVAbIj0246/LrzguzeiO1PVm5PLaB1EfXXn
	UF8EaThstmw07HxLKDh03dUA6q3vZ46Yf5y5J6EAtmxvq+7jJkaLPoohAZ02cBi4LfDX+Io8C2S
	7z7OGllhsUj2CZhnqfR0ukEexwFtuQD9AVsbXhLp1EsUt2aHW4+zlwzBvHmLn/r6Apcf6peTCf8
	Qx0EUB4E26eTnweqXTQHew7U4tX78TXtMIXg+j8bHxV7LusuVAe3EtJXfXurP82SzlS1Q2BDDh7
	9uG+RzQdVNm+EGxbf3iKrK78NlkGMnDKrNtQ221lKAVQlbaHbMwb5TW+C7x7B+S45zqSfGJTlob
	Z6rXCj3NUCBi+sHoDbfEJ5iwYpxR2vbgAbdj2VG5pB1Ig0IVzWESE9JYSaYwiZzwzCcqmZIG7Sp
	aDbDtT
X-Received: by 2002:a05:6808:1511:b0:4a4:6fed:fd18 with SMTP id 5614622812f47-4ab6a3c8450mr1854195b6e.37.1784979150931;
        Sat, 25 Jul 2026 04:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab3505ac2bsm5357186b6e.10.2026.07.25.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:29 -0700 (PDT)
Message-Id: <606ce4082cdc1c3a5a33fa4615374b5f00ebfdba.1784979136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:13 +0000
Subject: [PATCH v23 4/7] branch: prepare delete_branches for a bulk caller
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

Teach delete_branches() a new mode for the upcoming --delete-merged
caller that checks whether a branch is merged into its upstream without
falling back to HEAD when there is no upstream. Existing callers keep
their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 504117d1c3..1ef8362c12 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -262,7 +266,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!(flags & DELETE_BRANCH_FORCE))
+	if (!(flags & DELETE_BRANCH_FORCE) &&
+	    !(flags & DELETE_BRANCH_NO_HEAD_FALLBACK))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
-- 
gitgitgadget

