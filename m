Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4B1F63C8
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308015; cv=none; b=IpSgEzLhoNNWCNovYUeFfocbRIqcej/LpWbO3c8nltSBUJ9txjg20g0hUPV4EZrGHd+CfSaIfyRBrcedtbFH0NIeMGYXC+mNdNCADgWfXihtLAk/Kso3AoTuYLHCxu3iThYvWSHynmMGVV4kdKJImAJYnjitjui2u2XGEZZS26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308015; c=relaxed/simple;
	bh=VLERwtbXArgwWaDZpV7C1qPIn9xcGXzuP7GfxvZ7Fgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFp9sMs58/seKzMFAfWNxmwpqvaEuCzMULiq45VDXHSQ8ko0FCJRViDKUd12M+rrTOcxGMv48W/HpwRbjbrL7EjY19k7gAgK9KrPPJJ6zgAEqPWXTW1LEK1pl9fYSMduU/lvGR0+s6rscLCyeaVlF3dZfJp7KcRgQ+RhrP7N7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TjI7WD1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nku66FKP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TjI7WD1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nku66FKP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E1B0D114011B;
	Fri, 27 Dec 2024 09:00:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 09:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308012;
	 x=1735394412; bh=p4Eynlh7t1I9srpHERlknVz7ycPAwPscDAzTjmVxmi0=; b=
	TjI7WD1HC5L4Pf1pNM7r2ZcoeIzyUtLLz8slxJFCrJniDW2TG3VMh1OlnOkJ327A
	XYSe8wiic/EZn47S7Q6QQC5j5E95c8evfhtMq66qldf1Uu55TNEQzGr8oSePMl7+
	6IszttN5FqKMpJMgbgSX8q0xz+GMUWNRnQLWyp52yQ8hrf/7qvLFjd5QStsLKGLM
	eJPJe0s6mShi4TflnuklgzQQF6VdfR/+bgQiEeymjL7Mu6INObJq8qsfthCC2/7r
	eRqa/74ZGTPdZL0QV22Ac1KqwycsNVZ618GtzwUfr7zz7JecsJQF8oew7VTTTjLp
	26wPcEql6BSmZPm5jaLZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308012; x=
	1735394412; bh=p4Eynlh7t1I9srpHERlknVz7ycPAwPscDAzTjmVxmi0=; b=n
	ku66FKPd6rGz8L8fKLNW0eb3OjTMsX9A9rGsAL/RfiDRPefy79xue1uD6sNPt/oz
	xphiIE2SmlynJ5E26z7i5SHztYBc5S0ItJ8Fdx2t3p58ToDVwkm61khYISWm1Xek
	s9dsjCsdePDNYZwopZMg2jvYdO2P0QyUkENwytTC55wH/GK4fcNVk6Uf8cI3Rqi9
	JX7ynNwYmTirkonHtoOCnLgx4xwmeCrHrV8mDex5ydt/VLRPhOI3OTMKmBMBHdIf
	0O7srVcua6OLw4atxXk4mIqe4vL7RlgIDA6+udl6lh45+Db1lGD7O7e8dhdCPMYG
	CxllWZJFlBIBErBjK9Q6w==
X-ME-Sender: <xms:7LJuZ4DhsFo92on_C-IEY6w8ULzQN-Reur4maff6RpIbtlhKhQOqJA>
    <xme:7LJuZ6gf37EVFw8SvZx_idSDhBTdi2ZrCHENY9LAgtA-gvZIQ9y1XM8LVIs4G3jeu
    YQY_V5uoUdMwTmx0w>
X-ME-Received: <xmr:7LJuZ7nCsQiJfssdHv-6gPbmhmNpVfZnYDNFVI7di2w7njxS5UF7Bkg5avrsf9mxyLJBIb9K1Qw30qiN6fVK7OnxwTQ6s5FlJAByEdA6j7a9yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:7LJuZ-yKEZ5JY-kp4HVbN9j72q6LlVVfr-7aJy2CrT2BB7kCKqv3yw>
    <xmx:7LJuZ9TyGwZpX0Ng03N9EJtBs59KtznAq9oeN-QqB1Vz3ByF_3Jg8A>
    <xmx:7LJuZ5Z4Z-qX3LbugZ3lgBVilo86Tk5FXRa_cv4XupePlh3G-TZHRw>
    <xmx:7LJuZ2StSnV5ozo80iYRxTJazxwLeNcCNgchWhGGVoMQdRc1dWgWUQ>
    <xmx:7LJuZ4cG26ZNB5y764z0jLiwpmNkRLCjfCPmNvxlr1sUqBMdXq3IAvxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac73772f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:40 +0100
