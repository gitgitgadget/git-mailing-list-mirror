Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5A15C9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949718; cv=none; b=c+fCDiFRx+l0msqZlJaMgopS5Fv3sb4U24OUQkn3434rDdjSxhccswv1M33Y0LDFcBTT3/Pnp+o+BSeG/onO5a43+6pTq92H2EQmi+q3nDvCHjT0p7bz+wlRACWDYn3zf+0ixBkxKNfOh/rFMq3DUsWtiVIVvs2JDc0aPUCDzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949718; c=relaxed/simple;
	bh=rb8XTwB1xLbFMwXVZQ1sw0EvrJkBNZRZzRXS2ELsoWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0DsYzlElBKTx1h6mPPDyW1qxBm3h9by8Mu/NXuquDdeMjU79co/bwg8mfvGKQ+tquba4AIGzPXGYz1VFuYaee7Czs96hNR2mRrLOKToi3j4NzTx/lwD0LZztxh2SL7aIUqEisVeU0hmxRFvV9iswoDpu9FDPE7V/mayG9BcVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEYG7UFP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEYG7UFP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7ecfc9e22so1106587a91.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949716; x=1719554516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3hMQjdCkDKBsQOBEV/f92WR7TRzdNbkwpcecxStxlk=;
        b=kEYG7UFPoQnuH+nPtT7ge7tfDOjAjU12PlZ/bBUwruaf17zKe60aSzp8fDNC9AnZZy
         C6URpjxw1DnOKCwQ1ChpYkDuNEZNUUJhXeMnOFoP+QDeCjTS9RPrpAP7JUAh3+JtjLO0
         mJBsBzWUWoc+DAA+Q9BW2k5VG8EKSzbA6QUYJptba0oAM44avr8h5QajLiUAa1Ulpr8M
         09AIAddzI9qD40CD1vqB4AWOcYwAVHJbWPgwV6XNX1HasdrMClZ/6bHuEvtV6iEb40Fa
         2XLIATnnlAq3RgPckE9p+EPeCSqQiq2LiBM8iSU1D1TIiBgyH+iBU0tULnhyR0KFD/nR
         bC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949716; x=1719554516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3hMQjdCkDKBsQOBEV/f92WR7TRzdNbkwpcecxStxlk=;
        b=Ajzc+Eyl/tnvyF/2OVtUI4Ym0m/qFF3+mxcAqpGJ8xGTJz+HJIwsNMBr07v+B2ti7s
         YTg1GjDKLcvPv0osANFy1cVhZRjg1yRWCGiS2SFD+eZEgcBiVmfxaZSYOcYEAfsEsFtd
         zXOHvdxdAEU5hl1OhjjpbgAbH8wQx0rvl/WpJKYihMXCjqtHEKfE0HpXZq4ad4OsLsi6
         xnHCiEzF43WlMWbQy9UocwEQnVUzhh9NLjrnDxcneTVkkuJfBVS7A7ndHzdX8zVMnhys
         j2CJKIg2YH591jUcDM+hb32up2PLFRMDM/7PzLCDxqWquzCNyDEpQfwd45jalmcJGcDd
         8qUg==
X-Gm-Message-State: AOJu0YxYddu+c/XLrtVpW7ZzFaryIG9UI3SaD19e1UAGNJApxYuxo/4P
	lbmswJBsVRXRI7DQzr875mJUuK7LPPEndT/FQXe6XxrlofAuYKL6heitWg==
X-Google-Smtp-Source: AGHT+IEmBz4VMCO7G8c7ESfb0MCrOWdGpwH7/yWUJqf9pHVdavrRq5ForJXVyFTXtmMnN+OL35Hwyg==
X-Received: by 2002:a17:90a:c243:b0:2c7:700e:e2bf with SMTP id 98e67ed59e1d1-2c7b5cbdb3amr7808551a91.20.1718949716058;
        Thu, 20 Jun 2024 23:01:56 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:55 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/11] t-reftable-record: add reftable_record_is_deletion() test for ref records
Date: Fri, 21 Jun 2024 11:17:05 +0530
Message-ID: <20240621060018.12795-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_ref_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a ref record is of
type deletion or not. In the current testing setup for ref records,
this function is left untested.

Add tests for the same by using the wrapper function
reftable_record_is_deletion().

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index d7490db5e5..fe12fd2201 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -105,6 +105,7 @@ static void test_reftable_ref_record_roundtrip(void)
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
+			.u.ref.value_type = i,
 		};
 		struct reftable_record out = { .type = BLOCK_TYPE_REF };
 		struct strbuf key = STRBUF_INIT;
@@ -118,15 +119,19 @@ static void test_reftable_ref_record_roundtrip(void)
 		in.u.ref.value_type = i;
 		switch (i) {
 		case REFTABLE_REF_DELETION:
+			check(reftable_record_is_deletion(&in));
 			break;
 		case REFTABLE_REF_VAL1:
+			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
+			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val2.value, 1);
 			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
+			check(!reftable_record_is_deletion(&in));
 			in.u.ref.value.symref = xstrdup("target");
 			break;
 		}
-- 
2.45.2.404.g9eaef5822c

