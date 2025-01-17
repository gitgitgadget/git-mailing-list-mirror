Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD21F9F61
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107783; cv=none; b=A4BPvftMjrdggRk95Wpj/cegvxNWLumcCzP25xMthpNg4rWGxRUqfDO6KWOnWs2BvDkN+eXWz7ikpLSWPSRFMvD3EZByldCnStwBM+N7fzvak33ixceiAfDkZWE+yS9m/xqzhjE8cXqCsS7rKVQ/SsdeBOjFojh3H6nhbmdWJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107783; c=relaxed/simple;
	bh=LXrrKmIwZLgVXScflJ76WmheGqO35YoS0Cg+NDIL2dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFugKaLa5+bS8cs7H132V68QtwWIrM96DzIwzsJKVENgkSBjx1+c1BY7G2Gq+YSJFAIdIgKTem5qmoiUOyihRIZkrma1zeSuKQntibyFORhaD1pGefFFe0axqzoEag2Tbw2f73edeE8ROl18jcOEL9MD0WjKVg3nHCE5Rw8NsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=flyiY+e8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0MmKfoa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="flyiY+e8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0MmKfoa"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B29631140121;
	Fri, 17 Jan 2025 04:56:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 04:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737107780;
	 x=1737194180; bh=DXu73kEj5oj2q0S1xBF+LonCgaxu1onPINdEFMVii68=; b=
	flyiY+e8cf/pRMIh6TAjxZ3oYfvKconodtt7tOsvgLMNRpSW10uQ+w3P13dzlndO
	vLpVV0uNr28mKSTbOqPI56FNExRPkZpoG8Qgo0kjsTXFcMeFdFbDyqqmjlL91BYC
	UWQ/8Ktzp06SuscvL848fPzQrq2SKNR/BbbtSDnmGGTwbhrR6kcSTkCwMF3SxcKf
	ewhfHSmGqVu1c0Nd1rhORS7LO5loB0NGGBrSG6WzNYMmqmE4YJOn6PrTo8qPtvky
	zzBvegIjeEHG1ZULKnfmLl1VFWbgY9qSiqDE7/HVRSW9uKgcyEiw0/w9DXTF40Hm
	zcVneGR43mvoxoGctKQXrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737107780; x=
	1737194180; bh=DXu73kEj5oj2q0S1xBF+LonCgaxu1onPINdEFMVii68=; b=R
	0MmKfoaouxzCMD9gtn7b8/yRd192d2GIXbREmtn+8jQDrTngQPoTzTQt7kTX62mD
	dXa6zRH9OaaIA4FFyb23EunZh2yAPeuw9gXVDTTqnYdlcXxoPZ8LiY230KmruDok
	hGCnfoFSdKbThrjbXDDSPkpehXqr7b6x85xlUB9VwaVhtPTQUZ8Kxn0y+0FJNTcq
	T9fXCoP5vo8W4Ur2JyZvGeEjRY87UYNXgJ097MPefTbIJmaa/ay98u66vdNW7PSP
	zJW79moTyLCS2JMGgM485Q33V4jiHo8anUr+MLEQYnkNJ3dOrpYyhf4if8K7m+A+
	RNSVwPD5pgJhmnVB/YUPQ==
X-ME-Sender: <xms:RCmKZ_oBBs8lm7GKT8HNJoVAygRfEJXokFHgJS3fSkimIi3p1CtZvw>
    <xme:RCmKZ5qPw3FB5r5uZFHny8gdBaV62lfHOp1cEJCej5nvTGr0jcnU4l7egoAvqA9LB
    YZISVIbuID3g88nvQ>
X-ME-Received: <xmr:RCmKZ8PYoAj3Nc4Enexh4mJCFdqDDm14MiWhaBK93kMYqvtwfVoi_qAmLKpEzUUddnlMEvzB9m8WzCrmadq9JEq4m-wT5yD7RfUkBndujslglHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrghgrsehfrhgvvggssh
    gurdhorhhg
