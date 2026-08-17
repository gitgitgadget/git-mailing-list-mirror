Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B453793DC
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992776; cv=none; b=V1bI+C59F5/1p/QCjzIs0FW1DVTzOr3ze0x2CzgyIjHi0ihwr3W+q8/Sd3p7xOJmXy2aiMlOLaAtWtL2zxtYomUE2R5zIAAPWyiLOuR2ykwNufzE8FcXGmXdys0gtDIOMfKYHxBl+hKRQEec4fxJCAxj41f68magyYu6VUeCxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992776; c=relaxed/simple;
	bh=QpZTWeYm8w7RYDe0xw/LSbx+6gqyG9hdqjbIZKleH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrbbkFsFKQsyxNaYWQw9YT2ixpiq9saPAjEUxpeeKRcpfcSs3sQUknI3mmzb9jsdbN4JTPaMVsOsEBCAX3HqIqlU5l6X1bxpwsMdt3RFf9ZgtRU/GPKRsVMN4ItuZffJbx/yBrZZWTGXhWPsY6Tc/p0ZfY155XHQLMCO/61Nazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LrnM0Q3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsK1pnVJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LrnM0Q3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsK1pnVJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E89631D00188;
	Mon, 17 Aug 2026 14:52:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 14:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786992772;
	 x=1787079172; bh=1bcPe2uJoZkbC0UzeNm54vbiMi4eZ+u6b9DFlqT9N2Y=; b=
	LrnM0Q3kz573ivh9DUWI9PdIueAAythe1lCcIjYRt0d2cTJiF/5TejlV1VpDCsF2
	IstpKqBDrUUAwaJGL4lr4ptBOWy0W+mRfGtbm7TVaVOAAbbMygbkv35gtZiaqKaK
	F9c+gtpNRZ3ln4FJjlM1ouG/5/dd8GRP3TwV0V9vZyWjOyvI4WaiQuhaiI/dYVLj
	dPp+Rw5g06d0uiWrhrKDJIK6sQ+wiLz+6liOX7lPDv0c9B6A2cKkeUMO4mNiuHN8
	9oOj7VvYl4yYKo/NEXjLQyhVe5s/sfSyHQBnW6/KuR3rbaMDA7Yqdm+cl6zKKV9m
	Wtfivt+sPA434YcRXLc3ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786992772; x=
	1787079172; bh=1bcPe2uJoZkbC0UzeNm54vbiMi4eZ+u6b9DFlqT9N2Y=; b=F
	sK1pnVJC0lVxn+xsNP6tvcwez+syiXF7UWJcLrwy31gAcJsq8J85A0veWSnkr9Uh
	kPCQxy2GbskNJ1tjSrT7A8DYLLh2G0XnW5OROkaEZnnbfdSQgwgcC4MhcgWGLnjk
	EMEkEWm4209732kN6229wjGbYXk+H/I5VeMEOuGstkZPoxPQbysxhM5yBZL7PMsU
	GZyScd8SSMdO6uiAsDNK10ynerMsRiZtyts1FuSstU9oHlKrneaC82y7QuQ+oFaw
	ZhfMqUo9Qs0AckRpzgWt29pCxYuhCXorzGRdFoPx0W00uOKV/gtgU7LaE0pjCURg
	PLd3zKb8zmxQ5T41C4UzA==
X-ME-Sender: <xms:hFiDatnmPP2Xo7ahOfCXM2TZkfiod2c_ihvvb9QLFvxiVvY9aZMZSVs>
    <xme:hFiDav0AkOveUMkzmDpzAKER9dDm6yi0bBCu1q5LlysxnoqSVkOnMcpfEyEXwJJqs
    BC-am_un_D2h_iqLOK2i6T1fmW2iJmU0ce8RPn21OGAjAAjm4YD7g>
X-ME-Received: <xmr:hFiDaorHWWo0l7iS7fPPlEvvgBlxjG_IGtqxzsQpMpb3xgwnrwFZsBBbkh6d_wFoROJcwGUzm8WgSgIW-kDZboOjSjZ06aheImzQ-0HdczXTQTxp6o3qVtM>
X-ME-Proxy-Cause: dmFkZTGyRL5S5oNpoF6e3KZFS6fk3iX9E8GIhuqZcssxTPHRUad2hI0C1Af7/SloCf1JzC
    Ycg1/D+/v/9NdMwsJqa8RxFmbsFdYWNAzHvUwMhHGMWfnrCPQbj7vCUsFVxzx2Nao8dKcN
    H8fsye3U+Rr57XXQQ7Z6ayA1PlU0BkhsOSbSb48txr1hCf8I/+Bc0gpQ66OF9UnkP76eW2
    FJvcKl5KvtjH0N2RPPOmy6a5VvCAn3gonxcxEf5kun5pNC6TVMTEeSidKF80gWyTW2vINB
    SCJ7aX2htFmohTxUsvUkkJswblS7ECVw153GJ/hXtuiVL4Sy9NDPXZOsQrkYmjf+KpD7lb
    vApQ04f4UIpP9gfmeqQCE5ULgDMHaWAt7x4DcCQZBthOnwRjfckaHZa/v+sVQLnN76huP5
    GCpc4HglNMMB1lWZKEBdQfSHzrq45aLD7OBTBwdwfquwFND00zLehORIye8IrnmjJXWDcv
    UPFqPd9PpekcGybTWHAa+i5YAVXQVhYlsORTYoua8uUnqF32KGWt4lfGeWmJUPIdKXRFrY
    UuobCGR1aavYdaqwARI4vxdYsbnZFPBjMCuf/kSZy2Z6RZfQCVopwu0IdM52HAjh/1tR8Z
    pB2D3slSQuGVkLretuMrQVuviE/wpnvAhCGK29sa0XbIdDuRNKNCjt65rOpA
X-ME-Proxy: <xmx:hFiDasf_12mLnIf7nAuytrIOLsDEVt73YIHa6lr2KijN7VNYskPOLA>
    <xmx:hFiDanrneSvoCETk37Qf-m7u7HQB0OCLnQt-Exj8c7i7pScXoMtPfw>
    <xmx:hFiDatF47YfU5cZXf-rbGLWD3nmH3LZkLWEb0hsMxp0bc6pUteOr_w>
    <xmx:hFiDantKP2H2qx67ohyot0XBT-r5k0eT-giLa-4bME6edH1g_bcrUA>
    <xmx:hFiDarl4AmXo4VQK3bkiPuk5pOvMXrGAeHTpavM1PkGn4sxn619exlPU>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 14:52:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v4 1/2] doc: format-rev: quote subject placeholder before and after
Date: Mon, 17 Aug 2026 20:51:48 +0200
Message-ID: <V4_quote_subject.b8f@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V4_CV_synopsis_block.b8e@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V4_CV_synopsis_block.b8e@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We first talk about just `%s`, but then show the result with
quotes. That is inconsistent. Let’s use quotes both in the format
as well as in the result.

The implied input here, which is not spelled out for brevity, is:

    Did we not fix this in <commit object name>?

Which is then supposed to be formatted to `"<subject>"`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • [new]
    • I wanted to add this after spotting the problem in [1]
      🔗 1: https://lore.kernel.org/git/a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com/#t

 Documentation/git-format-rev.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 505a52feccd..19241837345 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -93,8 +93,8 @@ acts as a _terminator_, not a _separator_. In other words, the final
 line or record is also terminated by the terminator character.
 
 The mode `--stdin-mode=text` replaces each object name with the
-formatted commit, i.e. the format `%s` would transform some commit
-object name to `<subject>` without any termination. Like this:
+formatted commit, i.e. the format `"%s"` would transform some commit
+object name to `"<subject>"` without any termination. Like this:
 
 ----
 Did we not fix this in "<subject>"?
-- 
2.55.0.13.g85d2d65e389

