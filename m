Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F95346E5A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208592; cv=none; b=mNXZlcFo5AMAs5wtRibmLlMuheR6CoUcarNz4f5cEXVLqatnHJdhNn/LVNo8wbLWWCzmuoiQTxheF5Q3+a6C6OqvkJROcC4X6YjZBZsjjt+VIpuMrypuPcrME1cDRMDQ/b5SZ5VRcSD1zBkH6mDkUJd7OupP4DEPKXtMdtIk9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208592; c=relaxed/simple;
	bh=dmGtsSQnoTmvtMJLTRqA5w2xzyfuvX6eqJtO1m/JkD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcdcRnU21Ny+D/B4TRFo9Ff0Msp5CEceNN8MM5RqZBeFCTNYu6QKLq0jGtuayTIs9oZWNJXOhpBNMmnyqYYqHfh/GRRRxMywUVac+Yp0axrfsqA0azeX+sDe8fmZT+Fx/ffWCcGH1HJNvJd7pmSRcevuUP+uA+WlSEt7aKdTyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dz5O43Ho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4dWMaMt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dz5O43Ho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4dWMaMt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E55AC1D00072;
	Mon, 12 Jan 2026 04:03:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 04:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208580;
	 x=1768294980; bh=8b4LeMv6QlcU0kIkBai9LQuHUtY+Ht1R+AjyoJNYZ2I=; b=
	Dz5O43HoB02/6uhEotaOx2r67ZQHyAN8F5B9F084J1BdU9OVmGTegth62DFXq01E
	DYK9CIwyPcOul1/SQxlOLpYkEuuc7GbLXbvL7zmj5sSaQVAY9HyMsHhPQ6qU6B8m
	8wbQtMmD7abmv7LHmkmOhnZ3pBZONO8ZliPxMF30wF8cwDx/aPsqPLxTWcRWZ7QX
	gUw2GRZZ+im9p7ddbpxPeBzb37jlkesU6zMwwHc5ZWae7xwd739jEnQ5FWUQuMsj
	LFa9faNdgumJxxjr9gEyo0KyTfDWyquhcMrgMCHlUMhsCI5JKA9x/mkC7ZRULyDk
	q5dN/Nhv3pJphkHZh91lyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208580; x=
	1768294980; bh=8b4LeMv6QlcU0kIkBai9LQuHUtY+Ht1R+AjyoJNYZ2I=; b=L
	4dWMaMtVusabya7Z6TtZbCTO2PYD0suuJRYNtLJPG9Q61UlRreJOksP7W1JRG+c8
	8C3l2bX8F/yYzJ4mkx6319BbiefEIDR4NiG+KQ4DkUBeaPlb2rnFPVw/v4dlkAP+
	6hU7BYMwX+jjcVev1MguktdFlmSNXMcCAC5iKVNrzwY/q8r0tmvj5TeXLfg/X7ip
	yD8tf1EIwxBrsuVHeVecl0kLdXoiQPs/UbtOLelff7dDnddNqWpdU2XGfjpJLkRi
	BE0RVsbBgIN/pvt1sW5Lpp8vgktu675HqpeWXPQEsjHrJ4j9PzzzlApMRwn1X3zN
	8Y2FsHcE3eJPaJkOjbVMg==
X-ME-Sender: <xms:xLhkaRl4FGz6ssuX4VTbVw32uZvjW-TQC7UR6lJfizbSsjDVsEaMRQ>
    <xme:xLhkaUSQe3-6X_EceEiXh9CbsXvjMsr2LCpJYa77VGNUEjS6kM7N7ZD6Uk4SKnYfH
    YBaZ8bcQxZhDvFNU8cs_coQ4EqMUI5yd0IKWrOiEf5LP0cpgETHKQ>
X-ME-Received: <xmr:xLhkaVCNZ3YBiV9hDu-i_sZ9F-snFeBcIJenD7VRBavC-3P_bkUTgIaDbDS1bY-9fVvem7eMOf_Rv4C6lAVrzkg0QcOZx3Nq6GYXH536GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:xLhkabSOlwFv0Nk7NHjOwgV1NCu88lqKoI-kytyq21UNdbF543Ajxw>
    <xmx:xLhkaTr2DujRrE8iwk7KbBJi5CNBIOgSeaf4EH7qi_I8ScbroF_CpA>
    <xmx:xLhkadxzoJMBFYTWrI2Xu77FCd_I_NvgqGSBOYV2D2EmdftyICgATA>
    <xmx:xLhkaYIGDAjRCTN8PMZIDfdSJC5s0xRqVhBJLWSJ7SLLAfLav3WB-Q>
    <xmx:xLhkacvM-_vNlwM6998jK_6NMVX8RhLMnbRno0U_54I8Kdw1KCXiFMLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0aa67cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:02:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:51 +0100
Subject: [PATCH v2 02/17] refs/files: move fsck functions into global scope
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-2-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When performing consistency checks we pass the functions that perform
the verification down the calling stack. This is somewhat unnecessary
though, as the set of functions doesn't ever change.

Simplify the code by moving the array into global scope and remove the
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 297739f203..feba3ee58b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3890,11 +3890,16 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
+static const files_fsck_refs_fn fsck_refs_fn[]= {
+	files_fsck_refs_name,
+	files_fsck_refs_content,
+	NULL,
+};
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
-			       struct worktree *wt,
-			       files_fsck_refs_fn *fsck_refs_fn)
+			       struct worktree *wt)
 {
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -3955,13 +3960,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o,
 			   struct worktree *wt)
 {
-	files_fsck_refs_fn fsck_refs_fn[]= {
-		files_fsck_refs_name,
-		files_fsck_refs_content,
-		NULL,
-	};
-
-	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
+	return files_fsck_refs_dir(ref_store, o, "refs", wt);
 }
 
 static int files_fsck(struct ref_store *ref_store,

-- 
2.52.0.590.g1f87b77810.dirty

