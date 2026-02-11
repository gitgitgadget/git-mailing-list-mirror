Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C42D839E
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775176; cv=none; b=coIQRYKwmOQwROQtVvq/YkYHTNoYLo+qjfYtKptNW+07WJD8kvrJI+rrwHaJ7eN/Znx44fR83P2GEnOmXo6Khsrvg7rJalHdRghDlNaqMtjI72sKQysE4rPSWnKA2Sm49AUxveYXQeY9W7POKQqB22CQid09hv9UKSq1T9c4t1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775176; c=relaxed/simple;
	bh=hbSf98kGMwTxZncv956voCAPeZX2qepucw/WM/u2BYI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dwjsfK5tFvnONFQhxUtpCZoIgosEteOa5H8UTz+/YqhX+PPl/hb0Zl2KhQYzGU3e19KFM14PRgqa4x2e4hk3YZLhTXwnP+EOCd4YYdDAO4fQPqR7ubtvfBK3LcKn8Ggd0CBfieq5K8esOFC6v2oeydCoUlwzQ8MSAiTHYlP39E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnwIlo0S; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnwIlo0S"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb20bcff5aso120247885a.3
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 17:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770775172; x=1771379972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbmzBBFznJGdIZqOzBzpOrSEOyih0VfdaAptjQ/HUOQ=;
        b=mnwIlo0SBvMw1PW/qxJLOirSxm+aYJZWIjPDrULEPZqNOz+BzGEgBu02tAcKYiKZ+J
         GAVSQmcppWYJtbtqfQW2QZ1CtMIfwyeB0qgqjMDJ5Ic8WSjqll35kyyUt+FLIyjSaIHa
         rV+Wg+WyXUfUwAjI5wcl/U3fQ+jukKvyAjb4/WohuiG5e4jaev/0IevdnTV0Wj6Rk44z
         2Rqr+OP4fk3OdxXy1VjdOsAk7JIpn2koV2nEvI47OISvblcb16dUYuM4yU140EVfrS7e
         3n4jVrSySoflq8s17Da48mpd8LDxvTLzllTAKNRFO+eXawVhkIVGuwu8ohtJfR2DFMqt
         +wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775172; x=1771379972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbmzBBFznJGdIZqOzBzpOrSEOyih0VfdaAptjQ/HUOQ=;
        b=SWjRjLohzKostSiYCVb6R1RgaNvSGOMgcuukzB56WG652e788X0DpYnfEqP8wx2ySH
         l/o5v2r2dRjn7HngNy6eYaCZShz51BY7glmroS46IIvION66DPd6Ezoq5W5bB8JGZXaQ
         cW49irWxS0RoQT7xaQS//udBZt2uIVWlfzwrWd733zokG4b15M60T6yd2Pavgrj3L//3
         /4lufz8JhheYK3Jq+qoSkPYPPmMkTqw4AVWg9c1MIl3LLDkOLRguNK+xLinQ6D955428
         MqtjmlzzCKkUV2LHNLokDc68Hv5Wa10ZepcphrgSTWMdwCDzArsYlBP2cwdmFUFOazBo
         T9Tw==
X-Gm-Message-State: AOJu0YyJxeWJlB8/R5m/hle4sFGhM0oyFUp8u2eB+nVUn+dNHu2TaTXK
	XTxgdmS+RDE0J5k9UkIB+O5PcoNBiJGBsICZnSsNjWHIjrNwlJ/u1ItNsfoulj20
X-Gm-Gg: AZuq6aK5/0GZ/ZyAD+Uz0cUgmb+NeLDSktYHACrxoa3XwXqahPBiq5YHqqI3bKzTkUn
	Ts+bLC7/JDtLCS3gTpZlwg4V0arm0PtOmkLzo0kn7GLrzzIyZTaVWvhQ02+bY8FZ7wF2btNO9oy
	zaz2G5PmPLy7FolLTJFtvAJrdf72PDhv4oe37q4Qt538CZKtW7rTRu7xY2fKh4iskXgTByshAM1
	do2OMfvB0rD2pRp0ggUwlja8elxx4Nwf1PFHvCCRP41MCCmjUoz4aquzEZFXlULU1C6FLVumqxG
	s9Tu+oPdPdi550oBhQgqZQA2AlOHblbpE4wrSeBOD4RQdYVcG+Qzbr6OQiNcDOJ5abBeHCJ3h1w
	Lc8KvB5GFBcog0jATJgy7cgRj8gQFYS1GwcdttFu3AaN/uTD6+dRAGtiJn32hLhjIyrQZLx+aeY
	fCLokJa4PLC9NP5bDp7LwROQA=
X-Received: by 2002:a05:620a:40c9:b0:8a4:107a:6772 with SMTP id af79cd13be357-8cb1f72a954mr608780185a.76.1770775171774;
        Tue, 10 Feb 2026 17:59:31 -0800 (PST)
