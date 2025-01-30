Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F81EB9E3
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248259; cv=none; b=gzve0ooV+tF4joguMXHTzS5yF0yG4LTHEv+kNP9uPWbMQSg+sLhGuMSmdrUROa+dXUYb5oK8juKeMXOjBc2pSCIfonsbI1CE1K7tMmHoBJnYxTfAQI6zHrTK0+D0fgHUu+fp1qC3Z0fpTsmYxq4Kxd/njqS6UOrhSihAABoqHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248259; c=relaxed/simple;
	bh=150XYehbKCv1F9lkdlLJt2lPxwgw9lWjzvctOJZx9HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPaGqq6JARTq/yhUGJDkrj/pPXnJqtC9HWa+MbB/4G02Ea971CJFAvYgme/MnJ9XU+zUAYGP71UpPh8K67ooYCzes5y5PELhpvi+ylq/nAdNiGnJrJfKIhDM23pGRM/DZCL9FwDZx6m/CtuDnKWb7xb+IrEVN17BuXnyvHOMjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YMtZxUwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcQ2fU4n; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YMtZxUwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcQ2fU4n"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 011AA1140169;
	Thu, 30 Jan 2025 09:44:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 09:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248255;
	 x=1738334655; bh=ZpLfqUaoMGcokHmI0bDvi4HsCJOuRPkZ5bVLpHq0v/E=; b=
	YMtZxUwKWSVVHc73TRmd6mTUAofOBd8olCrofNVL91ZwpfXohHTfwaL+vhjId87k
	KqwQ3QiRzHumN5r+Q0uzfSu1wfGWFqW4BS4CC63Zc8Tmi8p5y2c+bO9l7b2fZHtF
	4MWcjcKq1oMIyvD8OTTVGx55l1EjTpDwgJlP2VR3MXoqpl4qAyJ+SFcSVnjXQ86k
	ikXZGUcve5e7bzBeOzn+IkpHHuUVR8vr7KlWWV8n9BnkNZMU5cvqad+boXObF/B9
	NCw5Gk9jZMHsXft7SUyMwIirL31kdBv32Hlgw7h1QvbZxkmiTdnMc2lKIL4kPMu1
	QooZCYS/AS11zfU4wttZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248255; x=
	1738334655; bh=ZpLfqUaoMGcokHmI0bDvi4HsCJOuRPkZ5bVLpHq0v/E=; b=O
	cQ2fU4nHK9ep14Ch0LGtqB2griLbVOQNVLMyW0s4a0p+ogDU9zl/SLUbW1KopaDS
	7Hnxt+Y6u87KTM64OmgUo5V8LxiWexG+EpA/Sh3lYNj2VaTKtjEw0gQfCotgpWXI
	NvLwbZL06iZLgTi1jlsxv5peLC/icpKriNPs6pMTPOSQaXS/8/RpeiLf/i4j0/1j
	4P03+dVmpm9gQ7I6zFhKZZOO8yl76ezwIHI1FhrNSmLXxYDr62x2Ud7xZCvlvvlh
	QIStFSvlnUBaAdG26lv2WUFoq3Syh36nGy/jcvMD07EOwCx6UcTfnTZMGY11FA3D
	0dUfyBZiEZzO2gHZiwoOg==
X-ME-Sender: <xms:P5CbZ4VlOVkoIRJsrgc7qT8I7zXsF6XIJ6cqYGxXWpSIThVqu5JN1A>
    <xme:P5CbZ8nTN8Pobe7IBNHszKFvX_VBAxOecUQ3VbtMX-AmC-HeG7aXV1IC6rCDlBe4_
    -P-ggvs64i5_UDhWw>
X-ME-Received: <xmr:P5CbZ8YauMkZh4d_l806QqCAG89zdkz-kN5x9wlIKvt7H43p-Do-pzfWwe5cevuKgvrAwpL5gS-OzaTIqR3r3m7ROkgSXo3yWA7AZTzrO-xT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P5CbZ3W23PKoGbvtVDT-G58YsVyxPRRGipxuHatffykBQNPhQuytGw>
    <xmx:P5CbZymSBpqmrL5kwQX9ZeTsW8LT7aoAEkm4IspGy6yTK8LLTB1wKA>
    <xmx:P5CbZ8etz0ifY9hyHoOZOhZ0EQCeclrwhUtuOStjtUpQ_j7cBJcCIQ>
    <xmx:P5CbZ0FZn86RVovRZml1S3OjS5O80N3khMA8IozNBPR6_uuUs_35Kg>
    <xmx:P5CbZ3xbWEMuUX8b6JzhH3E8gTh_dQuuG_GQKoakB2bXX9jGJaufAbL9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70f18eae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:59 +0100
Subject: [PATCH v2 07/13] meson: drop separate version library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-7-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When building `libgit.a` we link it against a `libgit_version.a` library
that contains the version information that we inject at build time. The
intent of this is to avoid rebuilding all of `libgit.a` whenever the
version changes. But that wouldn't happen in the first place, as we know
to just rebuild the files that depend on the generated "version-def.h"
file.

This is an artifact of an earlier version of the Meson build infra that
didn't ultimately land. We didn't yet have "version-def.h", and instead
injected the version via preprocessor directives. And here we would have
rebuilt all of `libgit.a` indeed in case the version changes, because
the preprocessor directive applied to all files.

Stop building the separate library and instead add "version-def.h" to
the list of source files directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 4b641095a1..e9af093024 100644
--- a/meson.build
+++ b/meson.build
@@ -478,6 +478,7 @@ libgit_sources = [
   'userdiff.c',
   'utf8.c',
   'varint.c',
+  'version.c',
   'versioncmp.c',
   'walker.c',
   'wildmatch.c',
@@ -1542,26 +1543,14 @@ version_def_h = custom_target(
   depends: [git_version_file],
   env: version_gen_environment,
 )
-
-# Build a separate library for "version.c" so that we do not have to rebuild
-# everything when the current Git commit changes.
-libgit_version_library = static_library('git-version',
-  sources: [
-    'version.c',
-    version_def_h,
-  ],
-  c_args: libgit_c_args + [
-    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-  ],
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
+libgit_sources += version_def_h
 
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
-    c_args: libgit_c_args,
-    link_with: libgit_version_library,
+    c_args: libgit_c_args + [
+      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+    ],
     dependencies: libgit_dependencies,
     include_directories: libgit_include_directories,
   ),

-- 
2.48.1.468.gbf5f394be8.dirty

