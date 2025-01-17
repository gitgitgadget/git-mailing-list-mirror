Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE21FCFE5
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110809; cv=none; b=RPn1nudYiF1iIg/+EaUTETw/i3JLQZcJ2lTx2GWEGLGyhYzjXe+CmvAMSN+lLJdC0hpYBaecirFETl9csximFAE0TIw3D1wxsfEt0ARbGtWVxJHzV6w6xRZY73MLGZW/EaLFklDjH+g8TK/pLb7a3G8FJhSr0IlmhrZ5qkZ1kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110809; c=relaxed/simple;
	bh=YzdSr9TxfGSg2iXUULj2hhAkwA/NCShmiYNORFiZlHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGAK3o77I3a4lAFuh92Uv6YL1yOtWH+mxhdno6mLz1LMtSp3bMKKrYOZSCkVyvj9bm54LYq7bOFTgCZUQVzD/OaSOGDuPQd4SlylU5TaJ6rt2vqlKGmgUKCp6vHzl+yYuE9QiRM2ligWVm6Z4LH8oIV11KnLv25397D1mna8Cn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfAwkuRx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfAwkuRx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21654fdd5daso33155495ad.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110806; x=1737715606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIXPoIw78rLTPzIJ+CvfQ+BHPYSIh+/SqOIJSs76G+U=;
        b=HfAwkuRxf5Aw5A7kDXhEwPob8nldoJe+cnd/FEExyWE6I/9kl50WCt0D8MKUDc6ok+
         RF51U9tJceRGX4EumQcVXr8gcj97cdXlNJ+tGm0DlCRwdMm3TJlHE1YgTFSZeq7jxWWv
         Y07q+U3Sb8RLoKQzQjPaSySTotz2z5R5tqPaOi3bbl4cY3NwXzgbJqNRHMXxcqsJE3bX
         //xygNWW0or/3/GCjMTdh+Gl3Ns+Mdm9rXk4jcdLOjJLAM1Il9UituqlQsLtkYIyd/Wt
         ykfqsVT8Vmnkw0E+bKTEbz7AE/afOZT6F1IhJXYU4KXaAlSm+XkYN5RRyA1I2BFpx+VL
         M53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110806; x=1737715606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIXPoIw78rLTPzIJ+CvfQ+BHPYSIh+/SqOIJSs76G+U=;
        b=OLFe3NsYmQFz0Ih7XevyAdvlmQ2hpm6pbR8C9YYT5KvV19X/hAFkfLm+LYLxR5pqJ0
         NsetIkNrSBYyP9qtPDx1+tVlr7j6+LTYBB9ZRsfVo3w3SyIO1334TlMwwfQ0lXMXRGxx
         3m7b5k56jUvlJNj+Z2WY0eOvuYSyneNVZckMt2OEgLEsnwiIRKqKnLDCeb6rNJ71VDt6
         ypnZABY5x+ELNTvTa9WWHQT2TFv8+L9SHJzQAzekmL0EHtOua/exto6Sq5UuGmgX15ZO
         lrIkOVzi+otMDKjZfORW8q07q3sNp2deWMkq8bvl7YnSsrp8RJmmiVHn7V7fMMP37WFD
         uZ8Q==
X-Gm-Message-State: AOJu0YyhM7FyuKatQ372+MkEeiLFpZsR6pM1bmJhrHeHnoCMXnEJrZ00
	4XruCxbOE+xTj9jP9i8N+v6kqotTs3I625FxAzm4T42Hod6Cs91DUX8AgIiFhhM=
X-Gm-Gg: ASbGncv8htaExm/5qjxOtKAeiKZysat8HijOwK0rioF5Iiz2Cu7C47n8iDNBQVeMMOY
	fw3RNoMmMnhwYljg/M478c8yzpYF+TnIjYV/jTOeGaJH0RQR0J65cs1dvS/wrb/91SHIYlkYa9h
	s+N4WAK40SGFWik/BpgzJtwrlS+CYzeVM67DHWRqchZSzjdpLFjleJAf53JumjfATLLr+t/B+9N
	j0S6+rKtDWHLt24rrmRwuOinodoMVxXaiozqdpKEK2yDsK6M4JL8I2zQS6rp7LB/YRc3/sVDPRh
	roZtCg==
