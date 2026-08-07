Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89540A940
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083508; cv=none; b=WSnKY7uSnE2AroL80jytA23lLg9F4vaQYHFzmN6er+IcCRNdmzuJ12j/Z7TGgN6Kl+X+vBvkfh0Hg28RuQTA10KEpvx5WEMzQg7QSJfNVifigntdNz2coYSjby+Ms9DSsc3dafgS1N1aBjpvOYMn36GeoWPHJlmZM2tRGORnIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083508; c=relaxed/simple;
	bh=SXGobNHRA6algFSuFQ5BfHAFrtJucOw1ve/Td2y3rtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qii3AtSVdlYe0xi0VaJBql05RZOFRG4E5YRzAb7BI2NS86D/7kCrabp+j1mvuWT9gffaKAsCGNzVUupfBVv8g2oNlpEP3W2UlE/HfnTnGJiWE9OmnFPmYymzogTqmFO0KY8BkSck7iexcOefmuKOWauOghjQUn0NKNv79G+fPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XZdBS5Qw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ce5R3sXg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XZdBS5Qw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ce5R3sXg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8618414000DF;
	Fri,  7 Aug 2026 02:18:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 02:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083503;
	 x=1786169903; bh=SKNX3l8YPLSi6d/wmhWmoaX3dKf5sNagZCtXxvrXIck=; b=
	XZdBS5QwiIT4ELgNdrkFjLgGIuucetmaRvxmoZ6Q8I7hSBB4vB/COvTpbw1cIXav
	JrafBIdZ1BioScnsa28gTQia3bKBMs53FSBuJ3nDbfLQdEFT28Z/2ZXFAa1ZMUh8
	kf/HYLUxoPRijxZG5acCP7ADuqRwc3AsYZslnbotl9E9pSO4yBAiPKQ6hitjW51N
	10UIvdcpoVAUMjhJ5h+FZo8wUvQkFC40Mt8YRMr07uOX6T8VKhQZL+Jn2qMklHsU
	fTVm0dfVdXmX95Q4kp84WebPSiFofEjwsduktxRd6CFa+M8GuWkTkXLMpxueV/bD
	mauOnht3knNb3aDXHf5GAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083503; x=
	1786169903; bh=SKNX3l8YPLSi6d/wmhWmoaX3dKf5sNagZCtXxvrXIck=; b=C
	e5R3sXgPWO6h/sjd+CqxuJvECdz9s0R4LauTR4YSJQEIkBJW7MchzmB66P+ysme/
	mKHYbb2bQ/QIGBnimgl8RXtlyZ7mHELq7q7N8z3v0JNE0yLHJxB2Ae3ZHU8lxSZY
	tx+gWP83w9LhDGIN69/YS6ZRGCEH33y9gQx5L2jYA9dWkRWeIOINgd1hIgTgRT2B
	PECijuYR9QhFo/Dw2f6aTBPaT82MZkgIC9zGc+MPajrBNCFbebRqOHx9VWmsYw8S
	mkQ9kSy/NA4AewrwPVMn22NCiPrqMtO8FQRl7GdD4+Gams68Wr48byUCwPtSor42
	FZcJmCx1F5XpLCpBbI+xA==
X-ME-Sender: <xms:r3h1aiJYzK5chj_JDqpXtibSXuuq2eeBUUnUibTgyjAkTBzmKPwA6A>
    <xme:r3h1akIwcTQ8O-zfHvwtEExm0QPLE2caRpHMfh57VDjnlm7CKx0kAfFBh2Ej_2EvQ
    rAO9_cU7VrBSwsFEO4ym8EmWM2BcdjgP6Fu4Qo7BNxJpVXLhVZbsQ>
X-ME-Received: <xmr:r3h1apVmo-awizWFJPnd_en4h2iZRqFaNGoZAG9B9h7QtytL48IgMR22zUlVsWpecVE2T3UlCV2Kl1MTonXTDt5qL6DNzUtt6TYAqM2lxfWUFQ>
X-ME-Proxy-Cause: dmFkZTFEbCYBVFlR1LzZ4G67sbLtMLnWPvR3938YO2DJLQ7JQzws8UkikOS+FFEmVG3g0m
    IoO0WBWV271gIGxDYm3R8r2ueW2K2JsqR3aDMB3NAglvt3mT70LNDsX/MiZm7/7B8acN2J
    fvCEAvrA1F/WzBxick1ovrOG60+AMO4n3VpGXu/4AEViyw29F2s4P66gdxJ0X63dNJiLjt
    DJfqTYm8fjDYkY6pyMWo4177Pzu27EOEciFD9q7rLPQMqP5tTKL6B9320WvjoMaAdZCHhT
    Iz5bMOe2vZpWIvM+oZwowA0aD11E25eD0ZQ08pJ6RGVCpLul+epMl3mSTnVp7eL/zItwXz
    ALu/uIQD1f2b8JV2Jz6pWG0PGHHe71R+k8GAYRSHj3/w6W55kwawRi1K4ABtjTCMCVLHGs
    ClUIxlJcz8cdgtE8CIrU6tp7I8yMGXV2ihhide5BHl7sYj8ejL1dSS+Lv2s+9qMUoieCmf
    Lg2sYCyzjyKCcg1d0Zm09e60mc2oHXI+uMHKCEZSbhl83/bl8fGzadjYufnkTJeCAWSDGh
    XMDYnQWwXQyqKPfE5MHjbnGkVa5gw3FNqMC0JBbAjqVuEIGp9L+YOGoQh2B4QZS4gqBun9
    6Wltby2EA7YbCuGMPaO2pRZCAdhvOvSoCgPuBRCuolx1rOat+wT/YNpiwYXg
