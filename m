Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740020110E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905841; cv=none; b=h6j5W8iEtpiqpP4U+FOImod9iXq7x6zrT1h3N93K7irMMH8Bw2eRqYc0nnGzb7Q3TKfnsf3lfVoM7hdn8QDlvA4x5AmXODCzd5dlwju/nHbUBM2CZuOOEtmQUCBmU+SOsEREVrNmTo/3Nu4VR1JY2brgM+MaDzIDJjY8Me+PtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905841; c=relaxed/simple;
	bh=0aIHMliTptdkIsA+OSWuQ1zCzegf/1jwiJICht89o10=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG3aC85vGf4J9tpNoGBICJH4VDKybOK3/PF/kP6Nmp9Dmv5dYmXw4sz6o7KoYSjxcpZzdY3uKHRl7fj/QzLh5gNInvqcX9Sw7vnpTbqxAZoJuUutYxMYCHmKqWIXsxWjJRY0tKQVrfY9ZrQ4TjSLTfUGUjIG6S29t21YyqLr/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y9RSk1g3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLvN3Bs4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y9RSk1g3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLvN3Bs4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70E131140151
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 10:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905839; x=1730992239; bh=xc8CXmQKbn
	GgX3Rb7nU0trt5RYcA5Qz6tmQmfvrXNkM=; b=y9RSk1g3MmAY3MOkYwUi0NKqVo
	YBqMKxLY57OYREHJ264Gh7M6q69OopWhqQaqRFMRW0vEVPYC/mhqDpTZI3+T3SxH
	3fjSmVoSyrFPDHJQSsg3RowIBQmUps8gKbeLCFOEkDF5wbOb/m1eOQhSW5s/WLGw
	xoiwq8Ki49jba7bexnvCAHpoG1GkmjXN1kt35/P5VvOkvsIIBUZ4UrMO+nlnFMxm
	yd1Jl1d3GzY+mjkiow0UWvhpwO+n4ei17c/dg6CHCQOgaG6B2nvN8V5g5+CauK0s
	UCcNtxjeYzRFUCHHmgzHPcn8ttELPcCvUPKwx8qf2CgYJtTgnPDr0/dIx+aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905839; x=1730992239; bh=xc8CXmQKbnGgX3Rb7nU0trt5RYcA5Qz6tmQ
	mfvrXNkM=; b=VLvN3Bs4ccOvKNWgq/xPenlR67AfX3FXEZmHaTS+iLbDQZIP7gL
	42XhYziSVXl9/EtgTjfOPu3wxiOQaQY16Rqb3FUly8HSE6Pm5NpJxlCYCd6iVUF9
	kSp0mbPuLjTH+WZLBMKqCSNWYOCdvoiMQrZ2wsQbhV/2H9Y7P37UCs1Ce25ydG0s
	y/J4HC+FNb96u8x3L3eaBk3KPjx4vFsPH5PH4cgb2aDbNZAPyIaGu1UL24ov9UA9
	ubRKw4f0U4mcywZcvtY6jg3BExBxHSDKu+Zc5Ja5AP6JQhkDU3wYMwEloucjDSoL
	FaNgblq+SJxaJB7eKfqrDiU2vCcZ4W/1Etg==
X-ME-Sender: <xms:74YrZ_EQ6WFjn8ot1FJydIOfaWtlGebKol-zJNeTS9gKoSZAEyIzdw>
    <xme:74YrZ8XYlvlSlcbWjFG1v8Ia2Sa8ehW-5L0vBX0ZokJo7myAKW8po2d3qdagpOmAK
    yIn7uRMeVAyBFtoXA>
X-ME-Received: <xmr:74YrZxKi925PYIKsVI46Ey3qA4K8Wv9_Aj7FRmhivqOV74S-0leu53NF5LZM2thi2TYrQfzP0E3MXf0ouiTuX70pD3CN6z_dPQddpEW4H3avrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:74YrZ9GZhwRH7triwzpURNcJ4F1iPYPjnM469aSz4pffIFPt4gMM4A>
    <xmx:74YrZ1UI3gj8j5cJPCVlbf0FJF4_qxs9IGTCpSaxC-VNOIiXSYHHfA>
    <xmx:74YrZ4OGSCc2wPT9l0Rd_zjysvgE0clo6ewGAOo18qSHsPQrVG1RVA>
    <xmx:74YrZ02JHPBkr680ZLupuezsP1ueGFD7wXA5c6HfsjCyyfsDqXG3tA>
    <xmx:74YrZ0euj_MZv42_lpikojC2Nkktydx4fyBYf0mDLQN5HqJg5PaZDshO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a3413c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:14 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/26] bisect: fix multiple leaks in `bisect_next_all()`
Message-ID: <6dd1a56aa45a5b9b1302b4ecb629bdf9bd5fe331.1730901926.git.ps@pks.im>
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

There are multiple leaks in `bisect_next_all()`. For one we don't free
the `tried` commit list. Second, one of the branches uses a direct
return instead of jumping to the cleanup code.

Fix these by freeing the commit list and converting the return to a
goto.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6dbc22f84fc..04e9a63f11c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1031,7 +1031,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
 	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
-	struct commit_list *tried;
+	struct commit_list *tried = NULL;
 	int reaches = 0, all = 0, nr, steps;
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
@@ -1098,7 +1098,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			return res;
+			goto cleanup;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 
@@ -1132,6 +1132,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
+	free_commit_list(tried);
 	release_revisions(&revs);
 	strvec_clear(&rev_argv);
 	return res;
-- 
2.47.0.229.g8f8d6eee53.dirty

