Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939F2B9BC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721347; cv=none; b=T8reKsu4yIVE4GoAQci5WnslS9pA72Eoir7bG8QSyT7G11sEGOoTxAQSEY6e2QJTy4ulv38vxWgAJLnUaa7mWg+BBfpEf1xm27PaLYWdhSS3KU+kSqMemfumGFSV5cV72H3r22JQreqKC7O3NAR69OvPZil3uUH6PjZnpNWtV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721347; c=relaxed/simple;
	bh=91yb/J2cKkkAocJhDMNnNLIZa8H3mOoZFGZr2bO4aNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ/uuXvdKoiVqG4HGXn3B4dID6Y2XRbyllfMqCHumKBRkpyvBvz/J1dviR9o5YGx7Sz9TfmUKLLVsuoVNr4LOnwIYS/K+kwVtE7z+y1za7ItWlDtKUOY1D5s4hAwkho3R3WTOhBg17EXXlotx6xwSUqwN8SZVW5+k9DMNnBKukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLWN970S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLWN970S"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so3773158a91.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721344; x=1738326144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wzYnYzAw0W1H3dS67DNtv4rKanqyr0v2rIuMo/Iozo=;
        b=KLWN970SxRXxS7sp0bix7zPf8FmgS5FYWv1i2TEG/hZzpRVUh8VyAhvC07T43hseDV
         JpyW39St1cBR/S/Cj1UMrapyESrHvmhLPhlzN5bqGcBEHY1I9sgALDPHAe7sa98tnSMh
         un/CO1BRZ3F55MqBxlJH5aRHSpSDpXs4J+GMiOLZRzsGLxmVyVsZzWzMsrMkelaUc/oW
         ij1RIv0ShqD+j1ewqhh1j+3qzd5hKG+w8B0Mgxu9Ws9mrSXxuODSNS+RKx7E/7anmme2
         iguWZNMgp2xFhBw8TFIUG5alYGol7KvXfFTm7vJYR73M2mul4HNhGDWMwKa1Kz4JCPYu
         XepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721344; x=1738326144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wzYnYzAw0W1H3dS67DNtv4rKanqyr0v2rIuMo/Iozo=;
        b=ZL19j9mZDh2m9jlbeXB6C8kNX8dkNcE7BRqNAK5rmuX4yDeCMkgUkifYg+8kMG/D73
         rn7y4MFji1mxpHv1+gqM77gzBb+knKBcH95TxTTqRgu/oZPnpwMCiFrJ4rWcLS9Y6bhP
         GeBYiiVGK7TCuimzTYgXC9HjwiSs8tHhjfYh45SUx2Plm9Uc5UxuTedl6wZtFCNtEW4P
         fhRNk31xkgIk8U3z48QrX0TvyTnPhYtqKXTGItCcwMQ/TQLXHgOJDv1Y3bB+HMMUFrgM
         WUAgSDQHL/hTm0Sw4qEOCcxaEC+gYnNslGOYjXq6M3QbjzXUaxKMTwoWglkKvzQm48kG
         dgng==
X-Gm-Message-State: AOJu0Yz8i9H8dQuENoJNssHmtFsZcgF1raO3bKBp56V9ZaPw59eEX/4r
	bBbsSMcWNeS76ZBHmwqOCm4I+NikprpEqfMnQRPrEyDfvXlDF98Ndsnikt1o1qM=
X-Gm-Gg: ASbGncsnrPgOeZ/H1h538lJu+d2ZEHkHef7SR4qUEsZ9Hsp64+7r31RMxSTGnCae1e0
	R43bPKot7Z3N1L2qUJRkpM5K4GvV1DM5UfA5Do1k7EFN1Pkot9322QoPdjM3xCquqxG7FkbTMsx
	0gHWpqEE+AYGwp1SJoGy/Wq8S4/+4AvoNqbw3VcET8byUpR7OaHLnUAq5nDrSSX6Qdm/PtvIFNs
	bzfKbDNu2i8P6USfwXv8A2gdm6+YsgBayFvWcq+4Co3GbGgcscpwne1+FRiXeMSMPEzUJttL75l
	a0uPQdYVA3aQhe/UoHa506MtXcSf+A==
X-Google-Smtp-Source: AGHT+IEMxUGku5I+4T9nOJ9pGx5xZvQm6OXpyVH8oIHiKR7puNoDD8Y4PgzUB3JNrZY9spxYJB0umw==
X-Received: by 2002:a17:90a:e18f:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-2f782c674c1mr39880576a91.3.1737721343898;
        Fri, 24 Jan 2025 04:22:23 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:23 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with Configurable Options
