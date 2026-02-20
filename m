Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B223EBF3E
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771551546; cv=none; b=POvlJ0Ghj8aChBv1hiDIogNiwoWU2QZcXAyaS9G7vt7T0ghTOCAZJPu7pbRj8Egxdk3dASngGWqD/CjJWNmdyi91mB4vK6SRyCWoV+7DihnUmygVwUvaTnW+UBUIUea6ZqoSnA/yiimaqiXUhT6dJh9CeKRGaOScbcsCE3PGasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771551546; c=relaxed/simple;
	bh=I7t0wwlw6teJIWo0j1T0/SW3tpdZ7bRjkJ7+3a5NJjY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yagfh28CWcdC26bmrB+XF6CKVVbZvV3Doc3Gf7tcHRFgVLgJRt2em9j0P/VFjGvRbnyOy4h9rGV6633xvh0E9rQSIVkJf9IurQwJgo8G/G43tjrLeS/f1uvYvx4GT25UAJc+EooJfp26FRJAfFerwGxP9w9QtJJKDa4tup1mHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyxiXxNI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyxiXxNI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3825b0fbso155273485a.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771551543; x=1772156343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqE5CERWMrnWvDzkyogp9auMfeeN6XnpJ26TDwlsObc=;
        b=dyxiXxNIm6VIQ1L7Z4DBPpNWZjy/54fGD6/QTaxalOGDjW4FEmSBU1C2mpOF55zTv/
         FSNrB3QSmK4lPjgj8Hx/VQ1I6qyOJ7zLLryhDrcK3k22xVhbItePlTb9pAqpgJH08Mk2
         98lgfax1QD8A0MIsgPSvT/SzPEOuAkuoHYQVDEcvqxZyaBaojTxDkpopyYsMth3R0DXS
         UuaLKtd6EAvCj65pqqAZoeqGEFGuDJWbDhPFMIPPSOOGhl6frWdc1RU/e1M6KTasOK7B
         4J/Ics4DQotBny9lwQnHWd5EGr1XIbtvDPsxqV+MJw2jVl37bQN3EUEFItZli2XJIaRM
         wttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771551543; x=1772156343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqE5CERWMrnWvDzkyogp9auMfeeN6XnpJ26TDwlsObc=;
        b=VlZJIDthm/U8eVVK8R8r0PRcNr+AhHk/43bJt9BhSU8SEjavK09k6dRAiwHfkemo7S
         cocI7dY8wFVa2gQT+MPBGIAwY+SK8a9vejYKKHzAnCz7XSs9BMhRTGh4ldUxAWYwFsKk
         W1J/9EFRtoxyVJ4msk/7LuGYdkRpICx9TLcq9hdDcY4oXCVkLgaG8qXble7ZDOc0DuFf
         oGSzUjzIzNx8GACpJfzdkpYvSytdVAo6YGSD8vxiFKcelt5X23TGw72gfdKyV+GTIW05
         8aTO1DpKePap5Ml4VHC6gXpSjOxWHUtMFYMStvSHwlzX5Opl0POMbnyEX/VpztAUDta+
         iu1A==
X-Gm-Message-State: AOJu0Yy4Lz5RDZKrrLSKLHUDD8lMh1xKvAj98cbYbBzPNFXNtz1NEHl0
	gLWVj3OulK3dgV6lNOPZXhy9XLBBe/c3mr2SVBx1qzVuFIS2in4Xd+W9N2ehtw==
X-Gm-Gg: AZuq6aJu0HpFLWT0dIQaDIlRXv0d/rADRYUd+Cm8gyUcS0hlEtA29KFPg4W83/tr/If
	y8HIlvQw1LKL+AjqhFTC0IFRx0F0+9eCsqlySCnVIppPQZPYiQ8IOMdO3Zrg81HvWZCgL8CWIpX
	r8ckU9qpI+3H9+nMLWUUu4rrSwt1w6OzSGbEuOT/cYHj2Bdbx8ZUSjPaY5tDnuJOCxJBUWPE0+3
	R5hIwY9nhiREtIE8a5tVEfHHE9o0pRN902WLX/XgBiEYVfZ/Fq1tseKu5ACkNaWaufKyCSyAy+3
	EmEJADw2OpZ6AKfsFJI123tU57noSLlcR29zoiY9Bbj/iP1sK7/RikVaxLYTS1BnD0sVApqmkRQ
	NYA73lJytiMk8X1CRcc35JpqzUxoKKvrBgSAB1q0UsxBH4R5HJPRW8Vo8K+Ph38+hhBMr+urRjr
	hbubjMuHu+6iWcpVS/uuRR6AmA7D8=
