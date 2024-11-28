Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554881BBBFC
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810347; cv=none; b=UoIHykuWPK7T9hjQdQiniB3kl/gO0VsNybJ71HZwasroMU28GgJYTLikGkONCCM1WPQ3hzc1HBWrSWCBkbUXq8OjiZZcTVvU52i2n4Sm6BT6h89aG2s7xNMZLn5zCaVkB/VBvPVokqxwHWS2VWxnDIUlzfswkMHSbXXF+zKr8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810347; c=relaxed/simple;
	bh=3M2H0/fia65MdyPVxZJxD4lFOm6XPAreL0Yt3L/yXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7MH6nznlEnv6PDVwX+pqm5IKPXzarI1xXj5ZefePF0rBj2cNW9yVGsoQm4cePzsVRa77QjiNb9eDj4CCSXw69l1WSgdZYGJ1O2xCtgTRvOW5nFdFIwYfRqum+wDf8aI/7jKLz6aMUDEDiaq0WVY6BNZecIL67F7o9wEG6n4rLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W6lSMRlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJEPE69v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W6lSMRlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJEPE69v"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EE22138028D;
	Thu, 28 Nov 2024 11:12:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 28 Nov 2024 11:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810344;
	 x=1732896744; bh=X83S+o3tjSpEtRvq3rE1LoQpMirUOmyusjcgaC9n8HY=; b=
	W6lSMRlIunvv86rZR4zOaJGgucSKYLWRVGJ4Kww1d8dl2NlHQRYRwrtg55C0iVmG
	qjQki/vqwPpTxoFyM6MFWyLoB4j5+xPs6Idwvphz5upAeh46paubkSC0tDt6BceI
	D2w96nf7ht/oH/zXNFL4yPC2ka+BPVnkt4ADOcIWnuBo15H95fgimgZtIRZZ8HJp
	kw77BSm+etnrCIanr8TMkhhXaodgiesFi2sz3u5olLI/DgYgI89CC5LFAygucDy0
	MifoHd/1rWHKXnPaM2UK6B0iNnbSBlA7EPD2g33LsAQAio/SA6Nuu8wstvnGB7u/
	8adoAVJBA1m4zVqO/CG8uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810344; x=
	1732896744; bh=X83S+o3tjSpEtRvq3rE1LoQpMirUOmyusjcgaC9n8HY=; b=l
	JEPE69vt2YWU2C02sb2p4JVwOYmTgGF5Nk9deyZi461spYViq3TUALyhsz3xpBZk
	vBUIjMqmOScg3XncDeHpTibsKuPZspcaWOmTRfzgoPdtDb04d8fvyTw27zv/IevK
	y7m8/GgzrEjnSnvd9uQLbMZaQxBDwMSFd7gRbOzG2Dq4lckZ7nZzIl0SlGZlbLh9
	23HXqIvS6P3Qt9MFrvsu+eqdMJo/b5XR16in4qVaK9XQFNB0wF8656XvI4ex5jk6
	dexi0OVwA+QJWqpc8cQJQ7Uf0sKWnVsuXDL7hSpqpHLjlf7fF5Q24zC9E9f+iyC+
	1SWfsH5D39JXuxkF9xt7A==
X-ME-Sender: <xms:Z5ZIZ-8XlbPTrhV-b7Xb1WFAywlQt2ZpJN0K8MvrYu9_m4_uOjSpcg>
    <xme:Z5ZIZ-sGRgST5Mk9I4KfMZa8vk2Fyf6Xt8DI00F5pgwFMCJjxPshcS7ytVg5IB2ZX
    D3EDj-pEjkwaN3tNw>
X-ME-Received: <xmr:Z5ZIZ0BsDN7WKzf19VDtMUGxDAVK6STqmGRqNsYX_uRha0Kv7yVTQ11XYunqq1whOznAIwPxXIY8OhTVIpjMa-uxtYDHfPIdEi9BHUgurG3P8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjheitheskhgusghg
    rdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:Z5ZIZ2cDb0SpmOTn60o_YdeIl0L6SX1R6RR9jM669ZBc4BzCglGlag>
    <xmx:Z5ZIZzPBipGyHrjIdyfLdChMl6-vKrw8hD5Ot0TjTtYwIp-EhUqmMQ>
    <xmx:Z5ZIZwmxkndErfWhS8n-uzSVk7_lwzNhr0UniegLkkBxnMXA7f76qw>
    <xmx:Z5ZIZ1sIbSkS9QbxtdBm3JG2zJ_cs8pr4Uuom9PG61-FymzKk1e2Nw>
    <xmx:aJZIZwkYS1hEYNZAXHxozYRgsoldxeqU-Ql95qwjSyRUtMxOwLMElu1->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 562e4abc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:02 +0100
