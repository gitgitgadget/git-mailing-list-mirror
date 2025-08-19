Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F725A324
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591526; cv=none; b=PhYADmM0zOWe8EGdeowFS/WhzOaWzKvyJVweT1RrL+/Fiz2oY4C6paLCGrGf95NxUbggw0Jit13npRzIVYwL9z4jgH4YILyYMzBj1A2XgP2mYndxjpsuYQPMd7FxjUQqxIypzPSdurDdfgF/JxoUnE8Rkg1aHb8ST4gXfI7knJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591526; c=relaxed/simple;
	bh=Yvl9tiFO1GAqJfYkS638im7Ygn16PlWFrqZHAqXWakM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcrTUltsl9M1UsLf3bl9754xXjBFaiXr3MFkh2WouT/xhMGiO0SosEN1BWB9G2hXbXNWY+eivMtYhxfWTdmsLe0xUfeJvjZOjGDfquQQ3VXAia18cY83Ya+jCKPEuz3NVn+1CG7b9ZR3FpXtJbUMQT7HYvaituG6fE/U6d/3FN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hvifCf5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKE+YFkp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hvifCf5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKE+YFkp"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5119D7A0277;
	Tue, 19 Aug 2025 04:18:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Aug 2025 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591523;
	 x=1755677923; bh=p+9vTVXUlpoonikd9R4PnpmU8+d1pbtY2XruWB6BVX0=; b=
	hvifCf5G0/opBJVirRUb3/B2TMKNqpPX9nsE74R0V6yTW46NH/s15NExQ+2onBDA
	7cej0kUkqW5W7yqEyWlU87pPi5X7ksu4xYZDVUljny0mMrQ8U/YOEqescx0LVQay
	++e7N0aq7tA8syQ030Gps4jxl1PTjGvQecjIr0hzAcvPadzhn1r5GutYrFK/Txvh
	NE+wLzSlnRhN9h3J9twLsFDX3btckFBHFRADZ8SA0jqxaio3BWp4EjJ/uigeJpff
	iNwpWMRlU7G9EwnH0F/lS70dme+/66vaofBcSGzuCBZZ0X2fB+If15o41z6FetV+
	8tm5j6BcfnmDnnMP+y3QFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591523; x=
	1755677923; bh=p+9vTVXUlpoonikd9R4PnpmU8+d1pbtY2XruWB6BVX0=; b=h
	KE+YFkpCOTmrsnppl+PIooqd1vXXH+EeiepgGSdoSZ6hpqMnkqG4hiY7b8/uRh5a
	FCWH1j/fh0KFS6l70RO0EgULjGcyGXQ5hRYrgwzcRA446HzHFQjFkZpFfo698ylK
	GkF2ZwamwavZdPtMuHIFd1KniZTNZ7PpIjx/zE9GGdkbZPmNKHRsszVKWVo0r5cD
	a0LFpay9Wmr1cKm9lLDZ+qgZyvzO4/rx150Hv6afXcICGcarvcaouwxCv8SzeVBq
	TCQAz4lqV/ZsWBjcqqfqaTpKLaP+An+mlN4Y8GOP6mlSI4cc3U99bvXFQOtxW3J2
	j2Y6kBw/zEiVEieiEHvyw==
X-ME-Sender: <xms:YjOkaN1rDHBhdJYvylbJ3Ku_HXuX5kCrY3usGcGaNZSsRfBBTbUwtA>
    <xme:YjOkaERxNyiIrfZw6OqJ_C_Nk1TYAVJ9Y2UoiiJ3SNIQMDvTZistiKcgvXLx9n0-V
    ZmWWIptFwVuuiaWLg>
X-ME-Received: <xmr:YjOkaPua6HnQupLYdqILWmFy460K7Q8OjBLapCJgjgVpKEHaI7I6NFalWJT8yaafOX8Egj0OYRlWemX9j85of7xQ2TF-FHBVzvvKAjd-DSr3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedutedugffhjefgleeghe
    ehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:YjOkaJb8cVZSJQ3Jqv3NBJqrwDqDQG34_FjCtaRUYvryEvoNj0c23g>
    <xmx:YzOkaEs7V8NOIWqfRmODnsjxWq-xfJ-L0_SuylSNYxXplFVUCIPcQg>
    <xmx:YzOkaLFTIhr0gGFs39wgDMKOo4l5vUxYb9YVr6niN-EoFKH4MMTffw>
    <xmx:YzOkaPyfzE6zeuOfgdO7yNuQNpfF5ap8Dbxs1Puat5Q7SF77WYz5dg>
    <xmx:YzOkaOFCJdiPVWeIUUvytvOzB-4W8131lkePMstO2NFVde8Y2i7ArN9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:18:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d54925f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:18:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:18:35 +0200
