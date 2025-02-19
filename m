Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B41D8DFE
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970849; cv=none; b=s+nOXGj7vVp/a0jCsBd7oJKGmiix9kMKeD1qR0pLrZLbSq+vpufRwQ24Og4F7W09FWPyuRB9WIbL/6phs6QUSQLE3KNtz3LZJunWZ5FNS852D/2tx09pMZx/rj2TaQ9ZxTiMkyc+iiViJcxs5YMWEJHipKIy7UjR+ve4Q0cOdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970849; c=relaxed/simple;
	bh=QbjRK/1DOwLrFeiYGDm537TH+qhiEYijV4+Zzwd3G3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNNoFC/ONd417DVJkjlY1RlPua3UuqTV8jwzC6wJQbJa3/kYLyqtYtn3jE7rGb48A/pvPMkZqQ8STWUHEC19dap9JakXNMa21W2/HJaw6iDWCh/oDX4EdBvc25bjkgP97aIRnz4S0Xfcz/7hyISxYdEdmn/WvDtNVqHeZLMLUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RhcMtunx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pI9LDlVq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RhcMtunx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pI9LDlVq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F8A7114012B;
	Wed, 19 Feb 2025 08:14:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 08:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970846;
	 x=1740057246; bh=Jad/tC30baZfBxEqEbC4wLccM0Z8jZoIj0/JK63ZspE=; b=
	RhcMtunxXBLlnES3fjyuyu8IjAC+cYv9L6DQGc/4QjMa+pB5TsgokMZm9idLvRiq
	4oY6BC04bzuPUmI+5vqAOJU6H3+jbc/SJVsJF5m6r1PFPIK4QJAtaS2x0R2jQJzT
	fZMQR7w7evMC39HfKJDh5kDycBOD58CctNjjOBPDiHMa3fn/6MYJ+Qvuut55UuZT
	uFurFyxax9c2GVQXFrIWfrNAoG9PR10yGv2u87jt/fZ4A6mOOABVtF0NAT7gNKNa
	Pl2TbKBP7yDhGSU2VyrXFMux+SXXnrBGaPhGgkNxRQfHo3/UVocwQl7SXdw4p4Ip
	vRT92H8FKJcs/QoubAWhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970846; x=
	1740057246; bh=Jad/tC30baZfBxEqEbC4wLccM0Z8jZoIj0/JK63ZspE=; b=p
	I9LDlVqkfJ/jMQYGvKkkJzfEXknrZdZLgCWE5FXzNLVgsFZ5riSTxGrmLZJD2J0k
	dJZnT3a6ba3fxdt3Rq/lkjb+MzMANjJfWbxIvAA+2u7fsfulGAtzuCbfU//tNGFE
	ugC0+/TX0YYuc6F1xRasF8SKlkWo2Ye5G44KD2K/CshaBGfe3Xm3IAT/GGoPsrpv
	IeHCie0VOhY8E6c8RC3ScuEwemYFfpMhR3a2vGowX9aEBIv2eg4WGpJnRRq+4/lw
	YBDr9pxcBL9RNgTlBMCbuON9AEhVuInsacNoF2vD8UU/whiWfaONaARoVfF4/yRq
	mcbx1V/DI4ZLDSwScZP0g==
X-ME-Sender: <xms:Htm1Z45J90IbGoTTTi-wZhTfI9Z6bShwB6dcDtGL_vfToM4pzumiLw>
    <xme:Htm1Z54BPurFUWiDgdbdCVXMBCuFufeqr4kwUnduPnHJymzbV7fojIF_0Im70ct1u
    uMYiMWkqlW42nKfYQ>
X-ME-Received: <xmr:Htm1Z3f84urKplDLZloBEfQLC06g0meYsQaYU550u71UthO1-LU2Vr-3ClnoBZnLJc91MYjBiu_-1zD3VKFgkOqoW6XelECaTdzLWdoAAC5slmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhg
X-ME-Proxy: <xmx:Htm1Z9LUDya5K3Ii42xHEFsYPvjG9MgXPwbIAcmWtOOD3NdaJewbNQ>
    <xmx:Htm1Z8INzvdA0Woo-Ho8jQw06NVZbpNxY64Gst0ldU0pnez6Fn5mXQ>
    <xmx:Htm1Z-zD1g40AHFDo_dlRnHFjSAhDLvKw6CKqWEEdyntKWEdBwAIwA>
    <xmx:Htm1ZwIFpf3ZHKEDDalnOSlr_yFj_xgv3mqdt4jMNOYyU79UFLtP2w>
    <xmx:Htm1ZxFynXyOLXoyhD5Tgx6GapwLeBdhWXPWFEVngYjwKOL9x8Ca5icO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c2e9ae8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:47 +0100
Subject: [PATCH v2 07/10] meson: wire up git-contacts(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-7-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
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

