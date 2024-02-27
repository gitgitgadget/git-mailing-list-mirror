Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DE141988
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040511; cv=none; b=g0njkPqFOwUNI3UWIC6u66yUndCfAN5JjBXhfDRLeN4DipT1hPJ5LS/tx5rCjvPa2fv8TVwwPsmwzVegQ82HcF5V1tfwc884uSVjnE65+p8R5ApKrGhMYvYotqBCkR4KErOADfXwTPWQu78V9RJVWkmNUx4z/cjeUNOh0tfOehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040511; c=relaxed/simple;
	bh=GMisT3c0UH8nvhHSntvgDda4WOaTeQgKFgBvq9WNG3s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CWXNvj9B1w7WMpR6N7sYYB522s9PWqphsZaa6/qADNZMdT51pVS8suZv6Q5ioyTL297w1UFUip91D5RfTUnYf43zZlcx8W/RzOpY7fGLTpWfhAHYbo200QAins/a3OLM/7wDD9srhVN+AiH3/9Qcsm/qFjtxPc2zGCvlrBgXFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV0SHxr7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV0SHxr7"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b700c8ebso5302476e87.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040507; x=1709645307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZYTa7/iq5fGG8lMxU083J6LdnIvDMjkHZYAAFHn/9g=;
        b=nV0SHxr7/vnANSpQ6BUDYaM/vsR8jAd6YULjGoj4tRRAambge5tqgQxlzkBaevFaLs
         jXwj/ZIpCRGPpDczWHua+FuzyyywDX7KSSaTvtTEwcDRfB9bcoNmEvxvNyIuQITuc/gy
         wr3TSE8YkiWM8bhy4UIc/0wjdJ/Ub2Z68ljY0V+MVE/Nhb9sYh+m/URRLjv3QHM7nEgB
         Palr+Am1bTZ89YSPLDV1mP12Br/HnAufhtr+sGZ8dl2yW3c1UpvDUB9V/LlUy9B2mVyw
         0p2Y7Fy+lXRhUPbjs2LAU525ahjO5tyOyT3/1p1pB/ydTuaja406l1iZtVqP85bDRfEj
         Ksaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040507; x=1709645307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZYTa7/iq5fGG8lMxU083J6LdnIvDMjkHZYAAFHn/9g=;
        b=ITU9ZErKyfngSJzMvjQLwyT892o/L4J5LvfBE94f1y/dPc1bRYlI1YEMmlJqvkogYN
         c8FK1Eou4x3eSBIcgM4r6dZzueKf8O0iDrmz9z8PzgXWsxfRo7jBtF2lWF/W/DGkHSQj
         T3M9gL6s2GtA3fSAdo01IZcxAfRUmi6ra38gGZnd1UVyrFpbQ8f15jI+7DkKWnjoeruH
         LHLsz27Z89nFeW98Jp1whiBS2ijPv62sggnwOpbq7bjRxwN3JWwT3Dn/E7ZcoYCNCcvh
         In23+k50hGodho6VYVe2iq36evHu5hvfWNy1neok3KrzCB9rbGuJtc0+NC+VZSDn9r5M
         sU/A==
X-Gm-Message-State: AOJu0YyhkWG+prMwoda9OHMHBuWkVPRAEKKLi3Q+g/Up68oCPBmUs+hg
	vzI+mIRVwKSgWzGvqJqi3dJD500PXKOvf6CSMpBMAKbQ1T2I7uA4WseHoTxE
X-Google-Smtp-Source: AGHT+IGLBVdGDJsvHeeeUOeOC0YN3tHpEO4SCVEtdDkb/3tiuBcliNA8J6hRxneP2gx22b0eaVdVkw==
X-Received: by 2002:a05:6512:108f:b0:512:b00f:a55e with SMTP id j15-20020a056512108f00b00512b00fa55emr8094641lfg.13.1709040507522;
        Tue, 27 Feb 2024 05:28:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b004128e903b2csm14892139wmk.39.2024.02.27.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:26 -0800 (PST)
Message-ID: <4321795102d5cc5f4e599cba0ff623b5eb31b5bd.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:13 +0000
Subject: [PATCH v3 07/11] get_merge_bases_many_0(): pass on errors from
 `merge_bases_many()`
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate
parsing errors, and now the `get_merge_bases_many_0()` function is aware
of that, too.

Next step: adjust the callers of `get_merge_bases_many_0()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 2c74583c8e0..5fa0abc7d1e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -410,37 +410,38 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return remove_redundant_no_gen(r, array, cnt);
 }
 
-static struct commit_list *get_merge_bases_many_0(struct repository *r,
-						  struct commit *one,
-						  int n,
-						  struct commit **twos,
-						  int cleanup)
+static int get_merge_bases_many_0(struct repository *r,
+				  struct commit *one,
+				  int n,
+				  struct commit **twos,
+				  int cleanup,
+				  struct commit_list **result)
 {
 	struct commit_list *list;
 	struct commit **rslt;
-	struct commit_list *result = NULL;
 	int cnt, i;
 
-	if (merge_bases_many(r, one, n, twos, &result) < 0)
-		return NULL;
+	if (merge_bases_many(r, one, n, twos, result) < 0)
+		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
-			return result;
+			return 0;
 	}
-	if (!result || !result->next) {
+	if (!*result || !(*result)->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
 			clear_commit_marks_many(n, twos, all_flags);
 		}
-		return result;
+		return 0;
 	}
 
 	/* There are more than one */
-	cnt = commit_list_count(result);
+	cnt = commit_list_count(*result);
 	CALLOC_ARRAY(rslt, cnt);
-	for (list = result, i = 0; list; list = list->next)
+	for (list = *result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
-	free_commit_list(result);
+	free_commit_list(*result);
+	*result = NULL;
 
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
@@ -448,13 +449,12 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	cnt = remove_redundant(r, rslt, cnt);
 	if (cnt < 0) {
 		free(rslt);
-		return NULL;
+		return -1;
 	}
-	result = NULL;
 	for (i = 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
+		commit_list_insert_by_date(rslt[i], result);
 	free(rslt);
-	return result;
+	return 0;
 }
 
 struct commit_list *repo_get_merge_bases_many(struct repository *r,
@@ -462,7 +462,12 @@ struct commit_list *repo_get_merge_bases_many(struct repository *r,
 					      int n,
 					      struct commit **twos)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, n, twos, 1, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
@@ -470,14 +475,24 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    int n,
 						    struct commit **twos)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 0);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, n, twos, 0, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 struct commit_list *repo_get_merge_bases(struct repository *r,
 					 struct commit *one,
 					 struct commit *two)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, 1, &two, 1, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 /*
-- 
gitgitgadget

