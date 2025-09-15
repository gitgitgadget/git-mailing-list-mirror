Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210430EF87
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940791; cv=none; b=rPhTSN0gHWMW2kYBEGCisWaoECUsARoIkaoL2G8lkSOjWK/W1asLNOsH6ODsKmJpLaXKo1ypyU4xY6KberYjF1OnTf0jTGGKnX21sq/nPUbM24r6Pi3RqqGRmO/OLjlk+dyNZeK3WcUXKRcWnsYhxmar/dNprXCLokHTPoKIMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940791; c=relaxed/simple;
	bh=LFLOzEjSb780rTfp/1v1VSq0abMY0adOlRd9QxgOF4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Abojhx71tFqgAv2NFBFabUodA0SIzbBY6/uXwrazGggQ2ge7Iwdop6vAmEhAKQ//3zAMP2dPgP4aMoHgNFhky7neejE0hXTJeNXg/jVUmGFq4kfCamqNMseCc22I8YtFA6Zlnfe3mD06zGXAEFJNUKfJvNGnXwCOyaQX+r2Ym8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j2TBqjqV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YR42ocBk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j2TBqjqV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YR42ocBk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFF3A14001D1;
	Mon, 15 Sep 2025 08:53:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 08:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940788;
	 x=1758027188; bh=hzPQs10QBVCmx1cPd0wH3TcJR+notJ1ZKr/XW/AC/r8=; b=
	j2TBqjqVeQiIEhH8OnWdwuh8bkASBm6olpXQvTDX+EdJdSqx9VSuVbyecKhw4BTn
	MCD9WkdWic4o1mhX7iqjOgS06XGmeTwULNAQwviECqKY4Rt7Zic97eOWJkNQxETb
	7st+BLBMV0jmXz6dQ4Nhprx/ySvBoj1XhvwP/c3U0OtDw5UbST9p9OqkKmFRBdUx
	ljB3vYcTvc0gyy8CSCY4uwIMM55nQwvwuzitubD/GKzyfd8lQgTTFYVR8TNOdPLP
	ny3/mNZvt1VyRY9qMihH6ebk/Ap+MRmwxUXBsieYOsXpUJ2biabjHS+M0TlT0sNR
	5DwYmU51QMCUE2cCAop1Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940788; x=
	1758027188; bh=hzPQs10QBVCmx1cPd0wH3TcJR+notJ1ZKr/XW/AC/r8=; b=Y
	R42ocBk8xbfTtIZHmgZESWjxbAHmaHNK1twKYJh0ozQZxEdGTtvPwFWqFjnHjnmQ
	IN8bUGSw3pPsz67STsueeQTOwWwDtRXGDga1LUbO+BxVTkp/cjeI+gj/oLhIpwfQ
	7moIoZ/uSIpQnhk1oJC4z5WXRwRSDFIrSVlZxB/8M8kl0r8f+SwK39SbwggWwsj/
	2CFyOSeNpj+l/GfGkddWgkx0GOjVxc+dDRyOcYgj+7FyoGqNM2FaNd5ER3NOOcim
	zCsL2SBPD71972p84UwyT+TtqDQ+avMqwgVpfogE/5hOXuGneZLqSIjyjVN5S2v+
	zeFxKX0dKgV/UrrJpukhg==
X-ME-Sender: <xms:NAzIaNPhZE1rGL-VhH128skHnshR5auQJyabb0Gbpnu8Em9doCB32Q>
    <xme:NAzIaKjGRS1BS3Ia6kBDfk0U4coBu8l3jW4FlsvZX10vS8KaPAS4Aoirw7f8LlHk4
    XlEiymlXTy6eECEYw>
X-ME-Received: <xmr:NAzIaI2TMKM0bdqQDP_T5QXnUz63Ya5jsz9jEVGOewzW5xb_vOnpgMCnvCcNbX-Y8OtJOmMWAXgJhPjhgYp6CcG_eHx1uWuKYB36bFyrQHJ7LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NAzIaMi2fBnJwtszIur3O5kV-TSR7F2cTzu9sMNb2pAeNyMk9-byDg>
    <xmx:NAzIaAfRRyUj7aXmd0LgRQNu7cF244OgSCz39G0q-Oof4-G3D7rlXA>
    <xmx:NAzIaHldv7G1M1SEcdFGErn5rZaRINtJ6eZWqhfZ9hBU-Ut1qERZPA>
    <xmx:NAzIaBtpLtGqEOoJJ60QA6YsSC94TraVDGN8ioPr7OSVL-KCtf4ZIQ>
    <xmx:NAzIaJfT-fp9DoIqT7haohdQg2upJn6apBpQtqnR4Ll7X1JCMuR4C6uF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:53:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00f450cc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:53:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 14:52:52 +0200
Subject: [PATCH v2 5/5] builtin/config: do not spawn pager when printing
 color codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pks-config-color-v2-5-e4290bd8d13c@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
In-Reply-To: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
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
may instead be written to the pager command. This is of course quite
nonsensical; there shouldn't be any use case where the color code should
end up in the pager instead of in the TTY.

Fix this by disabling the pager in case the user is asking us to print
color sequences.

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
2.51.0.450.g87641ccf93.dirty

