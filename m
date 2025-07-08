Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086D29E111
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961497; cv=none; b=nlvqrvP6+FEZIbsih/tfZvZgX7R/SSVqO2Lmh2OdggNduw5aw8jfvAJ7KQHWeiQsn8cRQ6WmOZj9hxgDbbeU7cXao73IAXIB4bSy/S934akpo5INLeoppnHtq21sZm+0ZeVcBnunUM9oEfhV9A42FCUPCmPATJUUHF72dUHJ8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961497; c=relaxed/simple;
	bh=XfMYgQwmV6dmxLtOCqvg1Ez5KmUrsUUZbs6Be72HNWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlOjy8Siicpo8gyhbsdm1sAC5Aa7IO/1wrpxaiw39dShnv28R5NOkjDctdx36dca/f69iuHL2f+Z704P4fiDJvJhPBcVOS7J4h23AwGZ8M6kYN43oW3AZFy5qqYIj+xfbmskenYi+kjwfmnOGCW+7UHspjEjbmrNG/EwsZfWFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TSXVWHfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1ZAL42/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TSXVWHfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1ZAL42/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A12BEEC0B5A;
	Tue,  8 Jul 2025 03:58:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961495;
	 x=1752047895; bh=FKhFCrSZNb0cd2ZIdhDsvcDLYxZhD6rNR8GgYm3GSrU=; b=
	TSXVWHfFg/46PaRjy8gPQxv7TSvVA2ugP6YjOFO/CZfFwt1s/o6A4H8ZP9UmCwZc
	xEaF/gWt285HksqaeHruk0LgRrZ75qkXRmvnWpZwEP3F1JScic90jMuHygg5sxak
	8avQiDPAEaUmpv0i99ifCHKx3bwB2ixLuOuoJLBoO5z0c0VUskiM2cN0/R+sfAR2
	ZD0X9/EAXXJNSnIW2YGZG92Pd5cNcZA0iH7yYfa69n+2ZD+JFfQVGJ7PpuO6rcIr
	w0l7lZcjuQcPfjEuRlJYSQbjK8NY0cGjV8bo4fQ2mIOr5BIV6Arnn1xoJHHMyyd8
	YvTpxlz8J0kD3If6rODHfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961495; x=
	1752047895; bh=FKhFCrSZNb0cd2ZIdhDsvcDLYxZhD6rNR8GgYm3GSrU=; b=m
	1ZAL42/MS/5TVMv0EljVD4dztP6YIXUZ0GgIOguz0KJ8i5Yg05LwaPHdpEUQHdqJ
	eFO8vSYCNe4aBHYssJTeQ1QGl+PkAJc6+SKRX7SHyBGCrL4N3ikqTP5rRMwoEV6x
	YjmU4njs2l2vYTrj4t63tpkf0b39m6LpX6pNJxefeCmXfXztsw7Annn48D8uOVOq
	0yPK9a2nwB3NC3XoTrb8ATQdG6qIGlch6FsZp/2OE+6ar/4AXb9w/6506UuCgcgp
	gC0dh/hBP37Er+C9N9mO0qYcEhc6FOTzpUE0YP285uZm4XZ7e+ndMerWBaZmQd/o
	1prqmjlbXQxLj/nKFA+Ug==
X-ME-Sender: <xms:l89saJvRfkwl4nUWVaE1-2IOO5GyUG7jjv8eiIfzkWvjYiD6KOoF7g>
    <xme:l89saDNQqo38aET9LkKmaAJw0gAw8UMt9ryjQaKUzy_1vT1xD_LCY6Id7yQ2vYWjP
    61lq-vHJYBbMqOIIQ>
X-ME-Received: <xmr:l89saI4Wxg05HoUx8zJLTO1wO-kcinkuMQsmpXDfcmT3IgC50wxFIJ2ZVgOxzuH9ZFWqndOpQIra06Zqwu7UVnlG9c7MOShEH5lN_6Hzf24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleevjeffvddtheeuvddutdfhkedvtdefueejffehjeegudehieekvddtieejuedtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrthhrihigrdhnrhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehirhgvtg
    gtrgdrkhhunhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:l89saBSli9I9wFttXyKIXBwI3iBi-cQ-A0AQE5rzNGaqKziviD0P_w>
    <xmx:l89saNBFA6EUjfPSctFSO8ALvPuYQMpPPIcHJn59QwrhfmSFlZ6Lzw>
    <xmx:l89saJF1ISbU9Or6lrJy_XWJfHRuFoVHoUwK91NMZN2rMNgnzGFlUA>
    <xmx:l89saPDCOvotO4nLgJF0BtrDUEqvjxInhGDwXQh5AjE5GA5koszqrg>
    <xmx:l89saPvoMB-2nFj8FAAZn5nLpC72oXHlj9oVDDNbutPbDRU597JtSiKy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:58:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bec5cff7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:58:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:49 +0200
Subject: [PATCH v2 8/8] ci: use Meson's new `--slice` option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-8-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

As executing our test suite is notoriously slow on Windows we use matrix
jobs in our CI systems to slice up tests and run them via multiple jobs.
On Meson this is done with a comparatively complex PowerShell invocation
as Meson didn't yet have a native way to slice tests like this.

I have upstreamed a new `--slice` option [1] that addresses this use
case though, which has been merged and released with Meson 1.8. Both
GitLab and GitHub CI have Meson 1.8.2 available by now, so let's update
the jobs to use that new option.

[1]: https://github.com/mesonbuild/meson/pull/14092

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f123..d122e79415a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,7 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
 
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bb6d5b976cd..af10ebb59a3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -178,7 +178,7 @@ test:msvc-meson:
     - job: "build:msvc-meson"
       artifacts: true
   script:
-    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group; if (!$?) { exit $LASTEXITCODE } }
+    - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
   parallel: 10
 
 test:fuzz-smoke-tests:

-- 
2.50.0.195.g74e6fc65d0.dirty

