Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E52248AA
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011737; cv=none; b=ujU0XR4TuGI5WddWATd3gO7kPnNovcouThfFo+L8vK2ITqGKIGRL1KNnOcbaTaYk3JRAz+l+2JKEAUvfseZLzjacUB3HF9ERnWlknr5PpDfXrjQhPkN4bqtEyj/JDlirFoVn3nIDGNthrU1gmuRp3Ei489DdE6YVHDj9kkSj3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011737; c=relaxed/simple;
	bh=IjrqzPYE+nUd17thwGn/bI++lQcigwUwtxxJk96BR0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K+J4iBQB2rHzHzehys5wwj/2CkMLyAdyNVz1rEU+Ui1pcrNv6E1O//SBe2wulAwEyYM03lPsU05w34nE0kNU7FAPsEqyHaPUZgmW58zy8kV6aPDOwct5kkWTtrhIhPxJUWklYVH6IqbO+zTqNKdRnzAJvbG985mbeQCtPOab6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TdNEMA3I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8IxeXQr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TdNEMA3I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8IxeXQr"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A3A81380263;
	Mon,  7 Apr 2025 03:42:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 03:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1744011733; x=1744098133; bh=6jxe7GGwLJ
	Zf15sToLJztapP9Tz53k9W+rmOLVRFfeQ=; b=TdNEMA3IaFOFoQbloepXqavI1Z
	FE/3uIx5QJhXjPupkC6WhJjx9vACStMWgHMxa1sH0+bmIa7HiCpL1PAcqLpI2jf+
	4c8G7mypWpLZuzyjda/Kf0gjvDt5orRQHOhAfwQjjfHx3lw721TNI/ExXNaBGizF
	ZylSMeiVnJO/6G98fwcciPxm3dWcLG0/0G9zQq/FB4WNVviGHwR4SZvaVC7MOmDl
	AtcHTd7cqZN++Glb1rgg+Vjd02pAnLOoZItfgLQDlBSrbR86CSDntMU1K9rmIEHc
	9lesEb01TogWTyx/XhgqCFNcwMMJXEdrtxuTzRAwgtzgsHM5vicxEV0DSudQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1744011733; x=1744098133; bh=6jxe7GGwLJZf15sToLJztapP9Tz5
	3k9W+rmOLVRFfeQ=; b=e8IxeXQrBvLDxnFBrmGpoA7PBQH4T7oxD/IR1/9VWxLy
	eSq0vSGgiS0TBO+VkjLwukxu2WQIuFIyH8EtH6dOb973ICd3+j55QPZByc5Klf8n
	uHQ7Yx1rebdNEWYUwqCqx/wddzP19B5kaGeb8NV/r+LZxbo6+gFwBOgNDpmAwZav
	yQXZuM4w2oRvg4rMK5hfydIxGo2tigJENUUBnrYt5ai970b9uKI1MmOkyq/97PWP
	IGXGMCa7JxP/ByVMNGAV6NolhFFwG4KGbc1jgioh7AlrU3+iPwH5ZGB19OVElpC6
	wrtw7oVwvr0EKUjNGef4AM9xeJ99ztUAM1ilmUnxdw==
X-ME-Sender: <xms:1IHzZxX9Sp2BZv0OKooSah918EFZ8MuR_LBOnabswDZ0ydKVocXIwg>
    <xme:1IHzZxm8oCXQrGZ2NKsHtftzuMBalzJVFX6zqHZ8Cs--QwmXAvCbBR84eDzHVdgv7
    MYV9sfUSgAdcjL7-A>
