Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D35477E
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258965; cv=none; b=EBj8UJvc68L+eWNrtSk3vQ0r+NWYE0x2QZy+k49l2tKVFkSW8IT0wsSJ7Ry6g0s4ap3HHqRu7aRhfIA2Vpvl5Zxljd40SnMB0Ez4eGuRDWo4o7NvNVq5a/tFpMuHp2sP/OYzWK5zmWR+KCbxaclLYfjaZ7gedWbirmK5ZW6XzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258965; c=relaxed/simple;
	bh=bB18TNzheASzH9/e1criv89CntVbN1jw4iLvEUhiGZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBmvTJlJwqyvUxjDoPCA4+NPfUslGjhG2LShysq1/mbwevYf9VoWRfWZnf+qi6lah4Ralpx5faV5BqgDYO3peRJUN4p46QJIJenqBFTJP/q+l0HiV0PS5CwjD22hOWgGuT79NimDfGrwUQkzLScTrqUbMoiD2HDhJiUplfcMapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EtmtT0Uk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uvcPe+t7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EtmtT0Uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uvcPe+t7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 185627A0082;
	Thu, 24 Sep 2026 10:09:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 10:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258961;
	 x=1790345361; bh=Hv3YOrwnKfB/FLuIM6jGGi9IiLpUYqbORDoeo7rn5Lg=; b=
	EtmtT0Uk7DhV1i3nAATE4+2WcYB8HGUwGc+yVD69dgXhUyTFaSPYXRjvlcukku9a
	yXuEER2CdgkujjbYq5IxVtuv9uqvqJ1UERp2xl4z8nA940iEksLcl/3G6qDBOUCI
	5leTn1vPF1muf2ihCSj1r5rWHpCtpbuIReKUa7D5QNEiTST+Lu2CJhRpje6igfs7
	sU7fyhqrOYPedLLDfU0zJiy7Ws5whxojN7CVnwJLnMUiVz0B/ND9B6g54M8eHnC6
	TlEtsqeFkkQeGp2wrpJU2rRVnwJMgCuHfsEPnIoMnkFCBjrxLeAd90s0xd0Ypmgx
	5yQq5+nrgQWY1jGLEeMf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258961; x=
	1790345361; bh=Hv3YOrwnKfB/FLuIM6jGGi9IiLpUYqbORDoeo7rn5Lg=; b=u
	vcPe+t7WbK2OXir58tq/MZMIQgQ/UmvGMseSSo5KeVbk3pGZxSmAy8AJnCGWMSTy
	QIq7z88cRy2eu84E7QZ8oNiNyT+hp3NV2I7WT0KmGUBD555448LRtF31H6XLVmh+
	GNiekqAr0kCXQD491Qcg/B3LnuRphaxjVl5OrBQlYJBAUxkFWxIDYIiELpjdLfEG
	9JOctrWCw8Ln81LzIIlIk+uJ6Ga8kHu378KezPd9wrtNDYpIM7EYelA/ImWJh4Hx
	u6l7ZwKK2DAx2k+5I74RHjoWoRyXGCdBvocuUAHMQai0MLNOPvW4CUErl0krrX/Z
	bwAOU97AUysKMk8mqOPag==
X-ME-Sender: <xms:ES-1avfvO4WT5aVnmhd0sy6bDImkLdqkEPl7SVR5AUp9dumWBLjWMA>
    <xme:ES-1arO1ZNaf6EegxuKF51WNKbMw4RMnCCpYWnCxebECmynj9-5vCsRqqvWBDs7AE
    4UHejHh1fngIdYVx5YJz4P27cSWRJD-A08R59S5ve87pQ4KqE8DqFs>
