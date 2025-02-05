Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CB1FDE00
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781600; cv=none; b=nVnzPKyUGhwAIulPCI0XllknV26mAvOmqJ1LN3T9AEou0Om856oSY+DNHE55BuUeF+KAeeUNyxGcjo+o3yB/F5UwWRLR/XK54c/z7FqI60eznKtJtM+xi/A4gRX9jDdHJgH8ARSLf1lN9DbzDlwElysa6WZiGMiEq+fOvJJkGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781600; c=relaxed/simple;
	bh=z82lKEABdhy/XVCM3hnGNlDTiAeNFAJQZK+zGRDQEDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE8EtUhJi2O8IU90vHQ7SgUUSvwvEGL/6BOVYkothHy6nrQQ2fBhjLH1c7g/WKY5YQHqXBpRGrMUwmPi68ArqlaOmyc/JzQhCkOo2F0+ZgibDA+pik6SGlPT7F+iHgZumbD75outDAjFxQI03WnWcKm9kRmE0Exws4vSSYI4XUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkhI1ECY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkhI1ECY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21634338cfdso3235215ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781598; x=1739386398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqjlURBI5cAHlJR/1iiawUI9AJRgNdM2yNlpAwRwcKA=;
        b=fkhI1ECY7e4A3E4WKEMyFD8kPMBdljOSnWSdc7Sup7HzyxXBlhQs3pociSvQR3zB58
         wkH/Y1KiG3qg/1eFJf049N7tXYZ27dRxl/Q5UDfsgZ2xiTEY67iZrl24sVHUMh7uGlZX
         clBxUfveZWBxc41U6BlmFSppCpSBb02AMm0JbOaISf+hNuYtnNfRAa/mXgrTrI0jL0zz
         4+PH6TxdHwqqRl+q3SaBJBjhX7ZIskVW5Wb1cCylW1kfAbFT9hq5nbwA1MPWZwb3Uu6A
         Wbat+s/nVVK7T50bMc7fQZlz3fhhoCPo1PG+Kgi0ROZMUGHmCl8Be2QtZYtTcj6tDjkd
         1DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781598; x=1739386398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqjlURBI5cAHlJR/1iiawUI9AJRgNdM2yNlpAwRwcKA=;
        b=RpkDzEE3HNZ07EjjNhf5oObcZfgXjYeaW8Ibvl+nH0UP6sSJYc0DyFOmYNwun9+Ctn
         LIAD9QzsVjxiAzBbYj4AGDPpxr8fOQFsNREALsTF0T7Ublku/kKKTUCU626WZ2ymcHWf
         Hi51/vjQ1vSPW3jmdhfHXF9qu+Boy5GxtH6GEVsEkSmwZmwYDwGZuBhZZH1GVUI+NaVv
         Hkk0hHOJPsgP5NgDfgL3W9tTxJN26DO59+qzWSR+2vLMV7h5OforiBVBagvl+oP7H/5c
         BwSVxvA3etviebLg94LKfXfZmteCndWWS5Gs2pG2EPhZvn7X/4kSUACsFbZdskE4+FOT
         4KGw==
X-Gm-Message-State: AOJu0YxtFyEDNjAVeI5F1NIHo17dMdNAsoH/gc0EmwxHlFFIRVt+oKKB
	sQ0LK6UZYsLI7reZTrnyLNll6glzxYRKzNs4TD9u0hYPJtUjNNduQS3jWIT3LSk=
X-Gm-Gg: ASbGncsW07foy1iq+zB367heoK4X2SXQf9Aun9unbHyVbOHPj677cR9lvFe+Mqm4cdx
	Eu98KrswI4V1JlFPgMkXl3Ip855uWxdaefP2ru78d58rAj0fOq8PP2EbuqH+8EmVVpOCQdB2nVw
	h6JFN8q7qF5a+P9ovs3E9tRAHpdfgS0/9f7VFbHu1pMh7ikYHileR3EnngXqHs6EglxMXrf1pX2
	RJihIgFcuhQc3ONqL3QbBWHqmOXoIxRN0Hnkt+pyGv2bqr3vgEcBhNStk0+9/6fHyD3Whj32rw/
	unP8RIaafiVxTEmX+2B4WlWsHFRHIhdRqIdyleOP