X-Google-Smtp-Source: AGHT+IGMvBDrn81ifX1m3Y7PjNsrYoByXTMVAnPX5kQVTGhda0h6mQvl/FyknA3vHpL/8zyp7E0xPg==
X-Received: by 2002:a05:6a00:8e09:b0:725:ef4b:de30 with SMTP id d2e1a72fcca58-72dafa6b436mr3742087b3a.14.1737110805817;
        Fri, 17 Jan 2025 02:46:45 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:46:45 -0800 (PST)
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
	rsbecker@nexbridge.com
Subject: [PATCH v2 0/6][Outreachy] Introduce os-version Capability with Configurable Options
Date: Fri, 17 Jan 2025 16:16:12 +0530
Message-ID: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
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

By default this sends similar info as `git bugreport` is already sending,
which uses uname(2). The difference is that it is sanitized in the same
way as the Git version sent by the 'agent' capability is sanitized
(by replacing characters having an ascii code less than 32 or more
than 127 with '.'). Also, it only sends the result of `uname -s` i.e
just only the operating system name (e.g "Linux").

Due to privacy issues and concerns, let's add the `transfer.advertiseOSVersion`
config option. This boolean option is enabled by default, but allows users to
disable this feature completely by setting it to "false".

To provide flexibility and customization, let also add the `osversion.command`
config option. This allows users to specify a custom command whose output will
be used as the string exchanged via the "os-version" capability. If this option
is not set, the default behavior exchanges only the operating system name,
such as "Linux" or "Windows". This option was particularly suggested by Randall S. Becker
in a previous conversation. You can find the reference here
https://lore.kernel.org/git/000a01dac25c$df7b23e0$9e716ba0$@nexbridge.com/

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 5/6 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Changes since v1
================
  - Refactored documentation for improved clarity.
  - Splitted patch "refactor get_uname_info()" into two patches with first
    part doing refactoring and the second part doing enhancement for code
    clearity and cleanliness.
  - Made test_redact_non_printables() to trim carriage-returns.
  - Fixed outdated commit message.
  - Splitted part of the "test capability advertisement" into a setup"-type
    to remove side-effect dependency.
  - Changed the name of some created files used in testing for better
    clearity of what their content is.
  - Added comment to os_version(), os_version_sanitized() and advertise_os_version()
    for improved clarity of what they do.

Usman Akinyemi (6):
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  version: extend get_uname_info() to hide system details
  t5701: add setup test to remove side-effect dependency
  connect: advertise OS version
  version: introduce osversion.command config for os-version output

 Documentation/config/transfer.txt |  16 ++++
 Documentation/gitprotocol-v2.txt  |  17 ++++
 builtin/bugreport.c               |  13 +--
 connect.c                         |   3 +
 serve.c                           |  14 ++++
 t/t5555-http-smart-common.sh      |  38 ++++++++-
 t/t5701-git-serve.sh              |  59 ++++++++++++-
 t/test-lib-functions.sh           |   8 ++
 version.c                         | 135 ++++++++++++++++++++++++++++--
 version.h                         |  28 +++++++
 10 files changed, 309 insertions(+), 22 deletions(-)

Range-diff versus v1:

1:  d23091031c ! 1:  97bccab6d5 version: refactor redact_non_printables()
    @@ Commit message
         For now the new redact_non_printables() function is still static as
         it's only needed locally.
     
    -    While at it, let's also make a few small improvements:
    -      - use 'size_t' for 'i' instead of 'int',
    -      - move the declaration of 'i' inside the 'for ( ... )',
    -      - use strbuf_detach() to explicitly detach the string contained by
    -        the 'buf' strbuf.
    +    While at it, let's use strbuf_detach() to explicitly detach the string
    +    contained by the 'buf' strbuf.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
