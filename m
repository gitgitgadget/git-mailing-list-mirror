Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF53803DF
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258970; cv=none; b=rrOTukeKg15vaNxOGcKx9HP+Gb6x3GM2fGoEzW7l7UnQIiG8h2McsH3w3SpQw3jHWNVLLrKe5LMieTCq2/2zNoreXlsZEVqnbrJLZMQbSzRSryJABOBfEHwMFMtXtIChzMVwPEorzCXxJqIQxyS6/6tsBJs3UVQNHTSnvzvDKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258970; c=relaxed/simple;
	bh=zMDeSbi3CP7sM0xJHH2J49letC6CvjbeOeD+3v7Glfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKRSiu4V1sbrgSfeM9wRgF8qWJuQB+V2A+NmLteeWoo8soV7StzFmBoTQIzuDEuT9ZsNmCNgldXgfiisQTGNEp8Q+fwddTc4W9RB0ed6M5kkEy7DMg3YMfc/LYVJ24xuW3qugB87cRpLXwiG7F1VIZSDesi/uOocYCUY2Xlfs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y4ofgNL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7snQMwt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y4ofgNL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7snQMwt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 61AA61D000DB;
	Thu, 24 Sep 2026 10:09:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258968;
	 x=1790345368; bh=hdnX0xh2yIrk7XGTh8VjzbWA00KR2iH9pWIhovASHAY=; b=
	y4ofgNL+0ewlzMTXbiiIpQaNnmcPdTcSLvKBffP1s1y2Vu4sJ2WikILWf9vSJWzu
	vpBLbBbpF4EWBbMjjDRA5yRs1cAwcd8GP7FdI3puBxF+B+O9m1tKtLt/s0W0QP5K
	ClxbBoi1g9kUTYr2keKrs+NjRWpsJ40myANLtFzOFWp7HBEgTICoWLQqIT1VEO+d
	Jv8oDu9aahIjGMJSg4SA0nej3qPIeHumlx2YIJB+a93uzlIT6K4OKZQRKEW+9EUf
	4LNlePaejIylj0q/0crUCn7LdtVefZL9aX3YOqiK3msPQj/rJ1ooajlnCtIAQINY
	SFtJZ/ojHnyCX5/3jc16xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258968; x=
	1790345368; bh=hdnX0xh2yIrk7XGTh8VjzbWA00KR2iH9pWIhovASHAY=; b=Z
	7snQMwt3TDmAeiMH/wrl/w7ZuwGdr903izMyAUN/4rbAF9Ftoj19nlc1G3+eh2LC
	AttzBurhNsfj1qve2uXAXDU4If1CXpCCCahPtzD6pGsYL+U8D7VXhxWEahZUg1jH
	smD9V3sq7iP1XR8QZxb9ATrNWvU77Z9wG1ttqsntLv6jm0NProAjo9vUiKWM4fnJ
	mIhAv1i1nMtIpVUbvuTUmOlQqHTIgo/Rx+iqTGXd3yDOni1LCeo+6vu9Fdn5zmAP
	RYhtvfJPM097HyvSygAfl9PCnbUiJ2yjHnwGdAvHWjL3zxc2DfIM+RUwTpvAHSpd
	2Ovf9lU9bdm2LPYLfDI2Q==
X-ME-Sender: <xms:GC-1ahZcA0K-eozjpuFWMlirNkzm_1qvpv6nBzeABgtEFu5KNcggXA>
    <xme:GC-1auaYBfF1ibAfk3DhTmZNImUwB52DtApnX4YgcvGk12U24voTMX-5EwbTrVEJp
    wxGMuzm7lW06JW3ybsC7iyVHgdeY_s6pEEf3c5RYof8WVS8FJuIYo8>
