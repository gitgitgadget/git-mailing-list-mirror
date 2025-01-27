Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A01FFC70
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983068; cv=none; b=NdWHxLH3xRxa7fZ+zNoMd0SLqBQ+73onXNlrWCeawxuPF7nufpFmgIPpy6b0cB8z1fr4IYezv4LW7bn+kD8jToTEBrul47D2B9tyirSLLdbM2hc15iyhMgf0NYC9PvAFW20DnmgnoFYFRWrEZjXfx/YWvOHDV0XQa7ska1CWhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983068; c=relaxed/simple;
	bh=CVOCq3Ab9U1F43Ds5A24Ljd+idNRvmODkHX0xx2hVc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtAjOkxMpekWRns5HUd4iONzKvFfbcAomFd+9MEzO80ZiXqe8x6INJxNtjTbxWfSQNoBGQELKDTvTe8DT8UwuMrOunrMl7b6zymK81t79YA/Ryy5kewba34t3CpG61UYnhZ1HzEarYL4IhJCifkpW11lJTycL/Eiby5l9jFLSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oF0DPzBZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zmwwmhXr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oF0DPzBZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zmwwmhXr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A58D1140234;
	Mon, 27 Jan 2025 08:04:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983066;
	 x=1738069466; bh=tJrciiJiZemBwMMzIMvDYFX/gnjv40BjS+jAPdHH6zg=; b=
	oF0DPzBZI+cNHFqzXOfM+1qSvB+CysOZoBY36k3MxzWD6MCbcy/9ySLLSBT86txh
	rdAfA/NCmAn9PwUtU08V4R1p5aMC9B10xiWxf/VqpHLv765fylDydYt/wZRngeZe
	Wg4hnFkQQFIAVGnB4TW+VN3u+djG8m5mVNndyyarMVdGs5roill3Qu5/NvCWC0fQ
	91X6UwWk9gSBzSlS+uvxjvHMMzTgQleVIcQ3NpPDhILf5YqVrGGIVlXit0/7vCSy
	3dciXYo24BqMhEyx6rlnLFvOrtP6hmYs/lk42hkdPierptXehXC602HQi4v+znal
	pyKwZk63nibwfdVT6x7pKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983066; x=
	1738069466; bh=tJrciiJiZemBwMMzIMvDYFX/gnjv40BjS+jAPdHH6zg=; b=z
	mwwmhXra65TDjeBN9hNAFnNZRKSVMVuhTdHq6ov/7sQDt4FWqkpN4XTdgUKiI7I9
	eGVDd4kq4uhKKBHR6VuA318X/bZ7lpeQa3yBh7a/FX0xX3xzqrNZ2bDsW9C+M+BT
	pj7np+Fk9STArNw9DAc/JZFhG7MKzByG6pyFY27gxUf1nNzZ255KGWYIXCsHP8zn
	+UA245D2wDpHz+dVt6zwxBzLKyuQqPQXK9hhLhzidZNcePWoFxWsx/lUwabLmOkU
	/YBGtkBk2DO310fxSOEn0ElbeUMWhGmna98PMRdG9/nCBxX8AjcsqzZjyC2SPic/
	QCGFR0kDYuTStQc0HiVhg==
X-ME-Sender: <xms:WoSXZ2-hM2-fKaYG__WytOmK1_G_eJCjlYUmyVg8LqIApk2IlTZBTg>
    <xme:WoSXZ2uSTxjSZGxduyt2ImPZCtTaQ3ZMwmhC7Bo5DHypyTN-ZdBn6ggHFiTH6gwXK
    n9tj-i23UkZhxl36A>
X-ME-Received: <xmr:WoSXZ8DRcZNrBkccFdii_X1fsdHXvZHTO_YOYAXvc55bysm9tgaTdLosOejPcgVgEWHXWPQxL2IvEKVqSF3IL8t1KH0B59-rzVkAehJY4orp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:WoSXZ-c6zCuFvgULkIBq78X4VILFjZ0Yio-oQklP9l3Gm_vQfe7oFg>
    <xmx:WoSXZ7NiGP6oEwcSaW_ylLGlFXL-csjV-RW0-ccWW1zVXmQ8OZSCag>
    <xmx:WoSXZ4l0-dAMJpL15X7MPDcpLN7vvqsi8r7b30c3P0SUItVapt08Kg>
    <xmx:WoSXZ9tF08c2-4NCCnqpGa-9Q_Dv0BABpTonfyLvvJIXJDkP8H1gdQ>
    <xmx:WoSXZ0bzGxTsQLaaKqveT3Jbttb5Fj0OlT_kJbEEco3teFCRRwz6vt5W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24491101 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:20 +0100
Subject: [PATCH 12/19] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-12-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

Refactor our use of `sleep_millisec()` by open-coding it with poll(3p),
which is the current implementation of this function. Ideally, we'd use
a more direct way to sleep, but there is no equivalent to sleep(3p) that
would accept milliseconds as input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 82bdf5169f..8e9836aef3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -524,7 +524,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		fd = -1;
 
 		delay = delay + (delay * reftable_rand()) / UINT32_MAX + 1;
-		sleep_millisec(delay);
+		poll(NULL, 0, delay);
 	}
 
 out:

-- 
2.48.1.362.g079036d154.dirty

