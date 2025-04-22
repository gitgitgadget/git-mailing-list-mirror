Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409841EB9FA
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310983; cv=none; b=Hx+AeA4UN8Myd6r4HtpDNM6B1iebofbhfrTWi+yvbWX0F6tvc2kJHXPZzd6mXSoatuBOpUHad9Gp3UqEoPZ9ltDFNgRPDjo2ukyRWDGJkcVL6I79dgV1x7NdXbmH0Rewf9RH6qxOUKFYDRkJ8g8UEtGHXkc8joTDzGSOKfltNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310983; c=relaxed/simple;
	bh=9Zbqcb+IbJo+RQtmiRA8E3ayjuc8ON1AquT5eLuQy6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=u6BxCWAcZo5vVNFKPT5j4qKAJ+z6n+/ifopHrtsxAgBxjVF0bseBf2k0CjNsDg+HrSX3lAQTufP8GjcgzyuTyCCLUdUxtd1r/C79Gu1MEd0865QrX5yupTUnKZKTdljC2ak7RJGXzpkDwSdIHyD9Axeea5alHIOr6oDiMAHLvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yh8dqVvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5CAYPRY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yh8dqVvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5CAYPRY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EA242540099;
	Tue, 22 Apr 2025 04:36:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 04:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745310979;
	 x=1745397379; bh=Dzwm5DyCmoNX+wT6bjD6XQJHYqboHhGOjxESufYFhmU=; b=
	Yh8dqVviDKUq3xXCLDwH1Hk/bqtV2SHCXNxSHrNbfW5sCyRKycyC9kJbsvwcO/NL
	JlwsIpMkWjNLswuGJSvUkewxC2o26/S8PYId/v/x3rp4tOmLk+D1BQm97Feml4uC
	QqHHNF8ZyU+BuYjhqAGnNTLa9NNlbfoIVk52WCbfg2L8/zBnm5QxHq1dKk6JQstt
	0kYIrrEGBmj0yb2fm1Jl7ZHATkLdjMzzc672YeHIpiAK/QO0Jfha2iBisMtoAPad
	QCU7zxkt/o5WGwCIyebW0kovU/UpCM3Lj6lb6hssfCHXk+t5Celq2eziHPRfIwiT
	ErqGpqiSderTsBbm3mFhWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745310979; x=
	1745397379; bh=Dzwm5DyCmoNX+wT6bjD6XQJHYqboHhGOjxESufYFhmU=; b=m
	5CAYPRYCXPMSkdtrTXhr2wWB4UmwS0uE/VQyOowea3bosbiUds8WzXdbMKtG1K+U
	zotdwaVMg7zYsPclGYmwm2tB+xLn0lrHfxRWdsSuIZXWCPEBE4VIlkQYxstTPnI2
	xSaREATG5JnLaXIoEwzXrnQfEeqt968XPgm1k7x7tv4HfTk6tshx0rHrI/SCDfCp
	Qw5LyAaF7cWod8KllnYTy/X3clXJaYcWA2DPV556w0gN62sMBC0w7U7V7oyLXEmh
	VuOrqkybUunfy1hbxN3duCLYEiaNoW4p+nQClOqzc5sWn7VZFtuunteQhzdW3IYi
	IYEdsG5dtgX1v78yXGg7Q==
X-ME-Sender: <xms:A1UHaABZ1s6QfmbL2yxe2_ap-PD118hq4aDUBJIcT57ogyE7d2I2RQ>
    <xme:A1UHaCgBMPlpxORPN9R0Tuh7OemO35bdw-IlyW1Bokjokb0gVWQ_9MmFXlPOB2JGX
    kRM27Fh_6QIfW9b3Q>
X-ME-Received: <xmr:A1UHaDnGuvI8ZAIQjcPZ5vWOUd7vBSsAaONE0fgYT5vTnqHPWNG2bRYCzKEgJsrFE_CR-wvHM7KYgdk5xNV3KCTZon_edXT9pJNK49NW__I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeiuddvvdefgeduhfetgeeuffejlefhkeehfeek
    teeuteelhedutdeifeektedtieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhmiiesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlihhs
    thhsodhgihhtsegrkhhshhgrhidrihhs