2:  1336622be9 ! 2:  1f8a4024a4 version: refactor get_uname_info()
    @@ Commit message
         Let's refactor this code into a new get_uname_info() function, so
         that we can reuse it in a following commit.
     
    -    We may need to refactor this function in the future if an
    -    `osVersion.format` config option is added, but for now we only
    -    need it to accept a "full" flag that makes it switch between providing
    -    full OS information and providing only the OS name. The mode
    -    providing only the OS name is needed in a following commit
    -
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
    @@ builtin/bugreport.c: static void get_system_info(struct strbuf *sys_info)
     -			    uname_info.release,
     -			    uname_info.version,
     -			    uname_info.machine);
    -+	get_uname_info(sys_info, 1);
    ++	get_uname_info(sys_info);
      
      	strbuf_addstr(sys_info, _("compiler info: "));
      	get_compiler_info(sys_info);
    @@ version.c: const char *git_user_agent_sanitized(void)
      	return agent;
      }
     +
    -+int get_uname_info(struct strbuf *buf, unsigned int full)
    ++int get_uname_info(struct strbuf *buf)
     +{
     +	struct utsname uname_info;
     +
    @@ version.c: const char *git_user_agent_sanitized(void)
     +		return -1;
     +	}
     +
    -+	if (full)
    -+		strbuf_addf(buf, "%s %s %s %s\n",
    -+			    uname_info.sysname,
    -+			    uname_info.release,
    -+			    uname_info.version,
    -+			    uname_info.machine);
    -+	else
    -+		strbuf_addf(buf, "%s\n", uname_info.sysname);
    ++	strbuf_addf(buf, "%s %s %s %s\n",
    ++		    uname_info.sysname,
    ++		    uname_info.release,
    ++		    uname_info.version,
    ++		    uname_info.machine);
     +	return 0;
     +}
     
    @@ version.h: extern const char git_built_from_commit_string[];
     +  Return -1 and put an error message into 'buf' in case of uname()
     +  error. Return 0 and put uname info into 'buf' otherwise.
     +*/
    -+int get_uname_info(struct strbuf *buf, unsigned int full);
    ++int get_uname_info(struct strbuf *buf);
     +
      #endif /* VERSION_H */
