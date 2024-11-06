Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4D20110E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905846; cv=none; b=sCGdCnBy9JIHlexg43e0qFtDDEfCz95pf312IoMqIbOsfWv6zxdJnNxleYfJYWZXtoF4nzGP33OH8m8GC1VX5MPIsvEw+BCVjFsOJzj6ywA92pATnquCKrmZNwxRCD2K68ekOcMV8Ty6a0a86GDP2UeV6VfTS2FVJkqeD+bD4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905846; c=relaxed/simple;
	bh=63KZEWUfhak87goU2RvcXFx3/yk3F1T1npVDm7cCe2A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcOeRAWxstbCI6D96KHxmaC6Pap0kWgPnv+97OldcksYBBCoVLa85sWySiXuSYkQ11UrL3YTUf9dVfpw5vQzO3Qfd5txfDmx2y+K9RI5N/Pqr0T68xI67PnFET2FLFQduiKo9r9n3QcEvjHVkm6hzYRn9gUQFikVFT+jjtZxOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XLhc/mwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZpQOxi/n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XLhc/mwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpQOxi/n"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50F891140178
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 10:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905844; x=1730992244; bh=xWWwbZbEyQ
	zdXhxEIlGbJSUsn5Zp1BZxyLYBbEXSBoI=; b=XLhc/mwbbpHhbPYPD0niXSiohg
	2rVaVAVEZpXbwwmxtOwVJHix6IWSsgtpfnkYX/zkIjPyywl4Xgvn48WcQhXvjnEt
	1TPK++RJcldhFgWuB7rqmGgTRlYdHzCdXosd/6A+IJ9Q7xDbZwKlwwKrB6nx1U8B
	Yt7oomBVXqFEP6M+k68gF6F2nIzP/hhAlpuYStwj1pzkbg8IC3+sN8FHRVKmc/rX
	QFV1v/aVxqqCPbQgK6W2ROXmWHp0Wu4ecPfOgtGnIlmu/HlAZFvpyPXdNwHL+4kf
	4uhhGm0N49MITRXmXL4vxh94psldv3tYmNikrLuVeKNPHpsYsYfimCAOe/fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905844; x=1730992244; bh=xWWwbZbEyQzdXhxEIlGbJSUsn5Zp1BZxyLY
	BbEXSBoI=; b=ZpQOxi/nbYYGe9lXdDt8yn21Ny99rGK2sNpajhlC7iZCgQp9M4m
	5n33Du1BWI8+2YB6mRy4VqyMxJ6HJ4eRQCeg3DVA7LpsI1ydLq1BM8qUQML9n/Z6
	vNxVz5h54jeMaMzpFnRBej/OT5mTrzux7IhBAFARDOVW0vLWFtP3UZdIUHyXhovO
	4GwNWFIQAAtm9kvmSLXPY0H+Zf+xaR5WVQII8bhZphrqEPqCYO+GgOJRnluqEvhe
	qVvdzAz+xqHQ7l09Pho0wH2i3m7L4KwxGe+MFtIB4Dcu7+Q2UxKFaylrs408qo1x
	jEHsIXFpFBThEDXMczlhKML8npUqtBqMrKA==
X-ME-Sender: <xms:9IYrZ6eha6ROjdm80JpGXGaxUM5X7ypKwWa3dWHhJwEFxti5RuTndQ>
    <xme:9IYrZ0P6-dSYXznTcqdpv_i-XGR5iKFlC_cyKqBdJRq4f-Pa1Nw8tPb9ymWdJnq-v
    _BsImpTjYLwIakvQg>
X-ME-Received: <xmr:9IYrZ7gYbAzrHa258FdigJKlB02Fn1ObTJItvQhxn0qcjQNEOSsFFuvRIuFTMiRDbc_Pt7jC1BDDpbNlTtTtidZc2nJBTUqoDbm3J8ISvzQ9-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9IYrZ39CvwYnNQoK9kjwc98IeBCLwCUAs7V5KYpGgpP3OctyCerkvA>
    <xmx:9IYrZ2suhWAlyLK8Tl0qajCg8Ek1-r7I9mvaoOj4CPwWiB-w000IgA>
    <xmx:9IYrZ-GB89Vtk0iyQfi76zav3qpuC9wX95Oq5MqYMlVciANnjCJpMw>
    <xmx:9IYrZ1MEaCtXYTDdue2qwOdq98Fgyk-A-uyJlWqBbOjJZLTpB3uC-Q>
    <xmx:9IYrZ7V-pkGGsYcIAcQNLYzos3ggQuUckXcerQ_jzJb_DzBXZ2LbU3KW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d85d83c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:19 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/26] bisect: fix leaking commit list items in
 `check_merge_base()`
Message-ID: <fba5b4b9f60c4d22aacb2c66ac96fefe6fd8f5fd.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

While we free the result commit list at the end of `check_merge_base()`,
we forget to free any items that we have already iterated over. Fix this
by using a separate variable to iterate through them.

This leak is exposed by t6030, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 04e9a63f11c..12efcff2e3c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -851,8 +851,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 				      rev + 1, &result) < 0)
 		exit(128);
 
-	for (; result; result = result->next) {
-		const struct object_id *mb = &result->item->object.oid;
+	for (struct commit_list *l = result; l; l = l->next) {
+		const struct object_id *mb = &l->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
 			res = handle_bad_merge_base();
 			break;
-- 
2.47.0.229.g8f8d6eee53.dirty

