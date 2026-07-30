Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23343F4BC
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419924; cv=none; b=BKj8mzfU17EkHXBCf+TNhRd6HIuuczG1sec2pWA1pPQLHPv76kSfE0JLL7GP0+HznvcfSTPi4sbdhrTQ7gHuY0PuQo1cxOSPxQ+sx2U1woIsuCi0XRKEQBzsmy7aa89tKtW7w5VRzyl8dIihEAJ7qpP67vLl7ATnq1rjlr+vmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419924; c=relaxed/simple;
	bh=oZxcyKEgebUOznRHTj26KqhhWGf5WTO8oXdFz8wKzC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GuaIEeZ91ww0bKiw0CxCiZFgkpOG2c01iJLsOxUUVoZrh3dUVkwhKURZiPBhBraFAPgyVZ2akBcbn6rp/okf8MsN1iOkJCqhGq3NZxLRF7MgSfqZqQMwXaiUOiem4wSvUAuzMtpmzXQZi8t4wyVx8yzIG5nZLuW6lAsolUV22QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpJNm6aZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpJNm6aZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d02b4c3601so18211535ad.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419922; x=1786024722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8qQ7Ma5tZlqfL2G15c1hQMz6FCWNR1N6tn/tZhDRzE=;
        b=WpJNm6aZWdqtJFPAauGW/cTfrMK/X/kfPK3lXEpK+F5MXA4R6Luu3jYjj3wKc1ByrR
         q6qrRwgdzO1lXaXq7VCAIZCzKDeJMjVCrjoqk0pEVFJX3RsE0JOtgeldLrpnddS/ImuD
         Ojpq3vx9mUHZfRjqgUi05n4H0FOMS4lqKX6iLwcbHcNFJMSXvWZmAKcVHtFB3iAVqII4
         1xw02nMQxo/bQBt/x+4X+orif0R+3/hU3CE8vItk97bJIWE75zr220FV09D+S4cjD+i1
         JYK1RlFwboKjp0s8QJltCtti76SIsoYYfdQbs9PjSGCo3bLEoMomR6MhGE/n69kp2Cjp
         DdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419922; x=1786024722;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8qQ7Ma5tZlqfL2G15c1hQMz6FCWNR1N6tn/tZhDRzE=;
        b=fZvDc05y6fEX7WYhbsvGVABKf/wzAqCkc3yLiyC8W6aJJ40L2XC1MljJjvP5uJoGrZ
         7ni7mKubuXAZ1T/7GZTpOywfy31y5QbNNHipH/11hgDSWDFkp/w5F2MLbokyYtevBmtx
         +AWpB5rpDbtYtrT7GDlaE2KrtDzwbDlk2TGpWqo30HeqgRz0HS3b5IffRQx4ud/I+NEZ
         jWKfn5b3rsAf1c8U+0W7TFw/f9RNM8HvdqLR1twpJg+n09w5n6k/zLEY3/aazK5ae8Kb
         cT6I8LKGn4T9ZoWQIiFccZWQ4d867DYGmS+OLGernolmzgvr1HJayo0CC9tjZrwKSjqL
         3Rhg==
X-Gm-Message-State: AOJu0YxMjTocY2w2VgxlX2NlpNIwsiMeDEMAb/fZj7Xi8uAPppBThcIo
	ZCiAXJlADyYWD8UPXNv6aXcb7O7e4IQYkzlIKfRzOHOZ7paLF8DGsGzMlmDubA==
X-Gm-Gg: AR+sD13FSp5Co5p3pm2+D0Ih6mkezVauEiJHMClkoL6RXR5wWSL9HtvbBZJEH9rQN4C
	QNfzA45u3bi6pHCs86d9s7+mUdEgse/G8XIEAtyv4TP4QuS4ksrl0xQ88oNKmr4OZjhvWYJbR08
	7cbff5pKoEYQXHYIv2TRe7D3t8NXO2FM0hUnqkxmippeF4wx93Dofk9fv/t5w7TUooZdkpXzeU7
	Q0Z9PJKJrVcjEcAqDqLp8+CHDss+VWW6c/Y1qPdYwaszuH0GJai+ihGDIpVFZC1xvdIvaJmcs6t
	0D6Y8Xcl4fvdD/iW61SrQXXKU7h6jLa5ARob/1DE3oSo+6Oy54u9aXR1FYe97Phld/q4atLE/Sf
	CsJXNWc3AlxL+1s7E8mkAHQZeuNI4G5uzQcAV4coSrn6BmWHsQ9UOz3VNOXp9eIfHaUILTJDM+o
	vL8rTHjoAp/h6n1rys2ec++UcFcazIk3+pzopIPaCbzKLGD89OpFrCHyTs8u5WvaWw
X-Received: by 2002:a17:902:f550:b0:2ce:8551:318c with SMTP id d9443c01a7336-2d035cff415mr24843715ad.40.1785419922509;
        Thu, 30 Jul 2026 06:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c37211sm27506055ad.78.2026.07.30.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:41 -0700 (PDT)
Message-Id: <22e31fd35c2791f0f1ff7b6fc015aa5e24dea87a.1785419916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:33 +0000
Subject: [PATCH v24 4/7] branch: prepare delete_branches for a bulk caller
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
index c44f710a48..7b0aa68572 100644
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

