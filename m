Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EF35B136
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629341; cv=none; b=Kf4MAg+sFRwV27loRKWXZGGusNm1A9khsaRnIk67T6NF48aE6enSr53sfMyBP5PR8GGVoZcidtY+IROqYk/TY1UP39Fvnzbx9H6q+/CYxdh5ffBYJZrvhkNsWyuCdmdnLmrgVCWdAWnxEQ2GIQvJGDlIc6CMsDnXBWmrwqxvDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629341; c=relaxed/simple;
	bh=n4VksQDmRGlaWOTel/HWzbgG7Se3pu56yzJdsxe6tic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLa4t/iEogFps7Em1Mwd71XdHmPTWQWdv25zCdgtoGqBxC/Iav/pP/3PwkHviErL/a0yzF1KCkUvkbpcxjgZ6YZ+9RVI5e9WzRj9d7loLEw+cjqqnQNge3WTaDdxbV09ZoR7PnxHz5umvY4rtCLzXDs6iONrOBjvMEeL2H7Go8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JBgxzBe4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKFGSPHk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JBgxzBe4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKFGSPHk"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D0121D0007F;
	Sat,  5 Sep 2026 13:28:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 05 Sep 2026 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788629338;
	 x=1788715738; bh=uuS5NzG70GB8i9bKOOmiNS0ng1wNda4/qEdZYj++dkc=; b=
	JBgxzBe4lJMO5/sMo8YfR0fPGbpQ79HmLSyC0cxlO0NnMkLS6xVVCd65uxokkGEI
	4dqzmYnQVQZw2IHYv5SX9pX300cKdHNdjyJtjMIzFaHPwkODGxzoS0yqqEmlonH3
	3fMmsN3VqdLQdx+yE3ZWeC+4gYILg7KR5YZ5M7NDjhcJ4ADsSokmRuWh1M4hcdAn
	rW6wDLEuscPd3WvrdCnD4aQ15lMrripzMWLQ25QJ4LLl1VpPGdnlJTMg1vz9ifAM
	CGvNCnAGTx6RMt8rnXeAayVYayleEixzbiGMGkekHAcBEpNkx27YQynliA/iXUzZ
	azqFEeiaaXOD+Du9mPSzFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788629338; x=
	1788715738; bh=uuS5NzG70GB8i9bKOOmiNS0ng1wNda4/qEdZYj++dkc=; b=H
	KFGSPHkAzjF+NuiWFRoOaIHlNDFzaTL/arAUVt+RmsvyzDIdhUtEyjgoX4EHPNSS
	dQ9bMHx2LJjsFHaa81djsdangI30X03nyjjd4GaczH8hqFSjF+VvtSp8pFbY57t4
	bGnL/KVfKvWGJBUd8cbzFiTztW/3M0gHZd8E1WYR1K7b5EFCrN+KUCHHDzzzpP8E
	hdHhDyYYu0sP0+sXk/y8Bxy7iBji3ygBOMS6ZDxl1R9FzvU5p3SCbv1iYNne3i5V
	383AO6s0UNZcSUKWPYM/bOq/MXkekg2NMD2udHae2Prl6oL1guGHm68dgoTMC/8F
	P3wZsAKhKvalhHUGeW45Q==
X-ME-Sender: <xms:WlGcalOQrD3K3_zSiLGeCHVrqqHFvIDb5EO2KTwlcnjABIs_1qajVNc>
    <xme:WlGcau_F1rVepb1AQT_7QOODdXyAI6g4Rtaq04WpZymJy6Ma3xf2q2as4jHA6BHGA
    O9t0QcYldkAwiYe38Q7-CznWEUpBEIPfESXiOCh8vkObwV9Y3536A>
