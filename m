Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F261CDFD5
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071806; cv=none; b=FbvHz4kfZ5tZ0LtRDz2LVJHQKJdLQEIS38o+XAS0MozUJzjp0Vj/tcyG9hwqBBaiMjImMGXUKlVyJGsvXi5VuQEw8D5bYLyCROrhqZ96s58xfUEplMSKrgsE3zoqPQJXw7RXLcIDWqAqegKZTcchf+sQuZZL4KihFO3sJOb06nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071806; c=relaxed/simple;
	bh=/pL981Ia+gPoCZfwcCN9JciuT21aNJPABcv0XxgS55Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U9+0Sto9/810SVWLxkAr3qC53hgx7xRk0kxztPzonDV1td6ZsTRLpwl1J8LD/wEePuvKWEhWVOJ6xdG1F+/9vXDhb8gI3Dgcd/JLCG+Y3kRt/WwStSQ98Zcg/gpLI1ymBfzRUFUOmLGouwQBbkN3z1OGlqKOrSlE0SFQkagyzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUMHvvFw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUMHvvFw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5421142a12.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071804; x=1758676604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOc0kRsx9K3N4d0EoZcEkO+y4X86meszS9gIKKhxzNw=;
        b=iUMHvvFwOe+NU9zR6pM4iArlgbVkWePrmROt8yh5LbkI3WaP9GL/aGpuzHO2zS/9RX
         ajfYwhiCwvXXCZ9scHC/ZvH/w0bbRzwHzRzYZGiYER3J5aI93dAaBR2q0IVMLl+A/DGa
         EwoC1y2KfOjMtDWvb5UCHzIc+YrNVZ7UcdRSO/KtlApQQ24Xg3Bv+b4PV4qpn0AJnv5V
         n5gVhFSRA4blJDVUZ2GVHxiVBfm2lIAg3JDn94CNTfSL5kunqTaPSo6RRnVfOEXsvKla
         zV7EShYYEl8DdH8hYdqdhq2wZx8JNIl44HqFlYaJiod+TLF4xHwhDmnMIKR881o0WXd/
         M1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071804; x=1758676604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOc0kRsx9K3N4d0EoZcEkO+y4X86meszS9gIKKhxzNw=;
        b=jcIgoAhheGEarRqKoTHRJhMb4/2hGsCqpwyao1RKtq3+URNdT6IsklsYuHw4yC7e9n
         NyKngk1HkfOgKTC2awGKPmdmTQNnKg69P60/H3GOZetHVIQ0lRMTe+GfFWH/LlPBlDP1
         vON832roRVad5B3u4Ow4aLtvT2RTiOP9yQIUmlLAKuWiuQnSCjoEEMagvo9wheIhB7Xb
         gmwzk2ufHh1/sTiTxTXQytw06pHeCEgtmWzN6Qzh789ZQwCQFJHe8AGByi2Iq5J7Dpqp
         bLVhltYVCPIrq+C1vsaqGPTElJt8M0lCiaOo9ULzODEx+M8R+jy5LN7/TJuqe9M1roX3
         f0Zw==
X-Gm-Message-State: AOJu0Ywp6xfsPUwSZRME171NdrJxRCe2jT/Q05+2iSpvuq/aO1quS6mU
	US3U7czri53OPL89QfNeujYlb/VGYnPQYDq4Bg3GPOhdIHEODsvv8PoFos+caQ==
X-Gm-Gg: ASbGnctGiK+3VevzPkZ/RORT+dUSIqyVCmMr3Cg+uFbgPwUBDq27Tf73rby9Nfgr3ka
	qm45a+RkYLwDsai6IvYmW3Ug0rZAIOYYit2h99xrCajlmlsOSDScaX+71a0AU0rmbfzGrflrQu4
	PTm9QA8lsiiTWxvxmzidgtzMfZSMnMPSXWR/jyWgDnmemWkh+Te4nI+nKyT8Pv3bFGpTZHEmwDx
	VsQadIX7lzOfj4lTIRpyUQBR3RmbxR00/MO35sLSyc7T7HpwldXkf9E1QqSnMCsqW38vlpOWFPi
	88uaUw0MWRfFKRs7ysliqbHofawvL5+XEi0/QjePJw5wpRFwwOSZWPLPl+//dpKw5cO2n2m4vcI
	NSJpHteoEd3vyM99sYUTnmr8DQT3VJKvsX2yG/Q==
X-Google-Smtp-Source: AGHT+IGAAoBK27fPXEspNrQJbLV0r5bWUNM2hrbh2jDP+yamVqvtKdvzttwnUg6DqtRKk58Lljyl0Q==
X-Received: by 2002:a17:903:2984:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-268118b3f7bmr4593225ad.10.1758071803585;
        Tue, 16 Sep 2025 18:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm137569605ad.127.2025.09.16.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:43 -0700 (PDT)
Message-Id: <7fe85f0eaca88fd3084bccff6754c57a919e7d4f.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:23 +0000
Subject: [PATCH v2 03/18] make: merge xdiff lib into libgit.a
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
 Makefile | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index d3e034f3be..94f38eb4c9 100644
--- a/Makefile
+++ b/Makefile
@@ -670,7 +670,6 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
-XDIFF_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
@@ -916,7 +915,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1207,6 +1205,13 @@ LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += xdiff/xdiffi.o
+LIB_OBJS += xdiff/xemit.o
+LIB_OBJS += xdiff/xhistogram.o
+LIB_OBJS += xdiff/xmerge.o
+LIB_OBJS += xdiff/xpatience.o
+LIB_OBJS += xdiff/xprepare.o
+LIB_OBJS += xdiff/xutils.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
@@ -1385,8 +1390,8 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+# reftable lib may depend on what is in libgit.a
+GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2718,16 +2723,6 @@ reconfigure config.mak.autogen: config.status
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
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
@@ -2762,7 +2757,6 @@ OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
-OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
@@ -2916,9 +2910,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3760,7 +3751,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3955,7 +3946,6 @@ endif
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
 LIBGIT_PUB_OBJS += reftable/libreftable.a
-LIBGIT_PUB_OBJS += xdiff/lib.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget

