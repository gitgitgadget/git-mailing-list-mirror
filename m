Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712FB672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634723; cv=none; b=DqKP7ICZKcbhGVuZOdRV1GIWSmhKIqAcmbUdtPRq5+6lYoXVLuQxU0scMPaP0oK4Rb23FPMAVRn9fOO8n/HHo44sVBTWmrzDL8TsOwL09VEZ93/hNvZl/F2lbsTrPxUn0H0t381ANMDvNGwoBfnnNy88cbklCJNMIzFIdw38nTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634723; c=relaxed/simple;
	bh=Nus5i8HAvRZpkHEYC8rjbLJKXBb+JtcQom4JdFjl9tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiL1oMTw1oQKWzwa5L0MAqPSIDY2kjIZfoiwP/74MJAE6rgarx0JH+TDTWo2VKNwxic2v6neoK3j9crkFr7otqPquYOwcqNs0PjAyrJtry/lg/F4laUXlaqBj56WdGEJvsVFPr1qK41VpnPTxwW5DB1cR5AyRL4vtBROmlJLInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex4ls2L/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex4ls2L/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so53557555ad.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634721; x=1740239521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02rixjac9xVj86b2mB98Aqwr8CO9Dz9kGZoiaq4BzUk=;
        b=ex4ls2L/jW3B1XR1bXSTa4g4+xVPMgUWiZboBZbnrS+GKmZTXi4w2RnTIHFdswhLdJ
         26e/faozc0r0lYXXnpXKRaXRegLYF5qEop10BpsuFcbtK7Dd/tTzkFU9vey4KkoQu12Z
         zhUYbxo6MeVxkX1m0fxeksEeBAe+m0iyX10PSPLNjiRYaLG2/WDilkmU0R0voPCIdNLm
         8ThbD83UXA47+sPoP2o4CnY0Ko/nLMydg8xZ0LkJ3lYXz66JpUzaWnznUGtDX4p++eI1
         74iNNTDEg1nJ0Q9x+fIZ1Gk37WV5mIasGJKlPxytQEcI8ODB3zpr7abXw3T0M6MYzmEs
         knEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634721; x=1740239521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02rixjac9xVj86b2mB98Aqwr8CO9Dz9kGZoiaq4BzUk=;
        b=K3rwdEzq3EvbDNW2y2q30Y3I+tC7gOCURXSc87PZesNyIzzaEDB0q+AgpPHDR1frP5
         4/NScibw5kVMhQ2W878lCqROIqSI5614tgAx49rn8FbfuchqcgIqpTjdJRO3SoM+LeGB
         Cl71aF/JRf265ex7LJfHxkD2kwJsBnq8VNt69FXkd7yLGcdPeZtfpoDiB9FVAjCXIR67
         LFN6lf1LOJ5SURZH/ArfiQxX5DoY0ZyHc8W6PhsqloldNn5d3KH2v6+xPMCWQWPbBxDN
         o/685DAq1VZFoJDSFBQg7I8DfnwzEF3uoBzEJfLj3B9+xycfoi9xo7KrO50ErizHBxE8
         Jwwg==
X-Forwarded-Encrypted: i=1; AJvYcCWSn+7KjMyF+nBq4WJjx8JAsgylNn4VZR/MDuHElEynvs9NSHCuUp5wj4YoHbypxVTX4vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMSxwzYExTQuva8vu4VzpysZoQ61ICM4r5Rkv9Me7lUB7FNYe
	JCTsu+eUGywZtk6SkODBPQ/xoovLIVVOJ6yMdVB0XhtuTsRq9U9r
X-Gm-Gg: ASbGnctjIvUpo70y6tMU3GGR77cPSXqAvvxtO/268UnU4KY6tESzlSsn7JKiEITDO8P
	/HRcn7Erb2R7yge0l48UuPJztW6Wl+Fla51eo8AsYILf+m73jJj4+21IMQKhLDRFat+uFu/7hXJ
	bPoPTmAk0ZFFeEsl7QJiXR7EYwM0D1iBWZorp71kkKB9eh99949g4M/Z1LrbNCE6w+joWc6AmHp
	PXLCIbBMqVrrCdQtWjXpS0rf/88/AnSjM1OIhRZutUNIJIY63Lo8Qm1nC4V54Thz2R3LPVDo96h
	4ROPsjodNzqaR7r8IC6eaRa+Kru16po3+JOvl8Kw
X-Google-Smtp-Source: AGHT+IHAEmVRT4IU4IojGFPeUDZc8N12nV3VkneWAszgufETEpp/J6Au2/Gnd+MV5TMk2p3r3VHzMg==
X-Received: by 2002:a17:903:2f88:b0:221:331:1d4e with SMTP id d9443c01a7336-22103efedc3mr54927905ad.7.1739634720823;
        Sat, 15 Feb 2025 07:52:00 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:52:00 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 6/6] agent: advertise OS name via agent capability