X-Received: by 2002:a05:620a:19aa:b0:8c6:a5bc:8a80 with SMTP id af79cd13be357-8cb79eabb7bmr585014385a.29.1771551543145;
        Thu, 19 Feb 2026 17:39:03 -0800 (PST)
Received: from [127.0.0.1] ([135.232.200.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0be6besm2186426185a.5.2026.02.19.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:39:01 -0800 (PST)
Message-Id: <pull.2046.v4.git.1771551540816.gitgitgadget@gmail.com>
In-Reply-To: <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
References: <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:39:00 +0000
Subject: [PATCH v4] osxkeychain: define build targets in the top-level
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoid
incorrectly skipping store operation, 2025-11-14) introduced linkage
with libgit.a, and its Makefile was adjusted accordingly. However, the
build fails as of 864f55e190 because several macOS-specific refinements
were applied to the top-level Makefile and config.mak.uname, such as:

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
Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: define build targets in the top-level Makefile.
    
    Changes since v3:
    
     * Add missing commit reference date.
     * Use dep_dirs to create contrib/credential/osxkeychain/.depend.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2046%2FKojiNakamaru%2Ffix%2Fosxkeychain-makefile-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2046/KojiNakamaru/fix/osxkeychain-makefile-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2046

Range-diff vs v3:

 1:  25a66e1b7d ! 1:  3c36804348 osxkeychain: define build targets in the top-level Makefile.
     @@ Commit message
          osxkeychain: define build targets in the top-level Makefile.
      
          The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoid
     -    incorrectly skipping store operation) introduced linkage with libgit.a,
     -    and its Makefile was adjusted accordingly. However, the build fails as
     -    of 864f55e190 because several macOS-specific refinements were applied to
     -    the top-level Makefile and config.mak.uname, such as:
     +    incorrectly skipping store operation, 2025-11-14) introduced linkage
     +    with libgit.a, and its Makefile was adjusted accordingly. However, the
     +    build fails as of 864f55e190 because several macOS-specific refinements
     +    were applied to the top-level Makefile and config.mak.uname, such as:
      
            - 363837afe7 (macOS: make Homebrew use configurable, 2025-12-24)
            - cee341e9dd (macOS: use iconv from Homebrew if needed and present,
     @@ Commit message
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
     +    Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## Makefile ##
     +@@ Makefile: objects: $(OBJECTS)
     + dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
     + dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
     + 
     ++ifeq ($(uname_S),Darwin)
     ++	dep_dirs += $(addsuffix .depend,$(sort $(dir contrib/credential/osxkeychain/git-credential-osxkeychain.o)))
     ++endif
     ++
     + ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
     + $(dep_dirs):
     + 	@mkdir -p $@
      @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
       
       contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
     @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
      +		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
      +
      +contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
     -+	@mkdir -p contrib/credential/osxkeychain/.depend
      +	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
      +
      +install-git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain


 Makefile                                | 21 ++++++++
 contrib/credential/osxkeychain/Makefile | 65 +++----------------------
 2 files changed, 27 insertions(+), 59 deletions(-)

diff --git a/Makefile b/Makefile
index 4ac44331ea..47485004d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2876,6 +2876,10 @@ objects: $(OBJECTS)
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
+ifeq ($(uname_S),Darwin)
+	dep_dirs += $(addsuffix .depend,$(sort $(dir contrib/credential/osxkeychain/git-credential-osxkeychain.o)))
+endif
+
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
 $(dep_dirs):
 	@mkdir -p $@
@@ -4060,3 +4064,20 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 
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
index c68445b82d..219b0d7f49 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,66 +1,13 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
-include ../../../config.mak.uname
--include ../../../config.mak.autogen
--include ../../../config.mak
+git-credential-osxkeychain:
+	$(MAKE) -C ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
 
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
+	$(MAKE) -C ../../.. install-git-credential-osxkeychain
 
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all install clean
+.PHONY: all git-credential-osxkeychain install clean

base-commit: 864f55e1906897b630333675a52874c0fec2a45c
-- 
gitgitgadget
