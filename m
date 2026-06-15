Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFA3F5BF6
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531720; cv=none; b=svx7YaJGYHGb9HlRz2RVZKQhXyPRkEEY8ytRBheOciEQLP5hDn+VCD1JFYW7NSADPVnv8h59+Sy4/NN0Zm3kfnD4D1AfuShlEdafO5FWEJwS7FstyRoehde6D0rXckXqBDf/aCw1vjhHDI97i8ChYI7Po6qQI52Xbh/FJQlop5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531720; c=relaxed/simple;
	bh=bkP7pWnGXGcDB7/TEOrBOdtw3u0IUTXBGGLZ1t7hthI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chA+t1LS3dyYLVjp3TQM826OG4icGQLpcWOZmbyQXKntBIgQoJ6b6l7yCXDGjx1IheAWgdkNgt4Do0EduvVV9vZw6n7WSp5JEHRSnRJcDWllZ0G6fTaAE0XcpDBICd2G8SCpTfSYUcGUtaCam9invE5F+3nYVai/iJY2mTQhum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l2n6JZY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9gCjWom; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l2n6JZY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9gCjWom"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2FAC140007F;
	Mon, 15 Jun 2026 09:55:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 09:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531717;
	 x=1781618117; bh=d4MdEBSrGwRXem4LoQIsRL5/rXLb6gQo29qqTi4iFlw=; b=
	l2n6JZY6cxMnxqUq3O+I3uxndvxqcgApUg4DXgQqJIq9HnRPCmH+NtSX3a9nansv
	ueDzXpjg5fTnntwphSidKXzVGb5TUv4PfJLAtpZR4R+ZD5XfWVP14ho0YWw/y7bn
	Zi6KzuwoktcXkP12YaGsUActlOt+eWVqNMW1aAOIA9jl9a5EPmWeRKaE8v703Twk
	emxkWYKVaUvkFPxxXvNdna3pBHjqKFsnfFNR+hN0StMF/tBXJRfartqBrJczUMtK
	E5OUy1ourqbZHkNJXQOR8uTWSIWPXmyTWA9XOSLsiH2Z211Qoo074ijoAz/x1aq8
	ausXmPS4u3zIlL9K/R6AzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531717; x=
	1781618117; bh=d4MdEBSrGwRXem4LoQIsRL5/rXLb6gQo29qqTi4iFlw=; b=h
	9gCjWomFKiSdnBjTZ2YJsX8/HUerQPcBnnoI6wL+uASBHCi3fH44Zmjv14RLLjJV
	T0ZBQ2sg2vnq+iaKVbk5Snc8vGfefBkjPLHHkQbxOpAzKo5WUpldjLP/klU2NGEI
	rjuRnG6PaoudU1C/9e1JRCCz16S/YUqEUAabe3pSF1bo8bDOPxG54cgZW3w3bDhe
	3TwjUNtxbZLJdvNbFoYoq2YFRYMfmfmu92y/NCGi5trzC9n1XNzld9IajmMcK0Zi
	9AF2iwT5qL14WqaK9HWC657O4b0n9zCdH/IQ0T3Jc00Bd7CCjzdFMSiYY16xNtoK
	2vkOuO5WXX/X9veVP6XVA==
X-ME-Sender: <xms:RQQwapFJ3G9RukN2-AvXAyWMqoKnaxCRRp-f5AvrJr_cPBnCULH4Tw>
    <xme:RQQwardVpU___Oc0pXmO0uvJGmI5gBcpnU9UYtqPJ_G7FfDzyMNEzX2hSr2ps0MuV
    DOggk4-C6n3vkB4UOKZstQlp_NDX2GZRc8dAwPujJ6ONVM0R5fbug>
X-ME-Received: <xmr:RQQwaqJCGC8aaH59kKaNalB_ZUprKQC9UTpEB3hGtYWQpFcqKQzClb1V0QYLCWbYG0G5bfbo5RgC5G0LqONXwqLxKHD62oAkdG6U1VhVkg>
X-ME-Proxy-Cause: dmFkZTEMPeD8zBW3DHtQEP5i93Acch+5rP0QNkH1cG/JXuA6+oEvHbtVmbD6clvJelgRZE
    1vBDsT7A7uQV6Gdj9OkjlqBCAnA412wemQtKwuPA/hvgcOh8CyRfV2AhtwfLNHTKQlwHQv
    oxhlnwtt/nGkegyVzC975GVhHt4uS6iBR/u/zU4/qV1aRi9gpkRnRhEG7H0vxr+9yXdWRU
    A8v/TL7rSWppNOMIvDS55f2AGwsqLpr5AvNVKzOZx9y2Ss5T1e/j4FoCcOGPCslmG/qDWP
    4JG1/aHeUY9Coy2vDLc1RvUk2C6XO8Fs5cA6VTVPI0cv+rNzSdKho8Uu7UNXJYJWmKwPBF
    SQrNsOVVNmE+aBLx6gDxuzT58jM8gAVjA72eZYl7ibxSijTgkBz9Cn50JftyIqKYLzJdJv
    LqZJME7TxZhAyGbpixsd1UMeRYTpe4Sd+8Z9k4FFst2+dW+1sXc+Kzzpxolwd+rVNB5l6p
    EqiwjzAx3kQknXqkElrNSDoH9rmH0WKkUC5UL9AjKwdmTbowkQ1ZwqrywG4fIAvpKcWIvL
    1CepAdk3nNzpPmvgf4qOiPlKiPBCV3gyBz9FGe8hp6tevcwTptHHU9OXfpRnGItjWR5rw7
    6tjktsvt55WB0XPVamkB+kaLBJM6dMVOgavBARFhFeGpWo+Q4H5joqQXeA+A
X-ME-Proxy: <xmx:RQQwagEzwxi8kbh0Az1BBMNjQznQZWT9s5kFC4Xa98Nh3SmESdQvjg>
    <xmx:RQQwatDeTMXouLiIzolJUJ9PnEzwC78B4OY4tSmOY84JYqXj2flWMA>
    <xmx:RQQwaj8ZbSIHWBzxdHBqOe3xkRDUXUp-bghdTKC9DNkFIarwqaj0Bg>
    <xmx:RQQwapDJI3k5rRk9FxkIfLPK-mTI472Bkbbj1J1bQQ_7iCBDNu_CXQ>
    <xmx:RQQwanhK0RHARXXCjLt1K2FZVgspCnrCMaocreSlSfurYp1yEgNzWBw_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c275900 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:58 +0200
Subject: [PATCH v6 08/10] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-8-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_working_tree()` to stop updating the index tree cache.
This was done as a performance optimization: the function is only called
by "sequencer.c" and "rebase.c", both of which assume a clean index
before they perform their operation, so we know that the end result will
be a clean index, too. Consequently, we can skip recomputing the cache
as we can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_working_tree()`, and consequently we cannot prime the cache with
a given tree anymore as the index and tree will mismatch.

Adapt the logic so that we only skip the cache tree update in case we're
doing a hard reset. While we could introduce logic that only skips the
update in case the incoming index was dirty already, that doesn't really
feel worth it: after all, the mentioned commit says itself that the
performance improvement was negligible anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reset.c b/reset.c
index 06f375f296..ff87e3e357 100644
--- a/reset.c
+++ b/reset.c
@@ -167,10 +167,11 @@ int reset_working_tree(struct repository *r,
 	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
-	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (reset_hard)
+	if (reset_hard) {
+		unpack_tree_opts.skip_cache_tree_update = 1;
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	}
 
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
@@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