X-ME-Proxy: <xmx:A1UHaGwIDZcRE2E6vVUuHldQ0dQPs-hyvk_D4NhFMNjqcZgVOlZRdQ>
    <xmx:A1UHaFRi8a2MUQrhi8rm3ngfKuHWCidkbFEH2j32A5Z_aT0zW48UWg>
    <xmx:A1UHaBbydOwX2fmyWCj4pZN_PDZXjqUnTjeZtDfzj2nphfSYXyCFcg>
    <xmx:A1UHaORoMHKJ1pvJ48nCxXtEDFsfbGrwb4El38B1Gz3FH8cWu6zuEw>
    <xmx:A1UHaE9kwKh6D9t4pJ5KESn5RxaTwiw-jP0KZksvQRo8eUvS2kSTF-Zm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 04:36:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69a69c68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 08:36:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 10:36:11 +0200
Subject: [PATCH v2] contrib/completion: install Bash completion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-b4-pks-meson-install-completions-v2-1-ab29d399bc6c@pks.im>
X-B4-Tracking: v=1; b=H4sIAPpUB2gC/5WNQQ6CMBBFr0Jm7RjatAFdeQ/DosWpTISWdAjRE
 O5u5QYu38//728glJkErtUGmVYWTrGAPlXQDy4+CflRGHStbW3qBr3B+SU4kaSIHGVx44h9mua
 RlrIVJGutDsqR9gGKZs4U+H1c3LvCA8uS8ud4XNUv/UO+KlTYuoZ86y+6Nf5W+meeoNv3/Qvhu
 9jLzQAAAA==
X-Change-ID: 20250407-b4-pks-meson-install-completions-e5552f1ae2bf
In-Reply-To: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
To: git@vger.kernel.org
Cc: Akshay Hegde <lists+git@akshay.is>, Todd Zullinger <tmz@pobox.com>, 
 Junio C Hamano <gitster@pobox.com>, Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The shell completion scripts in "contrib/completion" are being tested,
but none of our build systems support installing them. This is somewhat
confusing for Meson, where users can explicitly enable building these
scripts via `-Dcontrib=completion`. This option only controlls whether
the completions are built and tested against, where "building" is a bit
of an euphemism for "copying them into the build directory".

Teach both our Makefile and Meson to install our Bash completion script.
For now, this is the only completion script that we're installing given
that Bash completions "just work" with a canonical well-known location
nowadays. Other completion scripts, like for example the one for zsh,
don't have a well-known location and/or require extra steps by the user
to make them available. As such, we skip installing these scripts for
now, but we may do so in the future if we ever figure out a proper way
to do this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch is a result from the discussion at [1]. Thanks!

Changes in v2:
 - Only install Bash completion for now.
 - Also install Bash completion via our Makefile.
 - Link to v1: https://lore.kernel.org/r/20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im

Patrick

[1]: <Z-uLqQd7QHZq-tB7@akshay.is>
---
 Makefile                       |  6 ++++++
 contrib/completion/meson.build | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Makefile b/Makefile
index ac32d2d0bda..118592414b5 100644
--- a/Makefile
+++ b/Makefile
@@ -618,6 +618,7 @@ prefix = $(HOME)
 bindir = $(prefix)/bin
 mandir = $(prefix)/share/man
 infodir = $(prefix)/share/info
+bash_completion_dir = $(prefix)/share/bash-completion/completions
 gitexecdir = libexec/git-core
 mergetoolsdir = $(gitexecdir)/mergetools
 sharedir = $(prefix)/share
@@ -2321,6 +2322,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
+bash_completion_dir_SQ = $(subst ','\'',$(bash_completion_dir))
 perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
 localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
@@ -3565,6 +3567,10 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
+ifndef NO_BASH_COMPLETION
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bash_completion_dir_SQ)' && \
+	$(INSTALL) -m 644 contrib/completion/git-completion.bash '$(DESTDIR_SQ)$(bash_completion_dir_SQ)/git'
+endif
 
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
diff --git a/contrib/completion/meson.build b/contrib/completion/meson.build
index 3a9ddab5940..576125b083d 100644
--- a/contrib/completion/meson.build
+++ b/contrib/completion/meson.build
@@ -14,3 +14,21 @@ foreach script : [
     )
   endif
 endforeach
+
+# We have to discern between the test dependency and the installed file. Our
+# tests assume the completion scripts to have the same name as the in-tree
+# files, but the installed filenames need to match the executable's basename.
+if meson.version().version_compare('>=1.3.0')
+  fs.copyfile('git-completion.bash', 'git',
+    install: true,
+    install_dir: get_option('datadir') / 'bash-completion/completions',
+  )
+else
+  configure_file(
+    input: 'git-completion.bash',
+    output: 'git',
+    copy: true,
+    install: true,
+    install_dir: get_option('datadir') / 'bash-completion/completions',
+  )
+endif

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250407-b4-pks-meson-install-completions-e5552f1ae2bf

