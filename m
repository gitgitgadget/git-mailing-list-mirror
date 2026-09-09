Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC23A9631
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981440; cv=none; b=UVsucpUw1N3xlLQ8GWODvAMX2mT6+w0wMXooF8UEpdHW8aLPLvEKtbA9VlpttYOV5dpz1508jE3Z7qoFCp6gCF1JZoZuOeiy6PebK3bVR0dpdfQ7J41eafWko0bitR0gsXZpGfQbEzD5JxZio3NCtR9b7aJAgQGbhYR9hivTh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981440; c=relaxed/simple;
	bh=hwlSZgP4bt5bQgFjzYJ/aPigKzmo/DK1pnSSRtzGclo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dBJq01JKz8iPKw6gKN4MN5fgntyLp7xzOEyNugK7v2TaDYGPNqZF9dSlsEEJwAP8JDQSBfzP0lAArZUDSJ6nCfyGcjw1xFhVmp7bUPaW4JCsvaYg30U9Suy7U6EMTxwBFFr611slp5Vjr9UmxZ8G+tc3IiNpgmqOixwKRnDBmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5HZjdvf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5HZjdvf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6f9e2f681so70192365ad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981438; x=1789586238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uUYU8srPK1poql1EiEeiAk9E/5IPmt2dkSSDhVHmAoQ=;
        b=R5HZjdvfzKDd+Izqh+fFPqIqTVY+cyGa9cNgfnLcThMM0m5EO5broNW7ux0ih4hUXl
         juSM/iuzddNXy1LjMbWRb0DWNLtpXVH7S4vCd33VeBBoB9kbfK5Jg3PezuAQRkfiiwg5
         u7G9muEInhRc95rxz7ZNyjLQiMwA+PuveESgj+kkVCQ04KbGYhjc8fQ+m1AcOjwDxg1s
         5vcvJ8EpbZonuJeAkPx/ehNAy9LYx1qlo2YHNriYk3zOQeLqm4Y85JJCSHHFXG8//qRO
         Dt4YTbzyj9PzFJ+yYMipTsD8CRZXhCXg3KAIXPYidH/4Wkhg+BjVv+zam6VfSIwxEDic
         Ek0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981438; x=1789586238;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUYU8srPK1poql1EiEeiAk9E/5IPmt2dkSSDhVHmAoQ=;
        b=NHakwkV5woIh5jhrsLVDie8aZ3WWnKiIhBaeqTVDNcCPrejKjJvry68SwM0jsRUhnh
         5w11ewSkMPgZ1Fgqw9PRff2wQktEBxZtbrKCmoyvyqgC/A55tPso0IVIgk+MOW8EZKKh
         +tvz7O2XOyGSqE96Q27Rx7RAxsMJuhWAu5wzWeWGldQF24VxDL0KEdzBlpyulIjODsx3
         nMxBwgUPh35ghvefpl+VT/yZefMy+2xUcr7GFAO3ELZSB+5t8jlkQ/xsNpXnt5ltoYaL
         PBlQbsWTv/UkP6o5VtXF24f5TGcsSt0nzQfhns1Fp8YhgXWEMlbzekLqj95UZeS/43Q4
         pooQ==
X-Gm-Message-State: AFuF++mbNgB5KqNlCg8gSI3F4tE2Cr/hxZMwPeFB/7LjPbvpEVY4q2ri
	DW7hvx2sFI8Ume79DjLDGRY4HUVeXPzU887gvKPUebJRMoOcEzllBLVbyUs2+A==
X-Gm-Gg: AYBFou1uNh542A967Zx75D1yWuKxTX1vhIDd9/vEKkNdqD4yNjZ1chgYRPeRff3GKMD
	rJxCcClw/aT+citrQzYGB77JElsvoq0gJALMcHFyAB/Rf7J2BSY+UqgKgJLm1AoQCN1muE9kNem
	92b/Qz7dy6FYrvOBCI6WANPg2YeOu3SsFPlEZNCAC4q8onUe/2PMdOM+nwwC6ZHFkhir9BvRKFK
	/10wVQTxQ6xckpzb8bBLfPYx64vmFmzaX1Re65weayBjJa7jrStG0miUrah6JZ8TyUu5ZCpWrhT
	Mx6t8uePkU8SyL/HPbcB1vlgMsdN7F7Cj8158kcuEfsh3PZDieDj7/JSjRyADWjnys/7vdbOKjV
	Hcy9nV1Rh82xLox9Ho95WDiCeLt9wzDIlgy54X/kBrG3SAXpkSx0B0jUEuL1oBs5COWVhHsLA1B
	GqNZcvzNyisxnhmPj45OySSuq6hC4aVTzqPljnlI7DQyQncRs+dx5jTeWx7EX91cym04CpPW/Q
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-39b26203f11mr57715013a91.16.1788981438234;
        Wed, 09 Sep 2026 12:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm51090741eec.30.2026.09.09.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:17 -0700 (PDT)
