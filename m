Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A998278750
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354680; cv=none; b=DdCaki6dKVa9vXRpEaiiLgaYzV2B/0C0GpRNgsrvFC/j+6MxNdGiEqwaTNshPQiRuHvgFC5HV7AA2vR2Q2NouHyJWEyZ0yiDt0EqbNyLxXkXdhXn9s3b5ZdiitrC/gutYF4CKLEGAdr+xDMpR5CeXlGdfe3Vvv2LgLNfNjS7+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354680; c=relaxed/simple;
	bh=i5DkPfe9AyPavnZ6Ea1yI6pN3zXj/umx6tyO9c/kezE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B++bCG1dx7POi+VczWC1+KeEZp/ZXwLvdeLNSQg89Xi3Iu2r3heV2ttuVJ313ivlEMnZAXMX0/pqLFeFNysVFnhHqaa6zvYCfMH59jvLv+vC1JFo6BB4W7c+VKF98BBzo84zCxgPIAuXKA+TFEOnCM30FeUmBPEEdCbdVGzvCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+zjC8ME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDQ5hr6P; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+zjC8ME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDQ5hr6P"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50DA2114013C;
	Tue, 27 May 2025 10:04:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 10:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354678;
	 x=1748441078; bh=YwDYTYtSUIzsKIKMruG6OGIodgHDdQ3civ1nzWBkaUY=; b=
	R+zjC8ME4TY96Ogsxwj3ooUfgXy6XYDIyPuWHhuawQypxXypLsp7rwbWZmv/62SD
	S1eLvvKE7nqCEEIlsYwv3e1nRLFV0Qox8bl7IV8lIp15JFwSSGROe83ksXbFciNc
	cSHa3UT8K9JycOrl/x0AT+dpMnUtSonpmapWOY0P4YGixxYZLGIl/UbKCH/QTDco
	D3N/NlZjhjrTzUkxLI+NKS7ajcRNr/2YK0cyNHCb7QLY0C7TaXovzn96STMoiyXN
	KS9n2uKAFM7H8a7unl1fowByb2+xrRAPRADHf+F+L56JQYpOgkxSe2YoQAiCeQXV
	1P7CW28hLz4z0jXix7360w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354678; x=
	1748441078; bh=YwDYTYtSUIzsKIKMruG6OGIodgHDdQ3civ1nzWBkaUY=; b=S
	DQ5hr6Pzwj2swAYYVy7q+nrXweIFB5BFiHr0DqF2nO4m4NNJwqNmfMLG4Cez+q/l
	acI5KMUmJrbL6pwebNGxfWRfG+74IwgXLiCvVDO7osjG9I8pg9HwnHybQacYC+s+
	B6XwmhInNC1l3YgqpBYI5ZqGNt+WLOicAORwcS9cGWkadGUy4FWw5+ceIr+595Kj
	HqKeL7w2rFd/J9QPc3HeZvy2JNd7lzD9UGLupGT1ifthl17TlVBWQrz83vZZoN6q
	KXzgqgKxlj20uyP3rgUKat/3iZTVza9y1JL7M9ZlqgqbjF0KsQ9dzIm5GRnpvLWO
	eXAPrzW3fsIXWzW8EBXGg==
X-ME-Sender: <xms:dsY1aIP0PT7SCTEAi-h7Mjcsh4sfgxPAJx2xOzP7b4Zpfvhy55Hc0Q>
    <xme:dsY1aO_pyHQLetLG0TQwRZTviph-UQ2jgWXKmA1HuFgSzPgX7cenrgrBJhgeDEX99
    2XPqzkgQlfG1k2Ulg>
X-ME-Received: <xmr:dsY1aPSsbB1MLb6J3TAzNR-Qxsn0xRWFI8i-TjQBllDB0t3vhXeTcCdiNvI9trWMvqweDvWxyltmYGY0Pu4Sq2DSUWv3jh1kCvBiRl2T4gs31A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hm
X-ME-Proxy: <xmx:dsY1aAtIfHi1qGodTReT80ygyEdCV_RT8-GgR-CfJpqfBra0Z43FIQ>
    <xmx:dsY1aAdTDCadX9gtpxmSExZM4fxkun9Qeluv583GB-nE8qT1m9xtJw>
    <xmx:dsY1aE1AMmMldYt5KMqv67ZlgJLtgLTG6pVeARKcrd_J_j4OfF0BNg>
    <xmx:dsY1aE8gxOH9NQeWXbWU9nPbG1eCbbFbRwSBvZqMm13zERhUBLyDHQ>
    <xmx:dsY1aMIV-31QrNiLVcuzoHqNzP-hh7nahgBapkp5q367USIfI2oXD2fQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bd7393d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:33 +0200
Subject: [PATCH 07/11] builtin/maintenance: fix typedef for function
 pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-7-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

The typedefs for `maintenance_task_fn` and `maintenance_auto_fn` are
somewhat confusingly not true function pointers. As such, any user of
those typedefs needs to manually add the pointer to make use of them.

Fix this by making these true function pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cfbf9d8a2b9..447e5800846 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1533,20 +1533,20 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
-typedef int maintenance_task_fn(struct maintenance_run_opts *opts,
-				struct gc_config *cfg);
+typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
+				   struct gc_config *cfg);
 
 /*
  * An auto condition function returns 1 if the task should run
  * and 0 if the task should NOT run. See needs_to_gc() for an
  * example.
  */
-typedef int maintenance_auto_fn(struct gc_config *cfg);
+typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn *fn;
-	maintenance_auto_fn *auto_condition;
+	maintenance_task_fn fn;
+	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {

-- 
2.49.0.1266.g31b7d2e469.dirty

