Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A51482E8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608127; cv=none; b=D2zu13SOAiN3KuumkukYrCgXFLGu8EBsGJAapxuAwAKDQssSnXqUTaaWjK3bZZjnnV0ZPqoMAjHo5uSHEDXZBt8hJuXGLB7GU5YE0ThyBvsMJjXkKadB2n6JXFMwF6h6O4UxxDzXh3moGJxXRe0Ta3Iyngl0eV06rpjXpYuiw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608127; c=relaxed/simple;
	bh=ycRcJNh4RBH0q+Ha2b1dfdCgivn8LOTTSA25a7ks9Io=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W9zYBO97/jEiTBQKzyNZcMN4BWI/Eq9ZrueIkkbG9k8d0W/BgsvrFHWBY3g7zuAQ2By/5juAoA5e6BeiNz4Gx4H1v/gScyUCtq35qprlEeZ0CAFNBL2jNToZeBx3D5zmcQTtilNEYDWQORBpy4gp6i3mH9hn5XksbW+U8YmNg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3hOOYFy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3hOOYFy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso367528f8f.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608123; x=1709212923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ATFgjL2j9vsAkuTtdOxufbw4oIBU/BIZVTdpWAvcts=;
        b=C3hOOYFyEIBxyWv5hKlilJTSwjIRF77Qy7NBzhS8UuA2mpvgoXCPevUzEOF5GUiS5L
         rxSjbyTgxYKZOiZU8JQt9Rs/GjEzRKn85QnG8sNUNiKTOwLDzEtVAWH/+9DLXj5jSxJk
         LDlBfJyOJzssmIVF+VoSBgLX01mhAZ9tZgxiDvYDqbbWWxTnb4z5nEqMzPXhT8EFPMsB
         aEl7i6BsBtBWbWEua4Vyt+yaNLHe6/Rn/FNI8j8YAvfmbRsE41sPzRIAusCdhU3936OY
         zZfWXb4dtf6wvzReiKw8cCKtaXUcXwJDrbBx2WQmiB2TwnqMrRE12VUO4QpOUSnpVVco
         XXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608123; x=1709212923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ATFgjL2j9vsAkuTtdOxufbw4oIBU/BIZVTdpWAvcts=;
        b=OCbiSPiSD0uUL8jm8iyEc0Uatn8wqTNzWdyTx+EMHKdHfHKKZTE7RYOkAXPPMYi/FX
         DUevRkL+ZbXSM0V6EF9zv1zMW8SQTMY08GYqfbEz7fiIjwIgUerkgOEfEHNilBN0bUj3
         jF13FzGjf4qiOFYPv3C8gbZDNv71lpVM7NxchxVsVwxwrc5hWhCFCHY58shcOvITcwvp
         t4QqLR4Vze5OKUzoOv5gkoJB5cNdk626A+pkUb1FIMPoELqAFHpA4f/aw+ZygbxX8VaN
         peVl9z/M4xoaeWXTLRSuVTHXfeEZ6Ud8cfBnjW1C76verx2trUtCzJSfXpAmnLtw2twB
         Mnpg==
X-Gm-Message-State: AOJu0YzCH4MzEiUsEnrKkarZ7cYnywYlI1ke8NamiYDtoVzK0M+6xuXa
	MVTRbfnZETupfdpy83KHZN31IUefn1aF+3zUz++rY1V0z2Usrk2gI9OxWhMl
X-Google-Smtp-Source: AGHT+IEHm1U9EtinAxNiLunt0Gx6yguege/XHVaumx10QCbxXRjf7kNIu9ZGn1B8yrqdGIMjZccUIw==
X-Received: by 2002:a5d:5141:0:b0:33d:3f23:eea7 with SMTP id u1-20020a5d5141000000b0033d3f23eea7mr2220595wrt.35.1708608123666;
        Thu, 22 Feb 2024 05:22:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020adfce83000000b0033d2541b3e1sm18774213wrn.72.2024.02.22.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:22:03 -0800 (PST)
Message-ID: <96850ed2d690adc58dd7866f984a04480e49fec0.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:50 +0000
Subject: [PATCH v2 11/11] repo_get_merge_bases_many_dirty(): pass on errors
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
