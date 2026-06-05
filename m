Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C29281503
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667836; cv=none; b=IShpaIEoUXF2d+Q76qRnPmVTynd6QKv3+oCVwy4OzhUtZsdGMx2aF46lcYebcKafA3h3+H+JfBX7YD2nQ4VqN+Cdi3echYhYbx2Tz05cbXsNOXorxFtNc0Je8Rk8WST/2WinQueJk2Hkqg4bQfdCBTn+elHPFLSENTbO2XcW/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667836; c=relaxed/simple;
	bh=4jQgUPPdGlTx/I581cSXjQHlnnn96Ei+ZCIETboLqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vb9J0Gsft6zl3e/2I5q/ktNioA/ZlzxdCBzIScWnwJLxsn4uy1S84FgZpUvkdUvn+zDM/Gc6DtU36cl8TWG/haG1340YnR0AgP+K/eFwJjkL+kJlYAU0GREUbXfCTDMQYoStqaoEU18Sw6i/0KtfTZBTIgQwqD5hQhWeDJWVdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pgymLyMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCw+M/zB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pgymLyMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCw+M/zB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D64314000E0;
	Fri,  5 Jun 2026 09:57:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 09:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780667834;
	 x=1780754234; bh=YDEgUM871s+lgkHZnbppOsNxSAf9ckYln+TGan1ieSA=; b=
	pgymLyMdaZryQlbQQ5DPkkgnXl5UpWQ20JRUm+ioXhRpkvd8RSeK1LQhfI2z+Gtw
	LdQIc9EPFd1PJPtGPyMqsN64OaTmMMwY+AI7ancWClMF7XHgKFYf0eneb/vvdSPa
	paHuGmu8njJEHWIza5fV3J0lp6ypo+6YunLuui2DCRaMR+X9t2qOl8zvfgqMPhA6
	mLbm6G0lPtypQNjVOq2eW2P6kEdsQqlseZ2PreTKeawcLEEc4F5xvKTi6uGoKv71
	Ot/fNlxDpi4y0jSXFxcOJICl8EmidQTUD05WflrgiAdfSKYR8p/qi+k+GLDIYhKs
	VACdSC8Kvy/BWz0gwEAMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780667834; x=
	1780754234; bh=YDEgUM871s+lgkHZnbppOsNxSAf9ckYln+TGan1ieSA=; b=K
	Cw+M/zB/a3+fR4grXpYruUXvaf6clQQi3bOBZ24y0PHUhUZ6DNRTAHTOC6tX16W9
	KCAxEfYMyqUyMgvxRult5o8LMNhQ19sJCiuN8C6zkcCCeZ7O6eRNPm1E70kqWuO1
	OmreroQTSzqVXmxtqPJMLnqGly5ychAj0Xg7dxduRg+4l6s8t6N8eqG7hLGkMxfe
	TqpHge3EvV7YzeBEt1XH8lbDE3xS7bdgvy/fkFt9bhsS7IHkAFlhX9SLVW+gOVLb
	Rw/zxVIro61QUEj92qFkc3FTpeNjNcg5UEXkkDC09YRR3iD6Qc3WRckGPE5dDbk0
	wbqVLn+qDDfenFpwc58CQ==
X-ME-Sender: <xms:utUiaogTm7X2qfj6T5koexMdiEs9_Aa94HcWOU1RqLUvOx2agMgZQns>
    <xme:utUian5nILOc2VkfCRXCmlBpWS-S6LbRPjRYURUG4v9SHPGGCW2CEuR_9M8mfarMl
    b6WBQi0mT_csZMU5uCFnGgb1D0IwQp-xL0WkckgQU1Ni7HDkmR7XQ>
