Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16B3115A9
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591533; cv=none; b=DBO+LSfEARYzMAVIATZgwXfVdTFaYzs4mBjTOI20lFm+zSTbfGPPdJ5G7RyBkwCWlwZuSct/VHPw286ucQwfvBa1l8xmi/PJfxh/qYObwlBsIplhxzRGIY4D5LFkUVIk/72sxNazBQZq1hRhGHSiT/U9NcXA6OZROTp4xY/fG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591533; c=relaxed/simple;
	bh=AbCGLH/1rigBgM6S2FfSxF2gcMqUD4i6bI6RC5thanE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hb8ahkaTJQkF/5yfL5LV9xdErhEZ8uv6B03Gu1B/k25gQkePo/8pY05TpZApXhABlJDFG0S/DNd+3zdqqMq75Op/ObeC3uoW2tlzXzBqFG8sxvnISw924yAzLN9bPLwCxMrg4JjdCwqetz8HZq9+cJ0lPt7lVGQXO7dS23yPNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OCp/34pj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwGL0eBF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OCp/34pj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwGL0eBF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AABE1D00261;
	Tue, 19 Aug 2025 04:18:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 04:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591530;
	 x=1755677930; bh=yFpt9+E41H8WD+g7+6OEdzqwnBHw++OGzQMGY3ouXCo=; b=
	OCp/34pjvn/O8T6PxvJVIwuNAEUeZ87XMAadS1aIhigJxWosXQGLrdUmlrkbVVcI
	/C6ZO59cdz9BSP31NDUPoJlBH7zWwPY0vqSaO35gfl5QzVDhr4q8d2OG0ximY1mF
	3MH1C6L4QHp0kvu3yFIuGTb50z7VJpVtjoOcqaGjjpu6vv1IMzOStfV62j9SIaiC
	KAhBnPLHFleU4Gc5U9m+GQD6LjtsatUrrBqXHJoHL6iwJ8cwTrpzUAw0duloYk/w
	DFi4xal1TUSfWADSwdpdL0TxF6KtggQUjc4CY26zVZnFoB3RIRWZnrJc/mMHnIAR
	TGAWTXdACQBpufOGxhBXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591530; x=
	1755677930; bh=yFpt9+E41H8WD+g7+6OEdzqwnBHw++OGzQMGY3ouXCo=; b=f
	wGL0eBFaV0gsO2jZ5lVdFyJ+Gr7XSmvS5Kd5EL86N65PnqmGw7YJQfnNAbsUjWhu
	iF+QIWgmt4Dt+t7ucdZpRhcDItYAXt4G3tvHD7UBWUwm+6Ywsxcu9X8snXpt0JHl
	K15eKB/e8XWfVFp67lBUnhr//3XbagDQvbDpvc8DiacQvFYyDGg9FnxUk1HnI3FP
	rUh6tH6dRvELF+F1BwYmgtA9Y5392EdPH5etOqVJtBK+O3RltddjPu1j+wVds4Ww
	z6KiZu9SNhpOdajMS7vWSIw27UWGGVuqbahmoOPqDvcsSy4B/uLaJQBn1wB7GESF
	7jvAxqKy3bVjV3/9Mvl6g==
X-ME-Sender: <xms:ajOkaOR1Enq8_lesc9ESc0D-GRHnwityiBnSsFuOVnq8xtE1Ds5ZEA>
    <xme:ajOkaD8AQCpCDlqilHqNpMT3qcbRQeyZ1vCL-p-gjYYvnEekSW8xpESKvwt8lt5-8
    y1KDDq8fnTVFWNZBg>
X-ME-Received: <xmr:ajOkaNr9ZoF9SqjJLW9p6kMHu_9vdaR850oCiHDRHlcfMZEx3bJKsNXQb8ZgEb-CCj95jxuwhN0CuLNIK_nCRx_UKnROXhW7wyZ00Z2oB5QV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:ajOkaIlvqptk7rSfi35GFYWzqVCFTawCW5JbBd2ILKD1BFy5K-xF7A>
    <xmx:ajOkaMJ-qqWif5-H_uDVeq0T2umhngT4hL3a_Latn_AgHE0Xl2M1Tg>
    <xmx:ajOkaFz35qn62SwUdR0xqpRYRZ28FAOKXnW76aR7ABWhSLvGlCJA0g>
    <xmx:ajOkaMvxNVwIYH1FIl3OFCFYmOI6_yrwfn_rUHOB6ISBdytNafU3AA>
    <xmx:ajOkaGDwrvTOg8G56w_D9rFqCixZDBT7W0JZamnLoCqqbCHdVhGwIagf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:18:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd830395 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:18:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:18:37 +0200
Subject: [PATCH 3/3] meson: wire up gitk and git-gui
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-meson-tcl-tk-v1-3-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Wire up both gitk and git-gui in Meson as subprojects. These two
programs should be the last missing pieces for feature compatibility
with our Makefile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 14 ++++++++++++++
 meson_options.txt |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/meson.build b/meson.build
index 5dd299b496..edf7b69a00 100644
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
@@ -2207,6 +2209,16 @@ configure_file(
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
@@ -2233,6 +2245,8 @@ summary({
   'curl': curl,
   'expat': expat,
   'gettext': intl,
+  'gitk': gitk_option.allowed(),
+  'git-gui': git_gui_option.allowed(),
   'gitweb': gitweb_option.allowed(),
   'iconv': iconv,
   'pcre2': pcre2,
diff --git a/meson_options.txt b/meson_options.txt
index 1668f260a1..8fa330771b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -41,6 +41,10 @@ option('expat', type: 'feature', value: 'enabled',
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

-- 
2.51.0.261.g7ce5a0a67e.dirty

