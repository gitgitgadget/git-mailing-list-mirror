Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEB40D580
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126708; cv=none; b=iOBxByLrNtGeNT98JR5Y2tSdxoZbjlhHlxPKtZ4pDmNYmgxe5INxb+fnw+6/iEIFEkxH4Ga5nw4h3gK9QeIJfHuzP3ko5mM9T1qZbqoetybo931WbgSE4jGqKp+6EbIFo/6PU88dNKbMEDyk5Dl0UoXBG1VfNKbDkm7/34RQraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126708; c=relaxed/simple;
	bh=Xgv1KQ9EzjwNKsbEs+/Zp78ZkfS3GPYWJG4yqIVT5Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhyYVRuqbuYqEWRKupLE3Gv2vWmZDUyQGfiO97JRJNcNySrg2BLQiYhhA9MtfE4tg/idZ9tDkGfWGGkN4jm1BcbAnC1zSVHHap4T6pi/3hxSh+zgFP8QHilTrVdTPpN98dIs+cSns9d7gRmMVUg0etojmxwg3/4+7ZOlwUovDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RML733pC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHsd1XWy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RML733pC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHsd1XWy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2BB77A0018;
	Wed, 10 Jun 2026 17:25:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 17:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126706;
	 x=1781213106; bh=caC08UHJLTMfvf81H5/URrF5613fRr5ckaIMazYYX+w=; b=
	RML733pCODseFGZfnZzLmHPNqrUa/rFyI+OR0rjJ9aDcfN2XofJILwaM6V8DnVC4
	eZA2ewntQ13PVY+TLfc2gS8eGoIxI4HEnt1A3U4UACv6Ju+wrZnZFbCkHH4knHXf
	69+CISFBKPa2DaHmRugsGneUggRYMbvAvqt8CHgzGWuv/4T9AnEhMvBcRF3o8wjd
	sxktlbOIDmthwrwFdU6SqZFozUU953DyLxAql0xByhF4Nk6Y1hRD1vestC9HyZUt
	0LSQIs56cewhb2fBt6Fe9ybvClURmWzq+en/qcq66F1T81OAMqLNVmB+v/oDnLsF
	lvRnMyrkdBz1ZEwvW56TYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126706; x=
	1781213106; bh=caC08UHJLTMfvf81H5/URrF5613fRr5ckaIMazYYX+w=; b=i
	Hsd1XWyerqYPjlugpipsVw3w4pga1q0sA7XnT71ZrZ6+HiVB/i/erdM9T5xEVH59
	p3mFZEniTUOkfAl8ZCJH98JYP9ICnixFO4hyjQzXgPSJtz1bGR5KiA1vXcXIbN42
	HZ3Bf+s9cB2ARQiN1BWJKFS+Gco3ASWTwN8lZ9sMS9SAwlw/5M2wuAyUeJ8ux8d/
	fQzDBpX/VomeWy39cl0XScCVyXlJNrTo9Yx5sseULKgq9j67ecCgtwXH8lpCTK9o
	b3aqqQBMjF9/XwhPBojsqzrwDQ7OjuV81DF/NpIpmK/7VJKATUmRXFAWZeREVlbr
	ZoHz5bTvTion2u+4B9YQQ==
X-ME-Sender: <xms:MtYpaphfeC2FHRYwu3e3nOxZn2itw4n1LSRxr8Kdg2ohg_rnvMPSvfs>
    <xme:MtYpahuFtGmXKlHs7m0_40TjkQLTSHWG1MneDQ8aFQ_YZCoOvOtrmf2MGXkellhWG
    g0UGvYvH3guckROehqQB0NefuPw3O0sxi7nAUBQTryIbyBbOrIgAA>
X-ME-Received: <xmr:MtYpai5JGpnt9w_WUpdpzqKmYaCaoR0ptKdyCItdQPJ6QOFJfmWAaQaZZaq81uEpLvf_xymsWtFrXc_XlL7OXncti3aWZrzD-jmZN2bzDSG38vo41gs9utnlYg>
X-ME-Proxy-Cause: dmFkZTEDRODY6dncr8bwhGw7lNbUcvIuw71usLJEASv0TjdvNKHZWp+zgcK79ciH8LAFkK
    RjGz85sZ4jlm9hztF50LVadJ7XfD+Akj4xQSajRCe4XOSfLcDlYpyRl+pHUE8YBho0LeVr
    8ZkkAuPQOV4M/Guz5wr+pCVS3PUyAcesj8ZI2ljgB7D4ViX1RlPY+MJgJYgDp0Z34iyso0
    7+KJAy495+nDsA9DgtUpI5obFv+GuNRc8dX0zRAHU8I9HbcYfMm3lefOfiSmf3Rdv0oCn2
    1FJOfyVqDrXCnv6yDq7SmQMBU67V+HOnk2WDN2OHXFLwqgp0GflLmxfl8F9XPyxzXUAXiJ
    upOCLO8m7XKwuE2y0wOjyuyGyZ1RFz/yQJFzITxSnelAP/Xu8RTZd0CiVRgs1dG9dYcvL+
    65WrCfXVzDeVxjmZN24V+T/Bh9BxuIwsqjvHwjfAIOfdSh44LYEeJme5KHERkAzx3dnS5V
    ESBeHarly9AuvWAc/CGq/ChZiT/cJrWxaIyP0Ra0WYRYYnKawMBngnpA+WsUbcORn7YXhx
    4SJtwOr6Qf0uD6qGckgEt/DTSY+hS49Cb0L7Jznwu7V5KQPrC10ErhRSQ8EFtYhhda/J0H
    zcJ00OPm/6c9LlQqGVoJYN4SU4sikrWfYbxECnnZ25saWIBL5RBFdFsaFK8g
X-ME-Proxy: <xmx:MtYpalPsRQy0Qcj3hKqx6qVkhL4B1d8mpa8QzwF6d3gNx6HoU7ss3A>
    <xmx:MtYpaosAEkmVd1w0y_wiNf9gPH3VpGkHy4__IftTN0G4cJzFyPIUDA>
    <xmx:MtYpagY8e-ILIXvUGHULj0sUdb346KZlzi9d3OoNmsQBIsBc8wPfZg>
    <xmx:MtYpaixp9r0gpS8-yLsTMa058HCvcIpxwIHLbngwNt0aFfyj3yGAYg>
    <xmx:MtYpaqtYzwMDuJPsyGjYfb9Fl-P3NinbBV2soib1__ko6LQCPImNu7m2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:25:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 11/11] doc: interpret-trailers: document comment line treatment
Date: Wed, 10 Jun 2026 23:21:29 +0200
Message-ID: <V3_trailer_comment_lines.8ad@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Comment lines have always been ignored but this is not documented.

This is mostly for completeness since this is unlikely to catch anyone
by surprise. But we really ought to be reasonably complete here since
it’s the only documentation page that documents trailers.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Msg: finally fix area
    • Demote this point to its own “other rules” section, out of the main
      running text. It is not important enough for the main text.
    • Since writing this I have realized that we can go into that long
    
         # ----- >8 ----
    
      Commit message separator scissor line, maybe other things. But I stop
      short here. These things are even less likely to become a problem for
      anyone. And maybe we’ll add them later?
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index fb9b1e94dd7..d5e856f5d68 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -117,6 +117,16 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
+OTHER RULES
+-----------
+
+What was covered in the previous section are the rules that are relevant
+for regular use. The following points are included for completeness.
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
+
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

