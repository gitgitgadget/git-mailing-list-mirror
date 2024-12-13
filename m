Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368C1AD418
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079751; cv=none; b=EHihAoRKlhAMJaUtQh2CF8SqXbKprWTR7WvorbBtJ5uffSpGN5y0KdI7ytbff7IeaoGVWPUQ7w2sMAzoZ9pejTAgoUetTBS74/2H0/ZRQDO/mp/3yxVNWcpFpSrb2B7Iq2RYMm0jHF0kWPWyykzPEdkxJJh9AilMqWkjSi2mB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079751; c=relaxed/simple;
	bh=kljqeo9XEakZTcKHOKRWAGP6o9UvT/+aaWeLYq3PT6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+NR5bKmW5gEvZO1sZ7EIG72pXPV5Jg0Bo0RtCzlcVkQwYEFDtQqx75B38NZBduKbth1ZbU708DhMNX/fSz70dko0MNRuGW6qhapr7rE3am5Zvz0LiVRonf+WsofeT1Ff15QzNDuJ7V+9HNZ9zp4sD7W/o0QF6/k8CcCWMQ2gPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GTD2Jtr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyI8LbGy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GTD2Jtr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyI8LbGy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E355A1140204
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 13 Dec 2024 03:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079748;
	 x=1734166148; bh=C+MFSgyYVTzqW9X2yjt3mi3mjP07aeMuxcok1Qur+HY=; b=
	GTD2Jtr9ueCpFmk9g58FB0NCwBsV9BfgO8jIRNcVcPiNqkTZISHexAzD2ZbPLEtq
	v+GCMikRA6GU2djoVIX3/rOT2iwd1n9IivWBe2FYT3McbTpfqwp+CideJQl7Aay2
	YZ1YWNf7EZb8fCTCh1kojCrWyDCMocEiUTOhS+AQuMZUF27cg5adWzM9vv1JuQww
	0aaYbNaxGazRP40lngB/DFawLm2bSGOM1+d/rqX62uShPtsbnQYPMXIs3UtpUrGo
	UPItqLhi6cN+hTaR/WoZdl6Yo5IBZxClgd2v/tBtoHlieJUulZytdwZ5CiqLTETp
	qSE8RXOybBOBzgRTdxeedg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079748; x=
	1734166148; bh=C+MFSgyYVTzqW9X2yjt3mi3mjP07aeMuxcok1Qur+HY=; b=h
	yI8LbGy1ebijq+2DDbx/QZmttpypo8iypR39/e9qD8jzs2mTkSUeMQAKfFzl/21Q
	+5lVtdbcrmu/c4AWQ1F7hxANdqoiF0mhlcSbuvUlnxf3b1xjaFWUEejdeUhREvoR
	jYWi3puVyhsIaqFAwKZ3UyQ6hNN1D8oe+drIoUTfHhiL7mibtO4uA4ErIwcQYnOZ
	8Orhpia586eliAiU6Zk68vEhcH3vp7JCMnrD3Qfvdik5wopNAdoyTsPsDB3vfahV
	DkMoJwINGWmE6BvLdY6ysZFSSRvnZen1xEyLwRHbyZ8KR3D2QPxbUvCa5MHOK0cm
	nlzof7VkuHY78ocuX/h5Q==
X-ME-Sender: <xms:BPVbZ3Sp7JAFycq1acMuKzca0oIV31umWnTBQsCN3xMkL5Dj6pAWVw>
    <xme:BPVbZ4x66GuX-3g6dM_aaGOqqApaWeQ3b7N14NrITdWTxl8UrEXCvmMGUySdBzHJQ
    MKWhr18zL_1cKGXcg>
X-ME-Received: <xmr:BPVbZ81Nhihzx68rZYVDHc1bqOXF6IZpziEUZfNoymYBIQIscZCzwkMHTKTQ2XE_EOrWuS8GUGen9FyrPmC5Bs22r_FnvOHRADkO-9REAFG3KDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BPVbZ3C69K4BIK_1dO-iRsCpgO3-kpgu1sa0qk-QJTKBdVzU8_uXEw>
    <xmx:BPVbZwjGN5lXMu5XUsTFxGy3jTz9OG12xt5q9N9i4KeB5Yor0GJRQg>
    <xmx:BPVbZ7od8Vjj2qkhlcM8IlR4c29OlriKjxQIqDiSsWuZ0ZNDNdMPRw>
    <xmx:BPVbZ7hVdKV4KwKGpxXfhQ4SXPCXQkBmbH_Fy8d_WbaxjaUiiKNnbw>
    <xmx:BPVbZ8aj3iqRoYCq_FPTZpVPztHVhOpMXxjvgVomGgECL_SW-Ot95rgj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c89256ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:38 +0100
Subject: [PATCH 09/10] meson: generate articles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-9-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While the Meson build system already knows to generate man pages and our
user manual, it does not yet generate the random assortment of articles
that we have. Plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/meson.build     | 62 ++++++++++++++++++++++++++++++++++
 Documentation/meson.build           | 36 ++++++++++++++++++++
 Documentation/technical/meson.build | 66 +++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..c023c104161e61ca0399b5390d59e20343746621