Subject: [PATCH v10 01/23] Makefile: use common template for
 GIT-BUILD-OPTIONS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-1-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "GIT-BUILD-OPTIONS" file is generated by our build systems to
propagate built-in features and paths to our tests. The generation is
done ad-hoc, where both our Makefile and the CMake build instructions
simply echo a bunch of strings into the file. This makes it very hard to
figure out what variables are expected to exist and what format they
have, and the written variables can easily get out of sync between build
systems.

Introduce a new "GIT-BUILD-OPTIONS.in" template to address this issue.
This has multiple advantages:

  - It demonstrates which built options exist in the first place.

  - It can serve as a spot to document the build options.

  - Some build systems complain when not all variables could be
    substituted, alerting us of mismatches. Others don't, but if we
    forgot to substitute such variables we now have a bogus string that
    will likely cause our tests to fail, if they have any meaning in the
    first place.

Backfill values that we didn't yet set in our CMake build instructions.
While at it, remove the `SUPPORTS_SIMPLE_IPC` variable that we only set
up in CMake as it isn't used anywhere.

This change requires us to adapt the setup of TEST_OUTPUT_DIRECTORY in
"test-lib.sh" such that it does not get overwritten after sourcing when
it has been set up via the environment. This is the only instance I
could find where we rely on ordering on variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  36 +++++++++++
 Makefile                            | 115 ++++++++++++++----------------------
 contrib/buildsystems/CMakeLists.txt |  58 ++++++++++++------
 t/test-lib.sh                       |  22 +++++--
 4 files changed, 136 insertions(+), 95 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
new file mode 100644
index 0000000000000000000000000000000000000000..f0ca240493c94aa41a6b6241a8474e42f7cdc8b9
--- /dev/null
+++ b/GIT-BUILD-OPTIONS.in
@@ -0,0 +1,36 @@
+SHELL_PATH=@SHELL_PATH@
+TEST_SHELL_PATH=@TEST_SHELL_PATH@
+PERL_PATH=@PERL_PATH@
+DIFF=@DIFF@
+PYTHON_PATH=@PYTHON_PATH@
+TAR=@TAR@
+NO_CURL=@NO_CURL@
+NO_ICONV=@NO_ICONV@
+NO_EXPAT=@NO_EXPAT@
+USE_LIBPCRE2=@USE_LIBPCRE2@
+NO_PERL=@NO_PERL@
+NO_PTHREADS=@NO_PTHREADS@
+NO_PYTHON=@NO_PYTHON@
+NO_REGEX=@NO_REGEX@
+NO_UNIX_SOCKETS=@NO_UNIX_SOCKETS@
+PAGER_ENV=@PAGER_ENV@
+SANITIZE_LEAK=@SANITIZE_LEAK@
+SANITIZE_ADDRESS=@SANITIZE_ADDRESS@
+X=@X@
+FSMONITOR_DAEMON_BACKEND=@FSMONITOR_DAEMON_BACKEND@
+FSMONITOR_OS_SETTINGS=@FSMONITOR_OS_SETTINGS@
+TEST_OUTPUT_DIRECTORY=@TEST_OUTPUT_DIRECTORY@
+GIT_TEST_OPTS=@GIT_TEST_OPTS@
+GIT_TEST_CMP=@GIT_TEST_CMP@
+GIT_TEST_CMP_USE_COPIED_CONTEXT=@GIT_TEST_CMP_USE_COPIED_CONTEXT@
+GIT_TEST_UTF8_LOCALE=@GIT_TEST_UTF8_LOCALE@
+NO_GETTEXT=@NO_GETTEXT@
+GIT_PERF_REPEAT_COUNT=@GIT_PERF_REPEAT_COUNT@
+GIT_PERF_REPO=@GIT_PERF_REPO@
+GIT_PERF_LARGE_REPO=@GIT_PERF_LARGE_REPO@
+GIT_PERF_MAKE_OPTS=@GIT_PERF_MAKE_OPTS@
+GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
+GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
+GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
+GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
+RUNTIME_PREFIX=@RUNTIME_PREFIX@
diff --git a/Makefile b/Makefile
index 549b24e7fdbbdc173dfec79cdaddf67ccba52e14..1f8434a902fa50035c29aecd0ac64c68e0f5db4f 100644
--- a/Makefile
+++ b/Makefile
@@ -3160,80 +3160,55 @@ GIT-LDFLAGS: FORCE
 		echo "$$FLAGS" >GIT-LDFLAGS; \
             fi
 
