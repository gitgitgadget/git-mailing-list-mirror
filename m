Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C01FDE0B
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110829; cv=none; b=jIa7BQFUMd2SkEZAkICLpJIpOv8FW+P32wj7PXjaB65TRtegren95NooBRLxgpVczOdZ8HZ11ZBylGweZyn/jQzYfx0Pbbq3BR+aMkWuWtCtxZwgL0r2rSVtajpLNDviBfocHkRAPH1fDoitxKvtaNsP0PyOtCDmdU+9ONVWln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110829; c=relaxed/simple;
	bh=GAhOsT2bW+1PFrxob92ZuOEB88boQLr8cM8qSfrSbjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5U4MC5zZv3WDDBWxzVm9GRmyLbocNXcDhDeMf17djQeCt1Vo6qyxgbi7oKXQXW2TWjPlrGTRhcXNzrlXBpJCBc6/z1jDwZuNZXNgr23M8jRs6AAj9tQi9dQw+3ITVg1TKRQP/4AXkM3mizSjO5Io/IhRvdMUl8/HiEqbJk0jrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVN5CPNn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVN5CPNn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so59097605ad.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110825; x=1737715625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3qqpa/XSfr1Uhz/wwSwiMc7gnqhCsjeSCYz4F6Uu80=;
        b=JVN5CPNnmixuMEG4v3WnZXD/GWa8VDk6v+NUDJQjJZogTz5yne5Ps+dQtkBuUVxQWo
         J/sSBgYdy/J7yPb+/IxR5P1huzYY4vJttfYTyqTnrf3h0r0rynxmun/0FnN+azML68aJ
         Yc+fSUxfJkyi6tcPZE+HoM/glqhUQEYi/KZ/NR0k5jBE2RrUEz15PyDn7be1cxXh+Iip
         R6CaXuKEQdb3A8C8Uu+gzZrjOt94SK5toPNM3ZooWuF1laQql/m7L2j7u04QOZtyAknq
         XUTsCesA1P8LH6VZ6qhv/+l/oqqWlDiPVfBNapT99TC2uyesdl6dT9Y/D2mkQVMldRXU
         rwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110825; x=1737715625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3qqpa/XSfr1Uhz/wwSwiMc7gnqhCsjeSCYz4F6Uu80=;
        b=P+GS/zvTWvW7tf95/ylV8HBlUypI01EdE39mLSICdTDmtmbGoYUbTNb8gqcfyf0UPC
         dt07snfDsFjo7N+3+BrIEtLQ6hZPABK30o12Xz03VMoGLYZ7/CbhhnBMVgJuxkK2auOm
         np7JZnn5/+Y6TXflH9L4Zg8fuCQi9y3glH4Y4tZ9Wv7PEXleu+G0XHwRzBdcK67iK5ga
         aObvp1VLIbddUll86YfuXy3vdbgocswbA6Xj1GnyGlN0BzRqYyQOx2iPDElX9h/lSPjn
         SjetITSOh19rSiOhF2U1lHFNyMKKT0lO9UyCcFF3bbYeDfi0c7Hkq8myie19VjeI73Dq
         DmHw==
X-Gm-Message-State: AOJu0Yyd3xT1mW8PTqdGNybAuMznVYmEhdWqKmI1m50JQiQc8evGjh/9
	52ks2vVvYQ5u3iu2wa7ogRKV1ESl/+4U87h7eoPv68E6IIC2WRmygDkk1OF9RAE=
X-Gm-Gg: ASbGncs6COfrG6xU7Q540IHElSv6H1Q9wKd/ugphpIObn5WQRvJqJSDioi/ofnUvuY5
	/CojN/QbEnMHmfMjX3Ej8cBpb87s2ntaF87G0/y9tRpSATJCoq3qzLZvaz/sPxKJcsBnCUamJwD
	xc4N+PAvnOiAOYvCPmKp76Qh/txqLNTazlyff0ryvBzyVe911134Wel+1tBnmarNZTp+DIJezaB
	mc0Zq7w8TbsNkxgwLM7faXcP6nqFHvflusL/pmpMpTjEVHGJfws057c7AuJWg4F9uzorKaqmMvU
	fYJxgw==
