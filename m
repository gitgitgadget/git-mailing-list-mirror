Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A81E5B65
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970848; cv=none; b=cV29dD7tKbIoFq1QuOzIF/rgUrm5ZMXI8shmxRK09Euu+ylJa7fEPeqQaH0lBieNAN4F/H6nhYjzRZlDZLI08EMOO4BarmvBqzct2F/b5uu8qNmAEEMfuDBK7yqrTE5DwHuzQWKGjiqoPPRDk+vfFYPsaNngIKiY5IQTu0iKi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970848; c=relaxed/simple;
	bh=eRwHtFAyoQgcj+0HFEz9Z5Ie6fOL57CVzPz79mUMfQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJYHI37b0BHXJ5yvIgViBD1HHD3Na/merw/kDO3Nv+oQyAx+0xMS0CxTJTbpArgJAOSSZ4zzCUW6NlTN14KZyZGnUNEANhcUkq4rF76ApqFTEeMor+hq6FCvJaZV9MALywr7Kf8ayk+dahqL6OfR3SbFh5PDiOgDYsLTYTsQASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1BGrpIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wEU35cep; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1BGrpIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wEU35cep"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FB9A25401FD;
	Wed, 19 Feb 2025 08:14:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Feb 2025 08:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970846;
	 x=1740057246; bh=O5Ndf9GhTLLO3WnTfVuD9GBrmIfK/TNghTycdhpEPLk=; b=
	D1BGrpIyx0AD0XwdBPrZW+FxZI1kzI0+aHHFnnHBPVjoSMIlJ4i5kTTv6EELikEN
	Xhtc/B2KK5/QIGHjhxqhLymuOQUqLAY8WGlNjCvLVH4VsSM8p9H/SkIirlgkQlgQ
	G8Ynq8CV7+lGSCJ5Hno+eINIW5BQJf08Twc2caAHR1E74XRQxXxLcN3EkUllYNj0
	YyTIDZXtvGNwe9qZ/oy3D1hrlLTkjg3heIR7qeu2oS8l2aGIubvLw0PvpcFxrQHa
	ffWrZT2O/sI/VkNGozBjNiAUJJuCHrnLGIMPuJeSvscb8zxF+y9Gi0y1JOrYM27I
	1UUr13UtoqT/bnNouqXT1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970846; x=
	1740057246; bh=O5Ndf9GhTLLO3WnTfVuD9GBrmIfK/TNghTycdhpEPLk=; b=w
	EU35ceplAXK4wYIcU7uemvcQ/TUw/neyE54kVR/7It3Kkx3SgtJbc9gFRjVJuMRL
	nOANYOdsUTm4bMnka/eeHLsS1QlncwfbZXY8uhEk+5cm+9taFbbByHSrxEYAfgOy
	//Q1+h6Znrh7IcR3aAmqv/z0oBND/pPcgUr80yMI7g5iNwNYrgpNBDvEUiYaRPiy
	VxLFXwyg6iebqnbKxDeeGCw2C548dqwr9vo9pfetfL3QambnEhQWlgzg2s0va27e
	nw1M4I68DmA9asQ0EzlUy/cJUdrWfqTPbFHQqqnyIdvnH6662weoQkMUrrqmob7r
	Q2E5YU6115Kx+CyTdcq4g==
X-ME-Sender: <xms:Hdm1Z3uMupTmLgDC-4LvsYENWElEt3pn924s1QqwmOlnfP_SPSRvmA>
    <xme:Hdm1Z4du_mADrS7qKErriPcrhcrf8ScloVYVsOWzmWFUOCfbk3X5AuMQpP37AKrer
    SPI7vtGS04gMmx-nw>
X-ME-Received: <xmr:Hdm1Z6yxdtHJCiXoheUIrYkrFBZGA-hdQm5hIGFmg3oH6anPX7eYTo-dsvyU827UGYfl9AXSlK8KVPOQCmgW9Ny4vWbW6M__54Pzzduh4xt1u7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehmihhrthhhrdhh
    ihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:Hdm1Z2OanQpD1HJR_oZvyQ5BZ_tcWHukyQx74yYT7nkTSYr-bxpKmg>
    <xmx:Htm1Z39yV4f9tAO7isd6xXFyIXp4-J6AUU2pdQbbmd_FjJnOqhCckA>
    <xmx:Htm1Z2V2FGG46seMhG04ziMfRl_6Mjx3cOcm_1cEH-EgVZis1yxLgw>
    <xmx:Htm1Z4e4zuWnMV3IJqCfnFJa0vdPPc-7jfVDxCoR1W-am70UuTIgKA>
    <xmx:Htm1ZzYxtt1EiP6qSSaI0SL8wwIsiLEeBHj4viTHUdzMfwbho0GOeRPi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ff3b217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:46 +0100
Subject: [PATCH v2 06/10] meson: wire up credential helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-6-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
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