X-ME-Received: <xmr:utUiaobXAbHgMSXxzrvV1VJmke-b_psgXBqTXU_lsw_SRDM4aPGJo8SY3dY7k1t1XpiFgdgk42jKlCLvuAh6GLIg7fu2v2tY9GXPm2A>
X-ME-Proxy-Cause: dmFkZTGvsYIBbcBckKcYFmAf2DprU/CQcsVUaSBxVzMlk2tltWKohjMLTFj2fZBFoZBsMT
    CbmwKGWeeNg0jEft8F9g8mugtV9QqiIa5evikB5SHHb4gazxVPP9SRLirwAmzkaj8btzvu
    I4ZESplgnwUSrigypLrqD+oJzTYoaxP8IS9OX2ONX9JLdJZiPAHOv5w9OgUDKd/OkVWT21
    PyilYZc9IwPg4gxTFke5nOFjTJ7zrfdMbT74FnfMG3o3b+DNTsVGiIC2rOftS+f4LNeXIt
    UPZ+U5dMI/S8VE85c9X21tODF/Gq/gEs+RbwCbGywzMlaRVf5z81qGXSWi+fYiJHB7ssC6
    bor/HI2+pkGxZxCNK3v8vRMJX7CB+KOMCqhl3wvHbOFJZ5E/qyqRegjhi/mBvrn6cL7qqJ
    FYmSHh/EjSv2oVuIY6Y7tA2CRBst7faU53vWDlP+faaECt11QIMmz3mH2X3GPWCiryDONa
    iO41eN8ZF7imtRSxumuo13fNxc0zZseYiOYsIYTl7MWbRwcSRd/DjqLd6iOAsn3gu4fQEc
    TJLAG1B+e0ZoMCShZGeQPuLZQyYAxRczJp3hZ1C01j6kRIuqJBV1rME4iQlrd3Qsh8UjXY
    WsP8T5pB3NyH8OnHPlZLfudyR1TNeZ9CthaAQhMDb/ioUb5CY8xi5mM7uq3w
X-ME-Proxy: <xmx:utUiak5SlG5Z2uI5vtWgG8qeP3szZJh0EF0IATbjzhM124nQ5TK9ug>
    <xmx:utUiajDcFhDAiv4rJYvMI7yyUAFd_ul296hpdHy9Kdw9JonRfHC7Dw>
    <xmx:utUiaic6ywPfWwbaY-JvSmDERh7aaXfb_uGwCfFGBnS6NhZBJ4cWog>
    <xmx:utUiaqIU9PcvWQMaZQIHMMYaoy8BKNznNlG-eQ_ZDmOkgKyI_mYQQA>
    <xmx:utUiagJiZfBQuvu7jnnL0ajuRpoKhT566DU1_ZeJ5fe6SfXKGv5PLKuO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:57:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/4] doc: replay: use a nested description list
Date: Fri,  5 Jun 2026 15:56:01 +0200
Message-ID: <V3_--ref-action_definition_list.783@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_replay_config.780@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz> <V3_CV_doc_replay_config.780@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This bullet list for `--ref-action` introduces a term with a colon.
This is exactly what a description list is, structurally. Let’s be
stylistically consistent and use the desc. list markup construct.

In short, just transform this unordered list in the same way that we
did for `replay.refAction` in the previous commit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Msg:[1] Fix typo: “stylistically”
    • Msg: Simplify message. Devote one paragraph to   † 1: Commit
      explain the transformation. Then delegate to the         message
      previous patch since we did the same trans-
      formation there.
    
    ---
    
    v2:
    • Msg: Mention that the explanation for the description list is the
      same as in the previous commit
    • Msg: It’s “description list”, not “definition list”

 Documentation/git-replay.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4de85088d6c..b4fe43ec687 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,10 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-	* `update` (default): Update refs directly using an atomic transaction.
-	  All refs are updated or none are (all-or-nothing behavior).
-	* `print`: Output update-ref commands for pipeline use. This is the
-	  traditional behavior where output can be piped to `git update-ref --stdin`.
+`update` (default);; Update refs directly using an atomic transaction.
+	All refs are updated or none are (all-or-nothing behavior).
+`print`;; Output update-ref commands for pipeline use. This is the
+	traditional behavior where output can be piped to `git update-ref --stdin`.
 --
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
-- 
2.54.0.22.g9e26862b904

