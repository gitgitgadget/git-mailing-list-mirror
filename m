Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EE3CA4B3
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390487; cv=none; b=B/xmN+eolyw+kAGx74B16GO9tfxg+v2lCAGZV7de2DHRbGNBNkxRMcNndYLQcxOJdXMPrwUUuDXb+5X7zWaYiWm5h05holiDslaHOc1z2GWUt5+yFzHD/fszkDbU6sg47y7ilaM2mPZvXFd+xn3pFC5+tIF+cVwrE/Pihp50jUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390487; c=relaxed/simple;
	bh=R1bvVu7Gcv4nxqxRQPKh75MSpzpkJ06hNIBGTJO9W7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VeGVMrPGtDs7YaXRc7JEazpq/IrhH02E2md9AfrRoVwVJWsIBnU26/qZhkKyhZPEJfm8MuCcMnIuTmHNpQyR2jZWSafpno0ZGN9IXyNsIDtwvcCJAc1K5iVSCttCdlQpnYUXv9aTf0gkC1W2oxkIsjFiyd2RiLTPsNGSTBjIKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qpiuF7f5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hz9DRWcC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qpiuF7f5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hz9DRWcC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2ABA97A009D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 04:54:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 04:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780390482;
	 x=1780476882; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=
	qpiuF7f5DyDb6IebH0GTJOxCrNWHE20/c/C0rSb8x3WfrrAmcYDHZsabg6WWNl8u
	hEjSTaUERz4fAK/YXBNBqeVwUG1Osy0L3jTJGAR4r5pT2CS71xm7ZOM1UFtEVvGj
	diobXKEsgq7FAQSkjtEwR8YFVqEJRaFVdrOS618T/4LDdYlKRG8KyeV/kM4oLvd1
	g3ZMdspokhQtUovLDIQ5dYi/1p7oBQ2KYqMfz0paFZ9/9gGdKlGAKwchx6PWyEdk
	AeRUQGWDYOcu9PVtPT10dq2Jc5UnKV939JAFxEkcJXcrz43K/Vtb/5uane7jXCQs
	KC5xjUW41Jx7bFRUF14F4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780390482; x=
	1780476882; bh=zxG8UBm2SAFJT0t/UvTPOEauJkAxh7EAF0/EnOA0Uko=; b=h
	z9DRWcCVUZz/2z6wea2ocOqjKU6zO7kmMhaNV8AlwsEDAbI6tiYUbMaSUyFUIUgU
	+PofWCp56cA8+ZNUdO0DOa4R4f36DmaHlgX5ZCNZnRQ2ZX6W9/Z9jjJp8a3UnDGf
	Ea/DlAgZ+xkUr+/hIZHoy+x8Dgpkm4A+xYlqrTCZiWJTTq1PyDR0dVCChPW2jVwD
	GFUh7VC5YDeznVIxtiSOocehgaVNxYCluY/kFXXwTIDCWh2a8OrUc510CCZi/6SK
	w+2iPmjmXUsYFSEHghminOeBgGLmKdDcCQsQBjTjJCk7lng+lt0pWagGwZIqlbFA
	BmQpP05auqNWJCyiNJXzw==
X-ME-Sender: <xms:UZoeai-K5ghkJpXrbtd6g3OLaf-b2F3ZXrKiZdojoz-QUxEiGEmrxQ>
    <xme:UZoeapokQ7ZkTXKaDZtmK0YVOX8DN0-4oy4oTBd1lq1n6xHwQblhYII9bSvltyjZt
    WTnmb_mj8YTgkQrIVtmvzq3V9qLQCb5VUpZe57HvBQOsqBinbu2BA>
