Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE0C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHIQyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHIQyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 12:54:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C61FF5
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 09:54:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso60031875e9.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691600089; x=1692204889;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+CF5kC9NsP8TU6vTCfdiLZ+Tv86ESor8az3RR91+Vw=;
        b=UoAapUxftwudgoWkaykUmlSKMCaA1wuNjafLmxlfU1ab7htfcz9D1cqBtsOUeKCeAT
         /M2UHY1352sDt9QM8z3NiNWIWH5MshjAyzYRy2J+Po7IwVOFytvn7mDU1KEge3Amqw2y
         rmXVTc29aFfT55xpTsWO7bjJoP3mFlKX1GbObKnYJh2KGHUbS5+T/7+ETaSfGCxBPPN/
         Rzp2W140AQG2hEaz2LriaxNLbbJlmA1jDK6s6xuctIAQdm/RxtPqYGk+WUZuOVWg/dvk
         ltoinH83TlsPv38vW0r4HSMsq7XJOM2zCxACqU3qz3uYsMbmqRxpiNyWT3hdczFZgSgd
         2xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600089; x=1692204889;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+CF5kC9NsP8TU6vTCfdiLZ+Tv86ESor8az3RR91+Vw=;
        b=EUyD063MsqiFtYVHi9EO1wE16AK2gKe4LZTJKJ9LLar9pSjKOsBiE8I7CEnPeVc7PD
         nIRsfqTBNZTEEwdfTZkAMT1oqxv0IhQHfZqYIz757y5fEYKZeZs+cN2s3Qst0SF5LhFn
         hB+bGastSVWgKoHkoAtSR2TuReY3Gf+hreYAcXZTTgZVguJk2QWwXepNOKP6xwzuOf/u
         Sqjzvs3/YUGFZagzt9ygI117lZZzv4SUfk9hdMaV7kxbkmF8LsRD8PilFNGqabw+kRIS
         jpD2VCCPrXd+aF+dER756XIqhRaxIY8CeqB2J5sR2yCnDFzJgYlV/pLMCPeqSI1FYsJE
         wngQ==
X-Gm-Message-State: AOJu0Yx8T/RhZVoKqpiJY8nyRh0ojKP4wZfPRYfcK/ReJJFjljHx/bD9
        x8ZFEE3IhpTqeDyrmUSvRxorUbJpns0=
X-Google-Smtp-Source: AGHT+IGKr8NDqUqiAdTwOVPxT7UILAD+uscJilSF2mcwEFwBZeV3F9GEz/wILpVYAxeK+e2zsoLRcg==
X-Received: by 2002:adf:f88e:0:b0:317:df4f:4b97 with SMTP id u14-20020adff88e000000b00317df4f4b97mr1997684wrp.7.1691600088896;
        Wed, 09 Aug 2023 09:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b00317a29af4b2sm17200001wrm.68.2023.08.09.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:54:48 -0700 (PDT)
Message-ID: <6192ceef1464c1c54d933ea8b42644a0b224e7f5.1691600087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1570.git.1691600087.gitgitgadget@gmail.com>
References: <pull.1570.git.1691600087.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Aug 2023 16:54:46 +0000
Subject: [PATCH 1/2] win32: add a helper to run `git.exe` without a foreground
 window
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, there are two kinds of executables, console ones and
non-console ones. Git's executables are all console ones.

When launching the former e.g. in a scheduled task, a CMD window pops
up. This is not what we want for the tasks installed via the `git
maintenance` command.

To work around this, let's introduce `headless-git.exe`, which is a
non-console program that does _not_ pop up any window. All it does is to
re-launch `git.exe`, suppressing that console window, passing through
all command-line arguments as-are.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Helped-by: Yuyi Wang <Strawberry_Str@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                                   |   9 ++
 compat/win32/headless.c                    | 115 +++++++++++++++++++++
 config.mak.uname                           |   3 +
 contrib/buildsystems/CMakeLists.txt        |   9 ++
 contrib/buildsystems/Generators/Vcxproj.pm |   4 +-
 contrib/buildsystems/engine.pl             |   1 +
 6 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 compat/win32/headless.c

diff --git a/Makefile b/Makefile
index fb541dedc9f..15b327b72b9 100644
--- a/Makefile
+++ b/Makefile
@@ -2779,6 +2779,13 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
+headless-git.o: compat/win32/headless.c GIT-CFLAGS
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) $(COMPAT_CFLAGS) \
+		-fno-stack-protector -o $@ -c -Wall -Wwrite-strings $<
+
+headless-git$X: headless-git.o git.res GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -mwindows -o $@ $< git.res
+
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
@@ -3652,6 +3659,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
+	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
@@ -3680,6 +3688,7 @@ endif
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
+	$(RM) headless-git.o.pdb
 	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
 	$(RM) $(patsubst %.exe,%.iobj,$(OTHER_PROGRAMS))
 	$(RM) $(patsubst %.exe,%.ipdb,$(OTHER_PROGRAMS))
