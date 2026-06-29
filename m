Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B85355055
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718502; cv=none; b=nDinwytJ0yh9qlNJMUVVL+pz2V7j/uC7ah9vTXwmlRR5i9FVRqsgLDJya69Kz7W5ls56UhBFPUIoVYkW7wMMqGToP+rMyV4dVwIbN7pEZhyWzB2cr27GQg88hyqCFgUJGB4bDib/cCRnAKJbah8Mf/V2vn+EbXCIMczuhlz/Ots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718502; c=relaxed/simple;
	bh=jZyBjfuxAkMoqsN2tbF7czFdlH1xk1OBEtASdr4RHfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luQ2+UjLH6A8yshmJkQjRdqwxw34rAR5A7H2XDELQdUQKpMdj0s7hanZ2PYaOqLC7eWZddqZF+Nuqyzp52j5/8javmCH7o3qp3EJO8U+1gQeJ2891KViNTY0OnxcATHbiJUM28q98ulTOdLQ4LTpaPgITwRY9jaVAqqF9sLbZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=olAje9kD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5fmSEuu; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="olAje9kD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5fmSEuu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A0607A0097;
	Mon, 29 Jun 2026 03:34:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 03:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718492;
	 x=1782804892; bh=cYj/B8VLXGLt65ur5I9/9WUuliI3WaqmNGN7KhPwrM0=; b=
	olAje9kDdm3/DX1+KjrGFhjMT5ViUi90BLsdzwO1IjBZi8WET/sIONaAhBINNnPI
	mijMtD+rfQvZmerqTF+rV9ybLZnFSszVGbT91cXgc60MEIpYZA4MuC5QRZ+FcTKL
	Vlib+Fnrz5bxyGDYM3feYxz3gvGfgZ4LzKzS328R5jS8RrtRJbmObhVuEGBM7sGZ
	easd66rvjmgbH5ktQUSF0r0lOP1kl0bHY+Z6bB7Zs50Ux1ImXfh6Nfrj2Nzr4sT4
	eMGAlf+9go/wGgDMBDON5pJtp4T7a/upavDsOjn8PsNZ8zg2LkU4rd/Bn4rGzSD9
	ZNMrXjqz2QuWvLkS6JQpGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718492; x=
	1782804892; bh=cYj/B8VLXGLt65ur5I9/9WUuliI3WaqmNGN7KhPwrM0=; b=I
	5fmSEuuOy7ruNZvayURSlyLwQ7UXj2VGFEUhSQdO1pUAFgPKZl9Cox055RbGrFui
	xOIkcyiZ7ATdVoWNDZH3q9KAzUZAi/GFadB9DWyaY/QoG6Sl3P/cezJLqyOyN10u
	r9X0+g1tiBqWlAXqctOatBSAqzk0/wLfgvtn0FlkfUZBNpODxsinLonlc26OrA8U
	xnspoBLhVIDQrIBYaPvRiXZiQ3HitklyC2VcSw4dJBPP26vgWiCXCSb+gHds4spH
	pe+Q7szR7wDA+et0f1zISMR7Gbg15Ty1pZ/eGsAk9RBG8f4J6J+iONzDvmHpjKXf
	veuwaEO9OiSdQMaxTxZ6g==
X-ME-Sender: <xms:HCBCahxdy7wHQPZ_ZDR8JqM_w-kfR7BQYAJl0o93it3n0AQr_bmcqA>
    <xme:HCBCaqk8-xnG23Zfi_1g9ekut7fBDbp-KG1ylDclB8apynaeMSeYgDC_mV35w4BBq
    PFAXULwyO-jI-I254iy3AoV32hwjENV034ndshD6bqM0oqA_LlBg5A>
X-ME-Received: <xmr:HCBCail5uqhO0z2yrcAEVSE0T0fMDdyuYmEIBryN53rctVaGiYxqNR8thJe80EtdzBi_la0m2lKP2J6K7ivSEort6ljoDv37bGynfotmyCrm>
X-ME-Proxy-Cause: dmFkZTGtetO7yCluUx9bLRSPZ1KvQJHceBb4/MYjBuI9NLDle4R12oyYcICgAVtog/OHFx
    MVrrHVPLMcnmJysIeSo3vO12flDQCRO/hNQz1hkCCi8xRx4w7zOgQ/0nKUsrQAQcgWuATn
    35KqYS1TOzAH1R1/IyOt/CXMaM0f5qckropqcHo09PDCNXpjz5ja/yu5EZrR0v7Xg5syDy
    diYkJ5Avy+6fFSTJBEsci+jOOqwsyixqeqn5FS89okv/vVJkaV0pzeZZp3hbCYjCOGMTM1
    ESPWojBvJbEj3rFJw06SY2RwefcFiYjuOpWzo+8mqUF2PyssyTtXe+0+/u7pK1/EP46YtV
    axFcw8OB2fugxpb5/o+Ke9XkGEzupKdhtj8DRUa0L2IxeUHWX+96aPbsnn/+VzwP3Clt6B
    viiDGZqaxpOy7u5RFrEgIoImzTPvpE7O2/lk7eC9jxHlwqI3QE9XrUAorShPn0eGp8kIQc
    TFieV+T6V5JvRKg+A/9NpheDKSOdoSzgt2EiyFkXJD3UqtKI8V+YnESBh2kQwaKgZjkRMs
    nenf/Cho/ilnMDQZZgT9TYPmP7/zHYikOjtkDo2gGZaNrqAYPXwu8huZyThIhBk7GPgdKO
    QB/yev8vQHOYQSPf6K4BYOqDw8vX83fvEHjjjOyZ4NKZf0G5ziiR7tklRfLw
X-ME-Proxy: <xmx:HCBCakyLPC_FFfCIbxtyioken2zldlYLgM1Ak0BwNudE1rT2JvD0Pw>
    <xmx:HCBCavoNBuItqkg-5u91lMcKUtiV29IFwHwRuyB0vLl1nBqsRBerbQ>
    <xmx:HCBCar6TaFpd-82s3hEvRi8Ww7A1x8Ss6R-AIvB_X6YnKlc-BDg3QA>
    <xmx:HCBCaud3r1V7yekrlT1-IwKOM1ZCjXKGlw1HFvflFdZcsOm0ztgtLA>
    <xmx:HCBCaoONJZ1cJu4QGDIAfMp8jg1xce-H_eFBhlg_N9pHrNn0fYV4Rtps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b565348 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:33 +0200
Subject: [PATCH v7 07/11] reset: allow the caller to specify the current
 HEAD object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-7-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When calling `reset_working_tree()` we automatically derive the commit
that the callers wants to move from by reading the HEAD commit. Some
callers may already have resolved it, or they may want to move from a
different commit that doesn't match HEAD.

Introduce a new `oid_from` option that lets the caller specify the
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 5 ++++-
 reset.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 4bde5d8dc6..06f375f296 100644
--- a/reset.c
+++ b/reset.c
@@ -122,7 +122,10 @@ int reset_working_tree(struct repository *r,
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
index 38b2891b53..4c992ba671 100644
--- a/reset.h
+++ b/reset.h
@@ -37,6 +37,11 @@ struct reset_working_tree_options {
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
2.55.0.rc2.803.g1fd1e6609c.dirty

