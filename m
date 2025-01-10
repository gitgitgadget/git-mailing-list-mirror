Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50220B1F1
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508388; cv=none; b=VTAcxiU7i7KlEgn5S43UMe86oHfjXPSb0gaO6lxJPgw44adLOQFcXYPVM0rX/N5dtJ694d7f/HUVipEW+w2UzDaz1cakiZ+Hpprfuob/8axDSbwXOEWaV2iLt3asnXTe6EuGmfOZI7L9Rf86U9oSLAKthuC65suEFGjMhJjmOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508388; c=relaxed/simple;
	bh=9Qv9F4qiPOvPTXUsFRFBmGJWID0W//7vRrtWgG2USFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=r5khrfB59I2ztvj4wmStaiFhWBcj3BpC2E1PIsRhBeyfrZ6kOQiDMQ64uvp/As8ei2MaZ53Raqziep2EUOH8uxFp0lMEVjC3onSmsh72i/aYitQeghGwlqlu1i5BMAoYfWGoTifZz/R6xYebXir2L3tbW6pwIeXLAeWNBAHDgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n1sfF8ws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qY+/lB3G; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n1sfF8ws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qY+/lB3G"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A0DF1380BD0;
	Fri, 10 Jan 2025 06:26:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 06:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508385;
	 x=1736594785; bh=cxKXDjrTIsAIqkYLotjFaJ3ksS+WHoQ7qvP20IqLnSY=; b=
	n1sfF8ws5na6vPaBauxwivOyF+0qdTrKIK3Lib0d8N+I6+QCaZ0gv4tALuCY83gb
	BNyhat+sOb6M+GLYmuPaVGpfDO7gexLboiydxEunGVPqGlSkQzc15fa5/wIxRU1D
	ydVs6V49dDJbeIwq3DXZDELwfcnb510+eKb1DxcVC0YBWPuKI4qYp6WqiB2J7txj
	OIlCrz52Wj8/yiQZupQ0+IOdF417G1Q5uEaiLoScMo53R4nmXs+BqdU7S4D5Sy3s
	crhOS0kixNc9ydIZ5CSFMqUhR++qhu9mRecdhNrweknB2KgARaKIgwgJRqTy1KN4
	lKD3a66BdtwIgoUmYGFrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508385; x=
	1736594785; bh=cxKXDjrTIsAIqkYLotjFaJ3ksS+WHoQ7qvP20IqLnSY=; b=q
	Y+/lB3GN1CdJwyM8vFCcVLHZbISVXv3073eFpEm23mWSsWv7bQYxt+c73tCjlhwb
	HVNNJVb6vmT14SZ0CqnLzhkG/FsDLmMzkKAULwhsK1k2Tj/wjReWhYLnhVEw8KSR
	96mAsPr2+CbPl7HAEj/xcZSVWrwS4sLZ7ZoSYJbGQc/ydaJEj+tJn+fSoccWCfHg
	BKtaVO0yBkOj6MhI6onuibRcIlkPDqV1UNrs+lsNMejTEuOJGii8KWcTc3mFhsEk
	BTcfXvxRNiEBkEIVCnw6gV2jSHP7JqjLuzEh7XXgun1qoKg6K/lnJmM6veslwCpV
	0JJGEMdstyzaSRKrutrPg==
X-ME-Sender: <xms:4QOBZzcWEgN_E-GmiilFffmgLZ2-MFvEV7BhYfSYw6maYSmXGkZhSg>
    <xme:4QOBZ5P7UgNOZDcTM3zTBPFJJfiUtXkjxcpFgVWVlNQHE734F59JIjbbX4q8SpGhm
    D2ODfzI2WfCQsCxFA>
