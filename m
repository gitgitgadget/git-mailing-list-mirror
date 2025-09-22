Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034F309DDF
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546401; cv=none; b=dewjmvjkGOU03Xj2CZEYUOHCXRKIWjkHl8V9GI/+AZEfmcgfx6IP2Kl3ot4pGd7wwpYS9kos1yfhFjO2SiafYlQ3WGfCVY347y+b5N2jAlv47IHDkP0GgBSiU8iK9N1zgIYS/wou0CadHxA1An1TB86m9pALm79/7XRMFpMetqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546401; c=relaxed/simple;
	bh=OeMYtNlVAF6oupZlf7v9kPD7pP6NNaFOsOVv1LcrYEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0EbeTt3bUPCfY81J7F24gPU1nbGcOxVytXoC5AIXt9pAYDXdbjb/Gl1fZKklhculatCOvCqjlUVieyMzWUg5UkEUECyUOgErjJ+S8VXLkC/3sz4j1q4AQbY3BOQebxg9KHuRR7dqHAilk7mkgxwiJXCqMTRhkm71wF+w9cyOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+GdF6Ir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/QxwXj3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+GdF6Ir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/QxwXj3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AC9B91D0021B;
	Mon, 22 Sep 2025 09:06:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 09:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546398;
	 x=1758632798; bh=fa2WB85H7chQhpgUN7gZLkS9unNiSDfaB526QSXCzMM=; b=
	E+GdF6Ir6iHe0fxDMEI3GjhtOLBylfHiThRKycQRTrFzF5LyDpw/b1fFdxL6e/fA
	Oq1BJmUpW4bUT097We5YX5ZcEbv3gNa063Ws6SJ1yshBhkvMXRFfzqVo7acg1Tac
	aKzES4K7NMbpL08DtmT3LL3yNYcUpaf+33oX6OWEjImokH41SVh9e/U0tVzzIhaM
	Y3h2IgTSAtIzjWRkuQwVmfKLiG7HtqJ/RhVqBEeBnqeA+/iSxmeFq+XibCNbq8D2
	SENQ+c9mrS648Ka9WC6Nzlv5IUf9J5fYx03ltBn8qJBvB5TVcu9lZESncg5ZBRjx
	NG+dbUN+/GuNGzK4lgGxRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546398; x=
	1758632798; bh=fa2WB85H7chQhpgUN7gZLkS9unNiSDfaB526QSXCzMM=; b=b
	/QxwXj37XLHdfMfL/xFItuVBHAkDKHr97pzVM3MV9CWYHzJtY1XkGaj1L2Asd07l
	Sv62ZP5nrRJwnvORZ445zBubG3X+ShJnl8cDwjYocbxgeltXtUpknwwWq+vMOvV1
	hJvvs8C0kVVmVkLuRKoq3e8riLxywY26VhfFt/PZrC3HRgNP6QlnbUrbw8zhHEXl
	/XAsWJOJuI99l2SVxKHLZUQomuyGk40gRsvLn8DlTmgN/h+8Ai00AGuyiHJ2slUG
	Xnl1dd+F3IPco1aB1mNsNjXBU9OkFz/I4aMUl7OCUMBnrgiFtc3q+W/TE7K9TJhs
	X5P4d5pQUH2E2QF5yWQHA==
X-ME-Sender: <xms:3knRaNCxvdKykbt1ACej3FcYMuBwUIAFsg3v3ry5jo5jCOREUwcBZg>
    <xme:3knRaGGjL-JyOEKi4PONOd3AnSv1BjPwVhrDoL_nbHo8aMx--6_v8LKFRhx8-itb4
    qgKe6VMO3T0RFCafw>
X-ME-Received: <xmr:3knRaFLEna87aNdgaRuLBTWY75L6iWam0bpqvmaQzSu-d77m7uHn_MjvX76vGywbwsu0pSDwK2t-ntZhJKp7qhUO-vHB3p32c9jHBnYZgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3knRaKl4Z0n_5e0rASf16iWJ_eUu_sFQeBdCxyNuQji1au-C5_v2Vw>
    <xmx:3knRaNSD2E_gOVzDI0Fdy2-9RWZeEYuaj-7gL-5YariPaSPqR1bPCg>
    <xmx:3knRaMKs-2zTQoAcfDH4BTAvu0W7Xtg1QQMDudyZdrhB8ICyThc69g>
    <xmx:3knRaDDBYx6bS_sbQknj7eJ9zelTiUsIOzFGYYQLsuzoODXxOcpbCQ>
    <xmx:3knRaJzMnMsjtB2omX0PLO64vZCgj4_dFWevfSJgtCK8El-1Bz8AMvnh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:06:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8d4ac84 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:06:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Sep 2025 15:06:22 +0200
Subject: [PATCH v4 5/5] builtin/config: do not spawn pager when printing
 color codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pks-config-color-v4-5-28b7d2697eed@pks.im>
References: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
In-Reply-To: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
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
2.51.0.536.g15c5d4f767.dirty