+ifdef RUNTIME_PREFIX
+RUNTIME_PREFIX_OPTION = true
+else
+RUNTIME_PREFIX_OPTION = false
+endif
+
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: FORCE
-	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
-	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >>$@+
-	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@+
-	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@+
-	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+
-	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
-	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
-	@echo NO_ICONV=\''$(subst ','\'',$(subst ','\'',$(NO_ICONV)))'\' >>$@+
-	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
-	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
-	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
-	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
-	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
-	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
-	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
-	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
-	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+
-	@echo X=\'$(X)\' >>$@+
-ifdef FSMONITOR_DAEMON_BACKEND
-	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
-endif
-ifdef FSMONITOR_OS_SETTINGS
-	@echo FSMONITOR_OS_SETTINGS=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_OS_SETTINGS)))'\' >>$@+
-endif
-ifdef TEST_OUTPUT_DIRECTORY
-	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
-endif
-ifdef GIT_TEST_OPTS
-	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@+
-endif
-ifdef GIT_TEST_CMP
-	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@+
-endif
-ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
-	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
-endif
-ifdef GIT_TEST_UTF8_LOCALE
-	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
-endif
-	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-ifdef GIT_PERF_REPEAT_COUNT
-	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
-endif
-ifdef GIT_PERF_REPO
-	@echo GIT_PERF_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPO)))'\' >>$@+
-endif
-ifdef GIT_PERF_LARGE_REPO
-	@echo GIT_PERF_LARGE_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_LARGE_REPO)))'\' >>$@+
-endif
-ifdef GIT_PERF_MAKE_OPTS
-	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@+
-endif
-ifdef GIT_PERF_MAKE_COMMAND
-	@echo GIT_PERF_MAKE_COMMAND=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_COMMAND)))'\' >>$@+
-endif
-ifdef GIT_INTEROP_MAKE_OPTS
-	@echo GIT_INTEROP_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_INTEROP_MAKE_OPTS)))'\' >>$@+
-endif
-ifdef GIT_TEST_INDEX_VERSION
-	@echo GIT_TEST_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_INDEX_VERSION)))'\' >>$@+
-endif
-ifdef GIT_TEST_PERL_FATAL_WARNINGS
-	@echo GIT_TEST_PERL_FATAL_WARNINGS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_PERL_FATAL_WARNINGS)))'\' >>$@+
-endif
-ifdef RUNTIME_PREFIX
-	@echo RUNTIME_PREFIX=\'true\' >>$@+
-else
-	@echo RUNTIME_PREFIX=\'false\' >>$@+
-endif
+	@sed \
+		-e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
+		-e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
+		-e "s|@PERL_PATH@|\'$(PERL_PATH_SQ)\'|" \
+		-e "s|@DIFF@|\'$(DIFF)\'|" \
+		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
+		-e "s|@TAR@|\'$(TAR)\'|" \
+		-e "s|@NO_CURL@|\'$(NO_CURL)\'|" \
+		-e "s|@NO_ICONV@|\'$(NO_ICONV)\'|" \
+		-e "s|@NO_EXPAT@|\'$(NO_EXPAT)\'|" \
+		-e "s|@USE_LIBPCRE2@|\'$(USE_LIBPCRE2)\'|" \
+		-e "s|@NO_PERL@|\'$(NO_PERL)\'|" \
+		-e "s|@NO_PTHREADS@|\'$(NO_PTHREADS)\'|" \
+		-e "s|@NO_PYTHON@|\'$(NO_PYTHON)\'|" \
+		-e "s|@NO_REGEX@|\'$(NO_REGEX)\'|" \
+		-e "s|@NO_UNIX_SOCKETS@|\'$(NO_UNIX_SOCKETS)\'|" \
+		-e "s|@PAGER_ENV@|\'$(PAGER_ENV)\'|" \
+		-e "s|@SANITIZE_LEAK@|\'$(SANITIZE_LEAK)\'|" \
+		-e "s|@SANITIZE_ADDRESS@|\'$(SANITIZE_ADDRESS)\'|" \
+		-e "s|@X@|\'$(X)\'|" \
+		-e "s|@FSMONITOR_DAEMON_BACKEND@|\'$(FSMONITOR_DAEMON_BACKEND)\'|" \
+		-e "s|@FSMONITOR_OS_SETTINGS@|\'$(FSMONITOR_OS_SETTINGS)\'|" \
+		-e "s|@TEST_OUTPUT_DIRECTORY@|\'$(TEST_OUTPUT_DIRECTORY)\'|" \
+		-e "s|@GIT_TEST_OPTS@|\'$(GIT_TEST_OPTS)\'|" \
+		-e "s|@GIT_TEST_CMP@|\'$(GIT_TEST_CMP)\'|" \
+		-e "s|@GIT_TEST_CMP_USE_COPIED_CONTEXT@|\'$(GIT_TEST_CMP_USE_COPIED_CONTEXT)\'|" \
+		-e "s|@GIT_TEST_UTF8_LOCALE@|\'$(GIT_TEST_UTF8_LOCALE)\'|" \
+		-e "s|@NO_GETTEXT@|\'$(NO_GETTEXT)\'|" \
+		-e "s|@GIT_PERF_REPEAT_COUNT@|\'$(GIT_PERF_REPEAT_COUNT)\'|" \
+		-e "s|@GIT_PERF_REPO@|\'$(GIT_PERF_REPO)\'|" \
+		-e "s|@GIT_PERF_LARGE_REPO@|\'$(GIT_PERF_LARGE_REPO)\'|" \
+		-e "s|@GIT_PERF_MAKE_OPTS@|\'$(GIT_PERF_MAKE_OPTS)\'|" \
+		-e "s|@GIT_PERF_MAKE_COMMAND@|\'$(GIT_PERF_MAKE_COMMAND)\'|" \
+		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
+		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
+		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
+		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
+		GIT-BUILD-OPTIONS.in >$@+
+	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8c71f5a1d0290c9204e094fb266f10c7b70af9fb..985004f5943128483e2138cd61aca8bd8ccbd240 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1125,27 +1125,47 @@ if(NOT PYTHON_TESTS)
 	set(NO_PYTHON 1)
 endif()
 