Date: Fri, 24 Jan 2025 17:51:35 +0530
Message-ID: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, statistical analysis, and security purposes, it can
be valuable for Git servers to know the operating system the clients
are using.

For example:
- A server noticing that a client is using an old Git version with
security issues on one platform, like macOS, could verify if the
user is indeed running macOS before sending a message to upgrade."
- Similarly, a server identifying a client that could benefit from
an upgrade (e.g., for performance reasons) could better customize the
message it sends to nudge the client to upgrade.

So let's add a new 'os-version' capability to the v2 protocol, in the
same way as the existing 'agent' capability that lets clients and servers
exchange the Git version they are running.

Having the `os-version` protocol capability separately from other protocol
capabilities like `agent` is beneficial in ways like:

- It provides a clear separation between Git versioning and OS-specific,
concerns making troubleshooting and environment analysis more modular.
- It ensures we do not disrupt people's scripts that collect statistics
from other protocol capabilities like `agent`.
- It offers flexibility for possible future extensibility, allowing us to
add additional system-level details without modifying existing `agent`
parsing logic.
- It provides better control over privacy and security by allowing
selective exposure of OS information.

By default this sends similar info as `git bugreport` is already sending,
which uses uname(2). The difference is that it is sanitized in the same
way as the Git version sent by the 'agent' capability is sanitized
(by replacing characters having an ascii code less than 32 or more
than 127 with '.'). Also, it only sends the result of `uname -s` i.e
just only the operating system name (e.g "Linux").

Due to privacy issues and concerns, let's add the `transfer.advertiseOSVersion`
config option. This boolean option is enabled by default, but allows users to
disable this feature completely by setting it to "false".

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 5/6 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Changes since v2
================
  - Dropped the last patch which introduced `osversion.command`.
  - Use isprint() for checking printables byte in a preparatory
  patch. 
  - Add a few reasons why we should have `os-version` as a separate
  capability in the commit message that introduces it.
  - Improve how `printf` is used in the tests for better clarity.
  - Refactor documentation for improved clarity.
  - Retrieve and immediately sanitize the system information in the
  same function for simpler API surface.

Usman Akinyemi (6):
  version: replace manual ASCII checks with isprint() for clarity
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  version: extend get_uname_info() to hide system details
  t5701: add setup test to remove side-effect dependency
  connect: advertise OS version

 Documentation/config/transfer.txt |  7 +++
 Documentation/gitprotocol-v2.txt  | 17 +++++++
 builtin/bugreport.c               | 13 +-----
 connect.c                         |  3 ++
 serve.c                           | 14 ++++++
 t/t5555-http-smart-common.sh      | 10 ++++-
 t/t5701-git-serve.sh              | 30 +++++++++++--
 t/test-lib-functions.sh           |  8 ++++
 version.c                         | 73 ++++++++++++++++++++++++++++---
 version.h                         | 22 ++++++++++
 10 files changed, 175 insertions(+), 22 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  82b62c5e66 version: replace manual ASCII checks with isprint() for clarity
1:  97bccab6d5 ! 2:  0a7d7ce871 version: refactor redact_non_printables()
    @@ version.c
     +/*
     + * Trim and replace each character with ascii code below 32 or above
     + * 127 (included) using a dot '.' character.
    -+ * TODO: ensure consecutive non-printable characters are only replaced once
    -+*/
    ++ */
     +static void redact_non_printables(struct strbuf *buf)
     +{
     +	strbuf_trim(buf);
     +	for (size_t i = 0; i < buf->len; i++) {
    -+		if (buf->buf[i] <= 32 || buf->buf[i] >= 127)
    ++		if (!isprint(buf->buf[i]) || buf->buf[i] == ' ')
     +			buf->buf[i] = '.';
     +	}
     +}
    @@ version.c: const char *git_user_agent_sanitized(void)
      		strbuf_addstr(&buf, git_user_agent());
     -		strbuf_trim(&buf);
     -		for (size_t i = 0; i < buf.len; i++) {
    --			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
    +-			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
     -				buf.buf[i] = '.';
     -		}
     -		agent = buf.buf;
2:  1f8a4024a4 ! 3:  0187db59a4 version: refactor get_uname_info()
    @@ builtin/bugreport.c: static void get_system_info(struct strbuf *sys_info)
     
      ## version.c ##
     @@
    - #include "version.h"
      #include "version-def.h"
      #include "strbuf.h"
    + #include "sane-ctype.h"
     +#include "gettext.h"
      
      const char git_version_string[] = GIT_VERSION;
3:  962b42702f ! 4:  d3a3573594 version: extend get_uname_info() to hide system details
    @@ Commit message
         version: extend get_uname_info() to hide system details
     
         Currently, get_uname_info() function provides the full OS information.
    -    In a follwing commit, we will need it to provide only the OS name.
    +    In a following commit, we will need it to provide only the OS name.
     
         Let's extend it to accept a "full" flag that makes it switch between
         providing full OS information and providing only the OS name.
4:  7f0ec75a0d ! 5:  d9edd2ffc8 t5701: add setup test to remove side-effect dependency
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     -test_expect_success 'test capability advertisement' '
     +test_expect_success 'setup to generate files with expected content' '
    -+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_osversion &&
    ++	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_and_osversion &&
     +
      	test_oid_cache <<-EOF &&
      	wrong_algo sha1:sha256
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      	ls-refs=unborn
      	fetch=shallow wait-for-done
      	server-option
    -@@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement' '
    - 	cat >expect.trailer <<-EOF &&
    + 	object-format=$(test_oid algo)
    + 	EOF
    +-	cat >expect.trailer <<-EOF &&
    ++	cat >expect.trailer <<-EOF
      	0000
      	EOF
     +'
5:  007f8582d9 ! 6:  8a936b25f7 connect: advertise OS version
    @@ Commit message
         a server is using.
     
         Let's introduce a new protocol (`os-version`) allowing Git clients and
    -    servers to exchange operating system information. The protocol is
    -    controlled by the new `transfer.advertiseOSVersion` config option.
    +    servers to exchange operating system information.
    +
    +    Having the `os-version` protocol capability separately from other protocol
    +    capabilities like `agent` is beneficial in ways like:
    +
    +    - It provides a clear separation between Git versioning and OS-specific,
    +    concerns making troubleshooting and environment analysis more modular.
    +    - It ensures we do not disrupt people's scripts that collect statistics
    +    from other protocol like `agent`.
    +    - It offers flexibility for possible future extensibility, allowing us to
    +    add additional system-level details without modifying existing `agent`
    +    parsing logic.
    +    - It provides better control over privacy and security by allowing
    +    selective exposure of OS information.
     
         Add the `transfer.advertiseOSVersion` config option to address
         privacy concerns. It defaults to `true` and can be changed to
         `false`. When enabled, this option makes clients and servers send each
         other the OS name (e.g., "Linux" or "Windows"). The information is
    -    retrieved using the 'sysname' field of the `uname(2)` system call.
    +    retrieved using the 'sysname' field of the `uname(2)` system call or its
    +    equivalent.
     
         However, there are differences between `uname(1)` (command-line utility)
         and `uname(2)` (system call) outputs on Windows. These discrepancies
    @@ Documentation/config/transfer.txt: transfer.bundleURI::
      	servers. Defaults to false.
     +
     +transfer.advertiseOSVersion::
    -+	When `true`, the `os-version` capability is advertised by clients and
    -+	servers. It makes clients and servers send to each other a string
    -+	representing the operating system name, like "Linux" or "Windows".
    -+	This string is retrieved from the `sysname` field of the struct returned
    -+	by the uname(2) system call. Defaults to true.
    ++	When set to `true` on the server, the server will advertise its
    ++	`os-version` capability to the client. On the client side, if set
    ++	to `true`, it will advertise its `os-version` capability to the
    ++	server only if the server also advertises its `os-version` capability.
    ++	Defaults to true.
     
      ## Documentation/gitprotocol-v2.txt ##
     @@ Documentation/gitprotocol-v2.txt: printable ASCII characters except space (i.e., the byte range 32 < x <
    @@ Documentation/gitprotocol-v2.txt: printable ASCII characters except space (i.e.,
     +In the same way as the `agent` capability above, the server can
     +advertise the `os-version` capability to notify the client the
     +kind of operating system it is running on. The client may optionally
    -+send its own `os-version` capability, to notify the server the kind of
    -+operating system it is also running on in its request to the server
    ++send its own `os-version` capability, to notify the server the kind
    ++of operating system it is also running on in its request to the server
     +(but it MUST NOT do so if the server did not advertise the os-version
     +capability). The value of this capability may consist of ASCII printable
    -+characters(from 33 to 126 inclusive) and are typically made from the result of
    -+`uname -s`(OS name e.g Linux). The os-version capability can be disabled
    -+entirely by setting the `transfer.advertiseOSVersion` config option
    -+to `false`. The `os-version` strings are purely informative for
    ++characters(from 33 to 126 inclusive) and are typically made from the
    ++result of `uname -s`(OS name e.g Linux). The os-version capability can
    ++be disabled entirely by setting the `transfer.advertiseOSVersion` config
    ++option to `false`. The `os-version` strings are purely informative for
     +statistics and debugging purposes, and MUST NOT be used to
    -+programmatically assume the presence or absence of particular
    -+features.
    ++programmatically assume the presence or absence of particular features.
     +
      ls-refs
      ~~~~~~~
    @@ t/t5555-http-smart-common.sh: test_expect_success 'git receive-pack --advertise-
      '
      
      test_expect_success 'git upload-pack --advertise-refs: v2' '
    -+	printf "agent=FAKE" >agent_and_osversion &&
    ++	printf "agent=FAKE\n" >agent_and_osversion &&
     +	if test_have_prereq WINDOWS
     +	then
     +		git config transfer.advertiseOSVersion false
     +	else
    -+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
    ++		printf "os-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
     +	fi &&
     +
      	cat >expect <<-EOF &&
    @@ t/t5555-http-smart-common.sh: test_expect_success 'git receive-pack --advertise-
     
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: test_expect_success 'setup to generate files with expected content' '
    - 	cat >expect.trailer <<-EOF &&
    + 	server-option
    + 	object-format=$(test_oid algo)
    + 	EOF
    +-	cat >expect.trailer <<-EOF
    ++	cat >expect.trailer <<-EOF &&
      	0000
      	EOF
     +
    @@ t/t5701-git-serve.sh: test_expect_success 'setup to generate files with expected
     +	then
     +		git config transfer.advertiseOSVersion false
     +	else
    -+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
    ++		printf "os-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
     +	fi &&
     +
     +	cat >expect_osversion.base <<-EOF
    @@ t/test-lib-functions.sh: test_trailing_hash () {
     +# Trim and replace each character with ascii code below 32 or above
     +# 127 (included) using a dot '.' character.
     +# Octal intervals \001-\040 and \177-\377
    -+# corresponds to decimal intervals 1-32 and 127-255
    ++# correspond to decimal intervals 1-32 and 127-255
     +test_redact_non_printables () {
     +    tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
     +}
     
      ## version.c ##
     @@
    - #include "version-def.h"
      #include "strbuf.h"
    + #include "sane-ctype.h"
      #include "gettext.h"
     +#include "config.h"
      
    @@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
      	return 0;
      }
     +
    -+const char *os_version(void)
    ++const char *os_version_sanitized(void)
     +{
     +	static const char *os = NULL;
     +
    @@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
     +		struct strbuf buf = STRBUF_INIT;
     +
     +		get_uname_info(&buf, 0);
    ++		/* Sanitize the os information immediately */
    ++		redact_non_printables(&buf);
     +		os = strbuf_detach(&buf, NULL);
     +	}
     +
     +	return os;
     +}
     +
    -+const char *os_version_sanitized(void)
    -+{
    -+	static const char *os_sanitized = NULL;
    -+
    -+	if (!os_sanitized) {
    -+		struct strbuf buf = STRBUF_INIT;
    -+
    -+		strbuf_addstr(&buf, os_version());
    -+		redact_non_printables(&buf);
    -+		os_sanitized = strbuf_detach(&buf, NULL);
    -+	}
    -+
    -+	return os_sanitized;
    -+}
    -+
     +int advertise_os_version(struct repository *r)
     +{
     +	static int transfer_advertise_os_version = -1;
    @@ version.h: const char *git_user_agent_sanitized(void);
      int get_uname_info(struct strbuf *buf, unsigned int full);
      
     +/*
    -+  Retrieve and cache system information for subsequent calls.
    -+  Return a pointer to the cached system information string.
    -+*/
    -+const char *os_version(void);
    -+
    -+/*
    -+  Retrieve system information string from os_version(). Then
    -+  sanitize and cache it. Return a pointer to the sanitized
    -+  system information string.
    ++  Retrieve, sanitize and cache system information for subsequent
    ++  calls. Return a pointer to the sanitized system information
    ++  string.
     +*/
     +const char *os_version_sanitized(void);
     +
6:  10a07a3095 < -:  ---------- version: introduce osversion.command config for os-version output
-- 
2.48.0

