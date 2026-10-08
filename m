Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77909489FAC
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453150; cv=none; b=F9uOdKbaNng/vwQnu862KMydViDtR4+Elrj9v2/T1JcW2qoQ7FDU8nBiIhhJtiBrGYHF62nfHyMdTGBVHBzmUyAh7ho025ibF6Y6ae7Rjel6RB9j5f84wBN+elW5kkdJFvNA/eVj6bCGV2JJHrYTXlWTUINIF8nNHNWblRcH7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453150; c=relaxed/simple;
	bh=9nvaJKW7pNK/DyewnxQxLdaCkTxguIYzfrAipEATYN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=avJks2/EnlBmn9yOGU4LneHfrQa+sG9rQxJfj7a9rw1iso53i5UlAqRrIhTpHjuaGvOq3D+OEfU+ln6WNqeuTpFitbpUpeVZ5VP8NzkLlkK71HiECs54PjKa2Xz/dLXDkJ9ddu5SOSFYjEOMAm9I7XF2gKS1ssi8o3hfIyi3L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVe5yoY+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVe5yoY+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so393377a91.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453149; x=1792057949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+ruc0jIUeiNpk79acWhxRIJf5ZMdx5fEoltFYtCSISY=;
        b=NVe5yoY+usfvbqrzWQeiGx2QDI2A9Yavnfah/BDlnMshjFRK8rPCY+Zk268wq4jzoH
         o4ILUPAIiNcf9ahHZtAEsrXcYaPuU17QxH4axjVdW413U1wQouDsVBiccBM8CGf8g0MU
         ulvmopITchQXSSBgVujkPoYoS0pGJttLPZoC39l6xGLe6eVXtbOwnpdYtS59RnMwEudM
         uuKAdoymhGfomcil2SbLDjNTdjaRVyH49TzLSwmNSvfAFAfRmQIwmNj2tFrRSmxYKBZS
         dkvO2XQZLyozuM0MeRK4bJqRwpwnnzlaXF8nGQnULU0+/XIwSbD4rIM8bPfbkG3p+xqE
         OcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453149; x=1792057949;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ruc0jIUeiNpk79acWhxRIJf5ZMdx5fEoltFYtCSISY=;
        b=UjS1wH57epjmR6ELEOPCxcHCugipdmyI2FbJQyTjw/RpecRAjE1eJwzWK46NJZL9Fl
         Q3GSpxAH5LH0ywmRH/sDAV2SY3H5WOaDorNtLcZhclqUiYA+4q/IXh7uAohrj042xs+p
         z32EKDCraQY4QvJpVQpjDYWvG6wkM9+Z4izjmyLytgHvlBPYTCIxKR+KBWrDDOJng1dr
         npAS5OM1xQuqIvE1nrL4IcaDeDBbWVMcNN+NXptfjX6jVnkFaz1C68ho9N8HyqqbvyM3
         QaLv8orL7pHxOknK82x1dZsouu6bf59Ua7xy9oUnxSHILWlt9AMVSmjoRe+NzmrrCIX6
         k3Eg==
X-Gm-Message-State: AFq9FYI5dIrUPdLhsXdhVZBNfYQv100urbfi3Q5hHW/ghJ3yGtGhNyK/
	+Xu+LTfUZVOego1LAXuf3VnjT4YafMJ3h8utJm5fbtuc0mqmV2tDMcnB1NKM8nH9
X-Gm-Gg: AYBFou2nLYgXZ2LraXQEIFxdrOV9B1fZf54LJCZCcBb6DFpelr9DCqlG0dI4mUl56z1
	0WHfw1Hu6iHEPqlc0WTZHs+7/DPsX4mde29WVX5aN8vZ36P3/64Zi/08dJolaQJ6yGpqv8F45UB
	8k0f0Gl+hyAIIS1LK3Xo+fA6JsPDI7/Bg0sRDp+nobUTHvVpfl2BXw747Z7pmM9HE87IB25UPUu
	q45pkVwfVTcFEh+fQW8Ks/Xo+dj6qF+ktgAbN9WBO5+JAg1TdWeOYQBWXxMI9iHwp+xngHvN8OG
	5qJPBBuBOEBx1OImAfGul/9ZKllxljkhQSbvMT64mDR0zAiVVYs4wjF/v6NDtRJWXN9RIciW8jr
	+qHoJLkw3J6QuDozICeiARMaer3qzSxvHoNPq+YiAVlfXbd5sDprdNMIXr4t+xagWi3wAxWichP
	E17ctQdXfHU6OLav6cwD6ETqaQ/EfoXR+j1a0/TX3wS88wGurA2K3g7NE1IVJGFGsUSz8fK2F81
	A==
X-Received: by 2002:a17:90a:610:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3aadff48952mr672672a91.8.1791453148734;
        Thu, 08 Oct 2026 02:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d416348sm4649804a91.0.2026.10.08.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:52:28 -0700 (PDT)
Message-Id: <ff2146d002289f92897a4defb3204bfca2350c1b.1791453141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:52:19 +0000
Subject: [PATCH v3 3/5] pack-objects: sort --keep-pack list for lookup
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
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

add_extra_kept_packs() scans the whole "--keep-pack" list once per
pack in the repository. That is fine for the handful of names it gets
today, but the next commit lets a caller name every kept pack in the
repository, and with thousands of them the scan dominates: matching
20,000 kept packs against 20,000 names takes 11 seconds here, against
under a second with "--honor-pack-keep".

Sort the list once and look each pack up in it. The comparison stays
fspathcmp(), so what matches does not change.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f86b3661c5..48faef2227 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5002,7 +5002,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names,
+static void add_extra_kept_packs(struct string_list *names,
 				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
@@ -5010,18 +5010,13 @@ static void add_extra_kept_packs(const struct string_list *names,
 	if (!names->nr)
 		return;
 
-	repo_for_each_pack(the_repository, p) {
-		const char *name = basename(p->pack_name);
-		int i;
+	string_list_sort(names);
 
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local)
 			continue;
 
-		for (i = 0; i < names->nr; i++)
-			if (!fspathcmp(name, names->items[i].string))
-				break;
-
-		if (i < names->nr) {
+		if (string_list_has_string(names, basename(p->pack_name))) {
 			/*
 			 * When following, treat the pack like a "!" pack, not
 			 * a "^" one: nobody said it is closed under
@@ -5146,7 +5141,9 @@ int cmd_pack_objects(int argc,
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
-	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	struct string_list keep_pack_list = {
+		.cmp = fspathcmp,
+	};
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget

