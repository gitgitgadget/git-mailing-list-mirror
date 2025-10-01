Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151F258EF0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341755; cv=none; b=VnEC+b8LnMs6CEhenRfvzajkeuJ8odJjk2wWMN2AMGhZME6zGhfYFQNbXEuE0zAebZ1W6Qz+MqI4eBpTGkvd3tSkXzoTr4N7KYfjiRDqTQbaUXbi2aND3xGmeFp8OoxZulJAeBSNpJXuscXJImB9nsUCQyhzY2QhSd99feBT4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341755; c=relaxed/simple;
	bh=eyc28A08ceStIaICXMXMQOY60uPq7WHQSOhpSMq8/LI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BN9bXSqCu6m/6yAX+fskhJ++8ww8q6qOT5YziROHoWw3TSSI4iSXXRX9FUTfoMABYk6Vn7h8pEAPTn1o74fO98b3pakkmbLFD6KGOTOMFTzxjjMw2aF9Lww5KQDBlT6vRZZDn77w0F5OVMJYglgWoi+5PnKpduZv4toav+wNcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRVEyB0R; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRVEyB0R"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42d86db0eeeso768235ab.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759341752; x=1759946552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcfj/rCrRA1w3TtJALBQcGJWMKEJQWY31r+GRQJ5nWo=;
        b=gRVEyB0RUU1xsPU6w/khEbO8abzPP4cQbNf94+QdxQCiZlkTdzdxSlZkK5gMhFnRMX
         OyD6cYr8GaVT69FLl5nJQzS0M6FS/2+yar5pLRYZ/QbabSEKv6T0523fRFsxGNRGfu8p
         le8p4CfgR14YYmrWVqQc45X3mk+Hcwo0rhiI7viZMUX8VeUig9vKQs6rLmYhICkfeevb
         5jTx3pAmZIeRTOtX8eJaW7/j5GvIH5aMbYlGgHHp1CJaYjwAfDUkvDGBxSWlett6CrNS
         94if0XSgnn4siz+G4hk1abbaYNhczjWPavrcALzAHiOsg/9oQr+KnVZHOeJKdbB1PiLF
         4kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759341752; x=1759946552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcfj/rCrRA1w3TtJALBQcGJWMKEJQWY31r+GRQJ5nWo=;
        b=diiFJ7RJrw2MghhGWjEwuzcj3ON9UuXnoztnZgyaqJviKAsznZo2QgGGUptWKBdVsc
         bF3ETnn9GoeAwsJ+afDwlivUStPCVP+54F6VAU/C5uRifNpLoxgNDlXWYBYTyxgsL6Bg
         NafeNgzugrDF4u0sSLHMW8eAAb/ughPHG3Q1nLvyqBSVNBCu1ID4IHzo2syChCO3BrZK
         TF1LY7lFtpUqoV0+hSIJXxZZFbGIy5F0i8TzOzYN/chCBMOxEHUhPXv9AjImLdMs8BDb
         4EzInWWQ8pVxCbzmnEFF1f+H/2o1MtAnBC5mvFxUBB3TcgPTLlWrf4CO+QElYqfhU+qO
         EDvA==
X-Gm-Message-State: AOJu0Yz+cvP92Ls1ClU7V7UeowbXbxllc9Rd05xzcq72ydJ4TPrTvd+j
	A9kfPf/QmFZQKTzrP/cH968LwrMH4wYCQfnw2ytWmMDZgtS3WuJyVSP6lZ0O4Q==