X-ME-Received: <xmr:UZoeatpck7N3lNGf5KeLEnb3xAbm44SxX6SPgfpQHP-BoQLotCz0z40_1h1m_Ifx3BLP3EiyAJAdB7mugJirZj0UFouvNQg2OQ4wRSQqEw>
X-ME-Proxy-Cause: dmFkZTFObxYlVnFrfDjl1pjMtZoye17DDwE19JVDq3HgvLa94nXp1TbR86yXeu2T8wDaAM
    mqayEjEmRQgi4OPc4IZKGtl9G2cyeqIzlgKoc45okwE0rcTJmMXkL2cSGClKtzjnkz6akY
    caLr9WHuE+YHg5Cfjn9Y2NIF3axhugbUIxNmGklOeFuo+CQTeBdmDLvJNph05J3iJcsuKp
    b/D7p1tKuJZTNEiGnaCIyaqUwAiI0bmru+zkcl1xc3kzFLTa/DJTEhiTmrDKLG3Fqsu7Bi
    D8omAQtc44Mv+z7FmOMsodQlgXtBtN1cNQUIfcx4nNZbUCldelduW7hpul2bUkgPb/8chF
    f0cUfxiuZBk+Fs3+fesVis6fuKtOq5odPbuKdunRa1oZly752YRDdUsSPyj9KguzacNik2
    5q+BW+0YmuHZUg0q4/UgK24+2zwE+r0Hx+1vezyPaN7uObc8rfDY0pGahIOUSvvXzW5Pos
    Wl+zqDcIngWXMrS4Wk5g56cwmI81NhZJxmcaZrMQAPfPT0CBl1uE4YUWGpQuKInyl6JG93
    Gn0fYGQGJCQQiip4QCiJTVEXMr/FKGvoCbSKVvEo/+cMYMiVSLrxTIZuntFyy7148om/AC
    g6ppnZpbup8XqnpFKy0C0+0583OHX4MzyifuWH4d0uBesUz8VL+4oOfiTBAg
X-ME-Proxy: <xmx:UZoeavnll-h0bmKqAokfhNBGMYeKXF7ibl7WgChUAtwR531vNgsMJw>
    <xmx:UZoeanGW-xFiNHt4Al_Bx7uFCA9CkGPr3fPvF2q29yFZOB7VEn7cLw>
    <xmx:UZoeagqBHyFXsZ043liVP5zdxdEDJyIKsRkLDscaz1YlGsYzbWxaYg>
    <xmx:UZoear72jxh3K9mLVvB9PATy0LroPMgzGPHP00kC5mS_JIR_pefVSw>
    <xmx:UpoeaqulJTXmVPT3WcwtFLya8rw9K1oKY1N2ugLlAJ4_GY3SLAC3XxE4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Jun 2026 04:54:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b00a7a6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Jun 2026 08:54:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 10:54:30 +0200
Subject: [PATCH 4/4] t: let prove fail when parsing invalid TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-t7527-fix-tap-output-v1-4-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

To make the result of our tests accessible we use the TAP protocol. This
protocol is parsed by either prove or by Meson. Unfortunately, these two
tools differ when it comes to their strictness when parsing the
protocol:

  - Prove by default happily accepts lines not specified by the
    protocol.

  - Meson will also accept such lines, but prints a big and ugly warning
    message.

We have fixed our test suite in the past to not print invalid TAP lines
anymore via b1dc2e796e (Merge branch 'ps/meson-tap-parse', 2025-06-17).
But as none of our tools perform a strict check it's still possible for
broken tests to sneak back in, like for example in 362f69547f (Merge
branch 'ps/t1006-tap-fix', 2025-07-16). This doesn't hurt at all when
using prove, but it's quite annoying when using Meson due to the
generated warnings.

Unfortunately, there doesn't seem to be a portable way to make all tools
complain about violations of the TAP format. The TAP 14 specification
has added pragmas to the protocol that would allow us to say `pragma
+strict`, and the effect of that would be to treat invalid TAP lines as
a test failure. But the release of TAP 14 is still rather recent, and
Test-Harness for example only gained support for it in version 3.48,
which was released in 2023.

In fact though, this pragma was already introduced as an inofficial
extension of the TAP protocol with Test-Harness 3.10, released in 2008.
So while not all tools understand the pragma, at least prove does for a
long time.

Unconditionally enable the pragma when using prove so that we'll detect
tests that emit broken TAP output right away. This would have detected
the issues fixed in preceding commits:

    $ prove t7527-builtin-fsmonitor.sh
    t7527-builtin-fsmonitor.sh .. All 69 subtests passed
            (less 6 skipped subtests: 63 okay)

    Test Summary Report
    -------------------
    t7527-builtin-fsmonitor.sh (Wstat: 0 Tests: 69 Failed: 0)
      Parse errors: Unknown TAP token: "Initialized empty Git repository in /tmp/git/test_fsmonitor_smoke/.git/"

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d1d24c4124..ceefb99bff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1532,6 +1532,12 @@ then
 	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
 fi
 
+if test -n "$HARNESS_ACTIVE"
+then
+	say "TAP version 13"
+	say "pragma +strict"
+fi
+
 # Are we running this test at all?
 remove_trash=
 this_test=${0##*/}

-- 
2.54.0.1064.gd145956f57.dirty

