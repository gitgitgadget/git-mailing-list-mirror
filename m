Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB12E859
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465957; cv=none; b=miHtYgUkQdFzjh5na7NRUu4FyUMnssvFdg2FZc9CGB8Um6z5loliZ2N2Sm2xpM5ROKEuucMvqgfYQHnHFP4AAokl64bI4B1sX+6ES8tLHPYFmd4NzYvI1IzVF/vcDXM6KHZbJCKEiUOTTei40DcPP9MrHHvnhYqvF9LA3kcb5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465957; c=relaxed/simple;
	bh=xZ+8G/UN4vZHAZTQeUsf//jS8k6s4xOC30qrZ92YpIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHvDua1rqPYbUdVn1yGMcWuvkFCbl5ox/hqxXFaT954SjXONdJMCmZ3UHbc2FjcG/2OVREXOPrIGicIwD8JqSMExo/Of1MMNi4seVECizJfkS//CjCtKpCu9IYQ1sTVadBnZRc+ZU4JA6vEAgM8/CdjKV572nYDJvJOZ8kDQkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlw8QM+O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlw8QM+O"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d730b6943bso7799695ad.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706465955; x=1707070755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR0J9lh1WNj4xCjPkLaZHEXIiHVOkhCe22xt6lcEHj4=;
        b=jlw8QM+OkBU3ZDO82nfkXlGFqVE1u1K+M3JFw6/Qybs6auWXQIPhBr/dJAaUdYHmgO
         k6r1qCvykOTM55AKbPUxY52NSRqFh4UavC9KlGNM4ii+zLv5uPUNckzwDSu2DVPfjwFk
         uXepWWvWJ17ZGBg1O3ZwtoPqyOsFQFPn1xZtxxbp1/hYRXbm2hbYqRhtwVvlsS1Dktmr
         mP+1kyzmQu9hh5h79D++CZFJMMDuNYB4Q6eSY/PMa+5PT/fKt18ISkvbKcMgUauth5l7
         azLGIRbIgrmRH5xgHhjtjfWmuICmo2yaAw5jJ9x/w9wvfUwoEvByiuhHD0g9wrYsa7LL
         Rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706465955; x=1707070755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR0J9lh1WNj4xCjPkLaZHEXIiHVOkhCe22xt6lcEHj4=;
        b=nHd3Hm1C51J1CA+SgNwlPd8j8i4HS3AjVMdMS0oNR/rN7QJb8ap4fHkhM9qcsoigID
         C8bq4kH8e3cM6OmV9ot+K7r0G5D83/Kf9b91/Z8FIVlgY7BuPVtxKk3hmhILAnYvsRqr
         uOSeMm2ped3IJq+Jbbc4nzPKJXei6GVFLaBWcnQ/tb3uCodn+O0smxzIC9ogRJlbCA8c
         kcWVuDCPsHDLSkrDHvZMgG1iaWsq+VZ39o88DqoCM4rR05jHmgQk8ZmyegV4lLM7ea4M
         iPHOkqnEknzERxVALwx0NKbUEp1O+MVlmYebweb3FEWh5MKpBw7WdcepdVR2zN++Cpv5
         519A==
X-Gm-Message-State: AOJu0YxY1qj6s+pEn4YCTtRJajB8uK2PqhDyMeg1PPEe4Gwf3hIVhXRt
	CfZMbxmNFNZejeq9CNjx2nI9vfIAOEP6UPDkkkfRrD5tvxUZB53TKJ7g41eXQZ4JRg==
X-Google-Smtp-Source: AGHT+IFhu4f5D86z3RzFxznAFkovjz36uMsEQN/LmH1O940pO18Jur2H/zXCi0D961VHdXnPp58Ljw==
X-Received: by 2002:a17:902:b10e:b0:1d4:4482:83c7 with SMTP id q14-20020a170902b10e00b001d4448283c7mr1351154plr.117.1706465955174;
        Sun, 28 Jan 2024 10:19:15 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8b574c9f1sm2447026plb.305.2024.01.28.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 10:19:14 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [RFC PATCH 2/2] checkout: remove HEAD special case
Date: Sun, 28 Jan 2024 23:41:23 +0530
Message-ID: <20240128181202.986753-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128181202.986753-2-shyamthakkar001@gmail.com>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_add_p() is capable of handling HEAD in any form (e.g. hex, 'HEAD',
'@' etc.), not just string 'HEAD'. Therefore, special casing of HEAD
does not have any effect.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/checkout.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..6b74e5fa4e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -539,12 +539,11 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * recognized by diff-index), we will always replace the name
 		 * with the hex of the commit (whether it's in `...` form or
 		 * not) for the run_add_interactive() machinery to work
-		 * properly. However, there is special logic for the HEAD case
-		 * so we mustn't replace that.  Also, when we were given a
-		 * tree-object, new_branch_info->commit would be NULL, but we
-		 * do not have to do any replacement, either.
+		 * properly. Also, when we were given a tree-object,
+		 * new_branch_info->commit would be NULL, but we do not
+		 * have to do any replacement.
 		 */
-		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
+		if (rev && new_branch_info->commit)
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
-- 
2.43.0

