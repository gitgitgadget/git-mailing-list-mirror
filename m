Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C59394476
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194302; cv=none; b=g+5UZoJnP3kchQ1fFEm+L3ASkLD59kIBSn9YBl/hYPwBzQsjd4bcWUN+bHtg9UjI3rv8VA6xWmq3m2WDOXO2f2Jki10dIa9ENUqeKevvqqvMcdwOK97uyUGKN8DuDY6G0fU8LrxPwvipmixi960CdqPglIQAjOrDFb9pwrmFC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194302; c=relaxed/simple;
	bh=rD1cPVPxob51GbPXWJ5gyOQm4pIGqzSmXrZmDkT2s0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=kefFQKkEKON29nUSLZYB/aR7kNfvjNLcnCf4Y+8vdJtJLpiI0GNjfiC2dUX1NkrHtabVp8DXCiWytU/hUKo7EPh8rUEGL8qsxZw463jYAmkG+wwNkU9s9CNxe/LqTA8wjl/2vH7Gux3C2Jb+leKxTHoXc5SKQNvYBmRlD+UAyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nERz0d2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzG/3ZwQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nERz0d2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzG/3ZwQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 688AB1D00016;
	Wed,  4 Feb 2026 03:38:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 03:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770194301;
	 x=1770280701; bh=rYMMQrR/CetGGOTl1aPcddQc1+F7HV6y/Nn8oSRt4XU=; b=
	nERz0d2joH0xM8/ExZf0SGHg8Lb3z+ehqwwbBhU4ZO4ZehhS5aQ1oimByMFAj59Y
	KOK30w72XsHaLZ2zHa0dKPqPJjJ5Y7/Im1T2GaDrifkjHDaarpdn4qbSQBSOXAFI
	I1WrAea6vFFWAkLQhNZunsFkugM0Sxe1hJ9Q/drmy3J8hoUnYJfDmUgUjZgbw1+S
	Uw+zyXzX5mIF8StnmzwzafcWTrWACre9pVSdz0g3t90QOZ0KQk0N8PC1iQbWErqu
	viLgsgI2Dam9KIy9ZjdEtofLnwTAL1g1loBLJC872qg928PIN0CS1eMQsy0uwus4
	e7qHfW1wdnMPcldK+lZ5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770194301; x=
	1770280701; bh=rYMMQrR/CetGGOTl1aPcddQc1+F7HV6y/Nn8oSRt4XU=; b=d
	zG/3ZwQE2Qm618b6481mfGbC7+q5q27w11sE0MavN6FJC6VLfShYvpuaLPwBAfRO
	MRTTb9kc9qGmvo519CqWSiO9pgmTBDh4bRsuQo22Fz2wqW5XrQwp0HDUQ4f2zzMv
	s0S21cg2TbYmz5BSpoZ+ECrXt8HIWlguldMfUnmF1XrjBXEzH3NH8+VpULVJw2yR
	uj3PuGQfTUFJhYIy2Jjy46pxQPoC3E9x/lALhmiPsIYUNYVy/++VG7HWi9WeTvMd
	POGL2b0QjlwqBsVwga1nK846QQgS1qRuL+FJPONvvECOat7xQlCmjrjyGtLcy3Gd
	R5Lhy2g5vS/xyxCZHBypA==
X-ME-Sender: <xms:fQWDaWUPUjhPau4hDKoD8Od7dCTyhDDbLKoWYnJYHf2JPZajk5fjHg>
    <xme:fQWDaYnrdFTpdEkUhGO2QVojIkW83BCKB1PiqMllBSYsBNjvr2q48bM3N0Ye0Q4sZ
    6PGH4-d3DH9J_kor5o4y0i_oRmCPGMsflyN0eFDSVb75u9ZTx1DZt0>
X-ME-Received: <xmr:fQWDaYBV-iXWJr5JjI17ST0ykXVruFvIpswsMZZ_mNgLI9f1bHurfo6CWZEeEEGJyC_bjXqAdSfyqkCV090x7c7b_lruAFlhMLbQZ69qgTmpUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepiedvffevleejjeduhedujeeiudevteduke
    elueeiudfggeetueehueevtdekiefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:fQWDaYewQQ5sKh_E3oxXOJUpLgQPgvsUuwxn6qHJPf_DcpBqtrSetQ>
    <xmx:fQWDaTLxy876SpapIme-HZeo0eyqQYGmpIOJiAtBGkTJvwcoUGfm9g>
    <xmx:fQWDabeJOJtjgBQ1tcEAhNXCnl1nfWbXpIXtk7_Mkfbqn3DLon04zA>
    <xmx:fQWDaa2_FWUcIIvvZnObUIDYd90QJW_0rL9Wn1zWDLS0KWNE-FAScA>
    <xmx:fQWDafAPhpgNuP_L7dOd23EHa_iMdXZkNyc1uvkPZOO1xUDYCg7EthdB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 03:38:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43205968 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Feb 2026 08:38:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Feb 2026 09:38:11 +0100