X-ME-Received: <xmr:ES-1amIlbbNg4-OsQJ5_8XX9RbohhCE6WBgV81gHtxULC9ujJXWNN2zfQanoG5DX2cnSzTg>
X-ME-Proxy-Cause: dmFkZTFtQE+DlqvF0lQbqprxNhHky+kluS0f31ID+eJQAOtW/ApPXZMwtEnm8b0s8Tz4zr
    2HcXZm4c1v0YwalfW7U7SogxguwgM7rzDq/2LSkXoKX2t8t4lcVOPYevkW4fNZe7D93O65
    rhKzP8wO2wEax1l3oSxntOmmMY0qqKhziMosLsZe0iuZ5mzyq7HLrvtcTYuPrgnDEnO7fM
    q6thSnkJiuXPsY/PFM+frscD7TgJFW3Dr7VrZgIJEWqGqHnNlRxsfIZW+8Eh4SmLar8TSt
    iCT+WmRuLtirP6ElGCe7B6h/GmMAPk7nc9DjRQbvsANHU21xAlnVYxzY3JetyAgfQsFNoc
    p4nEOOG9yn83claIsVPaRcwBpaecflG7D0aLhBjeseejcBmnbC+OK6ASlf01IR8QkjF/Pl
    B5N7cYUmrKfynmDu7VVIDN9xo4jeLFCmXil860KlsYtYjasIzSXxayyMw4ZE166CI94Yvl
    /Mu6GAfGRPc2TfIcYP5Zl3USAZQEvU2QUEP132f6TJueQnQ9M9KYLWueGVMCz3vJg+gZwR
    OsOezxaeitkNY1vRajrOo9cjrwuoSadT32PvoX+oLlnIRiEXl2kejS314Pm2Rgq2uV+vhn
    p75plwW8vXZSasM065D+pU/a0y/2ZOTLmq/QjtTg0CLvuipwO4FSwjLCpROQ
X-ME-Proxy: <xmx:ES-1asE_QQ9m77RtU7lHy6I4UWlwgjGtC4nRsiob979XqEeS97fnHg>
    <xmx:ES-1auQIwisyrZTqMgySfaKuxvKuH2oo2kybzPZlM6AR01WegVuVlw>
    <xmx:ES-1aoGMYn2c4lJ85pP4JnPkMU7B1ybtlxpK4QU2Ar9NQlfQt16HUg>
    <xmx:ES-1aq9rsi2Xd9Qma7D8TUaLkLUzxWGmpUujcofGiqKXL8eP5ztB6Q>
    <xmx:ES-1ajCTonmEgKL3pONS-5WPjOmEGby6yuyBb6s9TwdfXmUJWVMBsoXp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 277be47f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:10 +0200
Subject: [PATCH 1/7] meson: avoid recompiling HTTP sources several times
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-pks-meson-improvements-v1-1-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

We only link curl into a subset of our subcommands. Consequently, as
both "http.c" and "http-walker.c" depend on curl, we don't compile these
into "libgit.a" but instead only link those into the commands that
depend on curl.

In Meson, we wire these dependencies into the target executables by
using the `sources:` keyword. But this has the consequence that we're
recompiling those multiple several times, once for every different
command they are linked into. In fact, each of these sources is compiled
seven times, which of course has an impact on compilation speed.

Fix this issue by instead linking these into a static library so that
they only need to be compiled once. This gives us an almost 10% speedup
in a clean build:

  Benchmark 1: meson compile (version = HEAD~)
    Time (mean ± σ):      6.781 s ±  0.052 s    [User: 100.775 s, System: 22.954 s]
    Range (min … max):    6.709 s …  6.867 s    10 runs

  Benchmark 2: meson compile (version = HEAD)
    Time (mean ± σ):      6.274 s ±  0.021 s    [User: 91.882 s, System: 22.092 s]
    Range (min … max):    6.242 s …  6.306 s    10 runs

  Summary
    meson compile (version = HEAD) ran
      1.08 ± 0.01 times faster than meson compile (version = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 0a95d90d21..4fdb4c5405 100644
--- a/meson.build
+++ b/meson.build
@@ -1925,10 +1925,13 @@ bin_wrappers += executable('scalar',
 
 if curl.found()
   libgit_curl = declare_dependency(
-    sources: [
-      'http.c',
-      'http-walker.c',
-    ],
+    link_with: static_library('git-curl',
+      sources: [
+        'http.c',
+        'http-walker.c',
+      ],
+      dependencies: [libgit_commonmain, curl],
+    ),
     dependencies: [libgit_commonmain, curl],
   )
 

-- 
2.56.0.rc2.329.gd58861e689.dirty

