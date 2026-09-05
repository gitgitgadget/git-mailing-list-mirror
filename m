Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28853815FA
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629360; cv=none; b=Z4GrG7redUImcrL2Q6E/9auBypYXTSB/PQDqlnovcw7NGLPZlHid3rl7rIphhzKa8AnVLeQvV+9C7GU/zl6Z2eARK2uYuTeEIbUrwe2z7arH9Ya59zHP4O9fBk7sp4Y6MF6YZz9U/DJZyMnA257g4fs928FvgL7EQhwPw/dG5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629360; c=relaxed/simple;
	bh=rf3BlicpHLphcsrhbKz28clGJyTGWKBXVOeD64N4k2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOmUULkwUArJxwub3yPilgru1ALP05FOCyMvjR79/iJOIPd/TEuOcH3ZFEzO23828qr4+BBxw5k980Bn4O9zuJMRWyWJrLbFozqVLPpYZyAOrHJXcug9HDniTwn0QAjze9PH4HITcVWuCcCxDkj2ewczmMtlOI+zIrfBJCfqhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X5tPpldj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kv0iD2Tt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X5tPpldj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kv0iD2Tt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 30B121D0003E;
	Sat,  5 Sep 2026 13:29:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 05 Sep 2026 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788629358;
	 x=1788715758; bh=y9Q/PLV+Q8WOrLG61k51Vz8PTyftqmUsxUA0K/MUK5s=; b=
	X5tPpldjm+df8xJ3zbfShWrWfCS2fveDE7IbID11+GLu+5hUHH/XSEykh04Df292
	iCNpp4zmeWg/4L3fb523cyyFTXu7IZqcO08KKWh3RijWj3Q5Jb3zByQxTSjm8jLr
	VBIIZDnTnu8RcKz0qeuoGVEEbnd1u5vg40dUu/YWbRpNlq7oDgDoQOX7fZa0gMSJ
	aZ1M717+HyWKiBhMQWqkc5E/dDKZPmkwRd6NL1ylvAA7diSqcyHiO929EYi8n8X6
	91LB56rlf7NOQb8bhYICXsS04SwuDud3Jsm6R6z6jZDVoalgVz5EggzB48WIBMkn
	AFrsmtIN68p635929pxqEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788629358; x=
	1788715758; bh=y9Q/PLV+Q8WOrLG61k51Vz8PTyftqmUsxUA0K/MUK5s=; b=K
	v0iD2Ttwam/eCgUgsFaW4PnPx+rJ4Nfzy+5w3NAC7VxOoa4iZt7eQCmdTwU2C/J0
	ntuxF6u3sP1FcMoBJX/EPMCHg9bUqZAbhSUOqlBRqeYHy0RafgKtBgW5ndvNFd9Z
	I3h0F1sne9WoU1mo9o9kZdS1S6RQU1S66mAYd/buc4ZL2MMeEPBCD9gc+oJT+4uV
	ioEqXugs4yRrZOMJa4kVFA68Gf8ccAeiI/w5LDxRBLzqKj7gQxxSk+X/MNQ2v4Eb
	ZW2JTYoONl1tFs7dYnQkngApStqgRQeigOVkFX+kpT1YrH/NlKaZPsAUOvgj2O5H
	zy6qHvXt8lZU7x/OHepCQ==
X-ME-Sender: <xms:bVGcauhn-UkE8IEMLv7TcaQbZ2Hoiu37QWjUhyKEhIoTegAnzkhRR2k>
    <xme:bVGcamBumu9-aGVGf9MAFb0Mtbc1r3n4FeEpokxBP8CuWFVHjMTEX7BvJgeY4P5-q
    BtpEQvNoUeafVJqAO90VZbzT1PUbIqEAh-U8LWWzlMSpL9Bch6F_rA>
X-ME-Received: <xmr:bVGcarFMVTJe8KMZj4fDpDbmGji9lQrNb3YyTbst-vFcJlgFVt5DeafV9mswz3GMo26Dn29nCRt_BWf3wzDtFvZhXANdfNcHsVsCLTjCXeWUjT0RgjD-jUQ>
X-ME-Proxy-Cause: dmFkZTEotm6TrEcetlgUpWj2uj/UIr2I1BBNLNtx50zVR6LNPxoiJzguH9uTyT/QsvM6qb
    IJz8MzWhojBr8vNK4ks3TjQa9QiI6V+EoqvRJYYF/Nf90pPRInTROsiZLXrUo66jHOZFAT
    KxHbAtULnA6yzJAvHCaashSNHzsDpIofpAwuupmbvZkRoKPZjGPfxjZfONhhalS22oaYqy
    b+IcbApWqR8cFI9RwQNm++TH3Qc+E9vwnGwricNTdpgYGbIqWIFSIkJLHG8YIfOidqWDT0
    xYjlBgztZLD78/cci9IgyT6bRCelTocqerFLvT5c3o1FBB6XEjGotBTIXuXNTX3xCXJWXK
    rmJuM98JgKwXumc5mou0gYIqPqjPKRcfpkl4TREvtUPSxfEEoNCGd4f2rsOO1YoVJzMuSn
    zTfH8wKVEihtY2LsF6paimGafkfxZD6UvboZFIqOvzgiHgRwLANH24Tpmp1ujKPm3ZC8+V
    lHwL8SeMlxAjNliuZikWyEHb48n8NzN6g3q7rEUwQRC0KGs/94NQSDF7z564rCEAWbeo8R
    a0Ul9wPFTEmIGBTEapVE5MpYOyqQa5XP25oP4V6JY14tKzMStt+z0Hykes/kWd0rx+lWn4
    8SlUbdxvzeVvmWK0R5Jwu08CpAwvjifIh1kbg7rQeYVBxvIFVVmjYPFQA0WQ
X-ME-Proxy: <xmx:bVGcamK7hBsaWQ_M1JxMLhS-x5iUgU58cLn3UsdjQNeeDU1pAbNrkQ>
    <xmx:bVGcankKd1-naqEq5T3ZwjMdFZm5c2sMaDu9j5Ms2S3Ad2a1v3EujA>
    <xmx:bVGcamR5On13y0a-fznjsq02-IGgKrtd44iCpvG6zh8f_4XJ_lkLTQ>
    <xmx:bVGcahKbEAPfUCrot47aV_nCaBP6L8ce9LqSiqy0MkfsGhTm4PEUcw>
    <xmx:blGcai4jm7BZpn6VG1nEoNVDRBIdLVWy7jENG4icG2jUqd4hqDDT0F8B>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 13:29:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 1/4] doc: git: list gitdatamodel(7) as a concept guide
Date: Sat,  5 Sep 2026 19:28:12 +0200
Message-ID: <V3_git_help_--guide_datam.c7f@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

dee80940 (doc: add an explanation of Git's data model, 2025-11-12) added
gitdatamodel(7), documenting Git’s data model. But it is not mentioned
anywhere.

Let’s start by listing it under Guides in git(1) and with `git help
--guides`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Msg: s/everywhere/anywhere/[1]
      🔗 1: https://lore.kernel.org/git/aohDEKEs82MaWECV@pks.im/#t

 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 21b802c4202..63ae2a67c94 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -217,6 +217,7 @@ gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
+gitdatamodel                            guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
-- 
2.55.0.13.g335083658c8

