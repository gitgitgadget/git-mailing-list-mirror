Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F287175A9F
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890451; cv=none; b=tivhrLQH4zIOzc29Hv1RvxKbPSWqIF4loBVeA17s8XW0QMQYdRf/qkax0FM0GryQ3PxQo7n+kYOhpY1BpgOUBnUfjJp6f91m6RrWGAmfhIKpZ/DeNQI9/JlWvG1whvVt9qAoOfMXL5vX+9VcpEi2om8yKs+lJn9PP+kTdav68CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890451; c=relaxed/simple;
	bh=GFiM/SyLDuX+zUALz9bTf6e6QF1V78wPUJzAX8iNS4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7+At93Adt6e0oSgOJtm6JmDF6764fG8EXYXxdPfy90vi/0qtkiqGpfZZvdU8Tin+d8+e5MFVqzkIn9u5kl64qavGQdiCHM7HD7jDUJzUO8FcSrD/lt9y5CyPOkh1r/l9ylRyAm68gkeLDZjoPa1kukEYc9zzL5ahgTT+N9iJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=A+AoXVXG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBleR1lh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="A+AoXVXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBleR1lh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7872140015F;
	Wed, 27 May 2026 10:00:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 27 May 2026 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779890449; x=
	1779976849; bh=0/DcUbDxXsUIGCzcQOVfUeWfFBUlT5cisBrln0bNj84=; b=A
	+AoXVXG5LUno9ffeRwuGFTmSho9g22beWBHlcHp3wsWUSk7GIlEflkjkwuOfxc0A
	LF2ntp1InIAoH6TxeO7wf1rKX6RMXMqJ0NZxmlmOROkHFAMdYDRoUAefNwhdMHZ8
	Ua1zUk/ehmLRxmWCammmNnOizRqxjWsm1WjBryniat7AnccEAIDlsLczRGtgRx3b
	07LYfNWKVzmbDTSawqSOXcThfJ2JsaHyojMHB9MRRim6eMHfAuKz26m2aAJHFuiR
	XY5XyXUEmrWt5td9z5L6FfMqRb61Tva5tHuZg/8POtRnD7BLFpbNxVP886/7/E4D
	bDW9DCHPtWPJHlYB2N7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779890449; x=1779976849; bh=0
	/DcUbDxXsUIGCzcQOVfUeWfFBUlT5cisBrln0bNj84=; b=bBleR1lhmUx0k001F
	lIJJGVLjR6erm29Us+7nCfZsSpZAmJyIQD1JfiuCGabhgP5aVpgot76iwufFWikH
	QYpT2jV+FzXFbCd77UJGUt3IE2S3I9CxMqEmbs2cp2+3lQZjcc9xQRh+yJzvGbDa
	uCXvAIxdMcb8u7X7N52ITfqr97Jz4NQgS8RI/GUG4+vCFrIqRbQ7fPKL9EGV1ogg
	dwXlaQFtMrVeX/oue2mtpQPuU18H6EtJ6kwMXqPfjp33X7358eSLEe3kGBPtHcCD
	NKFJcj0Powv9uTDqA/wRqgQ8xggEKEMgkl9wEWDaYkkP3Zur/VDvnQZghiWgpMEc
	98gyA==
X-ME-Sender: <xms:EfkWaoAUfYNp6UfCzb90E5cI1dUQ57xSc3supa5isOX8n4YniWEhE6c>
    <xme:EfkWah-yfvSF-8bbZk_Bc6MMVRPRDxOV-CrFkOJcMwW1GWUn-_OukGPi0eRMWIG_n
    vXexDM8-d6IWT_wjC4VIPw3njijWL1K2j2hVCx5eEXj72A-0_PToQ>
