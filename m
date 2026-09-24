Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676D379998
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258966; cv=none; b=I3bdLk7M2XhwL2AvjIi08qt4iq8V9gNR8UTm4d7NLxUv0TWcjjXuunI/4w7z7bqod+ZLTdrlm5sAf2NcktUOACkRW3TKkUbwkwLdDujl6TQ9M5s8eO6qhQgmHDJHGKB5jjIFYmRStPgBzldzcxYU1d/N6tBKQUWQ2bvBBYHNYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258966; c=relaxed/simple;
	bh=KvSbyjO9cbX5LqTPSggcdZAXj+BG8Md8Du5ds/8dv3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf43r19SkDa1JKpRfuT18NpCMdnRytcXiNC1K9xqdKxwR3rnEXRTbSKhfX5YyIc/5YwC5ibZZcg1YGIyGWebxuFlMHQS+5T40PBdRGikZ16zVZmcBkWzcmszIMtJWNRyLN8M1z+RX8IHatRUxPItsMQ6pmUFN3hT1y9eyNRgevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eWT0WqkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBTXmLoR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eWT0WqkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBTXmLoR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 422B97A00A7;
	Thu, 24 Sep 2026 10:09:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 10:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258964;
	 x=1790345364; bh=6H1tu+vB4JJdQfYOuYeSOIE0kj3U+rc65LB3l6ICxzo=; b=
	eWT0WqkRZklFi1O1xUlfevFnn5Y5wCWRn7AujxQKZpNLgwW6nFNmG9drqsVnw7Ar
	tdvcy19HnNRcYhQ3vnxtKtYuJzwV29lkoG7f8iJu6PTWxBgkbZpkaCjtXcUo30XE
	m0bg41RsjknEG5jV0g1pOl2L7qHFnK2EWFvfvimcJjWjHm61i3uoxswSnRwQUwMo
	NXu7iDslvgrXUxmzwzEOgpbOUVpKuCT+jbReUs8NwS4V/FnzwMnOKv9kWWZ3jZhk
	JQDU6JnpqqO01pRng/e9UzJ5sokamggBau40GbqUMaBk42B1te6hVGNOzzKs3b01
	+bIiaPOHPAuLWYKReEvedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258964; x=
	1790345364; bh=6H1tu+vB4JJdQfYOuYeSOIE0kj3U+rc65LB3l6ICxzo=; b=k
	BTXmLoR6bZtVW6O2XemBIEdK2CdrRB4luVfa/Q3Eo7gSSrCLjWBe8raKyzFatiD9
	lMyIVJAwuj7yq3mHtPOdM4efimBeftgNEqYlSGsFx7Gd/dJHH5o8IQq45QKFqKH+
	y0dDOUMPPg4h888btgokdrQtIS+qCF82RyuWYP3MTrniQmVouOdQPBQUX5/nmbPV
	gMAjOjD52SZI+eJJdtw4+FVjYDv47DbJpV5DADEkJ3G3Hbq8lbgzH6c3KDSGETY+
	aK59xz+AoPEovyL2eh4jR0JNmxlOAQi+qIHlgAfhVW0sZLkajwBLt9uMMrF+Rhe5
	EqGeZd9XThuCLmEfx5eWA==
X-ME-Sender: <xms:Ey-1aiPeeEL8IrKD099eN-AmSQw9O36uKGNCBY0ZGKjJ9SuoxdfbFQ>
    <xme:Ey-1am-m4d8ObikWjkjeCK0bd1IB-01aFikn-7XaH0lDBcWF7dFXUgNEpuhiyJroQ
    d_h8Bm2pBhRxDpMMDuKjPPKldVy5BHCYCJFSkjTjsMLEBVY2w41QnQ>