Subject: [PATCH 1/3] git-gui: move into "subprojects/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-meson-tcl-tk-v1-1-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

The "git-gui" project has recently gained support for being built with
Meson, but it is not yet wired up in Git's own Meson build instructions.
"git-gui" itself is wired up as a standalone project, which means that
we can trivially make it available via `subproject("git-gui")`.

So far the theory. In practice thoguh the `subproject()` function comes
with a couple of limitations. Most importantly, all subprojects need to
be contained in the same directory, and that directory cannot be the
top-level directory of the parent project. Right now we use the default
subproject directory ("subprojects/") for a couple of fallbacks in case
some important dependencies couldn't be found.

This means that we cannot just include the "git-gui" directory as a
subproject as it lives in our root directory. There are three options:

  - We move "git-gui" into "subprojects/". It requires a bit of churn,
    but should otherwise not have any significant downsides.

  - We create a symlink pointing from "subprojects/git-gui" to the
    top-level directory. This may not work on Windows.

  - We can create a "git-gui.wrap" file that knows to pull a specific
    commit from upstream and build it. This would mean that Meson and
    Makefiles now have different sources of truth for which version of
    "git-gui" we build.

The first option feels like the most sensible solution. It creates churn
and requires us to adapt the pull-request workflow a bit. But this
should be a one-time cost.

