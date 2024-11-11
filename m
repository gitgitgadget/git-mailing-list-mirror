Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8E16F265
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321532; cv=none; b=ayGRX8X+Mam/tFPbPDPHe11zMZMaaWkIfTiUODSWGXBXBOtlwWoMnABtaUhi/uEBe9POJxun+mYDCXFGTOq6/8mdFgSQeQ4F/4Tlzbj9VoUI5DomQID25iaUFvF5HBBcel5GDYV7CoALG4pgHoaTAhxR1D0VK8HmhETGrNGw71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321532; c=relaxed/simple;
	bh=XBr3ST446l54yPj/D0VJra8dw0f/W03f0AFUmY1izkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usBIA+BV9Mt31x7mEN9ViMDBCur+7qjdMD9f9X3pXb5wRYq7M8vIEDTaF4z6K2KlU56oG/jVHINyPJggN9IGApxHu7TbApeTbAauVoTYRyfZlLQzER9DufowkpMOs1S8h4Ec9hLLrpYgCmd5v6PQux6oFrBAkJarTRcYYBoiU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FiOvTsfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8qrKnJ1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FiOvTsfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8qrKnJ1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E62D114015D;
	Mon, 11 Nov 2024 05:38:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321530;
	 x=1731407930; bh=mwmriR+9a9T2xF5nv77q4h3VSuHLM7smmNo5QQ4CnEQ=; b=
	FiOvTsflSi3leCbnD/V4J21N3btS9aAmgyvm8b8Vz9kmJGQSu4dlslFhr5hNsuL0
	a1yfZHS5n7M+65FjDlulpGSV0mQwo51wK1PyLiI0HL3PzSFT5hjfNcf+skpnECkH
	t9RXpdkucV8ACxd/UacE1AFPLK+pkBiYBQbPiyU12QJVVE5KpAKVA/JeDbCLMsMr
	88Eq0t4nUE0gkdc1nnii0Bj4G7Qto0sKAgCOPQJhoe9Ag4ZI7jgZ93qftyNUebdv
	hDqxNYwleuzEvn+KHX5OwNfCf/fxgJlQ5OPi1c1/xZrEfbvu6oFm9fOkcKZAbZiQ
	+queyPfcBcSR7pWpIP7Xsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321530; x=
	1731407930; bh=mwmriR+9a9T2xF5nv77q4h3VSuHLM7smmNo5QQ4CnEQ=; b=X
	8qrKnJ1RnrRb3WNKcCqit1jhVhi8qfJTCo4cBqJVM9dNsLYmmDyPDYiA4B+iTuVN
	E/Te4u22K9vQiOrzqot1xJhkhAxqrkXQCYhGNDW0h9zuhCie0bwPauUfDzwLSmMg
	zr7j33oBKLaiOMuQs3V/0QehRk7joTE9SnSHr1xBN3nNtMRbhNRbI2BQ9oWYypvE
	WMeyyUCMOqcLQHmm+0fOn3Dq4cjxgr1xLAfzQRSa5EcQN0H1An073EhgyoZD+mzk
	9icma6RiCTZXH7NtKXuCihezC8II5i0kxiOBd/R/Ijj0gyz4qqt8jADIHW50hF6x
	arm97OOKhilLF6D1etL/A==
X-ME-Sender: <xms:ut4xZ3sVsJiIEarji4Ec7qQTE2CmwVBiT0urXInhIUEQc7sVB7PJPA>
    <xme:ut4xZ4fDn_UVZqZrJa7dOEnC5faDbw02zpG0giYxFtURd4fnBdWYTKXXOjS6cGH3J
    pT3Ldk1xgLUMPpsCg>
X-ME-Received: <xmr:ut4xZ6zihWi2SfP9Jt4FjSY7CpV2U9P5wNfgvnLFKE_J6r5yMYzCr8JznrHjfpJ8_nPCZc3f3VsggAi0Cc0m0LMKnE6shdgGO5JGInxRHnbvPdFG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ut4xZ2N3Gy5OlMr6mIUofT8tc9SA1we0Wl2XttA4k8SC7E7ol1Wspw>
    <xmx:ut4xZ3-LfHRESnQXZo2y7YWI8e8beNHzEQcqLGAOMy7XGOX8P6JqQw>
    <xmx:ut4xZ2UbVrqocVgZ93WrvWaF0jqARyEO-zD2T2TeBPzU8lJ32HQvUQ>
    <xmx:ut4xZ4f5__xF7_R0UprMw1Deo_jVdPWErp7UQkVAPSilmG7luIKrjw>
    <xmx:ut4xZ5Lp1yXIO18z0xeItOeDsre5u1al96uIQhS7rsyJd_UuWbN4iFK6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf08ea2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:32 +0100
Subject: [PATCH v2 03/27] bisect: fix leaking string in
 `handle_bad_merge_base()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-3-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

When handling a bad merge base we print an error, which includes the set
of good revisions joined by spaces. This string is allocated, but never
freed.

Fix this memory leak. Note that the local `bad_hex` varible also looks
like a string that we should free. But in fact, `oid_to_hex()` returns
an address to a static variable even though it is declared to return a
non-constant string. The function signature is thus quite misleading and
really should be fixed, but doing so is outside of the scope of this
patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index 9c52241050c14ecbf3f7950a0c5e7b962fcaa541..e9e603877eba059c878ff92bc11dd84553d0649e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -801,6 +801,8 @@ static enum bisect_error handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
+
+		free(good_hex);
 		return BISECT_MERGE_BASE_CHECK;
 	}
 

-- 
2.47.0.229.g8f8d6eee53.dirty