X-Google-Smtp-Source: AGHT+IEnAcHBRtjbfPy9pPoS4o6vxhlPtXBYpWKI+x178PAwGFwhel09NfZwis19UqprhLtsMWxGvg==
X-Received: by 2002:a05:6a00:1d12:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-72db1c5d820mr3316740b3a.8.1737110825303;
        Fri, 17 Jan 2025 02:47:05 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:47:05 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/6] connect: advertise OS version
Date: Fri, 17 Jan 2025 16:16:17 +0530
Message-ID: <20250117104639.65608-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As some issues that can happen with a Git client can be operating system
specific, it can be useful for a server to know which OS a client is
using. In the same way it can be useful for a client to know which OS
a server is using.

Let's introduce a new protocol (`os-version`) allowing Git clients and
servers to exchange operating system information. The protocol is
controlled by the new `transfer.advertiseOSVersion` config option.

Add the `transfer.advertiseOSVersion` config option to address
privacy concerns. It defaults to `true` and can be changed to
`false`. When enabled, this option makes clients and servers send each
other the OS name (e.g., "Linux" or "Windows"). The information is
retrieved using the 'sysname' field of the `uname(2)` system call.

However, there are differences between `uname(1)` (command-line utility)
and `uname(2)` (system call) outputs on Windows. These discrepancies
complicate testing on Windows platforms. For example:
  - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
  .2024-02-14.20:17.UTC.x86_64
  - `uname(2)` output: Windows.10.0.20348

On Windows, uname(2) is not actually system-supplied but is instead
already faked up by Git itself. We could have overcome the test issue
on Windows by implementing a new `uname` subcommand in `test-tool`
using uname(2), but except uname(2), which would be tested against
itself, there would be nothing platform specific, so it's just simpler
to disable the tests on Windows.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/config/transfer.txt |  7 ++++++
 Documentation/gitprotocol-v2.txt  | 18 +++++++++++++
 connect.c                         |  3 +++
 serve.c                           | 14 +++++++++++
 t/t5555-http-smart-common.sh      | 10 +++++++-
 t/t5701-git-serve.sh              | 20 +++++++++++++--
 t/test-lib-functions.sh           |  8 ++++++
 version.c                         | 42 +++++++++++++++++++++++++++++++
 version.h                         | 21 ++++++++++++++++
 9 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f1ce50f4a6..c368a893bd 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -125,3 +125,10 @@ transfer.bundleURI::
 transfer.advertiseObjectInfo::
 	When `true`, the `object-info` capability is advertised by
 	servers. Defaults to false.
+
+transfer.advertiseOSVersion::
+	When `true`, the `os-version` capability is advertised by clients and
+	servers. It makes clients and servers send to each other a string
+	representing the operating system name, like "Linux" or "Windows".
+	This string is retrieved from the `sysname` field of the struct returned
+	by the uname(2) system call. Defaults to true.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..a332b55e4c 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -190,6 +190,24 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
+os-version
+~~~~~~~~~~
+
+In the same way as the `agent` capability above, the server can
+advertise the `os-version` capability to notify the client the
+kind of operating system it is running on. The client may optionally
+send its own `os-version` capability, to notify the server the kind of
+operating system it is also running on in its request to the server
+(but it MUST NOT do so if the server did not advertise the os-version
+capability). The value of this capability may consist of ASCII printable
+characters(from 33 to 126 inclusive) and are typically made from the result of
+`uname -s`(OS name e.g Linux). The os-version capability can be disabled
+entirely by setting the `transfer.advertiseOSVersion` config option
+to `false`. The `os-version` strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to
+programmatically assume the presence or absence of particular
+features.
+
 ls-refs
 ~~~~~~~
 
