Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0A3B14D4
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020350; cv=none; b=bC/fvjmF+ig++KKBdtKncs4xKdVhOErX2t0aEP8Lf1TqJgauDvA57sljc0J5V1fmNG5pjLSQrf5S5Y8nu7jkeYRJ6y9xiGa3CEEXphS6IpvuPAu76ANXFpz9nUzzHHLiz++Vnk3BAwN6JYfRRnN9d04ZBhocSkl9EotFZveKHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020350; c=relaxed/simple;
	bh=AiT7qG4p4aMc5wc6/G/wx5hBSd6++8jxuxFzdhEwZ8Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XwAu4QkYRue28rhGmWYge1G715YVOwxmGcyuBkSmW/AvlgVUWc698pvUrE0pCaUteVkhbgE3xdmSJA+UqcqLpmj1zex5k2OpymRhgv+AM6TQvigbKdG4MMFXNasBggoAlXzB8uQc2Q2+kJMKaRiIzXCvEsZM8vqeNbvzau7UJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/fX/vhB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/fX/vhB"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79fbso7545395ad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020346; x=1789625146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IqZ5JXhA9vzdVaeMT+EVRUigB9fwSino4GpIzqK47dI=;
        b=H/fX/vhBh4VY2Nj3Wf/D9p5d8UseWkDgG/c3Dj+LpX73JZSZrUgQw95V+eL+UAH31x
         gbk08vZpI+oadjTK46U3iSfcdNCimfZ/6aXNH1hf+FK5z8xQXzP42lNCb2LAna+2VfUe
         d5++wmdCKpQPFnRof75DB+w9l5hH8f4b5Ii3grD6jIlJfqz8dmltpzUrDCn3AVR2Xn7O
         GnEM5NbQLhgfxMT6Et/QCY5ol/7AyjQO3y3j76YqXFfe0bTspMnBX9MrIs7T4uMoPIPG
         YgBYnlkRzc1cmB1+9LO+kci3EIRumIA79fPZS0c7eEUnq8ojoiUUpxsPZY9ihfJJOSme
         QM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020346; x=1789625146;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqZ5JXhA9vzdVaeMT+EVRUigB9fwSino4GpIzqK47dI=;
        b=Z/Zvh8MEG1Se8C86ZWjvoONo4VkVbJVbA1mVtfy1F/6FUbHYZB/PJnyNzt6pfdIkvP
         vlqUYbMDIoriOnOw7+m7+TicJHGBEua546toajkWWCmQ7U+5o2LBRvTi27P8AdJ2fTIV
         T8UL80WrfU+90Dn0ACkG7TShlUGoM4Y7Cd70DB0YK+2kX51OEDsFzIOkioyfR0Q2J/BV
         25RY6IMQmFq7q9N5Vo3xxJfJIXgGlgCtlzEWXOMnlASHDfAUWrKxk1mbXkh/VxzinzwM
         l/TqCCx4D7sIMV1Zw6SX+fYBWpXUxZNw5gZUbCvl4+2Yy6oTmIT78oU2oPcsIMKuzpzH
         We5w==
X-Gm-Message-State: AFuF++n0+02mweT6Ib7srsmmX+FLqEwxDLKfttb9s83puA6P/VWr/033
	4cRrBjzFCcWMkWwnLxWZ8XZvpPSaD5BpbCtUoHyS6K9Xlvgnmnr7lUyIxJtTag==