Message-Id: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:04 +0000
Subject: [PATCH v3 00/12] Upstream some more Git for Windows' patches
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

When rebasing a Git for Windows commit to enable Rust in Windows CI, I
noticed just how many of the preceding commits touching adjacent code
haven't been upstreamed yet. This patch series rectifies that.

Changes since v2:

 * Moved some hunks that belonged into 12/12 out of 08/12.
 * Dropped a fly-by style cleanup from t0060.

Changes since v1:

 * Fixed the meson-side handling of the MINGW_PREFIX constant (this was not
   noticed in the Git for Windows project because it does not use Meson to
   build the project).

Johannes Schindelin (12):
  mingw: include the Python parts in the build
  mingw: stop hard-coding `CC = gcc`
  mingw: drop the -D_USE_32BIT_TIME_T option
  mingw: only use -Wl,--large-address-aware for 32-bit builds
  mingw: avoid over-specifying `--pic-executable`
  mingw: set the prefix and HOST_CPU as per MSYS2's settings
  mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
  mingw: rely on MSYS2's metadata instead of hard-coding it
  windows: skip linking `git-<command>` for built-ins
  mingw: always define `ETC_*` for MSYS2 environments
  mingw: ensure valid CTYPE
  mingw: allow `git.exe` to be used instead of the "Git wrapper"

 compat/mingw.c                      | 68 +++++++++++++++++++++++++++++
 config.mak.uname                    | 61 ++++++++++++--------------
 contrib/buildsystems/CMakeLists.txt |  9 +++-
 meson.build                         | 15 ++++++-
 meson_options.txt                   |  4 ++
 t/t0060-path-utils.sh               | 30 +++++++++++++
 6 files changed, 151 insertions(+), 36 deletions(-)


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2195%2Fdscho%2Fupstream-some-more-git-for-windows-patches-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2195/dscho/upstream-some-more-git-for-windows-patches-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2195

