Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9723B623
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447656; cv=none; b=Wa2IdRdy4nD2+J7IKN9COGt9gZAedenO97oNe33Gtiolq6jeg87EngkPkA4pA5qExp2sZvCX+0Z7YvgwAV3k0VmhAprDBPLXCVKys377DlQvd3SWxOsyitEFhruoiysujYhG3vphYHGRt7csTgNDtaQ2n3TjEJpCzii3R8Q6YCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447656; c=relaxed/simple;
	bh=KOVtxobq4RAQ3zWX25YI0hEFevMCayvyjG04OoXhHX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cSjrSyU+4if0EmCFkuBkbPXfLaDxgKP6xO1QcyadJRpWSsPEPECm0WUiLEgMGvYfnK8MZ8O/L2oXBXlDxZnXL3iMbV5uzQG7x3gz2wMnZ7aoTdGtwduiS3KSQL8KUpWTw9OtnoH7MSKP01wG/bLDUh6xXW0fNbzKViWXizm+0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/xM31Jf; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/xM31Jf"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42e7ad9474fso1723345ab.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447654; x=1760052454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7SgyU7pmDsCVWN0eXXjXW2ue+V+Hw/GPVaNZlOK2gg=;
        b=C/xM31JfihxYjdnOrAMcNP7IHawQeJYt9JC9Y/X/mSe3oDMLtYoO+18T1nXNNnnCR1
         AimsTMgtlYB/ban1yFQD6cn0rWyQM+vn6XC3O7Md/jL1SIkaWyVCyDoJupRxz7cATwOK
         1NE0XJnia9b/A3v9+uGYn2vPG0xmn7Hx/17IF/G4Dn4Q1y66bkNjPVrzt7LvxsM10zPv
         Szo15p9LwU909Y67N810V7nzgwO+gVy63QvVoVq0eH7WIxp9dqas1Ibe979nNosNy9ZW
         pvJ5tSWKiJpS8+ebtPqc33XIKKGsXPzvMVLXwcK1P7H0IZ7eRbtbPGQlaJKIOI+ToLTw
         yihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447654; x=1760052454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7SgyU7pmDsCVWN0eXXjXW2ue+V+Hw/GPVaNZlOK2gg=;
        b=ItGNf2uZIBWyVErw8j3Joxa4xDv7ravHSLSYpCMO+yNc2aYbNSMWrILx/AfgvV4uOm
         nLyi5nbnk3R5quzEJRxcz95EnWyAmLSFSqE66MTpnR/MZpj9BaXkNJedBT5lUjkEx+hI
         ZjcD+jstbsi7KnlJYm/Om8cedgGbQMYhqVPcg9GMtrblGsv7zLfWWC0trr3KxlTQE8Or
         lEx1/x5qCavXyu5aW6rvGQxcsMySeIDO05rtkgigE0EE/hdUEg9arukT2wrS4BOEA0jy
         6qVHMrFn9zQjcFOXqcKZMrh1n/Yb42+1NBphzQUp3gcTKKRHNFPK3X/yjKc2Mknhl/sA
         2uhw==
X-Gm-Message-State: AOJu0Ywz50HNpjaOEShO9yphNwkSdTmo01sXTm4LHghtsFJ8R24eI0Rz
	PFRqrOTjRC2vGJn7A/UuLIhOm22fZny1dWHRhJZF+VOYK4C670f0N1nrkrZOOQ==
X-Gm-Gg: ASbGncs+AT108RNHkIdnuMW8SyylWbis6UtpUYtebzD189aUlt+KsvJwl3oMr45M0NM
	+apr5X0OHBir7x3funWzHeqwjBES+LiwEYGPTIUFLM3F92L4yn5U31n97U1r7XfNm04bnKSdYse
	KZsvBhmSi0uRyCtQp04zxx/qhiE0FaOnmgFlOcj2HGhrmZ6oM2gnp832ma4B/CtiaLvtX6FqJ9L
	yhynU2wSRYW/U5KPUF6fOiziVMEmR688wNxE0+/PbdTW8sq9gzfoeV93an6jN66yMeG2/diea/x
	8IMWhV8Ji125DtwIRQ12dwG96oBUDJkbzyWlwiepiB1Xjpy2qHXsvJtkDzWj+CQ+EU3GkqcITN2
	UocSOdUAhkMa6qgDSnXnVwAI/laT+Tmk+Pgm4ThWnmTDR03gIYu8=
X-Google-Smtp-Source: AGHT+IFy9YLrGMNbRRrdTzhXA5wHr/QWH3SRn2yVqnyJCeeAdPluamENDUhVLNa0zD+tiDluKA/R8Q==
X-Received: by 2002:a92:c26b:0:b0:42d:8b1c:5739 with SMTP id e9e14a558f8ab-42e7ac40096mr11386975ab.0.1759447653617;
        Thu, 02 Oct 2025 16:27:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.171.144])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8400sm1292105173.42.2025.10.02.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:27:33 -0700 (PDT)
Message-Id: <9031610dc82f8598375534e2c04580af3bad8cca.1759447647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Oct 2025 23:27:27 +0000
Subject: [PATCH v2 2/2] make: delete REFTABLE_LIB, add reftable to LIB_OBJS
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Same idea as the previous commit except that I don't know when or if
reftable will be turned into a Rust crate.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index d37edd3d03..6464ded3a3 100644
--- a/Makefile
+++ b/Makefile
@@ -918,7 +918,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1136,6 +1135,19 @@ LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
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
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
@@ -1396,8 +1408,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# reftable lib may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2729,20 +2740,6 @@ reconfigure config.mak.autogen: config.status
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
@@ -2764,7 +2761,7 @@ OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(FUZZ_OBJS)
-OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
 OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
@@ -2916,9 +2913,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(REFTABLE_LIB): $(REFTABLE_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -3757,7 +3751,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3950,7 +3944,6 @@ endif
 
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
-LIBGIT_PUB_OBJS += reftable/libreftable.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget
