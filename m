Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B11917EB
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528661; cv=none; b=ENQEq6m/5RBkNQEVOxfd2XbJy1Oz/ZYm2lY/4BNWDBIV6RU2h4kHvCt73ktWiBoeurvOXE40oe8GHHGei0KUq7UgGPZoqTt5dgp/weFfrWB95JJNNwxTvzPyouh4s6vVzDb8/w3CPjihVR9mj9Cti3u8+LNVbvp9O5qYp4j7EXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528661; c=relaxed/simple;
	bh=AfnIF8vI3HEN2HlVfsNuDlT18LxxeI1CfFep2Gil8Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQTvBwMK1n9DIbquP+MO1PQmerW4OtI7MEkz1w7AuNqpUnAeVGqs92YkBNdBBBiBvAbNu2BzMPv/npScU3FZKRVDQ8/LLgfyCaEAEDzN1SpxbE7xixEG63vLsPBcXaKFHtv8T8wcYwkiHIvC8cv70MWFitDcTcPEn1B8xICBBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLv1am9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0b0XgKD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLv1am9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0b0XgKD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C4A7E1140176;
	Mon, 25 Nov 2024 04:57:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 04:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528653;
	 x=1732615053; bh=B+MVaod4RPEXBwc5lxc53t9y0lhl0+VBpOSe+Ngr4z8=; b=
	QLv1am9uODZOzjga7FQ4Gr84cu9b/798e9b0ll3QktzJqqnQsxL8/Uy1Xsi96jtI
	DaBTzexr7aftS4zi1ohncD+T3f3jX8TaLUPHG4UBA47ZayFJOkOni4AUCDm7ACfU
	hLrA6/L4/B0sBmNnkbU+L0AEgjGIU7NSGS1l1SZFPH/oWZQdJfE4pmkAOXSEOYag
	+7FVe7bIAC35OjiHz6RUvac9MF8EVmKgf2aJde5GIR5lHTdYSuAG0wFOzj4fahGX
	CkvQnUD0gI0VthDhHq6R9BdWiW8tJ7kFxEIBRoMyJiAPuCZVFl0SKv3NxMINjcX2
	tZ80PQJZrkw+agYrOGCUmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528653; x=
	1732615053; bh=B+MVaod4RPEXBwc5lxc53t9y0lhl0+VBpOSe+Ngr4z8=; b=D
	0b0XgKDwtyKWn2lT8r5vyUz3EgOY78WsoRgaPddVald+sOzhYG3Z4+6UIeR5/lmx
	dCsIBLOthuuR5TY+KZyejru1/hJTwc+tP+6m09EyDbY+To2iRz93/7veKvc5RTXG
	bP+b1vVp3VsWyrgqYQImfZbjRBnvoCct9u8fgo7fKu22LKK0zPnxyr0c4l64abQw
	oRizgflv7PDk38Cm93wxwBOd8C9pbiD4yvHWyNzW89McK3Yn311SX8bBv2AwEMVr
	FrpUdKn8c2QhppdNwpoXbxwalHsUwBdh4/aZnmDC7YvptrjQEErBOUOUT2UCWkhZ
	hrVRBcV7aEhozDcWojlcw==
X-ME-Sender: <xms:DUpEZ_5Tw_lZ7yNL6L8_9jcrtv_Ctanesf3Rm48aL-9qMO2fN4YzwA>
    <xme:DUpEZ04Tv8_SBrCj_OpHJY2Cot3tRXg5zusOEAb7bxKF7d1nmEATui9vdNQoqWCF4
    rnqexyU2bFtoZWEyw>
X-ME-Received: <xmr:DUpEZ2ek-4YDAb1U2vvLEIBjtHRnOtTOl6zH5xROAjqJCBE5UlVxV-DYOd4yrHQVf_wNpjbBtqi6GGznBC3gMJ8PPm-EcwqGg-RIumCw62lCKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeiveegheduleetueevgfdtjefggffgteevueejhffh
    uedttedvkefgteegtddunecuffhomhgrihhnpegtohhnfhdrihhnpdhrtgdrihhnpdhgih
    hthhhusgdrtghomhdpmhgvshhonhgsuhhilhgurdgtohhmpdhophgvnhhsshhlrdhorhhg
    pdiilhhisgdrnhgvthdphhhtthhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegurg
    hvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:DUpEZwL2sLQWW0o_RKjhIpwpleG4x9DmvLRCqWJ6tH3E_g0U6js0VQ>
    <xmx:DUpEZzJPeq66EawnqirlO2oymQQ_GiQ-hulTdU9sy6-vticWTI6scg>
    <xmx:DUpEZ5xAOQyGvWwC4BbYOdDpbk4KyeJWEPtyhCWJFl-yI7QBQqb5RQ>
    <xmx:DUpEZ_I72u4CJncZ8IAAgtAA840p0kDAM8u2L3n6M6IeuquJN_PX_A>
    <xmx:DUpEZ1yyUJKevz--HbV5KE3P4898FUplCHyrYPkOuDXe2AMI1XUKvetT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 384d1815 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:10 +0100
Subject: [PATCH v9 22/23] Introduce support for the Meson build system
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-22-1c6cf242a5f1@pks.im>
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

Introduce support for the Meson build system, a "modern" meta build
system that supports many different platforms, including Linux, macOS,
Windows and BSDs. Meson supports different backends, including Ninja,
Xcode and Microsoft Visual Studio. Several common IDEs provide an
integration with it.

The biggest contender compared to Meson is probably CMake as outlined in
our "Documentation/technical/build-systems.txt" file. Based on my own
personal experience from working with both build systems extensively I
strongly favor Meson over CMake. In my opinion, it feels significantly
easier to use with a syntax that feels more like a "real" programming
language. The second big reason is that Meson supports Rust natively,
which may prove to be important given that the project may pick up Rust
as another language eventually.

Using Meson is rather straight-forward. An example:

    ```
    # Meson uses out-of-tree builds. You can set up multiple build
    # directories, how you name them is completely up to you.
    $ mkdir build
    $ cd build
    $ meson setup .. -Dprefix=/tmp/git-installation

    # Build the project. This also provides several other targets like
    e.g. `install` or `test`.
    $ ninja

    # Meson has been wired up to support execution of our test suites.
    # Both our unit tests and our integration tests are supported.
    # Running `meson test` without any arguments will execute all tests,
    # but the syntax supports globbing to select only some tests.
    $ meson test 't-*'
    # Execute single test interactively to allow for debugging.
    $ meson test 't0000-*' --interactive --test-args=-ix
    ```

The build instructions have been successfully tested on the following
systems, tests are passing:

  - Apple macOS 10.15.

  - FreeBSD 14.1.

  - NixOS 24.11.

  - OpenBSD 7.6.

  - Ubuntu 24.04.

  - Windows 10 with Cygwin.

  - Windows 10 with MinGW64, except for t9700, which is also broken with
    our Makefile.

  - Windows 10 with Visual Studio 2022 toolchain, using the Native Tools
    Command Prompt with `meson setup --vsenv`. Tests pass, except for
    t9700.

  - Windows 10 with Visual Studio 2022 solution, using the Native Tools
    Command Prompt with `meson setup --backend vs2022`. Tests pass,
    except for t9700.

  - Windows 10 with VS Code, using the Meson plug-in.

It is expected that there will still be rough edges in the current
version. If this patch lands the expectation is that it will coexist
with our other build systems for a while. Like this, distributions can
slowly migrate over to Meson and report any findings they have to us
such that we can continue to iterate. A potential cutoff date for other
build systems may be Git 3.0.

Some notes:

  - The installed distribution is structured somewhat differently than
    how it used to be the case. All of our binaries are installed into
    `$libexec/git-core`, while all binaries part of `$bindir` are now
    symbolic links pointing to the former. This rule is consistent in
    itself and thus easier to reason about.

  - We do not install dashed binaries into `$libexec/git-core` anymore,
    so there won't e.g. be a symlink for git-add(1). These are not
    required by modern Git and there isn't really much of a use case for
    those anymore. By not installing those symlinks we thus start the
    deprecation of this layout.

  - We're targeting Meson 1.3.0, which has been released relatively
    recently November 2023. The only feature we use from that version is
    `fs.relative_to()`, which we could replace if necessary. If so, we
    could start to target Meson 1.0.0 and newer, released in December
    2022.

  - The whole build instructions count around 3300 lines, half of which
    is listing all of our code and test files. Our Makefiles are around
    5000 lines, autoconf adds another 1300 lines. CMake in comparison
    has only 1200 linescode, but it avoids listing individual files and
    does not wire up auto-configuration as extensively as the Meson
    instructions do.

  - We bundle a set of subproject wrappers for curl, expat, openssl,
    pcre2 and zlib. This allows developers to build Git without these
    dependencies preinstalled, and Meson will fetch and build them
    automatically. This is especially helpful on Windows.

Helped-by: Eli Schwartz <eschwartz@gentoo.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build          |  324 +++++++
 bin-wrappers/meson.build           |   28 +
 contrib/completion/meson.build     |    8 +
 contrib/meson.build                |    1 +
 gitweb/meson.build                 |   79 ++
 meson.build                        | 1888 ++++++++++++++++++++++++++++++++++++
 meson_options.txt                  |   81 ++
 perl/FromCPAN/Mail/meson.build     |    7 +
 perl/FromCPAN/meson.build          |    9 +
 perl/Git/LoadCPAN/Mail/meson.build |    7 +
 perl/Git/LoadCPAN/meson.build      |    9 +
 perl/Git/SVN/Memoize/meson.build   |    7 +
 perl/Git/SVN/meson.build           |   20 +
 perl/Git/meson.build               |   18 +
 perl/meson.build                   |   12 +
 po/meson.build                     |   27 +
 subprojects/.gitignore             |    1 +
 subprojects/curl.wrap              |   13 +
 subprojects/expat.wrap             |   13 +
 subprojects/openssl.wrap           |   15 +
 subprojects/pcre2.wrap             |   16 +
 subprojects/zlib.wrap              |   13 +
 t/helper/meson.build               |   91 ++
 t/meson.build                      | 1115 +++++++++++++++++++++
 templates/hooks/meson.build        |   26 +
 templates/info/meson.build         |    7 +
 templates/meson.build              |   15 +
 27 files changed, 3850 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..f2426ccaa30c29bd60b850eb0a9a4ab77c66a629
--- /dev/null
+++ b/Documentation/meson.build
@@ -0,0 +1,324 @@
+manpages = {
+  # Category 1.
+  'git-add.txt' : 1,
+  'git-am.txt' : 1,
+  'git-annotate.txt' : 1,
+  'git-apply.txt' : 1,
+  'git-archimport.txt' : 1,
+  'git-archive.txt' : 1,
+  'git-bisect.txt' : 1,
+  'git-blame.txt' : 1,
+  'git-branch.txt' : 1,
+  'git-bugreport.txt' : 1,
+  'git-bundle.txt' : 1,
+  'git-cat-file.txt' : 1,
+  'git-check-attr.txt' : 1,
+  'git-check-ignore.txt' : 1,
+  'git-check-mailmap.txt' : 1,
+  'git-checkout-index.txt' : 1,
+  'git-checkout.txt' : 1,
+  'git-check-ref-format.txt' : 1,
+  'git-cherry-pick.txt' : 1,
+  'git-cherry.txt' : 1,
+  'git-citool.txt' : 1,
+  'git-clean.txt' : 1,
+  'git-clone.txt' : 1,
+  'git-column.txt' : 1,
+  'git-commit-graph.txt' : 1,
+  'git-commit-tree.txt' : 1,
+  'git-commit.txt' : 1,
+  'git-config.txt' : 1,
+  'git-count-objects.txt' : 1,
+  'git-credential-cache--daemon.txt' : 1,
+  'git-credential-cache.txt' : 1,
+  'git-credential-store.txt' : 1,
+  'git-credential.txt' : 1,
+  'git-cvsexportcommit.txt' : 1,
+  'git-cvsimport.txt' : 1,
+  'git-cvsserver.txt' : 1,
+  'git-daemon.txt' : 1,
+  'git-describe.txt' : 1,
+  'git-diagnose.txt' : 1,
+  'git-diff-files.txt' : 1,
+  'git-diff-index.txt' : 1,
+  'git-difftool.txt' : 1,
+  'git-diff-tree.txt' : 1,
+  'git-diff.txt' : 1,
+  'git-fast-export.txt' : 1,
+  'git-fast-import.txt' : 1,
+  'git-fetch-pack.txt' : 1,
+  'git-fetch.txt' : 1,
+  'git-filter-branch.txt' : 1,
+  'git-fmt-merge-msg.txt' : 1,
+  'git-for-each-ref.txt' : 1,
+  'git-for-each-repo.txt' : 1,
+  'git-format-patch.txt' : 1,
+  'git-fsck-objects.txt' : 1,
+  'git-fsck.txt' : 1,
+  'git-fsmonitor--daemon.txt' : 1,
+  'git-gc.txt' : 1,
+  'git-get-tar-commit-id.txt' : 1,
+  'git-grep.txt' : 1,
+  'git-gui.txt' : 1,
+  'git-hash-object.txt' : 1,
+  'git-help.txt' : 1,
+  'git-hook.txt' : 1,
+  'git-http-backend.txt' : 1,
+  'git-http-fetch.txt' : 1,
+  'git-http-push.txt' : 1,
+  'git-imap-send.txt' : 1,
+  'git-index-pack.txt' : 1,
+  'git-init-db.txt' : 1,
+  'git-init.txt' : 1,
+  'git-instaweb.txt' : 1,
+  'git-interpret-trailers.txt' : 1,
+  'git-log.txt' : 1,
+  'git-ls-files.txt' : 1,
+  'git-ls-remote.txt' : 1,
+  'git-ls-tree.txt' : 1,
+  'git-mailinfo.txt' : 1,
+  'git-mailsplit.txt' : 1,
+  'git-maintenance.txt' : 1,
+  'git-merge-base.txt' : 1,
+  'git-merge-file.txt' : 1,
+  'git-merge-index.txt' : 1,
+  'git-merge-one-file.txt' : 1,
+  'git-mergetool--lib.txt' : 1,
+  'git-mergetool.txt' : 1,
+  'git-merge-tree.txt' : 1,
+  'git-merge.txt' : 1,
+  'git-mktag.txt' : 1,
+  'git-mktree.txt' : 1,
+  'git-multi-pack-index.txt' : 1,
+  'git-mv.txt' : 1,
+  'git-name-rev.txt' : 1,
+  'git-notes.txt' : 1,
+  'git-p4.txt' : 1,
+  'git-pack-objects.txt' : 1,
+  'git-pack-redundant.txt' : 1,
+  'git-pack-refs.txt' : 1,
+  'git-patch-id.txt' : 1,
+  'git-prune-packed.txt' : 1,
+  'git-prune.txt' : 1,
+  'git-pull.txt' : 1,
+  'git-push.txt' : 1,
+  'git-quiltimport.txt' : 1,
+  'git-range-diff.txt' : 1,
+  'git-read-tree.txt' : 1,
+  'git-rebase.txt' : 1,
+  'git-receive-pack.txt' : 1,
+  'git-reflog.txt' : 1,
+  'git-refs.txt' : 1,
+  'git-remote-ext.txt' : 1,
+  'git-remote-fd.txt' : 1,
+  'git-remote.txt' : 1,
+  'git-repack.txt' : 1,
+  'git-replace.txt' : 1,
+  'git-replay.txt' : 1,
+  'git-request-pull.txt' : 1,
+  'git-rerere.txt' : 1,
+  'git-reset.txt' : 1,
+  'git-restore.txt' : 1,
+  'git-revert.txt' : 1,
+  'git-rev-list.txt' : 1,
+  'git-rev-parse.txt' : 1,
+  'git-rm.txt' : 1,
+  'git-send-email.txt' : 1,
+  'git-send-pack.txt' : 1,
+  'git-shell.txt' : 1,
+  'git-sh-i18n--envsubst.txt' : 1,
+  'git-sh-i18n.txt' : 1,
+  'git-shortlog.txt' : 1,
+  'git-show-branch.txt' : 1,
+  'git-show-index.txt' : 1,
+  'git-show-ref.txt' : 1,
+  'git-show.txt' : 1,
+  'git-sh-setup.txt' : 1,
+  'git-sparse-checkout.txt' : 1,
+  'git-stage.txt' : 1,
+  'git-stash.txt' : 1,
+  'git-status.txt' : 1,
+  'git-stripspace.txt' : 1,
+  'git-submodule.txt' : 1,
+  'git-svn.txt' : 1,
+  'git-switch.txt' : 1,
+  'git-symbolic-ref.txt' : 1,
+  'git-tag.txt' : 1,
+  'git-unpack-file.txt' : 1,
+  'git-unpack-objects.txt' : 1,
+  'git-update-index.txt' : 1,
+  'git-update-ref.txt' : 1,
+  'git-update-server-info.txt' : 1,
+  'git-upload-archive.txt' : 1,
+  'git-upload-pack.txt' : 1,
+  'git-var.txt' : 1,
+  'git-verify-commit.txt' : 1,
+  'git-verify-pack.txt' : 1,
+  'git-verify-tag.txt' : 1,
+  'git-version.txt' : 1,
+  'git-web--browse.txt' : 1,
+  'git-whatchanged.txt' : 1,
+  'git-worktree.txt' : 1,
+  'git-write-tree.txt' : 1,
+  'git.txt' : 1,
+  'gitk.txt' : 1,
+  'gitweb.txt' : 1,
+  'scalar.txt' : 1,
+
+  # Category 5.
+  'gitattributes.txt' : 5,
+  'gitformat-bundle.txt' : 5,
+  'gitformat-chunk.txt' : 5,
+  'gitformat-commit-graph.txt' : 5,
+  'gitformat-index.txt' : 5,
+  'gitformat-pack.txt' : 5,
+  'gitformat-signature.txt' : 5,
+  'githooks.txt' : 5,
+  'gitignore.txt' : 5,
+  'gitmailmap.txt' : 5,
+  'gitmodules.txt' : 5,
+  'gitprotocol-capabilities.txt' : 5,
+  'gitprotocol-common.txt' : 5,
+  'gitprotocol-http.txt' : 5,
+  'gitprotocol-pack.txt' : 5,
+  'gitprotocol-v2.txt' : 5,
+  'gitrepository-layout.txt' : 5,
+  'gitweb.conf.txt' : 5,
+
+  # Category 7.
+  'gitcli.txt' : 7,
+  'gitcore-tutorial.txt' : 7,
+  'gitcredentials.txt' : 7,
+  'gitcvs-migration.txt' : 7,
+  'gitdiffcore.txt' : 7,
+  'giteveryday.txt' : 7,
+  'gitfaq.txt' : 7,
+  'gitglossary.txt' : 7,
+  'gitpacking.txt' : 7,
+  'gitnamespaces.txt' : 7,
+  'gitremote-helpers.txt' : 7,
+  'gitrevisions.txt' : 7,
+  'gitsubmodules.txt' : 7,
+  'gittutorial-2.txt' : 7,
+  'gittutorial.txt' : 7,
+  'gitworkflows.txt' : 7,
+}
+
+asciidoc = find_program('asciidoc')
+git = find_program('git', required: false)
+xmlto = find_program('xmlto')
+
+asciidoc_conf = custom_target(
+  command: [
+    shell,
+    meson.project_source_root() / 'GIT-VERSION-GEN',
+    meson.project_source_root(),
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  input: meson.current_source_dir() / 'asciidoc.conf.in',
+  output: 'asciidoc.conf',
+  depends: [git_version_file],
+)
+
+asciidoc_common_options = [
+  asciidoc,
+  '--conf-file=' + asciidoc_conf.full_path(),
+  '--attribute=build_dir=' + meson.current_build_dir(),
+]
+
+cmd_lists = [
+  'cmds-ancillaryinterrogators.txt',
+  'cmds-ancillarymanipulators.txt',
+  'cmds-mainporcelain.txt',
+  'cmds-plumbinginterrogators.txt',
+  'cmds-plumbingmanipulators.txt',
+  'cmds-synchingrepositories.txt',
+  'cmds-synchelpers.txt',
+  'cmds-guide.txt',
+  'cmds-developerinterfaces.txt',
+  'cmds-userinterfaces.txt',
+  'cmds-purehelpers.txt',
+  'cmds-foreignscminterface.txt',
+]
+
+documentation_deps = [
+  asciidoc_conf,
+]
+
+documentation_deps += custom_target(
+  command: [
+    perl,
+    meson.current_source_dir() / 'cmd-list.perl',
+    meson.project_source_root(),
+    meson.current_build_dir(),
+  ] + cmd_lists,
+  output: cmd_lists
+)
+
+foreach mode : [ 'diff', 'merge' ]
+  documentation_deps += custom_target(
+    command: [
+      shell,
+      meson.current_source_dir() / 'generate-mergetool-list.sh',
+      '..',
+      'diff',
+      '@OUTPUT@'
+    ],
+    env: [
+      'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
+      'TOOL_MODE=' + mode,
+    ],
+    output: 'mergetools-' + mode + '.txt',
+  )
+endforeach
+
+foreach manpage, category : manpages
+  if get_option('docs').contains('man')
+    manpage_xml_target = custom_target(
+      command: asciidoc_common_options + [
+        '--backend=docbook',
+        '--doctype=manpage',
+        '--out-file=@OUTPUT@',
+        meson.current_source_dir() / manpage,
+      ],
+      depends: documentation_deps,
+      output: fs.stem(manpage) + '.xml',
+    )
+
+    manpage_path = fs.stem(manpage) + '.' + category.to_string()
+    manpage_target = custom_target(
+      command: [
+        xmlto,
+        '-m',
+        meson.current_source_dir() / 'manpage-normal.xsl',
+        '-m',
+        meson.current_source_dir() / 'manpage-bold-literal.xsl',
+        '--stringparam',
+        'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
+        'man',
+        manpage_xml_target,
+        '-o',
+        meson.current_build_dir(),
+      ],
+      output: manpage_path,
+      install: true,
+      install_dir: get_option('mandir') / 'man' + category.to_string(),
+    )
+  endif
+
+  if get_option('docs').contains('html') and category == 1
+    custom_target(
+      command: asciidoc_common_options + [
+        '--backend=xhtml11',
+        '--doctype=manpage',
+        '--out-file=@OUTPUT@',
+        meson.current_source_dir() / manpage,
+      ],
+      depends: documentation_deps,
+      output: fs.stem(manpage) + '.html',
+      install: true,
+      install_dir: get_option('datadir') / 'doc/git-doc',
+    )
+  endif
+endforeach
diff --git a/bin-wrappers/meson.build b/bin-wrappers/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..6d03a19d7b8e3cf78ac0499b6cedf47e0c6cb441
--- /dev/null
+++ b/bin-wrappers/meson.build
@@ -0,0 +1,28 @@
+bin_wrappers_config = configuration_data()
+foreach key, value : {
+      'BUILD_DIR': meson.project_build_root(),
+      'MERGE_TOOLS_DIR': meson.project_source_root() / 'mergetools',
+      'TEMPLATE_DIR': meson.project_build_root() / 'templates',
+      'GIT_TEXTDOMAINDIR': meson.project_build_root() / 'po',
+      'GITPERLLIB': meson.project_build_root() / 'perl/lib',
+}
+  # Paths need to be Unix-style without drive prefixes as they get added to the
+  # PATH variable. And given that drive prefixes contain a colon we'd otherwise
+  # end up with a broken PATH if we didn't convert them.
+  if cygpath.found()
+    value = run_command(cygpath, value, check: true).stdout().strip()
+  endif
+  bin_wrappers_config.set(key, value)
+endforeach
+
+foreach executable : bin_wrappers
+  executable_config = configuration_data()
+  executable_config.merge_from(bin_wrappers_config)
+  executable_config.set('PROG', fs.relative_to(executable.full_path(), meson.project_build_root()))
+
+  configure_file(
+    input: 'wrap-for-bin.sh',
+    output: fs.stem(executable.full_path()),
+    configuration: executable_config,
+  )
+endforeach
diff --git a/contrib/completion/meson.build b/contrib/completion/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..a9bfe2da312ac9764367b656bd8a4099b575ad72
--- /dev/null
+++ b/contrib/completion/meson.build
@@ -0,0 +1,8 @@
+foreach script : [
+  'git-completion.bash',
+  'git-completion.tcsh',
+  'git-completion.zsh',
+  'git-prompt.sh'
+]
+  test_dependencies += fs.copyfile(script)
+endforeach
diff --git a/contrib/meson.build b/contrib/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..a7b77b87c22c8f1d8a86faaafc2b647b94651db8
--- /dev/null
+++ b/contrib/meson.build
@@ -0,0 +1 @@
+subdir('completion')
diff --git a/gitweb/meson.build b/gitweb/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..ef868bd7dbcbcb5b69c2e73fc40c374435205c9c
--- /dev/null
+++ b/gitweb/meson.build
@@ -0,0 +1,79 @@
+gitweb_config = configuration_data()
+gitweb_config.set_quoted('PERL_PATH', perl.full_path())
+gitweb_config.set_quoted('CSSMIN', '')
+gitweb_config.set_quoted('JSMIN', '')
+gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_option('bindir'))
+gitweb_config.set_quoted('GITWEB_CONFIG', get_option('gitweb_config'))
+gitweb_config.set_quoted('GITWEB_CONFIG_SYSTEM', get_option('gitweb_config_system'))
+gitweb_config.set_quoted('GITWEB_CONFIG_COMMON', get_option('gitweb_config_common'))
+gitweb_config.set_quoted('GITWEB_HOME_LINK_STR', get_option('gitweb_home_link_str'))
+gitweb_config.set_quoted('GITWEB_SITENAME', get_option('gitweb_sitename'))
+gitweb_config.set_quoted('GITWEB_PROJECTROOT', get_option('gitweb_projectroot'))
+gitweb_config.set_quoted('GITWEB_PROJECT_MAXDEPTH', get_option('gitweb_project_maxdepth'))
+gitweb_config.set_quoted('GITWEB_EXPORT_OK', get_option('gitweb_export_ok'))
+gitweb_config.set_quoted('GITWEB_STRICT_EXPORT', get_option('gitweb_strict_export'))
+gitweb_config.set_quoted('GITWEB_BASE_URL', get_option('gitweb_base_url'))
+gitweb_config.set_quoted('GITWEB_LIST', get_option('gitweb_list'))
+gitweb_config.set_quoted('GITWEB_HOMETEXT', get_option('gitweb_hometext'))
+gitweb_config.set_quoted('GITWEB_CSS', get_option('gitweb_css'))
+gitweb_config.set_quoted('GITWEB_LOGO', get_option('gitweb_logo'))
+gitweb_config.set_quoted('GITWEB_FAVICON', get_option('gitweb_favicon'))
+gitweb_config.set_quoted('GITWEB_JS', get_option('gitweb_js'))
+gitweb_config.set_quoted('GITWEB_SITE_HTML_HEAD_STRING', get_option('gitweb_site_html_head_string'))
+gitweb_config.set_quoted('GITWEB_SITE_HEADER', get_option('gitweb_site_header'))
+gitweb_config.set_quoted('GITWEB_SITE_FOOTER', get_option('gitweb_site_footer'))
+gitweb_config.set_quoted('HIGHLIGHT_BIN', get_option('highlight_bin'))
+
+configure_file(
+  input: 'GITWEB-BUILD-OPTIONS.in',
+  output: 'GITWEB-BUILD-OPTIONS',
+  configuration: gitweb_config,
+)
+
+test_dependencies += custom_target(
+  input: 'gitweb.perl',
+  output: 'gitweb.cgi',
+  command: [
+    shell,
+    meson.current_source_dir() / 'generate-gitweb-cgi.sh',
+    meson.current_build_dir() / 'GITWEB-BUILD-OPTIONS',
+    git_version_file.full_path(),
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  install: true,
+  install_dir: get_option('datadir') / 'gitweb',
+  depends: [git_version_file],
+)
+
+javascript_files = [
+  meson.current_source_dir() / 'static/js/adjust-timezone.js',
+  meson.current_source_dir() / 'static/js/blame_incremental.js',
+  meson.current_source_dir() / 'static/js/javascript-detection.js',
+  meson.current_source_dir() / 'static/js/lib/common-lib.js',
+  meson.current_source_dir() / 'static/js/lib/cookies.js',
+  meson.current_source_dir() / 'static/js/lib/datetime.js',
+]
+
+test_dependencies += custom_target(
+  input: javascript_files,
+  output: 'gitweb.js',
+  command: [
+    shell,
+    meson.current_source_dir() / 'generate-gitweb-js.sh',
+    '@OUTPUT@',
+  ] + javascript_files,
+  install: true,
+  install_dir: get_option('datadir') / 'gitweb/static',
+)
+
+foreach asset : [
+  'static/git-favicon.png',
+  'static/git-logo.png',
+  'static/gitweb.css',
+]
+  fs.copyfile(asset,
+    install: true,
+    install_dir: get_option('datadir') / 'gitweb' / fs.parent(asset),
+  )
+endforeach
diff --git a/meson.build b/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..6531c9b67ed2cb8cb5eac9b0be4654ddd14fbe1d
--- /dev/null
+++ b/meson.build
@@ -0,0 +1,1888 @@
+# Meson build system
+# ==================
+#
+# The Meson build system is an alternative to our Makefile that you can use to
+# build, test and install Git. Using Meson results in a couple of benefits:
+#
+#  - Out-of-tree builds.
+#  - Better integration into IDEs.
+#  - Easy-to-use autoconfiguration of available features on your system.
+#
+# To use Meson from the command line you need to have both Meson and Ninja
+# installed. Alternatively, if you do not have Python available on your system,
+# you can also use Muon instead of Meson and Samurai instead of Ninja, both of
+# which are drop-ins replacement that only depend on C.
+#
+# Basic usage
+# ===========
+#
+# In the most trivial case, you can configure, build and install Git like this:
+#
+#  1. Set up the build directory. This only needs to happen once per build
+#     directory you want to have. You can also configure multiple different
+#     build directories with different configurations.
+#
+#      $ meson setup build/
+#
+#     The build directory gets ignored by Git automatically as Meson will write
+#     a ".gitignore" file into it. From hereon, we will assume that you execute
+#     commands inside this build directory.
+#
+# 2. Compile Git. You can either use Meson, Ninja or Samurai to do this, so all
+#    of the following invocations are equivalent:
+#
+#      $ meson compile
+#      $ ninja
+#      $ samu
+#
+#   The different invocations should ultimately not make much of a difference.
+#   Using Meson also works with other generators though, like when the build
+#   directory has been set up for use with Microsoft Visual Studio.
+#
+#   Ninja and Samurai use multiple jobs by default, scaling with the number of
+#   processor cores available. You can pass the `-jN` flag to change this.
+#
+#   Meson automatically picks up ccache and sccache when these are installed
+#   when setting up the build directory. You can override this behaviour when
+#   setting up the build directory by setting the `CC` environment variable to
+#   your desired compiler.
+#
+# 3. Execute tests. Again, you can either use Meson, Ninja or Samurai to do this:
+#
+#      $ meson test
+#      $ ninja test
+#      $ samu test
+#
+#   It is recommended to use Meson in this case though as it also provides you
+#   additional features that the other build systems don't have available.
+#   You can e.g. pass additional arguments to the test executables or run
+#   individual tests:
+#
+#      # Execute the t0000-basic integration test and t-reftable-stack unit test.
+#      $ meson test t0000-basic t-reftable-stack
+#
+#      # Execute all reftable unit tests.
+#      $ meson test t-reftable-*
+#
+#      # Execute all tests and stop with the first failure.
+#      $ meson test --maxfail 1
+#
+#      # Execute single test interactively such that features like `debug ()` work.
+#      $ meson test -i --test-args='-ix' t1400-update-ref
+#
+#   Test execution is parallelized by default and scales with the number of
+#   processor cores available. You can change the number of processes by passing
+#   the `-jN` flag to `meson test`.
+#
+# 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
+#    Samurai:
+#
+#      $ meson install
+#      $ ninja install
+#      $ samu install
+#
+#    The prefix into which Git shall be installed is defined when setting up
+#    the build directory. More on that in the "Configuration" section.
+#
+# Meson supports multiple backends. The default backend generates Ninja build
+# instructions, but it also supports the generation of Microsoft Visual
+# Studio solutions as well as Xcode projects by passing the `--backend` option
+# to `meson setup`. IDEs like Eclipse and Visual Studio Code provide plugins to
+# import Meson files directly.
+#
+# Configuration
+# =============
+#
+# The exact configuration of Git is determined when setting up the build
+# directory via `meson setup`. Unless told otherwise, Meson will automatically
+# detect the availability of various bits and pieces. There are two different
+# kinds of options that can be used to further tweak the build:
+#
+#   - Built-in options provided by Meson.
+#
+#   - Options defined by the project in the "meson_options.txt" file.
+#
+# Both kinds of options can be inspected by running `meson configure` in the
+# build directory, which will give you a list of the current value for all
+# options.
+#
+# Options can be configured either when setting up the build directory or can
+# be changed in preexisting build directories:
+#
+#      # Set up a new build directory with optimized settings that will be
+#      # installed into an alternative prefix.
+#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER build
+#
+#      # Set up a new build directory with a higher warning level. Level 2 is
+#      # mostly equivalent to setting DEVELOPER=1, level 3 and "everything"
+#      # will enable even more warnings.
+#      $ meson setup -Dwarning_level=2 build
+#
+#      # Set up a new build directory with 'address' and 'undefined' sanitizers
+#      # using Clang.
+#      $ CC=clang meson setup -Db_sanitize=address,undefined build
+#
+#      # Disable tests in a preexisting build directory.
+#      $ meson configure -Dtests=false
+#
+#      # Disable features based on Python
+#      $ meson configure -Dpython=disabled
+#
+# Options have a type like booleans, choices, strings or features. Features are
+# somewhat special as they can have one of three values: enabled, disabled or
+# auto. While the first two values are self-explanatory, "auto" will enable or
+# disable the feature based on the availability of prerequisites to support it.
+# Python-based features for example will be enabled automatically when a Python
+# interpreter could be found. The default value of such features can be changed
+# via `meson setup --auto-features={enabled,disabled,auto}`, which will set the
+# value of all features with a value of "auto" to the provided one by default.
+#
+# It is also possible to store a set of configuration options in machine files.
+# This can be useful in case you regularly want to reuse the same set of options:
+#
+#   [binaries]
+#   c = ['clang']
+#   ar = ['ar']
+#
+#   [project options]
+#   gettext = 'disabled'
+#   default_editor = 'vim'
+#
+#   [built-in options]
+#   b_lto = true
+#   b_sanitize = 'address,undefined'
+#
+# These machine files can be passed to `meson setup` via the `--native-file`
+# option.
+#
+# Subproject wrappers
+# ===================
+#
+# Subproject wrappers are a feature provided by Meson that allows the automatic
+# fallback to a "wrapped" dependency in case the dependency is not provided by
+# the system. For example if the system is lacking curl, then Meson will use
+# "subprojects/curl.wrap" to set up curl as a subproject and compile and link
+# the dependency into Git itself. This is especially helpful on systems like
+# Windows, where you typically don't have such dependencies installed.
+#
+# The use of subproject wrappers can be disabled by executing `meson setup`
+# with the `--wrap-mode nofallback` option.
+
+project('git', 'c',
+  meson_version: '>=1.3.0',
+  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
+  # on MSVC. So we instead fall back to C11 there.
+  default_options: ['c_std=gnu99,c11'],
+  version: 'v2.47.GIT',
+)
+
+fs = import('fs')
+
+program_path = []
+# Git for Windows provides all the tools we need to build Git.
+if host_machine.system() == 'windows'
+  program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
+endif
+
+cygpath = find_program('cygpath', dirs: program_path, required: false)
+diff = find_program('diff', dirs: program_path)
+shell = find_program('sh', dirs: program_path)
+tar = find_program('tar', dirs: program_path)
+
+script_environment = environment()
+foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
+  program = find_program(tool, dirs: program_path)
+  script_environment.prepend('PATH', fs.parent(program.full_path()))
+endforeach
+
+git = find_program('git', dirs: program_path, required: false)
+if git.found()
+  script_environment.prepend('PATH', fs.parent(git.full_path()))
+endif
+
+if get_option('sane_tool_path') != ''
+  script_environment.prepend('PATH', get_option('sane_tool_path'))
+endif
+
+compiler = meson.get_compiler('c')
+
+libgit_sources = [
+  'abspath.c',
+  'add-interactive.c',
+  'add-patch.c',
+  'advice.c',
+  'alias.c',
+  'alloc.c',
+  'apply.c',
+  'archive-tar.c',
+  'archive-zip.c',
+  'archive.c',
+  'attr.c',
+  'base85.c',
+  'bisect.c',
+  'blame.c',
+  'blob.c',
+  'bloom.c',
+  'branch.c',
+  'bulk-checkin.c',
+  'bundle-uri.c',
+  'bundle.c',
+  'cache-tree.c',
+  'cbtree.c',
+  'chdir-notify.c',
+  'checkout.c',
+  'chunk-format.c',
+  'color.c',
+  'column.c',
+  'combine-diff.c',
+  'commit-graph.c',
+  'commit-reach.c',
+  'commit.c',
+  'compat/nonblock.c',
+  'compat/obstack.c',
+  'compat/terminal.c',
+  'compat/zlib-uncompress2.c',
+  'config.c',
+  'connect.c',
+  'connected.c',
+  'convert.c',
+  'copy.c',
+  'credential.c',
+  'csum-file.c',
+  'ctype.c',
+  'date.c',
+  'decorate.c',
+  'delta-islands.c',
+  'diagnose.c',
+  'diff-delta.c',
+  'diff-merges.c',
+  'diff-lib.c',
+  'diff-no-index.c',
+  'diff.c',
+  'diffcore-break.c',
+  'diffcore-delta.c',
+  'diffcore-order.c',
+  'diffcore-pickaxe.c',
+  'diffcore-rename.c',
+  'diffcore-rotate.c',
+  'dir-iterator.c',
+  'dir.c',
+  'editor.c',
+  'entry.c',
+  'environment.c',
+  'ewah/bitmap.c',
+  'ewah/ewah_bitmap.c',
+  'ewah/ewah_io.c',
+  'ewah/ewah_rlw.c',
+  'exec-cmd.c',
+  'fetch-negotiator.c',
+  'fetch-pack.c',
+  'fmt-merge-msg.c',
+  'fsck.c',
+  'fsmonitor.c',
+  'fsmonitor-ipc.c',
+  'fsmonitor-settings.c',
+  'gettext.c',
+  'git-zlib.c',
+  'gpg-interface.c',
+  'graph.c',
+  'grep.c',
+  'hash-lookup.c',
+  'hashmap.c',
+  'help.c',
+  'hex.c',
+  'hex-ll.c',
+  'hook.c',
+  'ident.c',
+  'json-writer.c',
+  'kwset.c',
+  'levenshtein.c',
+  'line-log.c',
+  'line-range.c',
+  'linear-assignment.c',
+  'list-objects-filter-options.c',
+  'list-objects-filter.c',
+  'list-objects.c',
+  'lockfile.c',
+  'log-tree.c',
+  'loose.c',
+  'ls-refs.c',
+  'mailinfo.c',
+  'mailmap.c',
+  'match-trees.c',
+  'mem-pool.c',
+  'merge-blobs.c',
+  'merge-ll.c',
+  'merge-ort.c',
+  'merge-ort-wrappers.c',
+  'merge-recursive.c',
+  'merge.c',
+  'midx.c',
+  'midx-write.c',
+  'name-hash.c',
+  'negotiator/default.c',
+  'negotiator/noop.c',
+  'negotiator/skipping.c',
+  'notes-cache.c',
+  'notes-merge.c',
+  'notes-utils.c',
+  'notes.c',
+  'object-file-convert.c',
+  'object-file.c',
+  'object-name.c',
+  'object.c',
+  'oid-array.c',
+  'oidmap.c',
+  'oidset.c',
+  'oidtree.c',
+  'pack-bitmap-write.c',
+  'pack-bitmap.c',
+  'pack-check.c',
+  'pack-mtimes.c',
+  'pack-objects.c',
+  'pack-revindex.c',
+  'pack-write.c',
+  'packfile.c',
+  'pager.c',
+  'parallel-checkout.c',
+  'parse.c',
+  'parse-options-cb.c',
+  'parse-options.c',
+  'patch-delta.c',
+  'patch-ids.c',
+  'path.c',
+  'pathspec.c',
+  'pkt-line.c',
+  'preload-index.c',
+  'pretty.c',
+  'prio-queue.c',
+  'progress.c',
+  'promisor-remote.c',
+  'prompt.c',
+  'protocol.c',
+  'protocol-caps.c',
+  'prune-packed.c',
+  'pseudo-merge.c',
+  'quote.c',
+  'range-diff.c',
+  'reachable.c',
+  'read-cache.c',
+  'rebase-interactive.c',
+  'rebase.c',
+  'ref-filter.c',
+  'reflog-walk.c',
+  'reflog.c',
+  'refs.c',
+  'refs/debug.c',
+  'refs/files-backend.c',
+  'refs/reftable-backend.c',
+  'refs/iterator.c',
+  'refs/packed-backend.c',
+  'refs/ref-cache.c',
+  'refspec.c',
+  'reftable/basics.c',
+  'reftable/error.c',
+  'reftable/block.c',
+  'reftable/blocksource.c',
+  'reftable/iter.c',
+  'reftable/merged.c',
+  'reftable/pq.c',
+  'reftable/reader.c',
+  'reftable/record.c',
+  'reftable/stack.c',
+  'reftable/tree.c',
+  'reftable/writer.c',
+  'remote.c',
+  'replace-object.c',
+  'repo-settings.c',
+  'repository.c',
+  'rerere.c',
+  'reset.c',
+  'resolve-undo.c',
+  'revision.c',
+  'run-command.c',
+  'send-pack.c',
+  'sequencer.c',
+  'serve.c',
+  'server-info.c',
+  'setup.c',
+  'shallow.c',
+  'sideband.c',
+  'sigchain.c',
+  'sparse-index.c',
+  'split-index.c',
+  'stable-qsort.c',
+  'statinfo.c',
+  'strbuf.c',
+  'streaming.c',
+  'string-list.c',
+  'strmap.c',
+  'strvec.c',
+  'sub-process.c',
+  'submodule-config.c',
+  'submodule.c',
+  'symlinks.c',
+  'tag.c',
+  'tempfile.c',
+  'thread-utils.c',
+  'tmp-objdir.c',
+  'trace.c',
+  'trace2.c',
+  'trace2/tr2_cfg.c',
+  'trace2/tr2_cmd_name.c',
+  'trace2/tr2_ctr.c',
+  'trace2/tr2_dst.c',
+  'trace2/tr2_sid.c',
+  'trace2/tr2_sysenv.c',
+  'trace2/tr2_tbuf.c',
+  'trace2/tr2_tgt_event.c',
+  'trace2/tr2_tgt_normal.c',
+  'trace2/tr2_tgt_perf.c',
+  'trace2/tr2_tls.c',
+  'trace2/tr2_tmr.c',
+  'trailer.c',
+  'transport-helper.c',
+  'transport.c',
+  'tree-diff.c',
+  'tree-walk.c',
+  'tree.c',
+  'unpack-trees.c',
+  'upload-pack.c',
+  'url.c',
+  'urlmatch.c',
+  'usage.c',
+  'userdiff.c',
+  'utf8.c',
+  'varint.c',
+  'versioncmp.c',
+  'walker.c',
+  'wildmatch.c',
+  'worktree.c',
+  'wrapper.c',
+  'write-or-die.c',
+  'ws.c',
+  'wt-status.c',
+  'xdiff-interface.c',
+  'xdiff/xdiffi.c',
+  'xdiff/xemit.c',
+  'xdiff/xhistogram.c',
+  'xdiff/xmerge.c',
+  'xdiff/xpatience.c',
+  'xdiff/xprepare.c',
+  'xdiff/xutils.c',
+]
+
+builtin_sources = [
+  'builtin/add.c',
+  'builtin/am.c',
+  'builtin/annotate.c',
+  'builtin/apply.c',
+  'builtin/archive.c',
+  'builtin/bisect.c',
+  'builtin/blame.c',
+  'builtin/branch.c',
+  'builtin/bugreport.c',
+  'builtin/bundle.c',
+  'builtin/cat-file.c',
+  'builtin/check-attr.c',
+  'builtin/check-ignore.c',
+  'builtin/check-mailmap.c',
+  'builtin/check-ref-format.c',
+  'builtin/checkout--worker.c',
+  'builtin/checkout-index.c',
+  'builtin/checkout.c',
+  'builtin/clean.c',
+  'builtin/clone.c',
+  'builtin/column.c',
+  'builtin/commit-graph.c',
+  'builtin/commit-tree.c',
+  'builtin/commit.c',
+  'builtin/config.c',
+  'builtin/count-objects.c',
+  'builtin/credential-cache--daemon.c',
+  'builtin/credential-cache.c',
+  'builtin/credential-store.c',
+  'builtin/credential.c',
+  'builtin/describe.c',
+  'builtin/diagnose.c',
+  'builtin/diff-files.c',
+  'builtin/diff-index.c',
+  'builtin/diff-tree.c',
+  'builtin/diff.c',
+  'builtin/difftool.c',
+  'builtin/fast-export.c',
+  'builtin/fast-import.c',
+  'builtin/fetch-pack.c',
+  'builtin/fetch.c',
+  'builtin/fmt-merge-msg.c',
+  'builtin/for-each-ref.c',
+  'builtin/for-each-repo.c',
+  'builtin/fsck.c',
+  'builtin/fsmonitor--daemon.c',
+  'builtin/gc.c',
+  'builtin/get-tar-commit-id.c',
+  'builtin/grep.c',
+  'builtin/hash-object.c',
+  'builtin/help.c',
+  'builtin/hook.c',
+  'builtin/index-pack.c',
+  'builtin/init-db.c',
+  'builtin/interpret-trailers.c',
+  'builtin/log.c',
+  'builtin/ls-files.c',
+  'builtin/ls-remote.c',
+  'builtin/ls-tree.c',
+  'builtin/mailinfo.c',
+  'builtin/mailsplit.c',
+  'builtin/merge-base.c',
+  'builtin/merge-file.c',
+  'builtin/merge-index.c',
+  'builtin/merge-ours.c',
+  'builtin/merge-recursive.c',
+  'builtin/merge-tree.c',
+  'builtin/merge.c',
+  'builtin/mktag.c',
+  'builtin/mktree.c',
+  'builtin/multi-pack-index.c',
+  'builtin/mv.c',
+  'builtin/name-rev.c',
+  'builtin/notes.c',
+  'builtin/pack-objects.c',
+  'builtin/pack-redundant.c',
+  'builtin/pack-refs.c',
+  'builtin/patch-id.c',
+  'builtin/prune-packed.c',
+  'builtin/prune.c',
+  'builtin/pull.c',
+  'builtin/push.c',
+  'builtin/range-diff.c',
+  'builtin/read-tree.c',
+  'builtin/rebase.c',
+  'builtin/receive-pack.c',
+  'builtin/reflog.c',
+  'builtin/refs.c',
+  'builtin/remote-ext.c',
+  'builtin/remote-fd.c',
+  'builtin/remote.c',
+  'builtin/repack.c',
+  'builtin/replace.c',
+  'builtin/replay.c',
+  'builtin/rerere.c',
+  'builtin/reset.c',
+  'builtin/rev-list.c',
+  'builtin/rev-parse.c',
+  'builtin/revert.c',
+  'builtin/rm.c',
+  'builtin/send-pack.c',
+  'builtin/shortlog.c',
+  'builtin/show-branch.c',
+  'builtin/show-index.c',
+  'builtin/show-ref.c',
+  'builtin/sparse-checkout.c',
+  'builtin/stash.c',
+  'builtin/stripspace.c',
+  'builtin/submodule--helper.c',
+  'builtin/symbolic-ref.c',
+  'builtin/tag.c',
+  'builtin/unpack-file.c',
+  'builtin/unpack-objects.c',
+  'builtin/update-index.c',
+  'builtin/update-ref.c',
+  'builtin/update-server-info.c',
+  'builtin/upload-archive.c',
+  'builtin/upload-pack.c',
+  'builtin/var.c',
+  'builtin/verify-commit.c',
+  'builtin/verify-pack.c',
+  'builtin/verify-tag.c',
+  'builtin/worktree.c',
+  'builtin/write-tree.c',
+]
+
+libgit_sources += custom_target(
+  input: 'command-list.txt',
+  output: 'command-list.h',
+  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
+  env: script_environment,
+)
+
+libgit_sources += custom_target(
+  output: 'config-list.h',
+  command: [
+    shell,
+    meson.current_source_dir() + '/generate-configlist.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
+libgit_sources += custom_target(
+  input: 'Documentation/githooks.txt',
+  output: 'hook-list.h',
+  command: [
+    shell,
+    meson.current_source_dir() + '/generate-hooklist.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
+# This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
+# build options to our tests.
+build_options_config = configuration_data()
+build_options_config.set('GIT_INTEROP_MAKE_OPTS', '')
+build_options_config.set('GIT_PERF_LARGE_REPO', '')
+build_options_config.set('GIT_PERF_MAKE_COMMAND', '')
+build_options_config.set('GIT_PERF_MAKE_OPTS', '')
+build_options_config.set('GIT_PERF_REPEAT_COUNT', '')
+build_options_config.set('GIT_PERF_REPO', '')
+build_options_config.set('GIT_TEST_CMP_USE_COPIED_CONTEXT', '')
+build_options_config.set('GIT_TEST_INDEX_VERSION', '')
+build_options_config.set('GIT_TEST_OPTS', '')
+build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
+build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
+build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
+build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
+
+if get_option('sane_tool_path') != ''
+  build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + get_option('sane_tool_path') + '"|')
+else
+  build_options_config.set_quoted('BROKEN_PATH_FIX', '/^\# @BROKEN_PATH_FIX@$/d')
+endif
+
+test_output_directory = get_option('test_output_directory')
+if test_output_directory == ''
+  test_output_directory = meson.project_build_root() / 'test-output'
+endif
+
+# These variables are used for building libgit.a.
+libgit_c_args = [
+  '-DBINDIR="' + get_option('bindir') + '"',
+  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
+  '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
+  '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
+  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
+  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
+  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
+  '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
+  '-DGIT_EXEC_PATH="' + get_option('prefix') / get_option('libexecdir') / 'git-core"',
+  '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
+  '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
+  '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
+  '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
+  '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
+  '-DPAGER_ENV="' + get_option('pager_environment') + '"',
+  '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
+]
+libgit_include_directories = [ '.' ]
+libgit_dependencies = [ ]
+
+# Treat any warning level above 1 the same as we treat DEVELOPER=1 in our
+# Makefile.
+if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
+  foreach cflag : [
+    '-Wdeclaration-after-statement',
+    '-Wformat-security',
+    '-Wold-style-definition',
+    '-Woverflow',
+    '-Wpointer-arith',
+    '-Wstrict-prototypes',
+    '-Wunused',
+    '-Wvla',
+    '-Wwrite-strings',
+    '-fno-common',
+    '-Wtautological-constant-out-of-range-compare',
+    # If a function is public, there should be a prototype and the right
+    # header file should be included. If not, it should be static.
+    '-Wmissing-prototypes',
+    # These are disabled because we have these all over the place.
+    '-Wno-empty-body',
+    '-Wno-missing-field-initializers',
+    '-Wno-sign-compare',
+  ]
+    if compiler.has_argument(cflag)
+      libgit_c_args += cflag
+    endif
+  endforeach
+endif
+
+if get_option('b_sanitize').contains('address')
+  build_options_config.set('SANITIZE_ADDRESS', 'YesCompiledWithIt')
+else
+  build_options_config.set('SANITIZE_ADDRESS', '')
+endif
+if get_option('b_sanitize').contains('leak')
+  libgit_c_args += '-DSUPPRESS_ANNOTATED_LEAKS'
+  build_options_config.set('SANITIZE_LEAK', 'YesCompiledWithIt')
+else
+  build_options_config.set('SANITIZE_LEAK', '')
+endif
+if get_option('b_sanitize').contains('undefined')
+  libgit_c_args += '-DSHA1DC_FORCE_ALIGNED_ACCESS'
+endif
+
+executable_suffix = ''
+if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
+  executable_suffix = '.exe'
+  libgit_c_args += '-DSTRIP_EXTENSION="' + executable_suffix + '"'
+endif
+build_options_config.set_quoted('X', executable_suffix)
+
+python = import('python').find_installation('python3', required: get_option('python'))
+if python.found()
+  build_options_config.set('NO_PYTHON', '')
+else
+  libgit_c_args += '-DNO_PYTHON'
+  build_options_config.set('NO_PYTHON', '1')
+endif
+
+# Perl is used for two different things: our test harness and to provide some
+# features. It is optional if you want to neither execute tests nor use any of
+# these optional features.
+perl_required = get_option('perl')
+if get_option('tests')
+  perl_required = true
+endif
+
+# Note that we only set NO_PERL if the Perl features were disabled by the user.
+# It may not be set when we have found Perl, but only use it to run tests.
+perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
+perl_features_enabled = perl.found() and get_option('perl').allowed()
+if perl_features_enabled
+  build_options_config.set('NO_PERL', '')
+
+  if get_option('runtime_prefix')
+    build_options_config.set('PERL_LOCALEDIR', '')
+  else
+    build_options_config.set_quoted('PERL_LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
+  endif
+
+  if get_option('perl_cpan_fallback')
+    build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
+  else
+    build_options_config.set_quoted('NO_PERL_CPAN_FALLBACKS', 'YesPlease')
+  endif
+else
+  libgit_c_args += '-DNO_PERL'
+  build_options_config.set('NO_PERL', '1')
+  build_options_config.set('PERL_LOCALEDIR', '')
+  build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
+endif
+
+zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
+if zlib.version().version_compare('<1.2.0')
+  libgit_c_args += '-DNO_DEFLATE_BOUND'
+endif
+libgit_dependencies += zlib
+
+threads = dependency('threads', required: false)
+if threads.found()
+  libgit_dependencies += threads
+  build_options_config.set('NO_PTHREADS', '')
+else
+  libgit_c_args += '-DNO_PTHREADS'
+  build_options_config.set('NO_PTHREADS', '1')
+endif
+
+msgfmt = find_program('msgfmt', dirs: program_path, required: false)
+gettext_option = get_option('gettext').disable_auto_if(not msgfmt.found())
+if not msgfmt.found() and gettext_option.enabled()
+  error('Internationalization via libintl requires msgfmt')
+endif
+
+if gettext_option.allowed() and host_machine.system() == 'darwin' and get_option('macos_use_homebrew_gettext')
+  if host_machine.cpu_family() == 'x86_64'
+    libintl_prefix = '/usr/local'
+  elif host_machine.cpu_family() == 'aarch64'
+    libintl_prefix = '/opt/homebrew'
+  else
+    error('Homebrew workaround not supported on current architecture')
+  endif
+
+  intl = compiler.find_library('intl', dirs: libintl_prefix / 'lib', required: gettext_option)
+  if intl.found()
+    intl = declare_dependency(
+      dependencies: intl,
+      include_directories: libintl_prefix / 'include',
+    )
+  endif
+else
+  intl = dependency('intl', required: gettext_option)
+endif
+if intl.found()
+  libgit_dependencies += intl
+  build_options_config.set('NO_GETTEXT', '')
+  build_options_config.set('USE_GETTEXT_SCHEME', '')
+else
+  libgit_c_args += '-DNO_GETTEXT'
+  build_options_config.set('NO_GETTEXT', '1')
+  build_options_config.set('USE_GETTEXT_SCHEME', 'fallthrough')
+endif
+
+iconv = dependency('iconv', required: get_option('iconv'))
+if iconv.found()
+  libgit_dependencies += iconv
+  build_options_config.set('NO_ICONV', '')
+
+  have_old_iconv = false
+  if not compiler.compiles('''
+    #include <iconv.h>
+
+    extern size_t iconv(iconv_t cd,
+                        char **inbuf, size_t *inbytesleft,
+                        char **outbuf, size_t *outbytesleft);
+  ''', name: 'old iconv interface', dependencies: [iconv])
+    libgit_c_args += '-DOLD_ICONV'
+    have_old_iconv = true
+  endif
+
+  iconv_omits_bom_source = '''#
+    #include <iconv.h>
+
+    int main(int argc, const char **argv)
+    {
+  '''
+  if have_old_iconv
+    iconv_omits_bom_source += '''
+      typedef const char *iconv_ibp;
+    '''
+  else
+    iconv_omits_bom_source += '''
+      typedef char *iconv_ibp;
+    '''
+  endif
+  iconv_omits_bom_source += '''
+      int v;
+      iconv_t conv;
+      char in[] = "a"; iconv_ibp pin = in;
+      char out[20] = ""; char *pout = out;
+      size_t isz = sizeof in;
+      size_t osz = sizeof out;
+
+      conv = iconv_open("UTF-16", "UTF-8");
+      iconv(conv, &pin, &isz, &pout, &osz);
+      iconv_close(conv);
+      v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
+      return v != 0xfe + 0xff;
+    }
+  '''
+
+  if compiler.run(iconv_omits_bom_source,
+    dependencies: iconv,
+    name: 'iconv omits BOM',
+  ).returncode() != 0
+    libgit_c_args += '-DICONV_OMITS_BOM'
+  endif
+else
+  libgit_c_args += '-DNO_ICONV'
+  build_options_config.set('NO_ICONV', '1')
+endif
+
+pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
+if pcre2.found()
+  libgit_dependencies += pcre2
+  libgit_c_args += '-DUSE_LIBPCRE2'
+  build_options_config.set('USE_LIBPCRE2', '1')
+else
+  build_options_config.set('USE_LIBPCRE2', '')
+endif
+
+curl = dependency('libcurl', version: '>=7.21.3', required: get_option('curl'), default_options: ['default_library=static', 'tests=disabled', 'tool=disabled'])
+use_curl_for_imap_send = false
+if curl.found()
+  if curl.version().version_compare('>=7.34.0')
+    libgit_c_args += '-DUSE_CURL_FOR_IMAP_SEND'
+    use_curl_for_imap_send = true
+  endif
+
+  libgit_dependencies += curl
+  libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
+  build_options_config.set('NO_CURL', '')
+else
+  libgit_c_args += '-DNO_CURL'
+  build_options_config.set('NO_CURL', '1')
+endif
+
+expat = dependency('expat', required: get_option('expat'), default_options: ['default_library=static', 'build_tests=false'])
+if expat.found()
+  libgit_dependencies += expat
+
+  if expat.version().version_compare('<=1.2')
+    libgit_c_args += '-DEXPAT_NEEDS_XMLPARSE_H'
+  endif
+  build_options_config.set('NO_EXPAT', '')
+else
+  libgit_c_args += '-DNO_EXPAT'
+  build_options_config.set('NO_EXPAT', '1')
+endif
+
+if not compiler.has_header('sys/select.h')
+  libgit_c_args += '-DNO_SYS_SELECT_H'
+endif
+
+has_poll_h = compiler.has_header('poll.h')
+if not has_poll_h
+  libgit_c_args += '-DNO_POLL_H'
+endif
+
+has_sys_poll_h = compiler.has_header('sys/poll.h')
+if not has_sys_poll_h
+  libgit_c_args += '-DNO_SYS_POLL_H'
+endif
+
+if not has_poll_h and not has_sys_poll_h
+  libgit_c_args += '-DNO_POLL'
+  libgit_sources += 'compat/poll/poll.c'
+  libgit_include_directories += 'compat/poll'
+endif
+
+if not compiler.has_header('inttypes.h')
+  libgit_c_args += '-DNO_INTTYPES_H'
+endif
+
+if compiler.has_header('libcharset.h')
+  libcharset = compiler.find_library('charset')
+
+  if compiler.has_function('locale_charset',
+    prefix: '#include <libcharset.h>',
+    dependencies: iconv,
+  )
+    libgit_c_args += '-DHAVE_LIBCHARSET_H'
+  elif compiler.has_function('locale_charset',
+    prefix: '#include <libcharset.h>',
+    dependencies: libcharset,
+  )
+    libgit_c_args += '-DHAVE_LIBCHARSET_H'
+  endif
+endif
+
+if compiler.has_header('alloca.h')
+  libgit_c_args += '-DHAVE_ALLOCA_H'
+endif
+
+if compiler.has_header('sys/sysinfo.h')
+  libgit_c_args += '-DHAVE_SYSINFO'
+endif
+
+# Windows has libgen.h and a basename implementation, but we still need our own
+# implementation to threat things like drive prefixes specially.
+if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
+  libgit_c_args += '-DNO_LIBGEN_H'
+  libgit_sources += 'compat/basename.c'
+endif
+
+if compiler.has_header('paths.h')
+  libgit_c_args += '-DHAVE_PATHS_H'
+endif
+
+if compiler.has_header('strings.h')
+  libgit_c_args += '-DHAVE_STRINGS_H'
+endif
+
+networking_dependencies = [ ]
+if host_machine.system() == 'windows'
+  winsock = compiler.find_library('ws2_32', required: false)
+  if winsock.found()
+    networking_dependencies += winsock
+  endif
+else
+  libresolv = compiler.find_library('resolv', required: false)
+  if libresolv.found()
+    networking_dependencies += libresolv
+  endif
+endif
+libgit_dependencies += networking_dependencies
+
+foreach symbol : ['inet_ntop', 'inet_pton', 'strerror']
+  if not compiler.has_function(symbol, dependencies: networking_dependencies)
+    libgit_c_args += '-DNO_' + symbol.to_upper()
+  endif
+endforeach
+
+has_ipv6 = compiler.has_function('getaddrinfo', dependencies: networking_dependencies)
+if not has_ipv6
+  libgit_c_args += '-DNO_IPV6'
+endif
+
+if not compiler.compiles('''
+  #ifdef _WIN32
+  # include <winsock2.h>
+  #else
+  # include <sys/types.h>
+  # include <sys/socket.h>
+  #endif
+
+  void func(void)
+  {
+    struct sockaddr_storage x;
+  }
+''', name: 'struct sockaddr_storage')
+  if has_ipv6
+    libgit_c_args += '-Dsockaddr_storage=sockaddr_in6'
+  else
+    libgit_c_args += '-Dsockaddr_storage=sockaddr_in'
+  endif
+endif
+
+if compiler.has_function('socket', dependencies: networking_dependencies)
+  libgit_sources += [
+    'unix-socket.c',
+    'unix-stream-server.c',
+  ]
+  build_options_config.set('NO_UNIX_SOCKETS', '')
+else
+  libgit_c_args += '-DNO_UNIX_SOCKETS'
+  build_options_config.set('NO_UNIX_SOCKETS', '1')
+endif
+
+if not compiler.has_function('pread')
+  libgit_c_args += '-DNO_PREAD'
+  libgit_sources += 'compat/pread.c'
+endif
+
+if host_machine.system() == 'darwin'
+  libgit_sources += 'compat/precompose_utf8.c'
+  libgit_c_args += '-DPRECOMPOSE_UNICODE'
+  libgit_c_args += '-DPROTECT_HFS_DEFAULT'
+endif
+
+# Configure general compatibility wrappers.
+if host_machine.system() == 'cygwin'
+  libgit_sources += [
+    'compat/win32/path-utils.c',
+  ]
+elif host_machine.system() == 'windows'
+  libgit_sources += [
+    'compat/mingw.c',
+    'compat/winansi.c',
+    'compat/win32/flush.c',
+    'compat/win32/path-utils.c',
+    'compat/win32/pthread.c',
+    'compat/win32/syslog.c',
+    'compat/win32/dirent.c',
+    'compat/win32mmap.c',
+    'compat/nedmalloc/nedmalloc.c',
+  ]
+
+  libgit_c_args += [
+    '-DDETECT_MSYS_TTY',
+    '-DENSURE_MSYSTEM_IS_SET',
+    '-DNATIVE_CRLF',
+    '-DNOGDI',
+    '-DNO_POSIX_GOODIES',
+    '-DWIN32',
+    '-D_CONSOLE',
+    '-D_CONSOLE_DETECT_MSYS_TTY',
+    '-D__USE_MINGW_ANSI_STDIO=0',
+  ]
+
+  libgit_dependencies += compiler.find_library('ntdll')
+  libgit_include_directories += 'compat/win32'
+  if compiler.get_id() == 'msvc'
+    libgit_include_directories += 'compat/vcbuild/include'
+  endif
+endif
+
+if host_machine.system() == 'linux'
+  libgit_sources += 'compat/linux/procinfo.c'
+elif host_machine.system() == 'windows'
+  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
+else
+  libgit_sources += 'compat/stub/procinfo.c'
+endif
+
+if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
+  libgit_c_args += [
+    '-DUNRELIABLE_FSTAT',
+    '-DMMAP_PREVENTS_DELETE',
+    '-DOBJECT_CREATION_MODE=1',
+  ]
+endif
+
+# Configure the simple-ipc subsystem required fro the fsmonitor.
+if host_machine.system() == 'windows'
+  libgit_sources += [
+    'compat/simple-ipc/ipc-shared.c',
+    'compat/simple-ipc/ipc-win32.c',
+  ]
+  libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
+else
+  libgit_sources += [
+    'compat/simple-ipc/ipc-shared.c',
+    'compat/simple-ipc/ipc-unix-socket.c',
+  ]
+  libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
+endif
+
+fsmonitor_backend = ''
+if host_machine.system() == 'windows'
+  fsmonitor_backend = 'win32'
+elif host_machine.system() == 'darwin'
+  fsmonitor_backend = 'darwin'
+  libgit_dependencies += dependency('CoreServices')
+endif
+if fsmonitor_backend != ''
+  libgit_c_args += '-DHAVE_FSMONITOR_DAEMON_BACKEND'
+  libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
+
+  libgit_sources += [
+    'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+  ]
+endif
+build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
+build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
+
+if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
+  build_options_config.set('NO_REGEX', '')
+
+  if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
+    libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
+    libgit_sources += 'compat/regcomp_enhanced.c'
+  endif
+elif not get_option('regex').enabled()
+  libgit_c_args += [
+    '-DNO_REGEX',
+    '-DGAWK',
+    '-DNO_MBSUPPORT',
+  ]
+  build_options_config.set('NO_REGEX', '1')
+  libgit_sources += 'compat/regex/regex.c'
+  libgit_include_directories += 'compat/regex'
+else
+    error('Native regex support requested but not found')
+endif
+
+# setitimer and friends are provided by compat/mingw.c.
+if host_machine.system() != 'windows'
+  if not compiler.compiles('''
+    #include <sys/time.h>
+    void func(void)
+    {
+      struct itimerval value;
+    }
+  ''', name: 'struct itimerval')
+    libgit_c_args += '-DNO_STRUCT_ITIMERVAL'
+    libgit_c_args += '-DNO_SETITIMER'
+  elif not compiler.has_function('setitimer')
+    libgit_c_args += '-DNO_SETITIMER'
+  endif
+endif
+
+if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: '#include <sys/stat.h>')
+  libgit_c_args += '-DUSE_ST_TIMESPEC'
+elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix: '#include <sys/stat.h>')
+  libgit_c_args += '-DNO_NSEC'
+endif
+
+if not compiler.has_member('struct stat', 'st_blocks', prefix: '#include <sys/stat.h>')
+  libgit_c_args += '-DNO_ST_BLOCKS_IN_STRUCT_STAT'
+endif
+
+if not compiler.has_member('struct dirent', 'd_type', prefix: '#include <dirent.h>')
+  libgit_c_args += '-DNO_D_TYPE_IN_DIRENT'
+endif
+
+if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#include <pwd.h>')
+  libgit_c_args += '-DNO_GECOS_IN_PWENT'
+endif
+
+if compiler.has_function('sync_file_range')
+  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
+endif
+
+if not compiler.has_function('strcasestr')
+  libgit_c_args += '-DNO_STRCASESTR'
+  libgit_sources += 'compat/strcasestr.c'
+endif
+
+if not compiler.has_function('memmem')
+  libgit_c_args += '-DNO_MEMMEM'
+  libgit_sources += 'compat/memmem.c'
+endif
+
+if not compiler.has_function('strlcpy')
+  libgit_c_args += '-DNO_STRLCPY'
+  libgit_sources += 'compat/strlcpy.c'
+endif
+
+if not compiler.has_function('strdup')
+  libgit_c_args += '-DOVERRIDE_STRDUP'
+  libgit_sources += 'compat/strdup.c'
+endif
+
+if not compiler.has_function('strtoumax')
+  libgit_c_args += '-DNO_STRTOUMAX'
+  libgit_sources += [
+    'compat/strtoumax.c',
+    'compat/strtoimax.c',
+  ]
+endif
+
+if not compiler.has_function('strtoull')
+  libgit_c_args += '-DNO_STRTOULL'
+endif
+
+if not compiler.has_function('setenv')
+  libgit_c_args += '-DNO_SETENV'
+  libgit_sources += 'compat/setenv.c'
+endif
+
+if not compiler.has_function('qsort')
+  libgit_c_args += '-DINTERNAL_QSORT'
+endif
+libgit_sources += 'compat/qsort_s.c'
+
+# unsetenv is provided by compat/mingw.c.
+if host_machine.system() != 'windows' and not compiler.has_function('unsetenv')
+  libgit_c_args += '-DNO_UNSETENV'
+  libgit_sources += 'compat/unsetenv.c'
+endif
+
+if not compiler.has_function('mkdtemp')
+  libgit_c_args += '-DNO_MKDTEMP'
+  libgit_sources += 'compat/mkdtemp.c'
+endif
+
+if not compiler.has_function('initgroups')
+  libgit_c_args += '-DNO_INITGROUPS'
+endif
+
+if compiler.has_function('getdelim')
+  libgit_c_args += '-DHAVE_GETDELIM'
+endif
+
+if host_machine.system() == 'windows'
+  libgit_c_args += '-DUSE_WIN32_MMAP'
+elif not compiler.has_function('mmap')
+  libgit_c_args += '-DNO_MMAP'
+  libgit_sources += 'compat/mmap.c'
+endif
+
+if compiler.has_function('clock_gettime')
+  libgit_c_args += '-DHAVE_CLOCK_GETTIME'
+endif
+
+if compiler.compiles('''
+  #include <time.h>
+
+  void func(void)
+  {
+    clockid_t id = CLOCK_MONOTONIC;
+  }
+''', name: 'monotonic clock')
+  libgit_c_args += '-DHAVE_CLOCK_MONOTONIC'
+endif
+
+if not compiler.compiles('''
+  #include <inttypes.h>
+
+  void func(void)
+  {
+    uintmax_t x = 0;
+  }
+''', name: 'uintmax_t')
+  libgit_c_args += '-DNO_UINTMAX_T'
+endif
+
+has_bsd_sysctl = false
+if compiler.has_header('sys/sysctl.h')
+  if compiler.compiles('''
+    #include <stddef.h>
+    #include <sys/sysctl.h>
+
+    void func(void)
+    {
+      int val, mib[2] = { 0 };
+      size_t len = sizeof(val);
+      sysctl(mib, 2, &val, &len, NULL, 0);
+    }
+  ''', name: 'BSD sysctl')
+    libgit_c_args += '-DHAVE_BSD_SYSCTL'
+    has_bsd_sysctl = true
+  endif
+endif
+
+if not meson.is_cross_build() and compiler.run('''
+  #include <stdio.h>
+
+  int main(int argc, const char **argv)
+  {
+    FILE *f = fopen(".", "r");
+    return f ? 0 : 1;
+  }
+''', name: 'fread reads directories').returncode() == 0
+  libgit_c_args += '-DFREAD_READS_DIRECTORIES'
+  libgit_sources += 'compat/fopen.c'
+endif
+
+if not meson.is_cross_build() and fs.exists('/dev/tty')
+  libgit_c_args += '-DHAVE_DEV_TTY'
+endif
+
+https_backend = get_option('https_backend')
+
+security_framework = dependency('Security', required: https_backend == 'CommonCrypto')
+core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
+if https_backend == 'auto' and security_framework.found()
+  https_backend = 'CommonCrypto'
+endif
+
+openssl_required = https_backend == 'openssl' or get_option('sha1_backend') == 'openssl' or get_option('sha256_backend') == 'openssl'
+openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
+if https_backend == 'auto' and openssl.found()
+  https_backend = 'openssl'
+endif
+
+if https_backend == 'CommonCrypto'
+  libgit_dependencies += security_framework
+  libgit_dependencies += core_foundation_framework
+  libgit_c_args += '-DAPPLE_COMMON_CRYPTO'
+elif https_backend == 'openssl'
+  libgit_dependencies += openssl
+else
+  # We either couldn't find any dependencies with 'auto' or the user requested
+  # 'none'. Both cases are benign.
+endif
+
+if https_backend != 'openssl'
+  libgit_c_args += '-DNO_OPENSSL'
+endif
+
+sha1_backend = get_option('sha1_backend')
+if sha1_backend == 'sha1dc'
+  libgit_c_args += '-DSHA1_DC'
+  libgit_c_args += '-DSHA1DC_NO_STANDARD_INCLUDES=1'
+  libgit_c_args += '-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0'
+  libgit_c_args += '-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"'
+  libgit_c_args += '-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h"'
+
+  libgit_sources += [
+    'sha1dc_git.c',
+    'sha1dc/sha1.c',
+    'sha1dc/ubc_check.c',
+  ]
+elif sha1_backend == 'common-crypto'
+  libgit_c_args += '-DCOMMON_DIGEST_FOR_OPENSSL'
+  libgit_c_args += '-DSHA1_APPLE'
+  # Apple CommonCrypto requires chunking
+  libgit_c_args += '-DSHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L'
+elif sha1_backend == 'openssl'
+  libgit_c_args += '-DSHA1_OPENSSL'
+  libgit_dependencies += openssl
+elif sha1_backend == 'block'
+  libgit_c_args += '-DSHA1_BLK'
+  libgit_sources += 'block-sha1/sha1.c'
+else
+  error('Unhandled SHA1 backend ' + sha1_backend)
+endif
+
+sha256_backend = get_option('sha256_backend')
+if sha256_backend == 'openssl'
+  libgit_c_args += '-DSHA256_OPENSSL'
+  libgit_dependencies += openssl
+elif sha256_backend == 'nettle'
+  nettle = dependency('nettle')
+  libgit_dependencies += nettle
+  libgit_c_args += '-DSHA256_NETTLE'
+elif sha256_backend == 'gcrypt'
+  gcrypt = dependency('gcrypt')
+  libgit_dependencies += gcrypt
+  libgit_c_args += '-DSHA256_GCRYPT'
+elif sha256_backend == 'block'
+  libgit_c_args += '-DSHA256_BLK'
+  libgit_sources += 'sha256/block/sha256.c'
+else
+  error('Unhandled SHA256 backend ' + sha256_backend)
+endif
+
+if compiler.has_header_symbol('stdlib.h', 'arc4random_buf')
+  libgit_c_args += '-DHAVE_ARC4RANDOM'
+elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
+  libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
+elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
+  libgit_c_args += '-DHAVE_GETRANDOM'
+elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
+  libgit_c_args += '-DHAVE_GETENTROPY'
+elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
+  libgit_c_args += '-DHAVE_RTLGENRANDOM'
+elif openssl.found()
+  libgit_c_args += '-DHAVE_OPENSSL_CSPRNG'
+endif
+
+if get_option('runtime_prefix')
+  libgit_c_args += '-DRUNTIME_PREFIX'
+  build_options_config.set('RUNTIME_PREFIX', 'true')
+
+  if compiler.has_header('mach-o/dyld.h')
+    libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
+  endif
+
+  if has_bsd_sysctl and compiler.compiles('''
+    #include <sys/sysctl.h>
+
+    void func(void)
+    {
+      KERN_PROC_PATHNAME; KERN_PROC;
+    }
+  ''', name: 'BSD KERN_PROC_PATHNAME')
+    libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
+  endif
+
+  if host_machine.system() == 'linux'
+    libgit_c_args += '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe' + '"'
+  elif host_machine.system() == 'openbsd'
+    libgit_c_args += '-DPROCFS_EXECUTABLE_PATH="' + '/proc/curproc/file' + '"'
+  elif host_machine.system() == 'netbsd'
+    libgit_c_args += '-DPROCFS_EXECUTABLE_PATH="' + '/proc/curproc/exe' + '"'
+  endif
+
+  if host_machine.system() == 'windows' and compiler.compiles('''
+    #include <stdlib.h>
+
+    void func(void)
+    {
+      _wpgmptr;
+    }
+  ''', name: 'Win32 _wpgmptr')
+    libgit_c_args += '-DHAVE_WPGMPTR'
+  endif
+else
+  build_options_config.set('RUNTIME_PREFIX', 'false')
+endif
+
+foreach key, value : {
+  'DIFF': diff.full_path(),
+  'GIT_TEST_CMP': diff.full_path() + ' -u',
+  'GIT_TEST_GITPERLLIB': meson.project_build_root() / 'perl',
+  'GIT_TEST_MERGE_TOOLS_DIR': meson.project_source_root() / 'mergetools',
+  'GIT_TEST_POPATH': meson.project_source_root() / 'po',
+  'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
+  'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
+  'PAGER_ENV': get_option('pager_environment'),
+  'PERL_PATH': perl.found() ? perl.full_path() : '',
+  'PYTHON_PATH': python.found () ? python.full_path() : '',
+  'SHELL_PATH': shell.full_path(),
+  'TAR': tar.full_path(),
+  'TEST_OUTPUT_DIRECTORY': test_output_directory,
+  'TEST_SHELL_PATH': shell.full_path(),
+}
+  if value != '' and cygpath.found()
+    value = run_command(cygpath, value, check: true).stdout().strip()
+  endif
+  build_options_config.set_quoted(key, value)
+endforeach
+
+configure_file(
+  input: 'GIT-BUILD-OPTIONS.in',
+  output: 'GIT-BUILD-OPTIONS',
+  configuration: build_options_config,
+)
+
+git_version_file = custom_target(
+  command: [
+    shell,
+    meson.current_source_dir() / 'GIT-VERSION-GEN',
+    meson.current_source_dir(),
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  input: meson.current_source_dir() / 'GIT-VERSION-FILE.in',
+  output: 'GIT-VERSION-FILE',
+  build_always_stale: true,
+)
+
+version_def_h = custom_target(
+  command: [
+    shell,
+    meson.current_source_dir() / 'GIT-VERSION-GEN',
+    meson.current_source_dir(),
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  input: meson.current_source_dir() / 'version-def.h.in',
+  output: 'version-def.h',
+  # Depend on GIT-VERSION-FILE so that we don't always try to rebuild this
+  # target for the same commit.
+  depends: [git_version_file],
+)
+
+# Build a separate library for "version.c" so that we do not have to rebuild
+# everything when the current Git commit changes.
+libgit_version_library = static_library('git-version',
+  sources: [
+    'version.c',
+    version_def_h,
+  ],
+  c_args: libgit_c_args,
+  dependencies: libgit_dependencies,
+  include_directories: libgit_include_directories,
+)
+
+libgit_library = static_library('git',
+  sources: libgit_sources,
+  c_args: libgit_c_args,
+  link_with: libgit_version_library,
+  dependencies: libgit_dependencies,
+  include_directories: libgit_include_directories,
+)
+
+libgit = declare_dependency(
+  compile_args: libgit_c_args,
+  link_with: libgit_library,
+  dependencies: libgit_dependencies,
+  include_directories: libgit_include_directories,
+)
+
+common_main_sources = ['common-main.c']
+common_main_link_args = [ ]
+if host_machine.system() == 'windows'
+  git_rc = custom_target(
+    command: [
+      shell,
+      meson.current_source_dir() / 'GIT-VERSION-GEN',
+      meson.current_source_dir(),
+      '@INPUT@',
+      '@OUTPUT@',
+    ],
+    input: meson.current_source_dir() / 'git.rc.in',
+    output: 'git.rc',
+    depends: [git_version_file],
+  )
+
+  common_main_sources += import('windows').compile_resources(git_rc,
+    include_directories: [meson.current_source_dir()],
+  )
+  if compiler.get_argument_syntax() == 'gcc'
+    common_main_link_args += [
+      '-municode',
+      '-Wl,-nxcompat',
+      '-Wl,-dynamicbase',
+      '-Wl,-pic-executable,-e,mainCRTStartup',
+    ]
+  elif compiler.get_argument_syntax() == 'msvc'
+    common_main_link_args += [
+      '/ENTRY:wmainCRTStartup',
+      'invalidcontinue.obj',
+    ]
+  else
+    error('Unsupported compiler ' + compiler.get_id())
+  endif
+endif
+common_main_library = static_library('common-main',
+  sources: common_main_sources,
+  c_args: libgit_c_args,
+  dependencies: libgit_dependencies,
+  include_directories: libgit_include_directories,
+)
+common_main = declare_dependency(
+  link_with: common_main_library,
+  link_args: common_main_link_args,
+)
+
+bin_wrappers = [ ]
+test_dependencies = [ ]
+
+git = executable('git',
+  sources: builtin_sources + 'git.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+bin_wrappers += git
+
+test_dependencies += executable('git-daemon',
+  sources: 'daemon.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+test_dependencies += executable('git-sh-i18n--envsubst',
+  sources: 'sh-i18n--envsubst.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+bin_wrappers += executable('git-shell',
+  sources: 'shell.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+test_dependencies += executable('git-http-backend',
+  sources: 'http-backend.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+bin_wrappers += executable('scalar',
+  sources: 'scalar.c',
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+if get_option('curl').enabled()
+  curl_sources = [
+    'http.c',
+    'http-walker.c',
+  ]
+
+  git_remote_http = executable('git-remote-http',
+    sources: curl_sources + 'remote-curl.c',
+    dependencies: [libgit, common_main],
+    install: true,
+    install_dir: get_option('libexecdir') / 'git-core',
+  )
+  test_dependencies += git_remote_http
+
+  test_dependencies += executable('git-http-fetch',
+    sources: curl_sources + 'http-fetch.c',
+    dependencies: [libgit, common_main],
+    install: true,
+    install_dir: get_option('libexecdir') / 'git-core',
+  )
+
+  if expat.found()
+    test_dependencies += executable('git-http-push',
+      sources: curl_sources + 'http-push.c',
+      dependencies: [libgit, common_main],
+      install: true,
+      install_dir: get_option('libexecdir') / 'git-core',
+    )
+  endif
+
+  foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
+    test_dependencies += executable(alias,
+      objects: git_remote_http.extract_all_objects(recursive: false),
+      dependencies: [libgit, common_main],
+    )
+
+    install_symlink(alias + executable_suffix,
+      install_dir: get_option('libexecdir') / 'git-core',
+      pointing_to: 'git-remote-http',
+    )
+  endforeach
+endif
+
+imap_send_sources = ['imap-send.c']
+if use_curl_for_imap_send
+  imap_send_sources += curl_sources
+endif
+
+test_dependencies += executable('git-imap-send',
+  sources: imap_send_sources,
+  dependencies: [libgit, common_main],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
+  bin_wrappers += executable(alias,
+    objects: git.extract_all_objects(recursive: false),
+    dependencies: [libgit, common_main],
+  )
+
+  install_symlink(alias + executable_suffix,
+    install_dir: get_option('libexecdir') / 'git-core',
+    pointing_to: 'git-remote-http',
+  )
+endforeach
+
+foreach symlink : [
+  'git',
+  'git-receive-pack',
+  'git-shell',
+  'git-upload-archive',
+  'git-upload-pack',
+  'scalar',
+]
+  install_symlink(symlink,
+    install_dir: get_option('bindir'),
+    pointing_to: fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir')),
+  )
+endforeach
+
+scripts_sh = [
+  'git-difftool--helper.sh',
+  'git-filter-branch.sh',
+  'git-merge-octopus.sh',
+  'git-merge-one-file.sh',
+  'git-merge-resolve.sh',
+  'git-mergetool--lib.sh',
+  'git-mergetool.sh',
+  'git-quiltimport.sh',
+  'git-request-pull.sh',
+  'git-sh-i18n.sh',
+  'git-sh-setup.sh',
+  'git-submodule.sh',
+  'git-web--browse.sh',
+]
+if perl_features_enabled
+  scripts_sh += 'git-instaweb.sh'
+endif
+
+foreach script : scripts_sh
+  test_dependencies += custom_target(
+    input: script,
+    output: fs.stem(script),
+    command: [
+      shell,
+      meson.project_source_root() / 'generate-script.sh',
+      '@INPUT@',
+      '@OUTPUT@',
+      meson.project_build_root() / 'GIT-BUILD-OPTIONS',
+    ],
+    install: true,
+    install_dir: get_option('libexecdir') / 'git-core',
+  )
+endforeach
+
+if perl_features_enabled
+  scripts_perl = [
+    'git-archimport.perl',
+    'git-cvsexportcommit.perl',
+    'git-cvsimport.perl',
+    'git-cvsserver.perl',
+    'git-send-email.perl',
+    'git-svn.perl',
+  ]
+
+  pathsep = ':'
+  if host_machine.system() == 'windows'
+    pathsep = ';'
+  endif
+
+  perl_header_template = 'perl/header_templates/fixed_prefix.template.pl'
+  if get_option('runtime_prefix')
+    perl_header_template = 'perl/header_templates/runtime_prefix.template.pl'
+  endif
+
+  perl_header = configure_file(
+    input: perl_header_template,
+    output: 'GIT-PERL-HEADER',
+    configuration: {
+      'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
+      'PERLLIBDIR_REL': get_option('datadir') / 'perl5',
+      'LOCALEDIR_REL': get_option('datadir') / 'locale',
+      'INSTLIBDIR': get_option('datadir') / 'perl5',
+      'PATHSEP': pathsep,
+    },
+  )
+
+  generate_perl_command = [
+    shell,
+    meson.project_source_root() / 'generate-perl.sh',
+    meson.project_build_root() / 'GIT-BUILD-OPTIONS',
+    git_version_file.full_path(),
+    perl_header,
+    '@INPUT@',
+    '@OUTPUT@',
+  ]
+
+  foreach script : scripts_perl
+    generated_script = custom_target(
+      input: script,
+      output: fs.stem(script),
+      command: generate_perl_command,
+      install: true,
+      install_dir: get_option('libexecdir') / 'git-core',
+      depends: [git_version_file],
+    )
+    test_dependencies += generated_script
+
+    if script == 'git-cvsserver.perl'
+      bin_wrappers += generated_script
+
+      install_symlink(fs.stem(script),
+        install_dir: get_option('bindir'),
+        pointing_to: fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir')),
+      )
+    endif
+  endforeach
+
+  subdir('perl')
+endif
+
+if python.found()
+  scripts_python = [
+    'git-p4.py'
+  ]
+
+  foreach script : scripts_python
+    fs.copyfile(script, fs.stem(script),
+      install: true,
+      install_dir: get_option('libexecdir') / 'git-core',
+    )
+  endforeach
+endif
+
+mergetools = [
+  'mergetools/araxis',
+  'mergetools/bc',
+  'mergetools/codecompare',
+  'mergetools/deltawalker',
+  'mergetools/diffmerge',
+  'mergetools/diffuse',
+  'mergetools/ecmerge',
+  'mergetools/emerge',
+  'mergetools/examdiff',
+  'mergetools/guiffy',
+  'mergetools/gvimdiff',
+  'mergetools/kdiff3',
+  'mergetools/kompare',
+  'mergetools/meld',
+  'mergetools/nvimdiff',
+  'mergetools/opendiff',
+  'mergetools/p4merge',
+  'mergetools/smerge',
+  'mergetools/tkdiff',
+  'mergetools/tortoisemerge',
+  'mergetools/vimdiff',
+  'mergetools/vscode',
+  'mergetools/winmerge',
+  'mergetools/xxdiff',
+]
+
+foreach mergetool : mergetools
+  install_data(mergetool, install_dir: get_option('libexecdir') / 'git-core' / 'mergetools')
+endforeach
+
+if intl.found()
+  subdir('po')
+endif
+subdir('contrib')
+subdir('gitweb')
+subdir('templates')
+
+# Everything but the bin-wrappers need to come before this target such that we
+# can properly set up test dependencies. The bin-wrappers themselves are set up
+# at configuration time, so these are fine.
+if get_option('tests')
+  subdir('t')
+endif
+
+subdir('bin-wrappers')
+if get_option('docs') != []
+  subdir('Documentation')
+endif
+
+summary({
+  'curl': curl.found(),
+  'expat': expat.found(),
+  'gettext': intl.found(),
+  'https': https_backend,
+  'iconv': iconv.found(),
+  'pcre2': pcre2.found(),
+  'perl': perl_features_enabled,
+  'python': python.found(),
+}, section: 'Auto-detected features')
diff --git a/meson_options.txt b/meson_options.txt
new file mode 100644
index 0000000000000000000000000000000000000000..32a72139bae870745d9131cc9086a4594826be91
--- /dev/null
+++ b/meson_options.txt
@@ -0,0 +1,81 @@
+# Configuration for how Git behaves at runtime.
+option('default_pager', type: 'string', value: 'less',
+  description: 'Fall-back pager.')
+option('default_editor', type: 'string', value: 'vi',
+  description: 'Fall-back editor.')
+option('gitconfig', type: 'string', value: '/etc/gitconfig',
+  description: 'Path to the global git configuration file.')
+option('gitattributes', type: 'string', value: '/etc/gitattributes',
+  description: 'Path to the global git attributes file.')
+option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
+  description: 'Environment used when spawning the pager')
+option('perl_cpan_fallback', type: 'boolean', value: true,
+  description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
+option('runtime_prefix', type: 'boolean', value: false,
+  description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
+option('sane_tool_path', type: 'string', value: '',
+  description: 'A colon-separated list of paths to prepend to PATH if your tools in /usr/bin are broken.')
+
+# Features supported by Git.
+option('curl', type: 'feature', value: 'enabled',
+  description: 'Build helpers used to access remotes with the HTTP transport.')
+option('expat', type: 'feature', value: 'enabled',
+  description: 'Build helpers used to push to remotes with the HTTP transport.')
+option('gettext', type: 'feature', value: 'auto',
+  description: 'Build translation files.')
+option('iconv', type: 'feature', value: 'auto',
+  description: 'Support reencoding strings with different encodings.')
+option('pcre2', type: 'feature', value: 'enabled',
+  description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
+option('perl', type: 'feature', value: 'auto',
+  description: 'Build tools written in Perl.')
+option('python', type: 'feature', value: 'auto',
+  description: 'Build tools written in Python.')
+option('regex', type: 'feature', value: 'auto',
+  description: 'Use the system-provided regex library instead of the bundled one.')
+
+# Backends.
+option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl', 'CommonCrypto', 'none'],
+  description: 'The HTTPS backend to use when connecting to remotes.')
+option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'common-crypto'], value: 'sha1dc',
+  description: 'The backend used for hashing objects with the SHA1 object format')
+option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
+  description: 'The backend used for hashing objects with the SHA256 object format')
+
+# Build tweaks.
+option('macos_use_homebrew_gettext', type: 'boolean', value: true,
+  description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
+
+# gitweb configuration.
+option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
+option('gitweb_config_system', type: 'string', value: '/etc/gitweb.conf')
+option('gitweb_config_common', type: 'string', value: '/etc/gitweb-common.conf')
+option('gitweb_home_link_str', type: 'string', value: 'projects')
+option('gitweb_sitename', type: 'string', value: '')
+option('gitweb_projectroot', type: 'string', value: '/pub/git')
+option('gitweb_project_maxdepth', type: 'string', value: '2007')
+option('gitweb_export_ok', type: 'string', value: '')
+option('gitweb_strict_export', type: 'string', value: '')
+option('gitweb_base_url', type: 'string', value: '')
+option('gitweb_list', type: 'string', value: '')
+option('gitweb_hometext', type: 'string', value: 'indextext.html')
+option('gitweb_css', type: 'string', value: 'static/gitweb.css')
+option('gitweb_logo', type: 'string', value: 'static/git-logo.png')
+option('gitweb_favicon', type: 'string', value: 'static/git-favicon.png')
+option('gitweb_js', type: 'string', value: 'static/gitweb.js')
+option('gitweb_site_html_head_string', type: 'string', value: '')
+option('gitweb_site_header', type: 'string', value: '')
+option('gitweb_site_footer', type: 'string', value: '')
+option('highlight_bin', type: 'string', value: 'highlight')
+
+# Documentation.
+option('docs', type: 'array', choices: ['man', 'html'], value: [],
+  description: 'Which documenattion formats to build and install.')
+option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
+  description: 'Default format used when executing git-help(1).')
+
+# Testing.
+option('tests', type: 'boolean', value: true,
+  description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
+option('test_output_directory', type: 'string',
+  description: 'Path to the directory used to store test outputs')
diff --git a/perl/FromCPAN/Mail/meson.build b/perl/FromCPAN/Mail/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..129cff161c585645c111af0386bafe136258e3db
--- /dev/null
+++ b/perl/FromCPAN/Mail/meson.build
@@ -0,0 +1,7 @@
+test_dependencies += custom_target(
+  input: 'Address.pm',
+  output: 'Address.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5/FromCPAN/Mail',
+)
diff --git a/perl/FromCPAN/meson.build b/perl/FromCPAN/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..4e7ea909df3593fb65facb4bf6a1c42e954d6f70
--- /dev/null
+++ b/perl/FromCPAN/meson.build
@@ -0,0 +1,9 @@
+test_dependencies += custom_target(
+  input: 'Error.pm',
+  output: 'Error.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5/FromCPAN',
+)
+
+subdir('Mail')
diff --git a/perl/Git/LoadCPAN/Mail/meson.build b/perl/Git/LoadCPAN/Mail/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..7da5b37adb278b4e13f41ea5ebc762bb4d78b64b
--- /dev/null
+++ b/perl/Git/LoadCPAN/Mail/meson.build
@@ -0,0 +1,7 @@
+test_dependencies += custom_target(
+  input: 'Address.pm',
+  output: 'Address.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN/Mail',
+)
diff --git a/perl/Git/LoadCPAN/meson.build b/perl/Git/LoadCPAN/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..9468c073aeb5ae1980f88b4c7f2c7fe69355ea37
--- /dev/null
+++ b/perl/Git/LoadCPAN/meson.build
@@ -0,0 +1,9 @@
+test_dependencies += custom_target(
+  input: 'Error.pm',
+  output: 'Error.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN',
+)
+
+subdir('Mail')
diff --git a/perl/Git/SVN/Memoize/meson.build b/perl/Git/SVN/Memoize/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..515ab3dd926618f6c46b030e1f283d637fdddedf
--- /dev/null
+++ b/perl/Git/SVN/Memoize/meson.build
@@ -0,0 +1,7 @@
+test_dependencies += custom_target(
+  input: 'YAML.pm',
+  output: 'YAML.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5/Git/SVN',
+)
diff --git a/perl/Git/SVN/meson.build b/perl/Git/SVN/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..8338531041d8e5cd4e8c2c8a0c3dcfc8b2d23cc9
--- /dev/null
+++ b/perl/Git/SVN/meson.build
@@ -0,0 +1,20 @@
+foreach source : [
+  'Editor.pm',
+  'Fetcher.pm',
+  'GlobSpec.pm',
+  'Log.pm',
+  'Migration.pm',
+  'Prompt.pm',
+  'Ra.pm',
+  'Utils.pm',
+]
+  test_dependencies += custom_target(
+    input: source,
+    output: source,
+    command: generate_perl_command,
+    install: true,
+    install_dir: get_option('datadir') / 'perl5/Git/SVN',
+  )
+endforeach
+
+subdir('Memoize')
diff --git a/perl/Git/meson.build b/perl/Git/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..259209d7302809b6c1d3249d9d21548515c31c77
--- /dev/null
+++ b/perl/Git/meson.build
@@ -0,0 +1,18 @@
+foreach source : [
+  'I18N.pm',
+  'IndexInfo.pm',
+  'LoadCPAN.pm',
+  'Packet.pm',
+  'SVN.pm',
+]
+  test_dependencies += custom_target(
+    input: source,
+    output: source,
+    command: generate_perl_command,
+    install: true,
+    install_dir: get_option('datadir') / 'perl5/Git',
+  )
+endforeach
+
+subdir('LoadCPAN')
+subdir('SVN')
diff --git a/perl/meson.build b/perl/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..c22d6f8a1a3266ded27c43c43c88620f9b4badcf
--- /dev/null
+++ b/perl/meson.build
@@ -0,0 +1,12 @@
+test_dependencies += custom_target(
+  input: 'Git.pm',
+  output: 'Git.pm',
+  command: generate_perl_command,
+  install: true,
+  install_dir: get_option('datadir') / 'perl5',
+)
+
+subdir('Git')
+if get_option('perl_cpan_fallback')
+  subdir('FromCPAN')
+endif
diff --git a/po/meson.build b/po/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..d7154b6395b2bf4a27110aad65aa1f51f979a1e9
--- /dev/null
+++ b/po/meson.build
@@ -0,0 +1,27 @@
+i18n = import('i18n')
+
+translations = i18n.gettext('git',
+  languages: [
+    'bg',
+    'ca',
+    'de',
+    'el',
+    'es',
+    'fr',
+    'id',
+    'is',
+    'it',
+    'ko',
+    'pl',
+    'pt_PT',
+    'ru',
+    'sv',
+    'tr',
+    'uk',
+    'vi',
+    'zh_CN',
+    'zh_TW',
+  ],
+  install: true,
+)
+test_dependencies += translations[0]
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..63ea916ef5f30255aef0c0b0b63f37b0e1d99fb2
--- /dev/null
+++ b/subprojects/.gitignore
@@ -0,0 +1 @@
+/*/
diff --git a/subprojects/curl.wrap b/subprojects/curl.wrap
new file mode 100644
index 0000000000000000000000000000000000000000..f7e384b85cf5ee98672e4409e1d30f8f6f0e5735
--- /dev/null
+++ b/subprojects/curl.wrap
@@ -0,0 +1,13 @@
+[wrap-file]
+directory = curl-8.10.1
+source_url = https://github.com/curl/curl/releases/download/curl-8_10_1/curl-8.10.1.tar.xz
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/curl_8.10.1-1/curl-8.10.1.tar.xz
+source_filename = curl-8.10.1.tar.xz
+source_hash = 73a4b0e99596a09fa5924a4fb7e4b995a85fda0d18a2c02ab9cf134bebce04ee
+patch_filename = curl_8.10.1-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/curl_8.10.1-1/get_patch
+patch_hash = 707c28f35fc9b0e8d68c0c2800712007612f922a31da9637ce706a2159f3ddd8
+wrapdb_version = 8.10.1-1
+
+[provide]
+dependency_names = libcurl
diff --git a/subprojects/expat.wrap b/subprojects/expat.wrap
new file mode 100644
index 0000000000000000000000000000000000000000..2e0427dcfd144c22d8c0bfd333e3cf31f14855a7
--- /dev/null
+++ b/subprojects/expat.wrap
@@ -0,0 +1,13 @@
+[wrap-file]
+directory = expat-2.6.3
+source_url = https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
+source_filename = expat-2.6.3.tar.bz2
+source_hash = 274db254a6979bde5aad404763a704956940e465843f2a9bd9ed7af22e2c0efc
+patch_filename = expat_2.6.3-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.6.3-1/get_patch
+patch_hash = cf017fbe105e31428b2768360bd9be39094df4e948a1e8d1c54b6f7c76460cb1
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.6.3-1/expat-2.6.3.tar.bz2
+wrapdb_version = 2.6.3-1
+
+[provide]
+expat = expat_dep
diff --git a/subprojects/openssl.wrap b/subprojects/openssl.wrap
new file mode 100644
index 0000000000000000000000000000000000000000..873d55106e9b83c487a88dfbb85eaf73429464d7
--- /dev/null
+++ b/subprojects/openssl.wrap
@@ -0,0 +1,15 @@
+[wrap-file]
+directory = openssl-3.0.8
+source_url = https://www.openssl.org/source/openssl-3.0.8.tar.gz
+source_filename = openssl-3.0.8.tar.gz
+source_hash = 6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e
+patch_filename = openssl_3.0.8-3_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/openssl_3.0.8-3/get_patch
+patch_hash = 300da189e106942347d61a4a4295aa2edbcf06184f8d13b4cee0bed9fb936963
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/openssl_3.0.8-3/openssl-3.0.8.tar.gz
+wrapdb_version = 3.0.8-3
+
+[provide]
+libcrypto = libcrypto_dep
+libssl = libssl_dep
+openssl = openssl_dep
diff --git a/subprojects/pcre2.wrap b/subprojects/pcre2.wrap
new file mode 100644
index 0000000000000000000000000000000000000000..7e184472543bde1572b9e780ae29318fe01e72bc
--- /dev/null
+++ b/subprojects/pcre2.wrap
@@ -0,0 +1,16 @@
+[wrap-file]
+directory = pcre2-10.44
+source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.bz2
+source_filename = pcre2-10.44.tar.bz2
+source_hash = d34f02e113cf7193a1ebf2770d3ac527088d485d4e047ed10e5d217c6ef5de96
+patch_filename = pcre2_10.44-2_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.44-2/get_patch
+patch_hash = 4336d422ee9043847e5e10dbbbd01940d4c9e5027f31ccdc33a7898a1ca94009
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.44-2/pcre2-10.44.tar.bz2
+wrapdb_version = 10.44-2
+
+[provide]
+libpcre2-8 = libpcre2_8
+libpcre2-16 = libpcre2_16
+libpcre2-32 = libpcre2_32
+libpcre2-posix = libpcre2_posix
diff --git a/subprojects/zlib.wrap b/subprojects/zlib.wrap
new file mode 100644
index 0000000000000000000000000000000000000000..aa14de17740728cecdb7431fb101e55e9b022273
--- /dev/null
+++ b/subprojects/zlib.wrap
@@ -0,0 +1,13 @@
+[wrap-file]
+directory = zlib-1.3.1
+source_url = http://zlib.net/fossils/zlib-1.3.1.tar.gz
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/zlib_1.3.1-1/zlib-1.3.1.tar.gz
+source_filename = zlib-1.3.1.tar.gz
+source_hash = 9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23
+patch_filename = zlib_1.3.1-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/zlib_1.3.1-1/get_patch
+patch_hash = e79b98eb24a75392009cec6f99ca5cdca9881ff20bfa174e8b8926d5c7a47095
+wrapdb_version = 1.3.1-1
+
+[provide]
+zlib = zlib_dep
diff --git a/t/helper/meson.build b/t/helper/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..5e83884246edc7841738de5085f3255aa1fa3fbe
--- /dev/null
+++ b/t/helper/meson.build
@@ -0,0 +1,91 @@
+test_tool_sources = [
+  '../unit-tests/test-lib.c',
+  'test-advise.c',
+  'test-bitmap.c',
+  'test-bloom.c',
+  'test-bundle-uri.c',
+  'test-cache-tree.c',
+  'test-chmtime.c',
+  'test-config.c',
+  'test-crontab.c',
+  'test-csprng.c',
+  'test-date.c',
+  'test-delete-gpgsig.c',
+  'test-delta.c',
+  'test-dir-iterator.c',
+  'test-drop-caches.c',
+  'test-dump-cache-tree.c',
+  'test-dump-fsmonitor.c',
+  'test-dump-split-index.c',
+  'test-dump-untracked-cache.c',
+  'test-env-helper.c',
+  'test-example-tap.c',
+  'test-find-pack.c',
+  'test-fsmonitor-client.c',
+  'test-genrandom.c',
+  'test-genzeros.c',
+  'test-getcwd.c',
+  'test-hash-speed.c',
+  'test-hash.c',
+  'test-hashmap.c',
+  'test-hexdump.c',
+  'test-json-writer.c',
+  'test-lazy-init-name-hash.c',
+  'test-match-trees.c',
+  'test-mergesort.c',
+  'test-mktemp.c',
+  'test-online-cpus.c',
+  'test-pack-mtimes.c',
+  'test-parse-options.c',
+  'test-parse-pathspec-file.c',
+  'test-partial-clone.c',
+  'test-path-utils.c',
+  'test-pcre2-config.c',
+  'test-pkt-line.c',
+  'test-proc-receive.c',
+  'test-progress.c',
+  'test-reach.c',
+  'test-read-cache.c',
+  'test-read-graph.c',
+  'test-read-midx.c',
+  'test-ref-store.c',
+  'test-reftable.c',
+  'test-regex.c',
+  'test-repository.c',
+  'test-revision-walking.c',
+  'test-rot13-filter.c',
+  'test-run-command.c',
+  'test-scrap-cache-tree.c',
+  'test-serve-v2.c',
+  'test-sha1.c',
+  'test-sha256.c',
+  'test-sigchain.c',
+  'test-simple-ipc.c',
+  'test-string-list.c',
+  'test-submodule-config.c',
+  'test-submodule-nested-repo-config.c',
+  'test-submodule.c',
+  'test-subprocess.c',
+  'test-tool.c',
+  'test-trace2.c',
+  'test-truncate.c',
+  'test-userdiff.c',
+  'test-wildmatch.c',
+  'test-windows-named-pipe.c',
+  'test-write-cache.c',
+  'test-xml-encode.c',
+]
+
+test_tool = executable('test-tool',
+  sources: test_tool_sources,
+  dependencies: [libgit, common_main],
+)
+bin_wrappers += test_tool
+test_dependencies += test_tool
+
+test_fake_ssh = executable('test-fake-ssh',
+  sources: 'test-fake-ssh.c',
+  dependencies: [libgit, common_main],
+)
+bin_wrappers += test_fake_ssh
+test_dependencies += test_fake_ssh
diff --git a/t/meson.build b/t/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..86076b77d2005529f58fb402e86bc95048071342
--- /dev/null
+++ b/t/meson.build
@@ -0,0 +1,1115 @@
+clar_test_suites = [
+  'unit-tests/ctype.c',
+  'unit-tests/strvec.c',
+]
+
+clar_sources = [
+  'unit-tests/clar/clar.c',
+  'unit-tests/unit-test.c',
+]
+
+clar_decls_h = custom_target(
+  input: clar_test_suites,
+  output: 'clar-decls.h',
+  command : [
+    shell,
+    meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh',
+    '@OUTPUT@',
+    '@INPUT@',
+  ],
+  env: script_environment,
+)
+clar_sources += clar_decls_h
+
+clar_sources += custom_target(
+  input: clar_decls_h,
+  output: 'clar.suite',
+  command : [
+    shell,
+    meson.current_source_dir() + '/unit-tests/generate-clar-suites.sh',
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
+clar_unit_tests = executable('unit-tests',
+  sources: clar_sources + clar_test_suites,
+  dependencies: [libgit, common_main],
+)
+test('unit-tests', clar_unit_tests)
+
+unit_test_programs = [
+  'unit-tests/t-example-decorate.c',
+  'unit-tests/t-hash.c',
+  'unit-tests/t-hashmap.c',
+  'unit-tests/t-mem-pool.c',
+  'unit-tests/t-oid-array.c',
+  'unit-tests/t-oidmap.c',
+  'unit-tests/t-oidtree.c',
+  'unit-tests/t-prio-queue.c',
+  'unit-tests/t-reftable-basics.c',
+  'unit-tests/t-reftable-block.c',
+  'unit-tests/t-reftable-merged.c',
+  'unit-tests/t-reftable-pq.c',
+  'unit-tests/t-reftable-reader.c',
+  'unit-tests/t-reftable-readwrite.c',
+  'unit-tests/t-reftable-record.c',
+  'unit-tests/t-reftable-stack.c',
+  'unit-tests/t-reftable-tree.c',
+  'unit-tests/t-strbuf.c',
+  'unit-tests/t-strcmp-offset.c',
+  'unit-tests/t-trailer.c',
+  'unit-tests/t-urlmatch-normalization.c',
+]
+
+foreach unit_test_program : unit_test_programs
+  unit_test_name = fs.stem(unit_test_program)
+  unit_test = executable(unit_test_name,
+    sources: [
+      'unit-tests/test-lib.c',
+      'unit-tests/lib-oid.c',
+      'unit-tests/lib-reftable.c',
+      unit_test_program,
+    ],
+    dependencies: [libgit, common_main],
+  )
+  test(unit_test_name, unit_test,
+    workdir: meson.current_source_dir(),
+    timeout: 0,
+  )
+endforeach
+
+subdir('helper')
+
+integration_tests = [
+  't0000-basic.sh',
+  't0001-init.sh',
+  't0002-gitfile.sh',
+  't0003-attributes.sh',
+  't0004-unwritable.sh',
+  't0005-signals.sh',
+  't0006-date.sh',
+  't0007-git-var.sh',
+  't0008-ignores.sh',
+  't0010-racy-git.sh',
+  't0012-help.sh',
+  't0013-sha1dc.sh',
+  't0014-alias.sh',
+  't0017-env-helper.sh',
+  't0018-advice.sh',
+  't0019-json-writer.sh',
+  't0020-crlf.sh',
+  't0021-conversion.sh',
+  't0022-crlf-rename.sh',
+  't0023-crlf-am.sh',
+  't0024-crlf-archive.sh',
+  't0025-crlf-renormalize.sh',
+  't0026-eol-config.sh',
+  't0027-auto-crlf.sh',
+  't0028-working-tree-encoding.sh',
+  't0029-core-unsetenvvars.sh',
+  't0030-stripspace.sh',
+  't0033-safe-directory.sh',
+  't0034-root-safe-directory.sh',
+  't0035-safe-bare-repository.sh',
+  't0040-parse-options.sh',
+  't0041-usage.sh',
+  't0050-filesystem.sh',
+  't0051-windows-named-pipe.sh',
+  't0052-simple-ipc.sh',
+  't0055-beyond-symlinks.sh',
+  't0056-git-C.sh',
+  't0060-path-utils.sh',
+  't0061-run-command.sh',
+  't0062-revision-walking.sh',
+  't0063-string-list.sh',
+  't0066-dir-iterator.sh',
+  't0067-parse_pathspec_file.sh',
+  't0068-for-each-repo.sh',
+  't0070-fundamental.sh',
+  't0071-sort.sh',
+  't0080-unit-test-output.sh',
+  't0081-find-pack.sh',
+  't0090-cache-tree.sh',
+  't0091-bugreport.sh',
+  't0092-diagnose.sh',
+  't0095-bloom.sh',
+  't0100-previous.sh',
+  't0101-at-syntax.sh',
+  't0200-gettext-basic.sh',
+  't0201-gettext-fallbacks.sh',
+  't0202-gettext-perl.sh',
+  't0203-gettext-setlocale-sanity.sh',
+  't0204-gettext-reencode-sanity.sh',
+  't0210-trace2-normal.sh',
+  't0211-trace2-perf.sh',
+  't0212-trace2-event.sh',
+  't0300-credentials.sh',
+  't0301-credential-cache.sh',
+  't0302-credential-store.sh',
+  't0303-credential-external.sh',
+  't0410-partial-clone.sh',
+  't0411-clone-from-partial.sh',
+  't0450-txt-doc-vs-help.sh',
+  't0500-progress-display.sh',
+  't0600-reffiles-backend.sh',
+  't0601-reffiles-pack-refs.sh',
+  't0602-reffiles-fsck.sh',
+  't0610-reftable-basics.sh',
+  't0611-reftable-httpd.sh',
+  't0612-reftable-jgit-compatibility.sh',
+  't0613-reftable-write-options.sh',
+  't1000-read-tree-m-3way.sh',
+  't1001-read-tree-m-2way.sh',
+  't1002-read-tree-m-u-2way.sh',
+  't1003-read-tree-prefix.sh',
+  't1004-read-tree-m-u-wf.sh',
+  't1005-read-tree-reset.sh',
+  't1006-cat-file.sh',
+  't1007-hash-object.sh',
+  't1008-read-tree-overlay.sh',
+  't1009-read-tree-new-index.sh',
+  't1010-mktree.sh',
+  't1011-read-tree-sparse-checkout.sh',
+  't1012-read-tree-df.sh',
+  't1013-read-tree-submodule.sh',
+  't1014-read-tree-confusing.sh',
+  't1015-read-index-unmerged.sh',
+  't1016-compatObjectFormat.sh',
+  't1020-subdirectory.sh',
+  't1021-rerere-in-workdir.sh',
+  't1022-read-tree-partial-clone.sh',
+  't1050-large.sh',
+  't1051-large-conversion.sh',
+  't1060-object-corruption.sh',
+  't1090-sparse-checkout-scope.sh',
+  't1091-sparse-checkout-builtin.sh',
+  't1092-sparse-checkout-compatibility.sh',
+  't1100-commit-tree-options.sh',
+  't1300-config.sh',
+  't1301-shared-repo.sh',
+  't1302-repo-version.sh',
+  't1303-wacky-config.sh',
+  't1304-default-acl.sh',
+  't1305-config-include.sh',
+  't1306-xdg-files.sh',
+  't1307-config-blob.sh',
+  't1308-config-set.sh',
+  't1309-early-config.sh',
+  't1310-config-default.sh',
+  't1350-config-hooks-path.sh',
+  't1400-update-ref.sh',
+  't1401-symbolic-ref.sh',
+  't1402-check-ref-format.sh',
+  't1403-show-ref.sh',
+  't1404-update-ref-errors.sh',
+  't1405-main-ref-store.sh',
+  't1406-submodule-ref-store.sh',
+  't1407-worktree-ref-store.sh',
+  't1408-packed-refs.sh',
+  't1409-avoid-packing-refs.sh',
+  't1410-reflog.sh',
+  't1411-reflog-show.sh',
+  't1412-reflog-loop.sh',
+  't1413-reflog-detach.sh',
+  't1414-reflog-walk.sh',
+  't1415-worktree-refs.sh',
+  't1416-ref-transaction-hooks.sh',
+  't1417-reflog-updateref.sh',
+  't1418-reflog-exists.sh',
+  't1419-exclude-refs.sh',
+  't1420-lost-found.sh',
+  't1430-bad-ref-name.sh',
+  't1450-fsck.sh',
+  't1451-fsck-buffer.sh',
+  't1460-refs-migrate.sh',
+  't1500-rev-parse.sh',
+  't1501-work-tree.sh',
+  't1502-rev-parse-parseopt.sh',
+  't1503-rev-parse-verify.sh',
+  't1504-ceiling-dirs.sh',
+  't1505-rev-parse-last.sh',
+  't1506-rev-parse-diagnosis.sh',
+  't1507-rev-parse-upstream.sh',
+  't1508-at-combinations.sh',
+  't1509-root-work-tree.sh',
+  't1510-repo-setup.sh',
+  't1511-rev-parse-caret.sh',
+  't1512-rev-parse-disambiguation.sh',
+  't1513-rev-parse-prefix.sh',
+  't1514-rev-parse-push.sh',
+  't1515-rev-parse-outside-repo.sh',
+  't1517-outside-repo.sh',
+  't1600-index.sh',
+  't1601-index-bogus.sh',
+  't1700-split-index.sh',
+  't1701-racy-split-index.sh',
+  't1800-hook.sh',
+  't2000-conflict-when-checking-files-out.sh',
+  't2002-checkout-cache-u.sh',
+  't2003-checkout-cache-mkdir.sh',
+  't2004-checkout-cache-temp.sh',
+  't2005-checkout-index-symlinks.sh',
+  't2006-checkout-index-basic.sh',
+  't2007-checkout-symlink.sh',
+  't2008-checkout-subdir.sh',
+  't2009-checkout-statinfo.sh',
+  't2010-checkout-ambiguous.sh',
+  't2011-checkout-invalid-head.sh',
+  't2012-checkout-last.sh',
+  't2013-checkout-submodule.sh',
+  't2014-checkout-switch.sh',
+  't2015-checkout-unborn.sh',
+  't2016-checkout-patch.sh',
+  't2017-checkout-orphan.sh',
+  't2018-checkout-branch.sh',
+  't2019-checkout-ambiguous-ref.sh',
+  't2020-checkout-detach.sh',
+  't2021-checkout-overwrite.sh',
+  't2022-checkout-paths.sh',
+  't2023-checkout-m.sh',
+  't2024-checkout-dwim.sh',
+  't2025-checkout-no-overlay.sh',
+  't2026-checkout-pathspec-file.sh',
+  't2027-checkout-track.sh',
+  't2030-unresolve-info.sh',
+  't2050-git-dir-relative.sh',
+  't2060-switch.sh',
+  't2070-restore.sh',
+  't2071-restore-patch.sh',
+  't2072-restore-pathspec-file.sh',
+  't2080-parallel-checkout-basics.sh',
+  't2081-parallel-checkout-collisions.sh',
+  't2082-parallel-checkout-attributes.sh',
+  't2100-update-cache-badpath.sh',
+  't2101-update-index-reupdate.sh',
+  't2102-update-index-symlinks.sh',
+  't2103-update-index-ignore-missing.sh',
+  't2104-update-index-skip-worktree.sh',
+  't2105-update-index-gitfile.sh',
+  't2106-update-index-assume-unchanged.sh',
+  't2107-update-index-basic.sh',
+  't2108-update-index-refresh-racy.sh',
+  't2200-add-update.sh',
+  't2201-add-update-typechange.sh',
+  't2202-add-addremove.sh',
+  't2203-add-intent.sh',
+  't2204-add-ignored.sh',
+  't2205-add-worktree-config.sh',
+  't2300-cd-to-toplevel.sh',
+  't2400-worktree-add.sh',
+  't2401-worktree-prune.sh',
+  't2402-worktree-list.sh',
+  't2403-worktree-move.sh',
+  't2404-worktree-config.sh',
+  't2405-worktree-submodule.sh',
+  't2406-worktree-repair.sh',
+  't2407-worktree-heads.sh',
+  't2408-worktree-relative.sh',
+  't2500-untracked-overwriting.sh',
+  't2501-cwd-empty.sh',
+  't3000-ls-files-others.sh',
+  't3001-ls-files-others-exclude.sh',
+  't3002-ls-files-dashpath.sh',
+  't3003-ls-files-exclude.sh',
+  't3004-ls-files-basic.sh',
+  't3005-ls-files-relative.sh',
+  't3006-ls-files-long.sh',
+  't3007-ls-files-recurse-submodules.sh',
+  't3008-ls-files-lazy-init-name-hash.sh',
+  't3009-ls-files-others-nonsubmodule.sh',
+  't3010-ls-files-killed-modified.sh',
+  't3011-common-prefixes-and-directory-traversal.sh',
+  't3012-ls-files-dedup.sh',
+  't3013-ls-files-format.sh',
+  't3020-ls-files-error-unmatch.sh',
+  't3040-subprojects-basic.sh',
+  't3050-subprojects-fetch.sh',
+  't3060-ls-files-with-tree.sh',
+  't3070-wildmatch.sh',
+  't3100-ls-tree-restrict.sh',
+  't3101-ls-tree-dirname.sh',
+  't3102-ls-tree-wildcards.sh',
+  't3103-ls-tree-misc.sh',
+  't3104-ls-tree-format.sh',
+  't3105-ls-tree-output.sh',
+  't3200-branch.sh',
+  't3201-branch-contains.sh',
+  't3202-show-branch.sh',
+  't3203-branch-output.sh',
+  't3204-branch-name-interpretation.sh',
+  't3205-branch-color.sh',
+  't3206-range-diff.sh',
+  't3207-branch-submodule.sh',
+  't3211-peel-ref.sh',
+  't3300-funny-names.sh',
+  't3301-notes.sh',
+  't3302-notes-index-expensive.sh',
+  't3303-notes-subtrees.sh',
+  't3304-notes-mixed.sh',
+  't3305-notes-fanout.sh',
+  't3306-notes-prune.sh',
+  't3307-notes-man.sh',
+  't3308-notes-merge.sh',
+  't3309-notes-merge-auto-resolve.sh',
+  't3310-notes-merge-manual-resolve.sh',
+  't3311-notes-merge-fanout.sh',
+  't3320-notes-merge-worktrees.sh',
+  't3321-notes-stripspace.sh',
+  't3400-rebase.sh',
+  't3401-rebase-and-am-rename.sh',
+  't3402-rebase-merge.sh',
+  't3403-rebase-skip.sh',
+  't3404-rebase-interactive.sh',
+  't3405-rebase-malformed.sh',
+  't3406-rebase-message.sh',
+  't3407-rebase-abort.sh',
+  't3408-rebase-multi-line.sh',
+  't3409-rebase-environ.sh',
+  't3412-rebase-root.sh',
+  't3413-rebase-hook.sh',
+  't3415-rebase-autosquash.sh',
+  't3416-rebase-onto-threedots.sh',
+  't3417-rebase-whitespace-fix.sh',
+  't3418-rebase-continue.sh',
+  't3419-rebase-patch-id.sh',
+  't3420-rebase-autostash.sh',
+  't3421-rebase-topology-linear.sh',
+  't3422-rebase-incompatible-options.sh',
+  't3423-rebase-reword.sh',
+  't3424-rebase-empty.sh',
+  't3425-rebase-topology-merges.sh',
+  't3426-rebase-submodule.sh',
+  't3427-rebase-subtree.sh',
+  't3428-rebase-signoff.sh',
+  't3429-rebase-edit-todo.sh',
+  't3430-rebase-merges.sh',
+  't3431-rebase-fork-point.sh',
+  't3432-rebase-fast-forward.sh',
+  't3433-rebase-across-mode-change.sh',
+  't3434-rebase-i18n.sh',
+  't3435-rebase-gpg-sign.sh',
+  't3436-rebase-more-options.sh',
+  't3437-rebase-fixup-options.sh',
+  't3438-rebase-broken-files.sh',
+  't3500-cherry.sh',
+  't3501-revert-cherry-pick.sh',
+  't3502-cherry-pick-merge.sh',
+  't3503-cherry-pick-root.sh',
+  't3504-cherry-pick-rerere.sh',
+  't3505-cherry-pick-empty.sh',
+  't3506-cherry-pick-ff.sh',
+  't3507-cherry-pick-conflict.sh',
+  't3508-cherry-pick-many-commits.sh',
+  't3509-cherry-pick-merge-df.sh',
+  't3510-cherry-pick-sequence.sh',
+  't3511-cherry-pick-x.sh',
+  't3512-cherry-pick-submodule.sh',
+  't3513-revert-submodule.sh',
+  't3514-cherry-pick-revert-gpg.sh',
+  't3600-rm.sh',
+  't3601-rm-pathspec-file.sh',
+  't3602-rm-sparse-checkout.sh',
+  't3650-replay-basics.sh',
+  't3700-add.sh',
+  't3701-add-interactive.sh',
+  't3702-add-edit.sh',
+  't3703-add-magic-pathspec.sh',
+  't3704-add-pathspec-file.sh',
+  't3705-add-sparse-checkout.sh',
+  't3800-mktag.sh',
+  't3900-i18n-commit.sh',
+  't3901-i18n-patch.sh',
+  't3902-quoted.sh',
+  't3903-stash.sh',
+  't3904-stash-patch.sh',
+  't3905-stash-include-untracked.sh',
+  't3906-stash-submodule.sh',
+  't3907-stash-show-config.sh',
+  't3908-stash-in-worktree.sh',
+  't3909-stash-pathspec-file.sh',
+  't3910-mac-os-precompose.sh',
+  't3920-crlf-messages.sh',
+  't4000-diff-format.sh',
+  't4001-diff-rename.sh',
+  't4002-diff-basic.sh',
+  't4003-diff-rename-1.sh',
+  't4004-diff-rename-symlink.sh',
+  't4005-diff-rename-2.sh',
+  't4006-diff-mode.sh',
+  't4007-rename-3.sh',
+  't4008-diff-break-rewrite.sh',
+  't4009-diff-rename-4.sh',
+  't4010-diff-pathspec.sh',
+  't4011-diff-symlink.sh',
+  't4012-diff-binary.sh',
+  't4013-diff-various.sh',
+  't4014-format-patch.sh',
+  't4015-diff-whitespace.sh',
+  't4016-diff-quote.sh',
+  't4017-diff-retval.sh',
+  't4018-diff-funcname.sh',
+  't4019-diff-wserror.sh',
+  't4020-diff-external.sh',
+  't4021-format-patch-numbered.sh',
+  't4022-diff-rewrite.sh',
+  't4023-diff-rename-typechange.sh',
+  't4024-diff-optimize-common.sh',
+  't4025-hunk-header.sh',
+  't4026-color.sh',
+  't4027-diff-submodule.sh',
+  't4028-format-patch-mime-headers.sh',
+  't4029-diff-trailing-space.sh',
+  't4030-diff-textconv.sh',
+  't4031-diff-rewrite-binary.sh',
+  't4032-diff-inter-hunk-context.sh',
+  't4033-diff-patience.sh',
+  't4034-diff-words.sh',
+  't4035-diff-quiet.sh',
+  't4036-format-patch-signer-mime.sh',
+  't4037-diff-r-t-dirs.sh',
+  't4038-diff-combined.sh',
+  't4039-diff-assume-unchanged.sh',
+  't4040-whitespace-status.sh',
+  't4041-diff-submodule-option.sh',
+  't4042-diff-textconv-caching.sh',
+  't4043-diff-rename-binary.sh',
+  't4044-diff-index-unique-abbrev.sh',
+  't4045-diff-relative.sh',
+  't4046-diff-unmerged.sh',
+  't4047-diff-dirstat.sh',
+  't4048-diff-combined-binary.sh',
+  't4049-diff-stat-count.sh',
+  't4050-diff-histogram.sh',
+  't4051-diff-function-context.sh',
+  't4052-stat-output.sh',
+  't4053-diff-no-index.sh',
+  't4054-diff-bogus-tree.sh',
+  't4055-diff-context.sh',
+  't4056-diff-order.sh',
+  't4057-diff-combined-paths.sh',
+  't4058-diff-duplicates.sh',
+  't4059-diff-submodule-not-initialized.sh',
+  't4060-diff-submodule-option-diff-format.sh',
+  't4061-diff-indent.sh',
+  't4062-diff-pickaxe.sh',
+  't4063-diff-blobs.sh',
+  't4064-diff-oidfind.sh',
+  't4065-diff-anchored.sh',
+  't4066-diff-emit-delay.sh',
+  't4067-diff-partial-clone.sh',
+  't4068-diff-symmetric-merge-base.sh',
+  't4069-remerge-diff.sh',
+  't4100-apply-stat.sh',
+  't4101-apply-nonl.sh',
+  't4102-apply-rename.sh',
+  't4103-apply-binary.sh',
+  't4104-apply-boundary.sh',
+  't4105-apply-fuzz.sh',
+  't4106-apply-stdin.sh',
+  't4107-apply-ignore-whitespace.sh',
+  't4108-apply-threeway.sh',
+  't4109-apply-multifrag.sh',
+  't4110-apply-scan.sh',
+  't4111-apply-subdir.sh',
+  't4112-apply-renames.sh',
+  't4113-apply-ending.sh',
+  't4114-apply-typechange.sh',
+  't4115-apply-symlink.sh',
+  't4116-apply-reverse.sh',
+  't4117-apply-reject.sh',
+  't4118-apply-empty-context.sh',
+  't4119-apply-config.sh',
+  't4120-apply-popt.sh',
+  't4121-apply-diffs.sh',
+  't4122-apply-symlink-inside.sh',
+  't4123-apply-shrink.sh',
+  't4124-apply-ws-rule.sh',
+  't4125-apply-ws-fuzz.sh',
+  't4126-apply-empty.sh',
+  't4127-apply-same-fn.sh',
+  't4128-apply-root.sh',
+  't4129-apply-samemode.sh',
+  't4130-apply-criss-cross-rename.sh',
+  't4131-apply-fake-ancestor.sh',
+  't4132-apply-removal.sh',
+  't4133-apply-filenames.sh',
+  't4134-apply-submodule.sh',
+  't4135-apply-weird-filenames.sh',
+  't4136-apply-check.sh',
+  't4137-apply-submodule.sh',
+  't4138-apply-ws-expansion.sh',
+  't4139-apply-escape.sh',
+  't4140-apply-ita.sh',
+  't4141-apply-too-large.sh',
+  't4150-am.sh',
+  't4151-am-abort.sh',
+  't4152-am-subjects.sh',
+  't4153-am-resume-override-opts.sh',
+  't4200-rerere.sh',
+  't4201-shortlog.sh',
+  't4202-log.sh',
+  't4203-mailmap.sh',
+  't4204-patch-id.sh',
+  't4205-log-pretty-formats.sh',
+  't4206-log-follow-harder-copies.sh',
+  't4207-log-decoration-colors.sh',
+  't4208-log-magic-pathspec.sh',
+  't4209-log-pickaxe.sh',
+  't4210-log-i18n.sh',
+  't4211-line-log.sh',
+  't4212-log-corrupt.sh',
+  't4213-log-tabexpand.sh',
+  't4214-log-graph-octopus.sh',
+  't4215-log-skewed-merges.sh',
+  't4216-log-bloom.sh',
+  't4217-log-limit.sh',
+  't4252-am-options.sh',
+  't4253-am-keep-cr-dos.sh',
+  't4254-am-corrupt.sh',
+  't4255-am-submodule.sh',
+  't4256-am-format-flowed.sh',
+  't4257-am-interactive.sh',
+  't4258-am-quoted-cr.sh',
+  't4300-merge-tree.sh',
+  't4301-merge-tree-write-tree.sh',
+  't5000-tar-tree.sh',
+  't5001-archive-attr.sh',
+  't5002-archive-attr-pattern.sh',
+  't5003-archive-zip.sh',
+  't5004-archive-corner-cases.sh',
+  't5100-mailinfo.sh',
+  't5150-request-pull.sh',
+  't5200-update-server-info.sh',
+  't5300-pack-object.sh',
+  't5301-sliding-window.sh',
+  't5302-pack-index.sh',
+  't5303-pack-corruption-resilience.sh',
+  't5304-prune.sh',
+  't5305-include-tag.sh',
+  't5306-pack-nobase.sh',
+  't5307-pack-missing-commit.sh',
+  't5308-pack-detect-duplicates.sh',
+  't5309-pack-delta-cycles.sh',
+  't5310-pack-bitmaps.sh',
+  't5311-pack-bitmaps-shallow.sh',
+  't5312-prune-corruption.sh',
+  't5313-pack-bounds-checks.sh',
+  't5314-pack-cycle-detection.sh',
+  't5315-pack-objects-compression.sh',
+  't5316-pack-delta-depth.sh',
+  't5317-pack-objects-filter-objects.sh',
+  't5318-commit-graph.sh',
+  't5319-multi-pack-index.sh',
+  't5320-delta-islands.sh',
+  't5321-pack-large-objects.sh',
+  't5322-pack-objects-sparse.sh',
+  't5323-pack-redundant.sh',
+  't5324-split-commit-graph.sh',
+  't5325-reverse-index.sh',
+  't5326-multi-pack-bitmaps.sh',
+  't5327-multi-pack-bitmaps-rev.sh',
+  't5328-commit-graph-64bit-time.sh',
+  't5329-pack-objects-cruft.sh',
+  't5330-no-lazy-fetch-with-commit-graph.sh',
+  't5331-pack-objects-stdin.sh',
+  't5332-multi-pack-reuse.sh',
+  't5333-pseudo-merge-bitmaps.sh',
+  't5334-incremental-multi-pack-index.sh',
+  't5351-unpack-large-objects.sh',
+  't5400-send-pack.sh',
+  't5401-update-hooks.sh',
+  't5402-post-merge-hook.sh',
+  't5403-post-checkout-hook.sh',
+  't5404-tracking-branches.sh',
+  't5405-send-pack-rewind.sh',
+  't5406-remote-rejects.sh',
+  't5407-post-rewrite-hook.sh',
+  't5408-send-pack-stdin.sh',
+  't5409-colorize-remote-messages.sh',
+  't5410-receive-pack-alternates.sh',
+  't5411-proc-receive-hook.sh',
+  't5500-fetch-pack.sh',
+  't5501-fetch-push-alternates.sh',
+  't5502-quickfetch.sh',
+  't5503-tagfollow.sh',
+  't5504-fetch-receive-strict.sh',
+  't5505-remote.sh',
+  't5506-remote-groups.sh',
+  't5507-remote-environment.sh',
+  't5509-fetch-push-namespaces.sh',
+  't5510-fetch.sh',
+  't5511-refspec.sh',
+  't5512-ls-remote.sh',
+  't5513-fetch-track.sh',
+  't5514-fetch-multiple.sh',
+  't5515-fetch-merge-logic.sh',
+  't5516-fetch-push.sh',
+  't5517-push-mirror.sh',
+  't5518-fetch-exit-status.sh',
+  't5519-push-alternates.sh',
+  't5520-pull.sh',
+  't5521-pull-options.sh',
+  't5522-pull-symlink.sh',
+  't5523-push-upstream.sh',
+  't5524-pull-msg.sh',
+  't5525-fetch-tagopt.sh',
+  't5526-fetch-submodules.sh',
+  't5527-fetch-odd-refs.sh',
+  't5528-push-default.sh',
+  't5529-push-errors.sh',
+  't5530-upload-pack-error.sh',
+  't5531-deep-submodule-push.sh',
+  't5532-fetch-proxy.sh',
+  't5533-push-cas.sh',
+  't5534-push-signed.sh',
+  't5535-fetch-push-symref.sh',
+  't5536-fetch-conflicts.sh',
+  't5537-fetch-shallow.sh',
+  't5538-push-shallow.sh',
+  't5539-fetch-http-shallow.sh',
+  't5540-http-push-webdav.sh',
+  't5541-http-push-smart.sh',
+  't5542-push-http-shallow.sh',
+  't5543-atomic-push.sh',
+  't5544-pack-objects-hook.sh',
+  't5545-push-options.sh',
+  't5546-receive-limits.sh',
+  't5547-push-quarantine.sh',
+  't5548-push-porcelain.sh',
+  't5549-fetch-push-http.sh',
+  't5550-http-fetch-dumb.sh',
+  't5551-http-fetch-smart.sh',
+  't5552-skipping-fetch-negotiator.sh',
+  't5553-set-upstream.sh',
+  't5554-noop-fetch-negotiator.sh',
+  't5555-http-smart-common.sh',
+  't5557-http-get.sh',
+  't5558-clone-bundle-uri.sh',
+  't5559-http-fetch-smart-http2.sh',
+  't5560-http-backend-noserver.sh',
+  't5561-http-backend.sh',
+  't5562-http-backend-content-length.sh',
+  't5563-simple-http-auth.sh',
+  't5564-http-proxy.sh',
+  't5570-git-daemon.sh',
+  't5571-pre-push-hook.sh',
+  't5572-pull-submodule.sh',
+  't5573-pull-verify-signatures.sh',
+  't5574-fetch-output.sh',
+  't5580-unc-paths.sh',
+  't5581-http-curl-verbose.sh',
+  't5582-fetch-negative-refspec.sh',
+  't5583-push-branches.sh',
+  't5600-clone-fail-cleanup.sh',
+  't5601-clone.sh',
+  't5602-clone-remote-exec.sh',
+  't5603-clone-dirname.sh',
+  't5604-clone-reference.sh',
+  't5605-clone-local.sh',
+  't5606-clone-options.sh',
+  't5607-clone-bundle.sh',
+  't5608-clone-2gb.sh',
+  't5609-clone-branch.sh',
+  't5610-clone-detached.sh',
+  't5611-clone-config.sh',
+  't5612-clone-refspec.sh',
+  't5613-info-alternate.sh',
+  't5614-clone-submodules-shallow.sh',
+  't5615-alternate-env.sh',
+  't5616-partial-clone.sh',
+  't5617-clone-submodules-remote.sh',
+  't5618-alternate-refs.sh',
+  't5619-clone-local-ambiguous-transport.sh',
+  't5700-protocol-v1.sh',
+  't5701-git-serve.sh',
+  't5702-protocol-v2.sh',
+  't5703-upload-pack-ref-in-want.sh',
+  't5704-protocol-violations.sh',
+  't5705-session-id-in-capabilities.sh',
+  't5730-protocol-v2-bundle-uri-file.sh',
+  't5731-protocol-v2-bundle-uri-git.sh',
+  't5732-protocol-v2-bundle-uri-http.sh',
+  't5750-bundle-uri-parse.sh',
+  't5801-remote-helpers.sh',
+  't5802-connect-helper.sh',
+  't5810-proto-disable-local.sh',
+  't5811-proto-disable-git.sh',
+  't5812-proto-disable-http.sh',
+  't5813-proto-disable-ssh.sh',
+  't5814-proto-disable-ext.sh',
+  't5815-submodule-protos.sh',
+  't5900-repo-selection.sh',
+  't6000-rev-list-misc.sh',
+  't6001-rev-list-graft.sh',
+  't6002-rev-list-bisect.sh',
+  't6003-rev-list-topo-order.sh',
+  't6004-rev-list-path-optim.sh',
+  't6005-rev-list-count.sh',
+  't6006-rev-list-format.sh',
+  't6007-rev-list-cherry-pick-file.sh',
+  't6008-rev-list-submodule.sh',
+  't6009-rev-list-parent.sh',
+  't6010-merge-base.sh',
+  't6011-rev-list-with-bad-commit.sh',
+  't6012-rev-list-simplify.sh',
+  't6013-rev-list-reverse-parents.sh',
+  't6014-rev-list-all.sh',
+  't6016-rev-list-graph-simplify-history.sh',
+  't6017-rev-list-stdin.sh',
+  't6018-rev-list-glob.sh',
+  't6019-rev-list-ancestry-path.sh',
+  't6020-bundle-misc.sh',
+  't6021-rev-list-exclude-hidden.sh',
+  't6022-rev-list-missing.sh',
+  't6030-bisect-porcelain.sh',
+  't6040-tracking-info.sh',
+  't6041-bisect-submodule.sh',
+  't6050-replace.sh',
+  't6060-merge-index.sh',
+  't6100-rev-list-in-order.sh',
+  't6101-rev-parse-parents.sh',
+  't6102-rev-list-unexpected-objects.sh',
+  't6110-rev-list-sparse.sh',
+  't6111-rev-list-treesame.sh',
+  't6112-rev-list-filters-objects.sh',
+  't6113-rev-list-bitmap-filters.sh',
+  't6114-keep-packs.sh',
+  't6115-rev-list-du.sh',
+  't6120-describe.sh',
+  't6130-pathspec-noglob.sh',
+  't6131-pathspec-icase.sh',
+  't6132-pathspec-exclude.sh',
+  't6133-pathspec-rev-dwim.sh',
+  't6134-pathspec-in-submodule.sh',
+  't6135-pathspec-with-attrs.sh',
+  't6136-pathspec-in-bare.sh',
+  't6200-fmt-merge-msg.sh',
+  't6300-for-each-ref.sh',
+  't6301-for-each-ref-errors.sh',
+  't6302-for-each-ref-filter.sh',
+  't6400-merge-df.sh',
+  't6401-merge-criss-cross.sh',
+  't6402-merge-rename.sh',
+  't6403-merge-file.sh',
+  't6404-recursive-merge.sh',
+  't6405-merge-symlinks.sh',
+  't6406-merge-attr.sh',
+  't6407-merge-binary.sh',
+  't6408-merge-up-to-date.sh',
+  't6409-merge-subtree.sh',
+  't6411-merge-filemode.sh',
+  't6412-merge-large-rename.sh',
+  't6413-merge-crlf.sh',
+  't6414-merge-rename-nocruft.sh',
+  't6415-merge-dir-to-symlink.sh',
+  't6416-recursive-corner-cases.sh',
+  't6417-merge-ours-theirs.sh',
+  't6418-merge-text-auto.sh',
+  't6419-merge-ignorecase.sh',
+  't6421-merge-partial-clone.sh',
+  't6422-merge-rename-corner-cases.sh',
+  't6423-merge-rename-directories.sh',
+  't6424-merge-unrelated-index-changes.sh',
+  't6425-merge-rename-delete.sh',
+  't6426-merge-skip-unneeded-updates.sh',
+  't6427-diff3-conflict-markers.sh',
+  't6428-merge-conflicts-sparse.sh',
+  't6429-merge-sequence-rename-caching.sh',
+  't6430-merge-recursive.sh',
+  't6431-merge-criscross.sh',
+  't6432-merge-recursive-space-options.sh',
+  't6433-merge-toplevel.sh',
+  't6434-merge-recursive-rename-options.sh',
+  't6435-merge-sparse.sh',
+  't6436-merge-overwrite.sh',
+  't6437-submodule-merge.sh',
+  't6438-submodule-directory-file-conflicts.sh',
+  't6439-merge-co-error-msgs.sh',
+  't6500-gc.sh',
+  't6501-freshen-objects.sh',
+  't6600-test-reach.sh',
+  't6700-tree-depth.sh',
+  't7001-mv.sh',
+  't7002-mv-sparse-checkout.sh',
+  't7003-filter-branch.sh',
+  't7004-tag.sh',
+  't7005-editor.sh',
+  't7006-pager.sh',
+  't7007-show.sh',
+  't7008-filter-branch-null-sha1.sh',
+  't7010-setup.sh',
+  't7011-skip-worktree-reading.sh',
+  't7012-skip-worktree-writing.sh',
+  't7030-verify-tag.sh',
+  't7031-verify-tag-signed-ssh.sh',
+  't7060-wtstatus.sh',
+  't7061-wtstatus-ignore.sh',
+  't7062-wtstatus-ignorecase.sh',
+  't7063-status-untracked-cache.sh',
+  't7064-wtstatus-pv2.sh',
+  't7101-reset-empty-subdirs.sh',
+  't7102-reset.sh',
+  't7103-reset-bare.sh',
+  't7104-reset-hard.sh',
+  't7105-reset-patch.sh',
+  't7106-reset-unborn-branch.sh',
+  't7107-reset-pathspec-file.sh',
+  't7110-reset-merge.sh',
+  't7111-reset-table.sh',
+  't7112-reset-submodule.sh',
+  't7113-post-index-change-hook.sh',
+  't7201-co.sh',
+  't7300-clean.sh',
+  't7301-clean-interactive.sh',
+  't7400-submodule-basic.sh',
+  't7401-submodule-summary.sh',
+  't7402-submodule-rebase.sh',
+  't7403-submodule-sync.sh',
+  't7406-submodule-update.sh',
+  't7407-submodule-foreach.sh',
+  't7408-submodule-reference.sh',
+  't7409-submodule-detached-work-tree.sh',
+  't7411-submodule-config.sh',
+  't7412-submodule-absorbgitdirs.sh',
+  't7413-submodule-is-active.sh',
+  't7414-submodule-mistakes.sh',
+  't7416-submodule-dash-url.sh',
+  't7417-submodule-path-url.sh',
+  't7418-submodule-sparse-gitmodules.sh',
+  't7419-submodule-set-branch.sh',
+  't7420-submodule-set-url.sh',
+  't7421-submodule-summary-add.sh',
+  't7422-submodule-output.sh',
+  't7423-submodule-symlinks.sh',
+  't7424-submodule-mixed-ref-formats.sh',
+  't7450-bad-git-dotfiles.sh',
+  't7500-commit-template-squash-signoff.sh',
+  't7501-commit-basic-functionality.sh',
+  't7502-commit-porcelain.sh',
+  't7503-pre-commit-and-pre-merge-commit-hooks.sh',
+  't7504-commit-msg-hook.sh',
+  't7505-prepare-commit-msg-hook.sh',
+  't7506-status-submodule.sh',
+  't7507-commit-verbose.sh',
+  't7508-status.sh',
+  't7509-commit-authorship.sh',
+  't7510-signed-commit.sh',
+  't7511-status-index.sh',
+  't7512-status-help.sh',
+  't7513-interpret-trailers.sh',
+  't7514-commit-patch.sh',
+  't7515-status-symlinks.sh',
+  't7516-commit-races.sh',
+  't7517-per-repo-email.sh',
+  't7518-ident-corner-cases.sh',
+  't7519-status-fsmonitor.sh',
+  't7520-ignored-hook-warning.sh',
+  't7521-ignored-mode.sh',
+  't7524-commit-summary.sh',
+  't7525-status-rename.sh',
+  't7526-commit-pathspec-file.sh',
+  't7527-builtin-fsmonitor.sh',
+  't7528-signed-commit-ssh.sh',
+  't7600-merge.sh',
+  't7601-merge-pull-config.sh',
+  't7602-merge-octopus-many.sh',
+  't7603-merge-reduce-heads.sh',
+  't7604-merge-custom-message.sh',
+  't7605-merge-resolve.sh',
+  't7606-merge-custom.sh',
+  't7607-merge-state.sh',
+  't7608-merge-messages.sh',
+  't7609-mergetool--lib.sh',
+  't7610-mergetool.sh',
+  't7611-merge-abort.sh',
+  't7612-merge-verify-signatures.sh',
+  't7614-merge-signoff.sh',
+  't7615-diff-algo-with-mergy-operations.sh',
+  't7700-repack.sh',
+  't7701-repack-unpack-unreachable.sh',
+  't7702-repack-cyclic-alternate.sh',
+  't7703-repack-geometric.sh',
+  't7704-repack-cruft.sh',
+  't7800-difftool.sh',
+  't7810-grep.sh',
+  't7811-grep-open.sh',
+  't7812-grep-icase-non-ascii.sh',
+  't7813-grep-icase-iso.sh',
+  't7814-grep-recurse-submodules.sh',
+  't7815-grep-binary.sh',
+  't7816-grep-binary-pattern.sh',
+  't7817-grep-sparse-checkout.sh',
+  't7900-maintenance.sh',
+  't8001-annotate.sh',
+  't8002-blame.sh',
+  't8003-blame-corner-cases.sh',
+  't8004-blame-with-conflicts.sh',
+  't8005-blame-i18n.sh',
+  't8006-blame-textconv.sh',
+  't8007-cat-file-textconv.sh',
+  't8008-blame-formats.sh',
+  't8009-blame-vs-topicbranches.sh',
+  't8010-cat-file-filters.sh',
+  't8011-blame-split-file.sh',
+  't8012-blame-colors.sh',
+  't8013-blame-ignore-revs.sh',
+  't8014-blame-ignore-fuzzy.sh',
+  't9001-send-email.sh',
+  't9002-column.sh',
+  't9003-help-autocorrect.sh',
+  't9100-git-svn-basic.sh',
+  't9101-git-svn-props.sh',
+  't9102-git-svn-deep-rmdir.sh',
+  't9103-git-svn-tracked-directory-removed.sh',
+  't9104-git-svn-follow-parent.sh',
+  't9105-git-svn-commit-diff.sh',
+  't9106-git-svn-commit-diff-clobber.sh',
+  't9107-git-svn-migrate.sh',
+  't9108-git-svn-glob.sh',
+  't9109-git-svn-multi-glob.sh',
+  't9110-git-svn-use-svm-props.sh',
+  't9111-git-svn-use-svnsync-props.sh',
+  't9112-git-svn-md5less-file.sh',
+  't9113-git-svn-dcommit-new-file.sh',
+  't9114-git-svn-dcommit-merge.sh',
+  't9115-git-svn-dcommit-funky-renames.sh',
+  't9116-git-svn-log.sh',
+  't9117-git-svn-init-clone.sh',
+  't9118-git-svn-funky-branch-names.sh',
+  't9119-git-svn-info.sh',
+  't9120-git-svn-clone-with-percent-escapes.sh',
+  't9121-git-svn-fetch-renamed-dir.sh',
+  't9122-git-svn-author.sh',
+  't9123-git-svn-rebuild-with-rewriteroot.sh',
+  't9124-git-svn-dcommit-auto-props.sh',
+  't9125-git-svn-multi-glob-branch-names.sh',
+  't9126-git-svn-follow-deleted-readded-directory.sh',
+  't9127-git-svn-partial-rebuild.sh',
+  't9128-git-svn-cmd-branch.sh',
+  't9129-git-svn-i18n-commitencoding.sh',
+  't9130-git-svn-authors-file.sh',
+  't9131-git-svn-empty-symlink.sh',
+  't9132-git-svn-broken-symlink.sh',
+  't9133-git-svn-nested-git-repo.sh',
+  't9134-git-svn-ignore-paths.sh',
+  't9135-git-svn-moved-branch-empty-file.sh',
+  't9136-git-svn-recreated-branch-empty-file.sh',
+  't9137-git-svn-dcommit-clobber-series.sh',
+  't9138-git-svn-authors-prog.sh',
+  't9139-git-svn-non-utf8-commitencoding.sh',
+  't9140-git-svn-reset.sh',
+  't9141-git-svn-multiple-branches.sh',
+  't9142-git-svn-shallow-clone.sh',
+  't9143-git-svn-gc.sh',
+  't9144-git-svn-old-rev_map.sh',
+  't9145-git-svn-master-branch.sh',
+  't9146-git-svn-empty-dirs.sh',
+  't9147-git-svn-include-paths.sh',
+  't9148-git-svn-propset.sh',
+  't9150-svk-mergetickets.sh',
+  't9151-svn-mergeinfo.sh',
+  't9152-svn-empty-dirs-after-gc.sh',
+  't9153-git-svn-rewrite-uuid.sh',
+  't9154-git-svn-fancy-glob.sh',
+  't9155-git-svn-fetch-deleted-tag.sh',
+  't9156-git-svn-fetch-deleted-tag-2.sh',
+  't9157-git-svn-fetch-merge.sh',
+  't9158-git-svn-mergeinfo.sh',
+  't9159-git-svn-no-parent-mergeinfo.sh',
+  't9160-git-svn-preserve-empty-dirs.sh',
+  't9161-git-svn-mergeinfo-push.sh',
+  't9162-git-svn-dcommit-interactive.sh',
+  't9163-git-svn-reset-clears-caches.sh',
+  't9164-git-svn-dcommit-concurrent.sh',
+  't9165-git-svn-fetch-merge-branch-of-branch.sh',
+  't9166-git-svn-fetch-merge-branch-of-branch2.sh',
+  't9167-git-svn-cmd-branch-subproject.sh',
+  't9168-git-svn-partially-globbed-names.sh',
+  't9169-git-svn-dcommit-crlf.sh',
+  't9200-git-cvsexportcommit.sh',
+  't9210-scalar.sh',
+  't9211-scalar-clone.sh',
+  't9300-fast-import.sh',
+  't9301-fast-import-notes.sh',
+  't9302-fast-import-unpack-limit.sh',
+  't9303-fast-import-compression.sh',
+  't9304-fast-import-marks.sh',
+  't9350-fast-export.sh',
+  't9351-fast-export-anonymize.sh',
+  't9400-git-cvsserver-server.sh',
+  't9401-git-cvsserver-crlf.sh',
+  't9402-git-cvsserver-refs.sh',
+  't9500-gitweb-standalone-no-errors.sh',
+  't9501-gitweb-standalone-http-status.sh',
+  't9502-gitweb-standalone-parse-output.sh',
+  't9600-cvsimport.sh',
+  't9601-cvsimport-vendor-branch.sh',
+  't9602-cvsimport-branches-tags.sh',
+  't9603-cvsimport-patchsets.sh',
+  't9604-cvsimport-timestamps.sh',
+  't9700-perl-git.sh',
+  't9800-git-p4-basic.sh',
+  't9801-git-p4-branch.sh',
+  't9802-git-p4-filetype.sh',
+  't9803-git-p4-shell-metachars.sh',
+  't9804-git-p4-label.sh',
+  't9805-git-p4-skip-submit-edit.sh',
+  't9806-git-p4-options.sh',
+  't9807-git-p4-submit.sh',
+  't9808-git-p4-chdir.sh',
+  't9809-git-p4-client-view.sh',
+  't9810-git-p4-rcs.sh',
+  't9811-git-p4-label-import.sh',
+  't9812-git-p4-wildcards.sh',
+  't9813-git-p4-preserve-users.sh',
+  't9814-git-p4-rename.sh',
+  't9815-git-p4-submit-fail.sh',
+  't9816-git-p4-locked.sh',
+  't9817-git-p4-exclude.sh',
+  't9818-git-p4-block.sh',
+  't9819-git-p4-case-folding.sh',
+  't9820-git-p4-editor-handling.sh',
+  't9821-git-p4-path-variations.sh',
+  't9822-git-p4-path-encoding.sh',
+  't9823-git-p4-mock-lfs.sh',
+  't9824-git-p4-git-lfs.sh',
+  't9825-git-p4-handle-utf16-without-bom.sh',
+  't9826-git-p4-keep-empty-commits.sh',
+  't9827-git-p4-change-filetype.sh',
+  't9828-git-p4-map-user.sh',
+  't9829-git-p4-jobs.sh',
+  't9830-git-p4-symlink-dir.sh',
+  't9831-git-p4-triggers.sh',
+  't9832-unshelve.sh',
+  't9833-errors.sh',
+  't9834-git-p4-file-dir-bug.sh',
+  't9835-git-p4-metadata-encoding-python2.sh',
+  't9836-git-p4-metadata-encoding-python3.sh',
+  't9850-shell.sh',
+  't9901-git-web--browse.sh',
+  't9902-completion.sh',
+  't9903-bash-prompt.sh',
+]
+
+# GIT_BUILD_DIR needs to be Unix-style without drive prefixes as it get added
+# to the PATH variable. And given that drive prefixes contain a colon we'd
+# otherwise end up with a broken PATH if we didn't convert it.
+git_build_dir = meson.project_build_root()
+if cygpath.found()
+  git_build_dir = run_command(cygpath, git_build_dir, check: true).stdout().strip()
+endif
+
+test_environment = script_environment
+test_environment.set('GIT_BUILD_DIR', git_build_dir)
+
+foreach integration_test : integration_tests
+  test(fs.stem(integration_test), shell,
+    args: [ integration_test ],
+    workdir: meson.current_source_dir(),
+    env: test_environment,
+    depends: test_dependencies + bin_wrappers,
+    timeout: 0,
+  )
+endforeach
diff --git a/templates/hooks/meson.build b/templates/hooks/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..5bbb1bd483f24e05f826918fe63391ef72334e11
--- /dev/null
+++ b/templates/hooks/meson.build
@@ -0,0 +1,26 @@
+hooks = [
+  'applypatch-msg.sample',
+  'commit-msg.sample',
+  'fsmonitor-watchman.sample',
+  'post-update.sample',
+  'pre-applypatch.sample',
+  'pre-commit.sample',
+  'pre-merge-commit.sample',
+  'prepare-commit-msg.sample',
+  'pre-push.sample',
+  'pre-rebase.sample',
+  'pre-receive.sample',
+  'push-to-checkout.sample',
+  'sendemail-validate.sample',
+  'update.sample',
+]
+
+foreach hook : hooks
+  configure_file(
+    input: hook,
+    output: hook,
+    configuration: template_config,
+    install: true,
+    install_dir: get_option('datadir') / 'git-core/templates',
+  )
+endforeach
diff --git a/templates/info/meson.build b/templates/info/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..7af5ddd24985fc0a5888961939ae3b2758f2aaa8
--- /dev/null
+++ b/templates/info/meson.build
@@ -0,0 +1,7 @@
+configure_file(
+  input: 'exclude',
+  output: 'exclude',
+  configuration: template_config,
+  install: true,
+  install_dir: get_option('datadir') / 'git-core/templates',
+)
diff --git a/templates/meson.build b/templates/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..1faf9a44ceaa5a6eee673e66c9d5448c08dbc7d5
--- /dev/null
+++ b/templates/meson.build
@@ -0,0 +1,15 @@
+template_config = configuration_data()
+template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
+template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
+template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
+
+configure_file(
+  input: 'description',
+  output: 'description',
+  configuration: template_config,
+  install: true,
+  install_dir: get_option('datadir') / 'git-core/templates',
+)
+
+subdir('hooks')
+subdir('info')

-- 
2.47.0.274.g962d0b743d.dirty

