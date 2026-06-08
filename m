Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289862EBBA1
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901407; cv=none; b=GLIxCrMzGpJo6WvWIp/eR3QQxVKZMs2rFdQFuMuZwdKpA10d0cQqN0BAmhez2EVB8QLZyim6Zi6mBWwpPzGLYjUVE1VslevdaKbcvyElvD2QJnyE7qlOP6fhsuaE3uVAtRlafQHIa822va2SXUzirRLQhk/oRZhBwkwl4SibIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901407; c=relaxed/simple;
	bh=Exl4z0ZtZVZ/Dy6/s1/lyU3WYjm0vqxDZvD36YyqE3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSbFKpPpqF3zKlwfvWdUJ9KKyB7hLrEYwr3Rn7Nqqx4JL+8gzIA5/Srd83jjZkqm6J7hFmFRQgmSL1Zxe3BRerNs7IhfE7llkc4usaWiD4uhu6mDcoE/Pw7d8DOedRzfAI4yQLJF7SpMqaIL8a2Pe0ih+1IbM07Hx9nY9sqUnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fXLqi/xk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDdQW2tX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fXLqi/xk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDdQW2tX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 582351D00085;
	Mon,  8 Jun 2026 02:50:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 02:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901405;
	 x=1780987805; bh=KM+ihq1552uDCxh/WIuo7kH1j5quqpvMB3Tq2ktrQcw=; b=
	fXLqi/xkVBMS+lx2HGoO0G9EvyvIuYbvw7IHGAFPqhINEmp3uPQsZYx8HXg4qVS/
	porGvqride6M4bVn7UzCwVnGCTck62b6TF67thObHRRmb/D3WaaJ8Ah0c7TPocPL
	G1Mc6JBLobVtQANTeWNFnhykroXm9wApXkJd5bOdKfI8wnuNlllHafc3czBZXPDr
	WApu3VdEnc4y10McmfhD4CwXevD1FV/SIqIwlom6EUjRtucZWyBUzslP0DmU/S+n
	lqO8xoODTs/sTHo6vZAkFtAxLuWfHH5kR9TwNwmWh4MFtLUACW8bhSNKQFG7kHQJ
	uO9FLXTHcaUdxN3ErW4o2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901405; x=
	1780987805; bh=KM+ihq1552uDCxh/WIuo7kH1j5quqpvMB3Tq2ktrQcw=; b=g
	DdQW2tXxS/wre5VEYoAc7mFqUfVpZshD/8MfLxntnSbEzSKuMrwN/2/5BUeSBJLn
	8YvMuRbFiaJg2s6jYhs2FbEDeZcJA+lnjMoj4XJW4g/NZFFA5aXP9G8os5EUHMLN
	lTcw/cu2lHKyZSITqs6PtYCyrmW30r9fAZaqnpKf1kekF3NBsMOqcMLXum39EtQ/
	jZgnTfnblAG7IVzzECRwUEA2RA1rooveoueDOOGXGAIkz1KfUZLf3T1dQRSuXh+g
	USOUjamP/X37sJPokV0QQ5iXKm7zB+G8LAhgqhRu2OPngQyNB3fLG+EmqGh0F6qt
	3Qg7q/wuEXT2wJiLjNjqQ==
X-ME-Sender: <xms:HGYmaoUvqCjsXYNLXd3KQ3uVJJ_HLcamQ_ZIVSoC3uoMDs4uJT5a8g>
    <xme:HGYmamnX0gM-QCyX6_-KcGxwA_SmVqDvqIuKqiGq3uiyx7ymuVKsjVT7dxTd1myMA
    I8LUCoEtAvE80p3J8hwc8Q402qVLnA9yvX2qCSx9mAii1bpnuzk>
