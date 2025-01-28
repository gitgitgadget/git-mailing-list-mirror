Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED41F37BA
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052909; cv=none; b=QY5UGnB+FBr3kTQoG4MYgcaq0E/ova8JEJRsbzs6u9lCiEcLsfIVaMkugQ8ceCpX0ABqhOcg0s2xGoHeQY9zUbCu13mShJF0wFolNOCvPD0u5YkYhgaOqm9fE7M5oZcgVBcKupfaHzMoWqmdyvTo1GOHOLLjebiYlSOPeI7RhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052909; c=relaxed/simple;
	bh=CVOCq3Ab9U1F43Ds5A24Ljd+idNRvmODkHX0xx2hVc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9RtPh9s2Nalju+XeWGM+5D2jW6uv/WOwFtnxd58YrN46JzOVbjG73TaPbF5esfRWOm/qIJ48EWDXO1KRRFQa3ZlrbcaQX4J7j9ydGkAqrt1lSWEWUmutvNUXq/c+iHtqS8cgJtHecBw0PAzc8MDE7M5Hcj3/rzkLe1Z2/GPkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bRYl4+zc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZG2/C05S; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bRYl4+zc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZG2/C05S"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9B622540246;
	Tue, 28 Jan 2025 03:28:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 03:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052906;
	 x=1738139306; bh=tJrciiJiZemBwMMzIMvDYFX/gnjv40BjS+jAPdHH6zg=; b=
	bRYl4+zczaBwzVSbuwwq78j2yDCt914HzEeY196tJIJ65cVl/nV4Z6JqCRTIZF0T
	Fgere1V3es8EPiCr1Fk+DFTzUO38SPU0Fd+5ehWbT7YFZWq1NtF86SLzMpXUhKI3
	woIckvkchfuVH1taMFF6dQ8Dugaz6mGFGe9/GZeHlmHndFooMNCPrB9pFE4qqQus
	gEp0VvpZHSQCRHUgsO1YNTWpV6KQnqJ385KkJZW/cANtSH4zG8AsG7rtKv1K9tDv
	UZJE9Je3d3R+Utb/W0xUQg7EYyb7f/pMO2C/FCju78HfAJBUExuTmtMauV+tfhSv
	8f+7ffbrDLlYv5DMD8V89w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052906; x=
	1738139306; bh=tJrciiJiZemBwMMzIMvDYFX/gnjv40BjS+jAPdHH6zg=; b=Z
	G2/C05SOX/GVLERrhNfjKdP7GKb7V2WKf4yerJ+D1K6Fw8aHqLrIFwO3UPT3OxVa
	ts7u1S2VMjFcIEahip1R+5K8CphrQbszEg4CZqExbVwTtGgT4ZS+9jme8lcOKy79
	rfrVHI9WhGmUbLH54i3VrCsMMi7TL6+FZgN8Mgxjm6pQPWCfk9aiknED99vVevEy
	pSb+mCcA8mNEZ0XCZVV4TlcdbQGPNE8tlGZrbSjUBtO3KF1ZXXajzU7qQgWA2I23
	a1/t08/Df9f9xMsr7Jf2+uyXIU+M0yhPNg32bALVg8tVQeBmlL4DoWuX0V1G1bmp
	DItE6NOMu3Pxq7TwWRquQ==
X-ME-Sender: <xms:KpWYZ7k23RtdyTxDi-PMyJ2a3mY19vPskdaO1NVhMa_zsO3uq4puZg>
    <xme:KpWYZ-2e3MT-jhYOV1-TbG5MJH0m6AqfjIVBZfqGCBiftTQ1DknXy9ANc4XnhtWDU
    MENaSOov6Esbxd4pA>
X-ME-Received: <xmr:KpWYZxrxlAimHd8x7tQn7Ft0PKtYK15hcJTwy2jX59oE3Iq-K9AbUhNkrn7d9Btp0LrlgDv3MpButV3UTwLzWWTBrpZ76WLYcGQAlNXFiFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:KpWYZzlw44zw53-0isMfVzkNulOkBqWyMggxzVv_FSmBl0HZ7eb1OQ>
    <xmx:KpWYZ53CeXLKjgIhIAfPIzx19CD1V2fuHM6Hlur4RtjoclnusxRHTg>
    <xmx:KpWYZyuHUzLnNPrKiUL2AVQ1yQDO0vLSVXq1rZBbQe1enB4RdHonRg>
    <xmx:KpWYZ9XAQtHW9-xqLntFtlvEhw-xiMb6HwGmiL-rZFnBa4fDj7lq3Q>
    <xmx:KpWYZ0S1Ge7DQl3qNPj3hIwyvZ-dxVJcpJYHZLlU77SzLHatrp86AV7b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bafac4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:13 +0100
Subject: [PATCH v2 12/20] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-12-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