Subject: [PATCH v2] meson: wire up gitk and git-gui
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
X-B4-Tracking: v=1; b=H4sIAHMFg2kC/22NwQ6CMBBEf4Xs2TVbhIKe/A/DgdZWNkhL2oZoC
 P9uxavHN5l5s0I0gU2ES7FCMAtH9i5DeShAD717GOR7ZiiprKmhE6oK5zHiZKJ3mPQT04hKNbU
 UUrdUtZCXczCWX7v11mUeOCYf3vvJIr7pz9eK81/fIpBQKt1bS0pTT9dcOfIE3bZtHxejLaezA
 AAA
X-Change-ID: 20250703-b4-pks-meson-tcl-tk-bb75616c8048
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

Wire up both gitk and git-gui in Meson as subprojects. These two
programs should be the last missing pieces for feature compatibility
with our Makefile for distributors.

Note that Meson expects subprojects to live in the "subprojects/"
directory. Create symlinks to fulfill this requirement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I have upstreamed support for Meson into both gitk [1] and git-gui [2].
This small patch series wires up support in Git.

Changes in v2:
  - Use symlinks instead of moving both gitk and git-gui into the
    "subprojects/" directory.
  - Rebased on v2.53.0, as it's been a while since v1 :)
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im

Thanks!

Patrick

[1]: https://github.com/j6t/gitk/pull/8
[2]: https://github.com/j6t/git-gui/pull/9
---
 meson.build         | 14 ++++++++++++++
 meson_options.txt   |  4 ++++
 subprojects/git-gui |  1 +
 subprojects/gitk    |  1 +
 4 files changed, 20 insertions(+)

diff --git a/meson.build b/meson.build
index dd52efd1c8..e96953afec 100644
--- a/meson.build
+++ b/meson.build
@@ -239,7 +239,9 @@ git = find_program('git', dirs: program_path, native: true, required: false)
 sed = find_program('sed', dirs: program_path, native: true)
 shell = find_program('sh', dirs: program_path, native: true)
 tar = find_program('tar', dirs: program_path, native: true)
+tclsh = find_program('tclsh', required: get_option('git_gui'), native: false)
 time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
+wish = find_program('wish', required: get_option('git_gui').enabled() or get_option('gitk').enabled(), native: false)
 
 # Detect the target shell that is used by Git at runtime. Note that we prefer
 # "/bin/sh" over a PATH-based lookup, which provides a working shell on most
@@ -2250,6 +2252,16 @@ configure_file(
   configuration: build_options_config,
 )
 
+gitk_option = get_option('gitk').disable_auto_if(not wish.found())
+if gitk_option.allowed()
+  subproject('gitk')
+endif
+
+git_gui_option = get_option('git_gui').disable_auto_if(not tclsh.found() or not wish.found())
+if git_gui_option.allowed()
+  subproject('git-gui')
+endif
+
 # Development environments can be used via `meson devenv -C <builddir>`. This
 # allows you to execute test scripts directly with the built Git version and
 # puts the built version of Git in your PATH.
@@ -2276,6 +2288,8 @@ summary({
   'curl': curl,
   'expat': expat,
   'gettext': intl,
+  'gitk': gitk_option.allowed(),
+  'git-gui': git_gui_option.allowed(),
   'gitweb': gitweb_option.allowed(),
   'iconv': iconv,
   'pcre2': pcre2,
diff --git a/meson_options.txt b/meson_options.txt
index e0be260ae1..659cbb218f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -43,6 +43,10 @@ option('expat', type: 'feature', value: 'enabled',
   description: 'Build helpers used to push to remotes with the HTTP transport.')
 option('gettext', type: 'feature', value: 'auto',
   description: 'Build translation files.')
+option('gitk', type: 'feature', value: 'auto',
+  description: 'Build the Gitk graphical repository browser. Requires Tcl/Tk.')
+option('git_gui', type: 'feature', value: 'auto',
+  description: 'Build the git-gui graphical user interface for Git. Requires Tcl/Tk.')
 option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
diff --git a/subprojects/git-gui b/subprojects/git-gui
new file mode 120000
index 0000000000..c6d917088b
--- /dev/null
+++ b/subprojects/git-gui
@@ -0,0 +1 @@
+../git-gui
\ No newline at end of file
diff --git a/subprojects/gitk b/subprojects/gitk
new file mode 120000
index 0000000000..b66ad18ae5
--- /dev/null
+++ b/subprojects/gitk
@@ -0,0 +1 @@
+../gitk-git
\ No newline at end of file

---
base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
change-id: 20250703-b4-pks-meson-tcl-tk-bb75616c8048

