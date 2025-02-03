Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFD1FA16B
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569837; cv=none; b=G3t0muWQ9u0D6vFEBT+W9AZZWgBA0f6UCVROBW9uQo6vJM7dzcm15uQXq7+OLzrBXs2Pjgn70s5QmTffpQFeYwFHlxlyJqiLZiZiXyjhalmOXkLB+xc1vVqv+BoCboLYcYgG45EdfG9t+NX6sbj5CbWNz0TRccKKKtK76L7Fhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569837; c=relaxed/simple;
	bh=T7M0Q1rBiNjyWopAO2F9GPLNqntAWmMZaSdiT1/1PvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoIDjbNqKLlX0fUrfK+S+6tHc8jAfYUnnhwsZAO5octL4gBdWe2yXmhJbvQiPJAaWRMQXneDEzjhxFVASyeG8dZNlw+37yneHvo2kIvb1wDy5iVpbhiMtUvvmwEqupI+bXGz1L2hvmfeKr2GO5KGB2Nv2IcFm6woFZkE9hEiSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hiGqxWMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6vhwqgu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hiGqxWMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6vhwqgu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71559114009A;
	Mon,  3 Feb 2025 03:03:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 03:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569835;
	 x=1738656235; bh=aaKX3h3MuODISzMKmpXzs2xZV9EBckEQJw8enTgvH0o=; b=
	hiGqxWMq1ZR87AUoJm157GJ8Tkfkipp+D5kJdRkWsLcAEtMebdBPeHMkp9NkYwm0
	MNf2m/LsooygpsqpcV9669aVnujMbsHOmyye45dunRwEAqWmiaLysoTPnDBxXvjx
	Gwmmg1N8oI0woD6dCfgu1zi3DTXQQQY1JV+L+sFTxzjVNLhENN7jRg8uvKmSb5Uz
	1qyKa6Ymk8rJmxLPzCAlQLZX+Ha2mh+ncjjod7TKoPpfVZjkSjWOxT3c/HHT3Z9O
	VFrg+GfJRqGg/JbLfjHj5KwvzSePHe8u4FPe0P2psviZKE6AhBh8BIe0ZjKaSCnF
	epCB7YzUlOegEz9E3BdqlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569835; x=
	1738656235; bh=aaKX3h3MuODISzMKmpXzs2xZV9EBckEQJw8enTgvH0o=; b=u
	6vhwqgugx3L69F8KRHgB3cCVhSaJXASfnn3BDYFX9EZFfSiumwtuXFNFUx8alM2I
	GdQSbEkKvBk3iSfHacxDQQGO+wy5OzLZ4GXcRfg/goc/GiiNgVyd8cor8EDNidYJ
	m2Y3hNYf8osfQsUopyqhjG52Mat1moIjHJ1s+Pz+/CbYFEf5PvvMo5MasxE5akoy
	t3bGxKcclWibvMDahit5yW7E8Y4rbqzWCq8IQM7kRxkfG7Uk4a64tOY9OPf1XFwx
	XoolxRtqx6M3ChhKCmzjLdZtO9h5otKt5BVZ9UAbceZcyqte9cLJ+oHJ36dodUY5
	Nyas0Xq9k4GyntyMzcXqQ==
X-ME-Sender: <xms:a3igZ78h7toC6QWZbD_5vUhw8KdDrqwTafq2y0au4m7Iqsx-XQYw4g>
    <xme:a3igZ3sUwC9QScfwftolZgM_0Jwyo7dx8QMMaBrjZWSojXnY4qKntavMO4okH_uii
    BUmYuGHXk-4MAwdLw>
X-ME-Received: <xmr:a3igZ5CS82mB3e0vVHCkx-ut1JlT7Sa2e3PmKWz1SJgXJH856OYSAu2syS5J04hqBlTmwmLz9_4ZArxbMezhjV3pkbvRFvesM0_MSvbKIUF39A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a3igZ3czBjTsBlOh4ohNrShXd9XwqfSlrw7ql_HcG_3eFd5gjbdxWw>
    <xmx:a3igZwOY2JhiT6mVuNvd9S90O-WLPFtZ3v5yxJL42gw6ARXbIXpO1w>
    <xmx:a3igZ5kHdupUjMUr8qtO1VE-XzC5fSk8ozunxNI3WdEFS4FZvDJF1g>
    <xmx:a3igZ6tDvgDCwOydIPpyR0VllaVAbJH3h8bWkpZwIAopd_TEeCfeGA>
    <xmx:a3igZ9p8NpZ0QMjXxrQZtpETL0dVYeA7k2wzUPDpQRrOM1bg826j7tJH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b90c63f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:43 +0100
Subject: [PATCH v3 12/18] reftable/stack: stop using `sleep_millisec()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-12-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
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
index e22577ec77..7b0b10cd38 100644
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
2.48.1.502.g6dc24dfdaf.dirty

