Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117A2D9492
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176080; cv=none; b=Q8utqFxLHlDKxGAHxxdZgJMb7ZRwxLvbr2xdoscb1F5ofpTB6Pdy4Fi8/6PuPeMos0m2nsj7H7U7aht3HImGjaDeyx930QW/eYM0rP0AdiPVwGtW8JKoU+xEItVqh2asHjFERKJGzLLQwapf7Lz0tfXODc6mQ1iiGtl7SP1Dp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176080; c=relaxed/simple;
	bh=wIe51EuS3TTb2fZribw15fpokc9xHkrGnKzv69+uKbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbJtq1m/7ufDKQSRGZLSEtsoEtRkkx5ksag/1G7014YijGAtifABAndhQxxiwSw27bhX/wV3W6acwo/2M0yUYX+lOE7sOmAtC5AMnGuwADbZbpyrK/2Xka6LZ7Ybv54S+Abw5bHZTBBPOTdpIPeL3in+52+spG9Tj6df7ubcZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j82cQgSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iONtnKi0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j82cQgSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iONtnKi0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 584B0EC027E;
	Thu, 18 Sep 2025 02:14:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 02:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758176078;
	 x=1758262478; bh=E74KNJWgwGrnjYLmXKEUTDNk1Ka2AqiefmPQNzF5zp4=; b=
	j82cQgSqSCb+texLVjEnToWU2NqnbG9Ssg+i23xEQ4UE9kc6oiYd/oGzfOLYtsr6
	N37sGHwVC3Bfp448PowCJAQqTWOSTsmR31CXGHB5AHaPtkYDTAcJlepZzSeDBTNV
	wBNXrdX44WOGlSBvzqLJZNOvsUqu4s5jERJFdhrptmhwX4+vdA4WlLhNMHoxbXFE
	XOgDOCZl7dfw0k7Q7ERrRK+nilSl5S4EoxEWYLxY5VtAjH77U/G6Y+N2Qn+53VIN
	qNzY/7FPhRvkcqpTKbavDVhFGh99yaSIBFAjpYx/MdHnMQCAlVcDyKY+CgdL1LxY
	yTfP4Io6OYowsnh+fHNFOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758176078; x=
	1758262478; bh=E74KNJWgwGrnjYLmXKEUTDNk1Ka2AqiefmPQNzF5zp4=; b=i
	ONtnKi01sx0Ep2D61FfhIfZ8DGsySs7FxOCULR1jFBbxHEQdOtj8el+Q1WjMwJ0b
	ycgBjYdO+dM9/pbpuHj11cyEVbLToN6ClY5hblb2JthmBiOaXLVbADMCZ+ve/Ybh
	g/p5+dfetqdl/4RcivCM/SReHjZXm0haTip6LILbFBqP4ARm2L/uEAfXazp8C8gE
	tOuN8HamjsAEd9IbRIpZ7yJaZNDWV/qd+idzpJBpNNMib9UXBOLATOKB7uMquxG3
	YEXja8xjQlhR1pff//yT/4tjgiaWXw9yckcR5DMdkpitkiHM1yXWi2LvW7kUOwiq
	roPTy1xYofCMvRdI11mBA==
X-ME-Sender: <xms:TqPLaOmAOsfJ1uAbw3cwCK13HxdrXS3kKx-4eV3sOF8n08nVels8cw>
    <xme:TqPLaAZHcLYyO1ff2NL9g6F3SWAntkxJKF-4l7DqioctfIk13tHIcVMKM3MrzUuZM
    wnO9bVdXOK_BQpB9w>
X-ME-Received: <xmr:TqPLaJOvRRQzt3ud_PAvm2IGhpVsUA9SHyqKBkBCPzRYn7Z5zd5pDw28NrkO38dg9RE2pMrBHB2FuoDHBtp67WSPxr3EnwlZDveY9ry4Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TqPLaFYJL0BEWbwtVKQ7I4mecQHc7F30pKosvYBq2-5cHiIWEfDsbw>
    <xmx:TqPLaH2LSBS1-txLd1N6THVDLJ3Cni6u6Bn-P_rt16T6BqnVJEKpgg>
    <xmx:TqPLaLfFXFXbqdwVMTnj4NgDZ7e-EtV-hoGFf3gV3CKSPM7naUv_-Q>
    <xmx:TqPLaIF_A8RkqZwTyHn0dps0nlJa8E2t-kODpnNKYNCKVAsJmqlInA>
    <xmx:TqPLaB3zQcPSsXzJ4BZC-SqrCegcSs2PFhy-KuSPJ1IdhdCQLm8WEPZ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:14:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d47a418 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:14:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Sep 2025 08:14:22 +0200
Subject: [PATCH v3 4/5] builtin/config: special-case retrieving colors
 without a key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-pks-config-color-v3-4-08ea618cae26@pks.im>
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
In-Reply-To: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Our documentation for git-config(1) has a section where it explains how
to parse and use colors as Git would configure them. In order to get the
ANSI color escape sequence to reset the colors to normal we recommend
the following command:

    $ git config get --type=color --default="reset" ""

This command is not supposed to parse any configuration keys. Instead,
it is expected to parse the "reset" default value and turn it into a
proper ANSI color escape sequence.

It was reported though [1] that this command doesn't work:

    $ git config get --type=color --default="reset" ""
    error: key does not contain a section:

This error was introduced in 4e51389000 (builtin/config: introduce "get"
subcommand, 2024-05-06), where we introduced the "get" subcommand to
retrieve configuration values. The preimage of that commit used `git
config --get-color "" "reset"` instead, which still works.

This use case is really quite specific to parsing colors, as it wouldn't
make sense to give git-config(1) a default value and an empty config key
only to return that default value unmodified. But with `--type=color` we
don't return the value directly; we instead parse the value into an ANSI
escape sequence.

As such, we can easily special-case this one use case:

    - If the provided config key is empty;

    - the user is asking for a color code and the user; and

    - the user has provided a default value,

then we call `get_color()` directly. Do so to make the documented
command work as expected.

[1]: <aI+oQvQgnNtC6DVw@szeder.dev>

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  |  2 ++
 t/t1300-config.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index afd48bfa51..f50c11df57 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -923,6 +923,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix,
 
 	if (url)
 		ret = get_urlmatch(&location_opts, &display_opts, argv[0], url);
+	else if (display_opts.type == TYPE_COLOR && !strlen(argv[0]) && display_opts.default_value)
+		ret = get_color(&location_opts, "", display_opts.default_value);
 	else
 		ret = get_value(&location_opts, &display_opts, argv[0], value_pattern,
 				get_value_flags, flags);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 6d1015acfd..3cf5d17aba 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1083,11 +1083,22 @@ test_expect_success 'get --type=color' '
 	rm .git/config &&
 	git config ${mode_set} foo.color "red" &&
 	git config --get --type=color foo.color >actual.raw &&
+	git config get --type=color foo.color >actual-subcommand.raw &&
+	test_cmp actual.raw actual-subcommand.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'get --type=color with default value only' '
+	git config --get-color "" "red" >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual &&
+	git config get --type=color --default="red" "" >actual-subcommand.raw &&
+	test_cmp actual.raw actual-subcommand.raw
+'
+
 test_expect_success 'set --type=color' '
 	cat >expect <<\EOF &&
 [foo]

-- 
2.51.0.534.gc79095c0ca.dirty

