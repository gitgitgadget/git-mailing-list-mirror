Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D32D3EF2
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341757; cv=none; b=ak2XrkCjLiJWSiXeMOB+wArQqnaV6bkUbXhzjkXLfieNxgx/GHKb30ER3N7lN8YK64hzHxGlsEljSn8TxshT2Xc9CMMRuD5CIDpTCACQ+smcjnD2Vqn17dKDuDWsw4iIMcP6mBSx3CA+o2ywqrRIKr+BH05Bl1wrC8gFNU+Njxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341757; c=relaxed/simple;
	bh=xkQKbZ67Q9yg1+nPreF51oFZGpE4qyjtVVUErBWTt1I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u7G4XSs9+HD+hRtgxHmYTE22/S5YjKghD5O3yTgV+O0eaU1RfilxxLKd5SAIvILIQRt+6C7HRe2bEwG9K7VkCsiTShbBg4+LTxK87woDA3C4Q3t8rPg+A5vcCCxNQ0NlL7/AhQESbpSFxgcSTJiiU/gQNldBtgEmVv3dt2hVCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvPwFAHx; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPwFAHx"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8b0055cbd0fso7592139f.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759341754; x=1759946554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyToMiOgzz3UrQ6/En0knXmOmSDd7CBKm+PLeRgVLuo=;
        b=JvPwFAHx95CbRY9s5xBIbbtmdFsde0RhNj2BliCofDr6vokDDGxh97InF8dqefhwfG
         nYCTeIKh41mjHlWZl1lgqj9C0ev4oAAkgBYAfJUpP/CFoMrG0T2lmKOzmOuSSmWbdfG3
         +V7uGNXWqtvQliEMpXCP0drvYPzIBgzyXGXskliBsnsZpDgf4VsAsOeePQFKrlveH7Ge
         ZhYVLgitvmr0PbymBsIkv4/G+C5PiqkcA8E2mVIKKpZDMn1P4KfytkKowO716sY7J9Mk
         Xd4v7pFOnh5sNPxEEpRGQWN0VLNoFu9IxP8t/FW72pYmeL8rcbtgWBbrGs2kX9vXw9Z0
         GHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759341754; x=1759946554;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyToMiOgzz3UrQ6/En0knXmOmSDd7CBKm+PLeRgVLuo=;
        b=KK0jbuT5bofv1F0NX9S/psWxMF6PIuPwtziFAXt5Wp63QH6bQwxi90zzvDvTFfnnxK
         U2gdKtvVb9EqNNMweB7CLF3VT6B7st3bGWMrXW1PGWFDurKDEnNffdhJKTASvYdrpAkl
         VqfdRqqEQycFYJycRILdl5DLMUuqd8i0PjXztHZNBew+rTsWkYbRebyat2oUYF4Nn4Su
         48p4ddI88bF3VtjWXqop9xlDlyGrnNO2nKzxtfNDRE0gRry7761i/V4nKnStu0vkVfK6
         d44nMBBvluCNozi0au3T3htb5YBCpCKhkrE7h9OYD33G6+fih3wiWtdi2T+jpxKIgkOY
         euig==
X-Gm-Message-State: AOJu0YzV9RTO39j6zudQEFyEhaZPN94XjChSKuyViNnbVnLodnuDFFou
	cUHBvJE61qsErJrOfonO2iwmn5A9hbLajoz9yqI6jPZMdl1B8rTcnmxYRSJKLg==
X-Gm-Gg: ASbGncuwQl4PjbvNfpAGVUBziY571zf/BEtZo0sG39zNaLvPIADzSglRDv8yH3HTnXc
	KM7astflCoK9Jbfh8X9mgM9JF6bR6KoOvPlaAbUbon/K20iXPnXgfHiFC2IsCwD3mEZku2f2HjH
	3BtpBk1qmrqgBdjtGiMR0jjcWImJbD+ZAizltAzdbgLjadEV7luIwr2W8t6HJvumR82hOO++SJB
	g5MX7SySE9mk+pIV+/v4kVF/2hSQQvEzocTYHFAVh6+CHCUIKhqxtYvqMdc17HUGdEAFgqlipYV
	kKgGzDyjNdxGiP+Iebh4pww7xT4mWoY4V0YbeXvWx2IlpH7/0X40v33j8oyF02BkPuMhdX02+Ek
	idqMhmWafOH9pa8sIgnXgl/isoSBh+30ESI64BBaxwoK9qu1E6Q==
X-Google-Smtp-Source: AGHT+IEsRw8BcO4SVEBYBh8+9MEe9tjvEAAF2tFwm113FdQlL8aFkPeDDlU3gSksiOdu4EUqxboOuw==
X-Received: by 2002:a05:6602:1352:b0:884:1e28:904e with SMTP id ca18e2360f4ac-937acc0b764mr652058339f.12.1759341754462;
        Wed, 01 Oct 2025 11:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.149])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb7003sm6353539f.13.2025.10.01.11.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:02:33 -0700 (PDT)
Message-Id: <8549f634153b1ab394a2e6630d8cc1209261a31a.1759341748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 18:02:28 +0000
Subject: [PATCH 3/3] make: delete REFTABLE_LIB, add reftable to LIB_OBJS
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

Same idea as the previous commit except that I don't know when or if
reftable will be turned into a Rust crate.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index d89ba03286..4c63045443 100644
--- a/Makefile
+++ b/Makefile
@@ -918,7 +918,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -1411,9 +1410,9 @@ REFTABLE_OBJS += reftable/system.o
 REFTABLE_OBJS += reftable/table.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
+LIB_OBJS += $(REFTABLE_OBJS)
 
-# reftable lib may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2766,7 +2765,7 @@ OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(FUZZ_OBJS)
-OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
 OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
@@ -2918,9 +2917,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(REFTABLE_LIB): $(REFTABLE_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -3759,7 +3755,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3952,7 +3948,6 @@ endif
 
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
-LIBGIT_PUB_OBJS += reftable/libreftable.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget
