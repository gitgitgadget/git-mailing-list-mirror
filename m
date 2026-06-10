Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CE213E9C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081573; cv=none; b=co5veYsQnMqa5HuSDtiuIAbdL4eaH6Utrwkao0TwP+1QIbivwJ/ilh0QFEuDoBst6qMigRHj53g0RKYSLOvYd07qQJkM0+qLAlQ/C2v/SQM0paXGnWaFsyQGQrtop5DhCeNLAicMHZDGBsSjBuEpX1AuHHQMDFh+KUSzgoZGKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081573; c=relaxed/simple;
	bh=FQeEVdqEV7+dxHKzw3chyIuDViRr5k2LuXKPnOkAOZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaTSb5h5BjlejLAfMfeVbBB6dJVxEy8oQ7dh5M/oS9P3egqMi/qOa0CxqFE4nch1u9WpQpef74voEPqS1pX9rigzgaD3C5dp6ajDZEIbvA4PQhd5sD3GX1Tcaty2MNSlJ8scMo24Q0X+sRAdowFSoc5pLASSXcVdG/Im0kYB9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M3oPu6nS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULKCzoP8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M3oPu6nS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULKCzoP8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 661871D000A9;
	Wed, 10 Jun 2026 04:52:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 04:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081571;
	 x=1781167971; bh=5k7bul5I0lm7mbMGBQfcvBMsPXh9KxZmgkrwyCt/XzI=; b=
	M3oPu6nS009ol7M757XGnQ5SgglbPw0Qbjk386RJ5KGp28XU6cdFreSdznka1vYT
	2Ww1UAKO00KAYvpvkGZEPKxdsfuL3HNpHs7n1kcdHdXQo5NdCkDWiTYqHR/A7S1/
	De64J6CZETzghwTQO2HHitewkpXamLaBc7Sn9THaYzIaNWm//X5WRPlf3n/x8sqL
	6ttc1VallgWAe6TZvJ+eP6HDz9JAVPMFJKDqGeWIMMaFTOxhK/DBvcEQdxeEW//m
	zYFZAX+DQWYQQpztmFOziE7ciKmr5UQGD6W+f8nNPh3k3aKReWcVSgwcoexL20Yr
	662qLE7QFfsxWCqQU8pBtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081571; x=
	1781167971; bh=5k7bul5I0lm7mbMGBQfcvBMsPXh9KxZmgkrwyCt/XzI=; b=U
	LKCzoP8euG+zWd7+sNzLu1hcs5lj9pYEHPCwjkK/d2tl1jGVZKDCf/gypel4r1qu
	+jWTxF62mVanv1ZXsLWX3s02ATLlyS/k+zbNBQntzabrpekBegWcX6seG6qweKbu
	jfhbE3bL9G2quTurD6LGk7M368v4oV73h504RnD8ytQx3LioXOjFGFRmQGEl3O6c
	ftpEG3q+NSlKcG8cO/O1Xqkb51K7ulbp2uMKfgnhZYF8royTsSf8LD5IwAqUHULG
	sIg7BZA32CwjN+T1Q+KZLdqGvsciLfbUkUBu5GrenJ5ef/AATQX0UiOuciY2Jb7g
	YDfPR3PyyqEqDhe56xO7w==
X-ME-Sender: <xms:4yUpatoSHK19Ujs47EE66UxUbjljjXXSiF5Qxm2JleLx1HhusNP6Rw>
    <xme:4yUpahINfeAMVL53Nn6vZLVlloMVGlZnzo2pFlN0_K1X_6-CsOMftAFsFrQhkQwXm
    2hUYKENp1kmS9yTnuO67mD24gk5DXLsqt-KY-Zhakf0y3OqbLX1gw>
X-ME-Received: <xmr:4yUpaqR5qswn0Urfm8jjhB7mXVTkmjp5pnMORqU_F_14KdrEeEm0_V3Es3HCm5fMBjAom0c-zjlQ0EOKMvQYdVC0OWA14-9BmAaJlAgGPQ>
X-ME-Proxy-Cause: dmFkZTEbt6F91Ex69dN3TtoPOHyfxZzzET4WHVjmzobpkTCy4D4Y8n/gJ8uoe/NE3SfZg8
    dKU3MHyOseBQxnJ81+hg/E3SAaK5meisYhhjeOZ/ogk1dlzE7JmJranp4biMCY9XhlPdiI
    zjU5PF9UohKfxf2l/IOpL2C0jbbRECl33A5kzGCnVIeUwJsJqgEEpmbrqXnahV1K9Y7MV3
    qce+ikt46HXmSWf8mWS7nvyE7JTAaS2oWx+a88DRrrpLXKsj7em4AeaigaHF6mLT3l8HGr
    50PS4wfjduIeMj8RrPm9Z2SV78OgBgEJm2uL3YDZbvYMKvYi4jk9/HxwyVYDET5sBa9DHN
    +LT8FHeaJN2/p8hsZyQ9cD67MY1I/8hkXvpsQnli6+nGpFxlSykotFyNtVeYL+V6eMLkO0
    +cxvdsqjBfreceCR6JoSqWOmBhH/cRKu0xraTJvdK+uL4lkw86yxAAc5m/o3+j26r2kjFC
    /gQ4jlniO233JLLa8PYka5ctu4RWQGGRDMa5PX+fruEpdIgqVUgXlNJEJe7ET/56tJ5KU3
    MW/DDpklFmE0ozMeOITpf5RTrshIezFg+9oaLlXXjrW2mq4r7aXQq+vQCREcUepvClP78s
    GyHNpt50U+h9Q0oMcpPEWz/k8ePbcCjjRV90Qey7o+sYDm9lxiEYd8SaZquQ
X-ME-Proxy: <xmx:4yUpaot8C62_jgyfjAIiT_RrRnSBcRWgkbIWq-VUmxaoAprHCrgvIA>
    <xmx:4yUpajYxJrB7h8PZUicLr-h26Mta0hw275f8POc1AZ7IthRSC7LZNg>
    <xmx:4yUpamG5snlaicH946mh8IhALgyBuIjqwC_cLqVpNYdCZiqyvQ3p-Q>
    <xmx:4yUpavxu1a953y6C-JznY-U538iAXgl2tIlHA8knqeZoEeV-HrpAKw>
    <xmx:4yUpat_hDbTp9xTsZchfZbPo7CFhzHsjdeC8eOPbyyZoPr6Kh6ApCr0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de69713a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:27 +0200
Subject: [PATCH v4 07/10] reset: allow the caller to specify the current
 HEAD object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-7-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
index 3ac99a51c0..abe36ba116 100644
--- a/reset.c
+++ b/reset.c
@@ -119,7 +119,10 @@ int reset_working_tree(struct repository *r,
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
2.54.0.1189.g8c84645362.dirty

