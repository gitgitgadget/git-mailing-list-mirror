Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C0411677
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184454; cv=none; b=Mo6LXnUlkJCs1seG9ZuHqL1cI09JrB3Hx7TAOOPE70KHcIiKGKq3ZLimQj2QOBMCcvr7XIBMaKD/KOINhm60QQtwiB1djQF+5X7QZKDyeusQKBXVLtnS23SL+4J+CAmHaxRH3l1nwqVB8segwNC38GSBGtQsgY5vZZSuG32RPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184454; c=relaxed/simple;
	bh=uLXoz0x8Iv/qJ+ElQTLKbu3ACouzDz2MU1llIOV4O5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS1m/bny5p7MOJtYhwzdkjT8V4leklPVioc8P769+nBHQD6n5ha6ymkqRZ7+BxPVAUvQbv8/Xkfgh09f+KoaFcay6yi3cxVtdrwHqcPlXrdfc+93za+nw9wkBDIXPnsM9HSeOMTEr+upl/XllgLNfPVmISj1kXhBzuYtlPaqvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h/gw8zzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAqsH6/A; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h/gw8zzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAqsH6/A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6745A14000FC;
	Thu, 11 Jun 2026 09:27:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 09:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184452;
	 x=1781270852; bh=l2oS4W7clZCUsNHMcslHPm93eFUuhBu1zDAWTnlTfGM=; b=
	h/gw8zziXGzsqIVzHFsLXv+gZa0HBaYJkqyE7rn5KrI8ZdvNZMAZYc1bZ2Y6Z/oN
	wNmH4UL65pSPMBBFTL82shaylJXJRf3hIirKCvEMklFVefapvV+qZXzpMnkdgHFL
	iwGfix2PA+LXLmgO6H4kfca2oteU/HjeCCm80ysJtpyl/1q/4Gzpa+5JA/aPczAT
	/b40coG8ANE0wo0LYlgtpToP17PxF6dznXcpH1TfDJl8ytrpkGnUXIm7nVS0oo5X
	tOjdjKnVFlvItO/mYN2l0LT5EXQkHYFF/0LTDV0e7OHpOOVN0LV0qugfjJQJPKz2
	SnwUnzqsusH7ZMyb3C++dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184452; x=
	1781270852; bh=l2oS4W7clZCUsNHMcslHPm93eFUuhBu1zDAWTnlTfGM=; b=S
	AqsH6/A270Www81+FmjgB6gVeEfQksu3pcvb/CuzHj7wVgk+QiifujwJwMvWVE8L
	vMSE9CYg+Cfztv+63CdxkEpZhKOsGoeDhVcGfdltAKIR+WpUiIoG+cgjW+W6rYx7
	rjI59mzriDM6AldrokdXB+CcvR6cs/7zas9b7kPK3qMLoU13lmxWwGSvMUu26TMb
	jy6irY4EIx7gVHbTfH+O5RCfZb5iLji4Z8z+Cox0TyCkE0HAjOAN+pm+nxeRBJyr
	PklzucuQdKNy+YVViy/TGCl3XUuiXcWLrWPsO1AzhM3z4Dtc/V8r0I4quZ13xenv
	wp/L0XdvwDy8IFZOu4MbQ==
X-ME-Sender: <xms:xLcqanH3EOUwoJgnJHfp63jU-iNOfRrIhIqftZozb2ySd3QzYWaxEw>
    <xme:xLcqal0LVmZET6Ly6RWdTxYmCeLO1YTp1vUgwbuO3I-MAVPLxnmXK9P7TX6otr7ar
    VCOjqySJLMCIF2DS6nmsHkXbQgvlneaxV5X7RxMRv2Dad_Z4qFq>
X-ME-Received: <xmr:xLcqapMhqjWGYT3GzO1rxS7klJqx6_mcym_VjRDEe-Vl_DjOIrGJ9zr7EiFa9krZ8cUQnW8DvmcygN9t9a7l1JRFNnoQnSKyyDcvgPANzKlO>
X-ME-Proxy-Cause: dmFkZTGGNOZQy2QTFN7IZUfAYMTq5Ljsjny/aPIOx7WJqe7Z1LumpFueIzeDdJnNJ5DVRz
    36KQCGTaoNUuTNfOfSxzVLKyz3syu0LyEd+VcrSaIbKR2Wk7mIy39Hol2k7OuX4+m1/Xrl
    QAVFceJO/5DINnoaU26AA0MPf95ZHQ9cWzgSwjXix9sAfTqoT0utcmEmlXQ8CpRHfMI13E
    5B4Mb7HeFzViwhZIFrHVRQdl5UW+0EMgSFWe6vn/6xx9YWCTd6FX/8MUSb+Wys5/iT0aWB
    cGMngkH9QtISmu5huLQYQ4jCqugx2AyXKFtoDlr8DLcs7+95+gqLjyrCGApmWLjjQ4h7h0
    j6g33VpVOd4jKEVr0LFCPaQefTR0vhyHL4LdshaQZRa46sOQCLtPn8MJYa1C3lTYLAsuJy
    oZ7FLIUw86m9UmdtnCciaogeL76FG5A0/ilw50akof21EqFUdN2BOvuGqa+nTg0il5mcBk
    VvdJoSgipEtHmliiBb8M7BySOfZSG4vGVaqtCEwYTLXw5Lw40+G0hoerOXkp8kQLg+vUE0
    T2E6dLKaNajUFLE0Jdi0XTR28IrivzcY04COk5EGh7vmL9DltYnERR2Ch2z9NV2k7X7FKt
    kYWG1+MXIV27MM4W/Cu0Y3HZLVjtNEtL21T5FHJfFS/VET4GtT0/pnjnfvjg
X-ME-Proxy: <xmx:xLcqak63GiUgTfKEyRHSEpwXiqtonrmbHiUtoPZ8V3S6IfSjrFff5A>
    <xmx:xLcqaj1oMcMYVY0ZYvoPqSr6Ad6P3JJMgXjok_Cxuoh-4CN9hxqrWg>
    <xmx:xLcqalxxXXVI0nml4IMyEBlNf_rz8N_S77J5UbJGBv20gQ2TYxMHSA>
    <xmx:xLcqattGNX4an_IofAU8Ir-mhl-Z27LHIbkzGcO9Njky-O3Lt-kYhg>
    <xmx:xLcqalJGddNnW7G49RA8O-q0JOZKgAT4FQ9RSrgl3zRZ1mxW4zBVxgtu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97bfe3ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:10 +0200
Subject: [PATCH v5 07/10] reset: allow the caller to specify the current
 HEAD object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-7-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
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
index a744b0f0fc..955ea4ed5a 100644
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
2.54.0.1189.g8c84645362.dirty

