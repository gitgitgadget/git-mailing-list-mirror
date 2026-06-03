Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B433E5A11
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503262; cv=none; b=WGPXNBthIQkQjig1bHLMs5Fmc/Z0PKoZ2PtJrjOW/BAsqP9pzC01Z2oMgkzhiQhFLvjBqP1Ce9idupqOVjKstT4YVfFmx2NVDCr5n46/EwpLOQAcyScBPAm1HqKEOBFAaWGJHhwjHkN5bCA2WK1YeFnxLdg9X4V5ETb5Hspg6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503262; c=relaxed/simple;
	bh=cSyTYrgv/NBfcbK+V14y5If81t2lxDYNoCQppBvSQZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/e5zKoHq0376rOLHkLwA8q3eV2Cv9OfyZ1Ad4ATMUoOFNH3H7owsTyzF+t2aXbG9OatD1kAn1nlgoJCPaNrpyhPo4MBkdyqBUXRfEV8MoNmOvj68YDruwwGa/kk/Ee9zbMv+Z7RfUQYGyLPZvA77ThqQtuLAGFyg1xTJ/a7/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mYP3Yk3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEWPkO+I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mYP3Yk3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEWPkO+I"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DA2A61D0011C;
	Wed,  3 Jun 2026 12:14:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 12:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503260;
	 x=1780589660; bh=NhCSqlbUKuRb2lY48K+VyB0V2tnoBFruefnS6uFzi5g=; b=
	mYP3Yk3AMOn9Klkk56okp5Qy0fivZ9JVvEDMA+5nKE0DXEAdoRINKcwyU4JFU60i
	i1IKhDZEKPeSBzLxMkfSxCioSBJJgsp2O8+ajxUugXubmousZfImseehX3ACd7QC
	KWYJRUGln0oy1wwR8ABidb2rXzgj1Ea4xUqZtsmCfnxUW8x5Jz+gnqHR3VCC/6cx
	sSLNBItnslKQN3OnHqyOK7jctnRg4sP1elOZ1+VlVKY+n2JeG4IKExO2EAPcFzQd
	VCmZ2kg5MZmyPZxyqx3mOw+UVTQpaFIDiqh04EZJ3+ARo2FEU9hpcKyPdEl7IFgd
	0s2LADnT/X9+w2aSav975g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503260; x=
	1780589660; bh=NhCSqlbUKuRb2lY48K+VyB0V2tnoBFruefnS6uFzi5g=; b=k
	EWPkO+IZjKgp3/KfzWx277pd9pHK5mYeMTYPWRkQdKtLMSmCqgK8VPu6xZCION9b
	T1hG4HV7og5Voj4OMTzm87B/7WgOBuMmEQgnO0BmVnEBiRFKAEygFl0SWNVwGS03
	eie3loMPUKxXuSEWiLsgxyHy5t5isQGhAbARXh9Q9lD+/dX6jHX8rpsSAgk8rdMT
	o26SwfWuw6nZU87ZKFVoNNAYy8LyzgToFZakhTx2SplYXTjGLzsB7k01oBhD2e9L
	amq+yFHTcrGCvE/SO9z7PkTbIuZK58+InmN9e8d6RbiTxEnDDU9QbE+aNdPfJUOK
	y373xjjLaRIQFRX27gW7g==
X-ME-Sender: <xms:3FIgaidBHi6TpebUMnhHn8bD9yW38JK-DezA6yCasTbJj0Z-j6u8Pg>
    <xme:3FIgajq_MGVZedj4jMvqCZrFAWMQOQhuHR8QZwvjWpzp8no2QqmLBDWZBCywkidNl
    -TR55iK2XneHg5Kah7a1DUjhQXywmv3bkg83iWiRovL8uYVT0p-lGs>