diff --git a/connect.c b/connect.c
index 10fad43e98..6d5792b63c 100644
--- a/connect.c
+++ b/connect.c
@@ -492,6 +492,9 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (server_supports_v2("os-version") && advertise_os_version(the_repository))
+		packet_write_fmt(fd_out, "os-version=%s", os_version_sanitized());
+
 	if (server_feature_v2("object-format", &hash_name)) {
 		int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
diff --git a/serve.c b/serve.c
index c8694e3751..5b0d54ae9a 100644
--- a/serve.c
+++ b/serve.c
@@ -31,6 +31,16 @@ static int agent_advertise(struct repository *r UNUSED,
 	return 1;
 }
 
+static int os_version_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	if (!advertise_os_version(r))
+		return 0;
+	if (value)
+		strbuf_addstr(value, os_version_sanitized());
+	return 1;
+}
+
 static int object_format_advertise(struct repository *r,
 				   struct strbuf *value)
 {
@@ -123,6 +133,10 @@ static struct protocol_capability capabilities[] = {
 		.name = "agent",
 		.advertise = agent_advertise,
 	},
+	{
+		.name = "os-version",
+		.advertise = os_version_advertise,
+	},
 	{
 		.name = "ls-refs",
 		.advertise = ls_refs_advertise,
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index e47ea1ad10..6f357a005a 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -123,9 +123,17 @@ test_expect_success 'git receive-pack --advertise-refs: v1' '
 '
 
 test_expect_success 'git upload-pack --advertise-refs: v2' '
+	printf "agent=FAKE" >agent_and_osversion &&
+	if test_have_prereq WINDOWS
+	then
+		git config transfer.advertiseOSVersion false
+	else
+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
+	fi &&
+
 	cat >expect <<-EOF &&
 	version 2
-	agent=FAKE
+	$(cat agent_and_osversion)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 0c0a5b2aec..8a783b3924 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -26,10 +26,26 @@ test_expect_success 'setup to generate files with expected content' '
 	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+
+	if test_have_prereq WINDOWS
+	then
+		git config transfer.advertiseOSVersion false
+	else
+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
+	fi &&
+
+	cat >expect_osversion.base <<-EOF
+	version 2
+	$(cat agent_and_osversion)
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	EOF
 '
 
 test_expect_success 'test capability advertisement' '
-	cat expect.base expect.trailer >expect &&
+	cat expect_osversion.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
@@ -357,7 +373,7 @@ test_expect_success 'test capability advertisement with uploadpack.advertiseBund
 	cat >expect.extra <<-EOF &&
 	bundle-uri
 	EOF
-	cat expect.base \
+	cat expect_osversion.base \
 	    expect.extra \
 	    expect.trailer >expect &&
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab50..f7ff38521c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -2007,3 +2007,11 @@ test_trailing_hash () {
 		test-tool hexdump |
 		sed "s/ //g"
 }
+
+# Trim and replace each character with ascii code below 32 or above
+# 127 (included) using a dot '.' character.
+# Octal intervals \001-\040 and \177-\377
+# corresponds to decimal intervals 1-32 and 127-255
+test_redact_non_printables () {
+    tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
+}
diff --git a/version.c b/version.c
index 46835ec83f..ea334c3e9c 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "version-def.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "config.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -69,3 +70,44 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
+
+const char *os_version(void)
+{
+	static const char *os = NULL;
+
+	if (!os) {
+		struct strbuf buf = STRBUF_INIT;
+
+		get_uname_info(&buf, 0);
+		os = strbuf_detach(&buf, NULL);
+	}
+
+	return os;
+}
+
+const char *os_version_sanitized(void)
+{
+	static const char *os_sanitized = NULL;
+
+	if (!os_sanitized) {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, os_version());
+		redact_non_printables(&buf);
+		os_sanitized = strbuf_detach(&buf, NULL);
+	}
+
+	return os_sanitized;
+}
+
+int advertise_os_version(struct repository *r)
+{
+	static int transfer_advertise_os_version = -1;
+
+	if (transfer_advertise_os_version == -1) {
+		repo_config_get_bool(r, "transfer.advertiseosversion", &transfer_advertise_os_version);
+		/* enabled by default */
+		transfer_advertise_os_version = !!transfer_advertise_os_version;
+	}
+	return transfer_advertise_os_version;
+}
diff --git a/version.h b/version.h
index 5eb586c0bd..3e983bc623 100644
--- a/version.h
+++ b/version.h
@@ -1,6 +1,8 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+struct repository;
+
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
@@ -14,4 +16,23 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf, unsigned int full);
 
+/*
+  Retrieve and cache system information for subsequent calls.
+  Return a pointer to the cached system information string.
+*/
+const char *os_version(void);
+
+/*
+  Retrieve system information string from os_version(). Then
+  sanitize and cache it. Return a pointer to the sanitized
+  system information string.
+*/
+const char *os_version_sanitized(void);
+
+/*
+  Retrieve and cache whether os-version capability is enabled.
+  Return 1 if enabled, 0 if disabled.
+*/
+int advertise_os_version(struct repository *r);
+
 #endif /* VERSION_H */
-- 
2.48.0

