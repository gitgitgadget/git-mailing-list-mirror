Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2D19E7EB
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159854; cv=none; b=tRtudEgG/VgAxgStzk+sFXCDjm2rXFnHHF5QaaGSvCp4A3tdZj08s/wPUfheMQBXCIpyHWO9uORTyMIgrC3vn2s0xAXLSzZotHXVish7Ue7KSae85oOEWf+c7ES0cC3+qhDfCW9FqBu1G+PtIN2Y2sJ35YLlBlbT1oSfkOoWuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159854; c=relaxed/simple;
	bh=YYFQTvpqSN7W/kRXejV0+UFuwkTyx1M9IOZUgZa70mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbJtUc/X0I8U7jz3Kn4hova6nnep4PFrBeyFwdJZIltzdoCzuhgRJF1Ftzr3mpr6CYNb1OV2X9xoSb/90beDmuViEjYtR/sUXSw66A1NG4El4/sONNJHMdXZtxoSdfT9wnNzW3boiUv2b2+rmpmwb8stFVEXdtsM/f0y25bL09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPo8ZfT5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPo8ZfT5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so177632055ad.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 02:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736159850; x=1736764650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE5ihcAJ+Kpt1lJIv9WzWk7McPwII/sW/F0fTCVn8IU=;
        b=JPo8ZfT56gnepAnoOff/pz3n6qBSj7EUNPz+73AOXIp1JOJpdf1Ks82h2YDiKNQF3T
         uSqtNP1C5Mx19aV9/zasoxteWiBM/71Ba2HVjjbZCGgPiPPfQQSwLYkj7nUDx4r87Sb8
         z1XJARKbPMZWcYzMhZXIGPmd5FLqNPC0fYTUCifDBo5a4NQHMfFpy64wW0B4KixdQlrk
         +iZSPeQxuUXMcBoSM6j0A4/bwrbCdlK1ybU89xoJ2kyne4A9fMuw6fWKH889TuuIso2i
         thGefrfQ02ji64NCpGUFyLvBDAQMLyjEa5MS2iHk33xyntrKoz1md42Pi59IxeFA1HZ+
         ujEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159850; x=1736764650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE5ihcAJ+Kpt1lJIv9WzWk7McPwII/sW/F0fTCVn8IU=;
        b=cChcUL7lNVj7Ojhyb+GRjN14mO+6qGagC2tjezyX0HCb5QPLfD3JSGjIleI3vG902s
         kMSJwIALa+mp0JZLb5mcgMrzB/hsdT1aaMhztcAAmKX0otVDrn3CJ5++GbRg37CFW2Vm
         DzLoLc0JS38b7LBt+Gz8LOH6Dq1sL36ZasnkMpRttR4jR+nNasgyv6DUuVowpOxcfvjH
         lZp2oYq0T/U+dZvBPQA5XwP2R3yaNeg6B3B6HRqdB4rCx5acIOOa282X2bllWU+ArAOn
         uj1ImpwUpakH+nGzNgAT9uFVBxUWAtf2gsnjm2lL6apu4xijTSu0izZoE0TMAU5Ket+n
         dddg==
X-Gm-Message-State: AOJu0YzWQuCUUNtAuT4/FR2LeeAAK+akX/a1Rm6aQNh2T+ffzaUmsYfy
	0Fhle/jdVxXcF0yi5W6ou8cE4bjBta3Dgs3E4DjKDxqFv8cXOcnRQXBpA6wpwU4=
X-Gm-Gg: ASbGncsyqkI152cRmbNx85tTSBxidaXhBVuLu8FjAvhGAnBC1BRsoRQF2yzcr4pAOCH
	LYnvzwpYMja6zEwgzOenXbstoFPfc8k6EK56tBvDfE7/RfcgwWvNExEalFCitrI/qT8xJlXdjif
	NCtEapsuKYjo/e/Bg2wUTbQzNG4ee7XE0Lk8NO/etggezKjyCFokRSJCG3mTp//49n+OqfGiS/Z
	ufxs9N/H/E3fbt/zQIomgAknDgVOBNFB3QDbOpx4I+Ore+kYfO5viDw2PCgf/HRBbdWAJxeo9Dx
	w+VspA==
