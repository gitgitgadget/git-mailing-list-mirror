Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107671448D7
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040514; cv=none; b=Xi2pEmsqMu5EEeeGrx10yllNSNgDlFL5fuiF5FTycD2jYS643e6wOwb1GUVkq3xESGQxngh1HorUgm0MpOAnc26TkZwaY+uMNSMr/E5FgsOgBdmz5D9ZQrDkmmjsy0WsGlhv7f0DvFEmAm4LHbD5YYRmGwhOH/+6o0TopGl+gD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040514; c=relaxed/simple;
	bh=ycRcJNh4RBH0q+Ha2b1dfdCgivn8LOTTSA25a7ks9Io=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bGht+Fpu0/YLKY5Y2sQv2ENAuTboZNdJJhjIe3ElOGngxM38fE8qyuoT7Bs5nKvLWWNT1838QFq9gTXR83iJYIFjQ3kY6lrWZUC9mJXqFRBEBy3pkk4Ugoxd/Ni/vWFWfgMDwG5W6c7Ct66tQ1yj7yOpk073+P3rFvRnS88H0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1GozOOX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1GozOOX"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512fd840142so2657744e87.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040511; x=1709645311; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ATFgjL2j9vsAkuTtdOxufbw4oIBU/BIZVTdpWAvcts=;
        b=Y1GozOOXlJyGnoV8Ewinxwijvwl5rBXEWcRk+DwhmezCg1wt+goyuUuGU+GLXAh1rW
         aadfo7yMw68Hl0RKqoSZiak5ihGdBGmExhPlvIixwhaVhYQjPDzMt5PQjAqMJf2FdWlr
         OlVz5FbKW6HMXh5bdoW+3+TqYSMcDaDI1aXQoG0d2VD/j2cOCz0vUaIkvQyllxXQw8MI
         cFT3i8fQSUEDc9J5k9ce3kZ5ATXwWjEgEjdH35Malo7FIUGe36BFs7m+WZ5GgIsiNl6I
         REK6HqHURaLUl+wt+skgQGW6sBlG+/tzVHnzdxJS9uV6BBL/RNL5SuarI/oebC22MD/I
         TD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040511; x=1709645311;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ATFgjL2j9vsAkuTtdOxufbw4oIBU/BIZVTdpWAvcts=;
        b=Vq3M/bwoc9sRQoB0L2IInMRjwA54+byAkBY7jrRKDevsZHyDvEF2Zhzb9fyBBjTmBE
         a6vgQer2GYhCAIs3wDFmbvrQ3+7ZIKsB3WqMR0Fd6X37Qjz2cSusJe0m21u9wnlrtoIV
         zZQ1AvNd3yIzDclAnSU5gEG1czAsC43W0HBiTs1n66cj8mL2kQFFu8iFyx20SymkmpZB
         gnQPO/n73dI2tBrIGqsQPnLFS95L/tT7daPHubHWbWbz7Tr2tlgB7UBF0dee7l5Vjli0
         mjQlMdkHWoQvN/6+9hzojUn7HNz9IHWEWVbfGF84xP7AfQ8JzdnQ7Qzew8lA6CH8W3a5
         daHg==
X-Gm-Message-State: AOJu0YyycUvjsl99sqFprlEMLX6J7VVMucyFt96Jxv9o8Cv/WIYy/GFf
	xrp/u+/XHGN2uU+lh9n+KX9OPI4vopffr5QVWWulxyRGwpMuhzlUYgGbc57w
X-Google-Smtp-Source: AGHT+IHEeDmPphvscRK+VSJHilRUV8iWW0QR7zVxWAz/+IYdbkrgLZ+R6yP9zLWfS53kefiaHjlp6A==
X-Received: by 2002:ac2:5468:0:b0:513:14a2:c3b7 with SMTP id e8-20020ac25468000000b0051314a2c3b7mr321519lfn.69.1709040511076;
        Tue, 27 Feb 2024 05:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b0040fccf7e8easm14990739wmd.36.2024.02.27.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:30 -0800 (PST)
Message-ID: <bdbf47ae505400b34fb41ab977d08938bb644fd0.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:17 +0000
Subject: [PATCH v3 11/11] repo_get_merge_bases_many_dirty(): pass on errors
 from `merge_bases_many()`
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

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases_many_dirty()` function is
aware of that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c |  9 ++++++---
 commit-reach.c       | 16 ++++++----------
 commit-reach.h       |  7 ++++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 2edffc5487e..a8a1ca53968 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -13,10 +13,13 @@
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result, *r;
+	struct commit_list *result = NULL, *r;
 
-	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
-						 rev_nr - 1, rev + 1);
+	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
+					    rev_nr - 1, rev + 1, &result) < 0) {
+		free_commit_list(result);
+		return -1;
+	}
 
 	if (!result)
 		return 1;
diff --git a/commit-reach.c b/commit-reach.c
index 954a05399f1..2c69cb83d6f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -471,17 +471,13 @@ int repo_get_merge_bases_many(struct repository *r,
 	return get_merge_bases_many_0(r, one, n, twos, 1, result);
 }
 
-struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
-						    struct commit *one,
-						    int n,
-						    struct commit **twos)
+int repo_get_merge_bases_many_dirty(struct repository *r,
+				    struct commit *one,
+				    int n,
+				    struct commit **twos,
+				    struct commit_list **result)
 {
-	struct commit_list *result = NULL;
-	if (get_merge_bases_many_0(r, one, n, twos, 0, &result) < 0) {
-		free_commit_list(result);
-		return NULL;
-	}
-	return result;
+	return get_merge_bases_many_0(r, one, n, twos, 0, result);
 }
 
 int repo_get_merge_bases(struct repository *r,
diff --git a/commit-reach.h b/commit-reach.h
index 458043f4d58..bf63cc468fd 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -18,9 +18,10 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit **twos,
 			      struct commit_list **result);
 /* To be used only when object flags after this call no longer matter */
-struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
-						    struct commit *one, int n,
-						    struct commit **twos);
+int repo_get_merge_bases_many_dirty(struct repository *r,
+				    struct commit *one, int n,
+				    struct commit **twos,
+				    struct commit_list **result);
 
 int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
 
-- 
gitgitgadget
