Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA928507C
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334281; cv=none; b=e8W4DIXlPeyAZIkEAEVascy57WFc7V43Gz6RijwUdjmyz+520fYur6g8bYVNQei8ImbUjlIr3FIVqHa8kNSLmGuhzncP7OzWhxR8yQROzlYcdLw6BAo/OVHDs41KcedNHuvJ7nAKzWijSLyDtUjOv96J04iCDefi1QNpOpjSeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334281; c=relaxed/simple;
	bh=ZuJ7Pl4l95TFS+ZyXQ6MjtDSUhFVpdfsGQFM026RhfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxc6T7ervN+ir3TSZqmbnt/vQRsTBVlFqvB7P7T7uCYMWdYDoO7IwcmjOcw1U2U63+PbaEanqErWbAOlrm/exvr8sMiH+7VlxjLjrXK6tZZ0L1+eD2uWREhFasoDbIORscjPPg/nQ9sFcRPiQ2r+zY7XLY3ZXVPD/uGaRgV7GRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fpDvzqQs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTq6JiOW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fpDvzqQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTq6JiOW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3CD97A0321;
	Wed,  1 Oct 2025 11:57:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 11:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334278;
	 x=1759420678; bh=CeAVZYYFMx8UXnvrtNzKNr+1Eg7xENc+3iluqNav3UQ=; b=
	fpDvzqQszdG9Xerb+JquUUjiheoSA28nx+MsEGTqf1YXBVDfAkCsblon4fPjA6Rk
	mZNOmazJu3nb7J61EeIF51PwFp3qBNHSqBdZOvx4kYcWGefNzXnz36BZMWY97TXS
	ELlF3+ANaF8MkqMoww/60HR3HOkYMoCl9FJn+I7EbcvEXQdtFIEvhsFnzUpl0mXL
	sEPyOYEBEw9AXJS47Tea/ic+19/b8+PgPbrA35ojB885KjOmuEfhEwLT+NTTaU2i
	ZK48WJETLK0+xIHEVILi0j6SXlSHT3/3NrruBVGHBsTw2zh32RFoOHFPW7rorgEh
	3lOmydWngeG50LR/lxi54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334278; x=
	1759420678; bh=CeAVZYYFMx8UXnvrtNzKNr+1Eg7xENc+3iluqNav3UQ=; b=v
	Tq6JiOWu6AV8seyzB/hzlh6p7a58yGhmcZBZvbbC8/zxrSuE629XBHfDCPtEVEVd
	AWjJ1CArNOYNdoa4W2KnoTtftNcGEhGK+5htQVm/745Y/K4RtqmTsmUNAda+iSgi
	PVNnla4vbK1CRqw4FHhXRa8SxwwBM6liFTXOBkyJLytsNYuP+Zh0A1VOKozvA93a
	sepXHKweaOpRPS/AxUQMnoMyXIjtJmfrlTDn3OlpCV51Dw0BAty4y6YoTy3x7Of8
	K0lSC0xxtJg9mLfAdJrJP+o02TPB0qi4nrdqtuUwM86eTbFAZ4bYt6RcZdbzm4Xa
	WY69lAHqBEf/IGpx/rkFA==
X-ME-Sender: <xms:hk_daHT7nlk3h-h_JE05vYXwVSR3lN-53BK2bubGf99l1hTcS4lsTg>
    <xme:hk_daH1D9PPuBQlNKFkOedrt7BkkhUfufiJzTjo8n2PEmpVlT_opvBQvY9aEI9E3O
    Q_kgNbQMraUJnYf2AeYiHzkE5lOMfiEF8w1sW5fTonOIwq8Gr2JLg>
X-ME-Received: <xmr:hk_daDDIa4T6KmJuJX_C-C6py6YR7_rBX2ucyULmv1m01DgcsqHjGaDC6f6Gb-WAabbZvPWrHFGRbSwR--VgPXqmihprflEYyxJP6siMTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrth
    hinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:hk_daDh66Nj39uV2FvVJkViOpmtR5eo70To97fRK8HZVcQOjM00-4A>
    <xmx:hk_daFPoqJzjn41yhoL3dHjmDmi-tfIMwYe-amHW9xUy6qu9MHUqbg>
    <xmx:hk_daD974XsWOoqA7cx5XUstBfLgz2DXqUPoB1Ztl5197_VClvF6XQ>
    <xmx:hk_daGdkkxZSDNR88aDxpQR3DGwljMxBY8sagfExfzS3KOeAZ4nldg>
    <xmx:hk_daGucKpUvZC0DJ9xdPPjlElVaE5PS_1egstZU-uCv2bw3yM7cXy01>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:57:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5c46e8d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:30 +0200
Subject: [PATCH v4 04/12] replay: parse commits before dereferencing them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-4-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

When looking up a commit it may not be parsed yet. Callers that wish to
access the fields of `struct commit` have to call `repo_parse_commit()`
first so that it is guaranteed to be populated.

We didn't yet care about doing so, because code paths that lead to
`pick_regular_commit()` in "builtin/replay.c" already implicitly parsed
the commits. But now that the function is exposed to outside callers
it's quite easy to get this wrong.

Make the function easier to use by calling `repo_parse_commit()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/replay.c b/replay.c
index 13d75d8054..c3628d2488 100644
--- a/replay.c
+++ b/replay.c
@@ -90,6 +90,9 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree;
 
+	if (repo_parse_commit(repo, pickme))
+		return NULL;
+
 	base = pickme->parents->item;
 	replayed_base = mapped_commit(replayed_commits, base, onto);
 

-- 
2.51.0.700.g236ee7b076.dirty

