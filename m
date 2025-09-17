Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E741218827
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071807; cv=none; b=JtRCVoxJCCP+x66Gncl6DaOVJDEytsQFHI6gi8yiywdK/RefKhe1bhHVV7NSZjBRJ8IC+/PRneDE3OQnPcQbdTYuizMDk+TdOKlvmOzN6+5lPKadqroXaYsWFbdsA0vRV1ziTwOuqrLMzUHEc1NT/yga4Li59RqiM3tpUnTWzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071807; c=relaxed/simple;
	bh=KSpB1brVz09iY/oIcOT27KY7q/SX3bWAoowkcxxHJOQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pNdvijiK8WgTh6GmGjpyHAVGJJfQZTDAcF5PYdhunbnR2RIpUlD3Q0+t32YZWnIw6Zhz9hgwFBweMt3unzibuYzmT5p0DfaaYkMxVQiqLeYTOZ3Xg40OwljWTR9/ung4ENsCAyAGsqYdEUJxYiYEBAOafPTqv4jq0mOjxiR3EuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVNkIlF/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVNkIlF/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5229007f31so4153707a12.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071805; x=1758676605; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkQqqFfutHhVUhM/eEAr3+JMSI9CgHhnY6pvCsgr8gs=;
        b=kVNkIlF/H9tQm3dfSroLUDvpyOm5I8cExlFvNHoapS1Lic6iVluHukUHIPf1ssfd1l
         JNB0HFNT56kvryZlipFH/n3v6G6vEMNyJXmcxD/bRwQuwLesIKO1bscudpwwp3YcjYXF
         7X6DYab9QlvBAusm1Yotcp/5u+gJ4qE78XVF+34vpm5h/KhO9kRUoSyjK0ds4yg6H22n
         wfmVA2wEPKFl3RwWVd5UuP8jpHdTmn6AMjGFL1KDU0SfdPLCCzY2OZMVtbJisiER+jDR
         FzuK12CrDUWtlVP8xVRFwY+XWMX82fLYFw4k/hfnaJqk4c5YsEOBbBgBiUaSl82cv9EK
         vulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071805; x=1758676605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkQqqFfutHhVUhM/eEAr3+JMSI9CgHhnY6pvCsgr8gs=;
        b=qClIj24cnXkfzail6I4XuE80v0dwEB3kT6KKByipd6r1sH8lbJyD7Szfmhmt0GytzY
         T/ZTT+R4m5erpCB5kvrGNbtJrCO74BQxtkzjYx+pfrAg1KGsqQDmjZrYf/O+ZyHsCGlx
         Wb5UFJqss45N+bb9B0Lwizp8f1S7TAi969Z9wVWlHxtQTPP8L7ym5DP+ESBQSrPPZaDt
         v3NFScYf8oblaQlVD3nGcHm+gYBXDolJ6M6VusqOj3XUkeZRkZwrvLVVm5sHHoWlDCVN
         XFslKtbBwRZ+TD5cIDM8findN5gx2PxyI2oFDDGtEkLr+swZLZrQrVt2ozZWqFT599QO
         mfXA==
X-Gm-Message-State: AOJu0Yx67TJDdjrNlYcpFY4u/gulr5u7VygmdZ45syYNprxdS4agPJ5N
	P54xFERG1Ki/q3D7rOr7xwir7zGWUqn/iOf6FATNox7/i/nkcYhTjWoTHko5qA==
X-Gm-Gg: ASbGncuEybXR1TYAOmfDGil376Yt/EL0/D9wg6uMKnSh8jJQxMmY56rP1hwTyiouWFi
	5Ipy9qqUewvhwi9AIEGTs8hES6cQP4ogQFh9Uzhw9VGiPrODmui6ODZyzaSEiCj0wP6G/hb0gXR
	EkRXNanWjPYOIc4bOOo5e5OGW5ebekIxMR73/RzQ/RuMMpH7dev83ZyWiwH7pXXQe7vKbrcU8GT
	HWXKfL/aIeRYZb8gVhFMBaOCeBf5AnozdIk+T7LiEX1DMlQz4zLwl6TD07gweCzuqkCKHH225bd
	rEnNCC+26NvxPymmhHSBr5SVuV2wvq5GWdA1JOg5qLlNEvpq+FvG5ja8P1KunujctDGU+Tqwj6E
	XxGMq34Fdg/NqP6GWHd6fWTLliQc=
X-Google-Smtp-Source: AGHT+IENJjazJiAKimmzVnnlFykE614ZfVGs2enZYhbGzpnlNaw/wocwvlvTA+NybrToo20sv7Cw4g==
X-Received: by 2002:a17:902:d2ca:b0:266:2e6b:f592 with SMTP id d9443c01a7336-2681217ae3emr4181295ad.25.1758071804741;
        Tue, 16 Sep 2025 18:16:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26418a14e08sm91974945ad.146.2025.09.16.18.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:44 -0700 (PDT)
Message-Id: <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:24 +0000
Subject: [PATCH v2 04/18] make: merge reftable lib into libgit.a
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 94f38eb4c9..ffb898b611 100644
--- a/Makefile
+++ b/Makefile
@@ -915,7 +915,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1125,6 +1124,19 @@ LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += reflog.o
+LIB_OBJS += reftable/basics.o
+LIB_OBJS += reftable/error.o
+LIB_OBJS += reftable/block.o
+LIB_OBJS += reftable/blocksource.o
+LIB_OBJS += reftable/iter.o
+LIB_OBJS += reftable/merged.o
+LIB_OBJS += reftable/pq.o
+LIB_OBJS += reftable/record.o
+LIB_OBJS += reftable/stack.o
+LIB_OBJS += reftable/system.o
+LIB_OBJS += reftable/table.o
+LIB_OBJS += reftable/tree.o
+LIB_OBJS += reftable/writer.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
@@ -1390,8 +1402,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# reftable lib may depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2723,20 +2734,6 @@ reconfigure config.mak.autogen: config.status
 .PHONY: reconfigure # This is a convenience target.
 endif
 
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
@@ -2758,7 +2755,7 @@ OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(FUZZ_OBJS)
-OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
 OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
@@ -2910,9 +2907,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(REFTABLE_LIB): $(REFTABLE_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -3751,7 +3745,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3945,7 +3939,6 @@ endif
 
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
-LIBGIT_PUB_OBJS += reftable/libreftable.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget

