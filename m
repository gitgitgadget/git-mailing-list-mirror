Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C525A627
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536663; cv=none; b=iAnBD7DxOCceo+vacuHMpbeB+ZeT4d9daJOdzaNU2byNNdswSOjxQcZCWpzldV6+0KZENeKPBlFLqHgwMgmK4Ybisfsq+l7JKI3RH+iThXWJezpZPdxDHEhHwBo83WX+OgLChrBs8iDrzzWUrXiHexEhspAl+4AHQevcuiEGrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536663; c=relaxed/simple;
	bh=YJMLkC++QO3E1AJwGzh5BhfSCgU1oWYLsSlMTkExN2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2qm/VHVkk3xInlpffhGyD6j+af4D70DQJKf+Iqlbz4XzVwd/sGAUfVCgay/ELGDzUto2yanKtZycEKC9xaeSs0wlvMqCe8KymPes6iFUzH5uUKBPqlg6A/ssdukPC+qZ6UPviIfJq8R1qnEQTeqZYgEdTR1lt2h40M4IW/jvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buoX9X0Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buoX9X0Y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c2a87378so28020485ad.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536661; x=1740141461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n6FYvgtOe1zdv/qKlgQ5mrFxxcxl9l59DKRAVK9R5w=;
        b=buoX9X0YgrS8zdxIRF2R8UNYdrdXR37pCZlb/RcZKrlLNpiqF8EJsS+use5bYUgS1b
         Gce79VWPWN0kRMCyrnF3dHXYez+nNx2ZPA3yji1TQumpXzPh0tWB3akWqWovBdWTAgZD
         NLqo9qZLHAOZIRcJYROT/Zv9xzC/2u0aKXYawTS/aEeFiw4ct5RusgLB2d4xN03tPSRJ
         HefBLwkEIoyy5ho5gL8AoOJ+RN4TkykajicO/65quKb7rlozk0DcSuVhBTWOM6owPJX/
         ebkgtWKUmgwB96s92HbozuQhNmZTm3UeUNLhrtEGY2JvFX+lva4JTYm90QmudMEqxiBW
         sTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536661; x=1740141461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n6FYvgtOe1zdv/qKlgQ5mrFxxcxl9l59DKRAVK9R5w=;
        b=W8kiWI+YvIUH1MtotZ7oFYEp72sL1ScGEOlH1IOC+hnIy2H3k+nJ9SSh+Gf6H6VGGf
         gOEaqyYJBlGELTHZhKvtS+kbHblKh9VFAhUYVLZgEsfwWOieL5g2O3teVgBOa/hXroSf
         CKnIBWddyjt8ruhGNg3XPa6PI5QWRlZ5JiQl4dfVoMu6gBx0VZGViSbHC45IXuTEhS/3
         pM9vNGHpP9b6OiQcW2kmm431H34P6fX7DSvOwY3GgDB27UjncT0Pwy9oewiYhaFD7bay
         UjVEWGBkVyoDCmtA6AgKLgkde3u2lkjvrWI/LhDPQ/+AP2dFSXt9MaSrAbvI/Im/Wlun
         xacA==
X-Forwarded-Encrypted: i=1; AJvYcCUHK7mzZqNjEUTjCJGNDiToAe2mcIlBGxFbyfske0GiKq1oPjwlOkDYaIyUezg7F88OuWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXi7TxmNvu89UGTL34QZX/4fNbCtyWQg4ALlIp3yGHJu5igE4
	SCh9S/836HgNDMP/Z7zsjrPySNVWz/KaSHPZkzPnuCDvkcClrQzM
X-Gm-Gg: ASbGncv81JxZ0BVvDFeeO8Ef1D2DIiEm8NOO503Gd6fMWiwhQpnzzPFgM5rt+dW6JFq
	xoekg7EfICFvheTuZQmAUiPCo7lc12ROhEMdJfATcOyDqAyrll8k7UvfbRVQu4Ve4RzUVkb0q72
	uni3zmKkmaR0rGWzzIewpa7CM95tF3jcOe8Arpy6riraI8yP08M73qxUfenJYQNWgD+a4Z9eQiE
	tbspsEonA9TUerHZmhZV1z7BQAn7A2QtZo5IOUF8WveWwh58UhzEGWmSkh3B1lF0mTA4E7l7c4i
	aD4PFY+PrUx6e8XNE8h0DUOURSzEficubNxj3V/O
X-Google-Smtp-Source: AGHT+IFdv/G6lhNUlik9FM+chU2oFaDFq/fHD2xc5dxSKl6NFKaSr+yaAZMRfMxcUgLXLGGAAzYSxw==
X-Received: by 2002:a17:902:ec83:b0:220:ce37:e31f with SMTP id d9443c01a7336-220ce37e53fmr94910965ad.17.1739536660589;
        Fri, 14 Feb 2025 04:37:40 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:37:40 -0800 (PST)
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
	sunshine@sunshineco.com
Subject: [PATCH v5 0/6][Outreachy] extend agent capability to include OS name
Date: Fri, 14 Feb 2025 18:06:10 +0530
Message-ID: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
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

Our current agent capability is in the form of "package/version" (e.g.,
"git/1.8.3.1"). Let's extend it to include the operating system name (os)
i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
The operating system name is retrieved using the 'sysname' field of 
he `uname(2)` system call or its equivalent.

Including OS details in the agent capability simplifies implementation,
maintains backward compatibility, avoids introducing a new capability,
encourages adoption across Git-compatible software, and enhances
debugging by providing complete environment information without affecting
functionality.

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 5/6 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Changes since v4
================
 - Remove the implementation of transfer.advertiseOSInfo config. 
 - Update the documentation.
 - Move the `os_info()` function into "version.c" file.

Usman Akinyemi (6):
  version: replace manual ASCII checks with isprint() for clarity
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  version: extend get_uname_info() to hide system details
  t5701: add setup test to remove side-effect dependency
  agent: advertise OS name via agent capability

 Documentation/gitprotocol-v2.txt | 13 +++---
 builtin/bugreport.c              | 13 +-----
 t/t5701-git-serve.sh             | 26 ++++++++++--
 t/test-lib-functions.sh          |  8 ++++
 version.c                        | 69 +++++++++++++++++++++++++++++---
 version.h                        | 10 +++++
 6 files changed, 115 insertions(+), 24 deletions(-)

Range-diff versus v4:

1:  82b62c5e66 = 1:  82b62c5e66 version: replace manual ASCII checks with isprint() for clarity
2:  0a7d7ce871 = 2:  0a7d7ce871 version: refactor redact_non_printables()
3:  0187db59a4 = 3:  0187db59a4 version: refactor get_uname_info()
4:  d3a3573594 = 4:  d3a3573594 version: extend get_uname_info() to hide system details
5:  3e0e98f23d = 5:  3e0e98f23d t5701: add setup test to remove side-effect dependency
6:  67a2767026 ! 6:  bcd1130aa1 agent: advertise OS name via agent capability
    @@ Commit message
         maintains backward compatibility, avoids introducing a new capability,
         encourages adoption across Git-compatible software, and enhances
         debugging by providing complete environment information without affecting
    -    functionality.
    -
    -    Add the `transfer.advertiseOSInfo` config option to address privacy
    -    concerns. It defaults to `true` and can be changed to `false`.
    -    When `true`, both the client and server independently append their
    -    operating system name(os) to the `agent` capability value. The `agent`
    -    capability will now be in form of "package/version os" (e.g.,
    -    "git/1.8.3.1 Linux"). When `false`, the `agent` capability will be
    -    in the form of "package/version" e.g "git/1.8.3.1". The server's
    -    configuration is independent of the client's. Defaults to `true`.
    -    The operating system name is retrieved using the 'sysname' field of
    -    the `uname(2)` system call or its equivalent.
    +    functionality. The operating system name is retrieved using the 'sysname'
    +    field of the `uname(2)` system call or its equivalent.
     
         However, there are differences between `uname(1)` (command-line utility)
         and `uname(2)` (system call) outputs on Windows. These discrepancies
    @@ Commit message
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
    - ## Documentation/config/transfer.txt ##
    -@@ Documentation/config/transfer.txt: transfer.bundleURI::
    - transfer.advertiseObjectInfo::
    - 	When `true`, the `object-info` capability is advertised by
    - 	servers. Defaults to false.
    -+
    -+transfer.advertiseOSInfo::
    -+	When `true`, both the client and server independently append their
    -+	operating system name (os) to the `agent` capability value. The `agent`
    -+	capability will now be in form of "package/version os" (e.g.,
    -+	"git/1.8.3.1 Linux"). When `false`, the `agent` capability will be
    -+	in the form of "package/version" e.g "git/1.8.3.1". The server's
    -+	configuration is independent of the client's. Defaults to `true`.
    -
      ## Documentation/gitprotocol-v2.txt ##
     @@ Documentation/gitprotocol-v2.txt: form `agent=X`) to notify the client that the server is running version
      the `agent` capability with a value `Y` (in the form `agent=Y`) in its
    @@ Documentation/gitprotocol-v2.txt: form `agent=X`) to notify the client that the
     -"git/1.8.3.1"). The agent strings are purely informative for statistics
     -and debugging purposes, and MUST NOT be used to programmatically assume
     -the presence or absence of particular features.
    -+printable ASCII characters (i.e., the byte range 32 < x < 127), and are
    ++printable ASCII characters (i.e., the byte range 31 < x < 127), and are
     +typically of the form "package/version os" (e.g., "git/1.8.3.1 Linux")
     +where `os` is the operating system name (e.g., "Linux"). `X` and `Y` can
     +be configured using the GIT_USER_AGENT environment variable and it takes
    -+priority. If `transfer.advertiseOSInfo` is `false` on the server, the server
    -+omits the `os` from X. If it is `false` on the client, the client omits the
    -+`os` from `Y`. The `os` is retrieved using the 'sysname' field of the `uname(2)`
    ++priority. The `os` is retrieved using the 'sysname' field of the `uname(2)`
     +system call or its equivalent. The agent strings are purely informative for
     +statistics and debugging purposes, and MUST NOT be used to programmatically
     +assume the presence or absence of particular features.
    @@ Documentation/gitprotocol-v2.txt: form `agent=X`) to notify the client that the
      ls-refs
      ~~~~~~~
     
    - ## t/t5555-http-smart-common.sh ##
    -@@ t/t5555-http-smart-common.sh: test_expect_success 'git receive-pack --advertise-refs: v1' '
    - '
    - 
    - test_expect_success 'git upload-pack --advertise-refs: v2' '
    -+	printf "agent=FAKE" >agent_capability &&
    -+	if test_have_prereq WINDOWS
    -+	then
    -+		printf "\n" >>agent_capability &&
    -+		git config transfer.advertiseOSInfo false
    -+	else
    -+		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
    -+	fi &&
    - 	cat >expect <<-EOF &&
    - 	version 2
    --	agent=FAKE
    -+	$(cat agent_capability)
    - 	ls-refs=unborn
    - 	fetch=shallow wait-for-done
    - 	server-option
    -
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
    @@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     +	if test_have_prereq WINDOWS
     +	then
    -+		printf "\n" >>agent_capability &&
    -+		git config transfer.advertiseOSInfo false
    ++		printf "agent=FAKE\n" >agent_capability
     +	else
     +		printf " %s\n" $(uname -s | test_redact_non_printables) >>agent_capability
     +	fi &&
      	cat >expect.base <<-EOF &&
      	version 2
      	$(cat agent_capability)
    +@@ t/t5701-git-serve.sh: test_expect_success 'setup to generate files with expected content' '
    + test_expect_success 'test capability advertisement' '
    + 	cat expect.base expect.trailer >expect &&
    + 
    ++	if test_have_prereq WINDOWS
    ++	then
    ++		GIT_USER_AGENT=FAKE && export GIT_USER_AGENT
    ++	fi &&
    + 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
    + 		--advertise-capabilities >out &&
    + 	test-tool pkt-line unpack <out >actual &&
    +@@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement with uploadpack.advertiseBund
    + 	    expect.extra \
    + 	    expect.trailer >expect &&
    + 
    ++	if test_have_prereq WINDOWS
    ++	then
    ++		GIT_USER_AGENT=FAKE && export GIT_USER_AGENT
    ++	fi &&
    + 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
    + 		--advertise-capabilities >out &&
    + 	test-tool pkt-line unpack <out >actual &&
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_trailing_hash () {
    @@ version.c
      #include "version.h"
      #include "version-def.h"
      #include "strbuf.h"
    - #include "sane-ctype.h"
    +-#include "sane-ctype.h"
      #include "gettext.h"
    -+#include "config.h"
      
      const char git_version_string[] = GIT_VERSION;
    - const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
    -@@ version.c: const char *git_user_agent_sanitized(void)
    - 
    - 		strbuf_addstr(&buf, git_user_agent());
    - 		redact_non_printables(&buf);
    -+		/* Add os name if the transfer.advertiseosinfo config is true */
    -+		if (advertise_os_info()) {
    -+			/* Add space to space character after git version string */
    -+			strbuf_addch(&buf, ' ');
    -+			strbuf_addstr(&buf, os_info_sanitized());
    -+		}
    - 		agent = strbuf_detach(&buf, NULL);
    - 	}
    - 
    -@@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
    - 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
    - 	return 0;
    +@@ version.c: const char *git_user_agent(void)
    + 	return agent;
      }
    -+
    -+const char *os_info_sanitized(void)
    + 
    ++/*
    ++  Retrieve, sanitize and cache operating system info for subsequent
    ++  calls. Return a pointer to the sanitized operating system info
    ++  string.
    ++*/
    ++static const char *os_info(void)
     +{
     +	static const char *os = NULL;
     +
    @@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
     +	return os;
     +}
     +
    -+int advertise_os_info(void)
    -+{
    -+	static int transfer_advertise_os_info= -1;
    + const char *git_user_agent_sanitized(void)
    + {
    + 	static const char *agent = NULL;
    +@@ version.c: const char *git_user_agent_sanitized(void)
    + 
    + 		strbuf_addstr(&buf, git_user_agent());
    + 		redact_non_printables(&buf);
     +
    -+	if (transfer_advertise_os_info == -1) {
    -+		repo_config_get_bool(the_repository, "transfer.advertiseosinfo", &transfer_advertise_os_info);
    -+		/* enabled by default */
    -+		transfer_advertise_os_info = !!transfer_advertise_os_info;
    -+	}
    -+	return transfer_advertise_os_info;
    -+}
    ++		if (!getenv("GIT_USER_AGENT")) {
    ++			strbuf_addch(&buf, ' ');
    ++			strbuf_addstr(&buf, os_info());
    ++		}
    + 		agent = strbuf_detach(&buf, NULL);
    + 	}
    + 
     
      ## version.h ##
     @@
    @@ version.h: const char *git_user_agent_sanitized(void);
      */
      int get_uname_info(struct strbuf *buf, unsigned int full);
      
    -+/*
    -+  Retrieve, sanitize and cache operating system info for subsequent
    -+  calls. Return a pointer to the sanitized operating system info
    -+  string.
    -+*/
    -+const char *os_info_sanitized(void);
    -+
    -+/*
    -+  Retrieve and cache transfer.advertiseosinfo config value. Return 1
    -+  if true, 0 if false.
    -+*/
    -+int advertise_os_info(void);
     +
      #endif /* VERSION_H */

-- 
2.48.1

