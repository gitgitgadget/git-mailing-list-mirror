Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B192D837B
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176083; cv=none; b=pejGAPal3gS+oSVIdHhvyTFYumFgFyWZ5gYrObiaRGgw/X6Z7HdEwhNtyENCa2VHrTTGRf19WuTkCBf/nDaE55UoE5FTN7hclzAScZl7BAfa2Dc5qNblZ2t6ZwiKEObrSJgKJnltgLtjQB2SWZpMPoKinxMUdIIxuS0wY+G9n5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176083; c=relaxed/simple;
	bh=Wb2oqI7WbPOyTKqpKW0ZQkJRCyBLOpYWfe02juTM/gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzsaJg8q8V/TQAowidZC6EjkO2xat9+iJPk8CmuqG9M2Ht8HgAiakvOz6fDPbCK9uRpT+HVQVgxaaGu6jb4zNDDLGdQ86bG8C2M++pc5yef9rzwWBhjRgcQqVHD67o6cNrcuJkeopsB8LMhMRAv0o0nHnL12f33/3dd19zwMBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCp+F+tK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4DUAFGW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCp+F+tK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4DUAFGW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 84936EC023A;
	Thu, 18 Sep 2025 02:14:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 02:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758176081;
	 x=1758262481; bh=uRG/2nPcjDnbGZrV1T3XZrFD6txFgZ/s3SBQ3Uc/Wfg=; b=
	nCp+F+tKT2Z/ehIXFoD3PRGz8dB20QFLX3TtUYFcEhX3aJ5nXzgWaGA9J22RrmL9
	KAASpg+hD6RveNwLEcOeXChVnhh62c5M9cVxt/hOzpTMkIzebukw2QLYA7ahOrId
	hQfwICKfiEZYugE0+A4BLCWLLH8bIcST+ksfbeJAes49lCHGaVBN/IhyUG9EnWeF
	gONvYQ2tZhn3Zuog1Bscjob3NFJet2ZexbvtUeVpAmCmD4Kdh1N/vXNuteanFLYG
	0eZCMj8CXH6HYchPlAZ1VweHbYcobQ2O8PT9f+4K+9tJz/jw/wX1gDyw7Y+uxSP5
	qnp4obGkr4F3pA2HIutLhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758176081; x=
	1758262481; bh=uRG/2nPcjDnbGZrV1T3XZrFD6txFgZ/s3SBQ3Uc/Wfg=; b=d
	4DUAFGWKHmpzr31ypm1aPfq4gqb8Ka9WDC2QK71xrgApQN+hRVZEk8tEM9iZWyu9
	/A40sApYnueu4YESvDcdXMqLgjypT+57GNteOoBbg3Oi/+pU3yTTOdjGiF30BfCz
	F/UQiKlbjh8bU4NEX9zigOcwudAD5FKcdBzxtEb7TDJvKE0ngjwyDxQmgljdY3rs
	G97XwJ8BzZV1gkxpNcJVJnbwZcUlQfoMS9dgq4+n5ra80Co/J+dq+kDx6tdx9JjF
	6XOBDf5woK37UTgZ1bjDGLB9+EuSCkcKboLfRDRpWAIihTxQg4QcqjmhIv7Fo8c/
	Q3hIPVIT25vdJAjU7tawA==
X-ME-Sender: <xms:UaPLaE169j9rc1HwTZAzcbyt3xKdpiBPMZYpTEdlv0JP7nsDQPpfIg>
    <xme:UaPLaJpOuaDxcLsWsWH5KVuXdEODLw8yXgHbrR19Y2j1nnlsc5MhxG7HDbovJkhm0
    PV3sqF0VQeCMaQo4A>
X-ME-Received: <xmr:UaPLaJfhnMZ11Z0eBFinUiByULejSuPJOLTnKhyAs1XLEeeFJXaCk1lVHNs1JWCPTKHR4PpEgBsenU6KLAMuMBSCx0kk54O3QHAjuTBJzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UaPLaArt7hnseSa3pGacz0uuNr7nb3ymPsTRtKZn03s3LKE05UaCNg>
    <xmx:UaPLaCE3gDPM7W3p6hMVh7mSAwRR7fKCLAS4S5P-Ivl1o81sXOU4Dw>
    <xmx:UaPLaIsydhdoiFJkIughiwYP7Hc3wi0kKohPJA6BwelqAxD7Xsxmtg>
    <xmx:UaPLaMVNDWwJXH4fXrTrYOqrs1z6P_qD_OqBrSr39b-s2BZiQR3dBg>
    <xmx:UaPLaCFSRhvwF_5_oXi2TuQnNChIeSNI_kXMgqs7-CN-iH8i4xmQShyk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:14:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c236c95 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:14:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Sep 2025 08:14:23 +0200
Subject: [PATCH v3 5/5] builtin/config: do not spawn pager when printing
 color codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pks-config-color-v3-5-08ea618cae26@pks.im>
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
In-Reply-To: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

With `git config get --type=color` the user asks us to parse a specific
configuration key and turn the value into an ANSI color escape sequence.
The printed string can then for example be used as part of shell scripts
to reuse the same colors as Git.

Right now though we set up the auto-pager, which means that the string
may be written to the pager instead of directly to the terminal. This
behaviour is problematic for two reasons:

  - Color codes are meant for direct terminal output; writing them into
    a pager does not seem like a sensible thing to do without additional
    text.

  - It is inconsistent with `git config --get-color`, which never uses a
    pager, despite the fact that we claim `git config get --type=color`
    to be a drop-in replacement in git-config(1).

Fix this by disabling the pager when outputting color sequences.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 3 ++-
 t/t1300-config.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index f50c11df57..6708d91814 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -919,7 +919,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix,
 	location_options_init(&location_opts, prefix);
 	display_options_init(&display_opts);
 
-	setup_auto_pager("config", 1);
+	if (display_opts.type != TYPE_COLOR)
+		setup_auto_pager("config", 1);
 
 	if (url)
 		ret = get_urlmatch(&location_opts, &display_opts, argv[0], url);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 3cf5d17aba..358d636379 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 for mode in legacy subcommands
 do
@@ -1099,6 +1100,14 @@ test_expect_success 'get --type=color with default value only' '
 	test_cmp actual.raw actual-subcommand.raw
 '
 
+test_expect_success TTY 'get --type=color does not use a pager' '
+	test_config core.pager "echo foobar" &&
+	test_terminal git config get --type=color --default="red" "" >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set --type=color' '
 	cat >expect <<\EOF &&
 [foo]

-- 
2.51.0.534.gc79095c0ca.dirty

