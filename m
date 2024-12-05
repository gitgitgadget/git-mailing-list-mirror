Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B991D5CEE
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391416; cv=none; b=IEsGE3wYVOuoeYjhuzWJtKTzIEmyBKsw1Z+Mf6GTn0QwA1J2jrOtFJkL6UnAfWVwTrAJ3oprwp2/Af+R6g+AcdTI+yMp9UBOeh458W+gWXoMysMlCm4b/1ujxHf5Nj5vX+D2ZVqIMg++cOCHBgauX1gCA7O6+Mayg2EHA5zTSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391416; c=relaxed/simple;
	bh=KB1iPDo37816jUbxvuR2sy93KKs96H5bcCpgcFLXcXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr8MRNieKRFCQO52TZ8JEkuKlidyIa4Vg0r/r6pyeSK1lQKvNy/XV9LOrwxSO9vbJ2puKn6l2fYEG910XH1NSIz/WkxYM70C6kQLqOWHvyxwRhtr8thxWM86ZhKvUgN7sd0ANGIzIN5nJp67k2okNVtKEgcUOBs1EsW1VQtbJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nc4dNKLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y2K9/1gU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nc4dNKLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y2K9/1gU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 01EB11380B86;
	Thu,  5 Dec 2024 04:36:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Dec 2024 04:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391413;
	 x=1733477813; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=
	Nc4dNKLn9E5m9BPPEmtCInk40+iOW0x4PCyVT12OeZFDr2N4Pz4wfJpBBhrHTMIK
	FJ/NIpZQzvCuVd7rm9NRGJyJcxgfjHWjFu0StBhwtSmRSM3gQMCHqzQKInw6LgbS
	6ScIbiNgczcmhbr2QWGabWIk/O+jBjsVEG5Weur0n3YPTaudjKHpLG3iN3UfRawt
	4WhM2aL/sokivNi2pRjlQcqr5XKSZToXGAvgLhi4p6QxLAtJnipCwexSjSF9lMSt
	jS4X9nc3vQt9+98Hu1LFoWrSE7UaYkE8dnMJIsdvt7aCslldyzEiGEWZU2WadRak
	OvvNuv0H/jBom3245EyfTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391413; x=
	1733477813; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=y
	2K9/1gUbzJbwVn7T9VeDqt3tC/S9tqFCna6te9r7BBCJ+w5OGrqlHL5dGYlHhAxg
	qfrRSPom8LhlSeYusPsnuri2e0tqay+ikCp4849GOeRNRu7hfLIGakkUx5QYsBau
	yX/9dyBBUDHkWBtXusGYKY8lR1kTbjwLCpNh97cidDzETYCUnB17SzKP5WBJptiY
	1Xbp8BvcOAodKjBuc6eZRe7+J8OO3wPjkHEmAwKXElBWO6zr2WiwSAumg6kInLd2
	yiW9R79S/IqKopsg+MuRJfubKKEfAKQW+E8fOMYCzXhDzu0nMk2yGWM9kh01Sym8
	NLFO9nTx+FBa+oSLc3Y6A==
X-ME-Sender: <xms:NXRRZ3H2nA_ZXyNkyJUKqEb7Oyj0pqhh87eXOjyrZYwlwB5FvNHwjw>
    <xme:NXRRZ0WQYCGTRkNNlQrWftH6ujAMGKuEyRU01f3c9iSOH-xIABvtM99ch5TH0KDeF
    HN2bqS6iS2F6hS6FQ>
X-ME-Received: <xmr:NXRRZ5LDt8SjlxSOuz05d6EfxRq0g7008CxgLto3P8n8kxDpo3Wx32DQ-xb2sq7voR7q_8rsPXepUolzfbSODwPzkNvIwcDKVweMdMipFYgqMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtueekgfehtd
    egleeukedvkefgtdfhfedvudeiueelheelgeeujeetvdfgteevteenucffohhmrghinhep
    mhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NXRRZ1Hdbge2AMEVlFub7BOlqvd1P_cUvaS96iiNn-kizcvNesOviQ>
    <xmx:NXRRZ9XF-kVn16LRGKT8dMRamNO-9LL3OhkTrLIdUv4gaS0p6PWqww>
    <xmx:NXRRZwM2xrBiPjno8twOlx0CzGFS02CnkWlUTLfQ62A5akh3Bd5SVg>
    <xmx:NXRRZ81CTTAmbMDu97IZ3hgcAlbOZNpjxnvj2Ouo8vfabKNOkCHeog>
    <xmx:NXRRZzx-BYaWoUpJGPd2j2tNe7qI1bAy7YVmmM879mksCCo4-X5bqdFC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 161bed59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:27 +0100
Subject: [PATCH v3 05/15] config.mak.dev: drop `-Wno-sign-compare`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-5-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There is no need anymore to disable `-Wsign-compare` now that all files
that cause warnings have been marked accordingly. Drop the option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 8eca7fa22823b46ebdf02b73d53031784fd5ba2a..0fd8cc4d355ebb7428e1d8258154926dedf8827b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -53,7 +53,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 DEVELOPER_CFLAGS += -Wno-empty-body
 DEVELOPER_CFLAGS += -Wno-missing-field-initializers
-DEVELOPER_CFLAGS += -Wno-sign-compare
 endif
 endif
 

-- 
2.47.0.366.g5daf58cba8.dirty

