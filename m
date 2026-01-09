Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589835B159
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962380; cv=none; b=WQ134I38WELG13TqtKYG3qo1Zsns1ho+Fj/9/KMPauPofrj2aqUyyl8quJ38jUcdVEYwyho6yuLaT1kZgCCB/dOqNST/r1s050Kd+YdshxRLDlXL6d7xR1j/cQUBOd1L2PL+KASCqweF11WKerxsuAr5xZVVxy32vbSbonsHTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962380; c=relaxed/simple;
	bh=nKl34m2fzl/rKr5cuT5nx4n3TuCM4DZwK2H5ydj93FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHdofmN8LieBi/s4VjdJJvekhSDWrSvCl9jHTWjKUmlVBdZyFGFunnP0DXUz1erPaXXdQCZgZ1wMTf1bw9RHlPQqdHYGgX72Oy1jPws7SSojRoG1S6aMKJTULR70ZmYZixCK8qypUGVn8EcbwlJ1I3zVcYzNjXJmEeaF1+GeodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9hqYsE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khalRXnF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9hqYsE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khalRXnF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08DE97A0170;
	Fri,  9 Jan 2026 07:39:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 07:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962377;
	 x=1768048777; bh=voMtkdsb7gmzvriX4tTjOmA+o/MDgGnQj+BaxkF6xZA=; b=
	R9hqYsE3rbaDCC46f4leaSsT88pK+Cpq+81Zmsr8emdv908Lo18mLVkgOx/lkUEB
	Bb0fRnucCFl7JiUa/3F1MckVOxOv/8qgsVrejOgklB8WS2N1ZS/4mRaW8y6mLSA3
	GQS2n2xHu79a0XLE9X5bLXkfwGal4oRcRrPizy+SomSIihV6HDg2szFJBg8jJE3P
	nCZezv/Kwn7cLpGKsUuS/l+sEAP+QHKr5vxftM5XR9VF9Y8im4QZXeIhamLVdacf
	1dCHLhEJAxUtb0IZRXu0v08WUSsdX6B1933zAkDBXd9tbHc+4TuC0wtvPmB3rk3c
	LaocLcxNZJxhOdv3wAAZ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962377; x=
	1768048777; bh=voMtkdsb7gmzvriX4tTjOmA+o/MDgGnQj+BaxkF6xZA=; b=k
	halRXnFlQ/qKDs2CNAMl4F3IZRwHGI2U5toIiOkuPgR730OS/cvzP/DtN4bg5LS8
	x+NZKgV6fOM+j33QqOHMhWwAS1UPepOd3MZff2uPMvAtO6zTI8dA2Hxkb4X2MFyH
	23wrdnAKuZufV1fZHO4mUQ5Ntedexb/512Myogh2ry7mHAI2i3dyCgNpRitHWjlX
	o7eOcTFtG35clunW38InXusS0IGGxLw9HT4JtTRymlr+X6+PbSZeC3gxngA61e3K
	obQ+LvuT3DxNFW3OAc0z6ABrV/9+RNiELQfoNyQvoXIF43hqbDR315TGiTdAO/AX
	RudjoAxPirRGGBJSKwDHQ==
X-ME-Sender: <xms:CfdgaboNa1w_a-WWvaacx-IXl6NzvD0oqMLa4UMCaDQzt-RbwEZYlw>
    <xme:CfdgadHrMy2hgjIBmBnfeTfLdZsVnkMCcAmlY2Bf34lq4Ji8rgHNxfH32uHf14i3y
    YlADXYVAIl5yiceyjvUImSu2fmD_779bFhuTn7hxa_r6rUDiDLwgQ>
X-ME-Received: <xmr:CfdgaVk2I7zFO5ApuG4Aol9YZv_kWHK_GfZjBw9Zfe5sJnaNfOwEkG4dx3hgeY_czpJxbRlIbVBLd_MBJdBNBafXwd-aIQ9PxidzLFYJkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CfdgaYmdqO5W0JhsYDL6SaaS-JZwQ08S1vxR1zXdDjBt5pnbopzVRw>
    <xmx:CfdgaeukAY6Lk9keo3yx8M27In9ZXql_QPbs5G7RTlxVdg_MesG5nw>
    <xmx:CfdgaTnbE85Q3SbP5QyR9W0Z6cAezpf_tawbjJT0b46pXoN6yuM78g>
    <xmx:CfdgaRuXyIkMpyke2cjxk6_vQnAeftuNz0AyOgANK6cHojhsbI-P_Q>
    <xmx:CfdgaShZmkczrXZmoFWWC3ghVyp8PdrFxOH-AhTP2ee3ZTLxxdTgf9sr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a8fce23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:30 +0100
Subject: [PATCH 01/17] refs/files: simplify iterating through root refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-1-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When iterating through root refs we first need to determine the
directory in which the refs live. This is done by retrieving the root of
the loose refs via `refs->loose->root->name`, and putting it through
`files_ref_path()` to derive the final path.

This is somewhat redundant though: the root name of the loose files
cache is always going to be the empty string. As such, we always end up
passing that empty string to `files_ref_path()` as the ref hierarchy we
want to start. And this actually makes sense: `files_ref_path()` already
computes the location of the root directory, so of course we need to
pass the empty string for the ref hierarchy itself. So going via the
loose ref cache to figure out that the root of a ref hierarchy is empty
is only causing confusion.

But next to the added confusion, it can also lead to a segfault. The
loose ref cache is populated lazily, so it may not always be set. It
seems to be sheer luck that this is a condition we do not currently hit.
The right thing to do would be to call `get_loose_ref_cache()`, which
knows to populate the cache if required.

Simplify the code and fix the potential segfault by simply removing the
indirection via the loose ref cache completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..297739f203 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -354,13 +354,11 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			     void *cb_data)
 {
 	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
-	const char *dirname = refs->loose->root->name;
 	struct dirent *de;
-	size_t dirnamelen;
 	int ret;
 	DIR *d;
 
-	files_ref_path(refs, &path, dirname);
+	files_ref_path(refs, &path, "");
 
 	d = opendir(path.buf);
 	if (!d) {
@@ -368,9 +366,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
 		return -1;
 	}
 
-	strbuf_addstr(&refname, dirname);
-	dirnamelen = refname.len;
-
 	while ((de = readdir(d)) != NULL) {
 		unsigned char dtype;
 
@@ -378,6 +373,8 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			continue;
 		if (ends_with(de->d_name, ".lock"))
 			continue;
+
+		strbuf_reset(&refname);
 		strbuf_addstr(&refname, de->d_name);
 
 		dtype = get_dtype(de, &path, 1);
@@ -386,8 +383,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
 			if (ret)
 				goto done;
 		}
-
-		strbuf_setlen(&refname, dirnamelen);
 	}
 
 	ret = 0;

-- 
2.52.0.542.g9473a8513b.dirty

