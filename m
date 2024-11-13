Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40A7083E
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515439; cv=none; b=YYqrTUUSAH+IezwYHTa2GSn/ffR+Pq9nKY6GTdSRpx8bcIxgYwHyQakvwD6JSM74Reuw4+Pio6wN1ODJFSX5xcrG6eijUdENRpi2GVaR5qOQ+ph2b61BOHID2pPYkqka/yJmhBfG7Pa5PrlpIQsV73nKtaNptTO6Saf5jLpxZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515439; c=relaxed/simple;
	bh=AjA455QjVoAiOqhIBuyClhfyVJJAg+jRViafY6lUVl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlIIplAso5NUOyOnljRvfG6oJlRVxhNYB3412rcKgewy+Qw9GvlDCCJDIG5ysKfudhsYMpi4zI4im/2g8yIqqDajormCrrPw8eruew1nVIqTr5h+Wcxxzv6a5yqbNrKP3zYx9KdbQOmPXTg6/71XxKznKgSRx8nqd/6KXCah5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ4I/7gw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ4I/7gw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so57443595e9.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515435; x=1732120235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=npfdZr5hOtZ9srciZLSPRadyk3RwBK0oQc/4XYsZS38=;
        b=DJ4I/7gwg9EMlCh2SIFzFT9nOVhKKpVd1F1PIJKXk5Vsep89m2qJRV5T6jmZ8MmoPN
         djsIFjgVasNrXW/WtX2aDYek5zc+7tt4t22sOGf/DkJuOPoZrh1R3/J1cNDP9k7DvojQ
         Tsb/HRzYcLkyRzt9a+gzc8i0tNc5kWiWj88EtGBWKo/o94PiZm3IFAhq35pz1TmjOdRy
         1WymPdP3OBWU3WeCihR28hR+spSMa9+6RaAHq0jdx3By3SsXeQiHKaZQOuBe/UgVUJyQ
         sQCkaZt5IPybh52E2pBMmKHAjvr5lFgX5d7M6GZKY2GLaY80nbafJyJCZ9l295+LRKS/
         XX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515435; x=1732120235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npfdZr5hOtZ9srciZLSPRadyk3RwBK0oQc/4XYsZS38=;
        b=OCT7J1JC19lvEog+/t2WoWmfh89/u8CO8mIyz83KcMTx7/7a8FtU+AZPD/CZPppopK
         dl74rAjwt4NIukNfDAd8DjP2lszfr7jl+A3qfKMlP602l7R3HnKsV1qaCqgcMPyKej24
         DtOGOLEpPy88pLK5n87jvaDOG2FNrFGipkkmJg2VFHokvsgCFpEVZBtb/R1gIj/DHojf
         R6/VVs7MkwKpyo7Z/YMlhcs5AdMi0TELNTkvF0YyhpQ9RwFC7tTPhpcAoyj2iWWDHiYC
         +3KnEbavhF/Jd3Qv7s10kH27wyH+q7BRqhN0WyPr8Fy9REDIK2yP/+GMTz0XRu8OxgSm
         VorQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPfDCsLYqWmwDLAyqZprBnzW49k9h8AQM4pe6Z5lisKTD+fkgzLqTuISEzk4qqvld90DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9PlFofbyqFKW3XxLn6Oei24gmzo3XebDTeOQT04m0BmbCUII
	THL5626DWdhi6OTUkxcVam92ps354RPcT8HaZx9qSaaJ2zMh6jpKq7e11A==
X-Google-Smtp-Source: AGHT+IF+lVCsYBrwsv2rCqYzsaV5S587XSeZ+bABmrQTC9V8QCMpzAHVKi+MG4Kfp2QI+ZEdNjmNzg==
X-Received: by 2002:a5d:47ae:0:b0:37d:34f6:92a with SMTP id ffacd0b85a97d-381f1888ce3mr16953120f8f.51.1731515435296;
        Wed, 13 Nov 2024 08:30:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9707c8sm18788548f8f.17.2024.11.13.08.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:30:34 -0800 (PST)
Message-ID: <c0474637-3923-4e4c-a90b-e86d5f37a366@gmail.com>
Date: Wed, 13 Nov 2024 16:30:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v6 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>,
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <20241112-pks-meson-v6-8-648b30996827@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241112-pks-meson-v6-8-648b30996827@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 12/11/2024 17:02, Patrick Steinhardt wrote:
> Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
> the current directory, where the expectation is that it should exist in
> the source directory. But other build systems that support out-of-tree
> builds may not want to do that to keep the source directory pristine,
> even though CMake currently doesn't care.
> 
> Refactor the script such that it doesn't write output to a file anymore
> but so that it instead writes the version to stdout. This makes it
> easier to compute the same version as our Makefile would without having
> to write the "GIT-VERSION-FILE".

This patch moves the logic that only updates GIT-VERSION-FILE if the
version has changed from the script into the Makefile. As we really want
the CMake and meson builds to set the string at build time which
probably means extending GIT-VERSION-GEN to write a header file that
defines GIT_VERSION etc. I'm not sure this is a good direction. In the
long run I think we'd be better off with something like the patch below.

Best Wishes

Phillip

---- >8 ----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] WIP CMake: update GIT_VERSION at runtime

The CMake build defines GIT_VERSION when it is configured and does not
update it when HEAD changes. Fix this by modifying GIT-VERSION-GEN so
that in addition to creating GIT_VERSION-FILE, it creates a header file
containing the version strings that is included in version.c.

