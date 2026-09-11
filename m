Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A233CAE8D
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105944; cv=none; b=ivGdFD7xvDncyjCdOAzzCQLSZaWJdiPPKv+oRME10HNM/2/TcISFXOz6DSZA8axCZquCIuCjj/AskhBADJKKTivu09wCE1uoLrYbxSgfjQLKL+agyD+5xhhvM36GWmUnXoCBv/KYNU0I298cED7XaulEyNnw4G4vew5mr/GVaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105944; c=relaxed/simple;
	bh=Pvkf60iu7cjrFjJtgHpp2c7LnQ7zOp01GaXsJAKmYdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=af5IABVay6n277e5HZzi91FBMYFEvDt2S5yZnSglwgZV4lkuNJmJHPeo0cpkFPpBe2U0xI1bTj2Igp5lawk79GtKV6iXeMosvijs53ZpBqacVQGpM6zc8D03U/k7AdPHxYpDL7CcTmawJwG7LTKsOM7y1qzI4PiB2AsJt2AuSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPlRaOW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=szUNKh7f; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPlRaOW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="szUNKh7f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E43EA14000CA;
	Fri, 11 Sep 2026 01:52:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 01:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105942;
	 x=1789192342; bh=ozU3Q0jIXKU6CGJQtcA8m5am7tOuuqVr2jGvOzZqolQ=; b=
	HPlRaOW4F7ZIRuMDSwjRSwbn+xjC1lLCkjAAcUskkD2Bbdqmp967mvWAjlMO1w8u
	hpp1ZwZF7JxBlAZatb/5dyU/YLJ+Zgn0vGBs2Z3S0fo/tI8RrWp/WtBXSMU1ZIE7
	TJWDgxYBhSPpAuO+mUY19n7PueFWM7E4zxYinXUJOohTZSqwac+Y8AM2R9xreIoR
	r+l+wOU51HfPRBssCmWVjjK7bJTioi0+ZZNuWTuYNUCAV8/WHPokjtXfjw/JIq/W
	w9yoF0Yrkf1ceMlDlu/nyEThPamgU/yY7XPB55I1K9NVYcIAGo3xN7QElUYhQ/1C
	l01C98ceG3a5/OM/1Igjbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105942; x=
	1789192342; bh=ozU3Q0jIXKU6CGJQtcA8m5am7tOuuqVr2jGvOzZqolQ=; b=s
	zUNKh7fau7W6kGh39FOOBIxebiWMLaFxUXc5jZ9z4iliZPLE0BnOlOKsM15F7IVw
	jUCzqIvPY8Zb9k7RqFjixNAf8xOZZ1bWKPPljXrgKNGbdFX5SuhiT1I7t3np/EGj
	uT0wUAJFZ1GkUlKQhVVtLr1EJy2o06rpllu6MNM7Un8QPw2uhE4+l/LBqr8RmuLQ
	Ch13TFqF7GUsnXmA+krDbJankvVyCps7XE74mDy3MpwEhbHzZlMPHP+oAb3OV6hO
	mp9kOpEyDbEvuZjkogu7UP/B9NzMmaiKCzXPRR/OS/UOs3569/KJRyMUg1PTu9DL
	1m+TWnzvuiozU5Vq4+zXA==
X-ME-Sender: <xms:FpejaggGKuEttS-p8vAns15OfqV8Fdrwo3w-4U4XDmYfXp28eGN1jQ>
    <xme:Fpejage5gdHqfI0ZXHPMWE3craU3Zi-hKdYUWhtMQMsCWcNMetOtWhFNLiNSbualY
    MJkWbCwUXI8p52pBoXbTSNBm1JZvySG5L-ozfY-l_T4EzD5-XOO7vg>
