Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68F1DFE05
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864776; cv=none; b=HUuJxz0e8hqXbgwQ5blBg6TXD8JMygjhvl4tiGCgzbrGMifJPJjS1Nn6LOBHgo+giF98dr06Kqu//CG9OdwV6PQ97VkcxWEYXUD736lqMI4nEmfw+vL6H4Q6VvlXmlaTFFJObHV+QpCDrhWJTO7bDMqf/TvLHFHUXLEOg0K3Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864776; c=relaxed/simple;
	bh=qzdMW9gLlKaqx1xxvrWg1RkxK5ZHtE/bxz5+sc8QZaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNpcJaXC5Y/jycQ33AGnEZyXYDXEar1cZq2Z/hXhinDXDL26hRJRXaMshqq0x9tNDkI4kaxNh/SLO3Hy87UMedMb4V0p112pifs+HeJ8piKLC9PjsOio7zG6jDtt4x1IBgR+4M/bH1dgkKsquLr/GxqP/RaYb4CWW6sKQ4DKeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ou+Q737M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFEVv2Li; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ou+Q737M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFEVv2Li"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 073BE1380A33;
	Tue, 18 Feb 2025 02:46:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 02:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864773;
	 x=1739951173; bh=T9IDSvj5n+6tVrr9QXGJWliWfYWCq2leEg7Ebkv5F20=; b=
	ou+Q737MnZKUEhfwIJqGIP5sKaLy8t3Umq8wR0qpf76KLpnT4E5WzTQTWJ6iv3zq
	ZluYxEYwpjiJN/AyrnkuOwM8hemJmVLcMw6rMoeSdSzjFLJ4OpwcA6m1jw3iFZaJ
	xAgJubRxpKXzAqNmhfnv7GuHNxZvfi/gs3LHEF5p+6WxzDTHIXRtlVl+1OgX+08X
	i1mN+gfPZGFC4r4Y60YdqT5iaWQlodQzXAHT+SWR9vX8TQzmKiOj2BTPFqi0awvM
	vzRF5MKX5tPQTgFtZZjL6P55Hn36imujDO0McVXz5UdF9Ewp2XfJebkVd84ri+Sx
	Fp9+VQMOUY0vYS5LYZ60MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864773; x=
	1739951173; bh=T9IDSvj5n+6tVrr9QXGJWliWfYWCq2leEg7Ebkv5F20=; b=X
	FEVv2Li4gotdcxBqcLbzfKL06YaxMQIq5EFTuU9h6vAApMjB5vNhCl1iJHrHkqsO
	H8gq08Xun8veBxEfc77PpfGOrP6BoyXzFkhFlreJHL6K2BSpVSBSWv/YlcmZsLzq
	k/QXlKGlCosR5nMHymTQJqLtU6rwYbGzckZDVKeDOVbv6Gy6nShpBgXxmvEkIIJE
	YwYxWEwvzz1N6b9wDUbCtuP9ZYrjclXGHSB6Q8tvKcocqWyxeKwdU70q05drqEEf
	R/sWUV7gxT5dPA6i6H+RDDY0Ms+NtdoTleaa5fVCY8AvvNBeUTrlKd0gCD3U6pWn
	BU81fGyVisg5C8NnsbD/Q==
X-ME-Sender: <xms:xDq0Z5UiHv2vNanzle16oKj2anQqhe6RICwgWHiv3Kvwxq6mQujh3g>
    <xme:xDq0Z5mzODjY-81o2YFORUDRD-RMy7a6Agr83HjkZPG9EQtOZdLRCK70HYIqXF3o7
    YrYCA0lBCeleK1UNg>
X-ME-Received: <xmr:xDq0Z1ZG7BfHA2sEEXNKioPlp_JuRaLqa9vobU6t5r8Rtmk3YXs-6C8L1SaB2nMauVmN6EaUm0CRFmDCSZ-cVNGou2J0SNDMksFdaH5A7v7JSLff>
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
X-ME-Proxy: <xmx:xDq0Z8Wi9ibNBE0WJYKio0CpU6ilYmkkFezFyPaK4zllM2SwY5OmgQ>
    <xmx:xDq0ZzkQIE2OQ-Rah6DRrEfR1CgM5_kZMopkEZ-Zi2qtCFUayxz88g>
    <xmx:xDq0Z5e6rIhNKTFVIUTdwv-VmMKH_IwH0ztGI34v0yR9VR63fBP-Cw>
    <xmx:xDq0Z9GtAMlLPd3cstd7tAQQQyjKtMVrfWPyUDIqU3W-bvfYjm0gwA>
    <xmx:xDq0Z4yLPVeRRTGWYCZuDcoHd0HoyZFH-E3J5qLc3T2XaUJeAghhtGCc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8639e6ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:56 +0100