X-ME-Proxy: <xmx:r3h1almJ0KmNj7bgOeqNJgtAy2pWbuUXbJOyYlEN5QkeOCkdz_xBuQ>
    <xmx:r3h1annB__eITZfLhPkhtFq1BZ6QkM_OvI5gZsg80k1TkivwB65PgA>
    <xmx:r3h1atb299v_T9a5JQJPe1D1SrVzwHsfHgdfMbZjaC7gc_zQSx1nDw>
    <xmx:r3h1ahQyvhjSiZ16m49niNcnU-7Ud-88gP8pPmKTRnFRctOS0QK13w>
    <xmx:r3h1aq7bIq-ZN5aPGkfgNqd1Kn628FgnVF1GfaI3EgST1ewDj2ZUEF4V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3861a54e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 08:18:06 +0200
Subject: [PATCH v2 4/5] sideband: use writev(3p) to send pktlines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-pks-reintroduce-writev-v2-4-30fcff0e89c1@pks.im>
References: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
In-Reply-To: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Every pktline that we send out via `send_sideband()` currently requires
two syscalls: one to write the pktline's length, and one to send its
data. This typically isn't all that much of a problem, but under extreme
load the syscalls may cause contention in the kernel.

Refactor the code to instead use the newly introduced writev(3p) infra
so that we can send out the data with a single syscall. This reduces the
number of syscalls from around 133,000 calls to write(3p) to around
67,000 calls to writev(3p).

This change leads to a performance improvement for git-upload-pack(1),
but we have to cheat a bit to really make it measurable. Usually, the
time is strongly dominated by generating the packfile itself. But if we
precompute the pack and serve it via the pack-objects hook then we can
essentially eliminate that overhead. The following setup is executed in
the Git repository:

  $ cat >request <<-EOF
  0048want 5ce91c059e41090e7d2cffad39c04af8acf98dc1 side-band no-progress
  00000009done
  EOF
  $ echo 5ce91c059e41090e7d2cffad39c04af8acf98dc1 | git pack-objects --revs --stdout >pack
  $ cat >hook <<-EOF
  #!/bin/sh
  cat >/dev/null
  cat "$(pwd)"/pack
  EOF
  $ chmod u+x hook
  $ git -c uploadpack.packObjectsHook="$(pwd)"/hook upload-pack . <request

Benchmarking the last command leads to the following results:

  Benchmark 1: HEAD~
    Time (mean ± σ):     192.9 ms ±   0.6 ms    [User: 106.5 ms, System: 95.3 ms]
    Range (min … max):   191.7 ms … 194.1 ms    50 runs

  Benchmark 2: HEAD
    Time (mean ± σ):     141.1 ms ±   0.7 ms    [User: 63.2 ms, System: 86.6 ms]
    Range (min … max):   139.8 ms … 142.7 ms    50 runs

  Summary
    HEAD ran
      1.37 ± 0.01 times faster than HEAD~

This might not be impressive in absolute numbers when you also take into
account the time it takes to generate the packfile itself. But GitLab
(and supposedly other forges) have caching mechanisms in place that work
exactly like the above setup, where repeated incoming requests can be
served from the same cached packfile. And in those cases, the impact is
sizeable.

More importantly though, as hinted at above, GitLab has observed in the
past that with enough cache hits we eventually start to saturate a
semaphore in the Linux kernel itself in the pipe write path. This
bottleneck is being moved a bit by having to do less syscalls.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 1523a53e1d..94e5b56172 100644
--- a/sideband.c
+++ b/sideband.c
@@ -441,6 +441,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
+		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -450,12 +451,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+
+		iov[1].iov_base = (void *) p;
+		iov[1].iov_len = n;
+
+		writev_or_die(fd, iov, ARRAY_SIZE(iov));
+
 		p += n;
 		sz -= n;
 	}

-- 
2.55.0.679.g6767b8d81c.dirty