In theory we could also rename the "subprojects/" directory by passing
the "subproject_dir" argument to our `project()` call. But the name
feels quite fitting for our purpose, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/SubmittingPatches                             |   2 +-
 Makefile                                                    |  12 ++++++------
 subprojects/.gitignore                                      |   1 +
 {git-gui => subprojects/git-gui}/.gitattributes             |   0
 {git-gui => subprojects/git-gui}/.gitignore                 |   0
 {git-gui => subprojects/git-gui}/GIT-GUI-BUILD-OPTIONS.in   |   0
 {git-gui => subprojects/git-gui}/GIT-VERSION-GEN            |   0
 {git-gui => subprojects/git-gui}/Makefile                   |   0
 {git-gui => subprojects/git-gui}/README.md                  |   0
 {git-gui => subprojects/git-gui}/generate-git-gui.sh        |   0
 {git-gui => subprojects/git-gui}/generate-script.sh         |   0
 {git-gui => subprojects/git-gui}/generate-tclindex.sh       |   0
 {git-gui => subprojects/git-gui}/git-gui--askpass.sh        |   0
 {git-gui => subprojects/git-gui}/git-gui.sh                 |   0
 {git-gui => subprojects/git-gui}/lib/about.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/blame.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/branch.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/branch_checkout.tcl    |   0
 {git-gui => subprojects/git-gui}/lib/branch_create.tcl      |   0
 {git-gui => subprojects/git-gui}/lib/branch_delete.tcl      |   0
 {git-gui => subprojects/git-gui}/lib/branch_rename.tcl      |   0
 {git-gui => subprojects/git-gui}/lib/browser.tcl            |   0
 {git-gui => subprojects/git-gui}/lib/checkout_op.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/choose_font.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/choose_repository.tcl  |   0
 {git-gui => subprojects/git-gui}/lib/choose_rev.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/chord.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/class.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/commit.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/console.tcl            |   0
 {git-gui => subprojects/git-gui}/lib/database.tcl           |   0
 {git-gui => subprojects/git-gui}/lib/date.tcl               |   0
 {git-gui => subprojects/git-gui}/lib/diff.tcl               |   0
 {git-gui => subprojects/git-gui}/lib/encoding.tcl           |   0
 {git-gui => subprojects/git-gui}/lib/error.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/git-gui.ico            | Bin
 {git-gui => subprojects/git-gui}/lib/index.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/line.tcl               |   0
 {git-gui => subprojects/git-gui}/lib/logo.tcl               |   0
 {git-gui => subprojects/git-gui}/lib/merge.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/mergetool.tcl          |   0
 {git-gui => subprojects/git-gui}/lib/meson.build            |   0
 {git-gui => subprojects/git-gui}/lib/option.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/remote.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/remote_add.tcl         |   0
 .../git-gui}/lib/remote_branch_delete.tcl                   |   0
 {git-gui => subprojects/git-gui}/lib/search.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/shortcut.tcl           |   0
 {git-gui => subprojects/git-gui}/lib/spellcheck.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/sshkey.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/status_bar.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/themed.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/tools.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/tools_dlg.tcl          |   0
 {git-gui => subprojects/git-gui}/lib/transport.tcl          |   0
 {git-gui => subprojects/git-gui}/lib/win32.tcl              |   0
 {git-gui => subprojects/git-gui}/lib/win32_shortcut.js      |   0
 {git-gui => subprojects/git-gui}/meson.build                |   0
 {git-gui => subprojects/git-gui}/po/.gitignore              |   0
 {git-gui => subprojects/git-gui}/po/README                  |   0
 {git-gui => subprojects/git-gui}/po/bg.po                   |   0
 {git-gui => subprojects/git-gui}/po/de.po                   |   0
 {git-gui => subprojects/git-gui}/po/el.po                   |   0
 {git-gui => subprojects/git-gui}/po/fr.po                   |   0
 {git-gui => subprojects/git-gui}/po/glossary/Makefile       |   0
 {git-gui => subprojects/git-gui}/po/glossary/bg.po          |   0
 {git-gui => subprojects/git-gui}/po/glossary/de.po          |   0
 {git-gui => subprojects/git-gui}/po/glossary/el.po          |   0
 {git-gui => subprojects/git-gui}/po/glossary/fr.po          |   0
 .../git-gui}/po/glossary/git-gui-glossary.pot               |   0
 .../git-gui}/po/glossary/git-gui-glossary.txt               |   0
 {git-gui => subprojects/git-gui}/po/glossary/it.po          |   0
 {git-gui => subprojects/git-gui}/po/glossary/pt_br.po       |   0
 {git-gui => subprojects/git-gui}/po/glossary/pt_pt.po       |   0
 {git-gui => subprojects/git-gui}/po/glossary/txt-to-pot.sh  |   0
 {git-gui => subprojects/git-gui}/po/glossary/zh_cn.po       |   0
 {git-gui => subprojects/git-gui}/po/hu.po                   |   0
 {git-gui => subprojects/git-gui}/po/it.po                   |   0
 {git-gui => subprojects/git-gui}/po/ja.po                   |   0
 {git-gui => subprojects/git-gui}/po/meson.build             |   0
 {git-gui => subprojects/git-gui}/po/nb.po                   |   0
 {git-gui => subprojects/git-gui}/po/po2msg.sh               |   0
 {git-gui => subprojects/git-gui}/po/pt_br.po                |   0
 {git-gui => subprojects/git-gui}/po/pt_pt.po                |   0
 {git-gui => subprojects/git-gui}/po/ru.po                   |   0
 {git-gui => subprojects/git-gui}/po/sv.po                   |   0
 {git-gui => subprojects/git-gui}/po/vi.po                   |   0
 {git-gui => subprojects/git-gui}/po/zh_cn.po                |   0
 {git-gui => subprojects/git-gui}/windows/git-gui.sh         |   0
 89 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 86ca7f6a78a..3aca70728c7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -699,7 +699,7 @@ rebase when I receive your patches).
 Some parts of the system have dedicated maintainers with their own
 repositories.
 
-- `git-gui/` comes from the git-gui project, maintained by Johannes Sixt:
+- `subprojects/git-gui/` comes from the git-gui project, maintained by Johannes Sixt:
 
         https://github.com/j6t/git-gui
 
diff --git a/Makefile b/Makefile
index e11340c1ae7..834b79ca7ec 100644
--- a/Makefile
+++ b/Makefile
@@ -2457,7 +2457,7 @@ endif
 
 all::
 ifndef NO_TCLTK
-	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
+	$(QUIET_SUBDIR0)subprojects/git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
@@ -3569,7 +3569,7 @@ ifndef NO_PERL
 endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