X-Google-Smtp-Source: AGHT+IEZCfWPecKa1ibMb2pJPJJoElkcvGY/KDthnz4soj2+gkng3HPltpq0NBbE/EdzRizGF2KlUg==
X-Received: by 2002:a17:902:f649:b0:215:6816:6345 with SMTP id d9443c01a7336-21f17e4d018mr67698895ad.16.1738781597928;
        Wed, 05 Feb 2025 10:53:17 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:53:17 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/6] agent: advertise OS name via agent capability
Date: Thu,  6 Feb 2025 00:22:36 +0530
Message-ID: <20250205185246.111447-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
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

Our current agent capability is in the form of "package/version" (e.g.,
"git/1.8.3.1"). Let's extend it to include the operating system name (os)
i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").

Including OS details in the agent capability simplifies implementation,
maintains backward compatibility, avoids introducing a new capability,
encourages adoption across Git-compatible software, and enhances
debugging by providing complete environment information without affecting
functionality.

Add the `transfer.advertiseOSInfo` config option to address privacy
concerns. It defaults to `true` and can be changed to `false`.
When `true`, both the client and server independently append their
operating system name(os) to the `agent` capability value. The `agent`
capability will now be in form of "package/version os" (e.g.,
"git/1.8.3.1 Linux"). When `false`, the `agent` capability will be
in the form of "package/version" e.g "git/1.8.3.1". The server's
configuration is independent of the client's. Defaults to `true`.
The operating system name is retrieved using the 'sysname' field of
the `uname(2)` system call or its equivalent.

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
 Documentation/config/transfer.txt |  8 +++++++
 Documentation/gitprotocol-v2.txt  | 15 ++++++++-----
 t/t5555-http-smart-common.sh      | 10 ++++++++-
 t/t5701-git-serve.sh              |  9 +++++++-
 t/test-lib-functions.sh           |  8 +++++++
 version.c                         | 37 +++++++++++++++++++++++++++++++
 version.h                         | 15 +++++++++++++
 7 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f1ce50f4a6..1e1dc849ef 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -125,3 +125,11 @@ transfer.bundleURI::
 transfer.advertiseObjectInfo::
 	When `true`, the `object-info` capability is advertised by
 	servers. Defaults to false.
+
+transfer.advertiseOSInfo::
+	When `true`, both the client and server independently append their
+	operating system name (os) to the `agent` capability value. The `agent`
+	capability will now be in form of "package/version os" (e.g.,
+	"git/1.8.3.1 Linux"). When `false`, the `agent` capability will be
+	in the form of "package/version" e.g "git/1.8.3.1". The server's
+	configuration is independent of the client's. Defaults to `true`.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..8fab7d7d52 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -184,11 +184,16 @@ form `agent=X`) to notify the client that the server is running version
 the `agent` capability with a value `Y` (in the form `agent=Y`) in its
 request to the server (but it MUST NOT do so if the server did not
 advertise the agent capability). The `X` and `Y` strings may contain any