diff --git a/compat/win32/headless.c b/compat/win32/headless.c
new file mode 100644
index 00000000000..8b00dfe3bd5
--- /dev/null
+++ b/compat/win32/headless.c
@@ -0,0 +1,115 @@
+/*
+ * headless Git - run Git without opening a console window on Windows
+ */
+
+#define STRICT
+#define WIN32_LEAN_AND_MEAN
+#define UNICODE
+#define _UNICODE
+#include <windows.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <wchar.h>
+
+/*
+ * If `dir` contains the path to a Git exec directory, extend `PATH` to
+ * include the corresponding `bin/` directory (which is where all those
+ * `.dll` files needed by `git.exe` are, on Windows).
+ */
+static int extend_path(wchar_t *dir, size_t dir_len)
+{
+	const wchar_t *suffix = L"\\libexec\\git-core";
+	size_t suffix_len = wcslen(suffix);
+	wchar_t *env;
+	DWORD len;
+
+	if (dir_len < suffix_len)
+		return 0;
+
+	dir_len -= suffix_len;
+	if (memcmp(dir + dir_len, suffix, suffix_len * sizeof(wchar_t)))
+		return 0;
+
+	len = GetEnvironmentVariableW(L"PATH", NULL, 0);
+	if (!len)
+		return 0;
+
+	env = _alloca((dir_len + 5 + len) * sizeof(wchar_t));
+	wcsncpy(env, dir, dir_len);
+	wcscpy(env + dir_len, L"\\bin;");
+	if (!GetEnvironmentVariableW(L"PATH", env + dir_len + 5, len))
+		return 0;
+
+	SetEnvironmentVariableW(L"PATH", env);
+	return 1;
+}
+
+int WINAPI wWinMain(_In_ HINSTANCE instance,
+		    _In_opt_ HINSTANCE previous_instance,
+		    _In_ LPWSTR command_line, _In_ int show)
+{
+	wchar_t git_command_line[32768];
+	size_t size = sizeof(git_command_line) / sizeof(wchar_t);
+	const wchar_t *needs_quotes = L"";
+	int slash = 0, i;
+
+	STARTUPINFO startup_info = {
+		.cb = sizeof(STARTUPINFO),
+		.dwFlags = STARTF_USESHOWWINDOW,
+		.wShowWindow = SW_HIDE,
+	};
+	PROCESS_INFORMATION process_info = { 0 };
+	DWORD creation_flags = CREATE_UNICODE_ENVIRONMENT |
+		CREATE_NEW_CONSOLE | CREATE_NO_WINDOW;
+	DWORD exit_code;
+
+	/* First, determine the full path of argv[0] */
+	for (i = 0; _wpgmptr[i]; i++)
+		if (_wpgmptr[i] == L' ')
+			needs_quotes = L"\"";
+		else if (_wpgmptr[i] == L'\\')
+			slash = i;
+
+	if (slash >= size - 11)
+		return 127; /* Too long path */
+
+	/* If it is in Git's exec path, add the bin/ directory to the PATH */
+	extend_path(_wpgmptr, slash);
+
+	/* Then, add the full path of `git.exe` as argv[0] */
+	i = swprintf_s(git_command_line, size, L"%ls%.*ls\\git.exe%ls",
+		       needs_quotes, slash, _wpgmptr, needs_quotes);
+	if (i < 0)
+		return 127; /* Too long path */
+
+	if (*command_line) {
+		/* Now, append the command-line arguments */
+		i = swprintf_s(git_command_line + i, size - i,
+			       L" %ls", command_line);
+		if (i < 0)
+			return 127;
+	}
+
+	startup_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
+	startup_info.hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);
+	startup_info.hStdError = GetStdHandle(STD_ERROR_HANDLE);
+
+	if (!CreateProcess(NULL, /* infer argv[0] from the command line */
+			   git_command_line, /* modified command line */
+			   NULL, /* inherit process handles? */
+			   NULL, /* inherit thread handles? */
+			   FALSE, /* handles inheritable? */
+			   creation_flags,
+			   NULL, /* use this process' environment */
+			   NULL, /* use this process' working directory */
+			   &startup_info, &process_info))
+		return 129; /* could not start */
+	WaitForSingleObject(process_info.hProcess, INFINITE);
+	if (!GetExitCodeProcess(process_info.hProcess, &exit_code))
+		exit_code = 130; /* Could not determine exit code? */
+
+	CloseHandle(process_info.hProcess);
+	CloseHandle(process_info.hThread);
+
+	return (int)exit_code;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 64c44db8058..3bb03f423a0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -526,6 +526,8 @@ else
 endif
 	X = .exe
 
+	EXTRA_PROGRAMS += headless-git$X
+
 compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
@@ -705,6 +707,7 @@ ifeq ($(uname_S),MINGW)
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
 	EXTLIBS += -lntdll
+	EXTRA_PROGRAMS += headless-git$X
 	INSTALL = /bin/install
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4faa419cc3d..6b819e2fbdf 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -738,6 +738,15 @@ if(WIN32)
 	else()
 		message(FATAL_ERROR "Unhandled compiler: ${CMAKE_C_COMPILER_ID}")
 	endif()
+
+	add_executable(headless-git ${CMAKE_SOURCE_DIR}/compat/win32/headless.c)
+	if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
+		target_link_options(headless-git PUBLIC -municode -Wl,-subsystem,windows)
+	elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
+		target_link_options(headless-git PUBLIC /NOLOGO /ENTRY:wWinMainCRTStartup /SUBSYSTEM:WINDOWS)
+	else()
+		message(FATAL_ERROR "Unhandled compiler: ${CMAKE_C_COMPILER_ID}")
+	endif()
 elseif(UNIX)
 	target_link_libraries(common-main pthread rt)
 endif()
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 1a25789d285..b2e68a16715 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -76,7 +76,7 @@ sub createProject {
 
     my $libs_release = "\n    ";
     my $libs_debug = "\n    ";
-    if (!$static_library) {
+    if (!$static_library && $name ne 'headless-git') {
       $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
       $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
@@ -230,7 +230,7 @@ EOM
     print F << "EOM";
   </ItemGroup>
 EOM
-    if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
+    if ((!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') && !($name =~ /headless-git/)) {
       my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
       my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
       my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index ed6c45988a3..069be7e4bef 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -371,6 +371,7 @@ sub handleLinkLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
+        $sourcefile =~ s/^headless-git\.o$/compat\/win32\/headless.c/;
         $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
-- 
gitgitgadget