Range-diff vs v2:

  1:  fd594ffa6c =  1:  fd594ffa6c mingw: include the Python parts in the build
  2:  47fc974582 =  2:  47fc974582 mingw: stop hard-coding `CC = gcc`
  3:  53f1fd5763 =  3:  53f1fd5763 mingw: drop the -D_USE_32BIT_TIME_T option
  4:  ad96aedda6 =  4:  ad96aedda6 mingw: only use -Wl,--large-address-aware for 32-bit builds
  5:  d67201f9b3 =  5:  d67201f9b3 mingw: avoid over-specifying `--pic-executable`
  6:  b49c42c50d =  6:  b49c42c50d mingw: set the prefix and HOST_CPU as per MSYS2's settings
  7:  b00d242621 =  7:  b00d242621 mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
  8:  9de4ea7fc1 !  8:  4cc14553dc mingw: rely on MSYS2's metadata instead of hard-coding it
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       		prefix = $(MINGW_PREFIX)
       		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
       		BASIC_LDFLAGS += -Wl,--pic-executable
     -
     - ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     - 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
     - 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
     - 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
     --				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
     -+				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
     -+	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
     -+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
     -+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
     -+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
     -+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
     -+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW32" MINGW_PREFIX="mingw32")
     -+	endif()
     - 	list(APPEND compat_SOURCES
     - 		compat/mingw.c
     - 		compat/winansi.c
     -
     - ## meson.build ##
     -@@ meson.build: elif host_machine.system() == 'windows'
     - 
     -   libgit_c_args += [
     -     '-DDETECT_MSYS_TTY',
     --    '-DENSURE_MSYSTEM_IS_SET',
     -     '-DNATIVE_CRLF',
     -     '-DNOGDI',
     -     '-DNO_POSIX_GOODIES',
     -@@ meson.build: elif host_machine.system() == 'windows'
     -     '-D__USE_MINGW_ANSI_STDIO=0',
     -   ]
     - 
     -+  msystem = get_option('msystem')
     -+  if msystem != ''
     -+    mingw_prefix = get_option('mingw_prefix')
     -+    if mingw_prefix == ''
     -+      mingw_prefix = msystem.to_lower()
     -+    elif mingw_prefix.startswith('/')
     -+      mingw_prefix = mingw_prefix.substring(1)
     -+    endif
     -+    libgit_c_args += [
     -+      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
     -+      '-DMINGW_PREFIX="' + mingw_prefix + '"'
     -+    ]
     -+  endif
     -+
     -   libgit_dependencies += compiler.find_library('ntdll')
     -   libgit_include_directories += 'compat/win32'
     -   if compiler.get_id() == 'msvc'
     -
     - ## meson_options.txt ##
     -@@ meson_options.txt: option('runtime_prefix', type: 'boolean', value: false,
     -   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
     - option('sane_tool_path', type: 'array', value: [],
     -   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
     -+option('msystem', type: 'string', value: '',
     -+  description: 'Fall-back on Windows when MSYSTEM is not set.')
     -+option('mingw_prefix', type: 'string', value: '',
     -+  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
     - 
     - # Build information compiled into Git and other parts like documentation.
     - option('build_date', type: 'string', value: '',
  9:  60a2999b75 =  9:  19c600cbee windows: skip linking `git-<command>` for built-ins
 10:  1dd6ac9295 = 10:  b8cc067e92 mingw: always define `ETC_*` for MSYS2 environments
 11:  d44d05c897 = 11:  09c90015fb mingw: ensure valid CTYPE
 12:  679d1fdd41 ! 12:  4a4f24a1ba mingw: allow `git.exe` to be used instead of the "Git wrapper"
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       			BASIC_LDFLAGS += -Wl,--large-address-aware
                       endif
      
     - ## t/t0060-path-utils.sh ##
     -@@ t/t0060-path-utils.sh: test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX wor
     - 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
     - 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
     - 	echo HERE >expect &&
     --	test_cmp expect actual'
     -+	test_cmp expect actual
     -+'
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
     + 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
     + 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
     +-				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
     ++				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
     ++	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
     ++		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
     ++	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
     ++		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
     ++	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
     ++		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW32" MINGW_PREFIX="mingw32")
     ++	endif()
     + 	list(APPEND compat_SOURCES
     + 		compat/mingw.c
     + 		compat/winansi.c
     +
     + ## meson.build ##
     +@@ meson.build: elif host_machine.system() == 'windows'
     + 
     +   libgit_c_args += [
     +     '-DDETECT_MSYS_TTY',
     +-    '-DENSURE_MSYSTEM_IS_SET',
     +     '-DNATIVE_CRLF',
     +     '-DNOGDI',
     +     '-DNO_POSIX_GOODIES',
     +@@ meson.build: elif host_machine.system() == 'windows'
     +     '-D__USE_MINGW_ANSI_STDIO=0',
     +   ]
       
     - test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
     - 	git config yes.path "%(prefix)/yes" &&
     ++  msystem = get_option('msystem')
     ++  if msystem != ''
     ++    mingw_prefix = get_option('mingw_prefix')
     ++    if mingw_prefix == ''
     ++      mingw_prefix = msystem.to_lower()
     ++    elif mingw_prefix.startswith('/')
     ++      mingw_prefix = mingw_prefix.substring(1)
     ++    endif
     ++    libgit_c_args += [
     ++      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
     ++      '-DMINGW_PREFIX="' + mingw_prefix + '"'
     ++    ]
     ++  endif
     ++
     +   libgit_dependencies += compiler.find_library('ntdll')
     +   libgit_include_directories += 'compat/win32'
     +   if compiler.get_id() == 'msvc'
     +
     + ## meson_options.txt ##
     +@@ meson_options.txt: option('runtime_prefix', type: 'boolean', value: false,
     +   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
     + option('sane_tool_path', type: 'array', value: [],
     +   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
     ++option('msystem', type: 'string', value: '',
     ++  description: 'Fall-back on Windows when MSYSTEM is not set.')
     ++option('mingw_prefix', type: 'string', value: '',
     ++  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
     + 
     + # Build information compiled into Git and other parts like documentation.
     + option('build_date', type: 'string', value: '',
     +
     + ## t/t0060-path-utils.sh ##
      @@ t/t0060-path-utils.sh: test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works'
       	test_cmp expect actual
       '

-- 
gitgitgadget