X-ME-Received: <xmr:HGYmajCcWNmtXovOySgNIXI4vPtlBoKlaZPiBggd88gD4xEKB1iLQ_lVqxwf0WSjDWipUd15u00YbU4sTu2-QvIvZoAyjqfK59-4MG6khQ>
X-ME-Proxy-Cause: dmFkZTEKEjXO/TeqFyjAWUAw67gxtHnRAvAVHYn5/55/pSvaSmNbXcZ1p/plrIVi+/VsjC
    +xxCr60emcKisYBT2W0OeTV204y+WrYLKkRGDdKcZxFhmeIWczeaghTfqKO28cr/+2Tzrm
    yyG+SaF/aU7ecfMGuEF2iq05xRpz2nInWBRp+DxLCTgLgVgeiA2BpaOooCoNUGP+STbCxh
    peNYZAQFlrfUAXbHZaX9OUJcFnKAbPtonp6KnQ0c45NEjdEne5oY74SREOuC5tExiV0iOH
    PjJUQVn5jau+b5wlmepwenwHbV7edTfFqFUlEsJR2O7rFlizQ4wAx3YpQQ+d9dP9bfvWD5
    zAyfrKdLUNrEQDAsMa/GOzBx+FKX2+mEraXt5pe/014CLrbXsGVM3JifHvrhKGE2a7FDew
    Lp48vTVGacdgnF8of5vPjer5MUOAYrfaW0kPRAvY0/yPVicO2SSIer9wiczTsRaMtGvj7T
    JrxQJZydQnSnOCTDEp/ZhXk1zaoixZAjfhA2Xgdx+4zbshY8ji1ozeerqoxU61E7DWO9yw
    y8PSNaCUEPnlnqc0a/4Tn7Dr6q4MQ8py0mhczD2kT8FpzClxwXfzmptXUfp3/9CfZNuitK
    G73fk/1SKhS1xoR6S5UpKMwTZsygU4X1g4eNoip9xKgk2tFEDZN2rhufac0Q
X-ME-Proxy: <xmx:HGYmalieBaSb2ZJiGGCd8sNmhf2BVzQtcjjlJKroKqT34w-DWL9sYw>
    <xmx:HGYmagzMiq5oNOeJk0uqBnPHrwQRdjn-AoybfyY1iT70y5r9e7T2Zg>
    <xmx:HGYmam2JL7oDBHsKA3m0MMt77YUtaAJtWLoiN9FnEM91-gdhQmT2mQ>
    <xmx:HGYmal9GT7krYDIB67MTJdlPweHZf2drttZikfPXAVDlhbjgvoCM_w>
    <xmx:HWYmatwqxQ7aRcrsYW06Os9innvDAjOMLKJBGVO8uFNo2QMiwz5zopn1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:50:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d937520a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:49:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 08:49:53 +0200
Subject: [PATCH v3 1/3] MyFirstContribution: recommend shallow threading of
 cover letters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-pks-b4-v3-1-f5e497d10c56@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
In-Reply-To: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The "MyFirstContribution" document recommends the use of deep threading
of cover letters: every cover letter of subsequent iterations shall be
linked to the cover letter of the preceding version. The result of this
is that eventually, threads with many versions are getting nested so
deep that it becomes hard to follow.

Adapt the recommendation to instead propose shallow threading of cover
letters: instead of linking the cover letter to the previous cover
letter, the user is supposed to always link it to the first cover
letter. This still makes it easy to follow the iterations, but has the
benefit of nesting to a much shallower level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/MyFirstContribution.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b9fdefce02..984b7f5aa8 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -790,7 +790,7 @@ We can note a few things:
   v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
   three patches in the second iteration. Each iteration is sent with a new cover
   letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
-  previous iteration (more on that below).
+  first iteration (more on that below).
 
 NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
 _i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
@@ -1214,7 +1214,7 @@ between your last version and now, if it's something significant. You do not
 need the exact same body in your second cover letter; focus on explaining to
 reviewers the changes you've made that may not be as visible.
 
-You will also need to go and find the Message-ID of your previous cover letter.
+You will also need to go and find the Message-ID of your first cover letter.
 You can either note it when you send the first series, from the output of `git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
@@ -1227,8 +1227,8 @@ Message-ID: <foo.12345.author@example.com>
 
 Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
 below as well; make sure to replace it with the correct Message-ID for your
-**previous cover letter** - that is, if you're sending v2, use the Message-ID
-from v1; if you're sending v3, use the Message-ID from v2.
+**first cover letter** - that is, for any subsequent version that you send,
+always use the Message-ID from v1.
 
 While you're looking at the email, you should also note who is CC'd, as it's
 common practice in the mailing list to keep all CCs on a thread. You can add

-- 
2.54.0.1136.gdb2ca164c4.dirty

