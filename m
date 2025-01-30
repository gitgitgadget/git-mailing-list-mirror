Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824D1E8840
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248256; cv=none; b=LBV014VchDH011LmeJuakEL3hfC2AU5Oq4z//bnZ+7OnHd90TmSGj+ts2mjB+Hh6gRcxpsHLndARBL1ZyLYxHMJl4MpOz6WdBo62YFwBOMBCmwmNpj/SKdZ4H88oQwV5F/fGtV0jiy2U+coRyireUgbO9bo5Vv8Fx46LtY9Q20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248256; c=relaxed/simple;
	bh=HQQzGoMjr/sZotY5PBmM+c3iAHv+fPRchGCcBk8WiU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tg4lMHHBQ96jv/yNOA7l5cUVTdIlyPsnNA93cFUeCt0NWaxiRdDCj5CKnZvVpfAYMZTZYWk5Hz3wE6mmD7FU4CaH+i7zHeXBLUTAe3NfwmIEz7eaEyHT/2G5jmO4ZPw8uaY7N1/n767/DWAWXcK1wZZNNL/QHJndABoXNsY9JAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z//8+1qo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ig8igVNc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z//8+1qo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ig8igVNc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51DE31140163;
	Thu, 30 Jan 2025 09:44:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 09:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248253;
	 x=1738334653; bh=4zr8DI7CcX8696ntqA2QAGSIopXi4+iBiYydZEPvycU=; b=
	Z//8+1qo6KdtRc1dz2K0/Py0FSOnaJ/2ggge46ZTwZRrlodOmlUPj0twQnW20u6g
	Cl9Vf4Ezp43CHpTOomMEOLI2FsnuCMWg6SHNFeflk3wQLsCFACY2pLH5kK9ka3BX
	gwAHyGH+t1FJVEUMM9z7zPjcFgsx5dsfogl4nSAdwOzLYC2vI4Y+aESwTp/LwJlH
	g9g+PfYp8IJjl9WweOeqwEN85cAY8jt+Si+a+pvTfYthbAABUeHpzHKbKcuJhKK0
	W0+ebs+oNT8YOC71c8DNxTh2sxSsuaEi/DugF0YxrPu88upR6UgUFDpGgk0Wd1mZ
	2mgbg2SzDyBzcF5oFURECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248253; x=
	1738334653; bh=4zr8DI7CcX8696ntqA2QAGSIopXi4+iBiYydZEPvycU=; b=i
	g8igVNcoJ9w8XZbwRygq2ZYVLS896W86OH7MZ6CeAKKrpjKDdkiDv/fj4SXOs0FX
	ZBMU30PGUgXbRSf8dtvq4zNVduwZraw8atONmP2VXeNuPKOV2kNmgtDLhuY9IH+A
	SW0WYpekKnGVvCwPV6Mb6MOkEuh3zSFAIALdQqIc7dh5bUhNDxCmSBAAZbDpbiR/
	wET+sND3t2ip7V43vBsIcu+ZD8pshy4RaMmg3G882lXY2atW8PExDUbi7UIDp7xH
	rNggMBHnMno4HWvtpuQVdZLulqrOj+YkEkuRKunmxCOLDi92ZZKGX46EPUCA3yW1
	RfpK8AsQPDB9ol9HxGlmw==
X-ME-Sender: <xms:PJCbZ6On48Eyl99b03Z-RP_QoddinTSjFdPvV8yAPWMDNSjUMjol6A>
    <xme:PJCbZ4_uxEJtyROdEkuVHQoM9Uj03cEO5hnk7YABRujlKnqbtsjknzeNQS6zHMjRd
    xPWpE8-OGnSXuGa2g>
X-ME-Received: <xmr:PJCbZxRlYkFrqi8vTZMtQvF3EzRlHnKvELnAHVsN917orFgeJ7bTU0k5T9l4RTeuKAV2rfWWrYaw6chEMMFHdPzpn7I5tKgRKTSIb2GcuPXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeggeduhefhjeevueejfedttdejhfelffehgfeflefg
    gfefhedugeeiffdvffeugeenucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:PJCbZ6ttCAmGiimeJlAqyostbObtQhSRT1xiqH8v2uH9fi5e2ift5g>
    <xmx:PJCbZycYBgvm3HA_LLv0FyE7xi89l91ckpUy7ByBv4sQM9e6pvS5VA>
    <xmx:PJCbZ-3uJcLYMBvlyQ_SSuwCN5O_gc3JJzYPwuSzMYaKltQMFRs5SA>
    <xmx:PJCbZ2866fkHXN5kMzMZeAA7AxQPDqN9Iy1WnxAwKAshQJ5y53_61Q>
    <xmx:PZCbZzpjN6i7ZQNqSAAanM2b33DWAxcKiD4jsEZz_HwOHN51edul8Ceo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0569f40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:54 +0100
Subject: [PATCH v2 02/13] meson: fix OpenSSL fallback when not explicitly
 required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-2-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When OpenSSL isn't provided by the system we know to fall back to the
subproject wrapper. This is especially helpful on Windows systems, where
you typically don't have OpenSSL available, in order to reduce the
number of required dependencies.

The fallback is broken though when the OpenSSL backend is set to 'auto'
as we end up calling `dependency('openssl', required: false)` in that
case, which implicitly disables falling back to the wrapper.

Fix the issue by re-allowing the fallback in case either OpenSSL is
required or in case the backend is set to 'auto'. While at it, fix
reporting of the backend in case the user asked us to pick no HTTPS
backend at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1f83dc58c2..83ed55c75c 100644
--- a/meson.build
+++ b/meson.build
@@ -1352,7 +1352,11 @@ if https_backend == 'auto' and security_framework.found()
 endif
 
 openssl_required = 'openssl' in [csprng_backend, https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
-openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
+openssl = dependency('openssl',
+  required: openssl_required,
+  allow_fallback: openssl_required or https_backend == 'auto',
+  default_options: ['default_library=static'],
+)
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
 endif
@@ -1366,6 +1370,7 @@ elif https_backend == 'openssl'
 else
   # We either couldn't find any dependencies with 'auto' or the user requested
   # 'none'. Both cases are benign.
+  https_backend = 'none'
 endif
 
 if https_backend != 'openssl'

-- 
2.48.1.468.gbf5f394be8.dirty