Date: Sat, 15 Feb 2025 21:20:52 +0530
Message-ID: <20250215155130.1756934-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
 <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
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
i.e in the form "package/version-os" (e.g., "git/1.8.3.1-Linux").

Including OS details in the agent capability simplifies implementation,
maintains backward compatibility, avoids introducing a new capability,
encourages adoption across Git-compatible software, and enhances
debugging by providing complete environment information without affecting
functionality. The operating system name is retrieved using the 'sysname'
field of the `uname(2)` system call or its equivalent.

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
 Documentation/gitprotocol-v2.txt | 13 ++++++++-----
 connect.c                        |  2 +-
 t/t5701-git-serve.sh             | 16 +++++++++++++++-
 t/test-lib-functions.sh          |  8 ++++++++
 version.c                        | 29 ++++++++++++++++++++++++++++-
 version.h                        |  3 +++
 6 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..ce4a4e5e3b 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -184,11 +184,14 @@ form `agent=X`) to notify the client that the server is running version
 the `agent` capability with a value `Y` (in the form `agent=Y`) in its
 request to the server (but it MUST NOT do so if the server did not
 advertise the agent capability). The `X` and `Y` strings may contain any
-printable ASCII characters except space (i.e., the byte range 32 < x <
-127), and are typically of the form "package/version" (e.g.,
-"git/1.8.3.1"). The agent strings are purely informative for statistics
-and debugging purposes, and MUST NOT be used to programmatically assume
-the presence or absence of particular features.
+printable ASCII characters (i.e., the byte range 33 <= x <= 126), and are
+typically of the form "package/version-os" (e.g., "git/1.8.3.1-Linux")
+where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
+be configured using the GIT_USER_AGENT environment variable and it takes
+priority. The `os` is retrieved using the 'sysname' field of the `uname(2)`
+system call or its equivalent. The agent strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to programmatically
+assume the presence or absence of particular features.
 
 ls-refs
 ~~~~~~~
diff --git a/connect.c b/connect.c
index 10fad43e98..4d85479075 100644
--- a/connect.c
+++ b/connect.c
@@ -625,7 +625,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, s
 					*offset = found + len - orig_start;
 				return value;
 			}
-			/* feature with a value (e.g., "agent=git/1.2.3") */
+			/* feature with a value (e.g., "agent=git/1.2.3-Linux") */
 			else if (*value == '=') {
 				size_t end;
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 4c24a188b9..678a346ed0 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -8,13 +8,19 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
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
+		printf "agent=FAKE\n" >agent_capability
+	else
+		printf -- "-%s\n" $(uname -s | test_redact_non_printables) >>agent_capability
+	fi &&
 	cat >expect.base <<-EOF &&
 	version 2
 	$(cat agent_capability)
@@ -31,6 +37,10 @@ test_expect_success 'setup to generate files with expected content' '
 test_expect_success 'test capability advertisement' '
 	cat expect.base expect.trailer >expect &&
 
+	if test_have_prereq WINDOWS
+	then
+		GIT_USER_AGENT=FAKE && export GIT_USER_AGENT
+	fi &&
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
@@ -361,6 +371,10 @@ test_expect_success 'test capability advertisement with uploadpack.advertiseBund
 	    expect.extra \
 	    expect.trailer >expect &&
 
+	if test_have_prereq WINDOWS
+	then
+		GIT_USER_AGENT=FAKE && export GIT_USER_AGENT
+	fi &&
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
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
index d95221a72a..8e927cf1eb 100644
--- a/version.c
+++ b/version.c
@@ -1,8 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
-#include "sane-ctype.h"
 #include "gettext.h"
 
 const char git_version_string[] = GIT_VERSION;
@@ -34,6 +35,27 @@ const char *git_user_agent(void)
 	return agent;
 }
 
+/*
+  Retrieve, sanitize and cache operating system info for subsequent
+  calls. Return a pointer to the sanitized operating system info
+  string.
+*/
+static const char *os_info(void)
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
 const char *git_user_agent_sanitized(void)
 {
 	static const char *agent = NULL;
@@ -42,6 +64,11 @@ const char *git_user_agent_sanitized(void)
 		struct strbuf buf = STRBUF_INIT;
 
 		strbuf_addstr(&buf, git_user_agent());
+
+		if (!getenv("GIT_USER_AGENT")) {
+			strbuf_addch(&buf, '-');
+			strbuf_addstr(&buf, os_info());
+		}
 		redact_non_printables(&buf);
 		agent = strbuf_detach(&buf, NULL);
 	}
diff --git a/version.h b/version.h
index 5eb586c0bd..bbde6d371a 100644
--- a/version.h
+++ b/version.h
@@ -1,6 +1,8 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+struct repository;
+
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
@@ -14,4 +16,5 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf, unsigned int full);
 
+
 #endif /* VERSION_H */
-- 
2.48.1

