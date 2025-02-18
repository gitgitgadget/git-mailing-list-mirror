Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC61D63CE
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864780; cv=none; b=AdeeMVCHZVgFNWR1kzwdAeZl7S/Wam2+qylrHgDx9eCbvnStiBfwtEtav4Ua1owCyyS9A5b4Q6wMTouqKQV8N5pfRwvtBzwv2XB59uPx2CI/+Svap7hfHpTCDEfpmh6rwveeh8cbmnld2nK2o06ccdZd0SRBXFZE+5I5GTrAqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864780; c=relaxed/simple;
	bh=cXrRoGNuIHrGG39QH+1YHhc4gAZhe2/r7WqBr7IooOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUqzJ/plRqrye219MKPQc+gmEXPY5uXnc0/M5HpVOyJJoeKEAGCSLqVL66C+lVL9GH2eYeUhX8EbR0Qi7Jx+YcGRzI+zVY9+AAr4waq2chEb+n0ylo/utOGtRNhWLQOqefhehCcagZhs7H/xYI8FC4j8VmkC9JgtWR2PjYPM0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GC7PDBWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zHOS9/VE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GC7PDBWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zHOS9/VE"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 122B311401C3;
	Tue, 18 Feb 2025 02:46:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 02:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864775;
	 x=1739951175; bh=/vAeO7JMaYsRftCPG+zvnzAFBLAT9TDrAXSMA9BFc3U=; b=
	GC7PDBWOtu54cDs0hdiiCli1oQA0+FSo/xFN8s4PHmVCpyhnBj4SK6nloJvxutT8
	Vfn5RurH0Ujz3kj8k2lg0HeB2QSKof+XgDRK45LR/HAyhPgJSk/cz2hANkmlSQZ8
	+SZMyTggbxWlX0lPLplbYeU0HX4AkOFZJPurW1clrphQP4ssqfMly1qTcAQeyGw2
	Bl/6TkCw0knoEcs1q3YIBQcL3dEQi9HlZumcXexrPxoAWd/INxot1Yi/Ji/EoZnf
	erTzO8eHBzutyfCVllejyDIvx+FmnDkJXG8AmsGuo94a52DKSxIoltEpf62wWE7H
	ndm/NuaZHHhLfXCCdkRg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864775; x=
	1739951175; bh=/vAeO7JMaYsRftCPG+zvnzAFBLAT9TDrAXSMA9BFc3U=; b=z
	HOS9/VE4kqJihTQsIe+Khxy3S7kaXxR5FhGyeIVTcF8TzYnIvjAMIZV+hub3Y7sY
	gmpWTFSwY3vv9bDGVLIX71Nc76YsTHUugbVlgaJ4NgK0QKSQSxjcmrsLsVXdttJ6
	RduuposvGkttXJshNW7ajSdLj4A36btaofFB6L6vgfuhsi6rXSoISixldfYGVNKm
	6zJB+b0+nq4df+kudTDNSq1M6v/bqbTTBhWzUEY66LWXOH8IbSdg7qAB5j71aUrg
	jKB85d4YaNE8cCZQSYoJRAs0ZFe2TtRRvdWxDBoJ+utb2/7JNpFIun5iCDWtOMmD
	Bte63d80ayuMYLqfKtsug==
X-ME-Sender: <xms:xjq0Z2vn15EfL0OzTX5yt_lpXFVp_YgqC7ANV7700N6dsMomPNSZsQ>
    <xme:xjq0Z7fGcXuu-ELI8Fj55eWuq7gDYrZ8xxU7YSRmgHN78jCcgRMmccpuN7p8yaqcS
    5p3JnKF3T96JOrVqw>