-printable ASCII characters except space (i.e., the byte range 32 < x <
-127), and are typically of the form "package/version" (e.g.,
-"git/1.8.3.1"). The agent strings are purely informative for statistics
-and debugging purposes, and MUST NOT be used to programmatically assume
-the presence or absence of particular features.
+printable ASCII characters (i.e., the byte range 32 < x < 127), and are
+typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")
+where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
+be configured using the GIT_USER_AGENT environment variable and it takes
+priority. If `transfer.advertiseOSInfo` is `false` on the server, the server
+omits the `os` from X. If it is `false` on the client, the client omits the
+`os` from `Y`. The `os` is retrieved using the 'sysname' field of the `uname(2)`
+system call or its equivalent. The agent strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to programmatically
+assume the presence or absence of particular features.
 
 ls-refs
 ~~~~~~~
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index e47ea1ad10..140a7f0ffb 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -123,9 +123,17 @@ test_expect_success 'git receive-pack --advertise-refs: v1' '
 '
 
 test_expect_success 'git upload-pack --advertise-refs: v2' '
+	printf "agent=FAKE" >agent_capability &&
+	if test_have_prereq WINDOWS
+	then
+		printf "\n" >>agent_capability &&
+		git config transfer.advertiseOSInfo false
+	else
+		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
+	fi &&
 	cat >expect <<-EOF &&
 	version 2
-	agent=FAKE
+	$(cat agent_capability)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 4c24a188b9..a4c12372f8 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -8,13 +8,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'setup to generate files with expected content' '
-	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_capability &&
+	printf "agent=git/%s" "$(git version | cut -d" " -f3)" >agent_capability &&
 
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
 
+	if test_have_prereq WINDOWS
+	then
+		printf "\n" >>agent_capability &&
+		git config transfer.advertiseOSInfo false
+	else
+		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
+	fi &&
 	cat >expect.base <<-EOF &&
 	version 2
 	$(cat agent_capability)
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab50..3465904323 100644
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
+# correspond to decimal intervals 1-32 and 127-255
+test_redact_non_printables () {
+    tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
+}
diff --git a/version.c b/version.c
index d95221a72a..f0f936a75e 100644
--- a/version.c
+++ b/version.c
@@ -1,9 +1,12 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
 #include "sane-ctype.h"
 #include "gettext.h"
+#include "config.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -43,6 +46,12 @@ const char *git_user_agent_sanitized(void)
 
 		strbuf_addstr(&buf, git_user_agent());
 		redact_non_printables(&buf);
+		/* Add os name if the transfer.advertiseosinfo config is true */
+		if (advertise_os_info()) {
+			/* Add space to space character after git version string */
+			strbuf_addch(&buf, ' ');
+			strbuf_addstr(&buf, os_info_sanitized());
+		}
 		agent = strbuf_detach(&buf, NULL);
 	}
 
@@ -69,3 +78,31 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
+
+const char *os_info_sanitized(void)
+{
+	static const char *os = NULL;
+
+	if (!os) {
+		struct strbuf buf = STRBUF_INIT;
+
+		get_uname_info(&buf, 0);
+		/* Sanitize the os information immediately */
+		redact_non_printables(&buf);
+		os = strbuf_detach(&buf, NULL);
+	}
+
+	return os;
+}
+
+int advertise_os_info(void)
+{
+	static int transfer_advertise_os_info= -1;
+
+	if (transfer_advertise_os_info == -1) {
+		repo_config_get_bool(the_repository, "transfer.advertiseosinfo", &transfer_advertise_os_info);
+		/* enabled by default */
+		transfer_advertise_os_info = !!transfer_advertise_os_info;
+	}
+	return transfer_advertise_os_info;
+}
diff --git a/version.h b/version.h
index 5eb586c0bd..b2325865d7 100644
--- a/version.h
+++ b/version.h
@@ -1,6 +1,8 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+struct repository;
+
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
@@ -14,4 +16,17 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf, unsigned int full);
 
+/*
+  Retrieve, sanitize and cache operating system info for subsequent
+  calls. Return a pointer to the sanitized operating system info
+  string.
+*/
+const char *os_info_sanitized(void);
+
+/*
+  Retrieve and cache transfer.advertiseosinfo config value. Return 1
+  if true, 0 if false.
+*/
+int advertise_os_info(void);
+
 #endif /* VERSION_H */
-- 
2.48.1

