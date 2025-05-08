Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CED20CCC3
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722948; cv=none; b=Omk8wf0Kji4F/Z/uphY/J5EkPW+bE4vC0QhTDzlYZVlGJr9LxB6E2GqU5PjMs24LEH1V8ISuKa9TUTH4SLQLxqhA8LIriTBqRVLQ8EBRy8l5bC3DEfV4k6FvzrQ4pXtmmynjSY3bBZIwI+REkmuweT+vFTAV8Je7/eHHZxvplkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722948; c=relaxed/simple;
	bh=IOxwmTQMfxSJScKMAov3jlXMRuAMAyOZeJfaiT3NF/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9tpmZlqJDFGf5zGCPZ2/vIziiWqPYCJ/9J5B0nI6laYYAYTsZxMhH5qvhTOMvKHlSLwwG/pj5hA5Pm/oOA75rqAuNDBakzSk+su/w+IvC3hJWAgLWJ8XGA1Ox5eBiaYTrxJMF4a2HBj8DHIARC6Qv2On6vGJdaJxUEh5Oy54TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oVrqgQJp; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oVrqgQJp"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NpuuAhG; Thu, 08 May 2025 17:46:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722766; bh=W55Mf13X+4YIm/yYyYoyBzZvPdsZ3WIsp7iEGqldM70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVrqgQJpyL0t83F4iLj8cAj84PsJlOiIxNPIfQpLb+P2xOB1dNySLfa2/aUeNgx6L
	 T1QauIHdqzeON3njvjiUdcvJjMaG1zbEqhqjnUxRkZVtixoeH06Qa0BbX3dDU8/ytA
	 A7QuqH/eKl98tTUzkKjzTf0HP5YQmfUdOwBsoA0vaQicGfC6pYxhjk622BjCyuTWIV
	 5Qp1oo7ji0GUKVbeZgitHmzC/Oq7OuAwaxEmTYqU+7+CerX/0vZGTQqlWTR5UlCPez
	 xKRRHAxvl7MhY0j0fQqqAgOaJn04zg5Tt+gZOOKfm3CBBtfUUgzKIIUUyd6H6bwsmp
	 2CfoZ23Eakwyg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfce
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=tAj7-kSf7k6-pbzrxKMA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH 4/5] meson.build: correct setting of GIT_EXEC_PATH
Date: Thu,  8 May 2025 17:44:38 +0100
Message-ID: <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAJNlPXJLIJ8waNykU2RLM6YeG5HE45yLAYpg4aLSsTazFDnncgOrSZEFsaLbXDG33ypGIgHYgQ2FrUeh1FqCasl+EKk04Z8U6+h8Gtp2fv9NASRN/f4
 gXYjV8vg8hhUdKGDK79XiDa+atyZogJOm8a8Wq4WTLvXykrcQ6HHvSyVK8NUsFnTFtAtG/PSR+TlX5QTXDQ9dQXBV/4ATsbyz18=

For the non-'runtime prefix' case, the meson build sets the GIT_EXEC_PATH
build variable to an absolute path equivalent to <prefix>/libexec/git-core.
In comparison, the default make build sets it to a relative path equivalent
to 'libexec/git-core'. Indeed, the make build requires the use of some
means outside of the Makefile (eg. config.mak[.*] or the command-line)
to set GIT_EXEC_PATH to anything other than 'libexec/git-core'.

For example, the make invocation:

  $ make gitexecdir=/some/other/bin all install

will build git with GIT_EXEC_PATH set to '/some/other/bin' and install
the 'library' executables to that location. However, without setting the
'gitexecdir' make variable, irrespective of the 'runtime prefix' setting,
the GIT_EXEC_PATH is always set to 'libexec/git-core'.

The meson built-in 'libexecdir' option can be used to provide a similar
configurability. The default value for the option is 'libexec'. Attempting
to set the option to '' on the command-line, will reset it to the '.'
string, presumably to ensure a relative path value.

This commit allows the meson build, similar to the above, to configure the
project like:

  $ meson setup --buildtype=debugoptimized -Dprefix=$HOME -Dpcre2=disabled \
      -Dlibexecdir=/some/other/bin build

so that the GIT_EXEC_PATH is set to '/some/other/bin'. Absent the
-Dlibexecdir argument, the GIT_EXEC_PATH is set to 'libexec/git-core'.

In order to correct the value of GIT_EXEC_PATH, default the value to the
static string value 'libexec/git-core', and only override if the value
of the 'libexecdir' option has a value different to 'libexec' or '.'.
Also, like the Makefile, add a check for an absolute path when the
runtime prefix option is true (and if so, error out).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 106cb17612..0101a8179e 100644
--- a/meson.build
+++ b/meson.build
@@ -1590,10 +1590,19 @@ else
   error('Unsupported CSPRNG backend: ' + csprng_backend)
 endif
 
+git_exec_path = 'libexec/git-core'
+libexec = get_option('libexecdir')
+if libexec != 'libexec' and libexec != '.'
+  git_exec_path = libexec
+endif
+
 if get_option('runtime_prefix')
   libgit_c_args += '-DRUNTIME_PREFIX'
   build_options_config.set('RUNTIME_PREFIX', 'true')
-  git_exec_path = get_option('libexecdir') / 'git-core'
+
+  if git_exec_path.startswith('/')
+    error('runtime_prefix requires a relative libexecdir not:', libexec)
+  endif
 
   if compiler.has_header('mach-o/dyld.h')
     libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
@@ -1630,7 +1639,6 @@ if get_option('runtime_prefix')
   endif
 else
   build_options_config.set('RUNTIME_PREFIX', 'false')
-  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
 endif
 libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'
 
-- 
2.49.0

