Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38A3C1D49
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983864; cv=none; b=LRx/SbQroJg0YX3ZXUOoPlVDYAhSvFFJsddl+dk1f5uAlOODAcIT64tjR659Bwy/dCd8IO1Hye4yz7K4FBbZn/4eENuJa4owJolt6rmKCi0WIkQ8zbxUmZXD6IM+D1OaPkXpn+LZSUJ7ractg7UC122KvVCr2DwG0vSqVsfSncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983864; c=relaxed/simple;
	bh=Tugnx9xoel++cHEOL/gXWtQcBmkATpT4Lm3wZC2Hbgk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQKNg344xZ6wXMJH9sdiIBmnF/MnLL7PJa5510wdMPz1hNZ7opkfNVHLbkhhDtN7rRUbNgS5xUKmuqEoUPYWtXa0wgvGuThFy9OFsUDVQUqgCkF5uNhfYjegK61+iu+kFBdX4CyE7GyQ9zzsBNyge2O0TvZOfUBw25wWm0SjgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5YFiI7x; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5YFiI7x"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so257893866b.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983860; x=1789588660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMr613Agyjq0LZBdKBcBqn4LmghJXQpX7mmfNGn0btk=;
        b=C5YFiI7xCdAtqry1FeLfZSICRR1K5mS48vyIIrixQGVFJGf1BuE60bJRiklINqFLpI
         Qz+o6DiEf2O/1TGFeV8VNsjTIJdeLosoL5H8lwZXf9LYIPM+nmSObArzB8UVEf2qBa+V
         TvfmXvndLD8n7vObPPi6Gd+M9JH4TDF3EF9cjB/aPdK53mk0rRpFVVafVa38fWStawJ3
         CF8S9jjNtNylYWMPbPm56fCcKnURShBRtRd63/U4SwsEtF2IYEtXCibTw3xoojAFszFw
         8Wa/naGlGlxiccRepnjpS9W3BJsIT0BYJdH193yFNjh1r5yeqP1NnvgfggfxuVLNKqyf
         RL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983860; x=1789588660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JMr613Agyjq0LZBdKBcBqn4LmghJXQpX7mmfNGn0btk=;
        b=rjLcorG87SuSusHAbAwSXkAx3ZTipMXeqWm6IJNGaT3AG2V9f4HvMnesruMhqgMZlh
         yKbkTMsxeNPCkxLqqc866uqBXkMJaBfJCItcPq1KyThSsGhBbC7N1BNEa60Icw6S1exh
         PeTrBljaAfBPLfUdKnkeO+7A6oZGt4CDyHMyUw8LgFCyUtW8PIEtRcnunp+jVL1stpny
         ULu+SPdyBPBFcq53XaMnwF5KvoqA0tSyxDztCp6+ShbXD3RAakDtjmz7gRjHu6ATUVLX
         zIM4JPZpsXXS/T/3JPauGQJTT2esK+vezaTZMYJ8LyoLOwZNa8Jrq63VjlvzPIMo04Ad
         8E6w==
X-Gm-Message-State: AFuF++mTqSM8wpa8IpiKVNsCfBvvKaFzjYZm65EzB11zStQqYfUpJHvZ
	chO13x30Hl4kNMnEAgVHM5iWTLLfOotNEVdxkIspTNDWGjgWDe2Mr2mJcX2B/g==
