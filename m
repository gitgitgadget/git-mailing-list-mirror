Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148D192D8B
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528637; cv=none; b=lTUCDIe+Qfwcyw/Ut9ZIOe+OneXineh84nFIA+udP12+T5AsflLWq2ypJ+4aHQ/xHmgy4JkMB6U4qiLqlxWS+0pseiQSwG6RXmKfboP1P5B43WzGNjn6OVIcAw9hqmvc/zVDcm70x59di7EQRQiajjIIsu+VbfrZSIScPT3klgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528637; c=relaxed/simple;
	bh=pvBWFiTXUxaEHkJ4gbHQbBr65o91QebyJmsWOJJJDCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBw5k0NzFVgzgHYOEqwq9/XVbB10oHmO/9Vgbib9V4HcLTZoFWY2Bx2TharapUMBkzRm6AlLDRoE9blXrA3GtoWcZ70Q3enUwEeP3fHrgojR/Kwfl1fYru9sJ5TNdsH933Pefx4PuT8vGIu8WDrot51oEiX+gwr8DzsWk9HjO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yIFSMs4/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/r7CyTF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yIFSMs4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/r7CyTF"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E1311140135;
	Mon, 25 Nov 2024 04:57:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 25 Nov 2024 04:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528633;
	 x=1732615033; bh=vdd+cz6YB89M5tPDgldR2LU+rQ4wypNI17J7W9nGBRY=; b=
	yIFSMs4/nYyboIndTiHvMSQlzediJSyT3Ft72zQcMfS4cH62MolJEw01Yb+LDCxL
	bQ/b2S3dWS2t5Mfk975UFx5r7FZEHoIqlEkuR/BL/PTFbTZyOPYPBeT8s21YQTQM
	c/wMraHh6bsvM6ANqq86K7yyrHeBPcJKiRSexREy0is/AEEGY6PAbX+ZlKVzHEWs
	qE1gTktg2jP6G/OXwpHtq245JVV8HrqNl+m1b+EEbmW/gjGy8UEXyVIxrVqQPhgW
	h1GFyNRTHG4gHiWveSAts6VPAzXIFXim4WF0fNlCicZ/Kmy0xGjPZatZYqjBPZ/o
	AwtGLOCf5PG6JRYjf65KSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528633; x=
	1732615033; bh=vdd+cz6YB89M5tPDgldR2LU+rQ4wypNI17J7W9nGBRY=; b=R
	/r7CyTFKZPQLxtwCF3Mw3AIXnO1HlsOec//fF7VKNF+kCajpZwwnVspAD6wHzfjD
	tExjNd4V6wmA286NtixmNMPND1+J9FbN+4RQvi61OcTIheej/lZnjK5BBGrCAQe8
	j40k2y3etb31qGTA0rUXOVZ0Itz1QxIQzMdi8ZT+/6g8fxlcM9ksfp4ENQpPtvsd
	wtFWEtWOWS3SIegyJLnBpBr4Of+UDVbFTybXpBqwZBPCIqaYFucGyWavvDAmj4r6
	3uUdMZ8BAzUVE6pCQzstUpBlrqA7kulbvJ0Oj4z4bZ98e/GAA9XSj1MnnyS9qtac
	x2CZgmmq35iBY5IaQjXRg==
X-ME-Sender: <xms:-UlEZxT-Ya1Fa5hlb4ajlmfcB-Flem3CbB1srRtr8IpX0of9hOBjbQ>
    <xme:-UlEZ6xCZbcbWUMFxfMvFMUHpAPkWDtrY-DY7u_L2o3nyYFDzBqGQ7FVhS4dF0eWA
    BOEmdosPG7-HLXt-Q>
X-ME-Received: <xmr:-UlEZ21D9KXoBmVqoTSVXNThmQG5Dgispy5oMG5H5yu37tUdmV4FcZ1G9XYrizBa8KnCf3bR47ozkGLtOQ1Xi3XdxCMoYpubD_AwfsqAnjNnQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:-UlEZ5AP9BDXDBNLIE-ugNoAdMHa4lp1sxxzOShzqFver_1WllB7Bw>
    <xmx:-UlEZ6jE6fKc7Sqvj91fTK0J3Qbh0Yl6C74G0fOVRgnd92rb9rzxQQ>
    <xmx:-UlEZ9pH_u-rZDDk8f-CU6ltwFF-w33Bwu2Dmm82lx5KDlTY4EeU0g>
    <xmx:-UlEZ1gFaF9fW2VhekSpv8FRkUFuhWBTcPI2gP6HQ8IE34PBm_UVyg>
    <xmx:-UlEZxoFfnlxrU_xywSyV45CoeksmNyL2y69FMsK92HqNIveyVVekyyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49f3e366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:49 +0100
Subject: [PATCH v9 01/23] Makefile: use common template for
 GIT-BUILD-OPTIONS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-1-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty

