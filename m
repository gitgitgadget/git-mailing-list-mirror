Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B538AC9C
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914226; cv=none; b=YLAKCigUpOczdsTgsQ2J9TURUcwlruph/lv9i+uDACvEKwPYIxhdS7pKDXbHbu83vnD68AOb7y9/Vc4zAEYTXkH5uIBxe8GHQC3XwizMMMsFMEw1G6DkEBUJRidUBUJBWjEt0wPx/URTGtPyOQ2/Ejc7aof5NY1Ft3kGBssmWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914226; c=relaxed/simple;
	bh=I796tc1jytU7FBMNMPnLUSbLNKaXADUCZr2fP8WZTuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9AeEJ88MiByOxkkbnMKNFFkr9X5BR18RwOWKNZutIQdutEZFqOed9jOKSfgeeP/3uVUTGdYNFtJUpd84cQR2USXTloesCsbSJn3Uoesz4SBZPuWFXOYNrDL439CHouzSLnS2/l5oZFSfgcuxtazMB9A9vKPt/nVKEaVPLsB5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkMK3Gck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcWcS6zC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkMK3Gck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcWcS6zC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E86527A0116;
	Mon,  8 Jun 2026 06:23:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914224;
	 x=1781000624; bh=3wytL6YsCTm1KuL6gGoN4pQ9mK1KrLEAwiZBbCMsCBg=; b=
	nkMK3Gck4Xi3NFJlVq7/XDNF5J79ntsFJLWoSBAqQovUqnsFvomHHVdH3wHWcQCL
	kMGt0sCTmGTa4OCVhDmplFO2P7JC7J2Cjyl8t4JjvyYVlTd5+fGPmQkGPDA4pmYB
	I+C19A8ZMPFKhyeIn/Ns8cs2QxxPLw00qc7oKPz1nVjC0m9BEPyHMBhvQU2dc5Vj
	oICDubKJdoG2z0TPAnpMmY+gJtH2FnBbi/8Mb7zJcUAOnQ706XDCH7f2AVfQbNcz
	tEMqEeuZSr9RxIyhhWyphkFpttnjOs7RYDU6PcO8oEaKy/0v1uPSKfs3zhmxOs2k
	bkwxYS8duH+GvyZF32Wqhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914224; x=
	1781000624; bh=3wytL6YsCTm1KuL6gGoN4pQ9mK1KrLEAwiZBbCMsCBg=; b=k
	cWcS6zCZsRqPcsTFD0vY+WqVq5Mg3ZF2r4CNZoRmWViSyAq32iH8CZPY1xpMlc0G
	06JMCOG7SwmJGTk6futIrE/9CNMowCTqkPBeEft621y/FPZe8iu0zDeVKWc9DFMN
	qAYbrAmX3ap3K8NGWxmDudo5tHUvHHtl6Y70pnbSDuPQMrobnvsrJoyb5/9ROlj2
	vfWwRgt5O7pPHzclCtbpkG9RMplWMVg/+IChi+x9UKJhUGLEDuuPlGbYB17KVBpb
	KEo4s3lpW+eqQt7CQp9nxOYIVbV0XkKtYsLk35M6NsrPdQ2qQdui8UKGLDLcqVXQ
	mG3ZZztEpYmhXbZJ0OHIw==
X-ME-Sender: <xms:MJgmajRJKJeUWYYK4QCpk5bWF8VKHVpPLQstb7n3KEeGskIWTot5zA>
    <xme:MJgmamQNfae1F93VIMIf7QwUcBq2uiQ2_EI3uhXU29ot7race2dPHCiJyInO3005J
    2UAucsrfgO62785CUPS-HsWJzIVCfJ2PSTzYKHVkrTa8d7WuLzxxQ>
