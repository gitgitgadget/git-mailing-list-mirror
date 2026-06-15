Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F3F5BCB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531830; cv=none; b=D4UxmwAN1hp0KjO5F6g26FhWXlWOyl0YM6zKk6+IVHi5exDJltVl9hswCHLlCwQ1U+T7SEFx/YAiQTN/OtpdTA+I0VNzsSkIGd8w8fjoFlndfuq7RhH25jB4X1fYYXijm/V4YYAJeT5jLbZB3VY3u9CAeoDmir5aMCH+U8Laifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531830; c=relaxed/simple;
	bh=62tteGTTY5PIePuM2tcfHmbJQzMjVo6aDeckqMndPdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1pyNGThEBc7pvF8dIsIKCKToSp24uPAmYyxTgFoNXUqJcBEQYvXfi8+tJCeqgaMQhVaiI3dX1B25elYl1P0yA2ug6QgOaJegXARaHxGcFPlprPT7aiYnWM071F6eZLnbzfnhpOk8shKPaTbfFqYmZPiXEysJrI7DZo7l2fYHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FG1rnn3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUXRk2ds; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FG1rnn3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUXRk2ds"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C1BCEC0281;
	Mon, 15 Jun 2026 09:57:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531828;
	 x=1781618228; bh=vfDhau6uqIPSbP/Tl8MZ6+BjEfmjmfBCQHHztXDO6hY=; b=
	FG1rnn3TuqtX41w6f0Udb2FSE8GCmMXB6t+qkW4rnfci5Mpf640MuKSco2eb+68G
	MDmmliSvJhf9UKcRkIwaqdzwG61umI30FiBAlGr6l+XOaQ8SeP1oT8z2RK3klwhu
	P7g2Omen+MULExJQklAg1Qz+bYvlCVBZdCTD8eSnTbgyJiPfCMwCqCDT6fproD9j
	xuxf2HCmccrKglFVfFOTrKgxkbL4GRtNgTFbXI55P/2Wgq7rxu3wKMDUWM0OlbmC
	mB5xruxggj9RJMNK5vQXPpgLCgy6cFzZp3SDnNeQIvwijIaCRSpKbEOTtPbe7QTF
	w+lBHtKMeLptWIcF1eiQ5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531828; x=
	1781618228; bh=vfDhau6uqIPSbP/Tl8MZ6+BjEfmjmfBCQHHztXDO6hY=; b=b
	UXRk2dsAVIQSfJkaNHMXiQEWxjB/j7DmEw1zNafMfKrV75+IcfMlm4K/zXB/m/rk
	NYW0b9h8m/OxmlLz0V6wH5lTcXVrGCDiJiKzF2Ips18/sP8Es+9i2yW81tnd0s5t
	TDOnPJImeJ9ulpMPF4D8nTPwwpr+NFE/l7oMWPR5Pbu6tBaCE/8mh3kvNphEl5V2
	9JwlOF7v/kQtVd0F0rtA5p6MtRg8R5oDAp2rXT2TjrTABYuVb+8TyTsn6LTaE+HB
	/dYrtOUqNHSuIUX7d12v2J/AeJd3YdsVMlzvkW8L/ZShCe9i5LbkvKyoyZmZ0fpZ
	VxNQtbUDcZ//y5lCHvojQ==
X-ME-Sender: <xms:tAQwaofAMPWn851IkM8SYiTiDx2nuX16B6V6eU5umilMsevscvsbNA>
    <xme:tAQwaho7AXNgwZjpKEnEgOZHWGsU7d8Bq9CrxfXAqT4PJa0TSwmVPcbxbvTEB50wk
    Z0TdZ3ExApGo_tEO0xhQtQYx-WuPfEQ8-OyQT77ji0zNva69zRtC_o>
X-ME-Received: <xmr:tAQwam6OFU_JPIOfIf3YTRO64wcgdyKV9TsCa-nqxDzjGn0saPJfUoJDIGYqJlhThJnPCZh8ERCOzMPzpS-rREbpBcoNWADKwYr0UEuoRw>
X-ME-Proxy-Cause: dmFkZTEzlJZ7R8Fvdu12VIGi3pV5LVsqHobsEu2nC0pNPyYWLdj9qPJCTKMapBlAsX/FC1
    ZbCX8TtHPplEWxYtSTu6Wxgl3HBugROG2heABRQngsHUxAkgA9ZJNEDMP2d2cDdLEK9PCh
    R9hAehfnKauFBTwOG4hB8EZg00fL1KQglppoCzUXP3cP+K4uNaKKWeaQ4zVLMTGHxDG1uT
    RHXaOGhJ6FYs6BRN9/WmRzlmt9z5H8dzqvlGMu9eQRpm7PjBo6kWzwGxTriYr9kp/zbnmh
    Reva0Rh+pLvtzTtkYVOqewlTH1iAUjzt9vKEkWf/t8xUrNceBF5ppzYc0VRIMxMTGr0kM+
    yx5yfpEEdecGhki3Bb8beqFdEahMQU2Ytp7B8vCG4ozsGF/dvVsBNmqZVyTFLi1CwmomAx
    dNK9EVYMz6QPPfVQCLGSUUCInakeR9/b6Kd/q75CWsIJiqAgW8ior2TXRWnjhXQ1UBPRnq
    Li9VDagbwFql4lfYUfFbRqaW2pgDg4Sw/Q4YjUHumVUhk+hIu7wr7f8G0oFHo1vu+J11sz
    mjd2nJasz3ZT90h/Ozgckzj4lSeAgSAghs+col++xkL6NY7pTSrV3FN+lfs0zAG8CLwf8t
    IQrE2AfHL/MhrHk7u+YYOr+5EFiJwVpKU35XULLRGAZZDpOfdAaJWadK/smg
X-ME-Proxy: <xmx:tAQwanr8VqTYsKXHpRMJgrqAjwLbMr3LxJTHudXGizBvtfSx9jMfRg>
    <xmx:tAQwaoiXuBZq7C3410Q9XIfk_PJVdUicdB_eyEyJv6QTCkh3UN86JA>
    <xmx:tAQwahI2rjCu7xn1rScNHIcsXvNdCT79VFggknyDe3_XCk4y_rAzFA>
    <xmx:tAQwaoA7LCHm2F-JYtJ_s_2YqjTm7ykgd05xLXoE60wawmWI4oggoQ>
    <xmx:tAQwahVDUoeYTWb7TQR09PAEjtuNZbkPkSw3odR_29EOMrh60dDWNqFm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:57:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a031951e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:57:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:52 +0200
Subject: [PATCH v2 6/8] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-6-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

