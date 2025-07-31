Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5D28000B
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002491; cv=none; b=eg+L2qvYDXMHB0yEQf5CmhzV8WATBiAy7C5oskmcOiKLTxoJu0it4oVJ2SGhnqvHJsWQdo5Kj1Jg/B01wmqv8ja9uQ+eXzNmD/NCXzH0Q8K37kkl4We2kaPD6WUUH1PqhIaBECk1Yidvk3lgcBRPgE6/zq8mvFgmL2NR6LB5200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002491; c=relaxed/simple;
	bh=bmEvk0WV2X3pqilCMRtYjpiMeD0u6iL5KvMCfshpS1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN3zi6QUQLyiWLJD0NO7CgSFCQQC/A0dzQ7RB8E6KEst8ybqTIGa3pr+w5M92UbPjQTUwJmWa0Y4b33vEu77/iOpcZQfdMjPKF4Bf2IZOtSDoF3FPovOPUaQBffcFGh8mlm0W0EFSC18jvcCZz0QSrHHuBK2Y1fontaeY+eXe0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F+r/7CsM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQPC5p7X; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F+r/7CsM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQPC5p7X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A3A4EC151F;
	Thu, 31 Jul 2025 18:54:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002489; x=
	1754088889; bh=dJS6U7/CLwRvRu29iRN4sFXNhoiHZB2WrmD8EBHE/uE=; b=F
	+r/7CsMvqAaGW7wSkjbsOBYlikPJCRaBTLYqFF4gwds9mfjT6mGnS4qcj09l31vn
	+PGagCIghqnvYqG+3MmPEOGILaYlbfS+zgCHF+QArOWFh6F6sCU46TEQ+gF+kqlw
	WVDChAmVAA6L4ahLV9sdCpegFdfmqv+JMUVuRyvoMi4FmeZOEZtd7WkFAp3FZg2A
	tX4MuJv5Gg4JtdjW7VFRudhkklg1F/qS7eVdLiyvJga69js5iCcjk1Xhk/iYbCQ0
	rCkCkNT9Uu07cT4pp/N5avOYjK/cep74dEr1WhsJ5Hr9wmICF5NtNWKfSEsyycKa
	ACrozGcG5R4xi8IDO6Faw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002489; x=1754088889; bh=dJS6U7/CLwRvRu29iRN4sFXNhoiH
	ZB2WrmD8EBHE/uE=; b=VQPC5p7XgIgec7ZZngbW/V35QAbJx3iRD2sxHQLT+6w1
	CIsN2peuBhWZkhMcmdgZISQE1bS0ozNlmje7apNnOmguAWlo/cGN76EatzpAT8RK
	IvoThuWSqMfU73mcM/dbkB+MjnKlLVJO5XvLkGI0OByfQbl++PHivq7OzGA92BPr
	VxQgZAI3M9Sr4bfwKKeOWZIyPFcL1wsvmluRIARdUDqLe5LTYSBmiDnI9MGwUcCF
	iJbXtFWOwUu3vrA3jCvKEjCrUzogHbxaDwSigAo4LGJWWcVrdlqBKpXgsumfAZvF
	scDso9o7RGS1N1APVrZN93bQo+WBa3Aa2KAbYoTDrg==
X-ME-Sender: <xms:OfSLaHc3ugxv6dA-nm1t5AC3jRIo3YzfxNAp_Z1tYZpeyhg2EFjclA>
    <xme:OfSLaNZ9G0FDEuX3vOMUEsN4yebJYu3ummxDmcM4HM3Mm3TTUg-K-9rLZxOyfvcGQ
    9E8HAP3orCQNVSVBg>
X-ME-Received: <xmr:OfSLaCUh5Si1cjotOGPPcYbdy0qntuNhulQ__hPGkMqSsPgO70x7h_Fhtl0_uT0KI4rPGjvR25AcZsjbFVCrZtulYFEpnBhwCrSrg6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepieenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OfSLaHjYONNdMMkNqEw5V7V82spRWTYKvjOEkP99-b30qH9ehInxFA>
    <xmx:OfSLaIXm5z2sUCWoW_KtHi5-xW_6xPp5nQuIw21USsnp5_6uNlrKKw>
    <xmx:OfSLaGNXCWkFMb1kNNhpaykNJcrZNT-6XrIKUzXI-ML-TPBgcc0CpA>
    <xmx:OfSLaMYekzi-JDPJH9kM3gBv514JcJ0eq1aKoQZyGQERDHUMGWH47g>
    <xmx:OfSLaKA6B0PL7Kg4hoD1fzxQE5-d7s7LZwnWhyh1FkNwKfghl3X2bdey>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 10/11] trace2: trim_trailing_newline followed by trim is a no-op
Date: Thu, 31 Jul 2025 15:54:32 -0700
Message-ID: <20250731225433.4028872-11-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf_trim_trailing_newline() removes a LF or a CRLF from the tail
of a string.  If the code plans to call strbuf_trim() immediately
after doing so, the code is better off skipping the EOL trimming in
the first place.  After all, LF/CRLF at the end is a mere special
case of whitespaces at the end of the string, which will be removed
by strbuf_rtrim() anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace2/tr2_cfg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 22a99a0682..2b7cfcd10c 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -39,7 +39,6 @@ static int tr2_cfg_load_patterns(void)
 
 		if (buf->len && buf->buf[buf->len - 1] == ',')
 			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
 
@@ -78,7 +77,6 @@ static int tr2_load_env_vars(void)
 
 		if (buf->len && buf->buf[buf->len - 1] == ',')
 			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
 
-- 
2.50.1-618-g45d530d26b

