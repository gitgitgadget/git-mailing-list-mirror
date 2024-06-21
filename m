Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D215C9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949725; cv=none; b=aZMjbqiSZuSi7ErBcaKp0/7VD3fVNtAHRUmOFgSOd7mf1VhbDi2j3RnJ8uozIh6jX14BCOsPZNglS92Kx6LCfRTqL5/AhjeJxSusu5gaCvigns8VL7OJ5474BtI93FLfKkUbF2wW7Yf9BdWFDvDMsvI1Ny7gL8Q7uHT6KxAFmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949725; c=relaxed/simple;
	bh=ZKfkTs3VrsBroN2uapjdESCeNg3Zq69k0Jjf4AuWqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEkKkkrstakTFuAqpRKQwPCedcsKMLUc4uNGC2+ZhtqLtynXD7YGOKQ2dRdnK6ubtZ7rJ3so0mcqm62k0ZIc+menMcoOcb2UpPoRx/7PIt8knhBP4SGPKvFc7YSOMsTun59wR09JJiKIEGte7bgpADUioRfl1nalxb95C890jQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia9oEQsQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9oEQsQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so1422953a91.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949723; x=1719554523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DkFDrU8YzLgG/uSXBvcpdbNRcxxJdAmTSnFAAAqjnU=;
        b=ia9oEQsQlP3HJ+Pvk12CgxqUewKN/R4OdgZLUezC7qHoKgDofbXgOw0oU8NIc5CzXY
         G3PqKkHAdS0ymVFn6BatcRNuqOLQ9Ibq3D+NyZdc60UB0iXRRL/e7/yznRENu2+cjVIe
         nD5h1+fx9JGPd6dgxo6zVRCllYJH6HiJIlqIJjnAYe8iZmiFrsu+N0nBRfZA8yhSqX9/
         OVPrbQZngEpJJqrlCdMXn7esBMVAq7fEY9+ajgcYvBdEItO+8WS3tSGY9jUbY8VsKtOA
         dcQ2Bg28LDGeBCXj4S4z/tb5d/rzxjH1RhYVLHAAoegppa9odpw4AS0YnwuK1WQqhQx7
         dNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949723; x=1719554523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DkFDrU8YzLgG/uSXBvcpdbNRcxxJdAmTSnFAAAqjnU=;
        b=PU296uxCYVVs/c4ijZGE6PnWpn4NV7osMyM24TAoP4Uaqpi+/FdqTPW2Va5oBRv6Fy
         EoAtUBBq0KK1QiWjq7ZpxgoWRCpNyXlPurrUvYIceYisHwsBtQo58Ks+ixFiJveYEeI+
         xvhxs0SURxN0i9UG2UBvABwqXCu1BrK64mthZZMHDzCIohzk48M/X4VR+5tHG7PtAP0S
         FWWR+Jek0xMIckEqdV89tE1xbUHAjYPSGDXYxlrtwQmlPWHrOZHdVrXiflxeid9uimrr
         07M+0EwsaxRQxnwYCNSsagngSGYh5bfgoU2KhkL01kNwm5dTw14o/DQ386/m3nQshq8o
         3C/Q==
X-Gm-Message-State: AOJu0Yy5wyobEInE3RM4RO5kfIrj7fIGvCzAAa+A//hiTXO+p2F3h2Re
	/WcdR9fwbHiZSdKVpf8+iD4K0Eh1A0Dx4FLLNK97Cw8+mQH1TBZ/0frZZg==
X-Google-Smtp-Source: AGHT+IHHMPSihLucVh99Zww450k+qH2xRG8KeKzBc4t+jhjlYcIKAcuMEYviHZQEqeE4J6VgbEklkg==
X-Received: by 2002:a17:90a:ce90:b0:2c2:db48:aae2 with SMTP id 98e67ed59e1d1-2c7b5dc9c13mr7416832a91.40.1718949723149;
        Thu, 20 Jun 2024 23:02:03 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:02:02 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/11] t-reftable-record: add reftable_record_is_deletion() test for obj records
Date: Fri, 21 Jun 2024 11:17:07 +0530
Message-ID: <20240621060018.12795-9-chandrapratap3519@gmail.com>
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

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} which determines whether a record is of
type deletion or not. Since obj records can never be of type deletion,
this function must always return 0 when called on an obj record.
In the current testing setup for obj records, this functionality is
left untested. Add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 70c1db6756..204a673260 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -389,6 +389,7 @@ static void test_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
+		check(!reftable_record_is_deletion(&in));
 		test_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c