X-Gm-Gg: AYBFou3CI6fMJ6e2SzIJ5SrC13ZANRZN2q0KLfNoD2FL9Bh6m5+zjvsaf1q8r4HJGvC
	FH5hcITmUX0Jlk2HulpL0wCo48XYXfj4UAdQ5RdNx8oaMXVgVcJHhez97IFR39spe/mfLW+c+Wj
	WcphUS9k3PxlUbN5P9IqCwv/ptWjO6RvkC/lT9Wg5r2ysaM0gPbnVqDh1uaO60Wt4NT36E2uvrv
	zKGjwLMVgBaV/RKHfDiry6vX1X3o/gug4xqKLOor+14ddtGIY2IcVuTNdBiQXVPfxpfI5Rcqjfe
	FGz9Q+0j86Rk/lHo6UT8Syh056lD+La2+zOkGAL+IIDm3tonO2nstpXhmLwleywatnIv94JNT90
	GQIayWUiNhbH94F29ArVC0lnY/SHfI75K/76x6oEyZZKygOApcAr+fQmggZAyjf4qGRjBWZft3x
	7hekseON17ulMDh363UrC/QY0ZmzAIX3Gp/PpAqhOTT0E+2lbX583q2rp/5AlphA3Rn06QsQBzR
	TrVQC9tHukRSZb8722mS+310Pw1
X-Received: by 2002:a17:907:9620:b0:c29:462b:f917 with SMTP id a640c23a62f3a-c29462c1f75mr93747966b.14.1788983859797;
        Wed, 09 Sep 2026 12:57:39 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293b6246c4sm112405566b.20.2026.09.09.12.57.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:57:38 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:57:37 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 4/4] Makefile: precompile "git-compat-util.h"
Message-ID: <aqG6MRWKCcG/ft/s@szeder.dev>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260909195006.2179119-5-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909195006.2179119-5-szeder.dev@gmail.com>

On Wed, Sep 09, 2026 at 09:50:06PM +0200, SZEDER Gábor wrote:
>   - List the object files that are built using the precompiled header
>     in the PRECOMPILED_HEADER_USERS variable:
> 
>     - The precompiled header should not change what actually gets
>       compiled.  Therefore, use the precompiled header only when
>       compiling source files that start with including
>       "git-compat-util.h" (directly or indirectly, e.g. via
>       "builtin.h"), or its inclusion is only preceeded by #define
>       directives that don't influence "git-compat-util.h" between its
>       include guards [2] (currently DISABLE_SIGN_COMPARE_WARNINGS,
>       USE_THE_REPOSITORY_VARIABLE or GIT_TEST_PROGRESS_ONLY). [3]
> 
>       Several (but not all) object or source files listed in the
>       COMPAT_OBJS, REFTABLE_OBJS and THIRD_PARTY_SOURCES variables
>       don't include "git-compat-util.h", therefore, for the sake of
>       simplicity, none of the files listed in these variables are
>       built with the precompiled header. [4]

>     - In short, PRECOMPILED_HEADER_USERS contains all object files
>       listed in OBJECTS, except those that are listed in COMPAT_OBJS,
>       REFTABLE_OBJS or THIRD_PARTY_SOURCES as well.

> [4] "make"'s flexibility would allow us to separately list those
>     object files that don't include "git-compat-util.h", but then on
>     my (I assume fairly typical) Linux box the number of object files
>     built using the precompiled header increases only by 9 (from 536
>     to 545), which reduces the build time by about 1% (0.2s).
>     Therefore, I don't think it's worth the churn.

For reference, a change to do that would look like that patch below,
but, as mentioned above, the benefit is rather small:

  Benchmark 1: make -j12 (rev = precompile)
    Time (mean ± σ):     21.747 s ±  0.048 s    [User: 186.120 s, System: 35.032 s]
    Range (min … max):   21.650 s … 21.802 s    10 runs

  Benchmark 2: make -j12 (rev = precompile-all)
    Time (mean ± σ):     21.556 s ±  0.062 s    [User: 184.584 s, System: 35.016 s]
    Range (min … max):   21.477 s … 21.675 s    10 runs

  Summary
    'make -j12 (rev = precompile-all)' ran
      1.01 ± 0.00 times faster than 'make -j12 (rev = precompile)'

  --- >8 ---

diff --git a/Makefile b/Makefile
index 7d9dac83c4..b5d75dc75f 100644
--- a/Makefile
+++ b/Makefile
@@ -698,6 +698,7 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
+COMPAT_NOPCH_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
@@ -711,6 +712,7 @@ OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
 REFTABLE_OBJS =
