Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25532ED5C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338116; cv=none; b=rti1BE2ZxD0Z1jos5fiG2JS6GaYALEP2t9wdWgDqf/VQqybhvfyYIbSW9Y73MNYy5R96cR19NQ0G6TbyNS9IBfiEB3PIjJqISsTE4kIwVSVeOn9FTVCIokCrWPmNwdU6bWNHHSZO6tKIDXheWd+MPFDY37CKqfjNahHAetEIHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338116; c=relaxed/simple;
	bh=gxwY3F5PGniZPgfmYkIbeul/qavCwA/qdn7Dcsfy3gM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qx+zQaLWifu73YqA+q/QGeaW/BWaRvBLUuUSB6Rcdml3LPKE8GBJAM7wS0aZrhW29Xbf02xFpenOndzvS/5PvkU1+erHGnW5yPajl6y5Uf9ptvAlsMQJ9XU0PiTJ/PgAP6+5AEidWxPFaLCaCJKtgJ+HO1QvozB6+zqmSE8834A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE8Gi39u; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE8Gi39u"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c52f96f60so2897444eec.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338115; x=1782942915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVbknJc43cmJcNCmIFbjtWgd+wWdw6OLvTIoBRv8HDo=;
        b=RE8Gi39u950xrNmMGGnrkeFm1Po0yroKI71CKnPexfgP8qASOEqQ8BVcux3LZ37bk/
         YmYqO3PLH8TeSbAilqngEEKlXqZUpFI6aLhfRYWKQBMBmTAbyla0t2+O8gd8O+jQQHkJ
         QoK9f7J1x7URe9VW3xpa17qxHByo3rdC7qkWKQeai53jBW+9YObl98EtksSm7egUQStC
         UmbDj6odFSCzFGX0Ube1PMp5wwMK+Cuenk8GQMb2tqyrTxEr6KZsRyDKyFDKGkY7gF1F
         XHecrkMxl6sVTUK1eMfyEiRDoCIAympN2z+ltSuKDW9KnkJc+3JpM20rn8pX/Vx4yJnZ
         wMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338115; x=1782942915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVbknJc43cmJcNCmIFbjtWgd+wWdw6OLvTIoBRv8HDo=;
        b=j/+uhOhKVsvWrdlZOn/pGYGiKz+XlmOLgcmiPsbmePBuhSa+7ogSOt6QLNFFGiyzo5
         EB0E0xv066HVaMVFPXxE6ansXQXhy2S3pUyK1bBBCj3zzhHr9zlcPrh/EKhlW8mw1WP5
         PxTkR5XK+9TlIj7BCfSNaZ7z9wGBDpYF8c8PHqRkqKgpSLa7pUHVBDrT8aDLUeHTMok6
         ahSlch71mtkxdI9eHLE87BJ90ZHDZefFwozMwiK1N1H52fcMGjCcB4G03B2uI2RE21zo
         S3ZyMQm/4ruM7GGjb54/6P2I+7wj9f91M8ccipHcHhF5h4wy0KplwaKmDHHD4jdVjQr+
         R5Lw==
X-Gm-Message-State: AOJu0YxJvdUbMjZRh3KvOf2AlsNnNZy+bEJvnKUBe21+pJnYj75qsuTR
	jNYaJuJ8qqTdyvBPlQocZ0j0G65F/LheU7yWXYmNbPx/bb1oSjVSv4wsG/gijQJ7
X-Gm-Gg: AfdE7cmC2xnrM0VWH67bVp7GVXo8H5tFahbtqR0KSBNRgMvMMma29GgQ4L/8qhNKMgv
	KBbkX0JqkZaT/mcWD8xU85m9k17BncRWvafzF4KkfhbuqQsT84d+UUH6akHZp9EytSPm6rsz1Tq
	TrHyDe6QRUlj9XXbt7YT4rUWpcO2qkBc62CSyQlH7IGOOUArV5Yh4dQkSM3EgugQO4bOQO3lVQ3
	6rAAncNWy0yIFWlN7Z/dJgNMobpK8utkkqacOD8HkX4ggAGBmxQUCSLDoVONJfRUr5cgkXUwfjC
	iCwqBgRju+evlCVhoK8YcE7HsgmLkS/Ltuy0/9Jy+UNGkB4ZhkpRL17pdM5EFD6bEJePn74gjJ9
	xU5XctVaa3fdfVFmu2gaNTZKL26jdwU9+WZfRgvWhewBG00Q3X/LwPN6fiLj88Zv8pRW42vaOEf
	RaWWU7atOb0GkJFUDC
X-Received: by 2002:a05:7301:1930:b0:30c:7ccb:189e with SMTP id 5a478bee46e88-30c84b541dfmr33490eec.6.1782338114743;
        Wed, 24 Jun 2026 14:55:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a80sm1754921eec.18.2026.06.24.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:14 -0700 (PDT)
Message-Id: <a56d8fe93e041d640b0049bcc37459ffedab795c.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:03 +0000
Subject: [PATCH v18 4/7] branch: prepare delete_branches for a bulk caller
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

Teach delete_branches() two new modes for the upcoming
--delete-merged: one that asks only whether a branch is merged into
its upstream, without falling back to HEAD when there is no
upstream, and one that rehearses the deletions without removing any
ref. Existing callers keep their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c569d056a..01c1f64c73 100644
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
@@ -241,6 +245,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
+	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -268,7 +273,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	force = flags & DELETE_BRANCH_FORCE;
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
-- 
gitgitgadget