Received: from [127.0.0.1] ([4.236.158.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0db51fsm11274685a.14.2026.02.10.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:59:30 -0800 (PST)
Message-Id: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
In-Reply-To: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Feb 2026 01:59:29 +0000
Subject: [PATCH v2] osxkeychain: define build targets in the top-level
 Makefile.
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoid
incorrectly skipping store operation) introduced linkage with libgit.a,
and its Makefile was adjusted accordingly. However, the build fails as
of 864f55e190 because several macOS-specific refinements were applied to
the top-level Makefile and config.mak.uname, such as:

  - 363837afe7 (macOS: make Homebrew use configurable, 2025-12-24)
  - cee341e9dd (macOS: use iconv from Homebrew if needed and present,
    2025-12-24)
  - d281241518 (utf8.c: enable workaround for iconv under macOS 14/15,
    2026-01-12)

Since libgit.a and its corresponding header files depend on many flags
defined in the top-level Makefile, these flags must be consistently
defined when building git-credential-osxkeychain. Continuing to manually
adjust the git-credential-osxkeychain Makefile is cumbersome and
fragile.

Define the build targets for git-credential-osxkeychain in the top-level
Makefile and modify its local Makefile to simply rely on those targets.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: define build targets in the top-level Makefile.
    
    Changes since v1:
    
     * Use $(MAKE) -C to build targets in the top-level Makefile.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2046%2FKojiNakamaru%2Ffix%2Fosxkeychain-makefile-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2046/KojiNakamaru/fix/osxkeychain-makefile-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2046

Range-diff vs v1:

 1:  0aa80d1d17 ! 1:  8c5d75f0c6 osxkeychain: define build targets in the top-level Makefile.
     @@ Commit message
          Define the build targets for git-credential-osxkeychain in the top-level
          Makefile and modify its local Makefile to simply rely on those targets.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## Makefile ##
     @@ contrib/credential/osxkeychain/Makefile
      --include ../../../config.mak.autogen
      --include ../../../config.mak
      +git-credential-osxkeychain:
     -+	cd ../../..; make contrib/credential/osxkeychain/git-credential-osxkeychain
     ++	$(MAKE) -C  ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
       
      -ifdef ZLIB_NG
      -	BASIC_CFLAGS += -DHAVE_ZLIB_NG
     @@ contrib/credential/osxkeychain/Makefile
      -../../../libgit.a:
      -	cd ../../..; make libgit.a
      +install:
     -+	cd ../../..; make install-git-credential-osxkeychain
     ++	$(MAKE) -C  ../../.. install-git-credential-osxkeychain
       
       clean:
      -	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
     -+	cd ../../..; make clean-git-credential-osxkeychain
     ++	$(MAKE) -C  ../../.. clean-git-credential-osxkeychain
       
      -.PHONY: all install clean
      +.PHONY: all git-credential-osxkeychain install clean


 Makefile                                | 17 +++++++
 contrib/credential/osxkeychain/Makefile | 65 +++----------------------
 2 files changed, 23 insertions(+), 59 deletions(-)

diff --git a/Makefile b/Makefile
index 4ac44331ea..97196c6afa 100644
--- a/Makefile
+++ b/Makefile
@@ -4060,3 +4060,20 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
+
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
+
+contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
+	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+
+install-git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $< '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+
+.PHONY: clean-git-credential-osxkeychain
+clean-git-credential-osxkeychain:
+	$(RM) \
+		contrib/credential/osxkeychain/git-credential-osxkeychain \
+		contrib/credential/osxkeychain/git-credential-osxkeychain.o
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index c68445b82d..2044a33f41 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,66 +1,13 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
-include ../../../config.mak.uname
--include ../../../config.mak.autogen
--include ../../../config.mak
+git-credential-osxkeychain:
+	$(MAKE) -C  ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
 
-ifdef ZLIB_NG
-	BASIC_CFLAGS += -DHAVE_ZLIB_NG
-        ifdef ZLIB_NG_PATH
-		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
-		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
-        endif
-	EXTLIBS += -lz-ng
-else
-        ifdef ZLIB_PATH
-		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
-        endif
-	EXTLIBS += -lz
-endif
-ifndef NO_ICONV
-        ifdef NEEDS_LIBICONV
-                ifdef ICONVDIR
-			BASIC_CFLAGS += -I$(ICONVDIR)/include
-			ICONV_LINK = $(call libpath_template,$(ICONVDIR)/$(lib))
-                else
-			ICONV_LINK =
-                endif
-                ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
-			ICONV_LINK += -lintl
-                endif
-		EXTLIBS += $(ICONV_LINK) -liconv
-        endif
-endif
-ifndef LIBC_CONTAINS_LIBINTL
-	EXTLIBS += -lintl
-endif
-
-prefix ?= /usr/local
-gitexecdir ?= $(prefix)/libexec/git-core
-
-CC ?= gcc
-CFLAGS ?= -g -O2 -Wall -I../../.. $(BASIC_CFLAGS)
-LDFLAGS ?= $(BASIC_LDFLAGS) $(EXTLIBS)
-INSTALL ?= install
-RM ?= rm -f
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
-
-git-credential-osxkeychain: git-credential-osxkeychain.o ../../../libgit.a
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
-		-framework Security -framework CoreFoundation
-
-install: git-credential-osxkeychain
-	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
-	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
-
-../../../libgit.a:
-	cd ../../..; make libgit.a
+install:
+	$(MAKE) -C  ../../.. install-git-credential-osxkeychain
 
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	$(MAKE) -C  ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all install clean
+.PHONY: all git-credential-osxkeychain install clean

base-commit: 864f55e1906897b630333675a52874c0fec2a45c
-- 
gitgitgadget