+REFTABLE_NOPCH_OBJS =
 RUST_SOURCES =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
@@ -721,6 +723,7 @@ TEST_BUILTINS_OBJS =
 TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
+THIRD_PARTY_NOPCH_SOURCES =
 UNIT_TEST_PROGRAMS =
 UNIT_TEST_DIR = t/unit-tests
 UNIT_TEST_BIN = $(UNIT_TEST_DIR)/bin
@@ -1376,20 +1379,22 @@ LIB_OBJS += xdiff/xpatience.o
 LIB_OBJS += xdiff/xprepare.o
 LIB_OBJS += xdiff/xutils.o
 
-REFTABLE_OBJS += reftable/basics.o
-REFTABLE_OBJS += reftable/block.o
-REFTABLE_OBJS += reftable/blocksource.o
-REFTABLE_OBJS += reftable/error.o
-REFTABLE_OBJS += reftable/fsck.o
-REFTABLE_OBJS += reftable/iter.o
-REFTABLE_OBJS += reftable/merged.o
-REFTABLE_OBJS += reftable/pq.o
-REFTABLE_OBJS += reftable/record.o
-REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/system.o
-REFTABLE_OBJS += reftable/table.o
-REFTABLE_OBJS += reftable/tree.o
-REFTABLE_OBJS += reftable/writer.o
+REFTABLE_NOPCH_OBJS += reftable/basics.o
+REFTABLE_NOPCH_OBJS += reftable/block.o
+REFTABLE_NOPCH_OBJS += reftable/blocksource.o
+REFTABLE_NOPCH_OBJS += reftable/error.o
+REFTABLE_NOPCH_OBJS += reftable/fsck.o
+REFTABLE_NOPCH_OBJS += reftable/iter.o
+REFTABLE_NOPCH_OBJS += reftable/merged.o
+REFTABLE_NOPCH_OBJS += reftable/pq.o
+REFTABLE_NOPCH_OBJS += reftable/record.o
+REFTABLE_NOPCH_OBJS += reftable/stack.o
+REFTABLE_NOPCH_OBJS += reftable/table.o
+REFTABLE_NOPCH_OBJS += reftable/tree.o
+REFTABLE_NOPCH_OBJS += reftable/writer.o
+
+REFTABLE_OBJS += $(REFTABLE_NOPCH_OBJS)
 
 LIB_OBJS += $(REFTABLE_OBJS)
 
@@ -1535,11 +1540,13 @@ THIRD_PARTY_SOURCES += compat/inet_ntop.c
 THIRD_PARTY_SOURCES += compat/inet_pton.c
 THIRD_PARTY_SOURCES += compat/obstack.%
 THIRD_PARTY_SOURCES += compat/poll/%
-THIRD_PARTY_SOURCES += compat/regex/%
-THIRD_PARTY_SOURCES += sha1collisiondetection/%
-THIRD_PARTY_SOURCES += sha1dc/%
-THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
-THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
+THIRD_PARTY_NOPCH_SOURCES += compat/regex/%
+THIRD_PARTY_NOPCH_SOURCES += sha1collisiondetection/%
+THIRD_PARTY_NOPCH_SOURCES += sha1dc/%
+THIRD_PARTY_NOPCH_SOURCES += $(UNIT_TEST_DIR)/clar/%
+THIRD_PARTY_NOPCH_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
+
+THIRD_PARTY_SOURCES += $(THIRD_PARTY_NOPCH_SOURCES)
 
 CLAR_TEST_SUITES += u-ctype
 CLAR_TEST_SUITES += u-dir
@@ -1959,7 +1966,7 @@ ifdef SNPRINTF_RETURNS_BOGUS
 endif
 ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
-	COMPAT_OBJS += compat/fopen.o
+	COMPAT_NOPCH_OBJS += compat/fopen.o
 endif
 ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
@@ -2063,7 +2070,7 @@ ifdef NO_TRUSTABLE_FILEMODE
 endif
 ifdef NEEDS_MODE_TRANSLATION
 	COMPAT_CFLAGS += -DNEEDS_MODE_TRANSLATION