X-ME-Received: <xmr:MJgmao5IjO9ZR8ne4Fxp4OT4XjtNesXNx9AAtR2pud6RCC8hkONe-IlgGP8XYtrzq12EV4k_9uKtRN0-FpN-Q4-O667ENI-2tFaJYFmVrA>
X-ME-Proxy-Cause: dmFkZTF/E0B6+8HbVI0EuzBQ3dK8cHD9k7zZhvtR4eGQVqhd3W4HTcOnifeC1qzKI3nsbE
    Nr9VNWSWcSFtS/UIV6gQwbKHmcbCLZQ5dEmWkSWzkCkUK8vkxjfNEdIFScQfFAYP5zawV8
    kuJkxbizX3zEJsOqszq2+IudRIc8Uq86mQ36+9qMWm2f62cSt69oypV8UuhbQr8RL6FlHi
    jgxr7RInSbFRodGxO7WuQWF/WG7dKUmnfBX95+D9IjM+5QwCHTGkAMls42CUbLZrRvniUT
    3lub+E8UcsLzA9W1abr8Tskkr7igIbaHvXdizdHbApsrCDDZaJOZp69gRz16mo276cOsYI
    lEkHYSRIOdrA1uS60Aur6INC3if9VkcjFOXjADdmAvLoAk1rBEzp1c+zbMynCOAR0BrHi6
    TkkQxurE9plMSqbSRkF96ATDRUIu/LnT8N1u2phpb/OIdrxPfpsS7+6tZH/ovXR04cvafl
    VULzTKZhUocnIbj8DYLZcZMi8iR8Mf5XCe5mtXKHQc8rRIL8i92Xt2Qoo46mslmCn8vzUb
    TvUdyAQ0AEo6cbY72/CjJtIXhoa/5q4c/3k9um+VUrT/w3XepQwmpu2mmPpAorHSt0cGvm
    7N3fhJ/NM6QBJreBI0EYanqMF6F7PU8DYknbD9e1ec+WG2jy6TddYCvoKtPg
X-ME-Proxy: <xmx:MJgmai3SzhJrYdvxtihdgqR19V7pCFfvdpBW1TcZv96nYHcjoSs8Bw>
    <xmx:MJgmajAzmfCO8NpwVYmmnHwsJwSS9HCFf5pqUCm7jDDS7kycdozVeQ>
    <xmx:MJgmatMs6dzH03UR7AQACWjnGACUABkbcFmaWh45N-dvpuinSaJyDA>
    <xmx:MJgmaoYC1SJ1MHR9yrqf1hiMSyaoGfbg0mDpsN42RJkF0H6y2E-CEQ>
    <xmx:MJgmaqFKy3ewcXxZwz4jSRMGgw2_PaIkDwuHseApxlzmAqHihMPMowls>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c6519c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:29 +0200
Subject: [PATCH v3 5/9] reset: introduce ability to skip reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-5-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we'll introduce a new caller to `reset_head()`
that really only wants to update the index and working tree, without
updating any references. Introduce a new flag that lets the caller
perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 7 ++++++-
 reset.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 8fb39d4c51..f88f32d563 100644
--- a/reset.c
+++ b/reset.c
@@ -93,6 +93,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
 	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
+	unsigned skip_ref_updates = opts->flags & RESET_HEAD_SKIP_REF_UPDATES;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -112,6 +113,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
+	if (skip_ref_updates && (opts->branch || refs_only || update_orig_head))
+		BUG("asked to perform ref updates and skip them at the same time");
+
 	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
@@ -196,7 +200,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	if (oid != &head_oid || update_orig_head || switch_to_branch)
+	if (!skip_ref_updates &&
+	    (oid != &head_oid || update_orig_head || switch_to_branch))
 		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
diff --git a/reset.h b/reset.h
index cc9fd4378a..d2f8546844 100644
--- a/reset.h
+++ b/reset.h
@@ -27,6 +27,9 @@ enum reset_head_flags {
 	 * any user-visible state.
 	 */
 	RESET_HEAD_DRY_RUN = (1 << 5),
+
+	/* Skip updating any references, only update the worktree and index. */
+	RESET_HEAD_SKIP_REF_UPDATES = (1 << 6),
 };
 
 struct reset_head_opts {

-- 
2.54.0.1136.gdb2ca164c4.dirty