-	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
+	$(MAKE) -C subprojects/git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
@@ -3665,8 +3665,8 @@ GIT_ARCHIVE_EXTRA_FILES = \
 	--prefix=$(GIT_TARNAME)/ \
 	--add-file=configure \
 	--add-file=.dist-tmp-dir/version \
-	--prefix=$(GIT_TARNAME)/git-gui/ \
-	--add-file=.dist-tmp-dir/git-gui/version
+	--prefix=$(GIT_TARNAME)/subprojects/git-gui/ \
+	--add-file=.dist-tmp-dir/subprojects/git-gui/version
 ifdef DC_SHA1_SUBMODULE
 GIT_ARCHIVE_EXTRA_FILES += \
 	--prefix=$(GIT_TARNAME)/sha1collisiondetection/ \
@@ -3681,7 +3681,7 @@ dist: git-archive$(X) configure
 	@$(RM) -r .dist-tmp-dir
 	@mkdir .dist-tmp-dir
 	@echo $(GIT_VERSION) > .dist-tmp-dir/version
-	@$(MAKE) -C git-gui TARDIR=../.dist-tmp-dir/git-gui dist-version
+	@$(MAKE) -C subprojects/git-gui TARDIR=../.dist-tmp-dir/subprojects/git-gui dist-version
 	./git-archive --format=tar \
 		$(GIT_ARCHIVE_EXTRA_FILES) \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -3787,7 +3787,7 @@ endif
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
-	$(MAKE) -C git-gui clean
+	$(MAKE) -C subprojects/git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 63ea916ef5f..96388dbdd22 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -1 +1,2 @@
 /*/
+!/git-gui/
diff --git a/git-gui/.gitattributes b/subprojects/git-gui/.gitattributes
similarity index 100%
rename from git-gui/.gitattributes
rename to subprojects/git-gui/.gitattributes
diff --git a/git-gui/.gitignore b/subprojects/git-gui/.gitignore
similarity index 100%
rename from git-gui/.gitignore
rename to subprojects/git-gui/.gitignore
diff --git a/git-gui/GIT-GUI-BUILD-OPTIONS.in b/subprojects/git-gui/GIT-GUI-BUILD-OPTIONS.in
similarity index 100%
rename from git-gui/GIT-GUI-BUILD-OPTIONS.in
rename to subprojects/git-gui/GIT-GUI-BUILD-OPTIONS.in
diff --git a/git-gui/GIT-VERSION-GEN b/subprojects/git-gui/GIT-VERSION-GEN
similarity index 100%
rename from git-gui/GIT-VERSION-GEN
rename to subprojects/git-gui/GIT-VERSION-GEN
diff --git a/git-gui/Makefile b/subprojects/git-gui/Makefile
similarity index 100%
rename from git-gui/Makefile
rename to subprojects/git-gui/Makefile
diff --git a/git-gui/README.md b/subprojects/git-gui/README.md
similarity index 100%
rename from git-gui/README.md
rename to subprojects/git-gui/README.md
diff --git a/git-gui/generate-git-gui.sh b/subprojects/git-gui/generate-git-gui.sh
similarity index 100%
rename from git-gui/generate-git-gui.sh
rename to subprojects/git-gui/generate-git-gui.sh
diff --git a/git-gui/generate-script.sh b/subprojects/git-gui/generate-script.sh
similarity index 100%
rename from git-gui/generate-script.sh
rename to subprojects/git-gui/generate-script.sh
diff --git a/git-gui/generate-tclindex.sh b/subprojects/git-gui/generate-tclindex.sh
similarity index 100%
rename from git-gui/generate-tclindex.sh
rename to subprojects/git-gui/generate-tclindex.sh
diff --git a/git-gui/git-gui--askpass.sh b/subprojects/git-gui/git-gui--askpass.sh
similarity index 100%
rename from git-gui/git-gui--askpass.sh
rename to subprojects/git-gui/git-gui--askpass.sh
diff --git a/git-gui/git-gui.sh b/subprojects/git-gui/git-gui.sh
similarity index 100%
rename from git-gui/git-gui.sh
rename to subprojects/git-gui/git-gui.sh
diff --git a/git-gui/lib/about.tcl b/subprojects/git-gui/lib/about.tcl
similarity index 100%
rename from git-gui/lib/about.tcl
rename to subprojects/git-gui/lib/about.tcl
diff --git a/git-gui/lib/blame.tcl b/subprojects/git-gui/lib/blame.tcl
similarity index 100%
rename from git-gui/lib/blame.tcl
rename to subprojects/git-gui/lib/blame.tcl
diff --git a/git-gui/lib/branch.tcl b/subprojects/git-gui/lib/branch.tcl
similarity index 100%
rename from git-gui/lib/branch.tcl
rename to subprojects/git-gui/lib/branch.tcl
diff --git a/git-gui/lib/branch_checkout.tcl b/subprojects/git-gui/lib/branch_checkout.tcl
similarity index 100%
rename from git-gui/lib/branch_checkout.tcl
rename to subprojects/git-gui/lib/branch_checkout.tcl
diff --git a/git-gui/lib/branch_create.tcl b/subprojects/git-gui/lib/branch_create.tcl
similarity index 100%
rename from git-gui/lib/branch_create.tcl
rename to subprojects/git-gui/lib/branch_create.tcl
diff --git a/git-gui/lib/branch_delete.tcl b/subprojects/git-gui/lib/branch_delete.tcl
similarity index 100%
rename from git-gui/lib/branch_delete.tcl
rename to subprojects/git-gui/lib/branch_delete.tcl
diff --git a/git-gui/lib/branch_rename.tcl b/subprojects/git-gui/lib/branch_rename.tcl
similarity index 100%
rename from git-gui/lib/branch_rename.tcl
rename to subprojects/git-gui/lib/branch_rename.tcl
diff --git a/git-gui/lib/browser.tcl b/subprojects/git-gui/lib/browser.tcl
similarity index 100%
rename from git-gui/lib/browser.tcl
rename to subprojects/git-gui/lib/browser.tcl
diff --git a/git-gui/lib/checkout_op.tcl b/subprojects/git-gui/lib/checkout_op.tcl
similarity index 100%
rename from git-gui/lib/checkout_op.tcl
rename to subprojects/git-gui/lib/checkout_op.tcl
diff --git a/git-gui/lib/choose_font.tcl b/subprojects/git-gui/lib/choose_font.tcl
similarity index 100%
rename from git-gui/lib/choose_font.tcl
rename to subprojects/git-gui/lib/choose_font.tcl
diff --git a/git-gui/lib/choose_repository.tcl b/subprojects/git-gui/lib/choose_repository.tcl
similarity index 100%
rename from git-gui/lib/choose_repository.tcl
rename to subprojects/git-gui/lib/choose_repository.tcl
diff --git a/git-gui/lib/choose_rev.tcl b/subprojects/git-gui/lib/choose_rev.tcl
similarity index 100%
rename from git-gui/lib/choose_rev.tcl
rename to subprojects/git-gui/lib/choose_rev.tcl
diff --git a/git-gui/lib/chord.tcl b/subprojects/git-gui/lib/chord.tcl
similarity index 100%
rename from git-gui/lib/chord.tcl
rename to subprojects/git-gui/lib/chord.tcl
diff --git a/git-gui/lib/class.tcl b/subprojects/git-gui/lib/class.tcl
similarity index 100%
rename from git-gui/lib/class.tcl
rename to subprojects/git-gui/lib/class.tcl
diff --git a/git-gui/lib/commit.tcl b/subprojects/git-gui/lib/commit.tcl
similarity index 100%
rename from git-gui/lib/commit.tcl
rename to subprojects/git-gui/lib/commit.tcl
diff --git a/git-gui/lib/console.tcl b/subprojects/git-gui/lib/console.tcl
similarity index 100%
rename from git-gui/lib/console.tcl
rename to subprojects/git-gui/lib/console.tcl
diff --git a/git-gui/lib/database.tcl b/subprojects/git-gui/lib/database.tcl
similarity index 100%
rename from git-gui/lib/database.tcl
rename to subprojects/git-gui/lib/database.tcl
diff --git a/git-gui/lib/date.tcl b/subprojects/git-gui/lib/date.tcl
similarity index 100%
rename from git-gui/lib/date.tcl
rename to subprojects/git-gui/lib/date.tcl
diff --git a/git-gui/lib/diff.tcl b/subprojects/git-gui/lib/diff.tcl
similarity index 100%
rename from git-gui/lib/diff.tcl
rename to subprojects/git-gui/lib/diff.tcl
diff --git a/git-gui/lib/encoding.tcl b/subprojects/git-gui/lib/encoding.tcl
similarity index 100%
rename from git-gui/lib/encoding.tcl
rename to subprojects/git-gui/lib/encoding.tcl
diff --git a/git-gui/lib/error.tcl b/subprojects/git-gui/lib/error.tcl
similarity index 100%
rename from git-gui/lib/error.tcl
rename to subprojects/git-gui/lib/error.tcl
diff --git a/git-gui/lib/git-gui.ico b/subprojects/git-gui/lib/git-gui.ico
similarity index 100%
rename from git-gui/lib/git-gui.ico
rename to subprojects/git-gui/lib/git-gui.ico
diff --git a/git-gui/lib/index.tcl b/subprojects/git-gui/lib/index.tcl
similarity index 100%
rename from git-gui/lib/index.tcl
rename to subprojects/git-gui/lib/index.tcl
diff --git a/git-gui/lib/line.tcl b/subprojects/git-gui/lib/line.tcl
similarity index 100%
rename from git-gui/lib/line.tcl
rename to subprojects/git-gui/lib/line.tcl
diff --git a/git-gui/lib/logo.tcl b/subprojects/git-gui/lib/logo.tcl
similarity index 100%
rename from git-gui/lib/logo.tcl
rename to subprojects/git-gui/lib/logo.tcl
diff --git a/git-gui/lib/merge.tcl b/subprojects/git-gui/lib/merge.tcl
similarity index 100%
rename from git-gui/lib/merge.tcl
rename to subprojects/git-gui/lib/merge.tcl
diff --git a/git-gui/lib/mergetool.tcl b/subprojects/git-gui/lib/mergetool.tcl
similarity index 100%
rename from git-gui/lib/mergetool.tcl
rename to subprojects/git-gui/lib/mergetool.tcl
diff --git a/git-gui/lib/meson.build b/subprojects/git-gui/lib/meson.build
similarity index 100%
rename from git-gui/lib/meson.build
rename to subprojects/git-gui/lib/meson.build
diff --git a/git-gui/lib/option.tcl b/subprojects/git-gui/lib/option.tcl
similarity index 100%
rename from git-gui/lib/option.tcl
rename to subprojects/git-gui/lib/option.tcl
diff --git a/git-gui/lib/remote.tcl b/subprojects/git-gui/lib/remote.tcl
similarity index 100%
rename from git-gui/lib/remote.tcl
rename to subprojects/git-gui/lib/remote.tcl
diff --git a/git-gui/lib/remote_add.tcl b/subprojects/git-gui/lib/remote_add.tcl
similarity index 100%
rename from git-gui/lib/remote_add.tcl
rename to subprojects/git-gui/lib/remote_add.tcl
diff --git a/git-gui/lib/remote_branch_delete.tcl b/subprojects/git-gui/lib/remote_branch_delete.tcl
similarity index 100%
rename from git-gui/lib/remote_branch_delete.tcl
rename to subprojects/git-gui/lib/remote_branch_delete.tcl
diff --git a/git-gui/lib/search.tcl b/subprojects/git-gui/lib/search.tcl
similarity index 100%
rename from git-gui/lib/search.tcl
rename to subprojects/git-gui/lib/search.tcl
diff --git a/git-gui/lib/shortcut.tcl b/subprojects/git-gui/lib/shortcut.tcl
similarity index 100%
rename from git-gui/lib/shortcut.tcl
rename to subprojects/git-gui/lib/shortcut.tcl
diff --git a/git-gui/lib/spellcheck.tcl b/subprojects/git-gui/lib/spellcheck.tcl
similarity index 100%
rename from git-gui/lib/spellcheck.tcl
rename to subprojects/git-gui/lib/spellcheck.tcl
diff --git a/git-gui/lib/sshkey.tcl b/subprojects/git-gui/lib/sshkey.tcl
similarity index 100%
rename from git-gui/lib/sshkey.tcl
rename to subprojects/git-gui/lib/sshkey.tcl
diff --git a/git-gui/lib/status_bar.tcl b/subprojects/git-gui/lib/status_bar.tcl
similarity index 100%
rename from git-gui/lib/status_bar.tcl
rename to subprojects/git-gui/lib/status_bar.tcl
diff --git a/git-gui/lib/themed.tcl b/subprojects/git-gui/lib/themed.tcl
similarity index 100%
rename from git-gui/lib/themed.tcl
rename to subprojects/git-gui/lib/themed.tcl
diff --git a/git-gui/lib/tools.tcl b/subprojects/git-gui/lib/tools.tcl
similarity index 100%
rename from git-gui/lib/tools.tcl
rename to subprojects/git-gui/lib/tools.tcl
diff --git a/git-gui/lib/tools_dlg.tcl b/subprojects/git-gui/lib/tools_dlg.tcl
similarity index 100%
rename from git-gui/lib/tools_dlg.tcl
rename to subprojects/git-gui/lib/tools_dlg.tcl
diff --git a/git-gui/lib/transport.tcl b/subprojects/git-gui/lib/transport.tcl
similarity index 100%
rename from git-gui/lib/transport.tcl
rename to subprojects/git-gui/lib/transport.tcl
diff --git a/git-gui/lib/win32.tcl b/subprojects/git-gui/lib/win32.tcl
similarity index 100%
rename from git-gui/lib/win32.tcl
rename to subprojects/git-gui/lib/win32.tcl
diff --git a/git-gui/lib/win32_shortcut.js b/subprojects/git-gui/lib/win32_shortcut.js
similarity index 100%
rename from git-gui/lib/win32_shortcut.js
rename to subprojects/git-gui/lib/win32_shortcut.js
diff --git a/git-gui/meson.build b/subprojects/git-gui/meson.build
similarity index 100%
rename from git-gui/meson.build
rename to subprojects/git-gui/meson.build
diff --git a/git-gui/po/.gitignore b/subprojects/git-gui/po/.gitignore
similarity index 100%
rename from git-gui/po/.gitignore
rename to subprojects/git-gui/po/.gitignore
diff --git a/git-gui/po/README b/subprojects/git-gui/po/README
similarity index 100%
rename from git-gui/po/README
rename to subprojects/git-gui/po/README
diff --git a/git-gui/po/bg.po b/subprojects/git-gui/po/bg.po
similarity index 100%
rename from git-gui/po/bg.po
rename to subprojects/git-gui/po/bg.po
diff --git a/git-gui/po/de.po b/subprojects/git-gui/po/de.po
similarity index 100%
rename from git-gui/po/de.po
rename to subprojects/git-gui/po/de.po
diff --git a/git-gui/po/el.po b/subprojects/git-gui/po/el.po
similarity index 100%
rename from git-gui/po/el.po
rename to subprojects/git-gui/po/el.po
diff --git a/git-gui/po/fr.po b/subprojects/git-gui/po/fr.po
similarity index 100%
rename from git-gui/po/fr.po
rename to subprojects/git-gui/po/fr.po
diff --git a/git-gui/po/glossary/Makefile b/subprojects/git-gui/po/glossary/Makefile
similarity index 100%
rename from git-gui/po/glossary/Makefile
rename to subprojects/git-gui/po/glossary/Makefile
diff --git a/git-gui/po/glossary/bg.po b/subprojects/git-gui/po/glossary/bg.po
similarity index 100%
rename from git-gui/po/glossary/bg.po
rename to subprojects/git-gui/po/glossary/bg.po
diff --git a/git-gui/po/glossary/de.po b/subprojects/git-gui/po/glossary/de.po
similarity index 100%
rename from git-gui/po/glossary/de.po
rename to subprojects/git-gui/po/glossary/de.po
diff --git a/git-gui/po/glossary/el.po b/subprojects/git-gui/po/glossary/el.po
similarity index 100%
rename from git-gui/po/glossary/el.po
rename to subprojects/git-gui/po/glossary/el.po
diff --git a/git-gui/po/glossary/fr.po b/subprojects/git-gui/po/glossary/fr.po
similarity index 100%
rename from git-gui/po/glossary/fr.po
rename to subprojects/git-gui/po/glossary/fr.po
diff --git a/git-gui/po/glossary/git-gui-glossary.pot b/subprojects/git-gui/po/glossary/git-gui-glossary.pot
similarity index 100%
rename from git-gui/po/glossary/git-gui-glossary.pot
rename to subprojects/git-gui/po/glossary/git-gui-glossary.pot
diff --git a/git-gui/po/glossary/git-gui-glossary.txt b/subprojects/git-gui/po/glossary/git-gui-glossary.txt
similarity index 100%
rename from git-gui/po/glossary/git-gui-glossary.txt
rename to subprojects/git-gui/po/glossary/git-gui-glossary.txt
diff --git a/git-gui/po/glossary/it.po b/subprojects/git-gui/po/glossary/it.po
similarity index 100%
rename from git-gui/po/glossary/it.po
rename to subprojects/git-gui/po/glossary/it.po
diff --git a/git-gui/po/glossary/pt_br.po b/subprojects/git-gui/po/glossary/pt_br.po
similarity index 100%
rename from git-gui/po/glossary/pt_br.po
rename to subprojects/git-gui/po/glossary/pt_br.po
diff --git a/git-gui/po/glossary/pt_pt.po b/subprojects/git-gui/po/glossary/pt_pt.po
similarity index 100%
rename from git-gui/po/glossary/pt_pt.po
rename to subprojects/git-gui/po/glossary/pt_pt.po
diff --git a/git-gui/po/glossary/txt-to-pot.sh b/subprojects/git-gui/po/glossary/txt-to-pot.sh
similarity index 100%
rename from git-gui/po/glossary/txt-to-pot.sh
rename to subprojects/git-gui/po/glossary/txt-to-pot.sh
diff --git a/git-gui/po/glossary/zh_cn.po b/subprojects/git-gui/po/glossary/zh_cn.po
similarity index 100%
rename from git-gui/po/glossary/zh_cn.po
rename to subprojects/git-gui/po/glossary/zh_cn.po
diff --git a/git-gui/po/hu.po b/subprojects/git-gui/po/hu.po
similarity index 100%
rename from git-gui/po/hu.po
rename to subprojects/git-gui/po/hu.po
diff --git a/git-gui/po/it.po b/subprojects/git-gui/po/it.po
similarity index 100%
rename from git-gui/po/it.po
rename to subprojects/git-gui/po/it.po
diff --git a/git-gui/po/ja.po b/subprojects/git-gui/po/ja.po
similarity index 100%
rename from git-gui/po/ja.po
rename to subprojects/git-gui/po/ja.po
diff --git a/git-gui/po/meson.build b/subprojects/git-gui/po/meson.build
similarity index 100%
rename from git-gui/po/meson.build
rename to subprojects/git-gui/po/meson.build
diff --git a/git-gui/po/nb.po b/subprojects/git-gui/po/nb.po
similarity index 100%
rename from git-gui/po/nb.po
rename to subprojects/git-gui/po/nb.po
diff --git a/git-gui/po/po2msg.sh b/subprojects/git-gui/po/po2msg.sh
similarity index 100%
rename from git-gui/po/po2msg.sh
rename to subprojects/git-gui/po/po2msg.sh
diff --git a/git-gui/po/pt_br.po b/subprojects/git-gui/po/pt_br.po
similarity index 100%
rename from git-gui/po/pt_br.po
rename to subprojects/git-gui/po/pt_br.po
diff --git a/git-gui/po/pt_pt.po b/subprojects/git-gui/po/pt_pt.po
similarity index 100%
rename from git-gui/po/pt_pt.po
rename to subprojects/git-gui/po/pt_pt.po
diff --git a/git-gui/po/ru.po b/subprojects/git-gui/po/ru.po
similarity index 100%
rename from git-gui/po/ru.po
rename to subprojects/git-gui/po/ru.po
diff --git a/git-gui/po/sv.po b/subprojects/git-gui/po/sv.po
similarity index 100%
rename from git-gui/po/sv.po
rename to subprojects/git-gui/po/sv.po
diff --git a/git-gui/po/vi.po b/subprojects/git-gui/po/vi.po
similarity index 100%
rename from git-gui/po/vi.po
rename to subprojects/git-gui/po/vi.po
diff --git a/git-gui/po/zh_cn.po b/subprojects/git-gui/po/zh_cn.po
similarity index 100%
rename from git-gui/po/zh_cn.po
rename to subprojects/git-gui/po/zh_cn.po
diff --git a/git-gui/windows/git-gui.sh b/subprojects/git-gui/windows/git-gui.sh
similarity index 100%
rename from git-gui/windows/git-gui.sh
rename to subprojects/git-gui/windows/git-gui.sh

-- 
2.51.0.261.g7ce5a0a67e.dirty

