Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7921D88D5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462129; cv=none; b=CxnJMqNHj6Hnn+if6+z2YRdX/ACPsOcpTP4D26nPmJOalPHf9iDqh22oDT8q0YltTFbYGEsNUVX0kW8TjyMhVh24qxU75qcpnLx3HdJ/l/NVOhkiJjNS+IKA6CmyVLd1Jer1upD5gONMR4DEVrLFXoWC/pzS4+2xrysTDjhRtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462129; c=relaxed/simple;
	bh=04EbSP/LvkdTgS/2dPSs0llfA+pfbAVgP+qYVm3wpOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ffm+KnGPjDXkx+qJOmQ2ixpbHeq/s4HiSKhf1Azz2MtRXI9Dd2UEBSi9ZWDTWnfMuYAP7Z42JwzD2WxN92EjMowaxAM8cpAZkwAgjIFdG4ERJxU7296igNdHzBip90nnHWJruORBoA7UpEpWLN5MXRhwShiUhduhTgtV/L97Kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMFPId6O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMFPId6O"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205909afad3so27056655ad.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462126; x=1726066926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWMeEGPpPBhRdbp2ElETdrQGKzusKxPku43hdOmugw=;
        b=KMFPId6ORYx+5swnpGJF7HrCImOmJEqIGI8teocLprgR/EXCMvfV1Y609QfHHoyAtu
         n8zknvcWV0cfqEk1w5k4ZhAB5V9MwQoY85ec8KI6g65sk8hexoXGMxZZOA3uvBUnvQRK
         IifF3mALkFAPqPQdocbHtmYMPc6P7K1M4xlyeSvG39gZjN4iQGSCT2Z3i3g4/pNLH4mh
         asetmrscOBtbQUXQRU5M4IWkdSECmsrKFRIhhee59ePG8XnES9ysDxVAh44JroJjU3Cm
         JQ4dO0oqvLq+fd4KvFmImo7HJMr7wRm1Xv5xl1uTM/qwVjNrGaDlytNOSbKF2C8P2Bi9
         angw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462126; x=1726066926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hWMeEGPpPBhRdbp2ElETdrQGKzusKxPku43hdOmugw=;
        b=TlK+0lKg/Y+qoIv82xnMSQh2qyyZuvg5IhpzUccIHikMe84adP9mq7PFd880VYsslB
         ChV7usXf7IDBOINTmZz46uTyNpGyGzR7aTtN58kTEjJpPg2BgteLTffghFLgziarECwt
         WZo+5mZHE7OoA0mvWKGYDS74b3FOkjIQE0RfURIqE5SZbLznO+FS/ipOis1yc5SZCU1Z
         raFEpBuagHzLQ5LyeJ9V0LuvqY2jY+vkw9GT0qzueVI3RZEd/F2OUL/K2n5mI7fpBLfa
         Zc8wxnoUHpYOADfsgwAQ/iadnZ6kHYetbCeTosd1YfjsRRKLebzY+sGPteO+BgB7imv/
         r1zw==
X-Gm-Message-State: AOJu0Yy2wvwX0AIaubribuPeXfeYBKuLLgQnZ3LvuimJ/dGKpNuwFOnm
	qnG0+SIEItjt2RxYdJzq3bO1RGvSnikwSjF6HPbAhNJuq/IS22QQpxxSZ5VW
X-Google-Smtp-Source: AGHT+IGIimwbNlb7qUGDWgfbWidg4laQsLcTS8Aj+EZgzcsQZ0Xc2S7xtWjEv8nhxD69ALXmLvDEvg==
X-Received: by 2002:a17:902:ecc7:b0:206:c60f:494e with SMTP id d9443c01a7336-206c60f68f1mr14141705ad.23.1725462126044;
        Wed, 04 Sep 2024 08:02:06 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:02:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/6] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Wed,  4 Sep 2024 20:08:04 +0530
Message-ID: <20240904150132.11567-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current stack tests, ref records are compared for equality
by sometimes using the dedicated function for ref-record comparison,
reftable_ref_record_equal(), and sometimes by explicity comparing
contents of the ref records.

Replace the latter instances of ref-record comparison with the
former to maintain uniformity throughout the test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 8047e25c48..4f2ef1a8cc 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -174,7 +174,7 @@ static void t_reftable_stack_add_one(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
@@ -285,7 +285,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
 	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
-- 
2.45.GIT

