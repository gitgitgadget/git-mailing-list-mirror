Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485F2C08D0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165573; cv=none; b=cIfWmtmvPG5r45NLX/bRPyL9ApEYZf28sL/shaFE6Nk/uj7znW54X1fufslTOEY9FIIh77/AOfGESuhwWI8HIH+fV40heLyh2j5PfPJt2RmV2g3J7g7WaDo1xu2/C8Xf7lEuh/SWQzx10ilNmxtRC+hef7k2Y5WWkbB08iwTk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165573; c=relaxed/simple;
	bh=NKGzjbT3G2Qs1LobYt8i+F1zwzUwn6KVReYzMTAQ1Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLGCJ0LtXxc2Rpz3OyFftenhyAU/jWsWuN0MyfCaH4Jv/D5f0AV+6acqjIeUaJFXGwZa/ZB9JEeFrCNIw3xzSsuDQ+NKfkpnRbzYmCf23pAtksNYM6wGMNmUxWkRFjLR9uBccilB9zw0G/chjaCSkbrcucn5Gpk3TtgWLBvNJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2PoA07g; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2PoA07g"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40efc77933fso869135fac.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165571; x=1775770371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=X2PoA07gv/KLeJoYG1Rw2tdzh36ujBB1skO1/hY1AFz6oJ3YDgygVnc7uNBfMcX/7H
         tECr8NHx099yPK8O18q3p2bESQbkD9fUbL+PTtW87UKqeJgrNmBE9/k4jGXXtWIajjI/
         2Dvl2HRydYXF2Y8GJIhXoWFXEwCLLAeRwTV3be5/STWi5S6NwPKHFi0etMmzwE0O1HWl
         9cFRLVTWLOIqr4/K4fU9fwWoAbBEDuKGDOPhlQdykRF1ynQZeqibhfKvI/1MuRfmgyld
         o3W3vYEJ4VLTQjUhxiphL0X5X9B78TuEpZ1sNz2DPPKDQiyazriOc9IIgenQSP+lDKMn
         D/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165571; x=1775770371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=GH+dfbGswqKlw/lNtNqoNGVtyPS20MFZrwMM+HsTc4/ROz7ZR/EXYmN953I/W8/5nK
         w/4Luu1YSatjnkcp88Ev+ASKbfkyvJAUDA5dRBSPdLBtlXWtN5QayzlQsx/gr2QKIxy0
         0x67Ju+J+rUJAT+MRDrwOLcTnWMyT1atITnYXnoSo5piFzwZQ0Oxm0aSsrM1Om/WrHUj
         u6sray00l3q0I/dM0uaq5MpQ+SKSRnRM5inH9QtE1Pyc0foJjYjubqsg/1Adt2s8Vz9N
         mXIJUHs0S3pbyU+oawIrIsPZUnFfCf3srL7IWfGfp4BQP9iwbaX2o6xr2PJ+KPeuf8Tp
         5HOQ==
X-Gm-Message-State: AOJu0Yz/w2ki3If7ErzsgG/dNacjKz/UKoxKb+48iLN5PYkw52RsAzV8
	p1/3DNHFs66hO/Kw+WZI02WdvkrJIyhJmyR+b0kdBYcJ5bnFQo7w3YHpeO3U2g==
X-Gm-Gg: AeBDietyzBXbJnd2NdEUlg0WZtDyVHKG/lmSyD3oAdiFDffpnhvqgjtdb73hiP0Onju
	hFUNHzmZTiiwMCUnUhvEtWifuGL7q23RCGTqxEWBwyvqUm1XQtiM2W3rFZbeYjcaNMlbdVK9qYE
	BYpNr2fXIXlSt2Gssca3uUta/N7jIraW6BZpzGN51+QEtGUdpP5s+V7K4UA0NBTV9AqdBkEUXh5
	AUpdFnuLV5B5QTV+nPn/98PTEwoNOb+YgNppnj2OtdEMwBcksXhM+Zhvi3i3C9SKxxcC7nZF8+3
	4TCRyp/1wI8yvWpQYzWNBkDRyzLLmq1HwdMlcNyIXIBmDJb3X6v+9QB5Xg3cemndRGwTCbj/jyY
	rzcz97XwrZYSvurq2Ha1yJQ610+kkfcuc4o2EOCxEbWZYD+U8VbsE5arP+OMD30QE6QB+4Qqj1v
	UsZbzwwhUneOF7jjlWFzVaSNvxsBgDXXM=
X-Received: by 2002:a05:6870:4590:b0:41c:6512:8419 with SMTP id 586e51a60fabf-4230ff4be77mr289726fac.28.1775165570979;
        Thu, 02 Apr 2026 14:32:50 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:50 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/7] odb/transaction: use pluggable `begin_transaction()`
Date: Thu,  2 Apr 2026 16:32:15 -0500
Message-ID: <20260402213220.2651523-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each ODB source is expected to provide an ODB transaction implementation
that should be used when starting a transaction. With d6fc6fe6f8
(odb/source: make `begin_transaction()` function pluggable, 2026-03-05),
the `struct odb_source` now provides a pluggable callback for beginning
transactions. Use the callback provided by the ODB source accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index 9bf3f347dc..592ac84075 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-file.h"
+#include "odb/source.h"
 #include "odb/transaction.h"
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
@@ -7,7 +7,7 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 	if (odb->transaction)
 		return NULL;
 
-	odb->transaction = odb_transaction_files_begin(odb->sources);
+	odb_source_begin_transaction(odb->sources, &odb->transaction);
 
 	return odb->transaction;
 }
-- 
2.53.0.381.g628a66ccf6

