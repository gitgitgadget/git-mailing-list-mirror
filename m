Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770535BDC5
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962385; cv=none; b=Uz67meZuuNXEybtgzkRVFUe2R2W9NxTHZqju61jk/K87/Lri9Pki6mMwdtcjb8XC38AG6I+TWXK57xKa3yGm0N+hKJsctnHRVwrqBgFffdk0R2iwpABRZw6UEJORa6Asar8kn3w7QliiqCrizAQbTIRzjuYW0zqmsFWpxPWrSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962385; c=relaxed/simple;
	bh=WeDHjyT8fx9DpoRCrCiuJtcHgeITsvpWRalfEPlz4go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pk1nb0LrTpvr3hxRlA/w0ifZe4D5tJS/SQyIXe18WeAPoVXYcnvLoOCCGgdqIzNQBZ3qPdoFWSgYQmAymGWDeB/EYQJAbeX47j7QYQVJ0aTP8e7KdpmuhzpCITj1f9lGUP0zm7BF8HTS5sAxmsoyMaanr2ZNB4klHX+zaq7kNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjsdPIdt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSLOaJnc; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjsdPIdt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSLOaJnc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BF311D00185;
	Fri,  9 Jan 2026 07:39:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 07:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962383;
	 x=1768048783; bh=v2Xs76e8WiwG+UyLNd9AEI5SMwHx0TOTlTIaYJcuH4k=; b=
	fjsdPIdtHd86BJJDG9oRqld0ouFQXT+58jJavYIHuPnfnrHSKyiVh71hjFns1Y7A
	uA08KS/7v1iiefznpZ/SeieSBwSJNui92n/VSvmsPmOKv0wcjMsrrxkoiwCg/v+v
	bTPtd8k1NBQVgIGAWswor3XQZcchOjA6CDyiJPd1U/PolMpfVXIyJQ7CJ+Ne+mRy
	xJal75p3d9lrGXjaDHyCgH7PZkfgc+uzbBQsb80uz3fFP4lJpJsu//70I+nBDIs3
	ctIkYHC64ltqUpLHJYa4htggwqDGF8mYhKq+Mbiro587yhpSq+g73wt9TKnK9yfc
	lkQSeegpQsBahs6qKsiD/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962383; x=
	1768048783; bh=v2Xs76e8WiwG+UyLNd9AEI5SMwHx0TOTlTIaYJcuH4k=; b=e
	SLOaJncGojysppwmjBs3NruEjsIEhVuw0urPQDNoMGHOCgyJPspo/cANVoDYrrXw
	2qrs2XL1yjWV/IZ34wJkDjlllKefl0Ke1AWFaqpmB79IoAVvgMFSdChc/qMwKQWa
	f7F6G+vBlg1MU0Y7j+VW1Z0gRx2hoXA3cw6FzyMe0apSC71NH8OwIkBeg84IpoTa
	rjfolhQGjrzaXvFsbDfe9ZbaHN8ff+0F8XiQhdfEE+VD2hgfPHxr/ZXeRDoeriOT
	QpcqZ09eDQU54sm5StLjACxN/wjS/N9cS2BIUpY8MYDbWLggDmE5vAVSGeMESrvz
	obEEbivXLKP+1YeGYfG3A==
X-ME-Sender: <xms:D_dgaTZTJb5h52SqZluBpUdiUFUg-9sAn4CVQU7CiIs3W0i_HBkzXQ>
    <xme:D_dgaZ3pQLqZ-Tdnul4vvbelRzujXDffLOp1dZOIrV-2nwl3dj01MpXT45yKj7ldb
    cMC4g46VMsgqJKhWDMa_FLpR1ZSE6FuybHmoRYD6OIxpE_XyQT_kg>
X-ME-Received: <xmr:D_dgaTWOwFahUHR3wm_rFE7VjgTMGPB_7yk9b8P27Yjr25jWa6-YyS7gFgjmivzOmOVQBM-SYeoa7sFL2QWpoURkuaUmKuCp7jibqoHAYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:D_dgaTWuZueKCYu-Nfx6XRn4nKSlBgZ5sLRyz1DIcLCEMZUcyCrKiw>
    <xmx:D_dgaSdGecCaStnNM6osPPWI6Do_x15eWPETYr67gHqQMI806miamA>
    <xmx:D_dgacVpL3FJnncEIhMN1JwRCclgEdrGCm-823tAmUNwqFeW374-wA>
    <xmx:D_dgabcQpo8utYd0h5j0xV3jX9HNOgljSOWqLwf383P98UFnbqZu_Q>
    <xmx:D_dgabRTFfEbpC1qFED-nZL6n-SIKF8qzjBMfAKtBBmw_R0tX51yb9V_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d96ba21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:32 +0100
Subject: [PATCH 03/17] refs/files: remove `refs_check_dir` parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-3-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The parameter `refs_check_dir` determines which directory we want to
check references for. But as we always want to check the complete
refs hierarchy, this parameter is always set to "refs".

Drop the parameter and hardcode it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index feba3ee58b..0a104c7bf6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3898,7 +3898,6 @@ static const files_fsck_refs_fn fsck_refs_fn[]= {
 
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
-			       const char *refs_check_dir,
 			       struct worktree *wt)
 {
 	struct strbuf refname = STRBUF_INIT;
@@ -3907,7 +3906,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	int iter_status;
 	int ret = 0;
 
-	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
+	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
@@ -3927,8 +3926,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 			if (!is_main_worktree(wt))
 				strbuf_addf(&refname, "worktrees/%s/", wt->id);
-			strbuf_addf(&refname, "%s/%s", refs_check_dir,
-				    iter->relative_path);
+			strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
 			if (o->verbose)
 				fprintf_ln(stderr, "Checking %s", refname.buf);
@@ -3960,7 +3958,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o,
 			   struct worktree *wt)
 {
-	return files_fsck_refs_dir(ref_store, o, "refs", wt);
+	return files_fsck_refs_dir(ref_store, o, wt);
 }
 
 static int files_fsck(struct ref_store *ref_store,

-- 
2.52.0.542.g9473a8513b.dirty