X-ME-Received: <xmr:FpejalcaapkczErOp-wHYfEIec0tLGQxZ8_PNH1oE5vlCqND1JQTX0XuB2iCWHjnqM3lHg>
X-ME-Proxy-Cause: dmFkZTF/5VLZWxN1li1PLNxu4R8NHlST+cwRfiV+TRmfTOf1tjMu51Ms2Kl+4kwwErDkji
    Ex04gZa9FrmtYRh/uSx8X9o2PoZUuwaVmUxBYUaIse/9NbJsyJol2seGGgxJMopEn60rDS
    x/YIvcFYbEuA5awhTibhv/9nXajrUV8j3AzsUm/QyFfhx5wheMlJEVJ0e5kxL77qgE1m86
    SZFlZ/s8Ag2zw7omC55T7b6OA0JhJd/K3A7gCUe0DRCX/Pe3MuwLFCWnWyEBKVM312f6vO
    7aau/PmCHYJzWUJxGQywvozn+/vWhbUTrJmu1Abwfwvz/zJ5XYTgzmsSEha1ht+dgRz2YX
    6bwY3m9NIG9gOflVR5EH30+K4yHh97vY+xZOQQmv0kSVHFPOIgKjAW43Cf8L9p/PaqS71V
    mwvb50JUKJH1/F8RS0n0rewlvP29KTAW3y4QZVJFywcwQh7pGwTOeG59KQEyLGDk8cSC/c
    ItpxAsIfaGsft/sDWWmFEPuLLnDq/pKdzmBo6ZxZs2e+62fILwSPBIu4PKxaoG+Tx2sv6l
    imw5bQ855QRKMYcm4JunB4wMHGdUSmQ/wA4vgStT3K6NDVJjQSAVmlDEQNzJ9C4jQJM1pn
    KhHsRIH3Aq7Eud6CehuNtXs81eoqftS2ZlKmwvk8iy4Gi79Bor3qiMj7PXLg
X-ME-Proxy: <xmx:Fpejaq_k1Uh7LvRphioMqdoEtdNtZ2YHX3hw0893f424jWq-5OJfgQ>
    <xmx:FpejahkUPSzIMGSA_fEimrvsNTBtPCX9QdbZTizD1ii9WtDu8QANIA>
    <xmx:Fpejas-FrfUnVVYYhXi4MjbfIy2raqBT7s727uh5uj1W3FUnrDzxqQ>
    <xmx:Fpejavn8wMviQlllQPrY5G89fI9RO6ar3iRFtTZyA24_Uj26Hf2YCQ>
    <xmx:FpejagdSR-Y1zMNDKh4yVgrNh6L-EGWK3IzO5gLg5wuj9yv3bivg_F87>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9ed6d18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:56 +0200
Subject: [PATCH v3 13/13] odb: remove the ability to link sources ad-hoc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-13-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Over the course of this patch series we have adapted all callers of
`odb_add_to_alternates_memory()` to not do so anymore. Remove the
function.

This series of refactorings doesn't only simplify our code base. More
importantly, with those changes in place we can now unconditionally
assume that the list of sources linked to the object database only
consists of the primary source and its alternates. This serves as the
foundation to eventually move handling of alternates into the "files"
backend itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 6 ------
 odb.h | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/odb.c b/odb.c
index 2f8a70a90c..5fe081496f 100644
--- a/odb.c
+++ b/odb.c
@@ -247,12 +247,6 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	odb_add_alternate_recursively(odb, dir, 0);
 }
 
-struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
-						const char *dir)
-{
-	return odb_add_alternate_recursively(odb, dir, 0);
-}
-
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 						    const char *dir, int will_destroy,
 						    struct odb_source **prev_source)
diff --git a/odb.h b/odb.h
index 54548efc55..9025239df5 100644
--- a/odb.h
+++ b/odb.h
@@ -258,14 +258,6 @@ int odb_has_alternates(struct object_database *odb);
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir);
 
-/*
- * Add the directory to the in-memory list of alternate sources (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
-						const char *dir);
-
 /*
  * Read an object from the database. Returns the object data and assigns object
  * type and size to the `type` and `size` pointers, if these pointers are

-- 
2.55.0.1074.ge7621b4bad.dirty