X-ME-Received: <xmr:3FIgag6Qhavs-KvkipyMIbn9AKcoOGpjWjNohwloV4sAQqKTBmLhNoT1Yp9B_GPyYXlwgN3svV-bzg6SKyIOJSkgWZv6L6P-EfZZ_UZrVj2P>
X-ME-Proxy-Cause: dmFkZTEbg51t+DzTHxMJ1sADTzvvmpuINP/sy9XkTtmufc/8cm0+oDbnwocxGMDWC0clzG
    aYnrGLxYbm9VqTRt2BxFI0FSBY0DkFjFThZa3voRjusT71ioNNkFkpmPC0igZ5jsSZDu76
    bWmLl1RrviRjr54LEorPa2Ppi5TjRvAIjPkRoS7Y4K4xX2O1UziEfbAjaWz6WfBWXmi9Ov
    k0ob3GzWVa23NO3uuRRcnXPQD+OZ8g9oqNjD01p20fNl5sKaxnQVXfXGrPtRXRXuIC0MXj
    QWc2+A6aMrE/6W1fdTWeDhaTHW3Jtv9fui8jkzky92DjfhO6+c8XEPCtipHF+nV+uFroCE
    e1/c4WMEHFxF1J2fBkkf2ZOkILICaqZ8cuNdwoqEl1FpFjTDuNijDuUHXn+C+6ZxzlsPyj
    eeboCjjift+h3qbZ6eoqLz/KuXQJr23X10O4BgOTxkeS47crnYrlbDIC3oIieC+AulOc/N
    PSOCNdJFu59TcHifu2cBNFW1rDiv36aqieOzDwJDW1M+xD4qo3SBEBhdFzSLEnb0hTXS/S
    jTjwm3zo1d3cBxKjqMLb5nlJji327HRRcvp4kQ8X/gbSorGvDItfgM2+zQDV3WmrxTh82t
    RhRaStDpP+QQHTcYlo9BB5559J04RUlmxQU6iYAODY5mqggARgcbRw0t7YLw
X-ME-Proxy: <xmx:3FIgappt_eDKKEAFtjYTI9IOVlvp-FYRHzXHCwRwUToWii9wumgxCw>
    <xmx:3FIgaiiCuXyM2r8gYyXJhBg32zPpsrbUVGX9Cw37mRCyWXrjhkAHIA>
    <xmx:3FIgajLcXX1PRMlNp4U1EmsyehFMLnYur6FC601k-zRspLwlHhx_dg>
    <xmx:3FIgaiC3tnyVYWDcr186RWjSVRfIe0UWQvWiby2rSxGh85INsS03wg>
    <xmx:3FIgavr1ldyVXtvXe462Q46_QYWzjmxKBYU32ZwW8Fq-TpgGST09nUZ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae401cab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:05 +0200
Subject: [PATCH v2 6/9] reset: allow the caller to specify the current HEAD
 object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-6-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When calling `reset_head()` we automatically derive the commit that the
callers wants to move from by reading the HEAD commit. Some callers may
already have resolved it, or they may want to move from a different
commit that doesn't match HEAD.

Introduce a new `oid_from` option that lets the caller specify the
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 5 ++++-
 reset.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index ed9df6ca5c..7ff72de5d2 100644
--- a/reset.c
+++ b/reset.c
@@ -121,7 +121,10 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	if (!repo_get_oid(r, "HEAD", &head_oid)) {
+	if (opts->oid_from) {
+		oidcpy(&head_oid, opts->oid_from);
+		head = &head_oid;
+	} else if (!repo_get_oid(r, "HEAD", &head_oid)) {
 		head = &head_oid;
 	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
diff --git a/reset.h b/reset.h
index cb0700ffa7..51ce114543 100644
--- a/reset.h
+++ b/reset.h
@@ -37,6 +37,11 @@ struct reset_head_opts {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * The commit to checkout/reset from when doing a two-way merge. This
+	 * is used as one of the sides to merge.
+	 */
+	const struct object_id *oid_from;
 	/*
 	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
 	 */

-- 
2.54.0.1064.gd145956f57.dirty

