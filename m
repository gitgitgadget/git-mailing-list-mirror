Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870D2D7DE4
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746465; cv=none; b=LHnRGmWgdWpq0VxUbmrDhKHr6PEh1FlVwMNzigRbuVPG4K+tprtSOTPzq6+WhpeohJOlg3orqcpV8JZqgTMGo+lLdgpYF82Kjn0Lej24Zz1c5cSchiPj6p3LKS4p2gHziTGqzwmPQErhS/g0x/6ix+qGLlQ8hgtciabK8zZVyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746465; c=relaxed/simple;
	bh=XK3A/usLn2ncVt7Kbw6BMAQaFuqKXl69tX85N8INHno=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GUmm9WJamZIhX3Ee+sNzLw87c9xWnrMjT8554gMz6JrTLCACWfdomgvMFJSaZJYZ+TyIh0dNb5ZcO1kb4FWvcV10JWUuRcymg37iovGTD+d7EEOstKHq7pt4iRuG3wg2UDI8oK9XsXHR2kGOTZtrRF9q0SAJUWqy6H/gddcu//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdB4YKOA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdB4YKOA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c70ab3b5fcso598609685a.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770746463; x=1771351263; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7aGhqrhFQ9pXv+/mPfQ+6CjaPhyLfNZdynUDEtRbbs=;
        b=DdB4YKOAlltezZGmDR++IRvo68hw9R80aGFCjI0PP4kgoTM9D20OoOEQpS9Sb0rdjR
         K1zQOvT6ANbP1ZOn1RLNS3yDZdblNiwICIQ6dHBbepjAR965XH/rIK7mqQ5492dYqmjT
         ki9xb+J9FMaFoHmUA1T4TjXvR4V8ICPenVm0RKOh2wsOZILMM1KqxBLZjukWaGAuz+7G
         Rcef+J4HOyyK4ulRY+L/ssZL64ZTOujy0JO6HDy8KeXRSbMVBWfMwJ+JKvbTWVvS+xF4
         82yCN0PfKDk4W5wXOMaeffEG5KnwfWXPA0PZOWcb7Wq4X5Z6EVeOHaS0OMGDGCIgp1XI
         5F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770746463; x=1771351263;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7aGhqrhFQ9pXv+/mPfQ+6CjaPhyLfNZdynUDEtRbbs=;
        b=mnDH4cIE8o3Bl7xNS5oa1ZMKPDzXC/IIB7gBbYsrdD6TCxZteHNnWuON4CafX+CN8w
         LVhPmbuTKjKKUxtSZ2G/hf4sga47PGQYzb8QqioP/j9zkm5NXgEkJ/PEtwZvZV2t2O+R
         B52gL0tm5pTI+4Bve2xfF7wj5gexxx8VU5atx4lhKsyyAhJIXAycpHz7H8NoGbs0pIqx
         bUcXfKa5riRAaOtaPhavJjOej8fBciG/IsYdwjQYtLu1zW4Jabw2NeHYfXs38Y1Z472x
         lyluJGmFmdfseKoKQEqqbEuY+POTb8S3/s3Ur8gp1wiY7nYXNzeouVrz2qyLmJA73SQ6
         oZWw==
X-Gm-Message-State: AOJu0YxLVLjRkDQDyKlP6yIejtYGXF6sFhnCKKtBgnxO4FrzoA2D8bHB
	VJ1W/lbg4Il25r+6gzrufTN4+wyEnUlXreh3orWfxKYZkudOIlZQSTN2b49Gpg==
X-Gm-Gg: AZuq6aIYA2VFzaGtFyYvyKPa/7C17VfovIWejfSei7vGsfaiWAvOpgm6jfy9LK188e5
	7faB0ccV8rSFkqYrN4MySGDIIjnzq1pvhp12dseTFZ0qJzcAD+pwqA4pzmmb1Olfqsl3mG7W2pl
	Tim8h7b2yc1BkPhxyDrwSBgVnimymR6Im239CjnEAD88aZjvgTrcKD1NtON/gWsv4UBowSSi3CJ
	8kekpyguK6gU3iXlxgreKsUIGMpWqw5GcQbUN2cnVltpxiW8zqZM+32tJm3pUUBM/K2eFlP27zG
	GgwOfF84kf/TR0cuvSNQJWhPMQxYBaGNbafgZC/IlMKEZirTm9vBzCBuKsQ7ihN7z5z9cfcqqyo
	w4JfyfTesp+wE5/0+xuag4veYrLRUFAbY4daJQLo1XCOP1tcsopqKv2ckT+84R6q6F7s1dhTotk
	W1qS7is/DpggUM6mS1Xr2fX8EsCxMVuf3aGiog
X-Received: by 2002:a05:620a:2845:b0:8c6:a5b4:e01e with SMTP id af79cd13be357-8cb27f79048mr12130785a.16.1770746462828;
        Tue, 10 Feb 2026 10:01:02 -0800 (PST)
Received: from [127.0.0.1] ([172.174.167.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9efasm1094861685a.43.2026.02.10.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:01:01 -0800 (PST)
Message-Id: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 18:01:01 +0000
Subject: [PATCH] osxkeychain: define build targets in the top-level Makefile.
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
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
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

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: define build targets in the top-level Makefile.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2046%2FKojiNakamaru%2Ffix%2Fosxkeychain-makefile-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2046/KojiNakamaru/fix/osxkeychain-makefile-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2046

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
index c68445b82d..ddb29f0563 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,66 +1,13 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
-include ../../../config.mak.uname
--include ../../../config.mak.autogen
--include ../../../config.mak
+git-credential-osxkeychain:
+	cd ../../..; make contrib/credential/osxkeychain/git-credential-osxkeychain
 
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
+	cd ../../..; make install-git-credential-osxkeychain
 
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	cd ../../..; make clean-git-credential-osxkeychain
 
-.PHONY: all install clean
+.PHONY: all git-credential-osxkeychain install clean

base-commit: 864f55e1906897b630333675a52874c0fec2a45c
-- 
gitgitgadget