X-Gm-Gg: AYBFou2raRZ4jbI61q9sP/ZUdsIfqX6+KwYK8y4izDkFKztGZlpX0G7Z3l/phGMIVxF
	30yYHc8Yp4VyBYbOwqS65wtbqS1VLG4qMJth8NjltOgrHFdIAP2VCydCCsZ74aPVyQvgRQHmCYg
	jcW8bVBW5A4VFtF6xRxFtqBjEDtO8Y6VbpTZs7sEeDr7ETm+N0MC5wmzVeb1pEPNL5oYul4zUkn
	war2sXhcwCYpYeVEdGYgXqD4qW0SVajYMWJrcHiOFSy3P153juQUIrtVfP65l2/YxTvKYGqI/Pa
	pOV9+izYr7cGnmBM3gvLyqQxlsgm5v403itYAWzLxho9f/imiQdf9xYNBsfzHsBNUgokRge1iSp
	vqxHaXAUWxLZmImJDFQE4PYVrWQ1d3/UcL4KfcSJ9CD+8ZqAm5HxNSlw9Xg+TLmBgTdqtY6mDex
	wFc3xiAodpxRVz+iC9o9gi1tsZbyaTND50KjBvOVvgKsUxPccynhPVRPRPV4dqwaH+jmKQyITW
X-Received: by 2002:a17:90b:50ce:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39d70a33425mr8732060a91.6.1789020346402;
        Wed, 09 Sep 2026 23:05:46 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm51614619eec.27.2026.09.09.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:45 -0700 (PDT)
Message-Id: <e8115c158cad58f4a4d59d2572a2c3343c513460.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:26 +0000
Subject: [PATCH v4 12/13] mingw: allow `git.exe` to be used instead of the
 "Git wrapper"
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows wants to add `git.exe` to the users' `PATH`, without
cluttering the latter with unnecessary executables such as `wish.exe`.
To that end, it invented the concept of its "Git wrapper", i.e. a tiny
executable located in `C:\Program Files\Git\cmd\git.exe` (originally a
CMD script) whose sole purpose is to set up a couple of environment
variables and then spawn the _actual_ `git.exe` (which nowadays lives in
`C:\Program Files\Git\mingw64\bin\git.exe` for 64-bit, and the obvious
equivalent for 32-bit installations).

Currently, the following environment variables are set unless already
initialized:

- `MSYSTEM`, to make sure that the MSYS2 Bash and the MSYS2 Perl
  interpreter behave as expected, and

- `PLINK_PROTOCOL`, to force PuTTY's `plink.exe` to use the SSH
  protocol instead of Telnet,

- `PATH`, to make sure that the `bin` folder in the user's home
  directory, as well as the `/mingw64/bin` and the `/usr/bin`
  directories are included. The trick here is that the `/mingw64/bin/`
  and `/usr/bin/` directories are relative to the top-level installation
  directory of Git for Windows (which the included Bash interprets as
  `/`, i.e. as the MSYS pseudo root directory).

Using the absence of `MSYSTEM` as a tell-tale, we can detect in
`git.exe` whether these environment variables have been initialized
properly. Therefore we can call `C:\Program Files\Git\mingw64\bin\git`
in-place after this change, without having to call Git through the Git
wrapper.

Obviously, above-mentioned directories must be _prepended_ to the `PATH`
variable, otherwise we risk picking up executables from unrelated Git
installations. We do that by constructing the new `PATH` value from
scratch, appending `$HOME/bin` (if `HOME` is set), then the MSYS2 system
directories, and then appending the original `PATH`.

Side note: this modification of the `PATH` variable is independent of
the modification necessary to reach the executables and scripts in
`/mingw64/libexec/git-core/`, i.e. the `GIT_EXEC_PATH`. That
modification is still performed by Git, elsewhere, long after making the
changes described above.

While we _still_ cannot simply hard-link `mingw64\bin\git.exe` to `cmd`
(because the former depends on a couple of `.dll` files that are only in
`mingw64\bin`, i.e. calling `...\cmd\git.exe` would fail to load due to
missing dependencies), at least we can now avoid that extra process of
running the Git wrapper (which then has to wait for the spawned
`git.exe` to finish) by calling `...\mingw64\bin\git.exe` directly, via
its absolute path.

Testing this is in Git's test suite tricky: we set up a "new" MSYS
pseudo-root and copy the `git.exe` file into the appropriate location,
then verify that `MSYSTEM` is set properly, and also that the `PATH` is
modified so that scripts can be found in `$HOME/bin`, `/mingw64/bin/`
and `/usr/bin/`.

