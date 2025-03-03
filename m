Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1E2405F1
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034718; cv=none; b=lHMEfVFR5k9U5qVdaLOXcNLHJvlufzaBf6cCTYN06tYrzwOtWEs6J50+xpnvNCYIWZ0n+llMOh0D6uoEOsiP0a4PaVN6qBvqoOtVmobveMaSbvVUTYquOgLdxvk9LXgPchOdIKN0ArNGFhdcyHqZ7jtb3Op0BFiuaZK6QzSLqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034718; c=relaxed/simple;
	bh=lOsY1bWCkRnfOK3sICKD0uHWr7EmebAlavJTnEkR9Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L93tguBRZjBDBs5GIP0ca/etkM+4/5DUWsJNOAB8P1aUvvU5HfjPUFv2oPLBK2SgahGY2hOWML/RRCcoy1kvt+5iHvho73SC0dGT50cRY9N0mgpHk/JA6g9qkPDRp4JjEpnLL6b9BxiSBgLg++QrYtXJSzOeU6csr4yCfCVyFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nQy4pXuw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTfzSe6K; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nQy4pXuw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTfzSe6K"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D697F1140143;
	Mon,  3 Mar 2025 15:45:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 15:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034715; x=
	1741121115; bh=xVW1AAIJDZMjaBX1CqdfW3o7DajSRB313BafiXFwrQQ=; b=n
	Qy4pXuwC1NXH3A2UYHpR+1/J3VhCqjPvPz6GbqilxKEE7VVV6Eliva5zv+t05dqa
	DQ9Zaali05+1tX7vxPKPi6u/CmrraSHEmlwUFuTA9Xdeu7gzKJ1zlQ2IVyyTtDPL
	ACVtKQJowe8IlXq6QPB0hQ68cwHys89aH43sdiLItE3CX3NBeXLtRctMU5eGbdZ1
	XoPXOvFBy5J/6I3W8cDXyX+gGounQqwQR4WjlPNvBR25hJsKdawt9J5wjgOLAOz/
	4wzoBOX/6fwYCRi25fvu2AOsKmtLMgqTtWLgdvVHYbXRqbp1ZKWxOVYSfEyWX2ig
	0MmtBGxG/v9iv4roOr5zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034715; x=1741121115; bh=x
	VW1AAIJDZMjaBX1CqdfW3o7DajSRB313BafiXFwrQQ=; b=mTfzSe6KepiZ90drf
	DPdWYWzreDGtyiQ15cShZ8ptWosbI+XXYhQ8klwfH6Zh2MJK2wMjVL5nriHU0WL8
	1j2+hLH9+XCqiRG96Lnstijd/Dtv1bGRF5r9g8mSsgGdH26MSzHbk6nxfcTamHRl
	4FeulX3dvo2Ung+m1cejs/3Owdrk9oJxe8jkqiFmdgvXPGoHor68uFgGw+fy2Z8l
	xGIp9OXl1e9qtWbzIBk9r3EBW2cqiQ5BIBJJBd5ob53lw8gsikBUm02PHJGVC03n
	fOSE5rVhA1MmPOrA4S7wHOBQliw53IrTn764LqGyJZ0mX4yRiK0JRU+KEZiSzvTh
	2fR4w==
X-ME-Sender: <xms:2xTGZxLG9zx23uyWpFrUIw2Y8nBrU-iVGH9VjuTAseMsVqMTwF0Z6Q>
    <xme:2xTGZ9KdAQ73STNHf446H93hcKTFbIsnD3RdPUXYd0-hlVkrgR08z2WOv97zSQekB
    iKZPD-rIxBjmUd-CQ>
X-ME-Received: <xmr:2xTGZ5s2c_vDZmAEZ7E-STvXLknPkTY6JCDYNBv79B6_wD2ZQgD8wOOdfvn9sBy6B8HGpkGLp9BmfMKhvsrr4ldKt2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:2xTGZybu5JhnCEOiZnheF1CA_4rPB0vIASbY2c39ma6X3jU8spabUQ>
    <xmx:2xTGZ4ZOu4KsHneULq2wi7A5Eiq3-VSk89nfvSw9f3rNYHrvlmFRfA>
    <xmx:2xTGZ2BvuwrhM0U2K-vYY2BTLtrTG7ncHGnoJG4oHJKOyW6YzgWqkw>
    <xmx:2xTGZ2Y9_FZ-Z6QZY0DcFygB2xvaCrAKwxLBCEdhFLqHCk3BmvlLew>
    <xmx:2xTGZwFh3mq_k47aT51N9gnmucqVcHmeMYmVjy7QAlmXuzHZCN35Sbuj>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:15 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 32/34] transport.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:30 -0500
Message-ID: <20250303204443.360595-33-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 transport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.h b/transport.h
index 44100fa9b7..892f19454a 100644
--- a/transport.h
+++ b/transport.h
@@ -168,7 +168,7 @@ struct transport *transport_get(struct remote *, const char *);
  * Check whether a transport is allowed by the environment.
  *
  * Type should generally be the URL scheme, as described in
- * Documentation/git.txt
+ * Documentation/git.adoc
  *
  * from_user specifies if the transport was given by the user.  If unknown pass
  * a -1 to read from the environment to determine if the transport was given by
-- 
2.49.0.rc0

