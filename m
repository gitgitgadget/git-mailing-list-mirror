Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714B1C6880
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830917; cv=none; b=pDtzO4c5vAQJ7c4lyVwNyXSd4XmAFsAp7N4i1fvKpCpOiOzwfZKQRH/lkUPwyeUjZ0Jma1LoHVedz4TZ5J7j8XB/H+ehdrqi8C2k+xnfOegZsgHq4xYuo6PWLD7e5pq6+/nIlg6z6tDH7IHY6ntl2NfDlSTcXIIn/uMEdk0v3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830917; c=relaxed/simple;
	bh=fYVq6x6OTAxVrRyB9SNlLxuuV5rAOds4y2R7OPJDboE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/xJEN4O+3Aae8Xf2LRbBuT4ahmtssSQmNTGJP01NDv6JH20FpWhEdB0yFQ0Z6AnoRYW2AdO7uANykEITOBtB1gEgIcaU+QDmbEb0MbTaVIKn46GGWMRwtWP+btKNB2vacm1Lo+p6+VitSXcrKSsPTHNkLTalLB5etUgiELupLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4ilstEo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ilstEo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1d6369acso2174830b3a.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830915; x=1724435715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1usnlTgK4r1JKqKCnaxdmYmZV0LRBT8lm6vrlKlxjM=;
        b=l4ilstEo7ejP6eW8+8iw2wihgRUPH74dBOOoYD9HbP6VRtyDPfnYXTpisgbAEFo3wW
         Se4lLM/wEPu499jMyMNshSaBc7dJKShp9o3WzGkHG5GS/7C0aA9Yc0LX5W6f14rcJeKX
         ydjz3fUNyHC+rr1INOvtOZe0lsURrLQR60mwW0GvEGhLlTnKb0hZan3Dg6WKR2HzuVju
         YI7vlfMP/Lfs2LecApa+3XRz+PgPRe0LKpbM+hAXh2M7EBHznxQrYZT9zYnc94/A7Kf9
         QgjfTpnKSQckxmzv/6Bw7ao5wtCoNKdqicLwP1NJ2i+heWJKFQJNqgtZBLe7qKSmqg9r
         /t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830915; x=1724435715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1usnlTgK4r1JKqKCnaxdmYmZV0LRBT8lm6vrlKlxjM=;
        b=vW6X8wo2rngNVFYQctSdFWTUEu1YyvF372YOrmnoAxNYoMbXt1Q++c0sntgtBLuBef
         yqeuATPGsvwRd3ezqRQMhd5SLJNtuBDIILMGgpaTKGzM/baNnbk21rABd9x1uhaDX47X
         sSFyT9yXLPx3r3GZe1R4TeTsGn9q9SL3Ti3R3abKQqQUsMY+O4+ktb70OAzVmablQqV4
         6v8DQBs8MdlCPjeyAZxd7n+oTAJkAfRDlgsfxW8SmLtprSyvnfbn4JUJ/A8z5YPKk2Xp
         v8rM9Br/AkAUabGoZulOUgUSM5zfy5qmFVN9+2Kg8i86FhYcst6mU0Dr6ZBKG/6zfHhq
         iz9g==
X-Gm-Message-State: AOJu0Ywcxe7tA7wVpu6P2/LBPRNZRL7e4BB53VgkBcRWxMlXPKKPKsl9
	eMbNI/0nMudPf1K8vHGBhADmYZD6mlKPzL2I2XnbuRzY9mRRse10W7gjqw==
X-Google-Smtp-Source: AGHT+IFwsckwnepyxSGabYe4cd8KGO+j6o1GmghR4l5FK4vO1sQylGDeRgefumWjg+3h063UHtY/BA==
X-Received: by 2002:a05:6a20:9d92:b0:1c4:85a2:9958 with SMTP id adf61e73a8af0-1c9aad2cf8amr4734041637.25.1723830915457;
        Fri, 16 Aug 2024 10:55:15 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/11] t-reftable-block: remove unnecessary variable 'j'
Date: Fri, 16 Aug 2024 22:55:31 +0530
Message-ID: <20240816175414.5169-9-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are two variables for array indices, 'i' and 'j'.
The variable 'j' is used only once and can be easily replaced with
'i'. Get rid of 'j' and replace its occurence with 'i'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 81484bc646..6aa86a3edf 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -29,7 +29,6 @@ static void t_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -64,15 +63,14 @@ static void t_block_read_write(void)
 
 	block_iter_seek_start(&it, &br);
 
-	while (1) {
+	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, >=, 0);
 		if (ret > 0) {
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
-		j++;
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 	}
 
 	for (i = 0; i < N; i++) {
-- 
2.45.GIT

