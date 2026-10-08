Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199435200C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487725; cv=none; b=DEOuaclrToAb1x6OZMIL99HWuSYOAgB7QRIbOqmNfYcWqqaueVJcxVh2GGzPApokXZb4bSfRz2C7FEECcYYbXHuFBWmjRiIoJnCI8v48sAgahGqjMEYzqoGfcoAbUeRIR8nZ172VRZOVL21FAGNFiumNV1mz/o7yznCRgkisHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487725; c=relaxed/simple;
	bh=3LsuNWvNY1rG8dG1jZ38wr4NFGkTTkYTloRY63RWnfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwtAX0Pbi1dtG0X2/bCGiJ+OZP6unCuYHVo7x+hiS5dgy90JoEsHTOLyZxqsv4ErGv6Bnnh83MkLc9uI13C2FDe0Q947Ifhq8/WsAafVfrKPDygWqZBl+pcutrKD2d0sCFfLrwH7dj7CfJz9/yvX3aeJhOV5EeyUnoOQUQZjSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FzR0Z98s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ywsCnW5b; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FzR0Z98s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ywsCnW5b"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8074BEC0354
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:28:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 15:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487723;
	 x=1791574123; bh=OO/d4bwr5IX2ooXE2PhO7rdU5SaVSJ5h45ulm21xVWA=; b=
	FzR0Z98s0yb8mfDrPkEvl7ffJJ7Glj7dI+9semHUcerNmfZwmAwYFmq2hf8M54xG
	1QHac+p08rIJBkHbmdl9ANo360PhuN58+rh98/fQK4SBMg8Abk8bwFdtIakQ/i5+
	JabNrj57kRn7mYsHkHKefpUEDGEStvdZX0fg+RXWuRG0UJ7W0uPVmPz4f5hu7tvX
	YaTXy6if+hAe/yB0iwwyyCc9BOoE1nxXOF5E1HkLAHW4XBS+Q2eeIRGDdzlBLAFi
	YNUYHkAZ5IsIPY51ivjRnVdeqbtHRJfDeNpOJ0zpHt1pAfCVp9prIishKhvcLOOQ
	XiY4basAk/rMF6D8VHZy7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487723; x=
	1791574123; bh=OO/d4bwr5IX2ooXE2PhO7rdU5SaVSJ5h45ulm21xVWA=; b=y
	wsCnW5bZwHyN5ETvXNzw9h8FWoVgNE/yRPHdFYESzKRrDIPeIfM8zoAI/IYl2J9N
	v088uIdpA3HuKpze3HOu2dCNveKyY8VKJCPtp0blSOAKI7umrGvM9YhxepLqsePG
	IwntnRe3heF58rUc+KKOpM2AUhd4EbYHFoYypqnv9ilPo6Hh7W1QovgijwUOAgs/
	jiz+kMqbCexxKMahQl1OQjp6fQJIIkF/V7Wwe5yYf0J1IWHB8xUsIs8wlVpc/AJp
	hb3kxVc3CS6gLHcLkyTTG6PWaKfHEdx5/YUQvLmjkCFKEwdKW2oW0UCGTclYdYdW
	5DcNlNz8S99k9N1/iYupA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487723; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b/sLUWjrx4EZP5jmvftVEepNjdOpfHG9nWTcYhv2DOrU0hI
	B0Rm9JUpsUpMGTPNpdLBQrJtRGlSiFoJFlPY07PfKNGDNYmwF1OfR9Pz5f2X7lEU
	wbM3XIXcKwLSV3U8SjO6/JCJqJ8p6Tr9P1wkJ3Xa+Ct09brLKIp+V062Jo76CErI
	9g7KiY9mVlyp1t/rI7bO2Zt9hUI3XfjS/VzUmQJ5AZCWVRU+11E8C1h5ky0s7Y4C
	onrRAaTEt+ypn9XtWC9jXL5aQEQpRJuIbVNSYiUTG1L9oGkytoKbjSDEXckPBW3T
	TQmXnkGoY7ODDiEKC5qq0Y2UzXxccbab8RvJJvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:L7g6yLeR/gPVOAxJ5Jfol0OgLfb3baeeXKDafXbibNc=:3LsuNWvNY1rG8dG1jZ38wr4NFGkTTkYTloRY63RWnfg=;
X-ME-Sender: <xms:6-7HaoGlBjJmiClhiuJZjNst4PoOfZcb6TBPeFVxifuCIz3srq97J9w>
    <xme:6-7HaoUeoRka6Q0Ni4dDK7PNwerpYXty9TGjmxmatwYxC7VqhHc5a0mMYYjNClpHs
    plCK4SIoGkTI4m9iMjno8x3albEEfkdGgzDn0SA0BOnN3BEzmaQ_-0>
