Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDE1D63EF
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864774; cv=none; b=KOMZeYU3wcw73ijAeR3UnCuH1sUPhgGZqsbDdJv3BFzBnCDAoOLAGm157D/L+ZX12+NrChUH3CRZqtNUYomWNDEaq2oQ3DT31IBQ9aeW1HMPDlBM75CzBwa5/HCN/OQalt48LJ2zVqRVKKXkGsK69B30pJVGt8sv1mGtZk7RxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864774; c=relaxed/simple;
	bh=eRwHtFAyoQgcj+0HFEz9Z5Ie6fOL57CVzPz79mUMfQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIVBOW6hk7USx/xVFGywkUQm4YocQFNwTRIYCIevbRxccaZXtKx0uzhw3d+vW7WV9eit/PVMjULuYa3RDMk/hMr+KV2WSVfdWueEO3zaDIxs5JteHY7iVUP8YTSDTwpn6Q80scIQFjMyJKl01zeeS5bHd1/E+uasrAyapAZOhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dFwZ1DU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eX8/jBP9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dFwZ1DU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eX8/jBP9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0FFA11401C3;
	Tue, 18 Feb 2025 02:46:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 02:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864770;
	 x=1739951170; bh=O5Ndf9GhTLLO3WnTfVuD9GBrmIfK/TNghTycdhpEPLk=; b=
	dFwZ1DU4N4zNQw3wBbzaDzJe2NJ6XsztBU9FiqeM0ipkck7kluuCx6LO4Rbmy/sL
	W2OWuIUfAYumxkyt0/+OLSsZdDhAdxSo8JNAMn6+WCLHO2nZYjxWVJPhxrO/Nu2p
	XTqimsN7JrfRREjCNESqgepWzbthwnPawN2wa9bRTBzW/Fk4PISk5e/2GymAooDn
	ftSLsJ5DS+wpg4aYFVoLpFI5WGH8GOysejf87V0mbiTvnKD54mUfKojklFjCd0M7
	dkOFp6naXnIWtd5eQOeqczfJc1b2v3JZAu6VVjXmmS5DTbMMAnByh8hBAqo2I+UW
	Kfk1bLT2ONx7WD91/JUNZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864770; x=
	1739951170; bh=O5Ndf9GhTLLO3WnTfVuD9GBrmIfK/TNghTycdhpEPLk=; b=e
	X8/jBP99Scc/A5t2NMtK9b7AyfpMFjY1LEU1pdDzKHQY8oqPwx0KHuotWCMcAgfl
	6UTvCvKwPWcVb+ktNrjuIVh6GIA+DfpamvdQQg+AVRMQx1X1hr/dLGnnJqWz4TAH
	h9Y5BWqqBL6vpv+pIPwjfezUNc21P/bHZ4xlpwmsubhSu+ESsZMimBQmQWwsy8xd
	KYj4rsxSBwMnnENqtvw+NvVOHryG+Y4jA8gRWc2kVp1iIpVg60cWqjoTyH0OwJ58
	grnkincjMRUmV1mIjHU5j2Te9M3HIsN7ryuFO0H8touQM18lzb5e22newYiYziwA
	qiSE6uqEGed2GL4nuc4Bg==
X-ME-Sender: <xms:wjq0Z6VxvhOLm4eDoIo2Q4TuCrx-SF3a7Ln9EveHEs9MsbXHQlTfAA>
    <xme:wjq0Z2m9QqTNl6MVmEsUb1T1bFapgB6Ja_r2CgNQyRLtsvIMKHh-xzCUes8RLXpqs
    Tt5BRNkLZXG9fRgmA>
X-ME-Received: <xmr:wjq0Z-ZTw4gpZ9eOKKbsMrsA2k8FGMfOoN1tZQlNAMOpSHv5vPKOIvJHHjQyR0B0EilPosiE470-0t9apYs7PjySgNNaDXX9k7LX-9VfxIWSJp9b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wjq0ZxXJdskE5iVmd9b62SYcJTR7tF_gxiXWKVV_GsFDuJB42k1cpw>
    <xmx:wjq0Z0lA3FE3WERRQJque39Fwb18BktTcxf0tYWyZ7KOKvNJCmvlFQ>
    <xmx:wjq0Z2eRu85zEa8MRtAun75qn74enFYsDKrLnXcvlO7_N81Yx91UCA>
    <xmx:wjq0Z2EEEVrchRaxfIt65KSd_O2jVg8GB57dfTweMsQdEzg6BvaTcg>
    <xmx:wjq0Z5ytqbezVQ7hIjpO-pVDOfZK5mQTpjg0SmXv_1z__UGuWIx6Wwyu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 538f93bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:54 +0100