--- /dev/null
+++ b/Documentation/howto/meson.build
@@ -0,0 +1,62 @@
+howto_sources = [
+  'coordinate-embargoed-releases.txt',
+  'keep-canonical-history-correct.txt',
+  'maintain-git.txt',
+  'new-command.txt',
+  'rebase-from-internal-branch.txt',
+  'rebuild-from-update-hook.txt',
+  'recover-corrupted-blob-object.txt',
+  'recover-corrupted-object-harder.txt',
+  'revert-a-faulty-merge.txt',
+  'revert-branch-rebase.txt',
+  'separating-topic-branches.txt',
+  'setup-git-server-over-http.txt',
+  'update-hook-example.txt',
+  'use-git-daemon.txt',
+  'using-merge-subtree.txt',
+  'using-signed-tag-in-pull-request.txt',
+]
+
+howto_index = custom_target(
+  command: [
+    shell,
+    meson.current_source_dir() / 'howto-index.sh',
+    '@INPUT@',
+  ],
+  env: script_environment,
+  capture: true,
+  input: howto_sources,
+  output: 'howto-index.txt',
+)
+
+custom_target(
+  command: asciidoc_html_options,
+  input: howto_index,
+  output: 'howto-index.html',
+  depends: documentation_deps,
+  install: true,
+  install_dir: get_option('datadir') / 'doc/git-doc',
+)
+
+foreach howto : howto_sources
+  howto_stripped = custom_target(
+    command: [
+      find_program('sed'),
+      '-e',
+      '1,/^$/d',
+      '@INPUT@',
+    ],
+    input: howto,
+    output: fs.stem(howto) + '.stripped',
+    capture: true,
+  )
+
+  custom_target(
+    command: asciidoc_html_options,
+    input: howto_stripped,
+    output: fs.stem(howto_stripped.full_path()) + '.html',
+    depends: documentation_deps,
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc/howto',
+  )
+endforeach
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 1fdc6a61eb04707d7c4b7aabb412b32ddc517dc7..1dd84af2d6bcf3214cfa1ec78c00359f64040fca 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -411,4 +411,40 @@ if get_option('docs').contains('html')
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc',
   )
+
+  articles = [
+    'DecisionMaking.txt',
+    'MyFirstContribution.txt',
+    'MyFirstObjectWalk.txt',
+    'ReviewingGuidelines.txt',
+    'SubmittingPatches',
+    'ToolsForGit.txt',
+    'git-bisect-lk2009.txt',
+    'git-tools.txt',
+  ]
+
+  foreach article : articles
+    custom_target(
+      command: asciidoc_common_options + [
+        '--backend=' + asciidoc_html,
+        '--out-file=@OUTPUT@',
+        '@INPUT@',
+      ],
+      input: article,
+      output: fs.stem(article) + '.html',
+      depends: documentation_deps,
+      install: true,
+      install_dir: get_option('datadir') / 'doc/git-doc',
+    )
+  endforeach
+
+  asciidoc_html_options = asciidoc_common_options + [
+    '--backend=' + asciidoc_html,
+    '--out-file=@OUTPUT@',
+    '--attribute', 'git-relative-html-prefix=../',
+    '@INPUT@',
+  ]
+
+  subdir('howto')
+  subdir('technical')
 endif
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..21dfb8b5c9d93490f16c24bab1d49631e0395571
--- /dev/null
+++ b/Documentation/technical/meson.build
@@ -0,0 +1,66 @@
+api_docs = [
+  'api-error-handling.txt',
+  'api-merge.txt',
+  'api-parse-options.txt',
+  'api-simple-ipc.txt',
+  'api-trace2.txt',
+]
+
+articles = [
+  'bitmap-format.txt',
+  'build-systems.txt',
+  'bundle-uri.txt',
+  'commit-graph.txt',
+  'directory-rename-detection.txt',
+  'hash-function-transition.txt',
+  'long-running-process-protocol.txt',
+  'multi-pack-index.txt',
+  'packfile-uri.txt',
+  'pack-heuristics.txt',
+  'parallel-checkout.txt',
+  'partial-clone.txt',
+  'platform-support.txt',
+  'racy-git.txt',
+  'reftable.txt',
+  'remembering-renames.txt',
+  'repository-version.txt',
+  'rerere.txt',
+  'scalar.txt',
+  'send-pack-pipeline.txt',
+  'shallow.txt',
+  'sparse-checkout.txt',
+  'sparse-index.txt',
+  'trivial-merge.txt',
+  'unit-tests.txt',
+]
+
+api_index = custom_target(
+  command: [
+    shell,
+    meson.current_source_dir() / 'api-index.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+  input: api_docs,
+  output: 'api-index.txt',
+)
+
+custom_target(
+  command: asciidoc_html_options,
+  input: api_index,
+  output: 'api-index.html',
+  depends: documentation_deps,
+  install: true,
+  install_dir: get_option('datadir') / 'doc/git-doc/technical',
+)
+
+foreach article : api_docs + articles
+  custom_target(
+    command: asciidoc_html_options,
+    input: article,
+    output: fs.stem(article) + '.html',
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc/technical',
+  )
+endforeach

-- 
2.47.1.668.gf74b3f243a.dirty