X-ME-Received: <xmr:EfkWao-5Czk8uN9vycbbA1Ksji2Ds8NMxdBA0siEctr4Chwx-UX16XjB_C5EPafahvRRgQO-KgxdWX_poJ4hrLm6rhxB_T7dm3e5iow>
X-ME-Proxy-Cause: dmFkZTGfAx7OkGpgk1BXIH0VLuC26ATohY1xoGoDXIclj1Qh6HEKGOhzgU/IedhLW2QT8Q
    jlxdzMjNThRq2zjPo4VasJeuX9Q1B3yIOzIZZ7DCRhQM5Agr8dnm6tYnUqYmPCQWEGt+rA
    jBx5SchTL9zZX9Hdojbwi/xYNcIFGubrKf56cS5sTXwQBJG3P3+7EPifnj+zBN7jnx1QXO
    coJbNxUwvC3LLoetAT8QHFNM53bdN/paH+9hz05585dRIMKtDfUJOrzR7xUtlYztomowbd
    RIfjAOLoVjkkU5R3gsrlor+XRCwVhMOmP+01X1iE0MATEYQCihI4ZypDc3nzNESiICLCTb
    0r/KoALdx+Lp3u8aXAoFiwZeUuU8xQOuNDhK5asTk1RrhNs/01O//dAiA5iEIAMThrlBws
    hYa0G9PfwLJy4Ek/sTLd5FhQxM9bWtMOrdkJGezpIb8hwO353DQG3yo1udSCFun7khUIcE
    IUjUudLmHEPoN0JYBMGkIi6xwCW85lQtTCs5jLEezC5NHfNEp2J1AXUl+/6Y8JPs/tX8Ph
    QASBdxX6LYkDdE8uqIEm5mh5pk/Powh4ZQwWsESz0sF+dp0/VMC4Dnb2ldD1zwICB66QCG
    SzhVuK9Cixd6qQDWdwXrWx5ZEE1VXTLXgiW+UU214wsMxgDjOEJ69CKdtRrg
X-ME-Proxy: <xmx:EfkWaof_Us3lCo8yTFeFuJv5v1T1vuC85QlCu9tK-k_1j8_4JxMkiQ>
    <xmx:EfkWahGSvwq9DKCx6BIV9r9HY2VfHd8FDC96tx_aCe_PwZshp-YAlw>
    <xmx:EfkWamf4CSEZHRYdpvzKBNwtg73TgWh_vY3mysOVXB41EI_w_z6eFQ>
    <xmx:EfkWarFXMsWCijEP9Zvb3t5dfkpIM8x0buFyhjr0neaY-H4WpMdD6A>
    <xmx:EfkWaqGbsBoyP8QeRSPao05_Iflu6uwlRdzCI2IlsIsJe3GBZHwo3mjM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 10:00:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] commit: remove deprecated functions
Date: Wed, 27 May 2026 15:59:26 +0200
Message-ID: <commit.h_remove_deprecated.716@msgid.xyz>
X-Mailer: git-send-email 2.54.0.6.gf6fa7dd4140
In-Reply-To: <CV_commit.h_remove_deprecated.714@msgid.xyz>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These functions were deprecated in a series of commits merged in
52882024 (Merge branch 'ps/commit-list-functions-renamed', 2026-02-13).

The compatibility was for in-flight topics at the time.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 commit.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/commit.h b/commit.h
index 58150045afa..5352056f87a 100644
--- a/commit.h
+++ b/commit.h
@@ -203,25 +203,6 @@ struct commit_list *commit_list_reverse(struct commit_list *list);
 
 void commit_list_free(struct commit_list *list);
 
-/*
- * Deprecated compatibility functions for `struct commit_list`, to be removed
- * once Git 2.53 is released.
- */
-static inline struct commit_list *copy_commit_list(struct commit_list *l)
-{
-	return commit_list_copy(l);
-}
-
-static inline struct commit_list *reverse_commit_list(struct commit_list *l)
-{
-	return commit_list_reverse(l);
-}
-
-static inline void free_commit_list(struct commit_list *l)
-{
-	commit_list_free(l);
-}
-
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 const char *repo_logmsg_reencode(struct repository *r,
-- 
2.54.0.6.gf6fa7dd4140

