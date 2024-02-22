Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D51474AB
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608124; cv=none; b=AcH9h+JF0BXgIwbeFUNH+ZDR7YgcExd558IbS5hgwcHqM+C7jv5KYROQuB5avvh1Mpc3KH3jZ2OIHiLCLJxLKoVGD21uKAjTE4NDMcb6UfFo4Asvqk9aTE2tZ/cRNaRyv4vWCx2RyMXhrjkGQPaqFvZ7hUbCytsWcPAVE7z5ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608124; c=relaxed/simple;
	bh=GMisT3c0UH8nvhHSntvgDda4WOaTeQgKFgBvq9WNG3s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hQJ7Tf/os43uGPhVHdnW0UNYQZR6dUoZkMbVdmgiWmDrbS6X5w/iDSToHxoTiKBYFCbR0UQ67m58jaHor+vMONEmstERHmAq56kWkBpNZb7FBP8gILpQ/DV7COum9DSxGBFhcTAZbQ9ShEkUDQJwa9LoVGL0ZpUWEzTHdNLMdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhhT3BZE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhhT3BZE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d18931a94so1466427f8f.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608120; x=1709212920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZYTa7/iq5fGG8lMxU083J6LdnIvDMjkHZYAAFHn/9g=;
        b=NhhT3BZE+g78YPQFz8bLI4SIjrJT3Ws65XDE49BCKqZDcg3OJeE6EThkGXkZ/kn9OC
         v26+yXHpsv04718QxzcQRb08lUW9vtWTASziJvhh8ftwX4Z8rdZ+NqQs3Dn70TqLPNKB
         /fsgaXn15bCoZFOCmAZGTsRwinnVO2R/HPgjcCsIEBwYqwMLmrlslDm0hYsuaubtadXJ
         HApHiuT+cthhay2r04yhtfculAesa2e1jBA6WzGg8HaYXs24mYD8yZT0ZDoqP28Symvh
         yK0hUCWErGWp3Ss8jdQ3XIzxoANmH1anPRJ7BOMqS+N8PSUKaQaBWvC7Y5YuFEXPE+b+
         kXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608120; x=1709212920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZYTa7/iq5fGG8lMxU083J6LdnIvDMjkHZYAAFHn/9g=;
        b=IgWAx8CjAzVg0Qgs4rr0vU8xuQLZZmBs9ejrQvcnCIcfbQVzpH+DBPRdv/IDOjfilD
         UdIR5etrzv/qjksdHxYJfFp9J6mHdOQq0mtcNjb49YJX3LlOu0uFJgCEdTsQsThV3MRw
         hLVRwvbBsCINb3WjgWa5Izp2z5+Y3p1dordV4ZpiT2BN6gaMmnsFbm+c+TigiSukv5aG
         kzkltPikyyjYsEERCBUS/VAMXtb5uL3Nozeii5srUBI6qimoZ8mUwV1rG39SY9jrzavj
         NloTQuc8Cowf+ssXETSTdScojfYv+hBPI3lqAxvMsJw7sD4ajEhIggpR32WDMCaDRlcz
         +WMw==
X-Gm-Message-State: AOJu0Ywff2L6wNn4KkLF7OfcYEkesDxuQabwPZ0ZggqVAecBKdYfCciy
	Au61sisc87QT3xVaPbPxgswJksGvzx5nda7CmBoABH/a1XHNxLVleyKtXz7o
X-Google-Smtp-Source: AGHT+IG9S8OcUcn3FxS+6UB3kBgOvK8gjYHUwkJT6LUjhW67o4NJdPuReF5PshjMXvH1O7EqJ9XhyA==
X-Received: by 2002:a5d:5182:0:b0:33d:1eea:4346 with SMTP id k2-20020a5d5182000000b0033d1eea4346mr11226238wrv.37.1708608120459;
        Thu, 22 Feb 2024 05:22:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc18-20020a5d5c12000000b0033d67791dc0sm9518205wrb.43.2024.02.22.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:59 -0800 (PST)
Message-ID: <e3d37a326e577420bb03ed54fb19ba3639ae3836.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:46 +0000
Subject: [PATCH v2 07/11] get_merge_bases_many_0(): pass on errors from
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