X-ME-Received: <xmr:4QOBZ8iHP1XEnO2mFqDIQqvzD3P7bMEpxXAPMSrUWOoWpULnNMdI4hFRv3hJjS1_vHVYt9cbSGpXmBvWudvmMLttANHy416t6YI--l2fY5ShIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:4QOBZ0_sTUFGPZVlXjVE46UqNLoRNVSyZFgArkngr5ZuGQkURxzS6Q>
    <xmx:4QOBZ_tblGfnW4JXXYVdSxpf9ICnjtWLvfmhrOkonYZ8TAWo2Cb3qg>
    <xmx:4QOBZzFIGVteDdBtm_CDOe72l06iCSUb2pZlI6kqK1mWgXi3iwX_kw>
    <xmx:4QOBZ2NUaf6dJsjz7Vf3xVjSm7sNs2W3kQRDzqcX1_Ex2G7-8A9vRA>
    <xmx:4QOBZ5LsPTsRiMhnNxJ5O0dJL7AJHc05ErRLmThLA_9EHl5cG3RteDTr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:26:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 926c24fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:26:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] builtin/blame: fix out-of-bounds reads and writes
Date: Fri, 10 Jan 2025 12:26:16 +0100
Message-Id: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgDgWcC/5XNTQ6CMBCG4auQrh3TIgXqynsYF/0ZaSMU0mKjI
 dzdwsI9y3eSeb6FRAwOI7kWCwmYXHSjz3E5FURb6TsEZ3KTkpacMipAVTC9IqheDghzeHstZwQ
 ro4UefTdb0G3DtdR1bRpGsjMFfLrPvnF/5LYuzmP47pOJbdcjemLAQEhTKUUFUi5u+eHsBrLRq
 TzMlZnjrdAtk7Uxiv65dV1/eP7k5B4BAAA=
X-Change-ID: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

This fixes the issues reported in [1] and [2]. Thanks!

Changes in v2:

  - Take into account that we may strip ^, * and ? indicators by moving
    around the check.
  - Fix the testcase so that it actually fails without the fix.
  - Link to v1: https://lore.kernel.org/r/20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im

Changes in v3:

  - Add another testcase for boundary commits.
  - Fix another out-of-bound write noticed by Coverity. This bug is not
    a regression in v2.48.0, but is a preexisting error.
  - Simplify the printf statement a bit by using a ternary statement.
  - Link to v2: https://lore.kernel.org/r/20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im

Patrick

[1]: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
[2]: <48ca0114-124b-e3f5-af80-1e302bf9ce52@gmx.de>

---
Patrick Steinhardt (2):
      builtin/blame: fix out-of-bounds read with excessive `--abbrev`
      builtin/blame: fix out-of-bounds write with blank boundary commits

 builtin/blame.c  |  9 +++++----
 t/t8002-blame.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

Range-diff versus v2:

1:  7065637d8e ! 1:  3865bfe643 builtin/blame: fix out-of-bounds read with excessive `--abbrev`
    @@ builtin/blame.c: static void emit_other(struct blame_scoreboard *sb, struct blam
      		}
     -		fwrite(hex, 1, length, stdout);
     +
    -+		if (length > GIT_MAX_HEXSZ)
    -+			length = GIT_MAX_HEXSZ;
    -+		printf("%.*s", (int)length, hex);
    ++		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
      		if (opt & OUTPUT_ANNOTATE_COMPAT) {
      			const char *name;
      			if (opt & OUTPUT_SHOW_EMAIL)
    @@ t/t8002-blame.sh: test_expect_success '--no-abbrev works like --abbrev with full
     +test_expect_success 'blame --abbrev gets truncated' '
     +	check_abbrev $hexsz --abbrev=9000 HEAD
     +'
    ++
    ++test_expect_success 'blame --abbrev gets truncated with boundary commit' '
    ++	check_abbrev $hexsz --abbrev=9000 ^HEAD
    ++'
     +
      test_expect_success '--exclude-promisor-objects does not BUG-crash' '
      	test_must_fail git blame --exclude-promisor-objects one
-:  ---------- > 2:  af0af67a8a builtin/blame: fix out-of-bounds write with blank boundary commits

---
base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
change-id: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71

