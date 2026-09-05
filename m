Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C437EFFF
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629398; cv=none; b=RLlaE7/9D+/fo1V978AgBOy7GT8fDF21O+TuVAESDu32B16HDn1na2oA0Yi1H7vfLUNCsVrzZjI/yDWfLh2DAhVe4Juazt8PA46Vqr2+TvAuYlpo9a0balFHXQdQOejdqwVZ4OBPkKwdWXPk1VV7hR3UZ2xYlkNa6OJ+2EBi+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629398; c=relaxed/simple;
	bh=7UmVwa1MVCNhJTWAnJa8wz6KgbfRYzfFBmyHSv+/5WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKFyWgVPiCSMDU/cCsCYbVzBqyRNynFVadxw8QGdFAufBz4fhcV0IskmbI2v2+yJBiH1Kd7y9dM/YUy7ORTdUi128A9nEWNwIaW3Dbwb6xjR/ubsBHWnd0xRzIvbHQVhITKQ61NIgfrRdBOug9+wyCI2IkNy5JBkTjIRKV80B00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V5htzyHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af3oa0Sv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V5htzyHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af3oa0Sv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 309B57A0100;
	Sat,  5 Sep 2026 13:29:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 05 Sep 2026 13:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788629396;
	 x=1788715796; bh=w3RuMHjj+CkmRJhVPQiJ5qkZfiqal7dkT5mBtO8sHMo=; b=
	V5htzyHltG9EO1K46TNTVAcnAokDAy4CnMt0fmDUMnD2vdOsmPbCgunR9prbjQ4r
	pSR1Y8tMC5aQnviGAWHB06w/yFd9tYjRuCXGBje+p2qY4V+8qo/S8NfhokIop+M4
	pBEUJ0yG99NgBSpISBjc91PBrfIrtCqkrAUXEnRfIZdXmg9sTRTjkUEkIL0JUAQ6
	YfADPZATDr8NjrTkINcll/bZOB86PnKreL1Yl+HRhYbDx3C4hlCRGAEI9HVMKb0A
	g2zhqv2zNJzc9GrIpHGDzF+9qqqg6SsRBdhrs+oGsPLs+wlri5/LredePZaf/qFW
	JL2AdlGIN1JfPGaWexToKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788629396; x=
	1788715796; bh=w3RuMHjj+CkmRJhVPQiJ5qkZfiqal7dkT5mBtO8sHMo=; b=a
	f3oa0SvbyfIlmJtXT2SyG/S8R4uP/d6Gt7Xm/LepQiZ3MR7BVWGPcqMGM6tGpNnM
	bgG2596M1T+2BAJdjRcsUverEk8omptryosBHKFwS9uAXN7HTjFSJ2jg3kRln8Wq
	/JGyTW30ApQwjZtdn4UKjtXzerSKPYgRIkrJWewxazjeTD16mbf/BvZdjoCeyele
	04728/6wFAqvFtdZG9CJmPbzfj7d3fgHp74pRAbi+tKmxkI0spAFkRNlegEIyfcH
	wizT1lZsuUcHSAtSzQv4eZf86qpfVwtT3N+sJzvnTDVi8Akz/iqMgb0j4seARGdv
	SMkdZOi2TOOjwBct5qhsA==
X-ME-Sender: <xms:k1GcagefWsaY4hnRxWmw_UGID8dtemcJyR4X71EFaUFdtOfdHLVLjok>
    <xme:k1GcapPAGO-3p81Ojvqvdrfxi-ixikNC2QP3OguynJUVHLiLaEKkphdg0sthrkXNQ
    Z8FqjdIXJRUAI-1rwStOA2eZukRrj1nCWtRZEYZLaHzrNz0IauWc64>
X-ME-Received: <xmr:k1Gcamge_Hklh2V1PcpcTT0i7ZBeMWuFuZX5hQb5MGuBL-dQzUPoaR3driYoet5hnWt1NxM8TpDM_zI4yJSBpmcOItgEqCZyZVCQHrSs_arSfamejBeTwFs>
X-ME-Proxy-Cause: dmFkZTE0L/w4UMuRgxmqW7uKGz+6hCKZgvzzYMQSPRWVuObiKyYswtqELH0GQmxlgtMsdO
    Q/zDSLChZzPv5c3Care4V5oALv7Dz8kRGuRH2d4zvWwhaIw5zHYRGiyN0kcTK2llCPHcca
    kESweVz8suInnZiSUu4S4OJXX0SMojDiIgg5FtilhNjD0Sx5c1F36c9IuPG+ziODt0sork
    1piaSENik0wdnPE2otQv+hBTLamLTovUneRMTLU5ta8OqC7T+8IF2F7dp85K5o3i5FDf21
    nCtpVnKhWykJCG2CNbOTODlgLfoC9P0jLlcKdnV+hXY3SIlZQ4xM2gMVreBsNhJtvVDJtH
    xr4VfvD+M2fhBUkpKb3kT1W6zGHcF33wWcarb/rtxKWw9BF4Kb+9TUUNvxk/5YvEHp3BUd
    4Qzc4G6b5GYj0psOO2PusnnjWOsxup4STU2sJneAjZqcxVneAJANH7N6AoNs21sFx3DUr9
    jfbHHai1kh6c29n5yVZnC1VjmD3UJ91gkd1QoAYujOvK3irFLjqpUKE9BcHvMteLBTSKTh
    +VshWJsrtI4mJ8Kqy9AMwOu/dkK9l6ZynXwilxNaNzonOltrtxVIaL+R3AIFw+4BzgoVhf
    M3BNBdk8nET9xNq3ZCkgsz9yJWC90RWECRINTVyOLs6ds2xZ+faXTtq+Ps1w