TODO:
   - update CMakeLists.txt to set the version information for git.res
     at build time.
   - Check for changes to GIT_USER_AGENT when the version has not
     changed.
   - Maybe remove GIT-VERISON-FILE infavor of parsing version-def.h so
     that there is a single source of truth for the version.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  GIT-VERSION-GEN                     | 17 +++++++++++++----
  Makefile                            | 15 +++++++--------
  contrib/buildsystems/CMakeLists.txt | 26 +++++++++++++++++++-------
  version.c                           |  1 +
  4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677..25c033fa892 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,7 @@
  #!/bin/sh
  
-GVF=GIT-VERSION-FILE
+GVF="$1"
+VERSION_HEADER="$2"
  DEF_VER=v2.47.GIT
  
  LF='
@@ -30,11 +31,19 @@ VN=$(expr "$VN" : v*'\(.*\)')
  
  if test -r $GVF
  then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
+	VC=$(sed -e 's/^GIT_VERSION = //' "$GVF")
  else
  	VC=unset
  fi
-test "$VN" = "$VC" || {
+test "$VN" = "$VC" && test -f "$VERSION_HEADER" || {
  	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
+	echo "GIT_VERSION = $VN" >"$GVF"
+	USER_AGENT="${GIT_USER_AGENT:-git/$VN}"
+	HEAD="$(GIT_CEILING_DIRECTORIES=.. \
+		git rev-parse -q --verify HEAD 2>/dev/null)"
+	cat <<-EOF >"$VERSION_HEADER"
+	#define GIT_VERSION "$VN"
+	#define GIT_BUILT_FROM_COMMIT "$HEAD"
+	#define GIT_USER_AGENT "$USER_AGENT"
+	EOF
  }
diff --git a/Makefile b/Makefile
index 2afad000762..7cd42e2bed7 100644
--- a/Makefile
+++ b/Makefile
@@ -592,7 +592,11 @@ include shared.mak
  #        Disable -pedantic compilation.
  
  GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) ./GIT-VERSION-GEN GIT-VERSION-FILE version-def.h
+
+version-def.h: GIT-VERSION-FILE
+	@touch $@
+
  -include GIT-VERSION-FILE
  
  # Set our default configuration.
@@ -919,6 +923,7 @@ REFTABLE_LIB = reftable/libreftable.a
  GENERATED_H += command-list.h
  GENERATED_H += config-list.h
  GENERATED_H += hook-list.h
+GENERATED_H += version-def.h
  GENERATED_H += $(UNIT_TEST_DIR)/clar-decls.h
  GENERATED_H += $(UNIT_TEST_DIR)/clar.suite
  
@@ -2505,13 +2510,7 @@ PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
  pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
  	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
  
-version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
-version.sp version.s version.o: EXTRA_CPPFLAGS = \
-	'-DGIT_VERSION="$(GIT_VERSION)"' \
-	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
-	'-DGIT_BUILT_FROM_COMMIT="$(shell \
-		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
-		git rev-parse -q --verify HEAD 2>/dev/null)"'
+version.sp version.s version.o: version-def.h GIT-USER-AGENT
  
  $(BUILT_INS): git$X
  	$(QUIET_BUILT_IN)$(RM) $@ && \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2e22e87d188..e64045c4dbd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -86,12 +86,15 @@ endif()
  #Create GIT-VERSION-FILE using GIT-VERSION-GEN
  if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
  	message("Generating GIT-VERSION-FILE")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
+	execute_process(COMMAND ${SH_EXE}
+				"${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+				"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+				"${CMAKE_BINARY_DIR}/version-def.h"
+			WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")
  endif()
  
  #Parse GIT-VERSION-FILE to get the version
-file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
+file(STRINGS "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE" git_version REGEX "^GIT_VERSION = (.*)")
  string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
  string(FIND ${git_version} "GIT" location)
  if(location EQUAL -1)
@@ -101,6 +104,16 @@ else()
  	string(APPEND git_version ".0") #for building from a snapshot
  endif()
  
+add_custom_target(version-def
+	COMMAND ${SH_EXE}
+		./GIT-VERSION-GEN
+		"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+		"${CMAKE_BINARY_DIR}/version-def.h"
+	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
+	BYPRODUCTS "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
+		-  "${CMAKE_BINARY_DIR}/version-def.h"
+	VERBATIM)
+
  project(git
  	VERSION ${git_version}
  	LANGUAGES C)
@@ -240,10 +253,7 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
  			GIT_HTML_PATH="share/doc/git-doc"
  			DEFAULT_HELP_FORMAT="html"
  			DEFAULT_GIT_TEMPLATE_DIR="share/git-core/templates"
-			GIT_VERSION="${PROJECT_VERSION}.GIT"
-			GIT_USER_AGENT="git/${PROJECT_VERSION}.GIT"
-			BINDIR="bin"
-			GIT_BUILT_FROM_COMMIT="")
+			BINDIR="bin")
  
  if(WIN32)
  	set(FALLBACK_RUNTIME_PREFIX /mingw64)
@@ -680,6 +690,8 @@ parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
  list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
  list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
  add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
+target_include_directories(libgit PRIVATE "${CMAKE_BINARY_DIR}")
+add_dependencies(libgit version-def)
  
  #libxdiff
  parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
diff --git a/version.c b/version.c
index 41b718c29e1..7adc4d51ff2 100644
--- a/version.c
+++ b/version.c
@@ -1,5 +1,6 @@
  #include "git-compat-util.h"
  #include "version.h"
+#include "version-def.h"
  #include "strbuf.h"
  
  const char git_version_string[] = GIT_VERSION;
-- 
2.47.0.354.g52c9d0440b0.dirty





