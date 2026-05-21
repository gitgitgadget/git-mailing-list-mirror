Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F20379C4E
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380876; cv=none; b=rhnqOavNdb66zIWZHUY68t1PtOttBYGga7F2EHaEWame4JJB4AvM6wtbsXDYRXAxC4WTx8pGSRQJp9YhgzETbDdHpVFqxAOtefxl8LjknJBEo5NiBgFuzOhCrS7RqgjL7KyfNh8h2njz7Hz68MfgQSi0yvPLzHy1g+JAcmrHg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380876; c=relaxed/simple;
	bh=BaXKAs/m01+uf9vZaVMPYpbYyzERpQg3XHTNihfaMes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFevRY1i3LTwXKD0e7KDnpykKUsugDpewbibq6B/H7BaboKQk2BFcUQP3dnMDEeTIJgOG9wulmsqZECF9XYWhhGb/B0DbH+EVxJrUFEZD0xBHBwiJSFeCMshhC36cwPzXESF7ooNMRcN3QjCY6uwZeKARO/LqrocwCbTGS3ZgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BWrVxBgJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adszAili; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BWrVxBgJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adszAili"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A9B421D00108;
	Thu, 21 May 2026 12:27:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 12:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779380874; x=
	1779467274; bh=iVLDj0m6/OqWx3YqbJfrmmaAqLD5Lm5Kq2uOydVX6K4=; b=B
	WrVxBgJ+v/0qCrsn9g06a9Ty8gtnJfVEPj9GudfYYdqcplPVp2JAB3rt1O6pfh+1
	SyVn9iRh0wRp4WLV0wxoOUPVzPGEcPQlvb1lQa9MscD//7sGJKTc2ylKS77bX3wv
	kSNcmbyGBasc80ctch2ieiyAWCh3TTmmV2CiF+EExSYyYvht+FZk/0fkXKd4pQfW
	0kF8tAtXC083ExKCiXFNXJX3BHqdFIcX88/ycdNOE6sc/gbJNPk5xkjBC6yTiAIy
	OlTW4KDAIjOopmtbzqKXqwsN5RmH08f25otNSk+p8Wf6LbWLpTIN5Af6YYDqF5aU
	n7rzXaALSHdsIMmBFTgPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779380874; x=1779467274; bh=i
	VLDj0m6/OqWx3YqbJfrmmaAqLD5Lm5Kq2uOydVX6K4=; b=adszAilimqUoSi/mJ
	y8rnyHGCSSpTpYqOoF4cUd1RAIFPnozANklvP6YZL3jZ5aq30BMgjzQoQbTWiocL
	bp2TD2O+rCTzcU7kUzmVx+EYzDuUMhpBol4Ligjym7mcFJ9lzZZzJccq6cGwr0jO
	a1yCEv/eJrAT0M5vG8Jomrz6r8PRbSkKwso4UoL3wGPt+whwb0rhHQF5UTbqZkzW
	VTDGyGKq+jr0jHj3Nr7AkGDem2y05AmGEufk12LOywyGX0euNI47zVzF3ghG8HeQ
	+Rp+21xreIqxWxSc12V97eqmbfIjEqnnXlufYhohMklkYy1Pta6AV+K0sVo+13BL
	rqDtA==
X-ME-Sender: <xms:ijIPasJLlNuLgGy-d1oEr9WQItoA-okDclZUUtN7cl8d5ea0Z7JczJY>
    <xme:ijIPajJOOzBRWDZi_CVuqYJqKxlHefdYfXnKbxVTmMsqV39D91D1bUKzmSwFTmIRI
    uTm9y8jAXEJWf-lAGxTfUy6dJwNgVBYySueZHqN-tNxpJfYP2q9SJU>
X-ME-Received: <xmr:ijIPahtFg7G_xPkPsiAkor00TseU6A0EY0MWY0G8yf-YqZ3EYzsMm4HE1cqNlrY9Pzh9P1m1U_7vzN666jJPnkpoPd4OKh7LBS8P_z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:ijIPaoS8_nxnTMZ_xcA5UqrwbnwG5qIfFDd8ryTpeqsCOlsnRUtJ6A>
    <xmx:ijIPavMRxgTOo8guQmH8pEu9Hif0BtfbZXcmprCw3SJz96cEZ-WdFA>
    <xmx:ijIPalZEEJFi2_hLPM4UtpODu7KRebaSx8QbA8wWmnBt7TQHpqdneA>
    <xmx:ijIPahxwhXwh34s0_K4O-3-ZaIrTp0Ey3nGPJMfDwAmDXCgp-DVTJw>
    <xmx:ijIPar-hMkY_t0aWFC-3mW6lesCRveqZHhx0KzMvykynVsKZzoxlbxF3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:27:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr,
	adrian.ratiu@collabora.com
Subject: [PATCH 3/4] doc: config: include existing git-hook(1) section
Date: Thu, 21 May 2026 18:25:57 +0200
Message-ID: <doc_config_include_hook.6f3@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It is already included in git-hook(1) but missing from git-config(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index dcea3c0c15e..a80e7db46d9 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -451,6 +451,8 @@ include::config/guitool.adoc[]
 
 include::config/help.adoc[]
 
+include::config/hook.adoc[]
+
 include::config/http.adoc[]
 
 include::config/i18n.adoc[]
-- 
2.54.0.13.g9c7419e39f8

