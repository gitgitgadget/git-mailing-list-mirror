Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3D7F7CA
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556649; cv=none; b=PMAT6k5agGV8yrc8Gf0NEUt0SdrCHUH/vLv2oE3vlZ+z6zRjJhb1uOJCuUo4HO/DW68kkTS3qJfPnNuVbFskbd2cv92VCKmLXHyDPzVjroSLzTb5RRjCsTd7/hsdk8EtNzwQD8nL073RDtPLotaSywZkgdAgoiGEVrv/TaSjE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556649; c=relaxed/simple;
	bh=BP06EDRvZG7FzNWlKj+6KEwAKe9JagKTD+thyQkpEEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilCC+lGXbOP8i9/qDNnEbRE3QRJzVib1hwVMMTN+8J3J/uiCFkrI1ajkyeGOwtdVdibH/lVyYkDP7ntuW0VMIPEuQp7x3UbtaE0Ft8OdkEpT1y/Ld4Cf5MX3gqgtBmnV0KtewUoOAn/AbeG/wyyM/h8/Mbnv7tuM2UnV/WgJkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ/yroMf; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ/yroMf"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9cc681e4fso159537b6e.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556647; x=1720161447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ck0l/MCxUwUFr2m1o8QgrlNLROreBXDTUAJK5Vyax0=;
        b=IJ/yroMfdfYT2qVMl63eGRvdvffCNjiHVxQUysMm38hhD5oauTB7KnjtjZCGfZ76QK
         FyCs1d9RDb23q1JvgzpVw//alOVb11XdixzGA/Ux+8u1uCp6RI1xlZ/7nWeYWSn5vhML
         elprLHjYmxdPYN5ACwaB8e7/+NxD4XdPYgCSXXF5n8PLtV8GvbT7FjNq7QnVFzOT1c1k
         E7k7xjeVCj6ZVndGg5Zj90nJORuQlL61sTa3GaP/LvcyYn36NQxDjVDJ31QFaX2RPaGP
         YyRqr/az3uOjEUeK9khR8RpTcxABKNEVGEui35OQtNBVmx0KasHhayCZfBCfK5xHlNHk
         blgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556647; x=1720161447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ck0l/MCxUwUFr2m1o8QgrlNLROreBXDTUAJK5Vyax0=;
        b=sLWy07/I03K+F6WosTE/TrJHTfbA3i/SvhHuglcPw3ApLd1s2fOmsfC1L97fInZ/Xq
         3vpCITNJxC/1dyDw956XaOcgS4hPR8VeFhpon5DQ2udm/wqG8OmJYSKsCpxGaBcIOw2m
         vHWJfRIjXqzMCC2PKz3voPCTCrdmWaMZ7NtRLU9waDDSGUGs8eC5QOCjVFVRywI5gO3j
         DtOiPzqE6eqT0GAdj73qDD++M2bR/SGOP8HSIldLd+b6H+IdpchYawOO/4JgcQxQDspv
         /npHm+P990cU/vrVkjsUVZW4BXpjSsU1OfxCX/SXHZFJPegoArF3eiKQHQDRzdJQyFhO
         pcng==
X-Gm-Message-State: AOJu0YyJxiVO3OVheV9YJEMYeCxNpYDVLzN7g5OUeOFmJ85nYfU7Y8aH
	AUS5vDWPoO1lohx6oGd+6YMA5FVetwDqhA2SGwcKZyeAKE2LTdgYd/bRnXCTh5k=
X-Google-Smtp-Source: AGHT+IGgW3o0sAXSEtaleCJE/d4RnwXTZLJZuESzo7K8qPz96N4hPHVaRFcJp6QZ52CHyhFsOJxv6Q==
X-Received: by 2002:a05:6808:2226:b0:3d5:65d5:edd9 with SMTP id 5614622812f47-3d565d5f1ddmr6294057b6e.16.1719556646741;
        Thu, 27 Jun 2024 23:37:26 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:26 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 07/11] t-reftable-record: add log tests for reftable_record_is_deletion()
Date: Fri, 28 Jun 2024 11:49:37 +0530
Message-ID: <20240628063625.4092-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for three of the four record types (log, obj, index).

Add tests for this function in the case of log records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 99dad75fb1..8983d54bb3 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -220,6 +220,10 @@ static void test_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
+	check(!reftable_log_record_is_deletion(&in[0]));
+	check(reftable_log_record_is_deletion(&in[1]));
+	check(!reftable_log_record_is_deletion(&in[2]));
+
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
-- 
2.45.2.404.g9eaef5822c