-:  ---------- > 3:  962b42702f version: extend get_uname_info() to hide system details
-:  ---------- > 4:  7f0ec75a0d t5701: add setup test to remove side-effect dependency
3:  b90a24813f ! 5:  499eda49cf connect: advertise OS version
    @@ Commit message
         controlled by the new `transfer.advertiseOSVersion` config option.
     
         Add the `transfer.advertiseOSVersion` config option to address
    -    privacy concerns issue. It defaults to `true` and can be changed to
    +    privacy concerns. It defaults to `true` and can be changed to
         `false`. When enabled, this option makes clients and servers send each
         other the OS name (e.g., "Linux" or "Windows"). The information is
         retrieved using the 'sysname' field of the `uname(2)` system call.
    @@ Commit message
           .2024-02-14.20:17.UTC.x86_64
           - `uname(2)` output: Windows.10.0.20348
     
    -    Until a good way to test the feature on Windows is found, the
    -    transfer.advertiseOSVersion is set to false on Windows during testing.
    +    On Windows, uname(2) is not actually system-supplied but is instead
    +    already faked up by Git itself. We could have overcome the test issue
    +    on Windows by implementing a new `uname` subcommand in `test-tool`
    +    using uname(2), but except uname(2), which would be tested against
    +    itself, there would be nothing platform specific, so it's just simpler
    +    to disable the tests on Windows.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ Documentation/config/transfer.txt: transfer.bundleURI::
     +	When `true`, the `os-version` capability is advertised by clients and
     +	servers. It makes clients and servers send to each other a string
     +	representing the operating system name, like "Linux" or "Windows".
    -+	This string is retrieved from the 'sysname' field of the struct returned
    ++	This string is retrieved from the `sysname` field of the struct returned
     +	by the uname(2) system call. Defaults to true.
     
      ## Documentation/gitprotocol-v2.txt ##
    @@ Documentation/gitprotocol-v2.txt: printable ASCII characters except space (i.e.,
     +~~~~~~~~~~
     +
     +In the same way as the `agent` capability above, the server can
    -+advertise the `os-version` capability with a value `X` (in the form
    -+`os-version=X`) to notify the client that the server is running an
    -+operating system that can be identified by `X`. The client may
    -+optionally send its own `os-version` string by including the
    -+`os-version` capability with a value `Y` (in the form `os-version=Y`)
    -+in its request to the server (but it MUST NOT do so if the server did
    -+not advertise the os-version capability). The `X` and `Y` strings may
    -+contain any printable ASCII characters except space (i.e., the byte
    -+range 32 < x < 127), and are typically made from the result of
    ++advertise the `os-version` capability to notify the client the
    ++kind of operating system it is running on. The client may optionally
    ++send its own `os-version` capability, to notify the server the kind of
    ++operating system it is also running on in its request to the server
    ++(but it MUST NOT do so if the server did not advertise the os-version
    ++capability). The value of this capability may consist of ASCII printable
    ++characters(from 33 to 126 inclusive) and are typically made from the result of
     +`uname -s`(OS name e.g Linux). The os-version capability can be disabled
     +entirely by setting the `transfer.advertiseOSVersion` config option
     +to `false`. The `os-version` strings are purely informative for
    @@ t/t5555-http-smart-common.sh: test_expect_success 'git receive-pack --advertise-
      '
      
      test_expect_success 'git upload-pack --advertise-refs: v2' '
    -+	printf "agent=FAKE" >agent_and_os_name &&
    ++	printf "agent=FAKE" >agent_and_osversion &&
     +	if test_have_prereq WINDOWS
     +	then
    -+		# We do not use test_config here so that any tests below can reuse
    -+		# the "expect" file from this test
     +		git config transfer.advertiseOSVersion false
     +	else
    -+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_os_name
    ++		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
     +	fi &&
     +
      	cat >expect <<-EOF &&
      	version 2
     -	agent=FAKE
    -+	$(cat agent_and_os_name)
    ++	$(cat agent_and_osversion)
      	ls-refs=unborn
      	fetch=shallow wait-for-done
      	server-option
     
      ## t/t5701-git-serve.sh ##
    -@@ t/t5701-git-serve.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - . ./test-lib.sh
    - 
    - test_expect_success 'test capability advertisement' '
    -+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_os_name &&
    +@@ t/t5701-git-serve.sh: test_expect_success 'setup to generate files with expected content' '
    + 	cat >expect.trailer <<-EOF &&
    + 	0000
    + 	EOF
    ++
     +	if test_have_prereq WINDOWS
     +	then
    -+		# We do not use test_config here so that tests below will be able to reuse
    -+		# the expect.base and expect.trailer files
     +		git config transfer.advertiseOSVersion false
     +	else
    -+		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_os_name
    ++		printf "\nos-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
     +	fi &&
     +
    - 	test_oid_cache <<-EOF &&
    - 	wrong_algo sha1:sha256
    - 	wrong_algo sha256:sha1
    ++	cat >expect_osversion.base <<-EOF
    ++	version 2
    ++	$(cat agent_and_osversion)
    ++	ls-refs=unborn
    ++	fetch=shallow wait-for-done
    ++	server-option
    ++	object-format=$(test_oid algo)
    ++	EOF
    + '
    + 
    + test_expect_success 'test capability advertisement' '
    +-	cat expect.base expect.trailer >expect &&
    ++	cat expect_osversion.base expect.trailer >expect &&
    + 
    + 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
    + 		--advertise-capabilities >out &&
    +@@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement with uploadpack.advertiseBund
    + 	cat >expect.extra <<-EOF &&
    + 	bundle-uri
      	EOF
    - 	cat >expect.base <<-EOF &&
    - 	version 2
    --	agent=git/$(git version | cut -d" " -f3)
    -+	$(cat agent_and_os_name)
    - 	ls-refs=unborn
    - 	fetch=shallow wait-for-done
    - 	server-option
    +-	cat expect.base \
    ++	cat expect_osversion.base \
    + 	    expect.extra \
    + 	    expect.trailer >expect &&
    + 
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_trailing_hash () {
    @@ t/test-lib-functions.sh: test_trailing_hash () {
     +# Octal intervals \001-\040 and \177-\377
     +# corresponds to decimal intervals 1-32 and 127-255
     +test_redact_non_printables () {
    -+    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
    ++    tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
     +}
     
      ## version.c ##
    @@ version.c
      const char git_version_string[] = GIT_VERSION;
      const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
     @@ version.c: int get_uname_info(struct strbuf *buf, unsigned int full)
    - 		strbuf_addf(buf, "%s\n", uname_info.sysname);
    + 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
      	return 0;
      }
     +
    @@ version.h: const char *git_user_agent_sanitized(void);
      */
      int get_uname_info(struct strbuf *buf, unsigned int full);
      
    ++/*
    ++  Retrieve and cache system information for subsequent calls.
    ++  Return a pointer to the cached system information string.
    ++*/
     +const char *os_version(void);
    ++
    ++/*
    ++  Retrieve system information string from os_version(). Then
    ++  sanitize and cache it. Return a pointer to the sanitized
    ++  system information string.
    ++*/
     +const char *os_version_sanitized(void);
    ++
    ++/*
    ++  Retrieve and cache whether os-version capability is enabled.
    ++  Return 1 if enabled, 0 if disabled.
    ++*/
     +int advertise_os_version(struct repository *r);
     +
      #endif /* VERSION_H */
4:  745e63060e ! 6:  a1637dc7cf version: introduce osversion.command config for os-version output
    @@ Commit message
         Let's introduce a new configuration option, `osversion.command`, to handle
         the string exchange between servers and clients. This option allows
         customization of the exchanged string by leveraging the output of the
    -    specified command. If this is not set, the `os-version` capability
    -    exchange just the operating system name.
    +    specified command. This customization might be especially useful on some
    +    quite uncommon platforms like NonStop where interesting OS information is
    +    available from other means than uname(2).
     
    +    If this new configuration option is not set, the `os-version` capability
    +    exchanges just the operating system name.
    +
    +    Helped-by: Randall S. Becker <rsbecker@nexbridge.com>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
    @@ Documentation/config/transfer.txt
     @@ Documentation/config/transfer.txt: transfer.advertiseOSVersion::
      	servers. It makes clients and servers send to each other a string
      	representing the operating system name, like "Linux" or "Windows".
    - 	This string is retrieved from the 'sysname' field of the struct returned
    + 	This string is retrieved from the `sysname` field of the struct returned
     -	by the uname(2) system call. Defaults to true.
     +	by the uname(2) system call. If the `osVersion.command` is set, the
     +	output of the command specified will be the string exchanged by the clients
    @@ Documentation/config/transfer.txt: transfer.advertiseOSVersion::
     +	`transfer.advertiseOSVersion` config option.
     
      ## Documentation/gitprotocol-v2.txt ##
    -@@ Documentation/gitprotocol-v2.txt: in its request to the server (but it MUST NOT do so if the server did
    - not advertise the os-version capability). The `X` and `Y` strings may
    - contain any printable ASCII characters except space (i.e., the byte
    - range 32 < x < 127), and are typically made from the result of
    +@@ Documentation/gitprotocol-v2.txt: the presence or absence of particular features.
    + os-version
    + ~~~~~~~~~~
    + 
    +-In the same way as the `agent` capability above, the server can
    +-advertise the `os-version` capability to notify the client the
    +-kind of operating system it is running on. The client may optionally
    +-send its own `os-version` capability, to notify the server the kind of
    +-operating system it is also running on in its request to the server
    +-(but it MUST NOT do so if the server did not advertise the os-version
    +-capability). The value of this capability may consist of ASCII printable
    ++In the same way as the `agent` capability above, the server can advertise
    ++the `os-version` capability to notify the client the kind of operating system
    ++it is running on. The client may optionally send its own `os-version` capability,
    ++to notify the server the kind of operating system it is also running on in its
    ++request to the server (but it MUST NOT do so if the server did not advertise the
    ++os-version capability). The value of this capability may consist of ASCII printable
    + characters(from 33 to 126 inclusive) and are typically made from the result of
     -`uname -s`(OS name e.g Linux). The os-version capability can be disabled
     -entirely by setting the `transfer.advertiseOSVersion` config option
     -to `false`. The `os-version` strings are purely informative for
     -statistics and debugging purposes, and MUST NOT be used to
     -programmatically assume the presence or absence of particular
     -features.
    -+`uname -s`(OS name e.g Linux).  If the `osVersion.command` is set,
    -+the `X` and `Y` are made from the ouput of the command specified.
    -+The os-version capability can be disabled entirely by setting the
    -+`transfer.advertiseOSVersion` config option to `false`. The `os-version`
    -+strings are purely informative for statistics and debugging purposes, and
    -+MUST NOT be used to programmatically assume the presence or absence of
    -+particular features.
    ++`uname -s`(OS name e.g Linux). If the `osVersion.command` is set, the value of this
    ++capability are made from the ouput of the command specified. The os-version capability
    ++can be disabled entirely by setting the `transfer.advertiseOSVersion` config option
    ++to `false`. The `os-version` strings are purely informative for statistics and
    ++debugging purposes, and MUST NOT be used to programmatically assume the presence or
    ++absence of particular features.
      
      ls-refs
      ~~~~~~~
    @@ t/t5555-http-smart-common.sh: test_expect_success 'git upload-pack --advertise-r
      '
      
     +test_expect_success 'git upload-pack --advertise-refs: v2 with osVersion.command config set' '
    -+	# test_config is used here as we are not reusing any file output from here
     +	test_config osVersion.command "uname -srvm" &&
    -+	printf "agent=FAKE" >agent_and_long_os_name &&
    ++	printf "agent=FAKE" >agent_and_long_osversion &&
     +
     +	if test_have_prereq !WINDOWS
     +	then
    -+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_os_name
    ++		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_osversion
     +	fi &&
     +
     +	cat >expect <<-EOF &&
     +	version 2
    -+	$(cat agent_and_long_os_name)
    ++	$(cat agent_and_long_osversion)
     +	ls-refs=unborn
     +	fetch=shallow wait-for-done
     +	server-option
    @@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement' '
      '
      
     +test_expect_success 'test capability advertisement with osVersion.command config set' '
    -+	# test_config is used here as we are not reusing any file output from here
     +	test_config osVersion.command "uname -srvm" &&
    -+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_long_os_name &&
    ++	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_long_osversion &&
     +
     +	if test_have_prereq !WINDOWS
     +	then
    -+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_os_name
    ++		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_osversion
     +	fi &&
     +
     +	test_oid_cache <<-EOF &&
     +	wrong_algo sha1:sha256
     +	wrong_algo sha256:sha1
     +	EOF
    -+	cat >expect.base_long <<-EOF &&
    ++	cat >expect_long.base <<-EOF &&
     +	version 2
    -+	$(cat agent_and_long_os_name)
    ++	$(cat agent_and_long_osversion)
     +	ls-refs=unborn
     +	fetch=shallow wait-for-done
     +	server-option
     +	object-format=$(test_oid algo)
     +	EOF
    -+	cat >expect.trailer_long <<-EOF &&
    -+	0000
    -+	EOF
    -+	cat expect.base_long expect.trailer_long >expect &&
    ++	cat expect_long.base expect.trailer >expect &&
     +
     +	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
     +		--advertise-capabilities >out &&

-- 
2.48.0

