Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD11E8350
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970850; cv=none; b=gZw0vSTkyOU661KbejFXxUhTeWb0YXyxKZezFNJiO/Z1OEZeRVlKdtFz8XhjsjqZibE+F9Lf6Sn10ARKc087CxQMSa2BJHbJE8yCaQNXDtK+r+vSTigqK4JZGq73oRFj/wyqn9h4u17zUfHb7FV+/928sTz4eRd0dZ//d8Vn/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970850; c=relaxed/simple;
	bh=qzdMW9gLlKaqx1xxvrWg1RkxK5ZHtE/bxz5+sc8QZaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFT+nOw5fVuxrNbckoNJlFRKAmEWCxMiPw57zasGb+6RoNlJxdAEx1f849Eco3YaUSJii+Lrs+gvFrJljSaC/0nl0t0cvOhTgGXAQ3NzF2/Qy+giKkfTAwpESjPZ1deoQMBFW1z6uzzQa5oaJY/ueoS0qLVByN39oTjM90INVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qWe2OiHY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTh5NIJ3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qWe2OiHY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTh5NIJ3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6E2425401CD;
	Wed, 19 Feb 2025 08:14:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 08:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970847;
	 x=1740057247; bh=T9IDSvj5n+6tVrr9QXGJWliWfYWCq2leEg7Ebkv5F20=; b=
	qWe2OiHYKMG7HhWU0iPQZf26UAwBozIKDn2X008FXZNT2t8dvfDE/gZmf0SSu1gj
	oae7iARWiAUJjqSPYpMron43IzLSsJCrKqJLmzF7xw1uil3GRVJSNh4kyvCerY55
	HrpHJL7r4TXvG94ldTwjA+Kd3cESX/8FGYvrd/R+Jn3LfKei1BzAkZcJSdYEBbUr
	F8bopcD8ieffv55OWNCfTHOHfg0L98deZqzTlFp+2JcQboLZZTdViTu2x97KMaCZ
	4XUsCj09LjMURTkQ2caK7vi9DZkyI6/peeUlvETXtf2Hz9ot3SzXF+CZioNhg/yn
	ClbFUhHZSj2KomVzAD+dUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970847; x=
	1740057247; bh=T9IDSvj5n+6tVrr9QXGJWliWfYWCq2leEg7Ebkv5F20=; b=j
	Th5NIJ3Kh/I4cmCmPCRWMKSdWPxdh1qTCT+uS99aV8G83tDbuy+WssF/RUi2BZo0
	SdItA/JBsyCloeBQTWZS4SBAv8B2/hThP1ZylRv8CAlEbTVS1lbBSBpQIC619pGE
	UEVaAH6duNW8KScF8oEE6NGxX5vUE5oQlChaa/Q/ATFCIwzL9VGuIhqoCCCBep9F
	L5AJh5jpHDFnDM2Dx8JkZ7gzeCgxNBgC+cxAk0i30cfCOxtQfaXgnIvSBgNukTzz
	5v2DdujT9GzlwoA/OqtxsykwZX9zZpkSOLCl6AvqYpD/dRiinqhyXfrHTIcZT2eT
	u/09zFRGYaWpBKIHSCNfw==
X-ME-Sender: <xms:H9m1Z5iPtDadetrFQ7tbEv2bs05VPF4LTo89Dz4dZbGNpORHAf6lgw>
    <xme:H9m1Z-DP-fsOolooQC0f74gOQYmIoksD1ZD1J9Y2XQ0TQgOgI7x4CtTYQvQ8vioZl
    AEyAgYuUHe5QFfQew>
X-ME-Received: <xmr:H9m1Z5EaAZQ3VKh4S8rgsgHXUae2KznKyfaKhuheXffOKgA_pIsG1HEu5samRUVUBhCeF_ShsrQXi7YtgwSFJz3BtFufxP_2Vt6_02jLMjvXaUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhg
X-ME-Proxy: <xmx:H9m1Z-QB5oKnWcRsYHv2Z7oeapmynKJI64BqzaMbg9LCaR6USzmCMg>
    <xmx:H9m1Z2xqFRR9Rc1L5-UldZLCmssH-Mzy-lookaJaiYJa1-pb2srlag>
    <xmx:H9m1Z070MQ_t9nOFMx6lbDZyKA1i9AJd3sNqi1XycSoMsi57C37Z-g>
    <xmx:H9m1Z7yqSKhYysrGYiunDWXL6422uB8kSGxK-boWMWswq5-459EtRQ>
    <xmx:H9m1ZwtVhpmbbwuguakd1WsgoRxaWbyoOWsdZ9yecocr0lBJZad4Y6AP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97c11290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:48 +0100
Subject: [PATCH v2 08/10] meson: wire up static analysis via Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-8-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
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