Subject: [PATCH v2 12/12] Documentation: wire up sanity checks for Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-12-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Wire up sanity checks for Meson to verify that no man pages are missing.
This check is similar to the same check we already have for our tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/.gitignore  |  1 +
 Documentation/Makefile    | 16 ++++++++++++++++
 Documentation/meson.build | 31 +++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 649df89474d357ccc91109b5c35fe2d0910f968a..9f4bb3c4bf9e9e84f740b3210c570ec25e15e4fe 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -12,6 +12,7 @@ cmds-*.txt
 mergetools-*.txt
 SubmittingPatches.txt
 tmp-doc-diff/
+tmp-meson-diff/
 GIT-ASCIIDOCFLAGS
 /.build/
 /GIT-EXCLUDED-PROGRAMS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index e284ec8b98d6187ecb73011f6e490610dd3e7370..aedfe99d1d35889aa24ed6b9085e614dbc240096 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -339,6 +339,7 @@ clean:
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) GIT-ASCIIDOCFLAGS
 	$(RM) asciidoc.conf asciidoctor-extensions.rb
+	$(RM) -rf tmp-meson-diff
 
 docinfo.html: docinfo-html.in
 	$(QUIET_GEN)$(RM) $@ && cat $< >$@
@@ -494,6 +495,20 @@ lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
 lint-docs-manpages:
 	$(QUIET_GEN)./lint-manpages.sh
 
+.PHONY: lint-docs-meson
+lint-docs-meson:
+	@# awk acts up when trying to match single quotes, so we use \047 instead.
+	@mkdir -p tmp-meson-diff && \
+	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
+		grep -v -e '#' -e '^$$' | \
+		sort >tmp-meson-diff/meson.txt && \
+	ls git*.txt scalar.txt | grep -v -e git-bisect-lk2009.txt -e git-tools.txt >tmp-meson-diff/actual.txt && \
+	if ! cmp tmp-meson-diff/meson.txt tmp-meson-diff/actual.txt; then \
+		echo "Meson man pages differ from actual man pages:"; \
+		diff -u tmp-meson-diff/meson.txt tmp-meson-diff/actual.txt; \
+		exit 1; \
+	fi
+
 ## Lint: list of targets above
 .PHONY: lint-docs
 lint-docs: lint-docs-fsck-msgids
@@ -501,6 +516,7 @@ lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
 lint-docs: lint-docs-manpages
+lint-docs: lint-docs-meson
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 4d9511156502653292144fe6962bd3411558d96a..2a26fa8a5fedc0f46a82fcc31bf1d6457f6d082c 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -471,3 +471,34 @@ if get_option('docs').contains('html')
   subdir('howto')
   subdir('technical')
 endif
+
+# Sanity check that we are not missing any tests present in 't/'. This check
+# only runs once at configure time and is thus best-effort, only. Furthermore,
+# it only verifies man pages for the sake of simplicity.
+configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.txt', 'git-tools.txt' ]
+actual_manpages = run_command(shell, '-c', 'ls git*.txt scalar.txt',
+  check: true,
+  env: script_environment,
+).stdout().strip().split('\n')
+
+if configured_manpages != actual_manpages
+  missing_manpage = [ ]
+  foreach actual_manpage : actual_manpages
+    if actual_manpage not in configured_manpages
+      missing_manpage += actual_manpage
+    endif
+  endforeach
+  if missing_manpage.length() > 0
+    error('Man page found, but not configured:\n\n - ' + '\n - '.join(missing_manpage))
+  endif
+
+  superfluous_manpage = [ ]
+  foreach configured_manpage : configured_manpages
+    if configured_manpage not in actual_manpages
+      superfluous_manpage += configured_manpage
+    endif
+  endforeach
+  if superfluous_manpage.length() > 0
+    error('Man page configured, but not found:\n\n - ' + '\n - '.join(superfluous_manpage))
+  endif
+endif

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

