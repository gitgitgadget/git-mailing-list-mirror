Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114518508B
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026742; cv=none; b=oMgWkZAB7yyQkKwg9NfmOEPAEZ/An3/dopzypoGHJHRWtQln8/WvFINc9kNByjyuW3mDPJUPEh1uEZnsdKTEgZy7L0AGBBeZJ0Tnlf7qQwKrb6LQO0bIGya7g60n6uHBuUajRXyctxFKdcJi7doSEZlQ2fGkhxJYEFVPzqySJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026742; c=relaxed/simple;
	bh=0l7ymUSnRrwez6kFQt+BJYZOtiGxxbieBfWe0MM7oW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3EuzPe63fIW+JDgP6MmQyr8XMrUj0twZwoTMeybUlzAo8tkI3wviOwm9naMyWKHGYy7Ll1uz0aCbXd3Z3sHG3ZhX2U0FHBlx7xs8WAD/vBXZlrFKyeD9pJLsl17l1gMHfEMxLoc/ToWhQMIV+ucl4b0Qvn7H5o7kq0jBgEXihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUNYt0co; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUNYt0co"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af0684c2bso564350b3a.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026740; x=1720631540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHAN49AWDvIRtkHLcCZqOaBIWqjwU8eHVQ9Kl7k2dtY=;
        b=hUNYt0colx1JJkjhllCfxeZhwPfk2CE0fwy1aLcbbquir2cWb0YyvgvcYPuBrn69Sv
         PoVF9bS0a4HCFuANTqdLpsoe71oKrOuOwAUPibVOHx4iYJJ9QJqPQkgAyjjH/6nl7zhm
         Ic8xBlwKJxNe0jS/wKdn6k8qk7d/zerLq1rEnkZyzdeibdtikNcxKKCoEzryLTpfSX5h
         1aIF1KKtF5ztxWv1J/0rR4BMO3srXyvZxSkdFVLpuFysmdUZyKU4ydXsCxYugnT0xuAJ
         KQZ1IH1MuYSR77KsuhFTkeC0hycXWO1jQmG9ZNoIsmgm7DC+H3xberj2HhCguKSFGpym
         W+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026740; x=1720631540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHAN49AWDvIRtkHLcCZqOaBIWqjwU8eHVQ9Kl7k2dtY=;
        b=BN0xWRAVYKSzAnhLxQfgMsNMQxzm6JQfxkuHkbt45/b0jgN9pGCf2WRl1jNoc5qj8d
         Jxrl5kI5e2OOcaN0ngiUclG2nDuU0pFsy2S2Ljy230PehORaJxlxz56V4FbPguxvpI3R
         CGeefUUn7smPsBrXUQY4+/sLM7nX+A0TAlqGbnIeWB6sxbufy2eBulVLNkIa5Ss31MvS
         xy2Z3PHfegqZw3/3dz+dr/9+Z3Z76A4Zst2ZwxJXkev23fqef5zGpbhwEmqHTgXgdQbw
         Pah216rWXJyqJ7b/fV2ArTC61dwIYSSz0oLvQU/1D6cyBZnzkW96veOXnCuBNpMMKNwd
         qDjQ==
X-Gm-Message-State: AOJu0Yy7Gs+6pWi4sSXOdis54GWIsMV+CZ0an3nklDrxXDTOuS8rZWN6
	uSW6C/CS7ERrJn5mRhlHKJNEhAvQxm/L52Njo4tD+Ek7GHi3TnKCqrhtPw==
X-Google-Smtp-Source: AGHT+IHRKU30573sWaF4r8qL76+8kvCerP/+ULx2a8F2mrZYBZK0oi1+Z86Ogz7VhDfBcH4jgZ21Xw==
X-Received: by 2002:a05:6a00:80f:b0:705:c029:c9a7 with SMTP id d2e1a72fcca58-70aaad60533mr12873402b3a.15.1720026739642;
        Wed, 03 Jul 2024 10:12:19 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 3/5] t-reftable-merged: add tests for reftable_merged_table_max_update_index
Date: Wed,  3 Jul 2024 22:31:43 +0530
Message-ID: <20240703171131.3929-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_merged_table_max_update_index() as defined by reftable/
merged.{c, h} returns the maximum update index in a merged table.
Since this function is currently unexercised, add tests for it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 28bf6f6696..543113f3d4 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -232,6 +232,7 @@ static void t_merged(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { 0 };
@@ -361,6 +362,7 @@ static void t_merged_logs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { 0 };
-- 
2.45.2.404.g9eaef5822c

