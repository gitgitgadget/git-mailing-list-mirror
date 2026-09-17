Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34C4848BF
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674882; cv=none; b=gS4FPjAFDiWNvsV5JzuYISIifx2zuJqyQGzmoWz3tel84uBviPHdHEYzaTnI8htjMxe492odWqqCA7Q+wi4/ma4/c6KcREepEEU2BZVUVOMhO40Eqr1aiZJJHBAyahDb6no0PV6jK0ESzjmtleSHFi9bSRyJOs4d9UGJiNL+mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674882; c=relaxed/simple;
	bh=sDE5u91vA8Jq6nCSjFNSaD+pruc61uJGKGbF2i+bgLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEB66gRjyetOHGZdpXUtqY3GkmfnLoSSw2V9PVKCflg/stpqII/lC9AX2xCU4AW2SVBDkcwNvkG7BOpSvET7CdVAWb8r8FOaK1GWcYTdtswfMZe/Mibo63D7dLQrYe8ZXzPJqHqus8UFR2HIHhoKAdLFD5nB9H5wOAx3aaRQKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nLG00lRS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=so3OE2IJ; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nLG00lRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="so3OE2IJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id DEF4213801FE;
	Thu, 17 Sep 2026 15:54:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Sep 2026 15:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1789674878; x=1789678478; bh=LRs0iCFs8M3dDJZUnAvvm
	femhFgym+YIJK0zwJu69rA=; b=nLG00lRS/Gv9dSLaIgQOIHxUC5xgcQgEjpmb1
	TTQduYZhL7d8cO+qZrhkhdvZmuqcFodt+zWmE15kF/SIbcurMxaqH/ieFnFkKnVZ
	bxxMvhwmrMLYIiifM30qt/Rr+mhbCzgiKMB74ZOuiXLAvuHm9eYdZsIxBxGGjSy1
	QnoRSGz+0iLu/N0YBK0p1vtHJ7VQvfeUOn1x7BTd9XlB+hRZ5+a6RggZLh8TCwPU
	CKECqygTSPD9U2rMLaRsUoy0LDDtVbVD3zG2KCw9X8olZEIel6IJvLoWxQXB9wK/
	/88YnVtqhZ+YzI7ALu/4h43g9Rl1s84WRaRNALdm6B9/SPIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789674878; x=1789678478; bh=LRs0iCFs8M3dDJZUnAvvmfemhFgym+YIJK0
	zwJu69rA=; b=so3OE2IJH/0W1kx42X4ZJsLNai/HL3zArFzXawle+l28ohZDH8L
	bwlSf5BQOCPCR8njtokjL4VKwhvLQBheNSkj0InBPbVscZKXe5RXnz1fXQobVFv1
	Lu/tRMSjNAx9qg6htd5SFrtcpqo0pERM9l+CWEXYwRHPZlv+hgO1+d3QC+yrzNxC
	cNUjIUjs73flD4BhUhfymdCobzoO6zdamvT+ilLAUGU7YNbq1lEI0qcStr7iTi55
	HUJn5zYZngJj3Z6Y0sj/oM4O6rmDAOZtWYdPWM3xbKnfyGX8duWMnh/6ShCSlQ/H
	+fnLSMOLmM3E/mdLkVZueGAVAx4jtoPN1ew==
X-ME-Sender: <xms:fkWsasrUItznEp5FjEhofL5juPIiB_rCkj19bPxfm0n6LYddzZxsAw>
    <xme:fkWsaoq1zTSG85Nuc1ZAL9c04CwPk7OiBftoRLix12puqgUojSJcqGCbRo3rCTpmQ
    Cfh9hemELvn4jO2wVQf31_6s-X-URq_RrpAyoKEg3MUDUH68fEO8v8I>
X-ME-Received: <xmr:fkWsau09MYh4F3is8dTc3Fenn_OKZDDF61d2LijdXksK_DeaqkMxzY9FFCqqkAuSLWTkMIX9RoALHwQzL9EbZUCw_yepYTaspiZupowuxYlYVA>
X-ME-Proxy-Cause: dmFkZTGHn0Qzy8C7CZzwaXjms+hiD3Vejc8kqB0qTgoVskBAGy9hklZ5Etspwgl+blLQzb
    cII4ulE5jdHJOlO3KWg9je1PzcnCEMlNAJ3XVXq81P1OmxTM+q65T3xUfRvo9UaRCOHa8v
    oOnBSDhjMDKjlC+0y6pIQDZ3eXe7do7qqPA+xMNp+JNa1dNrMctvuxpEogEnxZewLg48E1
    ShhC15ZSqIdVutvbq15TW9vETfD7PtgJRME1VpEdr7zURwf0xcRuSquYyJTdnDolhVDdVo
    AKaBswyQ/QfC9Kz0oGAnDJtWu1GaXPmS5zAJZSuL3SBl6taHBv8x4theAHVhLwdT6AkQc2
    Vzm8kYQjBP4beqY4ymblKyO6IE35LYz8eTStIeQ4/h2hOLTOKmWRO8w+yNCinDUQxxSolp
    VY9T/nn2wtYUmV5toe1rBXBR+MnXnsQLZlTG5UQzRjhMfhQzr9iUqyQRytjkMXgjLxzIJS
    BJOVOUpbpJuDZumm8KKNDEd2a+p2/fk+0onPkg2UgrGzMKgC3nlMTmWPrPyo2GkZp16d4J
    6q9S6XMX68Lr6MpalS73WZ1cxXvMC6hCv2qWsRXSoOY5RyU3Z3uqOf13uT5PHESZF3XYzh
    MZOSqkv7GuUQWSpHH8PbGXcEPD172rJk/w9vGYb5Famy5ZIEEUmFVjdts+cA
X-ME-Proxy: <xmx:fkWsavCU8P5mbtwrmeos9KI_NOCuPWf_JDVFsMSeBm2-mOnNWIA9bg>
    <xmx:fkWsaueHRQkaFzKpygoc6hz8S1GdOj4TwiYnjlGzNPtDqMjCwn9sWg>
    <xmx:fkWsashSQKNnag29cdl85bByR7ugAP3yav5-Rv7OcHeLM1GtiV28cA>
    <xmx:fkWsauqht-hvTWlnsvXDS68mCAAobib9pnrh5WlyY05CqJjmeJYjFA>
    <xmx:fkWsaqGzzTsrL3s2HlCUMAVHr3WWuh6e_8HftXxfHfnFfi7DLOOH9XfN>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:54:38 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 0/3] Update t40* tests to use modern style.
Date: Thu, 17 Sep 2026 15:54:33 -0400
Message-ID: <20260917195436.1102981-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t4001 to use modern style.

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4001 to the modern style.

(Note: I somehow munged the b4 state of this series; I've done my
best to fix it, but there may be threading artifacts in the email.)

Mark C. Chu-Carroll (3):
  Update t/t4001-diff-rename.sh to modern style.
  Update t/t4009-diff-rename-4 to use modern style.
  Update t/t4010-diff-pathspec.sh to modern style.

 t/t4001-diff-rename.sh   |  97 +++++++++++++----------------
 t/t4009-diff-rename-4.sh | 131 +++++++++++++++++++--------------------
 t/t4010-diff-pathspec.sh | 121 ++++++++++++++++++------------------
 3 files changed, 166 insertions(+), 183 deletions(-)

-- 
2.53.0

