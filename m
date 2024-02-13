Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED0241E0
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813724; cv=none; b=jjnC0PPMkD3GN5t/C8OLXYVXpjYnZwt9vLdS333h9Mba7cBawa1X8aSXltWN2dQgIRTI2qh7hh4XPqRyp+HkjiFaijUTX9/Nfbt6FVm6+ucooZBo7u7yFoD/aIjyG+SkeNug0Ej6fqdVYQxRIsEQ0KCoSHQdNZqi4fBb3y6j0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813724; c=relaxed/simple;
	bh=RxoT3URQxzSKtRB5NWpYXhSDr6yLg79ox/MyvN4ui3g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rs1coIY2dOMx8bSd7pEJuilxTHeC9IwhIVx1pajwyL2Hjj9kHmEROfn1OdXiUD/ZcqjQ1fY37caAMWiDaZUB6oop/unbeVZ0ONOABvZc5pqFACuPLm6+8PgKY5AhC0BEkgONq+RYiSCHwXIHKKqWCXIg05vSAbPagMhfvhFhqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2P88BjN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2P88BjN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b86bc4bbaso786578f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813721; x=1708418521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZKwi/ctzH3R8FrIFeuzQhRnkbkMXS7fqsSPnlKaOtA=;
        b=B2P88BjNdPa2AfUohqo//3R9Ni1gVXPGX8S36KEOD1y6CsJZaPiix14vwYuzk1q9lC
         3IaiQDd6eqqAfizGYboNK5NgJq9dGUMmmYbUHGxSooBRMS6zJfVT0kufZJXvB6zL13PA
         BFysf+OunP+EiFD+ujneQ6Bx53IF6OCC2pcu3Sw11ZwDfHZau/JG/p/BfmbYIBWikiV8
         vJ31LCgK3qJlQkJymRRWhb8g45q4SI5Yn7lslRIRaXq65M5inaqrhG2yzA5tNzmJuHKl
         VyzMG/pxXlHyipTy/2RF5hJ1C9DHlFcBEdmhJcUmzegPi1EfqBtQMe/e+TCebHtPq7bB
         71wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813721; x=1708418521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZKwi/ctzH3R8FrIFeuzQhRnkbkMXS7fqsSPnlKaOtA=;
        b=qXsWmcUoO4yIbUnspDIm3K5Jh1obmE5+mu2AG5wOT/WWk/MmIaMTeaAUQMX6YcnLNr
         zoxIWqHDgTjcKwkpa5tnelQzcpRxgu9kk/SSvRKKIIdsQL2DtMf0DHTVashK1fk1bQh1
         J7jr6iGhT9MHt2RCs2Aj+r2un+JJAbTJ7MPNFHY/ECC6MJoq2MArTrNki/NvEa43+zZx
         YQGuhLPlBGr2zZLfiAHLaUz94ZAXyN7Opw7UwH87NsEUZTcZNPSwJZYv0/pN+sRyH/fc
         9QmOH1B+s9vouAAZrB+XCpACfsR9N/ytYiUhYvR4m80fDmsidAGqcWfWT5ptH/eQO5cf
         JdXg==
X-Gm-Message-State: AOJu0YzMOhSHIN6Q8/OMwoL2LKoVH+7IMNP28TtaOWKkDw/zbthCLWJ3
	S+FQN+PeseKrfn9F5koMdlVIXNZZjIypPXZdcG3ppNqzlFy4K0oRWezLKIfX
X-Google-Smtp-Source: AGHT+IEhgtZtd2+Ruuj2UluqAnvBtxpJe9J7GAKSNKR15fjgg4a36KVAcERAvfXpbncMqg1ooT30Tg==
X-Received: by 2002:adf:f04b:0:b0:33a:e808:31a4 with SMTP id t11-20020adff04b000000b0033ae80831a4mr7109503wro.55.1707813720615;
        Tue, 13 Feb 2024 00:42:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23-20020a5d5257000000b0033b444a39a9sm8863005wrc.54.2024.02.13.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:59 -0800 (PST)
Message-ID: <e7fcc96196ca87bfe2331f8bd570fcb60c262587.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:47 +0000
Subject: [PATCH 11/12] repo_get_merge_bases_many_dirty(): pass on errors from
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases_many_dirty()` function is
aware of that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c |  7 ++++---
 commit-reach.c       | 16 ++++++----------
 commit-reach.h       |  7 ++++---
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6faabfb6698..2b6af1bc35b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -13,10 +13,11 @@
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result, *r;
+	struct commit_list *result = NULL, *r;
 
-	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
-						 rev_nr - 1, rev + 1);
+	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
+					    rev_nr - 1, rev + 1, &result) < 0)
+		return -1;
 
 	if (!result)
 		return 1;
diff --git a/commit-reach.c b/commit-reach.c
index f0006ab6422..25b39c302a8 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -460,17 +460,13 @@ int repo_get_merge_bases_many(struct repository *r,
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