This addresses https://github.com/git-for-windows/git/issues/2283

Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
as before, and introduces an `msystem' and `mingw-prefix` knob for Meson
(read: neither CMake nor Meson will automatically inherit the setting
from the current build environment).

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c                      | 65 +++++++++++++++++++++++++++++
 config.mak.uname                    |  8 +++-
 contrib/buildsystems/CMakeLists.txt |  9 +++-
 meson.build                         | 15 ++++++-
 meson_options.txt                   |  4 ++
 t/t0060-path-utils.sh               | 30 +++++++++++++
 6 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index afdc1ef2db..563e6299bc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3134,6 +3134,45 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 	return -1;
 }
 
+#ifdef ENSURE_MSYSTEM_IS_SET
+#if !defined(RUNTIME_PREFIX) || !defined(HAVE_WPGMPTR) || !defined(MINGW_PREFIX)
+static size_t append_system_bin_dirs(char *path UNUSED, size_t size UNUSED)
+{
+	return 0;
+}
+#else
+static size_t append_system_bin_dirs(char *path, size_t size)
+{
+	char prefix[32768];
+	const char *slash;
+	size_t len = xwcstoutf(prefix, _wpgmptr, sizeof(prefix)), off = 0;
+
+	if (len == 0 || len >= sizeof(prefix) ||
+	    !(slash = find_last_dir_sep(prefix)))
+		return 0;
+	/* strip trailing `git.exe` */
+	len = slash - prefix;
+
+	/* strip trailing `cmd` or `<mingw-prefix>\bin` or `bin` or `libexec\git-core` */
+	if (strip_suffix_mem(prefix, &len, "\\" MINGW_PREFIX "\\libexec\\git-core") ||
+	    strip_suffix_mem(prefix, &len, "\\" MINGW_PREFIX "\\bin"))
+		off += xsnprintf(path + off, size - off,
+				 "%.*s\\" MINGW_PREFIX "\\bin;", (int)len, prefix);
+	else if (strip_suffix_mem(prefix, &len, "\\cmd") ||
+		 strip_suffix_mem(prefix, &len, "\\bin") ||
+		 strip_suffix_mem(prefix, &len, "\\libexec\\git-core"))
+		off += xsnprintf(path + off, size - off,
+				 "%.*s\\" MINGW_PREFIX "\\bin;", (int)len, prefix);
+	else
+		return 0;
+
+	off += xsnprintf(path + off, size - off,
+			 "%.*s\\usr\\bin;", (int)len, prefix);
+	return off;
+}
+#endif
+#endif
+
 static void setup_windows_environment(void)
 {
 	char *tmp = getenv("TMPDIR");
@@ -3186,6 +3225,32 @@ static void setup_windows_environment(void)
 			setenv("HOME", tmp, 1);
 	}
 
+	if (!getenv("PLINK_PROTOCOL"))
+		setenv("PLINK_PROTOCOL", "ssh", 0);
+
+#ifdef ENSURE_MSYSTEM_IS_SET
+	if (!(tmp = getenv("MSYSTEM")) || !tmp[0]) {
+		const char *home = getenv("HOME"), *path = getenv("PATH");
+		char buf[32768];
+		size_t off = 0;
+
+		setenv("MSYSTEM", ENSURE_MSYSTEM_IS_SET, 1);
+
+		if (home)
+			off += xsnprintf(buf + off, sizeof(buf) - off,
+					 "%s\\bin;", home);
+		off += append_system_bin_dirs(buf + off, sizeof(buf) - off);
+		if (path)
+			off += xsnprintf(buf + off, sizeof(buf) - off,
+					 "%s", path);
+		else if (off > 0)
+			buf[off - 1] = '\0';
+		else
+			buf[0] = '\0';
+		setenv("PATH", buf, 1);
+	}
+#endif
+
 	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
 		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
diff --git a/config.mak.uname b/config.mak.uname
index 2f7d445eb3..0b63be10b7 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -535,7 +535,9 @@ endif
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
+		-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" -DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\"" \
+		-DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	# invalidcontinue.obj allows Git's source code to close the same file
 	# handle twice, or to access the osfhandle of an already-closed stdout
@@ -758,7 +760,9 @@ ifeq ($(uname_S),MINGW)
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-		COMPAT_CFLAGS += -DDETECT_MSYS_TTY
+		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
+			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
+			-DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\""
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b464f..7285bd9ac2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -256,7 +256,14 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
-				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
+				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
+	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW32" MINGW_PREFIX="mingw32")
+	endif()
 	list(APPEND compat_SOURCES
 		compat/mingw.c
 		compat/winansi.c
diff --git a/meson.build b/meson.build
index 7073d5844d..a8aba81e29 100644
--- a/meson.build
+++ b/meson.build
@@ -1318,7 +1318,6 @@ elif host_machine.system() == 'windows'
 
   libgit_c_args += [
     '-DDETECT_MSYS_TTY',
-    '-DENSURE_MSYSTEM_IS_SET',
     '-DNATIVE_CRLF',
     '-DNOGDI',
     '-DNO_POSIX_GOODIES',
@@ -1328,6 +1327,20 @@ elif host_machine.system() == 'windows'
     '-D__USE_MINGW_ANSI_STDIO=0',
   ]
 
+  msystem = get_option('msystem')
+  if msystem != ''
+    mingw_prefix = get_option('mingw_prefix')
+    if mingw_prefix == ''
+      mingw_prefix = msystem.to_lower()
+    elif mingw_prefix.startswith('/')
+      mingw_prefix = mingw_prefix.substring(1)
+    endif
+    libgit_c_args += [
+      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
+      '-DMINGW_PREFIX="' + mingw_prefix + '"'
+    ]
+  endif
+
   libgit_dependencies += compiler.find_library('ntdll')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
diff --git a/meson_options.txt b/meson_options.txt
index dc88f130d7..becf4689bf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -21,6 +21,10 @@ option('runtime_prefix', type: 'boolean', value: false,
   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
 option('sane_tool_path', type: 'array', value: [],
   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
+option('msystem', type: 'string', value: '',
+  description: 'Fall-back on Windows when MSYSTEM is not set.')
+option('mingw_prefix', type: 'string', value: '',
+  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
 
 # Build information compiled into Git and other parts like documentation.
 option('build_date', type: 'string', value: '',
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 8545cdfab5..02906055d3 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -611,4 +611,34 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works'
 	test_cmp expect actual
 '
 
+test_expect_success MINGW,RUNTIME_PREFIX 'MSYSTEM/PATH is adjusted if necessary' '
+	if test -z "$MINGW_PREFIX"
+	then
+		MINGW_PREFIX="/$(echo "${MSYSTEM:-MINGW64}" | tr A-Z a-z)"
+	fi &&
+	mkdir -p "$HOME"/bin pretend"$MINGW_PREFIX"/bin \
+		pretend"$MINGW_PREFIX"/libexec/git-core pretend/usr/bin &&
+	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/bin/ &&
+	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/libexec/git-core/ &&
+	# copy the .dll files, if any (happens when building via CMake)
+	if test -n "$(ls "$GIT_EXEC_PATH"/*.dll 2>/dev/null)"
+	then
+		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/bin/ &&
+		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/libexec/git-core/
+	fi &&
+	echo "env | grep MSYSTEM=" | write_script "$HOME"/bin/git-test-home &&
+	echo "echo ${MINGW_PREFIX#/}" | write_script pretend"$MINGW_PREFIX"/bin/git-test-bin &&
+	echo "echo usr" | write_script pretend/usr/bin/git-test-bin2 &&
+
+	(
+		MSYSTEM= &&
+		GIT_EXEC_PATH= &&
+		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-home >actual &&
+		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-bin >>actual &&
+		pretend"$MINGW_PREFIX"/bin/git.exe test-bin2 >>actual
+	) &&
+	test_write_lines MSYSTEM=$MSYSTEM "${MINGW_PREFIX#/}" usr >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