Subject: [PATCH 06/12] meson: wire up credential helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

We've got a couple of credential helpers in "contrib/credential", all
of which aren't yet wired up via Meson. Do so.

Note that ideally, we'd also wire up t0303 to be executed with each of
the credential helpers to verify their functionality. Unfortunately
though, none of them pass the test suite right now, so this is left for
a future change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/libsecret/meson.build   |  9 +++++++++
 contrib/credential/meson.build             |  3 +++
 contrib/credential/netrc/meson.build       | 20 ++++++++++++++++++++
 contrib/credential/osxkeychain/meson.build |  9 +++++++++
 contrib/credential/wincred/meson.build     |  5 +++++
 contrib/meson.build                        |  2 ++
 meson.build                                |  2 +-
 meson_options.txt                          |  2 ++
 8 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/libsecret/meson.build b/contrib/credential/libsecret/meson.build
new file mode 100644
index 00000000000..0137660fe02
--- /dev/null
+++ b/contrib/credential/libsecret/meson.build
@@ -0,0 +1,9 @@
+executable('git-credential-libsecret',
+  sources: 'git-credential-libsecret.c',
+  dependencies: [
+    dependency('glib-2.0'),
+    dependency('libsecret-1'),
+  ],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
diff --git a/contrib/credential/meson.build b/contrib/credential/meson.build
new file mode 100644
index 00000000000..4216296ae05
--- /dev/null
+++ b/contrib/credential/meson.build
@@ -0,0 +1,3 @@
+foreach helper : get_option('credential_helpers')
+  subdir(helper)
+endforeach
diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
new file mode 100644
index 00000000000..a990dbb86da
--- /dev/null
+++ b/contrib/credential/netrc/meson.build
@@ -0,0 +1,20 @@
+credential_netrc = custom_target(
+  input: 'git-credential-netrc.perl',
+  output: 'git-credential-netrc',
+  command: generate_perl_command,
+  depends: [git_version_file],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+credential_netrc_testenv = test_environment
+credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+
+test('t-git-credential-netrc',
+  shell,
+  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
+  workdir: meson.current_source_dir(),
+  env: credential_netrc_testenv,
+  depends: test_dependencies + bin_wrappers + [credential_netrc],
+  timeout: 0,
+)
diff --git a/contrib/credential/osxkeychain/meson.build b/contrib/credential/osxkeychain/meson.build
new file mode 100644
index 00000000000..3c7677f736c
--- /dev/null
+++ b/contrib/credential/osxkeychain/meson.build
@@ -0,0 +1,9 @@
+executable('git-credential-osxkeychain',
+  sources: 'git-credential-osxkeychain.c',
+  dependencies: [
+    dependency('CoreFoundation'),
+    dependency('Security'),
+  ],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
diff --git a/contrib/credential/wincred/meson.build b/contrib/credential/wincred/meson.build
new file mode 100644
index 00000000000..6de23ca17d4
--- /dev/null
+++ b/contrib/credential/wincred/meson.build
@@ -0,0 +1,5 @@
+executable('git-credential-wincred',
+  sources: 'git-credential-wincred.c',
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
diff --git a/contrib/meson.build b/contrib/meson.build
index d74b64a5181..569c23ee768 100644
--- a/contrib/meson.build
+++ b/contrib/meson.build
@@ -1,3 +1,5 @@
 foreach feature : get_option('contrib')
   subdir(feature)
 endforeach
+
+subdir('credential')
diff --git a/meson.build b/meson.build
index d77d7b6b603..20159cef83d 100644
--- a/meson.build
+++ b/meson.build
@@ -771,7 +771,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled()
+if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 
diff --git a/meson_options.txt b/meson_options.txt
index 5c12e9055e6..0b0708dd0ed 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -29,6 +29,8 @@ option('version', type: 'string', value: '',
 # Features supported by Git.
 option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'subtree' ],
   description: 'Contributed features to include.')
+option('credential_helpers', type: 'array', value: [ ], choices: [ 'libsecret', 'netrc', 'osxkeychain', 'wincred' ],
+  description: 'Contributed features to include.')
 option('curl', type: 'feature', value: 'enabled',
   description: 'Build helpers used to access remotes with the HTTP transport.')
 option('expat', type: 'feature', value: 'enabled',

-- 
2.48.1.666.gff9fcf71b7.dirty

