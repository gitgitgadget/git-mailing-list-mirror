Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BF261567
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536688; cv=none; b=rGCOGsirXYuxdtpvRCc2A7jXIkz5JFv2RPVGqtKBXKcHoadd/8D4t4iyzuxyWsFIY8DAqhrcRbmBcW4HlB1JpKkshW6SdGgXHe6qJxaweRwwO1A+34yI8v+RmvnNy5k89RqJbXRU4Gbm41gB0gzPb9vdxS3WX5+a7y9pZ/59EM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536688; c=relaxed/simple;
	bh=cZCsJbKV44wNeeDhMqFj7Ji/afYTEqUgmHdChGuznYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkXkMg7RybFypYL7L918JQg5wUHtEDHXd3n2wwkrnySe73EcqbU2+itQLP5sBK7jaMb30Dcg0Ek2TgE3Lz3GiTeCLMQxU9xtBS97rCyUvLsxt4aeM3vH2tN4ou6ZemmdUQwRLWa3roteT+u8jEZvEMZV9yTioTHG9JTH2qqT5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byVpy/qH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byVpy/qH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f3c119fe6so46874865ad.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536686; x=1740141486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMhluq5TYdN6ZdVsPOcx2eT0BsU3zGlAUrHr/mRBZBQ=;
        b=byVpy/qHqsi/ozaUtNP13CwwZGEtuoQbzoj7LApfBePeZacBTHm/Nm44ukrrRXzqbm
         cE163Kxzl1THHWzkJ6w2+S598t53FE6mFz37zD0gvps81d7g7xlw9ljUQtD5dZCpZFjh
         nmM6ohTQwMTgAhMR77eg01cY5Z4wrd+pgoRuOFH90V9rWvIbkh8Sa2oeCkkEMDS0NvY6
         F9hImcfi+FIHgjVkkod0Few6FV2A0Rk2OmxcekO7RTxyq75wNPqDejIm5mFH6fKS/G8J
         iGC9hsVZ1vfxe18WIaEjriX8IZKW+rhjsggjc/hNONexeCTQBwRxVofrr/HPWvbcXjIb
         pLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536686; x=1740141486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMhluq5TYdN6ZdVsPOcx2eT0BsU3zGlAUrHr/mRBZBQ=;
        b=GPnbGWr1Upxk9BIaCQgYG00xwD1OmHdpGi2K9IE5ewHguj52wKkyU4/bII98U1bXjL
         wN1dqFqZZN/P3Q9frwkFW5Tk9FpI11cwT9QmZbfOnMZGXvzUvRPWi5e62YpTe6FsXXaa
         QuAcNoYA83Y9yJsjP417rrFf3JuxInukABEf5b93G5zkKQUWmzReIQKa7FIHWfSTRP31
         f00Vu8PzbGrmqH5xYUVoGvjWhJqt2cGHhJ8gfUrWG12BjzsS+Se6oXvEhMqRDPVpGa4o
         wN6jXrFooyaZ40Nw5aOm0yDzw6rMtlnG7HRSz2PfwK/alCChw5KO6t914fvqwQ+KvMSg
         IOCw==
X-Forwarded-Encrypted: i=1; AJvYcCVbp0TCI83adEc7R+XVf56qIzOiVDUwSf09VWNfkvDmFXWOKzl+WqCG+nyPQCWcTQT+Swk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwdu9ei/V8OuXxG14X6xtFO9iNaHb8bcslU+g1QLQ33pvSXHu9
	ckkTNpTzXZwVoYwdrN6lAHgwu0vKJqVmuB/CxDeFpZLK24j6pEj+
X-Gm-Gg: ASbGncvzzaf4+Lvrwx/+fXpK/ouV+uJB6A0F8kna//UAi5XJNDP8TKZFDqD1o9DDJPt
	9PFvkKO/bD2UUO3ZfEG3gusUfcsSobH2fKzTvNHeSFzddi+8ep/h5atVXFXKhhuaGm/rnJqdn6M
	w0ly84HDhkmLHE+HDjM6aSn7BbbggYaTez/hW1puiu7EAqD9BuKXHXPmTNl9lXjac6IPrPtZhY8
	8b8dg5QnRWuRb5+yMEfkNdHlXHNajxeI4qzWMt75Hs9m2KKWvL98EHgRFRoa7xsdICXe+tFVcZ1
	1uADFolFXl4a5t9PeqhKUdYDJPpMa2AKOKksepys
X-Google-Smtp-Source: AGHT+IE8v0YewJfC5ITCzURqq16A81VvJZA1hozGY9zvqtkIY3u/FZcX4p5rnjUK8s3nQgsZDFxaeQ==
X-Received: by 2002:a17:902:e544:b0:220:f795:5f14 with SMTP id d9443c01a7336-220f7955fc0mr19092365ad.27.1739536686306;
        Fri, 14 Feb 2025 04:38:06 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:38:05 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/6] agent: advertise OS name via agent capability
Date: Fri, 14 Feb 2025 18:06:16 +0530
Message-ID: <20250214123734.1403120-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
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
 t/t5701-git-serve.sh             | 16 +++++++++++++++-
 t/test-lib-functions.sh          |  8 ++++++++
 version.c                        | 29 ++++++++++++++++++++++++++++-
 version.h                        |  3 +++
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..f4831a8787 100644
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
+printable ASCII characters (i.e., the byte range 31 < x < 127), and are
+typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")
+where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
+be configured using the GIT_USER_AGENT environment variable and it takes
+priority. The `os` is retrieved using the 'sysname' field of the `uname(2)`
+system call or its equivalent. The agent strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to programmatically
+assume the presence or absence of particular features.
 
 ls-refs
 ~~~~~~~
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 4c24a188b9..4f0b053c4a 100755
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
+		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
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
index d95221a72a..027ebc82b4 100644
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
@@ -43,6 +65,11 @@ const char *git_user_agent_sanitized(void)
 
 		strbuf_addstr(&buf, git_user_agent());
 		redact_non_printables(&buf);
+
+		if (!getenv("GIT_USER_AGENT")) {
+			strbuf_addch(&buf, ' ');
+			strbuf_addstr(&buf, os_info());
+		}
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