X-Google-Smtp-Source: AGHT+IFDY3mSKUo88TmmHq7DVjOJAQQ+Pkb6F6H6e9CZUEAELdTMHxVNDx6+u/Jr2VTjUDmqVrQRAw==
X-Received: by 2002:a05:6a00:414a:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-72abde0f264mr73969785b3a.15.1736159850554;
        Mon, 06 Jan 2025 02:37:30 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm28774281a12.43.2025.01.06.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:37:30 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] connect: advertise OS version
Date: Mon,  6 Jan 2025 16:00:51 +0530
Message-ID: <20250106103713.1452035-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
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
privacy concerns issue. It defaults to `true` and can be changed to
`false`. When enabled, this option makes clients and servers send each
other the OS name (e.g., "Linux" or "Windows"). The information is
retrieved using the 'sysname' field of the `uname(2)` system call.

However, there are differences between `uname(1)` (command-line utility)
and `uname(2)` (system call) outputs on Windows. These discrepancies
complicate testing on Windows platforms. For example:
  - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
  .2024-02-14.20:17.UTC.x86_64
  - `uname(2)` output: Windows.10.0.20348

Until a good way to test the feature on Windows is found, the
transfer.advertiseOSVersion is set to false on Windows during testing.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/config/transfer.txt |  7 ++++++
 Documentation/gitprotocol-v2.txt  | 20 +++++++++++++++
 connect.c                         |  3 +++
 serve.c                           | 14 +++++++++++
 t/t5555-http-smart-common.sh      | 12 ++++++++-
 t/t5701-git-serve.sh              | 12 ++++++++-
 t/test-lib-functions.sh           |  8 ++++++
 version.c                         | 42 +++++++++++++++++++++++++++++++
 version.h                         |  6 +++++
 9 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f1ce50f4a6..e2d95d1ccd 100644
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
+	This string is retrieved from the 'sysname' field of the struct returned
+	by the uname(2) system call. Defaults to true.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..c28262c60b 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -190,6 +190,26 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
+os-version
+~~~~~~~~~~
+
+In the same way as the `agent` capability above, the server can
+advertise the `os-version` capability with a value `X` (in the form
+`os-version=X`) to notify the client that the server is running an
+operating system that can be identified by `X`. The client may
+optionally send its own `os-version` string by including the
+`os-version` capability with a value `Y` (in the form `os-version=Y`)
+in its request to the server (but it MUST NOT do so if the server did
+not advertise the os-version capability). The `X` and `Y` strings may
+contain any printable ASCII characters except space (i.e., the byte
+range 32 < x < 127), and are typically made from the result of
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
index e47ea1ad10..f9e2a66cba 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -123,9 +123,19 @@ test_expect_success 'git receive-pack --advertise-refs: v1' '
 '
 
 test_expect_success 'git upload-pack --advertise-refs: v2' '
+	printf "agent=FAKE" >agent_and_os_name &&
+	if test_have_prereq WINDOWS
+	then
+		# We do not use test_config here so that any tests below can reuse
+		# the "expect" file from this test
+		git config transfer.advertiseOSVersion false
+	else
+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_os_name
+	fi &&
+
 	cat >expect <<-EOF &&
 	version 2
-	agent=FAKE
+	$(cat agent_and_os_name)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index de904c1655..f4668b7acd 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -8,13 +8,23 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_os_name &&
+	if test_have_prereq WINDOWS
+	then
+		# We do not use test_config here so that tests below will be able to reuse
+		# the expect.base and expect.trailer files
+		git config transfer.advertiseOSVersion false
+	else
+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_os_name
+	fi &&
+
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
 	cat >expect.base <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	$(cat agent_and_os_name)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab50..447c698d74 100644
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
+    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
+}
diff --git a/version.c b/version.c
index 44ffc4dd57..8242baf41c 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "version-def.h"
 #include "strbuf.h"
 #include "gettext.h"
+#include "config.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -70,3 +71,44 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
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
index 5eb586c0bd..8167ce956a 100644
--- a/version.h
+++ b/version.h
@@ -1,6 +1,8 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+struct repository;
+
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
@@ -14,4 +16,8 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf, unsigned int full);
 
+const char *os_version(void);
+const char *os_version_sanitized(void);
+int advertise_os_version(struct repository *r);
+
 #endif /* VERSION_H */
-- 
2.47.1