X-ME-Received: <xmr:WlGcapQOhYrqGzDbz4uB9BxTc_it3x1G72fdJV1Vav-u065h3y9EGL6KlRYSo8N1GPhtRTKvrA-_GYB0l3Ft_kehMvpb4XI303qWbKPBd6VHysl8V708ju0>
X-ME-Proxy-Cause: dmFkZTEotm6TrEcetlgUpWj2uj/UIr2I1BBNLNtx50zVR6LNPxoiJzguH9uTyT/QsvM6qb
    IJz8MzWhojBr8vNK4ks3TjQa9QiI6V+EoqvRJYYF/Nf90pPRInTROsiZLXrUo66jHOZFAT
    KxHbAtULnA6yzJAvHCaashSNHzsDpIofpAwuupmbvZkRoKPZjGPfxjZfONhhalS22oaYqy
    b+IcbApWqR8cFI9RwQNm++TH3Qc+E9vwnGwricNTdpgYGbIqWIFSIkJLHG8YIfOidqWDT0
    xYjlBgztZLD78/cci9IgyT6bRCelTocqerFLvT5c3o1FBB6XEjGotBTIXuXNTX3xCXJWEa
    IL+5onJQ6xtbdBWSo67Mo2Tl4ebgPSaMJnoFIueMXO6rHX0ibqhFKQPmaJOreXd4rXmto7
    EZFXoLcdbAdq2aXbw3hcCud5z41W9CKZeXpbYVmPSaaHksgLLZPRmXNYvF0IZOMCllyfxK
    6g93attqHQoj6Hgo0X+cCcErLWNEK25l1BNdDo2g0JoGQu1X+BQXO68HXl61uh7ebynhEg
    Rvle/nxJbAX4OiDqRbRJPv3b9r314vB5Phgn4jGz5qSXosE0gBQdYWzZ/6My53Vk856/Dj
    jEt4iDV1/a72uXDMuq45X5Bz722m4w5YtCtaf1wkCXtr0DduQqZGqIci2OJQ
X-ME-Proxy: <xmx:WlGcagk7UCdG8BQYNTMzuYhdic8LhYvXzydscrKpNjjHWpRL4v2iCQ>
    <xmx:WlGcapRuwLmwvYAw_Uqibl8lCBMxH6kBuBw7XAVnQyqS054Z6JW25Q>
    <xmx:WlGcauNaTpGlGEkmK7tHEzp_NZrS_FtQQtuIhP5JvEWDUmfkc5eG3g>
    <xmx:WlGcaiW4M2_9pbOypJhAbcsnpjvMB0YyWAXphWSQaEgldvsOhuu4uw>
    <xmx:WlGcav5cEReUZXhRlbaym9ESKlvwgW1G0Wg1kyZSmv1MxTU40bW1BxwX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 13:28:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 0/4] doc: advertize gitdatamodel(1)
Date: Sat,  5 Sep 2026 19:28:11 +0200
Message-ID: <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_doc_datamodel_advertize.bea@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-datamodel

Topic summary: gitdatamodel(7) is not linked to from anywhere. Let’s
mention it on other documentation pages and add a link to the glossary on
the data model page.

§ Testing

Testing done on v1. No tests done for v2 or v3.

§ Changes in v3

Thanks to Patrick and Julia for reviewing.

Following up on Julia’s review. See the interdiff/range diff and
patch notes. The patch notes also documents the changes from the
previous rounds by the way.

§ Link to v2

https://lore.kernel.org/git/V2_CV_doc_datamodel_advertize.c20@msgid.xyz/#t

§ Aside about context lines in gitlossary(7)

(see v1 & v2; no one commented on this)

[1/4] doc: git: list gitdatamodel(7) as a concept guide
[2/4] doc: git: link to the gitdatamodel(7) tutorial
[3/4] doc: glossary: link four of the terms to gitdatamodel(7)
[4/4] doc: datamodel: link to the glossary

 Documentation/git.adoc              | 12 ++++++++----
 Documentation/gitdatamodel.adoc     |  4 ++++
 Documentation/gitglossary.adoc      |  1 +
 Documentation/glossary-content.adoc | 13 ++++++++++---
 command-list.txt                    |  1 +
 5 files changed, 24 insertions(+), 7 deletions(-)

Interdiff against v2:
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index d588630e633..56b7635c199 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -24,8 +24,6 @@ Git's core operations use 4 kinds of data:
 3. <<index,The index>>, also known as the staging area
 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
 
-See linkgit:gitglossary[7] for a comprehensive terminology reference.
-
 [[objects]]
 OBJECTS
 -------
Range-diff against v2:
1:  35832098717 = 1:  35832098717 doc: git: list gitdatamodel(7) as a concept guide
2:  3d8c4334785 = 2:  3d8c4334785 doc: git: link to the gitdatamodel(7) tutorial
3:  04802040a8d = 3:  04802040a8d doc: glossary: link four of the terms to gitdatamodel(7)
4:  5e8911beb4e ! 4:  ef9469244f2 doc: datamodel: link to the glossary
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/gitdatamodel.adoc ##
    -@@ Documentation/gitdatamodel.adoc: Git's core operations use 4 kinds of data:
    - 3. <<index,The index>>, also known as the staging area
    - 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
    - 
    -+See linkgit:gitglossary[7] for a comprehensive terminology reference.
    -+
    - [[objects]]
    - OBJECTS
    - -------
     @@ Documentation/gitdatamodel.adoc: $ git reflog main --date=iso --no-decorate
      4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
      ----

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.13.g335083658c8

