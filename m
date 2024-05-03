Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D5146A81
	for <git@vger.kernel.org>; Fri,  3 May 2024 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720642; cv=none; b=L9CAZT33vkEZC3TZNu/VD4wm7tkCRAFTwwpwcHzZIyGBY5sjUIFCMQTyCBzdv13sWe4vCoN5k/bKLWEffS1PZxXb3DgYcivdsSlbfOK2ZqNVaUI6MPVLWGiYYTJyRwRW9QW05ztREPqVJcxnh0L9WQ1wLOVysqsBNyxTCW3gjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720642; c=relaxed/simple;
	bh=AddtxvKED/+64CRI64rsAOc1JrJXAgWvcR2QE1TjjWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeUanXdiVzdctHLs0sicMLRTPEmfNgN7hj5NJi3fAzrfxsctB4F7kboTGgEo/qxV/0J6kHxHPJRplgY5gbWqfmsdCWYW5BOprwEHOLeEMl8Fek8ReVx9BtywN4sF196UYO4rmqaj9q5zQRhxGBecP7u5dn2VWslPNndthR3gx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=ZZ3hGTYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HP9JYvHO; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="ZZ3hGTYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HP9JYvHO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 027CB1C00144;
	Fri,  3 May 2024 03:17:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 03 May 2024 03:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714720638; x=
	1714807038; bh=C9jQgoLgaYphRIP8hUF2w1mw6y3Y57LXsi10GVFOn5g=; b=Z
	Z3hGTYo3I+sqTFyMRVyFD4g6Xu7z1SX5Ri+gVXMsIRbx8Mu3fXl6rdW5PXBQMT+w
	jns0cHutuG9wzVP+KIOd0QXHRs+0NAlv9qhSmKsIJUFUh1d/LGJn+1sg6p9lMyZx
	Vxn1AG0WTuFcgT/NejS64EogJT26FygJMf8WofXPs+jAG61H4Hisvyyc9g7xb6a1
	8huInvSyPAZmaly009Q8GZs4/vtZmoLUQmInTUr9XGNWh29ClRXghEsxAXr+icuk
	NYTezMB/DfSyFJn0CRnB9x907f3JG2mXAb9Cs+yBRJAXkGVGHAVOzy4bwoLuoTxW
	KNIDcDs8anNRHVVX4iCpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714720638; x=
	1714807038; bh=C9jQgoLgaYphRIP8hUF2w1mw6y3Y57LXsi10GVFOn5g=; b=H
	P9JYvHOifxRfuV53OXwyoFodujqgy4kkA0ZUrmNJ5lAHRhvR5uxJzF15bpqGXHXg
	bPuvFWgU8iN0RBNvIRIIddl/97TWE7TaZs3qxLV+zFotv8K0v0ye1VkAhzF6G2yX
	b26c67sfamUtUaLmVAXAOl1Wz2zJnFV3K5uoSx8gVany20SDXg2rB6gjVOvpQJi+
	qqZUz92hb+Chhd4V8VioU8Mo4W+jqqxW5lavZJREJ/gLv0zpPqy05ZOhujcoBRqg
	qCdN/inAAwXnEAcghR4iAuZHCOMhiDu/alpOIRJ4KQAGbZ+uIBqKmQZbSZ5vWNyE
	JsRcQQ2bpwWTOu1c71OQQ==
X-ME-Sender: <xms:fo80ZkmLNGlABmdRHW8mtymCquMfJo6fS0BhrHv0S4S8iGHwOGNtbg>
    <xme:fo80Zj0Axf1Xj5-zPPXuj7XBDzDTVjH2XJc2bZtei_jYePZ-6fBMsUv2tGCmRguKe
    q6inbtrmLVNMRlt9A>
X-ME-Received: <xmr:fo80ZipAtCCRDiHK4CsknVjSIVIBVeUpjyUUv4dTPUBXgTtmHLSNrKm02GXNPotGlLvilAso62r-hK1Mi_ARLo35zIVFZta86eXA5ys55gkryeQW3ZJBS5tJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfgrmhgvshcunfhiuhcuoehjrghmvghssehjrghmvghs
    lhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeljedtuedugfetgeefieduheelueetvd
    fhueeuueehveeljeekleetteefvefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:fo80Zgl6ALYzHKQvI4sxKnBGeese2YbCqrTPNfulldBMp2LY-A-SKw>
    <xmx:fo80Zi3QZ3bqLw1kpLC3rdc5UMhV54WLIwYfJ6dpV_O2GDceKT7t1g>
    <xmx:fo80Znutnh9iy9bd3gVnDt8BuPZd4eBepeRzwDE8_zH4cw2NYKlGAQ>
    <xmx:fo80ZuXwbRCUpr6-XvdD0yg-LIS-ISsrG4uTOz2mvM-14-unlwxRIg>
    <xmx:fo80ZgDW-YP2-nfw3V-aIhaIxxHUH58AINmEsi7aHD5BlYHpcJCNePlQ>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 03:17:17 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v4 0/3] advice: add "all" option to disable all hints
Date: Fri,  3 May 2024 17:17:03 +1000
Message-ID: <20240503071706.78109-1-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430014724.83813-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you all for the comprehensive feedback. This is v4 of the patch
series to introduce a --no-advice option for silencing advice hints.

The main changes are:

- Two preliminary commits to reorder/clean up the options documentation
  and usage string.
- Caching the value of GIT_ADVICE.
- Adding tests which explicitly set GIT_ADVICE to false and true.

Cheers,
James

James Liu (3):
  doc: clean up usage documentation for --no-* opts
  doc: add spacing around paginate options
  advice: add --no-advice global option

 Documentation/git.txt | 18 +++++++-----
 advice.c              |  7 +++++
 environment.h         |  7 +++++
 git.c                 | 11 +++++--
 t/t0018-advice.sh     | 68 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  55d5559586 < -:  ---------- advice: add --no-advice global option
-:  ---------- > 1:  ae3f45dadc doc: clean up usage documentation for --no-* opts
-:  ---------- > 2:  1b0019026a doc: add spacing around paginate options
-:  ---------- > 3:  31e73e6c0e advice: add --no-advice global option
-- 
2.44.0

