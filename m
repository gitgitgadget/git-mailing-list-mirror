Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453E2FFDF9
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270426; cv=none; b=X3UBrEBRduxdLLNxAUnSL+JhX9U0X6DkwIIZbvNc7HBn8PGs2TmlyET+c6q1TjiA9drx0yxxEGqai83NgsEdYxnqKmn5ER4BSLrnyw3SaP46yNcYv/kXf3OTI+DJ+vfpLjfuWmI5Ts+uu12MKXq7K/6QNsGM3E8AmcSzvDW53Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270426; c=relaxed/simple;
	bh=/5uzJs3tBZuiiW+Ef1qHiGVNPeuZ1ifzIFipBYLHSqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHUmq+HzGJYxQVvSSvzE6Zy777q4zULiduaQknFjD4AvtN43j6sb4rVeY6tf1E7lcKgGBJclKyd3ZlxBwtlFrHhM1MR+rLsBpb4DA3jydFxjbvtqE2CXPFUmtDN/PrHmL3l+30YZ9l/HH/qtp7522L8tu+CPDAD/boBl9NTLFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4jrmyIu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4jrmyIu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1209054a12.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270424; x=1758875224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaYlvQWG4pKayQLSDntmz9GjdTwQI7ENjaILk9hq3k8=;
        b=A4jrmyIuXml3SDXdFA/oMgh1mNyyXlkTgUiSAMmimT0ePXu8B+J9a4pMAp04CMwksr
         dIr+vLsewMKmxC/ChFYPC1Ah8JJGtH4WGDnGPrR2xackHCcq60fBXgB7tUDT2FKqu8EH
         EwrPQoDIksYJnpxmgYwC9PRR2Vz3ncZc6yiQ+xSeDqBKWSRejRwqH70qwTTllQlwM63R
         1pfwWgQdgG7jknUupwe7l3IYCA+VkVffzq+3TRZtdy9rJ4WMPgWEk0a6TmLiA/NOgZBa
         93SEclX0HPiOCyTluCC+jmdxyaA9hoN/MWwVVKJxTZls0MUligUBAfHJqNC7LiYBETgI
         5x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270424; x=1758875224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaYlvQWG4pKayQLSDntmz9GjdTwQI7ENjaILk9hq3k8=;
        b=Hq8pXuxp2+Ul5WVMv/fYzXxF1j5xn5Yg3qKxJD88TyX/OxoJaD3nabCDAExIkJNyjK
         1KTsNBrIg4lRJi8Stpxnqoqlao09Cy/5RK1RwLVMCyY+TriuU5+dZKSHlustzcYxCY/K
         3OwEMPIotM62/V4Ou0XGczdenTl8svD4xhbSYIZRARmTa+yjEaFTGOps4vJ0Zp1M6OzZ
         O7xIVegpRcBAY4UwRLR6bGlwJV2GBrQxvpBiLoYR3ss5EzsuA9ckJip/5i6grMDq0a4I
         LL+Xtj3CM9oGlBZNIYxtj+0VtQEa7Ks/s99ZDWtFVvQVnVw3Hof4XmxfUIOoASvp9z2a
         O2UQ==
X-Gm-Message-State: AOJu0YzZYG/xIZd8RAEYxG00fS0YS3PSN8EASmxrXUVcNwCcpsRV2gLw
	oARXdO8SkmRzzQdyElB2TTmkw+/2lvWpmdiquoejEpDxX3UZFTbUsgAONks+WQ==
X-Gm-Gg: ASbGncuXproy4GkCDJ8qVsJWAgA0zyom9Ywz3S8dVE+j9S2kTzupAGtu/k+njE9B9/x
	BytmwtwJB4N79e4koPwLxFOufXFETzVD8Zlrb1BLABpnqUkAQg5Cqr7t7IuPuI9LMKUJQOM72rV
	O6GQ7a+dJMUlYmp4h7yBprCF4KpGDwkXhY3j1tO5UouxNH8ecuPIrrg/WZFVPTeN4tpRj7z96AM
	IxoHH518KcBhsnbMKuDWfAofJ/0veYp0zO03gxs+PeSYg7PsBYtrxJGHGBgX65Y4wVqFtYAPYEF
	P8nz4/7YbvfxIchEl/JmTB1SVq3A9ghmRTiw27r2htAhWaIwnHf4VKY/QAaC3FU7PUPzZn0PCZb
	lQxMagaYvtKJC8vhW78M=
X-Google-Smtp-Source: AGHT+IGIL1oMZXeVVBI1m3TH5WLA7mvOrPcXnb4tlA4j8Bt66h6Wy1AmvHirSoEmQxHOB49kFfxNog==
X-Received: by 2002:a17:90a:c10f:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-3309837a720mr2762508a91.28.1758270423692;
        Fri, 19 Sep 2025 01:27:03 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:03 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 4/9] builtin/pack-refs: convert to use the generic refs_optimize() API
Date: Fri, 19 Sep 2025 13:56:42 +0530
Message-Id: <20250919082647.535213-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git pack-refs` command behaves generically, triggering a pack for
the 'files' backend and a compaction for the 'reftable' backend.
However, the name of the command and its corresponding API is
conceptually tied to the 'files' backend implementation.

To create a cleaner, more generic interface, refactor `git pack-refs` to
use the new `refs_optimize()` API. "Optimize" is a better semantic term
for this generic action.

This change allows `git pack-refs` to act as a backend-agnostic frontend
for reference optimization, and paves the way for the new `git refs
optimize` command to do the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/pack-refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 5e28d0f9e8..dfcf664524 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -51,7 +51,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
+	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
-- 
2.34.1

