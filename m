Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75039B94F
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252210; cv=none; b=S7gySNvaKgw5tTc40YqYa/ELmpfg4RdIaylXA8TTv46b0NvT5q9i6RcuTxYIWxXJZiREBE6qFB6Rl8X72ru6tgfbxhikOXN+i9rhvDn8L7ews2I8F7P7xwSR9ly8lxDNvlY/V2NP07j2fsRFxvDfmKm2+vexyNohmsobpUhX82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252210; c=relaxed/simple;
	bh=lDEslpQkCIWT98Am1/0EoWfonbme3U2mnmEfTxF/j/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcuAhAcjOt/OhOu+pQljtoHbvpv4N5VAc7DyAZeCmcbd1XufB1LzDclVu0LplRqDArCvmRUjGzhk28tbnHvcFFkt9wuksyslERcGCdzq04HWjnLjtbnY+BQFI9HdE2MFY6WdvmNfa/yPhFrBPzXMM1r9gXMeeEWnBdtCP17+l3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iW83x5xK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkOw2c4F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iW83x5xK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkOw2c4F"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B46967A013C;
	Thu, 20 Aug 2026 14:56:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 20 Aug 2026 14:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787252205;
	 x=1787338605; bh=D9jm011NQeTvonrw+tJMLaIyemg0g6T/wvmLbvFqjcM=; b=
	iW83x5xKzn2H62PR8H4g6BRhHEQAbpy7XGr3bF92OVkWVONhGUN3//pSLLITLDsQ
	QTJS0Yy1ug9ui9dfFemkU5z6RlCMMCxHn24SGqqvzVKZgV6hGRE31A3pVnvMIfUh
	Enks12Cdo0ZPWaOjKpLSPS/VGiN46BDpwFV8YnXMnl3jKXeKimefIFPOiUR4qk1W
	NmhgHtYjSaJ5Uif++ekd0tzIXcui0fXlywiY74vkkDaSB6Ua/w8M7FWKlXulMkJz
	p0jQWmtSmsY+Gt1hD7OElBhfVWoSa+EN7yhVHAO/hHXL4NEPYWh4QRD1j8sLNDHk
	jjVEn7pIJE8IpgxUah8gJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787252205; x=
	1787338605; bh=D9jm011NQeTvonrw+tJMLaIyemg0g6T/wvmLbvFqjcM=; b=X
	kOw2c4FGyStmEVQuEePM+n/saKyG3vD97p8XcGxes6fDQSBbaUFhnl9XhJuSa7Y4
	AWnOfVje8WuciyaWY9spKAP8AvbpWXkEiwsZHqWdRaf+S2tRYTVlHPdlR31pPSRn
	oZsl8slGxY2yQUIHDPSMqeFzPrN9pk8BiWLGlXvm17F24Q0Mdp6feo8lJ5d3Z7Zz
	1gQ0SikhZUWW6iyrQViXCxb/OiYcd8rKSTr1AF7sw46+eg/WrrslKlBjLiPOnULs
	7pJE+dbrAsS1r2GXN8K5KHkzKm18zgObkKap/taRHKGog0AdS0MW3D/YkVUbiCQT
	SQn0MczPHQxb/COWtiAXA==
X-ME-Sender: <xms:7U2HavEzoA95dYuoOBWlHT8QYvFptkTHRLLHP_4-wW2VJjA3KfXSf_0>
    <xme:7U2Hajyb3iciQenqcak9FuXP6XWyPqUQd5BcN7uRtWQKei-ToozjqLaOHeBymK6fR
    yL4PF5Gfn5q5gX4pfLo0PbMi7dk6wh-NKJ6aW-ZzCpp6AeLfhTCkw>
X-ME-Received: <xmr:7U2HaugIDlE9wAkAOe2ACaqQRbWV0C-Rh2ILDkXsduIuFSS68U9e4zXoHwTCy-7O44kDV_XWnKvGdE2k4PJpmx_IT_qh1EUsaDq9pkIcQfKxo-a8e5FzG6Q>
X-ME-Proxy-Cause: dmFkZTERr8cIfkRsr96S1UyQ7fC7gyn3GxKGClH1sKbV0gTCC73LSxGS52pK+IKxFsCZeh
    r32lyaZRpSDSakipetnF8TYoOX1kSVFPU5Jy1ZnWk0tgVzGaG7cQ4oyAxtOIl4/SaVW9oR
    DtylNyLUEfPTPiNe3ebWX0FszgDtEBITDowCYzf47hq4CUbbzBLkMKRXSBjICSDqhXl2hR
    9l7NglNA+9pnVdqESXa8Hgfod0OwxScYk2J3ssbp6aO6/FPNuOBrIaBXQwGKUzlCcuQ2F1
    t6G6+RZdGQqWl7wWxRgM8BjJSwFLtDWamI7LsV8EwWGb3V03Z1WPV9Cfq74DArwHx7FWZG
    Tho6cw6w1NOl+VsRd06szTT2qN1LDNQMI5wZ1LE8H4vAes/7JDwJ+1cb3kjQ+KYE5BxfXO
    eNxCwf/SvJqAn10abd3BpD/NUASoqrK2khJrIqay+v7+wutbwrO7Ou9HRmUCOEIHsCiptR
    PS5IFhKGITG+hlVa+/4CUjttPchkyNGxiHbPR8NwAaI7kzapQOH9J6PBTdqtwbeKh/yxax
    inTVRDKdQ4j8FoF00b+/MtVl2jm2pMwbszYwF140lTwQ3SpKqg8GC9I1a0iPZVm7LM9Rqt
    Yg+ZCdnvR4w3UAvvFR9Fg7rKtZm8btnk/O7OOgBi9ESL+7w3pAbBO8TbkpOg
X-ME-Proxy: <xmx:7U2Hamy-pG2EPZG2u9cP_6hetWEBl3BNv7pbbZ6FimPz6phORu77fw>
    <xmx:7U2HapKXK1D9kjYC7ZYfMEv18ARcxWN-vJDcmQ4_8vq_oJped9W9lw>
    <xmx:7U2HalQ25q1-XGd20ne8SDysqt015EDXDt24GUfzCQi0uldWp8nOFg>
    <xmx:7U2HapqjFzuR9lVCVpEabKlCXmx84yFCpWubbjeJFW0I70PdVJXH5g>
    <xmx:7U2Haj5XFC6bZ7Hkt69A8VvCzGxFONnkf0uJ3OzYaxxuaRAg_7t6ZPnr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 14:56:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 3/4] doc: glossary: link four of the terms to gitdatamodel(7)
Date: Thu, 20 Aug 2026 20:55:23 +0200
Message-ID: <glossary_4_terms_datam.bed@msgid.xyz>
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

