Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14E35B151
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962388; cv=none; b=coxy/glCv+ShVS/wXMIDX+Le63rBNfda+I3TJPx6aDIoOyQohz89RlL7mx1b31j4ZQpaMR9TdbxAQnuyBs8dpwzh8de3DHFcUtW8H+0VRJKlq3WyPosp8rOOEX8V1xJ7OqtSVljy6puxvLYjo+7vjtxg3pkB9IhBb6+su52ozy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962388; c=relaxed/simple;
	bh=OXvC5Mfer+kuH+c3vSqXRRVhe6SUtckOTQcpkN6Qpmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjG9QVPwwyrXWP429nf5h6A9/AkIPSIU3g8fj2UNT4QS1hjCrbpD8ixXn9kPGkbx3JHRH9TwWlGv1F3ysBjRljc0Xv+I0U86sD93AgOG9LbQs4RI9q5sGWDCGV2zZbWExojkz/GbGZ0DIXB8YxUKizUAEjX7xx96EcdcdqlwNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=euyYlZFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pN3T0lQa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="euyYlZFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pN3T0lQa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85EB97A0170;
	Fri,  9 Jan 2026 07:39:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962386;
	 x=1768048786; bh=qoAjkY5PYBMB+meZasF6E9jIpTj5dtuansqkBttM2UA=; b=
	euyYlZFAHCHOoH6WynePsn6yYWXdCm/6jvzbrYzVW7Pr5vP1oR+E1iFFeDHFdtQs
	DS2+AKjQ+aEjLtOBmt2+01dJzPA8GEFgxzom6tdgKkK4UDaLGKTk1GkmD/Jy24uW
	caFt7/rtPXhreeXWuAUPQGLSsAmFGavjZ4ixZLZ78LXqu11hvK7HkuxkKC8Werjo
	wqyryqGrCZ3bw04GI+wUkR/wWQLOAxkqcxCp778gsCzOuix3Q5ULkGDlAZKp8zyg
	5vvR5EwX6chu3ROK1kWK1/F8z8mYEimJGgyUgBDD3jv4/XYF7x3h+ZokRZqXDJtS
	oy+vOvjAb04ok8CirgEQ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962386; x=
	1768048786; bh=qoAjkY5PYBMB+meZasF6E9jIpTj5dtuansqkBttM2UA=; b=p
	N3T0lQafky88iJ1gBKT82MCGXSFeL2UDyGozE1JAuf9DBQjKFjsMeX/In4l25cKP
	wFYncGrXp5uGZxVdVdMNDFvYt7XIa2ri5oycc0WbENyIz9jRXjA/bqWFYyHxo22C
	wvBvuXfnmyrg5B97TrlKjvyPEOUsh9EHyxLCY9o8uv8tPLIRmanXSfuHHE8P6Jj7
	I8FBmBGj0YyzolbvfWxlCI8LnNLcE6oRrs0CGohvkxJqqNEtRIMurxm24xHpNsRX
	2fs67lzt0yaLLbvxH2u9qXiNQxHQefcncBgfX3V8nqfYMFtziAPMdVnGweczxYQa
	YehkbA9SjmofLarBFHNjA==
X-ME-Sender: <xms:EvdgaU4olRt2H4pNwNQIj8DPnimfF_6MVy5OE0ImmmapA-Cl5pEbbA>
    <xme:EvdgadU0cj63eRmsOhvrRMtw1Jo-iMt8PnPtixh7Kp82SvSi69OdiVk5zskWXtzGL
    fJ_hT13AYB6sYjeOHNA4Rod1mnCqSfzcZZpKij2YppK0gStDejc0g>
X-ME-Received: <xmr:EvdgaQ3l8dAaU7lDJG4C7eKprp5vt0Byqd-KEzsHGRGePSkri10Zqk4gim5umBpSP18Oeoby7xxB04kNnKmU5sMhO-MOdrPThIxNL7LXIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EvdgaS24jqELxYRbWq-I58W_w5eHq76v301SqdJ4lsAUEvBfy2M9-g>
    <xmx:Evdgab9UGj3NG1lA9K_rMgtFKLpPtPEIHtBipRf7ekNWJs0l_6iGpA>
    <xmx:EvdgaX0w_3ggGmgjNYDcFCjtRCimQKrKmcRdVJ6fUrZ2czLA0jA75Q>
    <xmx:EvdgaQ_9RlG_wSWytjDK95k7zJktLRdRbEifuVEynAKEPRdAbQTI3A>
    <xmx:EvdgaWyS9p-IAlOE8vzEALU_lkSxLfDqZS3yyD5GeEQQeve02-m06LN5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2a31d53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:33 +0100
Subject: [PATCH 04/17] refs/files: remove useless indirection
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-4-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `files_fsck_refs()` only has a single callsite and forwards
all of its arguments as-is, so it's basically a useless indirection.
Inline the function call.

While at it, also remove the bitwise or that we have for return values.
We don't really want to or them at all, but rather just want to return
an error in case either of the functions has failed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a104c7bf6..4cbee23dad 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3954,22 +3954,20 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	return ret;
 }
 
-static int files_fsck_refs(struct ref_store *ref_store,
-			   struct fsck_options *o,
-			   struct worktree *wt)
-{
-	return files_fsck_refs_dir(ref_store, o, wt);
-}
-
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o,
 		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
+	int ret = 0;
 
-	return files_fsck_refs(ref_store, o, wt) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
+	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
+		ret = -1;
+	if (refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) < 0)
+		ret = -1;
+
+	return ret;
 }
 
 struct ref_storage_be refs_be_files = {

-- 
2.52.0.542.g9473a8513b.dirty

