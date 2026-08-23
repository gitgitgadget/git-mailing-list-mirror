Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E736197C
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484842; cv=none; b=CL4tuHbpCO8+dHd1tip3eI4cKGeLg6PIE7oPJ2mvQ2ZsHJwxwwVFxolVY3irBRDB62kdlv5UCeuiGDreJCfsl9dxIgm7AVRCIgQw7f2mtqu599jLocd7uM2Evr5Jerk2O9HmKwmoS6zMC12avfC+E3F3ok9Qdj4fbUJMXt7fTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484842; c=relaxed/simple;
	bh=74+1nJ85lGZQpfPD/CLReQ/3x1++tqz65zTRTfYQTX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOnGOvwaKeMsewt21ZtKj1Rsw8wziTgmb/g2c4T/uQ21d0KZXga4l4vA+iPnJ/5YExSc2T4LbKccLEy7U45v/5sXXkSsHgP95T7QjwRMbWpY507tsEsdaQ9e/TfseUQWNiXrFYEwwhBlk+D91/EKVK9TM78oz1FRxnW0zrrJE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fksoXYan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsMD+AZC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fksoXYan";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsMD+AZC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C5452EC012C;
	Sun, 23 Aug 2026 07:33:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 23 Aug 2026 07:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787484839;
	 x=1787571239; bh=zM3HYBXo7pMqW6l9MVEXygzBJBVT79QMv2EOsq3GTPw=; b=
	fksoXYan+fhqg2HgoO9Rkvv8eAvXkLzZXBo7uzMu8yyy5UzrH2vyOIRXTFrbQiJo
	otNKLpQsq8H8yuZ7l6l+VnvH73YR8XBpvGUwyct/+Ww1oy+yBihhiG6gyNfsrNfa
	lD2MYWuXnk+8PiFyRrqtDSez+wybtfmgyTv+va+6eWniExKLHe3CpkSoKfNDlo7q
	s2ZCMwUnph2dbPsR8lmX6I71HGQjzS6yN4jXlmFNZMvXYV1+X+48HE4Ph6U8X8nn
	mZZ14xXqpqRiRdAWUhZvHR97SRSLreehzn2bsoXScCYxacbwPihIUPL9n5C+7wxK
	s+8PWfWRuPMCpjqfE+fRoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787484839; x=
	1787571239; bh=zM3HYBXo7pMqW6l9MVEXygzBJBVT79QMv2EOsq3GTPw=; b=J
	sMD+AZCI/TidGAejSqg8fH7DMNXhIC+xb+/xmgpnHPZwsnMYlKfCWIV1upXkNhnJ
	l2szKLrQvjR6YIHHWOwM8RBZZoSpAqocuDQMDndL9F8rVDnSkz3P+jYPogO3VO3t
	+YFWtvQ+TRwT/TAQlPzHzutIjSMcq5hSf2MjczwoknHmAnpo91MyzLMkSsHOLmt/
	udg1twfBNY0eQTClydjQXpqiuxY6fIuwsvCJNPGABCuDESB7Qoo/VKcR2bnziq8y
	LfGRSsnlGzxedkT/gDAvzeH9VFqJz505oXhKJVLH3cw1RL5jkg2mSUiXRrezBXoV
	wWk7cYxxTSXsHqhKmSolQ==
X-ME-Sender: <xms:p9qKauqY2tosmaHI5bmdzFP2ycFQhcu5gkojeJKvwNFi05y2AMkzeYU>
    <xme:p9qKajoYXNsI7X6J0B6IXyPjJv7fWuRAXdNhoxHCIDif2iW_fP7ohsOBb-Mjp25ih
    Gsty5ECPNyNfllaCJm_LXg9XesflIz60wpKTd0XU_D26VR-ZtK9sg>
X-ME-Received: <xmr:p9qKaoN6XDPHmG2Yj9Vfip-6TvFzG5uVzaMTC3dX3N5rvTaJ84HIvd48_XlyecngBJMqSBuudITEHPd3ZmJnLAW_G_6IB7fzQ5iJIhb5vWn8kzmhXJXMojY>
X-ME-Proxy-Cause: dmFkZTGAdgoJw0eISgLjOVUvlkii4gHUtUwYlDKUJKSOMWh2V8XNdblkD8uNPqezVl/w94
    bhYEHTiUzn8VLkf61Ubv/2Q2mBwU+zN5pxNcQnfTvS9cZVEHy/sEfm6zjJWlS/wAs467FR
    RTSA9KBsIOzbJgbAtXYZq0MgJK7ouT9bY//u6N2qDhH4hWMLpkTPL4H86uoIlFokgu2n2V
    5g/G9n4Q3t52bEYGtsmEchBeslDro0bCo89V5UDUM5MRKX+z+nFnLeMOINbvbt2OjLPfuX
    6bCvmRpLlROTgpnmf8pXvx3PvLJsK+6qsM6iYPU6xt3t5v9SfAsoKsW+JuwSivRcgKJFYd
    yAFzTo08oLtzKquTSPadEECn1ib4HO1TmSN+4kDC+tcjU2y4BTVJiahXkN0IQjdi6LfCqD
    qW1sByTml1NghxvLQyMjiKvjAAtvHnrtIWAMNG805p9Rtf9nZ5pZDdfhQPSSJYlPZNvr50
    giR3aGKhkn/bjLtNX76KIxZex4jM4aVzigErjYG4DwnoXywCs/jyuDrR+y3zDzkNev8ZQM
    7nsrgAZ+6pgguWvS3x8cqpbrKM1R/rBKcdQZbm3A3Qto8gYjAAZeAIB9CClD7iAtcCb9wF
    sqN9f4nObJGXqyIgky8UVyTnMiSIbvFV6/FtMNpEB7hrdmEbupRXU9PLCaQA
X-ME-Proxy: <xmx:p9qKaszpVVjGA0IH1lSN2GK1EaVtA28vCe-3cRJqCULB_3rOdZ9oSA>
    <xmx:p9qKapsJ8-mIZEH5bFPV00PJzXadAyvLCa7qPdn4SZTX6k4XJWKtsA>
    <xmx:p9qKat6mlooIP6HJ-NYVziFii-4ivPySEa6vHdLANdO1S6coXcP21A>
    <xmx:p9qKagSUozzGZqIrpgRVsxgxZU5eRYOCgJ0jpcIi3xsDVxVyDePf6w>
    <xmx:p9qKam1sUIKAL_zMAG-237cpZaD3jYAjL8gTO0ibwwqSiedI3QJTbSjC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 07:33:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 3/4] doc: glossary: link four of the terms to gitdatamodel(7)
Date: Sun, 23 Aug 2026 13:32:48 +0200
Message-ID: <V2_glossary_4_terms_datam.c23@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
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
    V2:
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
2.55.0.13.g85d2d65e389

