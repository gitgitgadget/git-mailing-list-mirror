Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C52248A8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847986; cv=none; b=YaapokvfjqXTKN1puz2P8agosFPSWtJg7IsJUeDp+ALGSEQXgrk1K5H8jiidY8McaFhGBOF1k0gYkY53EI3Qg8ODNTW7o0yWnwq+PetJSg309Zlr5JR8WeaN4UwYZEsXm7chyV/RDozivj9PyNkAHr0s50hbgGwsJdhx0gTKOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847986; c=relaxed/simple;
	bh=l/n9hNqSNSUGYhdxqfLd+SbilcFku7XYYObvq9HIT5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft2NhxWhZL+UMNtuXw+CRVJQPkZwY/K4olxrneuq5h6YE2utJND0+JiNGMrETAQuXLo6eJRMck80SvPt4fq9T0yk0AJs72hJTiqffhePyQwnqOLGxHaXXkBmtUYTjfYbMaQt+6tFvEukxhPmLDyn5SLKvRxlqB/KdawNc9MKTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N9LidrEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3VYDO3x; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N9LidrEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3VYDO3x"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70CEF1400179;
	Mon, 23 Feb 2026 06:59:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 23 Feb 2026 06:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847984;
	 x=1771934384; bh=of3b6L2liBffu1AI2lbo3/U6xxdxL3fuVKezNK6PWQk=; b=
	N9LidrEADhyAtuGP+x0NyXUtSTNDLOFmHOOpCCLyHH6GBxf1jZVtF0w4x+HTVCEu
	CSGzUU//3R9GK/huMEA1p8+kjgAptbZYLSlZXYXvcqxHHr//C/6q45o6wnY/B68F
	lNI+zTVELCqozr04SkSUsafJ8xK6ELqOx36RSSKTeiu87E0zylFUd1CAc/xHQ9OI
	Efm+fGVLXe4qA+08t8Z9uNVvcJGArqB6d2Lu+sPxs8LCaEnHZHZpKRa8POgIJguE
	f1VgtsHGl/rSuGHHNUMJ1kKS8ePJGrpwMZuQUOesAd2c5rcD6mv4BiIG+s2MR7wG
	RWH+HO5gB5zzag2BdQCsvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847984; x=
	1771934384; bh=of3b6L2liBffu1AI2lbo3/U6xxdxL3fuVKezNK6PWQk=; b=V
	3VYDO3xwJDJYK7IpLYOwh0k14l1vGIT4xNyeW55/w7uWd3xn74QHe2fBE/mEZzrG
	MJBi/BvVy01BCzO6iADRbhdOjPPyKnjUChQvxYcFeczcb7qoLdHUfG6e5MxJEYch
	pjBmdX/m3Ez19l7YNMeAdk58BBz4c85rVxh1QcGVuFan0bmuqZI4MlJd2Jk9c3Py
	MDpQxm6eERZ/3TFip7GJew08BZ0ayeq0cyWe7c0uukRrXp1ipslDop+/c2f8A91g
	oL0qFp+2A0yqDjAIBEFkFsizyG+i4p1CI60yf19e9pbikBZrAwP5dRszQpxT1gp2
	ENuy3ZfdYIuTTQudOVP9g==
X-ME-Sender: <xms:MEGcabZupxLtrk8o2CRw4fK_VdSWFxFSt-1ejO31C6yXud8AUzDKPw>
    <xme:MEGcaR2fW_RQGt3hn6i7C8EK8694svz2RFjZBHcq2V4_2zOU-KWgqSTw_ZSffJV_0
    frvNfeE6LSgBzA6xbbTR1y2LchrBmHNaBo1Pgukit5tI0I9NzB7>
X-ME-Received: <xmr:MEGcabXVMGXSj07JWRUTChVCSe-xSyjs1uLHbQnrWcH2SjSXeGjkfpCYMv__vlQFCh5T84pHHWArqVbmKGKqC174y-hL9NVtAMsfu9Ss-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MEGcabUfctej23zTvb2zG0MJLAfs4MZEWO9qXFIUkc2Pt9rfJ9S9IA>
    <xmx:MEGcaaeZUd8bEh5uRFH93xlNSajWME2QKhqJrlT93tpRaRXbkg9spA>
    <xmx:MEGcaUX3T-hdUQzM_T3_z62Bg3Oc8ouVimp8sFmY3-ygPyTKcA0XJA>
    <xmx:MEGcaTdQo_mwtw34JQTMO-2CemfbknFvBfUkfmEkcP1A1p3Uw8bagQ>
    <xmx:MEGcaUVabeYXs5DMwmIhqhsEAZjn-1-JrSj2tIPkXnZgqO42yJ81I2Xy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4173ffe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:35 +0100
Subject: [PATCH v2 01/17] refs: remove unused
 `refs_for_each_include_root_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-1-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Remove the unused `refs_for_each_include_root_ref()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 7 -------
 refs.h | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/refs.c b/refs.c
index 600913b99f..466398494f 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,13 +1932,6 @@ int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
-				    void *cb_data)
-{
-	return do_for_each_ref(refs, "", NULL, fn, 0,
-			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index f16b1b697b..1fdb809343 100644
--- a/refs.h
+++ b/refs.h
@@ -471,12 +471,6 @@ int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    each_ref_fn fn, void *cb_data);
 
-/*
- * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
- */
-int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
-				    void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.

-- 
2.53.0.536.g309c995771.dirty

