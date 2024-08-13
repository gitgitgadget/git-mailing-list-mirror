Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F31A01B3
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560315; cv=none; b=YOLnLB7ikLasDT3KOpPIhDWYBGudHxk2rSmhPqYooa5fBYSehkcVq7rYHWS6e5dTDBD6/07v2XXqNkPYv59BoiTj15otjdRTwEKmDLxSs48KqEa/4IV1ATyz2nvfCjHj9UPMED3uO/35aajyguFUMbY0GY5hoVAyh8pSmsKZLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560315; c=relaxed/simple;
	bh=QI6Jai3TnLjM7M7GSXynpzUfbkYHUm0xGcScuumdmj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNx1dHrmfQH6pRo/qWFKpLn693J1STShDQWOK3nVSta6u4E9eRePYeiUEYOo95Gk6PtSZbA3Po+SlJs/KOl8euDtxTfo5gc1lgCfP5WJvYjfZQ4yXiISnKaNJqbKx+cBLGCOJ86prVgIG1njQH12mznsDd08b2/8wBMKdtxHogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmCxy/Kd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmCxy/Kd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-200aa78d35aso26812905ad.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560313; x=1724165113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDRVWmWpMijsrLk8w3wXGsOpUkPgY9wrLnYOhSIe4p8=;
        b=CmCxy/KdhT1cWk65ry0kcdBZNnryRU0Bxl3RX5QyFspGZnL76La9nDXIZE0a7MNQlw
         Lv1G2wmeelPs1AxRA8PUjYE7YU6TyYWzPwNdM7eNgsiSKJY7LJck+eyJV7BENS+OZFOR
         q5IW1niHQZnOabZvmegpNcRQXug8yqMoGwLibjWVB6SjU19Xjw9TQ7TaFpsmE7SSntY/
         okMTmtbcSKr5tS/Y92zJzRM3NAreO2AWCUOMmnUXqYnGfxZfQoVJuRcqChwzUQ6tgnXS
         lpttJLQvfV4IS24gLOc58JW8/1pprV7AHMu0jpDfHKuGBXVfcs2ErgIpim0n6Qs42dWz
         vAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560313; x=1724165113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDRVWmWpMijsrLk8w3wXGsOpUkPgY9wrLnYOhSIe4p8=;
        b=vjlGGFxt0O/vYuhrr6HpuYnEbwye7m0bNmwgkqPALZq7W1bBXZ8EwUxGzHGQpBpZWa
         v5FujcX8Ahx7upgRjlDg8uhMm5QXXj4BJiKbH1AKaSc6yd+892/5X5hzu4c7LUaNroxk
         YuHbwuQ6HOpj2w/LD+q0aGbfIh0lf7hSIpjLx7glBO56JqDt+6Zdyn9nkR8f6ZbGsTHF
         euxbmAcvkmXW9jp+YaFp2P4Fgab1mWdsQI/9ey6Y8h4h8GS5Kf7r7yTTAL+0VQ3wSuHs
         ENsk7/zmb68b8dX0lQVJ1Q1HZjbVYc5bGN6vmWmuvpdToLs3kOboZdPcOuMPjUFud5X7
         xIRg==
X-Gm-Message-State: AOJu0YzS6Gi15MhOMkhprheOlilxKqZOnhqnTMXPy0FAvl3y2le9LEDU
	QbuFs7IvrlvdjahfZcbDJtwd8E8KBhNdG68rRDiFOIthjnZPv38prxNZDjjyKms=
X-Google-Smtp-Source: AGHT+IF+szp+yBixuHVll+RenWpgf0EsLNKjc9sMX98qP6GfCXO2MVV4eYnA8ab+RNcgaHDQ49JP0Q==
X-Received: by 2002:a17:902:eccf:b0:200:aa90:f8a7 with SMTP id d9443c01a7336-201ca14e3admr36938755ad.37.1723560312832;
        Tue, 13 Aug 2024 07:45:12 -0700 (PDT)
Received: from Ubuntu.. ([27.61.226.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd14b1c8sm14388805ad.78.2024.08.13.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:45:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/4] t-reftable-readwrite: add test for known error
Date: Tue, 13 Aug 2024 20:04:50 +0530
Message-ID: <20240813144440.4602-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240813144440.4602-1-chandrapratap3519@gmail.com>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using reftable_writer_add_ref() to add a ref record to a
reftable writer, The update_index of the ref record must be within
the limits set by reftable_writer_set_limits(), or REFTABLE_API_ERROR
is returned. This scenario is currently left untested. Add a test
case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 9a05dde9d6..2ce56a0523 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -774,6 +774,11 @@ static void t_write_key_order(void)
 	check(!err);
 	err = reftable_writer_add_ref(w, &refs[1]);
 	check_int(err, ==, REFTABLE_API_ERROR);
+
+	refs[0].update_index = 2;
+	err = reftable_writer_add_ref(w, &refs[0]);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
 	reftable_writer_close(w);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
-- 
2.45.GIT

