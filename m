Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF229A31C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447655; cv=none; b=DelOW08UCIYcsMFsW6Ndb2b3uxWzX8XGY5xjfaXXqTvNT1IKQQ/HjUQis0fNZxLtoGrLh9GQjDrVuZqqDOkn6V/vpz55zPldrVb1VtMOsi4gVXcV5GTtQm0EbPSmERmiHx/4ZRMNy5i27sQdM9BFkY+VGi0zllYMCXX+J3xYOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447655; c=relaxed/simple;
	bh=5/OK5f9tdr3BmfWqsfb+5I2Ydz5bU0ATq2wQ2V+GnKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eIltl3JBjudrmoxNkLM8lRwMfbkmUcHzh282ARMiCpbgm/J+xVLGwchsF9BO/DMlXFL8ByT0lNqOuqT85wERS2JzODpTlV1kV3uVaf824CGhuiQxIg+4J0WuVn2CJlA2WDlnK2vDuG6sMFGrmR3kOp/G6QNjPxpGlXcUL1w5ugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frjR9F3I; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frjR9F3I"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-424da17e309so17617125ab.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447652; x=1760052452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkilX22HHZafZeXoXNmMDDLKbuJZd9+0rbom4vh7sA8=;
        b=frjR9F3ItzHcMqf+zysx0Y9h5C4qyvrOqsVu+R6O78CclkNk/RKJfMvECbm/oRneYt
         1ajCFOuhDBqTRznWopfxwfMaOUZBmhh8xXG9cbuN4HN+VpPk7kgql+frCKCR/Gq5O+k6
         CA8KQdw692IV/bkMToeYdiBLSgs4IqFl9V8EQYT2s0YddVXcxp/TRawEKCwiyu9Be+dy
         Ip+HFTRh3CndeU1ItBuwDvV2WDIfb/XHOcrv4ePLut4rts8ORGc/QhfwDrBeUpLIlrln
         plgSAzVB5Jy3nlX3XA1t5JNiRUyf0r1deWyJ0vWtTRy8QwB3XT08OilYwcD9nAXx7WIr
         sbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447652; x=1760052452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkilX22HHZafZeXoXNmMDDLKbuJZd9+0rbom4vh7sA8=;
        b=rxwmdeogeQ7o+lJT4GCIbRnahUXej3BvqgfWAf5NT/gT9GoX5MmpngOtcqIVsiwlxO
         F0nIPaaBQCRvDOl6jt3pLOPKiGXLoJWfp8IR+7n/ELNZ4FQAdxpjoeTlFwYkainqfw5J
         sMqp+yozNJbymCXuPT6DHPk+ObWFLTD/361EGLX7gyz2Z49Z7HtEneuGLaOEeKdtUfs7
         2HOMgRFYy6DnSC1YhTTyzo20KfGp/kuyGot3osBxUfROvNQDqc2PIRu6Sj4KzkLVTBT3
         EiD6kmQGiJ4epA8Z9gNjkt7HQmLtNFDPxvKG+CcpWbngdRYBn1xqRmoyhBrViFJ1SEG4
         hIQw==
X-Gm-Message-State: AOJu0YyYnYjBi7o7nCIMa+V179ri5pJ2oHdWCo3Xu1kVslENkFRWSeJQ
	0S+ZJ/D98gFnbZyVlPRsEq+/YDJMbcVj8Ml7xj/7bV8xi/N52jGVGT8nMQ16SA==
X-Gm-Gg: ASbGncsSU/sFAN4UDQWSPO02so3W/KJ0t/VgiGJs/BgRtmhAwuYmOZn8OJTzld3x3T7
	LODWt4zBhTwcw2G74Yrn07oB8zUokqkzfOvcRprJdL9795MgSEP99kFSaClhyWpDCDKMcAtlRKI
	DO+m3IwujJedvDGnac5aXz8/AUlZoD5a7UEaaPSy+faxRffakpGYp4iTCvX4MVU7/dEgWeD9+R1
	uuxOHZg3mN8e6buWEEwvQCVwiWSoaubH5/EBbSu7PZCx7yIQTOqYDWCkq6AiB+eEu/EE2o2W3tw
	J9fQ+GkoIGY03ZsDqEtpsVk3BsWD8OPOn5Y9bVRcEDne7YsCrulvYzpD+Ur9r56wdkvfkQVv2Mr
	l2X4HYQGBwRh75g3++tH2dpSlMNWzwSMQyPD2srjVE+cis77uiFA=
X-Google-Smtp-Source: AGHT+IGt0UKyCU65EYIUI7esLNh94TnQ8jCs61/7mWTFQwrsiGuiwnSFGDy807gA09+9uP67QgGHCA==
X-Received: by 2002:a05:6e02:1aa7:b0:427:d82b:1f36 with SMTP id e9e14a558f8ab-42e7adb3bb3mr14655615ab.32.1759447652569;
        Thu, 02 Oct 2025 16:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.171.144])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b295062sm14028905ab.36.2025.10.02.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:27:31 -0700 (PDT)
Message-Id: <b535a456ae7e02c518de2637381ee6c6efc7da48.1759447647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Oct 2025 23:27:26 +0000
Subject: [PATCH v2 1/2] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
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

In a future patch series the 'xdiff' Rust crate will be added. Delete
the creation of the static library file for xdiff to avoid a name
conflict. This also moves toward the goal of Rust only needing to link
against libgit.a.

Changes to Meson are not required as the xdiff library is already
included in Meson's libgit.a.

xdiff-objs was a historical make target to allow building just the
objects in xdiff. Since it was defined in terms of XDIFF_OBJS (which
no longer exists) this convenience make target no longer makes sense.
Remove it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 92fd8d86d8..d37edd3d03 100644
--- a/Makefile
+++ b/Makefile
@@ -918,7 +918,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1209,6 +1208,13 @@ LIB_OBJS += write-or-die.o
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
@@ -1390,8 +1396,8 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+# reftable lib may in turn depend on what is in libgit.a
+GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2723,16 +2729,6 @@ reconfigure config.mak.autogen: config.status
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
@@ -2767,7 +2763,6 @@ OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
-OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
@@ -2921,9 +2916,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3765,7 +3757,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3959,7 +3951,6 @@ endif
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
 LIBGIT_PUB_OBJS += reftable/libreftable.a
-LIBGIT_PUB_OBJS += xdiff/lib.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget

