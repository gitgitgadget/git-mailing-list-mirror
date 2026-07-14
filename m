Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783D23C516
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053506; cv=none; b=UidNgR+61AQjOFiUn/1haaPqb7CpOpprMZ/kmZ7iMP1cKLjM0Gv32p2Ra8a2mtT4kXQhoVzxSa0I/2JaFytkdxJ4klr7jeu/h4eTVTYuZX1b70ljpW9vLS2+XL6En3Goxpna2FvRWZGRbC4K52rYEmEYZx//V7Z3vXNmstUBZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053506; c=relaxed/simple;
	bh=4yn8XilS3zzXR/bWFsRSv+TFxb+pbN6R3yztI3qxwos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ErO9Wv91PUajHeU5V1BVJlvCzgdjKE+LELLP2tYYPVeAK3JgQ71xdnpkdqhS8+enfFyPjZegmieq7G3fajkI2JwkfG+9H8reAUkC/OgY7basRuMJYRbTk7+5u0r9jxJ2HaXQvXFZjFbgwmXbmWi1jsy9od8OdVxYlZHcDsgKBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWqA8zZq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWqA8zZq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4281921a91.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053502; x=1784658302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=srZUuatU+aBUkUVv3XTSnUkWMmlPNN8kn4+1HH6a3A0=;
        b=cWqA8zZq+eYmxUTgXLqfz4bDyB8iVFVunsmdo2Woklwa4Yb9OeaKHIeIPeXJEZh3Vd
         JkNhv6W+h9eQkX7k91kJDWknJBK2+L21nFXN53cSKkrrrjWkybUK0THlH2UBl004sEvE
         juOIhxmey5LtjJumvTfDRbeUkmBECf0SuyeUvniB1YRo0JVDAAMyHot+l5UMs/we8Mzn
         5lKJXkn1g40mr65fRczWBLj2mifwRkk7TFlYR2jLxdXTSso7iWzn3y32wr6iGAE+KdH+
         WOrCt2mceCk9tzDXWDMEQv8UMWiQLAqWejX3bIYoa9KMaYlV1l6Ec7Tja73n6eP52Tlk
         koFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053502; x=1784658302;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srZUuatU+aBUkUVv3XTSnUkWMmlPNN8kn4+1HH6a3A0=;
        b=kmeA25LcXVFZDu/ZAFApz/Fa0RnczSysWHOmznRqcHQqcgX6E8ir40JPx4o7mmiBKx
         Acectq3MVWqSfPXuz8+dSlzdIDlQcaivDjaViWRL4wlDT9RvzdOWFepiCdY+qMb+19um
         bnxoyRo/yZsGqIvBsDhrf0AZHG0sQz/aH7aYtn6RMxvcNMH0o8Uh0R2+bXEPCeUjJ6Us
         1s3k/Qh1T+XJqcAOSAed5wLHnCGH1iLkQah9FttdDyZf1RNliBOXcSMuKrNtd2eEThsB
         0chKkvRkl9g8GntpYLvFJ7FDBE5BgGl+hkKmTQBaVayNdPP+WbaJ/WnR0vcmteVK3AVv
         cysA==
X-Gm-Message-State: AOJu0YwVj36ejXqjvjv9mYw8QbvVgC0/UeiApA1PPXITxwoP96s5Ykuj
	kBzLYYLDHNJiHZZXHYx3/YBns+q6nV+7N8bYFGh1sBEL80dPn6/hlNUH0W7Hjw==
X-Gm-Gg: AfdE7clCADURW+btudmW1gummzplfsBAJpCKwU8MXHpXKxHeiRa7ZKoiFVST9mm6Z0v
	VVh4GiaYqIhhkZG2jRqu2KjODYxSeno97IDGcl7BKRwPJe/a4FBWglxKiuNyfLg5LewdLNmXIsB
	cfPFK9iabZKKXk+8ol6rKW2xiAViH1mFzTts467WjpgmFxrKqHohYiQsirhe6WjJbtMziKVrbHw
	YOL273Zkfye2QJYfJCzcX7iIPi8UdPloTRiBAG9jQkk8+L5bXdDb9H/Eu1AdRmmdwi+/zrDgGmm
	o8E2KEd8qdKiKkh+drn83O6TO5oEBtJ/Cn434A7lSnJfpneAUdfOPx76pg/2ldWNtdWHd9ZOAK9
	9UbkrDSZnk8mWiEWI8B3XpeAZtGOVI5kNqcz7x7SgsXaWS8CuJyPcvMuItFRAOa+CSHtncHFsmQ
	q8OvMkc+pmrIWRGZV3
X-Received: by 2002:a17:90b:1fc3:b0:37f:ef32:d444 with SMTP id 98e67ed59e1d1-38dc78227a6mr13444719a91.1.1784053501909;
        Tue, 14 Jul 2026 11:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm99932524eec.14.2026.07.14.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:25:01 -0700 (PDT)
Message-Id: <64a202526a673314ffb9d4cc4036b08434bef21e.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:50 +0000
Subject: [PATCH v19 4/7] branch: prepare delete_branches for a bulk caller
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
index 568ae817d6..23b2b7107c 100644
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

