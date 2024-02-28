Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1796339BD
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113475; cv=none; b=fZeXthaUY3doj4ZqBhipavRTKnQukrcoYQzYMo3Wd88gebY/GDXsHZvAed6SC9dr+LzUplB4+2l7qTi70JI9Ysi+k62Jp0bjsz2iw/XRsK86otGSa2jUWhGhKsu/YnfMai3SX75ZynAvcUSRfswWQ/yp7UQORmXqA0tezAWRo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113475; c=relaxed/simple;
	bh=uUOOMmadKz5Nnd5Z0oW6BKF780M3ENnI44pPgvMX92A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ptSG2IBuT+5dHsaZ73WMFuwSDTt+fMTbxfaqA4SOvLuf6al6DMFtLgTokt7liJjDCTaW0T9arlQAmbpRT3BNPpAiFeqo05++iebEkuxCw1F2VAYEQ4nNZSGkvCjd+c2NdfMKSHa9z0mTCyfvsOSbEv0olJV6+rLgvXtfbOgWEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw4CmT/J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw4CmT/J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412b493ed27so2435555e9.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113471; x=1709718271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbBNM9tJUa+ssc+h+r45IX2A/AFl7A8NJ+LiTOCxob0=;
        b=bw4CmT/J1/8slA7dg7VxLzb/6YiL4mgzsjPAphd+v/H9mU80r4MWJv84iLPVnnbQKR
         Z5jKsveYCwheEn5PC3+IOiQhOSATEAL6X+GFNfun4bViCTPhnpjKffEw7acPpnxcS79v
         46xjBGDn5ecFuO4QN5ahgmoZaknJDk4gc+YGhWuMlRT3lboIu4hQSsEEHABgKEMJYqjv
         fPFhdvwSn7P4D+wgLzT5kG8VQQ2fxlSgyfW5vb1RJUyZaeAQMWGqql+KfjaYz87qP0Um
         JXeL0n+i5csj6aBuSL70YLepXINMBYy4seaJ7ZKIs6HaZnWiGi3nzjf96OUO3ZxJzjP6
         QHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113471; x=1709718271;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbBNM9tJUa+ssc+h+r45IX2A/AFl7A8NJ+LiTOCxob0=;
        b=BZ7h8UFKbHx4RMhGdJdgvVZqU0Zdpk16KcOTNJT6hQHI6LG/vtNwg+X1mzfsJD00mM
         YWVvJX+t21aFqdesjmTUSCQhXCtJxS8lHr80AQ+O7h+ZpjVZ1tnVO02CQqec/0SxDXDl
         zZIrG2lndsS1z/6Hml2+8oRXxRztd7T/IFPCsqi2gtC7zfqcBD0Ms08XtaMQWxPWWbTN
         g5CngTluB+8a4kASZMnFBwU2sO7juqYfSCbZit/N9iCb5t69wQOraPBJAM87e5jazxZy
         BKtH+xi0pfYnr20+UzKTKLeMtsNFoyKiCEPldm3Ni/9BoDKvciHvIPG8yZJ6rVvT50Ke
         7otQ==
X-Gm-Message-State: AOJu0Yx3BQ/gI7Mt2l8w1ZYqpCJJh3d+E8cCJhTI4HTzqB7qyILKMbjZ
	WRLXEUPc7DS5h8RyI+uApxenFNy7a4DqfWt7YBlL8KEgCIWP3D1qBu/aPXGh
X-Google-Smtp-Source: AGHT+IGAaJ+3ILw6MT9IbKzm1w9kwPqrHB6qJKUf6FPPyFUOdA6N+bSQunVVuIvoGvHp3dgcdHYrAQ==
X-Received: by 2002:a05:6000:1243:b0:33d:b32a:8acb with SMTP id j3-20020a056000124300b0033db32a8acbmr9107187wrx.23.1709113471596;
        Wed, 28 Feb 2024 01:44:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adffed0000000b0033ce06c303csm13950234wrs.40.2024.02.28.01.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:31 -0800 (PST)
Message-ID: <05de9f2444477dd38b7e1cf67d8d233ce6e0e68b.1709113459.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:17 +0000
Subject: [PATCH v4 11/11] commit-reach(repo_get_merge_bases_many_dirty): pass
 on errors
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

(Actually, this commit is only about passing on "missing commits"
errors, but adding that to the commit's title would have made it too
long.)

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
index 0aeaef25343..202776b29e9 100644
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
