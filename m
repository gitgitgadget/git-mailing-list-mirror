Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E933B14A5
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070671; cv=none; b=VkebFikZV/tU/gR8suqqgI/pImp+QRbkIkWVtXZs2mnMqMAASLs2obgGIkiUM5MxehL5p1P+c2PPRnWIJnnfiVeQSl4QLjXHjqlaLicSHvvL6mK98Zgi8WlulvsUyB9yxYWnmG6fdOa7Mi4e1vFh/7QnvWzCK7obqfTIHAaYLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070671; c=relaxed/simple;
	bh=6a3wUNrBkO6Hw8O6fDvTXdoI/ukuRTPogEDb7gI/nwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VouRY/PB9+WDwBMKtvqLGmmpvDyiSrhe7YYI4GHs6lRnEdFZv6Evnt0dxo+xQF+IVjG+Z8LT52nuQaxxrqEieXJZvucXdn1+Z/ws0cc2lzxGtog3KQpY5DBizVS1TyQ1BZVAc8gNTF0+i2yEM5EQXXIYKTgGWCcQoCqq7FJBegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qe1g2dBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipf4rLV9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qe1g2dBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipf4rLV9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5BE17A00C4;
	Fri,  3 Jul 2026 05:24:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 05:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070668;
	 x=1783157068; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=
	Qe1g2dBTLX7U58Jr9q2OOElUSBwtTaFXMb5aYkchieQkLpl1mPUZQj636nPd6zl7
	ce5YYfAJgE/Ei7aKk/1IdVCMMVHsuPnPba45jUk4dhIwG5ZFBRTsgJkwP+q9k00e
	LCLnmBxslkea7djiq+ABT6KA4XtCkgnKtCF7WHyvVO1fEBpLc8wsylKP/fnFC6Tz
	YSmEoLFJ5CxoWBbTz6aFtbJCKZfKDALd+5Owooye7lzG2eJm702/OoBjCaB/My0J
	qWgIy/khMLdE/SURmqs6RpbFtdwfu2jHlisPrm7IOeZhfh6NVy4CatrTiLXoumyf
	SmA8i6tlWcD6aPuay1wW6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070668; x=
	1783157068; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=i
	pf4rLV958xHGPMyzV2MQYxJ81hNaIn9dl9FUIkMkAeEnIjckARx23AJbQvx8Odsw
	Zj0RM1a77LpA/Az6T19h1hTVWJXgdCM/cbxjVGyT11jWgf0gBPYhCqRk/Ty+jM3q
	KUds7h44M3DSXeJx/dwEX145C3OFsHMwqWsGxOJViO5c3VvWbdOw67iS4NLQ9Uqz
	asYHsW/5uQLB3DZhDXiJoQ/D15UdQUWXaLrQq4htxIfR004R6owEr034tVYFMoG8
	di4Mzlrfj92Mc2zgctyP8HAz78D/8WEFDKy5Rh/zJOY/cQBy8ISia3GJWmYzBqAY
	uRcwnhGkwHngjOQazMp4w==
X-ME-Sender: <xms:zH9HanT6Xvt_D4hMY7-46_gb3JXRrMtOMgdhVuV7kWSPqT-hrk2TTg>
    <xme:zH9HavrBkfLDyCACCfYjGbUwnxVIj81aIaaZHsyeFBJ__LuuIQ4awtM3HBxqf_uIR
    Bwx1sjTdzlCixyt4GMSlmt2YreocMZt_V7sksoDnuoxESFVc8-b>
X-ME-Received: <xmr:zH9HalLG4H3lbXdCrrSlV5NP5wHFsWVCrfPku-cBDvJsHsuTy-Vjcsa7agFTtxPhaFFdtgY7T7b-vrHwECEsONotm_VtC_AmXqS7ccU4wA>
X-ME-Proxy-Cause: dmFkZTFLUTKFdCVRoqkwNnOYK7n/q+x5TzKi5f0bGjledCKXvoQ45F9vfk7OPmfxMk4AlV
    fLMFjwA7sSGHWhYXBzUl8XXYV1TCQClFfMfV55sktIlm2JpXhdtgCSgPS+mJK1zXZCPSLE
    1e68MYDwIi5q0iHLxMsWyOp9fCm+OXK5vfQq1eyMy31+UirRC9kAK43y8GkYcBsFjCPzpn
    T+47lDkpkapGg1vBsCZpGl8ZDSJFEHGy2IYBEwddsheyj8gAvQKDT1WfjtEgDGDcw4Rz33
    op7cAaok/QBvperiHL0VWfQspIFCkUkyhDibeDfdGVJBNf4+s+EKodmK1qhYwbEWOhQRaI
    38sH3BQVausYsz52/XZy/WeOhXuAJbztXxIO6K8Y6/KDUoYarO5WAZ19ZTAULnV416+/UP
    LPBZLQBrqGRaX3MJMT/AM2qm4B5lM+N8iYAOdih2H0YVdpe4iuriXyx0qHhE5mjAlZaxQf
    xhqDbNfYD6bUMsQUBZHUMXJFCBREqodmqs0dRyGBU+Tfn7F5zqNBREotIP1fOByfunpD/C
    7YLRPk7IFOXlmeDiN+LJmsDZpnUrUei+gyy6LfBzy1drOd8T109C9pV7u34kMUeijqSIiG
    Wvo5u1R+89+mdXW5hDvyNjwBYkrlwnr+pNGevYvUHjCARiT9uI6V5XXG5olQ
X-ME-Proxy: <xmx:zH9HaipHGwBCH1W7EQgW3AADj9P_D-Q77CLu7VvDLmIXkLlqTRu26w>
    <xmx:zH9HatzFWsmrW0qMJMmgked6pDs9hJzZpf0zd3ROOw-RnviSB125Vg>
    <xmx:zH9HamNANnxYQ5Z0EB8x4EC6eW3d8nQk4l17LCcANvG-FdFXftEqZQ>
    <xmx:zH9Hai6kbyxoNWLFd87xHHcqZe-CgULVutGC8TNI4z_mJqMxju9uNw>
    <xmx:zH9HaiGWBsS8IUaXtMDLg83vdoQM7PeU12vkOg0Nb2WB8UPurxsyx6XQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b70c1377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:08 +0200
Subject: [PATCH v2 5/9] t7508: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-5-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

One of the tests in t7508 is marked as EXPENSIVE because it ends up
creating and adding files that are multiple gigabytes in size. This
takes a while to complete, hence the EXPENSIVE prerequisite.

Besides being expensive though the test can only work on systems where
`size_t` is at least 64 bit. This is because one of the created files
is larger than 4GB, and because Git tracks object size via `size_t` it
will eventually blow up.

This test has also been blowing up in the "linux32" CI job in GitHub
Workflows since 7a094d68a2 (ci: run expensive tests on push builds to
integration branches, 2026-05-08). But that job doesn't only fail, it
also hangs, and that has been concealing the failure.

Fix the issue by marking the test as requiring 64 bit `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c2057bc94c..dfdd78b6fe 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1773,7 +1773,7 @@ test_expect_success 'slow status advice when core.untrackedCache true, and fsmon
 	)
 '
 
-test_expect_success EXPENSIVE 'status does not re-read unchanged 4 or 8 GiB file' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'status does not re-read unchanged 4 or 8 GiB file' '
 	(
 		mkdir large-file &&
 		cd large-file &&

-- 
2.55.0.795.g602f6c329a.dirty

