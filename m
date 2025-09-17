Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F031A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140815; cv=none; b=jxiMWkZHUT9tti3R3PFw0hDWP9uw2yZQqOlKeaqhoWJNwTqBd3lPRI3heiX38QbYR9eTAw8IrNVOx6XIJ3vqth8q7xghB7qigokQC7wjF8KexVPLnrYvZ2v7jPSVkxgLEkWfuOA+naZQUVf37nEgbGi8iMcr01tMkuToBtu/oC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140815; c=relaxed/simple;
	bh=QLfpYPpuFNuzvQiItmNaXh6C5nUP0JmrtLeS9Rt6sUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlDXiEQ6aO/U8cIcDsLL2BnFrqQxpJrAWmtPilAnTCjPmxqJjAPW11fDm3XJDY+yWHTX2OatBUSlyJoqvFEu7rr49QYm7HCyP+3RWr+oWDiqxQ0Zi/9AHduhUePEYbcShAjoW0m1rVI7O3Z3ZAN7lJ/w8xNL8CafLB+hv2fx0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZcaSwQbn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHzDn3Z3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZcaSwQbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHzDn3Z3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A338AEC027D;
	Wed, 17 Sep 2025 16:26:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Sep 2025 16:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140812;
	 x=1758227212; bh=K8MysWs1FzB2AADFHRc0h8YLLSL4hKp7NyXizq/LvTc=; b=
	ZcaSwQbnXqe01ZkJwDZ09YBElm82gyLSWXL+0lFk3F3Wq6xR3qPg/AkGnH/voA5c
	sVNsdV3fMny+RSoDcQNkVGWDCPwkuunhAA6NZKRnzOXM1KgaJcKIptONkfkvbwo/
	ffgH+NmW3wUk2685EAYYxm1ARc2sj6tB09lS6gEdX4f8OCS3wpOKEzihsDFi6e9F
	c4j4bKwiV5/b0JyvX9rkY/Zcbj+2ntV0WCv5Pa9jMfkycQHCgPfGXsSosRFM1L+2
	mxJMoiHHHIhl+CBdi/GgS5PTdPYmAEGPKrRSjXBJNKGBBvDEzgPFQs2/JS1fpVWN
	tPkQl5RrTbTkAvjxIx7eMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140812; x=
	1758227212; bh=K8MysWs1FzB2AADFHRc0h8YLLSL4hKp7NyXizq/LvTc=; b=b
	HzDn3Z3wEnnA2XwE6sCoJnkGPetKUrzZD8KZ4cgwfaMwaEKIpShGU8FWf1UExwHp
	1Rj5O8Kf3jpUJYWegdnWXbnYbjeLuPIaJpXEBivgyY3Ld2AV+L5j0fuZTSt3IVGj
	I+tYzPQqvnkCHQmZoZw/A45Cmr/3oh/eJ6JoSpuh2x3S0dzaBa/P3DSDJ4tbOgo3
	NazHU0bRUrQLQ6mY4ftcvfODZnIZvI6qWpPXJf/Ljty2FwH3MMdWnBcPLRXPin02
	PrBcQYdPF4hrrg/J1zSLVRNnmV+ZDXt1jcPIqdFwvAviwxGmxQH++MVehC0O2eX8
	AQ/MUSdLuLa49DJTAJDwQ==
X-ME-Sender: <xms:jBnLaNr3Tp_gfHuT05xD3IHSztv48gX78--HmqxG4Jp5NfekeICTj0o>
    <xme:jBnLaIG-CJk0EBythBmVNo5RWjCvChhasEMIJ75xWqhMMZ4g9qh--CxW43f38Vbki
    69B2_pRenz_8YP3BA>
X-ME-Received: <xmr:jBnLaKpyumQmCBtynLbfv6p-pD7YD3JkW6xwenOu8hUjU8B0rzimxDYjo9oVUjEMKnzBKXFQwH8lYeRwhGLV5xMPQgg9J_YpNYY7B2OEVF7RicmhEKiifF5PIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:jBnLaJZdle1c8gCtcY2PGSwnASz0aqDzIXox9NxtJotf0H_M-n2Q-w>
    <xmx:jBnLaLW7JURkRzVRVBXKdaRsHzCPaBL6MJcr630la9WfipQxE2he0g>
    <xmx:jBnLaK8AmvmNG1PAOkdVLBm52zhgbsKGBZ2Fj2bNQo0bnemSRHm5GA>
    <xmx:jBnLaM-IUQWaX_6LZ3KXmMqZ4tggVEO2HbkSYLE8O9JodqUR-tCcXw>
    <xmx:jBnLaGBDBPQsCKRSv5e9GM8KKU4iNTnW4MC0HGHmw8ajqEutsMRFC9x2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:26:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 5/9] t0014: test shadowing of aliases for a sample of builtins
Date: Wed, 17 Sep 2025 22:24:15 +0200
Message-ID: <35764.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added tests for shadowing deprecated builtins.
Let’s make the test suite more complete by exercising a sample of
the builtins and in turn test the documentation for git-config(1):

    To avoid confusion and troubles with script usage, aliases that hide
    existing Git commands are ignored except for deprecated commands.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    Only a sample of builtins since the test file takes about 600ms longer
    if I test all of them.

 t/t0014-alias.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 1b196ed9d6d..07a53e7366e 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -95,4 +95,21 @@ test_expect_success 'can alias-shadow via two deprecated builtins' '
 	test_cmp expect actual
 '
 
+cannot_alias_regular_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail... (see above)
+	test_might_fail git "$cmd" -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'cannot alias-shadow a sample of regular builtins' '
+	for cmd in grep check-ref-format interpret-trailers \
+		checkout-index fast-import diagnose rev-list prune
+	do
+		cannot_alias_regular_builtin "$cmd" || return 1
+	done
+'
+
 test_done
-- 
2.51.0.274.gdcb64e51a0f

