Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D301DF965
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864774; cv=none; b=lg7J3h9md3yKqDW67ic/pGqd4jjqFSS7Q4L2/jpdvY3EmaokBfr78SnzPOnDmjOIWEOgQR0p3OcchBe2EO9ng0YmMUvlU8s9qXLrdjxt+3t+uqWPfpZoztR89rAZm6RBnD91/3E1gLoBLszCFQsfOGPC/NoOQpxwpyCD/woX91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864774; c=relaxed/simple;
	bh=QbjRK/1DOwLrFeiYGDm537TH+qhiEYijV4+Zzwd3G3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6Q+OlqMPx0ALHIFzU2r2Jk1mzXz4KxYZRpNZt+YUsyuRomeici+/nb0gHGO+llu2xUW4ebclcXZtTstT0r390E5QBeMKEnpo2HhnR9XZCfq5WYh6asuZ3nQyPi3TdQVqXXxorDwsL+AFvsZRAmYs2Sf8d2rxSdriKytK27gcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bh5nhrhb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WO9j68KC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bh5nhrhb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WO9j68KC"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 00F5B1380A39;
	Tue, 18 Feb 2025 02:46:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 02:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864771;
	 x=1739951171; bh=Jad/tC30baZfBxEqEbC4wLccM0Z8jZoIj0/JK63ZspE=; b=
	bh5nhrhbXRrTTnit47s+f/yVT0GjHe6bZnMaIg5EWICjw+5yF9zJl0bL2zG/v6ep
	z6JsEl/b3aT7oVuYie8HTe+laj7ZqoY5/SW9rYZyB3HupbGdGtivBQ3XzMV+Gze+
	MWLMvE29oOOpUEfi+81yF0kfeeU2gyUOzvRO5vU2jRi0d70ni5W6I5MaS5J318MM
	lPzuzb+o0CJGajTPzRQQ20ca1mss0kXicZRJxDiEquGiXQ055mS4GS0GlVh3WcBU
	v5rd3dNQ7AvLTXCxMcc2uVUiwYDeRLKSGWopMSaiTmmJR1tEt9vSo6kQ4vcOByZb
	hhozeUeydErQ2PQHtdxHgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864771; x=
	1739951171; bh=Jad/tC30baZfBxEqEbC4wLccM0Z8jZoIj0/JK63ZspE=; b=W
	O9j68KC3mIL2gTvmoI3Q75KQNAZE2xsh/S4AKB3u2MMYp/8IkGV3iekSXuuavSyM
	4X567e8BwxvzBfMYweEfL5vyAnz/s4DCr2xYyPoZpqRHuz9w3NmTA/0dWfRBW8sP
	P7uuR4e+Q/bwnkdL4rjOGDvAsrmpzbuZLvXra7ibUu6WY7UaoBtOXDdYzsKtQwCH
	JAvqeFBarBW7DFz8+c93GCKFHhKfw1SKf/iUlJn9HumK9eOHkT06NHULDDK3+ojS
	OjCG/1LNb5BCzzHrlLPhn2w7IY6vATtfKvYf1xHooIvC4wPaDigVB7bd40riXbp/
	1dJKMgJ6md/3ebJtzO8sQ==
X-ME-Sender: <xms:wzq0Z5X2VATE5i5b2FWkTHhmM70wiCE1Ny8W43kpTZEIMtX3ZYYHaw>
    <xme:wzq0Z5n3CP27KRjWoDPsOGhxSZTlr9LyPm8-tRh_T_CX3uI3NqEXngYgSd2b1GAej
    KYfdenvk3db4WnPlg>
X-ME-Received: <xmr:wzq0Z1Y6sbF-qBLRSXibYPx4jBBvVDnVAn741IUbaV-vAKK4NE67cNgL1yCmEogN9-_H33fNEpHgs4nxh-PuGJlVw19_JCsRf5xVPwRwyUBduHJm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wzq0Z8WGCoNLQCO7VIwVcV7MxoRaB_ANYjS548Ev1U3f7WJtb_G7cQ>
    <xmx:wzq0ZzkkcJCZ4XnTLbvnQtF7e-NMnt93MkeA8d8i3Q5YF9w-wt5vAQ>
    <xmx:wzq0Z5c-vZMWUo8E6g-WsK5UoeowHPRZ4tlNDWMSsCNcel5Zz2OYqg>
    <xmx:wzq0Z9HhoAX7n1T0xXduwy9TmGEKmAdkeb1D-3voxvpNCExA2M9HSg>
    <xmx:wzq0Z4wf_KT1sw0G-jM40O8_fXGkEyJ9ZJMmINHxWzGDaedhXrRzkNe7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c52ca59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:55 +0100
Subject: [PATCH 07/12] meson: wire up git-contacts(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-7-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Wire up the build for git-contacts(1) in Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/contacts/meson.build | 55 ++++++++++++++++++++++++++++++++++++++++++++
 meson_options.txt            |  2 +-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
new file mode 100644
index 00000000000..6ec92f47c43
--- /dev/null
+++ b/contrib/contacts/meson.build
@@ -0,0 +1,55 @@
+custom_target(
+  input: 'git-contacts',
+  output: 'git-contacts',
+  command: generate_perl_command,
+  depends: [git_version_file],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
+if get_option('docs').contains('man')
+  contacts_xml = custom_target(
+    command: asciidoc_common_options + [
+      '--backend=' + asciidoc_docbook,
+      '--doctype=manpage',
+      '--out-file=@OUTPUT@',
+      '@INPUT@',
+    ],
+    depends: documentation_deps,
+    input: 'git-contacts.txt',
+    output: 'git-contacts.xml',
+  )
+
+  custom_target(
+    command: [
+      xmlto,
+      '-m', '@INPUT@',
+      'man',
+      contacts_xml,
+      '-o',
+      meson.current_build_dir(),
+    ] + xmlto_extra,
+    input: [
+      '../../Documentation/manpage-normal.xsl',
+    ],
+    output: 'git-contacts.1',
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
+    input: 'git-contacts.txt',
+    output: 'git-contacts.html',
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+endif
diff --git a/meson_options.txt b/meson_options.txt
index 0b0708dd0ed..c51ba88d853 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,7 +27,7 @@ option('version', type: 'string', value: '',
   description: 'Version string reported by git-version(1) and other tools.')
 
 # Features supported by Git.
-option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'subtree' ],
+option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'contacts', 'subtree' ],
   description: 'Contributed features to include.')
 option('credential_helpers', type: 'array', value: [ ], choices: [ 'libsecret', 'netrc', 'osxkeychain', 'wincred' ],
   description: 'Contributed features to include.')

-- 
2.48.1.666.gff9fcf71b7.dirty