X-ME-Proxy: <xmx:RCmKZy7p4mFT2wEok8NSAWkLgcGvss4gGzS9DLbRDtiDIYF8mBXQ-Q>
    <xmx:RCmKZ-5gyKFKYJLmGo7a3b_91aKfwvzvBYHM4BYoU8n1DX6m51kq0w>
    <xmx:RCmKZ6i1tSnRIkBA7Upm3lsWNBsewTGz6NI09OBIsJVhKUtdaZsIcQ>
    <xmx:RCmKZw7aEJ0ac82hKAyS7kc9PupPijOt2zM-XoVWNc0MleIxStspaA>
    <xmx:RCmKZ-FdOeCVaxAggIW08wadQ7sy9QJiJO9j_8crKr7ifwb3LxYKcxIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:56:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e33568e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:56:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jan 2025 10:56:07 +0100
Subject: [PATCH 3/3] meson: wire up the git-subtree(1) command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-b4-pks-build-subtree-v1-3-03c2ed6cc42e@pks.im>
References: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
In-Reply-To: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
To: git@vger.kernel.org
Cc: Renato Botelho <garga@FreeBSD.org>
X-Mailer: b4 0.14.2

Wire up the git-subtree(1) command, which is part of "contrib/". Note
that we have to move around the exact location where we include the
"contrib/" subdirectory so that it comes after building the docs so that
we have access to some of the common functionality.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/subtree/meson.build | 71 +++++++++++++++++++++++++++++++++++++++++++++
 meson.build                 |  3 +-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
new file mode 100644
index 0000000000..a752a188df
--- /dev/null
+++ b/contrib/subtree/meson.build
@@ -0,0 +1,71 @@
+git_subtree = custom_target(
+  input: 'git-subtree.sh',
+  output: 'git-subtree',
+  command: [
+    shell,
+    meson.project_source_root() / 'generate-script.sh',
+    '@INPUT@',
+    '@OUTPUT@',
+    meson.project_build_root() / 'GIT-BUILD-OPTIONS',
+  ],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+subtree_test_environment = test_environment
+subtree_test_environment.prepend('PATH', meson.current_build_dir())
+
+test('t7900-subtree', shell,
+  args: [ 't7900-subtree.sh' ],
+  env: subtree_test_environment,
+  workdir: meson.current_source_dir() / 't',
+  depends: test_dependencies + bin_wrappers + [ git_subtree ],
+  timeout: 0,
+)
+
+if get_option('docs').contains('man')
+  subtree_xml = custom_target(
+    command: asciidoc_common_options + [
+      '--backend=' + asciidoc_docbook,
+      '--doctype=manpage',
+      '--out-file=@OUTPUT@',
+      '@INPUT@',
+    ],
+    depends: documentation_deps,
+    input: 'git-subtree.txt',
+    output: 'git-subtree.xml',
+  )
+
+  custom_target(
+    command: [
+      xmlto,
+      '-m', '@INPUT@',
+      'man',
+      subtree_xml,
+      '-o',
+      meson.current_build_dir(),
+    ] + xmlto_extra,
+    input: [
+      '../../Documentation/manpage-normal.xsl',
+    ],
+    output: 'git-subtree.1',
+    install: true,
+    install_dir: get_option('mandir') / 'man1',
+  )
+endif
+
+if get_option('docs').contains('html')
+  custom_target(
+    command: asciidoc_common_options + [
+      '--backend=' + asciidoc_html,
+      '--doctype=manpage',
+      '--out-file=@OUTPUT@',
+      '@INPUT@',
+    ],
+    depends: documentation_deps,
+    input: 'git-subtree.txt',
+    output: 'git-subtree.html',
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+endif
diff --git a/meson.build b/meson.build
index 0064eb64f5..ac7f6ef38b 100644
--- a/meson.build
+++ b/meson.build
@@ -1857,7 +1857,6 @@ endforeach
 if intl.found()
   subdir('po')
 endif
-subdir('contrib')
 
 # Gitweb requires Perl, so we disable the auto-feature if Perl was not found.
 # We make sure further up that Perl is required in case the gitweb option is
@@ -1884,6 +1883,8 @@ if get_option('docs') != []
   subdir('Documentation')
 endif
 
+subdir('contrib')
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_TEST_CMP': diff.full_path() + ' -u',

-- 
2.48.0.257.gd3603152ad.dirty

