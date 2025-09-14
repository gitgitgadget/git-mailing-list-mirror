Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D912B2D7
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879578; cv=none; b=eSTL9Q9MbXpC1qbfATyvRtKbWmYF2uhKTukqzlNHA7BldvurgcbWQJAjOH5cQyTyoEGmUc6IhcC/Ts24jvI3QkLXEMdcRJQVkMb+SuinnxHL/+Pj9JtDnRUMTrrt9buh3BPh9OmkH0IWyvU+AibOgErZDcGiNht+LV8q2YVboyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879578; c=relaxed/simple;
	bh=fHG1fSDNj9pEk07Zwt/08ZM8l45/LPoz6cMbB8NgcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUflzTfxmKrh+il9/OKTG3IYEB6+CFOHTjbOWbEbB2kl4dY+WPAyZVOA8eox48b3VaedJ3Cl/SVaDWuFH9Gew7uty6NX6RWaH2I7JK1j7Rq5KAYkK8axoKwNx1RpTrN62pYMBlzC4W5Oo1II0li7ZqAf8lNuUR9NYIlOGvwZI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aVkMQc8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CooaWTou; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aVkMQc8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CooaWTou"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7680B7A0060;
	Sun, 14 Sep 2025 15:52:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 14 Sep 2025 15:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757879576; x=
	1757965976; bh=BJ8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=a
	VkMQc8UrbVivp8Ox8N9BvZsNU76nPIJdBItJUwA9IIuUY8hwd3uLHtEsr19Bui4m
	TOy+CyliC2nbGcPfTsFrDihYU33wFKIluTY4LyR0NDI7/ljAIB4SqLbKkUmAhbDV
	U1qaGYQE+LAErRRyOXZD9tEvIWYDSNI/XKNfV5f8InOLs6H5v0qJeIpmIk+pFiBE
	RHgddBIInTULM+CdeO2RvP98NWurXeYuxIAU8D3u6dyvqfMumMmOQSlVAoTD4i45
	N15jW0/YZ6PtbvipQDcGTWeCCzzMDL5iWXqzV/aBBLfzNn93y52a6MrK56WwdEV3
	diDzzaZRMhJ+wD+RkVbXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757879576; x=1757965976; bh=B
	J8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=CooaWToucFiFWns/d
	us3CnRnxUZfCi+rS/TWhLLpQj6QURC5L4kmxCtdLKIqmwssstkfEUFTbWzdZKXe8
	NNX0UxnFk9p+t15qLQrB1EAcU/wg4bBqeDJPV7Qb2ZLzxYN1nB5BGA3DzxnyhLvT
	R7VYDWT10vCFZZ8/kFhJ/bPhBRmFu61SCDp3m87l8e35MbE/Pz7xEUnL0NoVb3fx
	gHD+V1ZOcyrDR3lx7EGQbRhQpr7fxNkmmTLuC4UOw54n7WVgCT5xJ3ywCbzlDJZm
	tTCONiA62kEIoufywe8tbLIL4X2zV8SZ9TMPpt0GqpxxJAzIBm6+OEYMw8zr1Vrc
	4MLVQ==
X-ME-Sender: <xms:GB3HaO92UomcPfadlcQdwEhIrl6SV9LCO1pQYQXzIVXrSKcbtCVsI-U>
    <xme:GB3HaHK4Dr7u6lt-N4aal3BgAwTzuHDZZ1kTxi8KBN9Dbe8FMM8oVP_hvi7nempDe
    QOZEKlPC8mpj-8B5Q>
X-ME-Received: <xmr:GB3HaEdkAO-4AFGzPSRX8K8laUxVv7ECvMH3Nu4KRcpFC706XmjZAAD7voRTiCAKsJ8Z4fEowntgHwmALPZ4vbbUur9va-yf2DEd5mJObyUY29ekwymtVO-Q_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeefheetkeeftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GB3HaG9LLIfebdcqH_hmUrYnAr1MIWoU8duGHF1lCegY5KkLYVsNAw>
    <xmx:GB3HaBr3JbWDQGAs__tKGB2Wd00slLYKAaYwzm-IE15Wm29gbtbZBQ>
    <xmx:GB3HaLAILKMld-wG8MgQ4akn9ecFbTYCenzGtD9UmFmhnWrKzTtimg>
    <xmx:GB3HaDzXm6rGWf8vSrzaW46QjTST9KI04-aOoW9wf_1zFw4TlEm_gw>
    <xmx:GB3HaNVlia4x6583CunARo1az5UjadyuhQPWjUBYwEB5eexr2U2wdmV->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:52:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 8/8] BreakingChanges: remove claim about whatchanged reports
Date: Sun, 14 Sep 2025 21:49:42 +0200
Message-ID: <5021647c2450bc124af20e5d7aa8bd6dd859e57a.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This was written in e836757e14b (whatschanged: list it in
BreakingChanges document, 2025-05-12) which was on the same
topic that added the `--i-still-use-this` requirement.[1]

Maybe it was a work-in-progress comment/status.

[1]: jc/you-still-use-whatchanged

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Footnote solely to avoid awkward paragraph wrapping...

 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..c4985163c3c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -235,7 +235,7 @@ These features will be removed.
   equivalent `git log --raw`.  We have nominated the command for
   removal, have changed the command to refuse to work unless the
   `--i-still-use-this` option is given, and asked the users to report
-  when they do so.  So far there hasn't been a single complaint.
+  when they do so.
 +
 The command will be removed.
 
-- 
2.51.0.16.gcd94ab5bf81