X-ME-Received: <xmr:Ey-1am6NOPMiJA3Vv-SKZ7254w9qLuX3SU8KZZbVPBenJ0yVx2q6OeIScyEd4W2SXm03ZNs>
X-ME-Proxy-Cause: dmFkZTFtQE+DlqvF0lQbqprxNhHky+kluS0f31ID+eJQAOtW/ApPXZMwtEnm8b0s8Tz4zr
    2HcXZm4c1v0YwalfW7U7SogxguwgM7rzDq/2LSkXoKX2t8t4lcVOPYevkW4fNZe7D93O65
    rhKzP8wO2wEax1l3oSxntOmmMY0qqKhziMosLsZe0iuZ5mzyq7HLrvtcTYuPrgnDEnO7fM
    q6thSnkJiuXPsY/PFM+frscD7TgJFW3Dr7VrZgIJEWqGqHnNlRxsfIZW+8Eh4SmLar8TSt
    iCT+WmRuLtirP6ElGCe7B6h/GmMAPk7nc9DjRQbvsANHU21xAlnVYxzY3JetyAgfQsFNdB
    aH5YkVAWYsk++nBBXEk3dqR5rOUQtoezddWcegGM+ay/sm+umYDxLGmOI+IyFFn7v9f8JQ
    QFx/CFx/Tx62lG/5PtVd5KMXjUtabdQydeOHaptFNMXhUhkC7V19ZJR+gsmcn/zERho1Bt
    VqbK7NwHCKCROVaM/tH8KEGtW/4fhVqwTFrX2LoUiFlEFBp20gtNxtUImum3da01RpMaUa
    DKkUwIaIoBqysrIB1OvhuNhpCVtpGTLe38B7NRVsijhmclxEYILDaViaLfVlz7Lm8dDY5o
    LIztYMbQ5bj53kI5QW5vZxR75d14FjXqp03tB43a/oZak1dLttBYuJhfYQpA
X-ME-Proxy: <xmx:Ey-1at1UZ0uBc3mXsNJuVWJHIvPKCxzeO3geAICr0D7HnIutineBow>
    <xmx:Ey-1atAtwLxDo06_s-dQ-MiXdfuRNe6PBpCyR5xID1QvbWedmMLWbg>
    <xmx:Ey-1av1MVEDYPh2vRNMPV0OKPEpNxO3P_-05Op92e_kfm6diQeIEMw>
    <xmx:Ey-1anvI4FuTmrUSgUuWuZ70EHbTNyjlH5YlTubQrs1ROcYU-6ZMrg>
    <xmx:FC-1ahyeEcui0EypZWaTiQsZoeIGw2LofAHZc2v-u5i4QzZTxpYZ6bFq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4439fb6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:11 +0200
Subject: [PATCH 2/7] meson: don't recompile git-remote-http(1) multiple
 times for tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-pks-meson-improvements-v1-2-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

When running our tests, we expect git-remote-http(1) and a couple of
other binaries to be available to the test suite. In our Makefile, we
achieve this by simply hardlinking the file into place in our source
directory. We cannot easily do that in Meson though because there is no
available command to create such a hardlink.

We could of course create a custom target that uses a script for that,
but that feels quite awkward. Instead, we build the executable several
times, which is of course less efficient. Even worse though, similar as
in the preceding commit, we're building "remote-curl.c" once for each of
these targets, which makes this even more expensive.

Fix this by reusing the already-compiled objects from git-remote-http(1)
so that we only have to perform the linking step several times. This
leads to a mild speedup:

  Benchmark 1: meson compile (version = HEAD~)
    Time (mean ± σ):      6.250 s ±  0.040 s    [User: 90.881 s, System: 21.912 s]
    Range (min … max):    6.197 s …  6.344 s    10 runs

  Benchmark 2: meson compile (version = HEAD)
    Time (mean ± σ):      6.218 s ±  0.029 s    [User: 90.633 s, System: 22.022 s]
    Range (min … max):    6.166 s …  6.262 s    10 runs

  Summary
    meson compile (version = HEAD) ran
      1.01 ± 0.01 times faster than meson compile (version = HEAD~)

Honestly, a 1% speedup isn't really worth it. But the change makes sense
anyway, as we're doing the same when we build git-receive-pack(1) et al.
So while the speed improvement is negligible, it brings more consistency
into our build instructions.

For the record: I also had a look at using a custom target that
hardlinks the files into place. But the improvement it had on our build
times were not that mindblowing either, saving roundabout ~100ms in wall
time. So sticking with the status quo felt like the better solution as
it is native to Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 4fdb4c5405..fa104a3efd 100644
--- a/meson.build
+++ b/meson.build
@@ -1935,12 +1935,13 @@ if curl.found()
     dependencies: [libgit_commonmain, curl],
   )
 
-  test_dependencies += executable('git-remote-http',
+  git_remote_http = executable('git-remote-http',
     sources: 'remote-curl.c',
     dependencies: [libgit_curl],
     install: true,
     install_dir: git_exec_path,
   )
+  test_dependencies += git_remote_http
 
   test_dependencies += executable('git-http-fetch',
     sources: 'http-fetch.c',
@@ -1960,7 +1961,7 @@ if curl.found()
 
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
-      sources: 'remote-curl.c',
+      objects: git_remote_http.extract_all_objects(recursive: false),
       dependencies: [libgit_curl],
     )
 

-- 
2.56.0.rc2.329.gd58861e689.dirty