X-ME-Proxy: <xmx:k1Gcak1wqoSxTduGyZfWk3RHEATwvpPz0tf4TrJSNGbMcrIMLywUKw>
    <xmx:k1Gcaog0tJcrZQUmfw_cHoMN-UsoX2maUtK9cqZPjZO9s4kHRo37Iw>
    <xmx:k1Gcasfb4ir0VodWWtFLSDtSc9hs8TcRaLlDJ13EHW74wMlabWnULQ>
    <xmx:k1Gcajlxa8mPG-ubLK5u0tYT-8IEzchhue57flP1AUB39leCESyUdg>
    <xmx:lFGcatLmkP5Ue9ZARfWuPUmpuaSKNGbjQBqrTe52AIW2MUmxEnGSihTp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 13:29:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 3/4] doc: glossary: link four of the terms to gitdatamodel(7)
Date: Sat,  5 Sep 2026 19:28:14 +0200
Message-ID: <V3_glossary_4_terms_datam.c81@msgid.xyz>
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

Four of the terms in the glossary are discussed in gitdatamodel(7).
Let’s link to the data model page from the glossary.

The phrasing needs to be tweaked based on what gitdatamodel(7) offers
for each term compared to the glossary, or even other pages (see the
git-reflog(1) mention). For instance, the ref/reference discussion can
be called a “see also” since the glossary here already goes into
detail. On the other hand, gitdatamodel(7) offers more details on
the subject of “the index”.

Let’s also add gitdatamodel(7) to See Also. It is at least as relevant
as the other tutorial pages that are already mentioned.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    No changes.
    
    I reread the Ref entry in the glossary and compared it to the
    Reference entry on the data model page. These two texts cover
    similar things (except the “irregular refs”, only covered in the
    glossary). The data model page is slightly more conceptual in tone.
    
    That’s why I originally went with just “see also” instead of for
    example “see also ... more details” or “see also ... for a more
    conceptual overview). They are too similar to distinguish further
    in this context.

 Documentation/gitglossary.adoc      |  1 +
 Documentation/glossary-content.adoc | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitglossary.adoc b/Documentation/gitglossary.adoc
index 0e85be48470..b046d9cb293 100644
--- a/Documentation/gitglossary.adoc
+++ b/Documentation/gitglossary.adoc
@@ -16,6 +16,7 @@ include::glossary-content.adoc[]
 
 SEE ALSO
 --------
+linkgit:gitdatamodel[7],
 linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 8c4e9dd3bee..52301a56dda 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -251,7 +251,8 @@ for a more flexible and robust system to do the same thing.
 	as objects. The index is a stored version of your
 	<<def_working_tree,working tree>>. Truth be told, it can also contain a second, and even
 	a third version of a working tree, which are used
-	when <<def_merge,merging>>.
+	when <<def_merge,merging>>. See "THE INDEX" in
+	linkgit:gitdatamodel[7] for details.
 
 [[def_index_entry]]index entry::
 	The information regarding a particular file, stored in the
@@ -290,7 +291,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_object]]object::
 	The unit of storage in Git. It is uniquely identified by the
 	<<def_SHA1,SHA-1>> of its contents. Consequently, an
-	object cannot be changed.
+	object cannot be changed. See "OBJECTS" in
+	linkgit:gitdatamodel[7] for details.
 
 [[def_object_database]]object database::
 	Stores a set of "objects", and an individual <<def_object,object>> is
@@ -587,12 +589,17 @@ extended in the future:
 Different subhierarchies are used for different purposes. For example,
 the `refs/heads/` hierarchy is used to represent local branches whereas
 the `refs/tags/` hierarchy is used to represent local tags..
++
+See also "REFERENCES" in linkgit:gitdatamodel[7].
 
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
 	it can tell you what the 3rd last revision in _this_ repository
 	was, and what was the current state in _this_ repository,
-	yesterday 9:14pm.  See linkgit:git-reflog[1] for details.
+	yesterday 9:14pm.
++
+See "REFLOGS" in linkgit:gitdatamodel[7] for a short explanation of the
+format. See linkgit:git-reflog[1] for details.
 
 [[def_refspec]]refspec::
 	A "refspec" is used by <<def_fetch,fetch>> and
-- 
2.55.0.13.g335083658c8

