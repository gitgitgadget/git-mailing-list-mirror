Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A023E25B
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034711; cv=none; b=E7w6PUXGPp6uwytV6v9iObaJRIUQ1Z3KRaee/vw/enzQp2ByeqhdW+wFB4ttev+LUi+NDyA4rfVB+e21p8S2u9KBa4t+W2ufufAT0Xo/cZEJIR3oeHA3tMe9ri4G9DzMoMI8uAB7XHWdorBsWUpGY1apx5/GZmv9WK1HG1heJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034711; c=relaxed/simple;
	bh=xsRir7URNQ01iszYfNKIhXNppecaUefed1W68c4KoRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw95KLRQFQEZd9EvXm1b9BPzo26kEXY1v6wdiM6Phk23WitR9iDbsQwN3owIUcTkYWBqV1XZeBDHJytcLkAIDaAdJjRJrzdG7Gn/wdw690RqmugZUrurcgR7SAGV9wHpcFZR4CRcNRIB2IyKGhdztN2Z3WRqiYoWNkwEHC0FajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xZryqWl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rut/W8/x; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZryqWl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rut/W8/x"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05B1F1140143;
	Mon,  3 Mar 2025 15:45:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034709; x=
	1741121109; bh=qmZsTp/KdC5DIM+XyIgq53Qfy6qt9YCNIhmQmes0+mY=; b=x
	ZryqWl10HNN3PPE3LsVK/geBhTUb82ksmKrwwgLKyEaSUiZcp0Da9SZNTDY+YSGQ
	zySOyr5FDfjta/HqbfiJNOa8vVd4paECfF7+rtEmIdPDO8i2qBKdOaLTvuu2IYKv
	qgW08vVbEsHDHwzaqrjY27Bw2KIn+lxPvmbzicWAffWvN0FWEJ7FrlxgaX+fwYHl
	rZ5qui+Jgcrhpk7AogVSONSAoPlmqIJ5UEiBgM9RmiKcHG2Heo722R4iPrj49qFe
	y7PvWUHsrHGSNMs18usgnSXOAS+I3J4NTkrtsL8EMfK3zcXJoMYBhd46q6CfV5fG
	qm8V69guljqMtDdikDlkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034709; x=1741121109; bh=q
	mZsTp/KdC5DIM+XyIgq53Qfy6qt9YCNIhmQmes0+mY=; b=rut/W8/xpCa3DpGp9
	WSIw4BKCUoqzisePV31AQiNAoq2EKIEeiZy/lUqYTo6endPxaEhnxJovhcZaqqyf
	UwpjbHXAhz0f6etYVyOM7Knx56Ds1ht4V0pbU26FJ5ImyRCMuZKL+t5htp2ElH5/
	j/oq+MNB2vCcd0QK0VQBr12LpNr0s+K3QeU0ydoG389/5k79nrVzhXQ2FLh5WrU7
	sScHq0rb+JvNNDLoLxkUHpSbW9UAGjlCerFsY0DMnRKdgos1hIMfDlrt1aU0WArm
	uHdZMTgEmOPu/YC5FmFmsP8kavhs3pGczmp0K4CzAOgt2uR3U+XAYA+FkDe2dgbz
	Nt5NA==
X-ME-Sender: <xms:1BTGZzf4hHM7ucW6YBNW2PehgTQydkhHGwob22iHXFzpT_-fzPr_-g>
    <xme:1BTGZ5M1SXPmpZU-sLxKoax9HqmRfwf_qmGFAtlDa-b8142KKl6_peYUmMkOG-9dU
    xQcsprXrN6hw-Y-Dg>
X-ME-Received: <xmr:1BTGZ8g5MrGBXJMOxcxbtszoIhQFWEfV2GTdgDOD7D2xnCNvI3-YLXz7MO74yEkBo0CfWk8Us4uu_2T4SxgONv_WfuI>
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
X-ME-Proxy: <xmx:1BTGZ0-2j4tKTMoN5cjZFJjyfInVv7Bma5-i56G2gDrDia0nm3fFbQ>
    <xmx:1BTGZ_tdE1khOXcArgtxh3vnshWAv24GbJ1K_lAj5T9SvwxlbMwbFg>
    <xmx:1BTGZzEi-SGBj7mYDy5lTtIvbmaSAtkpcfw8nnFQwg6bMr56lzhzPw>
    <xmx:1BTGZ2MmlcFSfLfoFJcJKwnVQ89nhR_wdKBNcnjJnqI2Rv3dveLODw>
    <xmx:1BTGZ_I8F2O_x013avRTec1jRr7EY-vCuD-gGhuyuKppgDKIO-oLCrPt>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:08 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 22/34] parse-options.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:20 -0500
Message-ID: <20250303204443.360595-23-tmz@pobox.com>
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
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index fca944d9a9..997ffbee80 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -6,7 +6,7 @@
 struct repository;
 
 /**
- * Refer to Documentation/technical/api-parse-options.txt for the API doc.
+ * Refer to Documentation/technical/api-parse-options.adoc for the API doc.
  */
 
 enum parse_opt_type {
-- 
2.49.0.rc0

