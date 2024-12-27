Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD01F543E
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308014; cv=none; b=opEpkKOc/YaN7BOgwKLL3eTbyfd5/3ClznDohWx/vb8VUDJDiZAy1F2o3XvIIgp8Lc/K55JS6SZtQWTsNyPaywijMh7xRK9Ahxtz3i3axc6Ot64BrAUptTz70xp3vx1U1A2tl9krbbrTXZLFYQq97NMhHqhh/IB7JVhSXOfniQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308014; c=relaxed/simple;
	bh=MgtouUHWLAFkTaTypVMONKA+Lu+uiCIFeD1BbIZUuRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+3qlTRLpJEk7yf4d9G9P1X3aa+i7rsKkTCwps/bJihQU+ftpi4o3Sx/rZ0ogGGkdHBg5d4UNthrAnT2M23sB0GWe73lTfDMEOcwVYtCUS0fbgdTM3ogW322/K86iMkAcP82klS0X5bL6SjHmtW0XptBpIGRFk4XIr2Q9QTIjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6kRY7yV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXDDYV/1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6kRY7yV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXDDYV/1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4796511400D9;
	Fri, 27 Dec 2024 09:00:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Dec 2024 09:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308011;
	 x=1735394411; bh=pA/tEZouwzeFS8H31m6JiPrx/NMCJV+f3clzQrznJ84=; b=
	i6kRY7yVU3z6IZUwBTGxt0ah7bqQ8Nmxhjl7y+/OcJP9nn194vadR+TxsWq+9isS
	1sycC6fZSSI9S3H9GDpwhbpwRIJgVBe58iOrEYVMn50b0/H4K+M6AzoeFzXv3yMO
	33KQng/r3EskL0SoHQqxMpaCL42wWUgoRYUyfvTEvxH0zhagRyAKz0a+I2s7OedJ
	kOokQH5d3IqFkLaUOURj/hihw8UQcSmzNKVCQAzTq2YYHybpDxlRTSbwUtnUXkOt
	42qbQu1RDxYhe63d6nOCovaguXEa1YS2qz1OZsvwxTJ5J4fEHPIhcLsliwWYsFA/
	PIpwRKLfQsWFnQQTr8ik1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308011; x=
	1735394411; bh=pA/tEZouwzeFS8H31m6JiPrx/NMCJV+f3clzQrznJ84=; b=w
	XDDYV/1zfClCN1wGWYYUvVS7YnyGiIqVfLSkP+diGwVMhz6zHdbOwsLGt9KxJphc
	vkXzUZbmSuzxb0O+tfyczIuhEBTLBrEEQEhAakP6OmoCaN9sJe/z9Wy3lcOEy1wp
	v3ga7L5AqU7+upuF6WKfVuT17aqG2l1Fna2OWnki5vodKm26CFi91HppvKEqQhDH
	g0ANho2KbRKsNOz2HtFef3cbHG68PeAgqXsQnuNGNyRhvr9bDB5+YJwCMNwssDa9
	/As0IP7ouuMLF8CWZn5vymB/yqBVufVQ/1mO6TDuj/2cV2iTLtQ5Lz+rb48PBrPR
	xydAETqCzAf/b8TIYFNuQ==
X-ME-Sender: <xms:6rJuZ0qASfQkKjUkO-1yHz7TQuEL_kEcUxN-68ynOABduTiWBU2WTA>
    <xme:6rJuZ6o3vMQHCmfhsPqliSqj3P4M7FloPGenROgInVBPpCIMP7qZCgQiz676np17W
    nCvgI_wUU6IiPuYhg>
X-ME-Received: <xmr:6rJuZ5PHPpL7Jv2HjRx7v4SfiSj-Avwot0QzUI5YlXJIjB-E6CDadYCwZB9TNvqFooVKsBfzeKvUmzq6jLm-aGSbzUKPZrQ2asv5Q0X3l0qXMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6rJuZ753cGbE3nXMq-d7L_dQZn1xk7IUgzXOdQuaCSCY1xKWaWGGgA>
    <xmx:6rJuZz504wwK3kzL0NdTWS8IxovcFBw1fvYtmjHbyykXGgz6pu4FrA>
    <xmx:6rJuZ7jOVkX2xmdNeqnrxeG1KH8WSbv3ri2f_UHWUx-Wsi2wQ4LcQw>
    <xmx:6rJuZ97l7BezuO0O8ljrIMKSeeRJGXr9gKaaUvKD1o5StbpBMqos3Q>
    <xmx:67JuZzGLRfqbVWOZORWMvA-gjMVtgvy2RGK3zCOXpisNz56IewupulMf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04fc0262 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:37 +0100
Subject: [PATCH v2 09/12] meson: generate articles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-9-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
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
index 404cb20d10a2fbbe4e014bd8a7df74c49dad40a7..8c6ff0bce1206d988cc0d3b7997fa0f338d01194 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -413,4 +413,40 @@ if get_option('docs').contains('html')
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
2.48.0.rc0.311.gb6c66824c1.dirty

