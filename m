Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FE486E4D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641886; cv=none; b=Zn+cdID/U4ATyZMjafeUg5dogA+wnFSPpIETCVdDpu2jJLbfTteNQb4v83ganCbvR2Yx3M2+C0wb1OSxna4Vtv2PDSnGRZ1yF6cz5sDPLdagcdIFeg+N1qkagMEEQ2b0EUt4K0Vsax3Vezbgq0mvGRiviWeSziPZ2HMnmgvSyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641886; c=relaxed/simple;
	bh=eVWW5eyTDADs5vIBF/oggSzX6zFCOTcIX75UreeIOEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyT8BUnpB+44uKtRYViGrmgN394nSEwSMQ6iz2Pg/p0yJ5tD5H0t5dpfcdkQTMXJnTNLWuFrW3iFN0za9Xs3Zp8eUpp6SFNL1uJkMXodvprke1EHv1Rjc2sBRn/qoABU30ccMTyWVawX3yz2srABGMi/dNJ18fSyeL6bSvh1uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WWNltTmD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0SL4yOd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WWNltTmD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0SL4yOd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0352A14001C0;
	Thu, 13 Aug 2026 13:24:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 13:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1786641884; x=
	1786728284; bh=e7MWmJeSZS2mQwn2Y5zaDAoKlYoHpneHK96BbBHOfSk=; b=W
	WNltTmDV/5C3ZB5plx452Y7YpMx2mshP4c5tR9vzNMEBADphDkqLb0qGtVBXQSYL
	/e2hf9P22bt5v4XdI41vgL0QXLDUzr0aCIetpkETP0rj5eutdexzWnnIuo+7hALJ
	d2jfM85EgosZtxNaI/wbkMlwk7s9v7QbP+kPZdvDUMVG+aoTGxSnKMTERfDp7G5Y
	lUWlbnAh9gqMR3k+wdzoqem9XkpO8pUdYfBj3814GhY/5QFya0v7eQlxtQMTKUx7
	210LI9Nj70WDWsgHRdNjEj/LUWIbOQ7frFZqfyoFYYNiQ9WYpGKmryK2sxU+0aZn
	sCSsfb3qgv5CLcrh/0W8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786641884; x=1786728284; bh=e
	7MWmJeSZS2mQwn2Y5zaDAoKlYoHpneHK96BbBHOfSk=; b=J0SL4yOd9Pd5RGdQz
	5v8MPJmQkF1XGOhW8+QwN0Sa7CMPJfjqNKvalKTEX4QQsZZ7KaHSMvmbZuw7hlHn
	ANxo3whgBIbHUpYhmoHQQD+4hTg2wIHes1tpWIh2yGjVN7eXKV5uxLK2C4xQXaFP
	A+LIRLapRnEuJdGmefklSJ8BVOoNlx5CSsfhZh7GGTZXhctfihjnAV9UusK9rLSZ
	MIfoCnuuo5F+5rlqvrAc884It98CiUg+YOddZPSSf8urvlh3pufQknwnozmmWUwf
	e5+Om/GlQWKGSmChkNYlUgTNYoSa8R2Z4hXRKURMaqKfWEru+A84/9ejsX7JRN2x
	tL6FQ==
X-ME-Sender: <xms:2_19ag7Fvs223TZweWLatWpHq1qnRuEBcHD4APNOKK256EmwXVVYG0E>
    <xme:2_19an4awKT8Udt9CwnJqPuYQiW3dbKvX_NJ685z2JI6DrNp0BqUjSUeRnOnXSNVs
    KyEZz8jOZIWwD6zOJ825Pp3l-3EZzlVnj2eXQZKbkhQ-0FMqJgU0jg>
X-ME-Received: <xmr:2_19atFxCaIsPsMrLSDF5D1ct5PvRd__U_SDBOhd8QSMIKjOK2ErNJwzjrH1_UtJou3M_ajOUftj_DqVjzej-nrUq5jg3RK4yY-nk2aYNa-2EQ2v082LhE0>
X-ME-Proxy-Cause: dmFkZTGaHO/WBFzAvu519hnlYaLD2zOJO/SqYWRv0pyurEK1ZGE3jwBqqrpeDriFIen9cJ
    s5covlOSqW4c93YbLUHkczlkmKd9mUjZVt6FgR1LRXmw99Tnh8fwzDRP8k6kD0OA3Qw1ye
    TeUvRuu5uZZGBXudiW+OeK6Lx0wqZyBGCJQTvmcfNBbt/MDN0HQ4ywM9tfRaTWMx8PBcx6
    OhQcYnymghhpHtcgeXeD39aIvoLQ+3yKI9nnMKjRMxUNDU1Q/Tk32Ch7rbcgzWfY0nuy0/
    zfy+Z2nm3XD365VJUPFDxw94L1HCfVIx98d/Q2IjJPz+6e5LLBhXy7LgfmxuRZ/CJXDhj9
    7rGgbAJd4PM7MRUnjuOkzrzBndbiyCXwLv6CaIhB3gXHqGL4omNsBO1fOIe3z2TA8pcGj4
    lL/LNcRt7wbDEG8LlgZ2S5HWhN6aFSYYL30Y+7eakddcZUFq/ufEa5edoaVKe89F2kBH0L
    7GcgzCTBIyU/OgTbr882xH7yH5+rKOl8BckS9iS2RyeToNmsVdw0LOutXbLyhERlfxjcjC
    nrva0z7plk6hSO5kvaWYG/CuRBspIelBxtTsprI12q4q+YYpuTyvL1OhS+6kqvAeMJs9AR
    2fVcJD6bN0CRvXTm/nWgAvwU82p+BBJicZ+7fvRNqxpPBHTtszC9HSEFkxKA
X-ME-Proxy: <xmx:2_19agSFzcwUfSAq3emwePCc8_1RbqgpletIzjghTCQr4zWb4DiHhg>
    <xmx:2_19amu4edrscuGfFXP7Z2Jwved13aa6uDci6XxBQcG970VffAXuRw>
    <xmx:2_19avySv8uTvR_qSI4v53e3T0KPD1ARkJVMAi8PFYx7rhza8WZyog>
    <xmx:2_19ag6whMJhGYUNwuTOIeR11yW5Hl37ij1SnolpREUPQxVLhkoHeQ>
    <xmx:3P19akRy0bREQwBzPj6cuc6-HaS3IAuLHUggtoMjOPRkOsgungehVbJw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:24:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/4] format-rev: use lower case for opts description
Date: Thu, 13 Aug 2026 19:23:57 +0200
Message-ID: <lower_case_opts_descrps.b81@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_format-rev_three_more_opts.b80@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The option descriptions use a mix of initial capital and lower case
letters. Lower case is the correct style.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/name-rev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 60cbbfb4b7d..254c88199fd 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -833,12 +833,12 @@ int cmd_format_rev(int argc,
 		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
 				N_("display notes for pretty format")),
 		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
-			       N_("Use NUL for input and output termination"),
+			       N_("use NUL for input and output termination"),
 			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
 		OPT_BOOL(0, "null-input", &nul_data.nul_input,
-			 N_("Use NUL for input termination")),
+			 N_("use NUL for input termination")),
 		OPT_BOOL(0, "null-output", &nul_data.nul_output,
-			 N_("Use NUL for output termination")),
+			 N_("use NUL for output termination")),
 		OPT_END(),
 	};
 
-- 
2.54.0.22.g9e26862b904

