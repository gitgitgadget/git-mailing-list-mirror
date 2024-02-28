Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF8381D9
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113473; cv=none; b=CWhEj/2W5ZTMOwssnhXVXwSYP7eE7N/1Sk0VfD0jkcM6IzTYze3BhQzYuhWzjpTwsfdtE+7dGciktg9MXoDDI0SbgCnLrLasGx+2TvK+PJ0/4Hv48E8Hn+r0Gyr1f7B2mZB1tmaxkOliQht3qyAjIdfjAaOtdfdIKDcTQo4VWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113473; c=relaxed/simple;
	bh=4sru390Ibo8Xgf1DQbOS/BmNr3Y60J6I13Lau3kJsw4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ql4Zuu97w31YSgOGQdsPRwGN5VmLLeAcacK/0XEXF22WXhOi0LI0DX3p5dTClJkVACEteXDIDHY8E/ModTCeoqAu98UPWYPRP6WWk6NZ2wI/VhzF2MV78z5U0w4l8ri/mYfdkCyVKTohdlBjtCRWfP9UtVs1aCFL8HRTmEdV14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOXGEOqi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOXGEOqi"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e39226efso6875928e87.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113468; x=1709718268; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FR8nadIybslUzNDZkj0sP76S6uhVz9Mu+LpylHw2qE=;
        b=IOXGEOqiWirdOlb2LyDlG6DZZ6mvO5cI8BtF+pKM0ObaSx9LcK+1Y0iWtwHmusf+nA
         aItN9CRWsKo2Dv/clZITDn4ELu3hKjj0BQIQzWQHpiHcXnPisuAClfaW5B0A8mfDeK7u
         2rRETUCkVdlNsygyR6pUIYVq9DvNx4EPOOPHJ1yP3t9jlA89f+pmRsKzSWz3nyhpQqrI
         TDBqAOCJQMMPMuDX3WZNEKkwEVFc0DojuRHRYNtlMYLtY8HivXsLs2cqM0fEIA5fWmwf
         zL5yxu8D67bdJqB5ur0k/7NXERh5VGAN5xNgc4i041E8b81hWaja8DTbjsheY0BTIjAf
         2nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113468; x=1709718268;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FR8nadIybslUzNDZkj0sP76S6uhVz9Mu+LpylHw2qE=;
        b=FBNu0XPeV+xVLninVVEX+o6o6y/J7lzqHqCBIwtk01bj/aoWtA+os9ntrhhOxVOS2d
         sEVW5kroihudCwPrJGCTkXgBKlxvWqXppeBUCiXfvSIlDK5xCeykRY7Yo8XpbWf7cdgM
         hQXKuAvtL/B9YcWWXlS3GA+jpEisPXEiIDHiA3IZQN1b6Ht7doeHAYHEXcWuN9ILBgGE
         FB4QhIKZHUXsDseZ3MJzfTOZe8lmIMZusIW/2d9LiFBZhXLM0uwmFu+2Qq27a/aaHLaH
         qVkQDAK4XSNfN0JbAhhRRoJHWznsm/P+9sZ58SGHYSOJl8SJlYOsrhxfgSNFdofpze2t
         pkuw==
X-Gm-Message-State: AOJu0YxaE3y23PD5VfWBIBqMtcVBFzmYEh3IanIza1aoeYVm3+mZnQ72
	8eYtjvzTMSdeUVbUSyHzoNqMOXPJjb3X5VQ1TjYWNS5QPTL7FGfY3S67VxAE
X-Google-Smtp-Source: AGHT+IH97FahrV7lIGIjKkpywmo1tTRwZkf8Iwop53y0iDY11jE0ldjgYRhfJTADQKQUi9tLTCeRjw==
X-Received: by 2002:ac2:555c:0:b0:512:e0a8:39d8 with SMTP id l28-20020ac2555c000000b00512e0a839d8mr6875413lfk.43.1709113467972;
        Wed, 28 Feb 2024 01:44:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600016c400b0033dda0e82e5sm8769289wrf.32.2024.02.28.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:27 -0800 (PST)
Message-ID: <133b69b6a62abb9317134636d5b323a33814e1ba.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:13 +0000
Subject: [PATCH v4 07/11] commit-reach(get_merge_bases_many_0): pass on
 "missing commits" errors
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
    Dirk Gouders <dirk@gouders.net>,
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
index ddfec5289dd..c0123eb7207 100644
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