Subject: [PATCH 08/12] meson: wire up static analysis via Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-8-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Wire up static analysis via Coccinelle via a new test target
"coccicheck". This target can be executed via `meson compile coccicheck`
and generates the semantic patch for us.

Note that we don't hardcode the list of source and header files that
shall be analyzed, and instead use git-ls-files(1) to find them for us.
This is because we also want to analyze files that may not get built on
the current platform, so finding all sources at configure time is easier
than introducing a new variable that tracks all sources, including those
which aren't being built.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/coccinelle/meson.build | 89 ++++++++++++++++++++++++++++++++++++++++++
 contrib/meson.build            |  1 +
 meson_options.txt              |  2 +
 3 files changed, 92 insertions(+)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
new file mode 100644
index 00000000000..5d76a7fee6f
--- /dev/null
+++ b/contrib/coccinelle/meson.build
@@ -0,0 +1,89 @@
+spatch = find_program('spatch', required: get_option('coccinelle'))
+if not spatch.found()
+  subdir_done()
+endif
+
+third_party_sources = [
+  ':!contrib',
+  ':!compat/inet_ntop.c',
+  ':!compat/inet_pton.c',
+  ':!compat/nedmalloc',
+  ':!compat/obstack.*',
+  ':!compat/poll',
+  ':!compat/regex',
+  ':!sha1collisiondetection',
+  ':!sha1dc',
+  ':!t/unit-tests/clar',
+  ':!t/unit-tests/clar',
+  ':!t/t[0-9][0-9][0-9][0-9]*',
+]
+
+rules = [
+  'array.cocci',
+  'commit.cocci',
+  'config_fn_ctx.pending.cocci',
+  'equals-null.cocci',
+  'flex_alloc.cocci',
+  'free.cocci',
+  'git_config_number.cocci',
+  'hashmap.cocci',
+  'index-compatibility.cocci',
+  'object_id.cocci',
+  'preincr.cocci',
+  'qsort.cocci',
+  'refs.cocci',
+  'strbuf.cocci',
+  'swap.cocci',
+  'the_repository.cocci',
+  'xcalloc.cocci',
+  'xopen.cocci',
+  'xstrdup_or_null.cocci',
+  'xstrncmpz.cocci',
+]
+
+concatenated_rules = custom_target(
+  command: [
+    'cat', '@INPUT@',
+  ],
+  input: rules,
+  output: 'rules.cocci',
+  capture: true,
+)
+
+sources = [ ]
+foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
+  sources += source
+endforeach
+
+headers = [ ]
+foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+  headers += meson.project_source_root() / header
+endforeach
+
+patches = [ ]
+foreach source : sources
+  patches += custom_target(
+    command: [
+      spatch,
+      '--all-includes',
+      '--sp-file', concatenated_rules,
+      '--patch', meson.project_source_root(),
+      '@INPUT@',
+    ],
+    input: meson.project_source_root() / source,
+    output: source.underscorify() + '.patch',
+    capture: true,
+    depend_files: headers,
+  )
+endforeach
+
+concatenated_patch = custom_target(
+  command: [
+    'cat', '@INPUT@',
+  ],
+  input: patches,
+  output: 'cocci.patch',
+  capture: true,
+)
+
+alias_target('coccicheck', concatenated_patch)
diff --git a/contrib/meson.build b/contrib/meson.build
index 569c23ee768..a88c5dfe09e 100644
--- a/contrib/meson.build
+++ b/contrib/meson.build
@@ -2,4 +2,5 @@ foreach feature : get_option('contrib')
   subdir(feature)
 endforeach
 
+subdir('coccinelle')
 subdir('credential')
diff --git a/meson_options.txt b/meson_options.txt
index c51ba88d853..afa908d6c53 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,6 +101,8 @@ option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
   description: 'Which backend to use to generate documentation.')
 
 # Testing.
+option('coccinelle', type: 'feature', value: 'auto',
+  description: 'Provide a coccicheck target that generates a Coccinelle patch.')
 option('tests', type: 'boolean', value: true,
   description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
 option('test_output_directory', type: 'string',

-- 
2.48.1.666.gff9fcf71b7.dirty

