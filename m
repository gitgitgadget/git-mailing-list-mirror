Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7730CB42
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403097; cv=none; b=WnC1xQ/A4TNKinYJ2mCXyJ3XrnN1MC8mbN4ZAWWJ8oOsX1dmJ85R420CWiijoy5nQAIrBA+0U6u07USYrQM1UT0MlFt/k3r0W4tz79dab1juJdKzQqgA+ZtvHDArMVDEFm/H1G32wVoA8nsvg2RFfvMbhKgtRVkr6j2fyMSxrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403097; c=relaxed/simple;
	bh=U7EEmNgI4tLm+XJZOA1+xM1BIBeXwwr35+gN46MUB/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0hDmQ2YnmQhE5uzbd8uSXwLn8DICnTM3PH/dPEdF1a+49tZcQPTXTvhIEyUdqj9kRdI+uxCAybN4kA4KOWiZGPgR/rFBHwTfiQYXPMscYQfCw61AW08zUi33+R6w3VfxZERLnEJBTqNxna+Dyb8XurL6vI4YFaND2mczsrcTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kBKKByh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RrpYI6hb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kBKKByh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RrpYI6hb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 213851D0018E;
	Thu,  2 Oct 2025 07:04:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403092;
	 x=1759489492; bh=O83M1JqhMBguFWK2p3FuouKaaqegIny8Xfa9qd7qfTA=; b=
	kBKKByh7MiIb9yu4Em//p9bo79GxzBJSrGkFxkZudGml+E0mKJ4t8vO1+yslwllo
	9bDmteEDXitB7J/4LiTjrqXJmA3CSIctF2J+2z7DrIKds+yoA6OXw3zPelcEiYp6
	iGbFxIUtyOnlw2tTK6LjF3hfYymJT5PH5fvOI663dfDdRt9/i9wMvQZUw67YQ5xt
	8+IEuIPQXMz1ugPrmskSu3x8GSrKvTo75scxmE3yQUair7+lu/dJhYPiRx22qXl0
	FTr3gFOTaGMEa3E54x2UGZq009V8oFbmu/0cPUKaGkVCXUB74mEst4SqO056r4Zz
	eweanlcJTMwJfo5AQkZcDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403092; x=
	1759489492; bh=O83M1JqhMBguFWK2p3FuouKaaqegIny8Xfa9qd7qfTA=; b=R
	rpYI6hb5Q3dPO+fTB5wxq6CuM3fMgjuD+M+pon1DI9dYk8JPosFuhGyILezZtNY/
	fs8PV3zAS3j8NrZ62aWq7/0TYet8WQg2Nl4AIhGEDw51ODf/wrm2Ng4pZ5anfxmu
	OWndgtfs/oqu020d9SGyYRih4aJ6FWYUSb4KnLxRSTtKVJOXRXkQvcQKlYTMXT02
	Tf262Hr5T3Xe6okXa87t93jbOO2XMUZaMroDv7DaZKgq3JYFs5vMfym1eB7rGOpj
	pZK8Y4J/LxmmlKCrmVE/9BgVjAeDPeYu5tMCT/+l/JSSbcaMf4VbwjIlf871hC01
	9qIOeVgPt7qIGWRDyjQ5g==
X-ME-Sender: <xms:VFzeaBrAHkwpXec6R_g0FmWE3r6C3tKYoeCpMyeJojgrOX0dyV_-1A>
    <xme:VFzeaJrGOobtpeB_a5EyfWbCFCBg1q1dvvV_4442SaaQjGOBUHg27QK9qE79L4rK4
    -chvKftRQyfbVmZzu3hkWM3kpfS2NgC0ubaG4h6mUI89AWoOlTuhFk>
X-ME-Received: <xmr:VFzeaL3htcu6Xlp8YA26SV1Yhv4gaDlv-xTc3cXUSVNQHbYQfoJDXlPhH4UJ0nDt6dfUXii-ZaeA07NUPVUSJHbrKy2DwRsxgLi1rpnz_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:VFzeaIA0V00wdsHD_7JapBRtO_AatGu34WZ6jwrgQmjWcGAPjfyoTg>
    <xmx:VFzeaDfYEpct-VWINLfGVBj5XB1R-kXF2gM-0uRzsP2IS1IxDm2N5w>
    <xmx:VFzeaNhkk-OQ1E5DGdtcNCuOBfGdOxnuwXqjZWIKWNLG2JsIORl8og>
    <xmx:VFzeaLqyEHVUmAocdD1GEx5KSeX9YsJsxs4iP8DbdUH4cNoRMrdcTg>
    <xmx:VFzeaFDj58Rd-Kl9NitDfW-lKC1Sn1UCNyo6k4gWqSwnHSbRpNkrKj8R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:04:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2ee8404 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:04:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 13:04:37 +0200
Subject: [PATCH 2/5] gitlab-ci: ignore failures to disable realtime
 monitoring
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-2-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We have recently introduced a change to disable realtime monitoring for
Windows job in GitLab CI. This change led (and still leads) to a quite
significant speedup.

But there's a catch: seemingly, some of the runners we use already have
realtime monitoring disabled. On such a machine, trying to disable the
feature again leads to an error that causes the whole job to fail.

Safeguard against such failures by explicitly ignoring them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 552c033fb0..ed4dc9db94 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -113,7 +113,10 @@ test:osx:
     when: on_failure
 
 .windows_before_script: &windows_before_script
-  - Set-MpPreference -DisableRealtimeMonitoring $true
+  # Disabling realtime monitoring fails on some of the runners, but it
+  # significantly speeds up test execution in the case where it works. We thus
+  # try our luck, but ignore any failures.
+  - Set-MpPreference -DisableRealtimeMonitoring $true; $true
 
 build:mingw64:
   stage: build

-- 
2.51.0.700.g236ee7b076.dirty