-	COMPAT_OBJS += compat/stat.o
+	COMPAT_NOPCH_OBJS += compat/stat.o
 endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
@@ -2229,7 +2236,7 @@ ifdef SHA1_MAX_BLOCK_SIZE
 endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
-	COMPAT_OBJS += compat/hstrerror.o
+	COMPAT_NOPCH_OBJS += compat/hstrerror.o
 endif
 ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
@@ -2282,7 +2289,7 @@ ifdef UNRELIABLE_FSTAT
 endif
 ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
-	COMPAT_OBJS += compat/regex/regex.o
+	COMPAT_NOPCH_OBJS += compat/regex/regex.o
 else
 ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
@@ -2387,17 +2394,17 @@ endif
 
 ifdef FILENO_IS_A_MACRO
 	COMPAT_CFLAGS += -DFILENO_IS_A_MACRO
-	COMPAT_OBJS += compat/fileno.o
+	COMPAT_NOPCH_OBJS += compat/fileno.o
 endif
 
 ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_CFLAGS += -DNEED_ACCESS_ROOT_HANDLER
-	COMPAT_OBJS += compat/access.o
+	COMPAT_NOPCH_OBJS += compat/access.o
 endif
 
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
-	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_NOPCH_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
@@ -2531,6 +2538,7 @@ endif
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += $(COMPAT_CFLAGS)
+COMPAT_OBJS += $(COMPAT_NOPCH_OBJS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -2912,7 +2920,7 @@ PRECOMPILED_HEADER := tools/precompiled.h
 PRECOMPILED_HEADER_GCH := $(addsuffix .gch,$(PRECOMPILED_HEADER))
 
 ifndef NO_PRECOMPILED_HEADER
-PRECOMPILED_HEADER_USERS := $(filter-out $(COMPAT_OBJS) $(REFTABLE_OBJS) $(patsubst %.c,%.o,$(THIRD_PARTY_SOURCES)),$(OBJECTS))
+PRECOMPILED_HEADER_USERS := $(filter-out $(COMPAT_NOPCH_OBJS) $(REFTABLE_NOPCH_OBJS) $(patsubst %.c,%.o,$(THIRD_PARTY_NOPCH_SOURCES)),$(OBJECTS))
 endif
 
 dep_files := $(foreach f,$(OBJECTS) $(PRECOMPILED_HEADER_GCH),$(dir $f).depend/$(notdir $f).d)
diff --git a/config.mak.uname b/config.mak.uname
index 95ef6e64dc..c51ebadc40 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -152,7 +152,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-	COMPAT_OBJS += compat/precompose_utf8.o
+	COMPAT_NOPCH_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
@@ -535,7 +535,8 @@ endif
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+	COMPAT_NOPCH_OBJS = compat/winansi.o
+	COMPAT_OBJS = compat/msvc.o \
 		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
@@ -735,7 +736,8 @@ ifeq ($(uname_S),MINGW)
 	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+	COMPAT_NOPCH_OBJS += compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/flush.o \
 		compat/win32/path-utils.o \
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 462c1eb5ec..d96a4ebd84 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -101,7 +101,7 @@ project(git
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var makefile regex)
 	file(STRINGS ${makefile} ${list_var} REGEX "^${regex} \\+=(.*)")
-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(REGEX REPLACE "${regex} \\+=" "" ${list_var} ${${list_var}})
 	string(REGEX REPLACE "\\$\\([^)]*_OBJS\\)" "" ${list_var} ${${list_var}}) # remove any "$(*_OBJS)" variables
 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
 	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
@@ -669,7 +669,7 @@ include_directories(${CMAKE_BINARY_DIR})
 parse_makefile_for_sources(libgit_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "LIB_OBJS")
 
 #reftable
-parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_OBJS")
+parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_(|NOPCH_)OBJS")
 list(APPEND libgit_SOURCES ${reftable_SOURCES})
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-- 
2.55.0.1193.g1b994e35de


