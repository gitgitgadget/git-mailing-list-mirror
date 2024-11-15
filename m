Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4A17C21E
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655300; cv=none; b=MSmX3AXkMqasK/2tfrK9coshmiQkqeVumuHagZQuLHzKXxIHrG9pEKkCa91ccSlDdkFyblFsypyNIthqWaOUMs8I5g7kxhLBBO3CsAbuxg63LAMXdGFyrrsZxTu3OkIOsaCZhsyANfzpoDOqhRp7LjDNRj2RF4HEsk8b4NdZvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655300; c=relaxed/simple;
	bh=EExI5B2cM19nwkJfuzMz0Ru90KwVMT0fqRZN04+qn/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoCk2QAGqEe3UeeNBcZ3Y+4eB3vE1UnvxrhFwcMc6kmQGYs9LJ/g7tA9o6LCzSHceTraqBOp61y79rtUg6jnV15XdmMJQCdsC1+xAbBaKnc7DPOWJ1u83oLYKUaCfc8bFX6147HosudnwGHCdFXQYAk9h8fK38lB6ll8yA4N22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A8tIIS7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfkA7gdA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A8tIIS7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfkA7gdA"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A61FB114018F;
	Fri, 15 Nov 2024 02:21:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 15 Nov 2024 02:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655296;
	 x=1731741696; bh=JVoGKqLAOY3ctOlWA6qf3GwLVLoTKq9jm7G6DsNdAXk=; b=
	A8tIIS7toYi7WCx8tqwBXRYKYL4HHgz8L/Sy1I3IRxr0qzhiVC23p2yPe8T1HXc1
	qAFXH3vAI0BLogDBeFn8W862ad57lw5loQOO2R89ctobMtx61v1c9J7DLmcOav6n
	2owrF0XfUtno26KvdggmtgNEKfqgR/z3SlgRNh+MoR4W6SMoejcpz/YMsj7jScvZ
	568iO9RUuvftg0j6pQaK0D18uqDikinqPc4y07ic55jTIx6b1Lt6/kaQyLIzRmE2
	gtJgiAQ7gbHLCDpUEbu0+mTMrPXt7QRDdKmmXdygbShyyUhXlE10R4BN9Kciv9Jm
	LGuEIn/a39OI7Xg6YY8O1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655296; x=
	1731741696; bh=JVoGKqLAOY3ctOlWA6qf3GwLVLoTKq9jm7G6DsNdAXk=; b=T
	fkA7gdAzSnXdNvgCA+71ZL6zH0a2HGN360mpzPB73jMPn1vWpGnlh9iq4zSWaDbm
	KQOGKAscxTwmRJWI+7WYps4ycODPx4yvEb8K7/OdJqqNxT0hWnoa9d1r28E0IMvV
	PvaBRXMdWEMWtIoErtC7b7HpKW8CdbalO+fT6e1F3/8sV5gZATpaP89rCj+tMgsb
	tCCCWh2qot+cXnu+kg+bYfDY27DULBfH+6nWysCXwL085OaOwfOme/7wnTlzl9OQ
	ddfhgRUqXdhevIscLXve/e8jeLsHC2Ofu7bbNtjsx7rl1lVQLgy7TEURdxP0FPvR
	qVqFbsE23w+DMDGZb5A3A==
X-ME-Sender: <xms:f_Y2Z1iY0lU8KabP-2ws_mHs98lLowuWwATIuSCbL9KOtIfJB6LcPg>
    <xme:f_Y2Z6AJoMheFgTtGbn_rznymZdTCvigmabfy1bcFEWW6lrvQ8znNq_lyAOkJGawe
    cb5NtFgnSGxwjz9Sw>
X-ME-Received: <xmr:f_Y2Z1Exqss47AXImsRo3pwkZ-B8FrahUG0sf6rUm-1efhZ14x6njkJdi8tjDy9NYqXGyiO_AkFjj1M4w5BPn7z9GTncYUtl8BS-pqi6PE50i4Zm8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    gthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:f_Y2Z6QxVZneBPu7QiKk4_Jig6Am80a9xH4pLfz0bj9aWPzd4Hi3lg>
    <xmx:f_Y2Zyw_UwsIdMceTTmhMTFLx6NtFGjGS1gmkNZacZFezS4VHV6_yA>
    <xmx:f_Y2Zw4KqoJ0VjhrtiUxw2D9pNxOpPaYzGE0Exy1r0oSca0bID18ZQ>
    <xmx:f_Y2Z3xt9ELJyis9PsALuJl3XDOZM8AUv7en73g4-lertwTfTeVIzA>
    <xmx:gPY2Z3r09zYXqEJNMqdSEz8wWqaprd1_IvKT8amqI8EsX8nbZmcSEf59>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76fd4c53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:13 +0100
Subject: [PATCH RFC v7 01/22] Makefile: use common template for
 GIT-BUILD-OPTIONS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-1-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
 GIT-BUILD-OPTIONS.in                |  36 ++++++++++++
 Makefile                            | 109 +++++++++++++-----------------------
 contrib/buildsystems/CMakeLists.txt |  58 ++++++++++++-------
 t/test-lib.sh                       |  22 ++++++--
 4 files changed, 130 insertions(+), 95 deletions(-)

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
index d06c9a8ffa7b637050c9619a367fbe61e7243a74..962df75635a8cbf7114970ddfe7948ff17c65fdc 100644
--- a/Makefile
+++ b/Makefile
@@ -3164,76 +3164,45 @@ GIT-LDFLAGS: FORCE
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
+		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
+		GIT-BUILD-OPTIONS.in >$@+
+	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8974bb9fa202a0556fd9b16d105836d8cb66f543..e5d258419ddacd837c4abb07709fb3252fca5c3c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1117,27 +1117,47 @@ if(NOT PYTHON_TESTS)
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
index a278181a0568a2422ab1e7f007bc016b95a58e63..19057faa73925f619750fec30f05c3e5a1ba05ac 100644
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
2.47.0.251.gb31fb630c0.dirty