X-Gm-Gg: ASbGncuSnpLTccubwErMIplsnf6RGLTt8vjKoEfUTdlOzrRUZIUcU4AGuOyZI+4EB7/
	hzi9M3qluTt6pGl8SWHj0Swgr7XmH7iRBk8DfNPrqvlqtIrNo0EBxQuKO0aM96Kp07YWIo0tAa6
	4RtolyZoM3zdkCR+RdMNaZhAQziD6XDrVpLoLWXsSW5+LxRP7S1KfhiTzq2RGJ8dfRQ0S0uCtgk
	y/qL5Kxk6MlJcSxFYVKrOuo0ob5v098lCSeOmXpZE8sfyxxzoh7GKCjTjmYqJ3bI5Lg0zpaqPAd
	Dog512tEi2OhoX2WYLvcPl7iQw9GshfMLl7UIFkLD288OAFQrQUHgVdAW9wOp3pHt8buPhycaO0
	3Qcx8L9f85RJUL6Tnljh9BAdrDKyftihwVCGYX3+eJz1NHcr+JDWWudgSf3ht
X-Google-Smtp-Source: AGHT+IE3LcNhNube73BxJZReRIcHweHRpyQZmwKQhcEZD1PtzFz21Am1ohE685E6ajnGLXfAlb0Fyw==
X-Received: by 2002:a05:6e02:2309:b0:427:1841:666d with SMTP id e9e14a558f8ab-42d8168d2b6mr59987345ab.30.1759341751547;
        Wed, 01 Oct 2025 11:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.149])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b2a48d6sm1109225ab.39.2025.10.01.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:02:30 -0700 (PDT)
Message-Id: <fdcf5a0de86a2200da01f2bce9250398ff10f8d9.1759341748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 18:02:26 +0000
Subject: [PATCH 1/3] make: move xdiff and reftable objects before GITLIBS
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

XDIFF_OBJS and REFTABLE_OBJS will be added to LIB_OBJS in later commits.
Move them here so that GIT_OBJS += $(LIB_OBJS) works correctly. View
with --color-moved.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 92fd8d86d8..e8fad803be 100644
--- a/Makefile
+++ b/Makefile
@@ -1390,6 +1390,30 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
+XDIFF_OBJS += xdiff/xdiffi.o
+XDIFF_OBJS += xdiff/xemit.o
+XDIFF_OBJS += xdiff/xhistogram.o
+XDIFF_OBJS += xdiff/xmerge.o
+XDIFF_OBJS += xdiff/xpatience.o
+XDIFF_OBJS += xdiff/xprepare.o
+XDIFF_OBJS += xdiff/xutils.o
+.PHONY: xdiff-objs
+xdiff-objs: $(XDIFF_OBJS)
+
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/block.o
+REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/stack.o
+REFTABLE_OBJS += reftable/system.o
+REFTABLE_OBJS += reftable/table.o
+REFTABLE_OBJS += reftable/tree.o
+REFTABLE_OBJS += reftable/writer.o
+
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
@@ -2723,30 +2747,6 @@ reconfigure config.mak.autogen: config.status
 .PHONY: reconfigure # This is a convenience target.
 endif
 
-XDIFF_OBJS += xdiff/xdiffi.o
-XDIFF_OBJS += xdiff/xemit.o
-XDIFF_OBJS += xdiff/xhistogram.o
-XDIFF_OBJS += xdiff/xmerge.o
-XDIFF_OBJS += xdiff/xpatience.o
-XDIFF_OBJS += xdiff/xprepare.o
-XDIFF_OBJS += xdiff/xutils.o
-.PHONY: xdiff-objs
-xdiff-objs: $(XDIFF_OBJS)
-
-REFTABLE_OBJS += reftable/basics.o
-REFTABLE_OBJS += reftable/error.o
-REFTABLE_OBJS += reftable/block.o
-REFTABLE_OBJS += reftable/blocksource.o
-REFTABLE_OBJS += reftable/iter.o
-REFTABLE_OBJS += reftable/merged.o
-REFTABLE_OBJS += reftable/pq.o
-REFTABLE_OBJS += reftable/record.o
-REFTABLE_OBJS += reftable/stack.o
-REFTABLE_OBJS += reftable/system.o
-REFTABLE_OBJS += reftable/table.o
-REFTABLE_OBJS += reftable/tree.o
-REFTABLE_OBJS += reftable/writer.o
-
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 .PHONY: test-objs
-- 
gitgitgadget