X-ME-Received: <xmr:xjq0ZxxeDqJSQkpBmrvXOgJ3VmwWBgwxsbFbHAwnbAD_5Ypecgt4z4uXqDyY2DPf-4z63kcuGHKeZ5Ln860ZNbi1m1HbrSpO9ovT-s5PngvT6XPS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xjq0ZxOmXjctlJKeMK-S_wbMxQ9_7V59-dn1EETF8pHs4Zgmc8GFAA>
    <xmx:xjq0Z2-MSWwzkPwOZQcD1VOnuEV4vRMBBetIxkXGfUd3iJyyS_IEIw>
    <xmx:xjq0Z5Uht2gzf_wa_UBykL9ZiKnMiV7szaDshfhVsWUPPhsOyFcyLA>
    <xmx:xjq0Z_e7HrwKdSIqi9bU6ZARHqMjW_ip1Zb0X2dh82AUp3SbUSzlnw>
    <xmx:xzq0Z4IYip0qd1J-hJUw7M1wen1YvwDob9SFm7MWTnDOcCEZQxzR_f4k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 943d17e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:58 +0100
Subject: [PATCH 10/12] meson: wire up Gitk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-10-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Wire up the Gitk graphical repository browser in Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitk-git/meson.build    | 28 ++++++++++++++++++++++++++++
 gitk-git/po/meson.build | 19 +++++++++++++++++++
 meson.build             |  2 ++
 meson_options.txt       |  2 ++
 4 files changed, 51 insertions(+)

diff --git a/gitk-git/meson.build b/gitk-git/meson.build
new file mode 100644
index 00000000000..7b16cd3c4d3
--- /dev/null
+++ b/gitk-git/meson.build
@@ -0,0 +1,28 @@
+wish = find_program('wish', required: get_option('gitk'))
+gitk_enabled = wish.found()
+
+if not gitk_enabled
+  subdir_done()
+endif
+
+custom_target(
+  command: [
+    shell,
+    meson.current_source_dir() / 'generate-tcl.sh',
+    wish.full_path(),
+    '@INPUT@',
+    '@OUTPUT@',
+  ],
+  input: 'gitk',
+  output: 'gitk',
+  depend_files: [
+    'generate-tcl.sh',
+  ],
+  env: script_environment,
+  install: true,
+  install_dir: get_option('bindir'),
+)
+
+if intl.found()
+  subdir('po')
+endif
diff --git a/gitk-git/po/meson.build b/gitk-git/po/meson.build
new file mode 100644
index 00000000000..b1ed0198285
--- /dev/null
+++ b/gitk-git/po/meson.build
@@ -0,0 +1,19 @@
+import('i18n').gettext('gitk',
+  languages: [
+    'bg',
+    'ca',
+    'de',
+    'es',
+    'fr',
+    'hu',
+    'it',
+    'ja',
+    'pt_br',
+    'pt_pt',
+    'ru',
+    'sv',
+    'vi',
+    'zh_cn',
+  ],
+  install: true,
+)
diff --git a/meson.build b/meson.build
index 20159cef83d..5f2db6b0419 100644
--- a/meson.build
+++ b/meson.build
@@ -1957,6 +1957,7 @@ if get_option('docs') != []
 endif
 
 subdir('contrib')
+subdir('gitk-git')
 
 foreach key, value : {
   'DIFF': diff.full_path(),
@@ -2010,6 +2011,7 @@ summary({
   'curl': curl.found(),
   'expat': expat.found(),
   'gettext': intl.found(),
+  'gitk': gitk_enabled,
   'gitweb': gitweb_option.allowed(),
   'https': https_backend,
   'iconv': iconv.found(),
diff --git a/meson_options.txt b/meson_options.txt
index afa908d6c53..4cce8a81154 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -41,6 +41,8 @@ option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
+option('gitk', type: 'feature', value: 'auto',
+  description: 'Build and install gitk(1), which requires Tcl.')
 option('pcre2', type: 'feature', value: 'enabled',
   description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
 option('perl', type: 'feature', value: 'auto',

-- 
2.48.1.666.gff9fcf71b7.dirty