X-ME-Received: <xmr:1IHzZ9bk2noz5lUmzAPtOO9p2dfZNrlLzUe9lcuO8vzkHao4EBXJMLKCT4fJQavuqH-HKCEyiSuehDLYvI8GbnKIXmcrbnPmrFJNd2ItGOY5Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepiefgiedtff
    ffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiies
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhishhtshdoghhithesrghkshhhrgihrdhish
X-ME-Proxy: <xmx:1IHzZ0Uf98aIOBQv5dZBbi_nZIoqTps4kxOEVpHyw74hVIcSNvczqA>
    <xmx:1IHzZ7kSMKMr-dGvHxavfHoH3LkAZILuQHmvxVV6-0vkF_3GpbawxQ>
    <xmx:1IHzZxfLvN2R_3DHv0r-tUWdfgObLONX7Ct976VkLcPO6mXnY4mtog>
    <xmx:1IHzZ1G0qqVYSbUEtV4qq7tuaHZBKEZIZqZxC0Wfh9w01RN8ym0EXQ>
    <xmx:1YHzZ84WLIueWfkT8JjauuBKgcJq0VSPtoRhlNxpDR4T-pC9ojebXAd6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 03:42:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c7c35c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 07:42:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 09:42:04 +0200
Subject: [PATCH] meson: install shell completion scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
X-B4-Tracking: v=1; b=H4sIAMuB82cC/x2NwQqDMBAFf0X23IUYDIK/Ij1E+9IuxiRkRQriv
 zf0OIeZuUhRBUpTd1HFKSo5NegfHa0fn95geTUma6wzgxl5Gbhsyjs0J5akh4+R17yXiKO5ynD
 O2dB72CVQy5SKIN//Yn7e9w9r9xabcgAAAA==
X-Change-ID: 20250407-b4-pks-meson-install-completions-e5552f1ae2bf
To: git@vger.kernel.org
Cc: Akshay Hegde <lists+git@akshay.is>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

While Meson has support for _building_ our completion scripts, it does
not yet know to also _install_ them. This omission is intentional as it
matches the status quo of our Makefile, which doesn't know to install
these scripts, either. In fact, our Makefile does not know about these
scripts at all: the "build" step that Meson performs is basically just
to copy over the files into the build directory, which is required so
that our tests know to pick them up for an out-of-tree build.

The status quo is somewhat confusing for our users though, as the build
steps need to be enabled manually by passing `-Dcontrib=completion` to
Meson. So the user explicitly asks for completion scripts, but all they
get is that we copy them into the build directory and execute tests.

Teach Meson to install completions for Bash and Zsh into the prefix. For
now, we try to do the "right thing" and install the scripts into the
installation prefix at their canonical paths. These paths should be
standardized enough these days so that this works alright for most
distributions. If we ever discover that these paths don't work well we
can still introduce build options at a later point in time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch is a result from the discussion at [1]. Thanks!

Patrick

[1]: <Z-uLqQd7QHZq-tB7@akshay.is>
---
 contrib/completion/meson.build | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/meson.build b/contrib/completion/meson.build
index 3a9ddab5940..019c1457488 100644
--- a/contrib/completion/meson.build
+++ b/contrib/completion/meson.build
@@ -1,16 +1,42 @@
-foreach script : [
-  'git-completion.bash',
-  'git-completion.tcsh',
-  'git-completion.zsh',
-  'git-prompt.sh'
-]
+foreach script, config : {
+  'git-completion.bash': {
+    'filename': 'git',
+    'install_dir': get_option('datadir') / 'bash-completion/completions',
+  },
+  'git-completion.tcsh': {},
+  'git-completion.zsh': {
+    'filename': '_git',
+    'install_dir': get_option('datadir') / 'zsh/site-functions',
+  },
+  'git-prompt.sh': {},
+}
+  # We have to discern between the test dependency and the installed file. Our
+  # tests assume the completion scripts to have the same name as the in-tree
+  # files, but the installed filenames need to match the executable's basename.
   if meson.version().version_compare('>=1.3.0')
     test_dependencies += fs.copyfile(script)
+
+    if config.has_key('install_dir')
+      fs.copyfile(script, config.get('filename'),
+        install: true,
+        install_dir: config.get('install_dir'),
+      )
+    endif
   else
     configure_file(
       input: script,
       output: script,
       copy: true,
     )
+
+    if config.has_key('install_dir')
+      configure_file(
+        input: script,
+        output: config.get('filename'),
+        copy: true,
+        install: true,
+        install_dir: config.get('install_dir'),
+      )
+    endif
   endif
 endforeach

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250407-b4-pks-meson-install-completions-e5552f1ae2bf

