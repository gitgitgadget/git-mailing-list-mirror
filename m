Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA131F0991
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648620; cv=none; b=kUTsiDB2bn97CyYH6LB27R/HnaFfSuuNRLrCyXjlLxeCjjTod7MW8Y74PeSG4utUHBNsVeCoiTfe9DwujVdO9H3c0EA3bc9qhuDE1qmH1JI5pGlxQPGvTRAmLU2K9WF6UQfyFjoHToVZVj5VvdhpR+HSzGFw60oWT3AoDlq6p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648620; c=relaxed/simple;
	bh=NjY9MR8euWGyLTn//7RSXXhHxs/lddrF/h06yyXNf0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML+CE+6voaNwLAu/hmzPiHwZjPmXgZUVW83KoN0WbE4f75mh1io5Zj2cX7a6SOJNBEWLelJe3psleCxTnuvzitmd26NRBkPMJYeMsKXDRSsIec7gXqGO1O6mClh13mvB4dLKMYxsGcBUpGGIJUatCngpZrY7+pj71yHyNUHEzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dncshxw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFjrnMTN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dncshxw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFjrnMTN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA44F2540251;
	Mon, 10 Mar 2025 19:16:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 19:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741648617; x=
	1741735017; bh=50jsIWvnosGWhMUPiWAUzmkd+s6OCrH/7tYgcJhrlGw=; b=d
	ncshxw4e9YflepBcLq3JLUYXtRvwEggVDA9iQi9WT7ih/ETK0rgFTtRnTU2L3p69
	6eViFkysD/pg+4upG8sLpuZclFqEu3HFzbkNK1FJfFrp2Ylq3dx3edzk8EN+jya0
	9NhBy28WNEhSSrjR2EC1xL1Gtk1NoJ48LLu4Ui3WPtvW7O/tDAhSlV0A0P7Zo7A3
	NCuhpq8/exJhaRFXpHptrdHZ9qBJ7TJAycpA9IVwRoq9vEA//n/tPt6rDSxeYSeu
	iSm3CrD597ZhQ8dF6vVHiNbdq6MIhJHoXKPmj5jJaQNGNoHMyfLTrbIzx4RvYBLU
	E5DriN8WPHuf+JupGr3UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741648617; x=1741735017; bh=50jsIWvnosGWhMUPiWAUzmkd+s6O
	CrH/7tYgcJhrlGw=; b=aFjrnMTNm6MU68A7pY36ibtIJg+Knhu0+jM/1ExVoXno
	Ko6n6N7be4UMvOeQ5eMqwcM0DxlmW2jm68X2uXLCA+tILA7VMComf0gic/b+6kDq
	lb3ocfKKM3zTMzrVtBCUmz+3FD3xyIhSyDHVo6AUwe3iygdKiVrtQ/lE+BKAO9VA
	v12YddojarHZ41F51pnIpBPRUdOFvEqYUeBZZkWmcDHj8sMugES1SeeSu9nVoxEc
	l4i4ILKX/qU5r0++RJNImPVp5WFkOWvUD/KJOxE7MbiT295wzai4ciocgzd66KdZ
	bclMKHkPv8kmX04mGrM+61NruKk6DPNae+EPmY7v5g==
X-ME-Sender: <xms:6XLPZ9Pma1kskezor0A4hUuVW-c4zshv3lXh69Qu2fNJHrks9kDhug>
    <xme:6XLPZ__1zBA3MFYn1LLwKnUnZIZvvdUSX6pIoC5Usr5wjiGPF7h5g8QeoMEtXivlL
    XRNFDsMQKd17FOAqA>
X-ME-Received: <xmr:6XLPZ8QvvCwifZIy2p09OAsRGO0BuuJMkJ2yz5_Fr3Yz_jpzEz6ajw1rR5syob20p3zLE_aj5g5LaPikzuiBAQ4xZ_eaS5elgvKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6XLPZ5vanWRCst7FKXFEZj369JMfVSifAPUoEOpn7q7CJnYrcGiPXg>
    <xmx:6XLPZ1caxdbLQLKZ7KhqKCIAVsO0OsbrLMIE2CkMB1RejTKiEZGF7A>
    <xmx:6XLPZ139sMKbpj7kB7X7Jd-EYCDD9_E7OiTusvjv504yGhiRd9nU0g>
    <xmx:6XLPZx8AV5MBiMkvJRCEiKwsPMxzkBeD6wHvtaabXqFT_KBIbsiK-w>
    <xmx:6XLPZ2p7Iq_QCi3PF4bp9NeYUP5i5jWL2HGk8DjYgbktO_p3FEOxi3BU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:16:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 2/4] t6120: avoid hiding "git" exit status
Date: Mon, 10 Mar 2025 16:16:50 -0700
Message-ID: <20250310231652.3742490-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-173-g4d16673c2b
In-Reply-To: <20250310231652.3742490-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of tests invoke "git" on the upstream side of a pipe,
hiding its exit status.  Correct them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6120-describe.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 76843a6169..dcb526e37d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -292,13 +292,15 @@ test_expect_success 'name-rev --annotate-stdin' '
 		echo "$rev ($name)" >>expect.unsorted || return 1
 	done &&
 	sort <expect.unsorted >expect &&
-	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
+	git rev-list --all >list &&
+	git name-rev --annotate-stdin <list >actual.unsorted &&
 	sort <actual.unsorted >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'name-rev --stdin deprecated' "
-	git rev-list --all | git name-rev --stdin 2>actual &&
+	git rev-list --all >list &&
+	git name-rev --stdin <list 2>actual &&
 	grep -E 'warning: --stdin is deprecated' actual
 "
 
-- 
2.49.0-rc2-173-g4d16673c2b

