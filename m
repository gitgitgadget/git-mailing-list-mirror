Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D23595F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990731; cv=none; b=XxQuDo9zsYoek57+Ej671llWIS0dQVsK0DiLLTvb3//FaVWQiqVT+BPNOk/pK1xSoOx8+1IQ3nyS/jajf6hmzge9hI6YkD7HdzHkwhv1Uh7YZSPkH7SaIz4sp/2buec8GtuMX3ZmxdyUVjoOo4ZSV/UjEo1gXfDNQgaM3fPV3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990731; c=relaxed/simple;
	bh=L86UTu8HZyrq9X1pkKU4X7tx7u2818HWV1OJYnrsEL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwwnYZtR+Q8w5hE7FGN1X1ZPJQMFPEM7BF3Mf1wKRGfX4wsUCN0Uq+9iL3d0mLC7A6G6Rc4DJXSxXtakmJ+Wq+M4HAW+lAaQm0IbwIC45NNh4enMmJA4oxBpmlbqbWH72TYwkve/udplfn23/OAhe6N0BCEjfxBP81CyXUHZrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EvBifBg0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vor6WkHf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EvBifBg0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vor6WkHf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28DDB114010A;
	Wed, 15 Jan 2025 20:25:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 20:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990729; x=
	1737077129; bh=5dN9r93SEL7Y5cYHWJA8XRvyi+eov6aLFS11jRLS4KQ=; b=E
	vBifBg0HWr2IJuxbTPMHPEv9O4rdXcPgjBTXvP9ElHFbM6nHRiKEd9c9ZLl8bKkl
	XKqB99LQrcF3TaMVB+U/2+FYJw/luMt9eg63GubO941D4Uh+KnlBHeMRumF1vAo4
	ukaicpy5G7DU8jHxJDMMIEYfz0ywzWXyY38l2Ryh/ld0updnnO52VXqnqUjWlURP
	s1gRdNf1gHPfFLQQiAFDcDuSqk0PnaonlG9HwyDGVnp+Cd6722OY/n9CM8MwD9E2
	8eWgwMACRF7rqRQT1P3FEszvkYH8jvhHxeKtr6zb03kg1a2jKQZpvhWrJCl1BYBe
	aRlV1thq5gEdL1RyTxvRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736990729; x=1737077129; bh=5
	dN9r93SEL7Y5cYHWJA8XRvyi+eov6aLFS11jRLS4KQ=; b=Vor6WkHfAjpa/hyOC
	yUfxkNli7A06L49jx1QH5qlzkqGN6hFVfGhmdZIkHPnKF4IG9/zXaQ0JQNC4r2r5
	w7lXu+bXO0slwg8Lt3JrAzFzmzwEDfsqkQ4CHIvOYyUgSQK3a9fF458wDqF95iYi
	KRMIA1Cwkpk8Y/KaHzAP4c8363X2Bia1rs9RQfqZSAE1e8eppuFa48qd7sZXz8+x
	xY1yIGDm+HEZFVxba6f56v2JdCx3sfJoKV32KjZZiCrojzI83EtPSADHsob0ENxb
	Dn0fzXfZM9m/xR7vYVk/IgvV10/tvG9pLlr6fE0I+tQC6sk3C1ZGpnIMh+L1SNcQ
	qGp/g==
X-ME-Sender: <xms:CGCIZ9aQ4ZSNUMC0BJCy4A-aNKFAqVpt40Pf8WMoliw0UXOEG9lLIg>
    <xme:CGCIZ0YLaW1F9ywVpfTDtVa31y2PyGZp4EOqBsKPF1-DfsHxB8Vr6QDoByyiurezG
    n8t_NHKqNOTbkHefg>
X-ME-Received: <xmr:CGCIZ_8IwwVEfHlN8rYKNoIogAo6P8X1s4DaiQmoyWun14Ctv-2OygGJGPc4C1a8IL8iNeU8XCkwNAEWmQrM4nfuOsnBZZ_bMfh1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvff
    elhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:CWCIZ7paF2CR1EX1OgMOWW6KSkAD6QzTBR0xSG53B4vw-B6s6fWmRQ>
    <xmx:CWCIZ4qBMBEHagJOZ_7fhSpn7pVZbsHIvswhS9YfEoXlv7Xkjx1yCA>
    <xmx:CWCIZxTAJ36nyxZrTcFbuWKFM15lDoHdOqVuoP0DClvWRoAgrw3iug>
    <xmx:CWCIZwpSjEoVBthkgLty4AB2y7Wq6IspmZUoQQqFJbPp0QV-Gw4DrQ>
    <xmx:CWCIZzWU-Acr8U8eXHuGcXhW48WCHmHvgWn9EGWX52zrx9i5eaK3eqmZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v3 2/6] t0012: optionally check that "-h" output goes to stdout
Date: Wed, 15 Jan 2025 17:25:19 -0800
Message-ID: <20250116012524.1557441-3-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

For most commands, "git foo -h" will send the help output to stdout, as
this is what parse-options.c does. But some commands send it to stderr
instead. This is usually because they call usage_with_options(), and
should be switched to show_usage_help_and_exit_if_asked().

Currently t0012 is permissive and allows either behavior. We'd like it
to eventually enforce that help goes to stdout, and teaching it to do so
identifies the commands that need to be changed. But during the
transition period, we don't want to enforce that for most test runs.

So let's introduce a flag that will let most test runs use the
permissive behavior, and people interested in converting commands can
run:

  GIT_TEST_HELP_MUST_BE_STDOUT=1 ./t0012-help.sh

to see the failures. Eventually (when all builtins have been converted)
we'll remove this flag entirely and always check the strict behavior.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0012-help.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c2..9c7ae9fd36 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -255,9 +255,16 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+			test_expect_code 129 git -C sub $builtin -h >output 2>err
 		) &&
-		test_grep usage output
+		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
+		then
+			test_must_be_empty err &&
+			test_grep usage output
+		else
+			test_grep usage output ||
+			test_grep usage err
+		fi
 	'
 done <builtins
 
-- 
2.48.1-191-gafe818080f

