Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4730E0EB
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345964; cv=none; b=UWO/Aely+f/DBo+FqJv84Sr/MBnOKsx6WJBmtl5sfRuwzLn1w+hMJSV3B2lbDz+lIZnd7iV2oIbK90s/dXbyFBomejW+eCPin7epFPxagsMzCZYDhLQAoYBEVCqhs8Ay+LGrfJRZr5pSXeO0HidOJwu1j2V1X8AFb+i2ofJsRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345964; c=relaxed/simple;
	bh=n9bszQEtZv1fmQuEx62loMPpBCuVBgVMy6Vde73kmJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDvAtdEB5OkHDmHwoVnVg72mQkYon7QjOOK5RXRANGG4BToCtoyiAKoe0Qbvmy5H/w7u/dpbTkVQHJitmqmxncg6BfulpGnYgwh8UhTqWJhUYt6xw1uIlO9nYbOaJDunCnrkUB4k14MxTMCaHYtShBdXGAk/EYgICNMtPZ/tt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LB6K87Ac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=afO6tJ1G; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LB6K87Ac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="afO6tJ1G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D224AEC021B;
	Mon,  8 Sep 2025 11:39:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 11:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345960;
	 x=1757432360; bh=Zr2ODWmc76hMQxIPH5ERbz3j7M4JuqLFoQHkUu8IwQM=; b=
	LB6K87Ac7VjEe0a/34Xmw3sqYqSIOMwz0oW+s5SvibNZkr+s5gzopbZtB5yZ7xui
	+tEESYDtU/AgbyEHsHUoOu/oe7S5kFmHOUm6sDUS2Xrf07ZRxKY9QbWHNBSDM9+h
	+rsK2Axec1Rv0CS0IgQobt9nqab8nuaH43mepLJ7Eq0+aK/tiNDrlO3CrpD+qMG7
	SRb2u02xzkMFLTJpd16zDM6hxR+96dHdlBpLVylU5L7OIpykthTIg2Ojhr+Oi9bu
	jzbeZXCE+0fD6DEXEFwZD15Ov3hw1zZId1cj64tULIxjgyshNKPot4K1tOMiKMx2
	QOmGHjHt1wZ8WKhXHoox9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345960; x=
	1757432360; bh=Zr2ODWmc76hMQxIPH5ERbz3j7M4JuqLFoQHkUu8IwQM=; b=a
	fO6tJ1G4fw8jxC/Jv6gChGrbXaGgtlOdKcu1naO06NAr+4cKLPNz4FYUI3Fyy2Af
	/hLUZrNcJy0oiB8JR1NnPbt2bPLOkIlBKyvwR/5HgMpDXzy5St2HxEUz49n2UaUT
	11xrSwQmsKuN1YqoP175iW/4rMBCAN4vynjlptohnWCtiLyHwlkVAUgDahnvhjyL
	JQkrg54sYfb8YSOn+krqRyEqkhV7PKwLo8+HTaIpxHNWCnTt7rs5obKKCeJnllTF
	OvXVhMQMeJIRIU5DaRnlB4lJQGV2klaVNLWrqemBw2cEEQZbKqhjBxjnSvOG0mQR
	ME2tc5PiAkEbXlBbDMJbQ==
X-ME-Sender: <xms:qPi-aCejf8vx2VoC3_dwnCG3brJ56Sxhh8XS6FavN7rZ85XG_oLJJjc>
    <xme:qPi-aGyPy_kvz-U2TOmsc-7dcQ9k_jsuYybIVp7q0A7-5R179vCtvvYAA3x5lskWp
    rzAPE_EFcPgjduI1w>
X-ME-Received: <xmr:qPi-aAEnN_d-Xt4FYhcH6nVuI7MRvRG0FvrI5VaO8ra5FJ_IkGq1wrkHdN64-96mWTkb4GG443pD5j_1svwJrc1jVQ1Flfv-hWKoSEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:qPi-aCy3s0_8QDAFJ_bYect_eLVJLkwlxJTAk70kbs1RSEBdeUA9-A>
    <xmx:qPi-aJvTPLnhdVTX4mQxLSzMboU6fmrJZXFrunt5_jh_Bx3pW4AbXQ>
    <xmx:qPi-aH1u0ol9JSZ24jwm9Q1NdD3G-HtYnqdxVpzuUXnzgYz0Xqi61A>
    <xmx:qPi-aM8_RhqPZnhDq3U32NEPeWA1hePiqUUoN-2DSifhWqpbC00Ngg>
    <xmx:qPi-aBs7kGzf7KkxfjNZDAGRZH7ueZcSUwbRXWkAWKFgF31HMEA2fDLZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:39:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 4/8] t0014: test shadowing of aliases for a sample of builtins
Date: Mon,  8 Sep 2025 17:36:15 +0200
Message-ID: <80fb02caeebae82650cae91fd5bb291bc630ac02.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added a test for shadowing deprecated builtins.
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
index 89bedb9f73b..bf7e6512bb1 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -72,4 +72,21 @@ test_expect_success 'can alias-shadow deprecated builtins' '
 	done
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
2.51.0.16.gcd94ab5bf81