-file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SHELL_PATH='${SHELL_PATH}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TEST_SHELL_PATH='${TEST_SHELL_PATH}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PERL_PATH='${PERL_PATH}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DIFF='${DIFF}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_ICONV='${NO_ICONV}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
+file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_CONSUME)
+string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
+string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
+string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
+string(REPLACE "@NO_CURL@" "${NO_CURL}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_EXPAT@" "${NO_EXPAT}" git_build_options "${git_build_options}")
+string(REPLACE "@USE_LIBPCRE2@" "" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PERL@" "${NO_PERL}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PTHREADS@" "${NO_PTHREADS}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_PYTHON@" "${NO_PYTHON}" git_build_options "${git_build_options}")
+string(REPLACE "@NO_REGEX@" "" git_build_options "${git_build_options}")
+string(REPLACE "@NO_UNIX_SOCKETS@" "${NO_UNIX_SOCKETS}" git_build_options "${git_build_options}")
+string(REPLACE "@PAGER_ENV@" "'${PAGER_ENV}'" git_build_options "${git_build_options}")
+string(REPLACE "@SANITIZE_LEAK@" "" git_build_options "${git_build_options}")
+string(REPLACE "@SANITIZE_ADDRESS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@X@" "${EXE_EXTENSION}" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_OS_SETTINGS@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@TEST_OUTPUT_DIRECTORY@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_CMP@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_CMP_USE_COPIED_CONTEXT@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_UTF8_LOCALE@" "" git_build_options "${git_build_options}")
+string(REPLACE "@NO_GETTEXT@" "${NO_GETTEXT}" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_REPEAT_COUNT@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_REPO@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_LARGE_REPO@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_MAKE_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
+string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
 if(USE_VCPKG)
-	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
+	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
+file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS ${git_build_options})
 
 #Make the tests work when building out of the source tree
 get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6c60e8adae8c3daf39ceb8afc8c4938fa7fc48a4..cca6a09c68cb9d08c37b0ded3150118767153b9f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,12 +35,6 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-if test -z "$TEST_OUTPUT_DIRECTORY"
-then
-	# Similarly, override this to store the test-results subdir
-	# elsewhere
-	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
-fi
 GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
@@ -92,6 +86,15 @@ export LSAN_OPTIONS
 prepend_var UBSAN_OPTIONS : $GIT_SAN_OPTIONS
 export UBSAN_OPTIONS
 
+# The TEST_OUTPUT_DIRECTORY will be overwritten via GIT-BUILD-OPTIONS. So in
+# case the caller has manually set up this variable via the environment we must
+# make sure to not overwrite that value, and thus we save it into
+# TEST_OUTPUT_DIRECTORY_OVERRIDE here.
+if test -n "$TEST_OUTPUT_DIRECTORY" && test -z "$TEST_OUTPUT_DIRECTORY_OVERRIDE"
+then
+	TEST_OUTPUT_DIRECTORY_OVERRIDE=$TEST_OUTPUT_DIRECTORY
+fi
+
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 then
 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
@@ -100,6 +103,13 @@ fi
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
+if test -z "$TEST_OUTPUT_DIRECTORY"
+then
+	# Similarly, override this to store the test-results subdir
+	# elsewhere
+	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
+fi
+
 # In t0000, we need to override test directories of nested testcases. In case
 # the developer has TEST_OUTPUT_DIRECTORY part of his build options, then we'd
 # reset this value to instead contain what the developer has specified. We thus

-- 
2.47.0.366.g5daf58cba8.dirty

