Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AB14E2FB
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906604; cv=none; b=dIg6OGmXy6pBv/FRPeJJS2Ji0onh3lQfYVNP3L4UsBlWCVSoQv+GJpfER6lZc+Ok/Onb4Fl9hLcUZbkoRY2PgSY53vSlw1r8IDsY+nxRF/+30AIDK5G4DcAD5G7wDbJNqbAWYT5bv03HXtvK+rkLs4jaqWUNZP+4xf+bgmBxltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906604; c=relaxed/simple;
	bh=OtBimNkwnIk94ZSTta/HkYIxLDWplRd3hHrM9/EwHKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHP6xRyYST6spgPz51z2L//5elW+qbpibWK35D4ZCv34jCkZT3b3CkchBtHHhnie0tDvuS6Qpmas5BzA0NCpxmXkTsQJWTbdKA2MwlGaogCENcieCTMnwO7KDggYHrnPflsRi8D1fTyPjz2dKwqeD5DAkC+MMgOs8Tb0gPL2r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2leaizH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2leaizH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706a4a04891so2445818b3a.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906602; x=1720511402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6AA2o4X8R22DXw/IanXSu1lHOYpmnIlURb7wXpGIFU=;
        b=U2leaizHNZWlgDZSpdDN4lvmqewnyM3+dHuoIDbAyPHVQRYZR1fSurqFQ8/Zi6GWV3
         jlYUIABfq21ksewmiW9QR30AjfnxQAPd+xacV7FT/e44vHGHAAwWz52l+1/Xl5qrTMpG
         i05bRd5Ybfvo+tpVsCTuAgrbL21v84DmZTEe8zWT47B9bFhoQCrxyC0s15gSt08xUPmL
         NM/LFwdtaSPzgqISnOs+cBXfLwTN9MQv5NV8Ion66qMlzUe4NdX0qjz3pWe34L1LL7yx
         ++ylHjfVQOhQwGwtCB9E1KyNgWc5mN4oRVk+oXhkrCtfh8ann3pF0Y7YB+N6RjUn18t2
         hj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906602; x=1720511402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6AA2o4X8R22DXw/IanXSu1lHOYpmnIlURb7wXpGIFU=;
        b=pz6FwLFto8AuA1P77nYQjQLMguYeAFd7f6ilI2F+Ka3omkoTPcAm3FG00fh4U2wPQI
         C79fmniSUxb0lMgK8H4z4Ltl2qx2tb5amEH22Wooqee4oyLmtqr7oe7hY/7RKG/A2F8s
         v0kdULf8iwEIBk8gGdSWaECOeT4nUzFtCU3k0VwEaAPWSL6pegTrxLxg/5TjkIzI+Dxk
         Be0H7O1QeG//43TqM55Bb2h9nisRf1xIhSZZUVxxoFp5EjOIh/hxtoEvWn0m4jNUbcsr
         bmGLKXln3+RxMB17wp1JIg8rOEtxksnX4LhWknCOxbvBKw9a05VyClU21Kq9fxswksUM
         J8yA==
X-Gm-Message-State: AOJu0YzMb2cqXWGKhAm+94vdy/WSCoamUaKyBcx5VUFKO5nGViGdr6AW
	0vPf3cqHmUyg3dkjYohWt8fZHTXqPDhnralKMaFIiEzloda1wqy4yXr/PX4Dvbc=
X-Google-Smtp-Source: AGHT+IF2d5Oi1FeX+BhivJlTrx3wFzdMcvip7xWrAtrXa4cl4Ly8j+A5GoDlfNuBpQKHRh9BtvoWkQ==
X-Received: by 2002:a05:6a00:4b10:b0:706:7943:b9cc with SMTP id d2e1a72fcca58-70aaad4c445mr6238473b3a.12.1719906601925;
        Tue, 02 Jul 2024 00:50:01 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:01 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
Date: Tue,  2 Jul 2024 12:52:19 +0530
Message-ID: <20240702074906.5587-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
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
is left untested for all the four record types (ref, log, obj, index).

Add tests for this function in the case of ref records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 46614de948..170c804825 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -102,6 +102,7 @@ static void t_reftable_ref_record_roundtrip(void)
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
+			.u.ref.value_type = i,
 		};
 		struct reftable_record out = { .type = BLOCK_TYPE_REF };
 		struct strbuf key = STRBUF_INIT;
@@ -132,6 +133,7 @@ static void t_reftable_ref_record_roundtrip(void)
 		t_copy(&in);
 
 		check_int(reftable_record_val_type(&in), ==, i);
+		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
 
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c