X-ME-Received: <xmr:GC-1ahm0EUPEQD0zkyV1Q5B20CL4i3PO3xGmL02rCjoVu5_me94hdaFH9-yMloJGSZ_0ltU>
X-ME-Proxy-Cause: dmFkZTFtQE+DlqvF0lQbqprxNhHky+kluS0f31ID+eJQAOtW/ApPXZMwtEnm8b0s8Tz4zr
    2HcXZm4c1v0YwalfW7U7SogxguwgM7rzDq/2LSkXoKX2t8t4lcVOPYevkW4fNZe7D93O65
    rhKzP8wO2wEax1l3oSxntOmmMY0qqKhziMosLsZe0iuZ5mzyq7HLrvtcTYuPrgnDEnO7fM
    q6thSnkJiuXPsY/PFM+frscD7TgJFW3Dr7VrZgIJEWqGqHnNlRxsfIZW+8Eh4SmLar8TSt
    iCT+WmRuLtirP6ElGCe7B6h/GmMAPk7nc9DjRQbvsANHU21xAlnVYxzY3JetyAgfQsFNAd
    /8Ngb9ky7VkHa1+n+mOAXE080zyy5cDLNkQa+b3xS5qJhHbBqMgT6pbEId/LrjSPg8DS8z
    Glt1cQvrM9iBMiD1dZKjcF/YHBeYhUpN/fd0ARenflY8idH2dbBcTSNKxzf+9vLqFDIXHh
    tZ6iIE8i4xTiCMmHoua4MtQrXIVPtJKdnK38hSJWhGx2m5IpIlGspSyu2S1AmHipx2lQoG
    z0oFYM47MEoLQtqxcg1o+LVWX/e2gat0telqxDKX1eyPbBLrFt5AxeHicbkEYN2Z9i0YrK
    8Xa7FVVg83MR1z7oyqwFc4aFhAC0tytZETxyW6BwFkyouoKxpZBuuAZ3eOHg
X-ME-Proxy: <xmx:GC-1aqxtPlM-EG0yGtGeFO_ileD8pKEt0aLt5KylUQv1RqF7_VSo9Q>
    <xmx:GC-1avO3c7R3g6_CuKJIhfq1vn1dGqwIf-B68-3NVk-mHMuM2kx12A>
    <xmx:GC-1auSPJbh5JY71yAmAZ8EOezRlvU_taWiys76OGBA0EEdqOq4J4Q>
    <xmx:GC-1atbOCWHgdIShIG4BsnxbCp6d61pKvPeG7AoGQ4v72vNIJLy5MQ>
    <xmx:GC-1ar_1uyPq1XFif3y5S7_IN6d1aOPew7olNjqSmLinB1QdxWZFmFuz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c57023d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:13 +0200
Subject: [PATCH 4/7] meson: use precompiled headers for unit tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-pks-meson-improvements-v1-4-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Same as in the preceding commit, our unit tests don't use precompiled
headers yet. In this case though it's a tiny bit more complicated to
make use of them, as we do not want to include "git-compat-util.h" for
"clar.c", as that code file is a third-party implementation that is
independent of the Git codebase.

But there's an easy workaround: instead of linking that file into the
executable directly, we can easily adapt it to be built into a static
library first. Like that we can trivially have separate build flags for
that one file.

Do so and adapt the remaining sources to use precompiled headers. This
results in a small but noticeable build speedup:

  Benchmark 1: meson compile (version = HEAD~)
    Time (mean ± σ):      5.343 s ±  0.019 s    [User: 75.478 s, System: 20.382 s]
    Range (min … max):    5.308 s …  5.376 s    10 runs

  Benchmark 2: meson compile (version = HEAD)
    Time (mean ± σ):      5.077 s ±  0.017 s    [User: 70.557 s, System: 19.999 s]
    Range (min … max):    5.047 s …  5.103 s    10 runs

  Summary
    meson compile (version = HEAD) ran
      1.05 ± 0.01 times faster than meson compile (version = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..9f1ee9ad59 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -30,7 +30,6 @@ clar_test_suites = [
 ]
 
 clar_sources = [
-  'unit-tests/clar/clar.c',
   'unit-tests/unit-test.c',
   'unit-tests/lib-oid.c',
   'unit-tests/lib-reftable.c'
@@ -49,7 +48,7 @@ clar_decls_h = custom_target(
 )
 clar_sources += clar_decls_h
 
-clar_sources += custom_target(
+clar_suite_h = custom_target(
   input: clar_decls_h,
   output: 'clar.suite',
   command : [
@@ -66,6 +65,13 @@ clar_unit_tests = executable('unit-tests',
   c_args: [
     '-DGIT_CLAR_DECLS_H="' + clar_decls_h.full_path() + '"',
   ],
+  c_pch: '../tools/precompiled.h',
+  link_with: static_library('clar',
+    sources: [
+      'unit-tests/clar/clar.c',
+      clar_suite_h,
+    ],
+  ),
   dependencies: [libgit_commonmain],
 )
 test('unit-tests', clar_unit_tests, kwargs: test_kwargs)

-- 
2.56.0.rc2.329.gd58861e689.dirty

