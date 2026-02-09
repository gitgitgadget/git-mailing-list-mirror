Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD583002DF
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658584; cv=none; b=b2+dlsPpQ81qNByWmF+9wUfdWberopnU9Dy9T3/+lKj5006NckcDopqvxo/gGVA/628z9TyZGyMIJuLdnsUft7Rxq5zHl8eqtzFvyXHyuZdu6tX+WeePy4+fGK7cUy5y1Pr1pUvZ3+lV6KRMOzFlM/RcBQZk+qN142PDS5Q7ECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658584; c=relaxed/simple;
	bh=bOnjbsv7R1iRaQx6igDu2+HxyjOp5pWNjmzlZK6Zrt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+m5GiBMPScZEIj2/BTZ6OnKzjFSKAbXUii8EUE1i2lyR9xhAD5QVIkBWyA3n1w1DZi5LDlQSENYsKWSXCrIoHFfecu3KNJHu1YFW2bjvysFS1VNwRXinYKl/Fhv0Wvu9ue3m3y39+OOgR60WaWlZHQr+NygKqAUYv0Te3Hc+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CXVs02FP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B7y4hfA4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CXVs02FP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7y4hfA4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12F1B1400182;
	Mon,  9 Feb 2026 12:36:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 12:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770658584; x=
	1770744984; bh=HEpnIgdML3/WmA8uqry1/Yjum4+lmPAazOzEqxxYytM=; b=C
	XVs02FPn1nmbIHT3nte4g8Hzjnd/Zyb51aMbF74vj2np2dpsbKXfxMoI/lxQtAI4
	3pzD83V/42Y1J87wNy3ZiLFF00gpPjYBUjekpkfmN+Ge6i5xFcRed3QrQAMpW/y6
	AxE7RLs+/S6NEVWAvd4u5wLlPEpyavoV0qpXSctAS/MibJ4W7t7Tk5t6EF39y1lP
	79IinbDjAMCm/7aHNhor4J5TM/yWysNrX9ylMd+Ag78zCvg6dvathH5ARGHd1Gkt
	5ChfOZWVZs1B1CGPQxOFe6HfgnfVdc2KKRdary+elproxWEsNYLnLLQ50oUEuBYt
	vWyQjT3w37ReZ+j7UYLYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770658584; x=1770744984; bh=H
	EpnIgdML3/WmA8uqry1/Yjum4+lmPAazOzEqxxYytM=; b=B7y4hfA4pc350KIzU
	7PXpVkecScRUmP60v0gG+L0ezLY5zznPUAXSc1Axr6RBVPcldxSEa5rwHhtlyjdI
	d6VPPtddaN71Hm8zPwz9Z6PdwVC4bgLl2BBvS73FARzf4ps4gBCoNZ/blydrEm1H
	M7ou0VRgSRyOIVW5FAf8cxLelChUMXKd+VEieIa3ziWhBlEdKYcEyeYJUx6hmz0k
	d+MmuBUXGT20CyoySJt8P007fLBL7Z2Qms0j3Ca6bIeVHSr6awqFl4M3Ar1s0Zft
	LnJksZncfvAOzz+dSFLe7Ze6lnRx2TtLRA3Tla/LfK8K+oQwXpBFsdotf6cfDMUY
	GV5pA==
X-ME-Sender: <xms:FxuKaen4o4cORcPt_aM_KB-rExj79gdm5zW3r86WCCdJ07xu9tSD0Vs>
    <xme:FxuKab3w0W_MZIP-2W49X3XYLM4MCFS08hx9FfzrS_hVzZ8y9dlsUITE2a0VODC3X
    vbDcJiJahyS_Wr_DJMEF616kDSb8IsSAW0fEmBnOet5YYmH5CYmgSQ>
X-ME-Received: <xmr:FxuKaaREMkNH-2D-6mtVKLU8k8fgV4Msh33yJfZ3mSwfpK9kYypHdhO5-LPKU3DoFawgJQvFmfKemFTeGN-MkEH3wpFnAh4ncIMKyXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:GBuKadvaHG3xuWZCpfJosMtBu-akMmANN4DQZgV46Gkm-wAp7E20ig>
    <xmx:GBuKafZulPcgI3TIdNXMkcHtOWKeQHNwXUA7lta1sykCjDjGr96KGg>
    <xmx:GBuKaSsuRAKNHE-ycRlyJYv0pfEl1Ibakw8IP4cNuRNuJFU4EoUbuQ>
    <xmx:GBuKaRH9uu1YcpmM5q5rRIPqyAdDOxoqECNLQI3lc56dL8kHxujHqw>
    <xmx:GBuKaZ-vHBnHd-zdccaMVpLWaKDWg7PEjJVmrp1D8_ZiDPqpdLZqeGKY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:36:22 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/4] doc: am: add missing config am.messageId
Date: Mon,  9 Feb 2026 18:34:36 +0100
Message-ID: <add_am.messageId.324@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/am.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/config/am.adoc b/Documentation/config/am.adoc
index 19ef5aa00c4..e9561e12d74 100644
--- a/Documentation/config/am.adoc
+++ b/Documentation/config/am.adoc
@@ -12,3 +12,9 @@ am.threeWay::
 	records the identity of blobs it is supposed to apply to and we
 	have those blobs available locally (equivalent to giving the
 	`--3way` option from the command line). Defaults to `false`.
+
+am.messageId::
+	Add a `Message-ID` trailer based on the email header to the
+	commit when using linkgit:git-am[1] (see
+	linkgit:git-interpret-trailers[1]). See also the `--message-id`
+	and `--no-message-id` options.
-- 
2.53.0.26.g2afa8602a26

