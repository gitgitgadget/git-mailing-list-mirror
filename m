Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86213624BC
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391293; cv=none; b=cBDBp8aEuYNOpTHqRfTeU6Nwpy28iQdj+CGwgHhsXtzWUhXQuJeLFhcCWCDQHRgEuclIfRN53oC6GkAJhsTi8I5qimlZ1QumbhFGiC562DcztxN2RXbz18t61czCQ5Ygz7yFZgRWQYepesbAdMjIlLBt3UzgSIjvt/r7zTJI2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391293; c=relaxed/simple;
	bh=yCnddkmnDPp1U+gsE5E69b/XL7hbGS3MNrADtbY0X1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FdHfqoLG9Ir2+Ke6p8pUWjhef54+M+8nyKf6lJ0AbS8B0vdOVgEJ1gX/y6sriD9drMEfgwtn9Ra7lULonTYzQs/3IoqCzcrBFcTo2PSGx8aC6ZuOzPl4GevUec++Zyaly0f1n7mVAi7WG6y42IzntrvEWZOqEO0NKx9aXMakSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b3BygtSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCZzE3kc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b3BygtSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCZzE3kc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C76401400205;
	Tue,  2 Jun 2026 05:08:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 05:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1780391290; x=1780477690; bh=60PmC3T9RlZ0wo1xvf6M5
	ZFxTebzVfciQ74UXZm5Xwk=; b=b3BygtSd8oUC7ivWzTPJXdLSL1v1bqlBvfoOe
	c4H1WrHRv/ttalNyNLzXiBflJj4SDx1FyKuw8t0d8ij7yttxg0JqRwLFCGRXyEwt
	WncjxHb5QDZOI5xrBk44wxNv08xMvuqEYlVgNG9jAcEzjuDHoZpbhHWZPMhqmRtS
	EB6JYNIlqCbCdfRbpQQEAdhZcEdZbT/U477+GGe/LAHUX9NAzf3ztENehx/vSZfV
	F2RWU5R9/kxmRl0pcrSJb/bTgPcKG8SLTHWkTZdcOSnEGa790YaHsDHCMzieah+y
	a1uSRNmz34dDxqejZg4M565vhz4rl1oXkguNS5M9Y5lmuHomg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780391290; x=1780477690; bh=60PmC3T9RlZ0wo1xvf6M5ZFxTebzVfciQ74
	UXZm5Xwk=; b=GCZzE3kcGqR0jLpXD0+CHdgQ5T8xUEKHa/Ybgrw6vMzeQWYJ758
	AMneW59v4o8lqNjSOEUWrYPswurrcgsnO4uribKA5ue9yArtGARjrbIcAKAhW8V4
	SDatm+Ki71edHeyI21zAgqOqz2ii79XpsDm6iLrAVFeakrYP/Tsgv/5MX6zSexYt
	DH3gWH+OiU7GTn6zDjbyRWHieWCIimN4Aw+mwUBsaMYFw7sT41FXIagD1qAYPti6
	0DGG/bZbRavMz8cgaovaexvLcF+mMXnfdOLN+oKwgdgHDDERiKH7FvAZF8BuqWbn
	xHRdFG4eP9t+jaH3g/rzCRVSjsuz2D1CzUw==
X-ME-Sender: <xms:ep0eanlO2yKWHVakzlGFr8DIm0u3nqseInHjxUAmojR46SLsjt_o6w>
    <xme:ep0eag2_AP4dZHjX1QWOXKowqggUl7Wx-u_A5_vp3R8lr_mUVcjBRW-NIx45dC1vM
    j5Zf7WdeWhtqi83dtoO7YuueRitJoUk7js2qX0Ixe9E-nZVGEah4w>
X-ME-Received: <xmr:ep0earT8O2z6KA1qUWg65GqQt4hm0Tai488rEQ-SjI-t_cz3qqY7aA2dLOthfNSzKxE1eqoC_2D4OI2dKmArXPmQazbRCDDPiMti>
X-ME-Proxy-Cause: dmFkZTGRYx7HukP3z5q/AcNRL06QTVYZTLnNfAj7BaeQKApeu61UromacZEaYrSqAjh/iC
    jEBmM6KqAxog89MvlztBeYn4EPIc5Z1H0KTraupqKkIvKEoF2gafenL3PLz2aPnQPAR3UA
    3sVtCMohOi674R5/7RO0NpnlYDI94iQ9NGEkD39Wd4ag+wDqhnWvhUuRiuWmW08WT0Qqqq
    DfY4JeotnO+5vNCVZ9d+TdHamgqoA+TxhwFTB8jJhnxnP3PNDcaMf5xUL1ysadzilQ30lc
    N0xDTBHV28KqaIlVGjPqCnqLIxExA10SyFVTGk1Q27MOJPf9mXEnpd//9NiUAUj86zUdiz
    nPm17+U+Q2kyUXRr+KwAzML6URZDRaR+5+HIuVP88lEH3s0huLFgVZv+J0R1yDKYheJnIT
    JOeifoXhZbSBLkd5+gN3P0gUOqliJy8EsvQxGhPaI6Xb8pAQSfk8pG1/tQZQmsWf/9XGp6
    hN33L3BWd1mfzSaX5v1Mus7dNI/W1GzrsYaOqSNQitF5JQxZ0nGlPsTUzYkxXB7Pi99zgp
    nneifQqfGRFSb+X/K30EBURK4GL/X9MxPHa4Urj2IrLkWNaEhQWXyoQYyRWDoeAvBu+QwS
    wCl8robDPbCeSOSFnnq8P2/5+pgeaP9BWS/XQZ0Eg32AWh3eANsv6tL2SbwQ
X-ME-Proxy: <xmx:ep0eaquZXjCZ0mGCJ7CwO0k6y2bghEovmW3M48gQm2Vs20oBqo838w>
    <xmx:ep0eaoaNwXP0wuI5VwQ0rbO65aQ-LlWvDMz7inZ6P3w_Au6g5Sf60g>
    <xmx:ep0eanuRr3djY0WY8sNMpMTr397J6R5huLvkfMZPS-N3aTmh_b3OPA>
    <xmx:ep0eaiEmblVkhZYM8Sm25PDOhkMSOj2jADqBYd_hY8GjfWjDZUUC7g>
    <xmx:ep0eai8N_nhYauldjXTllo1ECyxkCl4BP2EZfxtDUMfqe9jfEE6LyNEo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:08:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Small updates to SubmittingPatches
Date: Tue,  2 Jun 2026 18:08:06 +0900
Message-ID: <20260602090808.87837-1-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-567-gf25c749695
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently I gave some advice on how a cover letter should
try to sell the idea to widest possible audience, and then
I realized that we do not seem to teach how in our guides.

Here is a small series to do so.

 1/2: SubmittingPatches: separate typofixes section
 2/2: SubmittingPatches: describe cover letter

 Documentation/SubmittingPatches | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.54.0-567-gf25c749695

