Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A8134CCF
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105934; cv=none; b=tt7oELSsl7H9wHoJtT7/9QKEIOmLBQ6FFg7TO5oPqyAGNzPWTW7RDDM76g6t2xiBCCLvTliDUW5FgqAIgqrUEZCBgFLSCq5PdX2+okWPayWrKmX0d3Vv5s9iSJdJG2Oqjy1NyKG9oPDjfaz0L7LTRjqA+f5+I25esqcHZVvyrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105934; c=relaxed/simple;
	bh=9WS/PYa6ocLFRdKFwKZPJIoGxYmv+hlYHRVbM00eDC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCeE2dvSAzJjKoSL87jd2zSO4fCzMAqvQhXb8RU2ayWU7tg+V5sfjgp27HpOYCJNbNBmAskFw819Y9n+TDAeR5szb9Xoe3BXh0TqFQ1difU/sIvX4TDwVzw8tIMa7SzApqnOOiB0KguZnAI2Jon2ORxLi4mK9NJeI6tpwh/JH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ayyE4zMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz30XHYy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ayyE4zMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz30XHYy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48D6414000F9;
	Fri, 11 Sep 2026 01:52:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105932;
	 x=1789192332; bh=ZO20x2TqOhpXNW6fJscFTAkvxy8yFHFKkYFkT4T1+JU=; b=
	ayyE4zMsIX2nCxolH9hDT2apIgaNNtz5mU+BtXRChEJcs2tLAOeA5e2U2J4jb1WI
	jeD5jwpXw7oiYh5ppWBfuxhNk1JtMZ9sMziBSpETw1quqepxtl9Tz6cQNDfJpZre
	RNIkqjFeT+Gu/aI+Dhsg7hh+MjsM+DXP0EpszjBQf+vFgMtAcOjtfF8dzWMakZGZ
	5NasHI1aK+EvIR5dVIx14ibXRQH8nIxn2OroVhrZZBbk0ro24vyb8a7N2s4TGQaW
	w/qq7wDgnkTY1aGVQVh5Zu6Bs7V7sbHqUkLbed1QVwz3/aiCGOWeOg1PoEaOkVxJ
	GnaS2YV67U1uIUSzM3Ihng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105932; x=
	1789192332; bh=ZO20x2TqOhpXNW6fJscFTAkvxy8yFHFKkYFkT4T1+JU=; b=Y
	z30XHYyYjS3kWLbPlkhTiSbI4B6vPz3tZiM5Qz8EiEyFactna3iWOb5rEcxf4CKB
	aG93NSS5mdyBpxaJtc95hNLhk7vid+X6Z3iTY9VthIweTKPWcTCsnRQCdK+7ttnK
	r+epxa8elMOgbsZYk6FXiQJZMb9ZgqKUPZCoyJBsbTJbWcW1KEpwtEU4eDWkDIrB
	ePp3jRW312g4kAmS2SRFSZYznMe4RvdrK5kjc2HBZ8APtrcCL6F0R4ehPRpMGpLj
	UsLYvgWQRu2NWo+2vUc9qC8gezMGIWUwtebHm852VYc2RPITDQUnAxElO6xrp2+w
	ssMyJboLfCRnLT6Q+3SjA==
X-ME-Sender: <xms:DJejakfq_kE1HCGB-qUPOpMQwfhKDB8cNLHJu1fDFJRcmSVo5K6_xA>
    <xme:DJejatqBS12liK_Yg8NBb9A7MBsRuez2_SlFbLxDfOp-uv3r8H4xi4Yu0DxEVH7iZ
    ag3_vYZw-awVTA8dFVfSXfxn9jes__UY4p6mr758SZ-1P3-KrUHr2Q>
X-ME-Received: <xmr:DJejai4uRoXcT6jPKLg9F50BPEhcuigzEne-FXTOj_31TSP0mTyM_cOiLJiEGbiRJmO3mQ>
X-ME-Proxy-Cause: dmFkZTGfDhiR4X7UB5YOqIZL06ZIl+Ja6w4i5NCXf+OrJx4cGpCAcFPoxBaKrcvbE3ObKW
    S6w3aQPqVAc6OiGQYQYiyjZdl7n+bEhSJsS5wvTb4NNLtSlHQCZ1BSw2ZdDOWEwELmwWOh
    58gCrZu6xF8O8Zve1GSJQaub4RKc7OTn4BvXMOU6tVeLW/Lr/+hKOEJESJPGh2FkdVh98T
    9luQSg42jt2uch/oLnt+Nzw5x2BBOKpd97BcZk3gtn502JRtxtsZkwPXRPp/1tUVkUp53i
    Ejc2Ls9echym+i27yIA5RBBUpeyvia/guMz1cR0P7MjG3Lf8Ws8+wE/UO5KRE7bC7S+mNU
    p1wpSxRlsQitUthDIVP6AFv1NFilrvw1gxYPS69piAAsxIIr4rgIg5NnEhZXmFbMEmPPiG
    m/QUoZNdXez0J6eeqL4W5kYe0P/H5ld3bft3iweHsIynyqyEyMYI3z7gcriaxsJ3cIutNn
    /ShwFN07g93YeKRqpGvB3ulY+7tiLboWUtoWpJ4r6xTV2OJ09OHjXNoD6+s6YOi0GyFawu
    V36OWgf78UrzqnF3o5wEWW7QP5+xW6AixDcAPa/I15DUyE9cPGCKI+ey16ElC2KEQu0yu4
    BgKscRGBp7GxxitpROO47iu59a3a487gH4EoJ1Fnpk5ZtYwkZICTPIKUp0KA
X-ME-Proxy: <xmx:DJejajqBkSuBXcnUoyVFAE9LXykqr8xVlS29ElJIYOTH6bJsinUhtQ>
    <xmx:DJejakid5x7YOQsAFhZ7CHB4KKwp9BHdx-CEobNqbe3dpA_FY5UxXA>
    <xmx:DJejatIo3rgch3GCAkoCr23P3GgjwTQF4gzRsc1LkOBKHOzx63oYeg>
    <xmx:DJejakAXr3q-OM4gKKI7dw8oWI7jO26eUgw3IIxHCXvQpwxGMB-GTA>
    <xmx:DJejappAIlKlcqb4S26oHvq-OrXwH7eOl9_Hj9gdzj8Tqd9bnE1wJ1iu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45fbc52c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:52 +0200
Subject: [PATCH v3 09/13] odb/packed: fix memory leaks when freeing source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-9-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When freeing a "packed" source we don't close either its packs nor its
multi-pack indices. This can cause memory leaks in case we create an
ad-hoc packed source. As we used to always link packed sources to the
main object database we never noticed this issue until now, but it's
going to surface in subsequent commits where we stop linking them.

Plug the memory leaks by closing the source first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1d90e714e6..166e76e2d6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -844,6 +844,7 @@ static void odb_source_packed_free(struct odb_source *source)
 
 	chdir_notify_unregister(odb_source_packed_reparent, packed);
 
+	odb_source_close(source);
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		free(e->pack);
 	packfile_list_clear(&packed->packs);

-- 
2.55.0.1074.ge7621b4bad.dirty