X-ME-Received: <xmr:6-7HanKKi5Hd49eQofqk-BaRTiiKlxvz2-sRwfY9jAokuBm_uQpk9II1x8CG2JAPqSXhAdzPH52OFVTU--iLqrWxRMt20CulxScMjerQPnc4ebZ68--n9TE>
X-ME-Proxy-Cause: dmFkZTGesTBw5oiZR92fd3sIt498LDbCc4G8WdMSpWCT6ufsuQAF9udgwnW7zLMwWM8RUM
    6ZHb4V+cN2wglOYldC4u5KD5xGr6MQFCHXZEY1em8Iha0StJfyflpgRhDbHXnD6mETueIE
    ghIqBbMnwur0NqwZGODwKTOG+FaJt3Zf2nRxgRcA39jZ37CKj/8l/L8mAoYm3NfVBaIZJG
    1OPPjIoK5ECuGe/9QZLxO+G2AEDjrNGZRKlurdW8QjxyXDFWPJEXrMkAC2JoeLZDifMPZD
    oRmpMHJv9Wrg1If/gd3rOfBBIbj6xKDnhZ7XCI2nPrqy0AWpWfmbVSe1s+MyZmeBWc0bXi
    zGkCkfTVk253H7SWXjutH8pXPLbMRsaYN9mIc/jkOThPpuniNR65TAxycIO+o00FzKZkid
    xU5VFWRTypaTOEjGlM98KwoJK7i/atJLdZdPlVC+5K8CBcJ7opC9VOvqGuN7xfwH3CRASk
    02FsmGOu3DGoR1w3tkP37LqjYf5j545c496LhnYIRr3ArWa4qaOPhUv5kgwG2x+/7MdaeL
    N3a+AQ2ZlMjv/PPeRs/W/QHR1ZxTgjHQyOnvoUJwKrbJf0NKjX1c9zYY98/0vvZ8NVl/BU
    /zMotR+6VDq/ispCP+jmAFcvQGao/z1GiVPpyjuelNVV2FCT4D/eWR3fbagA
X-ME-Proxy: <xmx:6-7Hao9sBK1FbyU2uCLidf9QgWFBUcCwxTfBf0Fr80u7SAB4Vp9iYA>
    <xmx:6-7HaqLof2duPjx6NqK3dFeeW2A2OIhZfxPQJLV4Dzxj7zhf4JzGag>
    <xmx:6-7HatnmZTwVgcX_g6u4Lq-oJqVcAPROsdJAmtSNdNE0hCde4o2NHw>
    <xmx:6-7HauNTwcro1O3PlXLIOcDaaK9z-3BQCGBq1Co0zHB6x6DRoZ0F7Q>
    <xmx:6-7HatwfifvMhl4gZfh6vQwsQlp-LkvNav2PSbu2sfYR5TuxHLzcIei8>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:28:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/5] doc: gitbreaking-changes: add note about living document
Date: Thu,  8 Oct 2026 21:27:19 +0200
Message-ID: <V2_gitbrchanges7_living_doc.dc8@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This document has always stated that it is a “living document”, subject
to change. With that in mind, we should be mindful of a potentially
larger readerbase now that this is a more public-facing page. One could
imagine that someone reads this document on a released version,
disagrees with a point there, and posts feedback to the project—but this
decision could have already been reverted in the live document.[1]

Let’s add a note (admonition) following the “live document” with such
a reminder. Let’s keep it short and simple though and not go into how
to fetch the source. They can figure that out themselves.

† 1: Let’s say that someone on Git for Debian Stable reads about the
     breaking changes for Git 3.0. They don’t like something about it
     so they post it to the mailing list. Then the mailing list informs
     them that Git 3.0 was released two years ago and that the current
     document is about Git 4.0.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/gitbreaking-changes.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index 2bb9f877256..b94759260d9 100644
--- a/Documentation/gitbreaking-changes.adoc
+++ b/Documentation/gitbreaking-changes.adoc
@@ -73,6 +73,16 @@ over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
 this list to mean "it is settled, do not waste our time bringing it up again".
 
+[NOTE]
+--
+In case you are reading this document from a released version: this
+being a _living document_ means that you might want to consult what
+the current, development version of the document looks like in case
+anything here motivates you to post some feedback to the project.
+Because specific details you read here might have been changed in the
+development version.
+--
+
 == Procedure
 
 Discussing the desire to make breaking changes, declaring that breaking
-- 
2.55.0.793.gc667de3f2c5

