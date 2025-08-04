Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D724678C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300446; cv=none; b=A5rc11olat9LCKvMeIIlz+OAF0oVS9sjaGCko1PnTKmSbY84LgyjuITm5Ze0rL12QZvu/R76gh/ri7MqETB4mOuGZQQ/I+vQv7zd/ZXC0yF6zcYpy1NaPBVDdkp0wgkW4y5uceIRpoKUzPT54qXcNS7CDKo6sJpTiJYBHG/o8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300446; c=relaxed/simple;
	bh=FDzISb9n3sxfEDqesp7g7PJSr86uB3/asDMk633zIXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCqPinKPBKYiwsAy7mCyCk1GwipLlwouNjwdd00VZ3azf0LYT0/f+iVnDyU96oKRjvj2lx1lFcvEmipPG9qUOx/GUsndDtCboFpbb6Ql3w7YAuSAs3gbFoz+Jqdz4fTArmUzhr76uw2PhMmbRbrRCeqAo54k5zT58EPJaRZlOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F46rzStm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OosnaTSd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F46rzStm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OosnaTSd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A562A7A011A;
	Mon,  4 Aug 2025 05:40:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300443;
	 x=1754386843; bh=RWHqEX7b4gvdITiKCqtcicp2Okac3iE0AI5QORG0+uk=; b=
	F46rzStmcPFhCxeCVT4A8m7y7YQIx3XB2lOSQh1jXgmKWKO1fkGb0GzD4cjvJWxD
	qms+uDN6CczDNxPwHD+64HqgnMtP264xLMpfEqZEH7SpQf5x8cSEx0AnrDRqH1l8
	731AM6GhLZNPrZ13hbDvM1A0eakU0ik8f2OgIceZY+ao44lb8HaHPLgP9Bd42+8M
	mKJaA9A/fHV9zWnIuAEOAL4RzntBx6p6HEBFIDxx1/SFPFe1pnX9dtnbZGaZSdU4
	m5pJoYJwFQrDgxjX88ONgtx7XxQHPhJxOyfUjbMfa2xxnrOFx2wjvneZNFtzxbsi
	3de/WClCBZ/oMch9qF3BGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300443; x=
	1754386843; bh=RWHqEX7b4gvdITiKCqtcicp2Okac3iE0AI5QORG0+uk=; b=O
	osnaTSdXyGAQuAzTKEYY1JqLip+dRmJzOhVZgv09opGChvkhailEePEZoGDoUGRj
	uyepZdlAaQMFGmRTDIaZkRUO5AcgBAAvrtq9jBp+qyBE2HQDd/5w0NQ3Ivc0w7qG
	xEDcNozyszSRS3+sENqt+tCzFDFFuQIpois1kc1xVnQ+KodVyLyR36DYOIl43TwN
	co7he1pl6xide3Ajal4Im6UZ5WFam0SWxMvENQBbM2K0mFDAiJpk0yts265IltXM
	BhGBywG7VJgFlj8/ycoQD8f+meJjoI4A3vDxWLqhMnoko9eS7C0TYy5BkXTW87VL
	mba9CIH53aOtt2CgDjugg==
X-ME-Sender: <xms:G4CQaMyLKUIr9K_AwdExukb7YAzh1hoR_tZYij214JUOTvFoJfPOxQ>
    <xme:G4CQaAfEonvMEX62xwzwNV1o1dtjDQAooPwLq4MGxWnx6INQBobLi0-hq9ElDsCll
    Wvx1CpCru2mTSqSDg>
X-ME-Received: <xmr:G4CQaAIKutDflaeEl76pnJNsUEVsce1W0zv1m0ji_R3ynkc_jVm0cATb45smnJHd7coJ1d7sOd4HRYZVciMOtu125RMV2RlEVfctUfToBQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G4CQaJGM0uN_DSn8dpyuHxH_21dsQUHWF5IdoodUQAdnPGp5cKdu7A>
    <xmx:G4CQaCoLNBxPgbNNHloj1Yq9DPbmmZ10vTqVJeaaw4b0W77zms5tLA>
    <xmx:G4CQaKQvfVaAYJL-AKWuA_yjSJo6P9h7Lxs3MayByBNxhnQB3ZAqVQ>
    <xmx:G4CQaHOYHCElEQ6RuKVQynUUdrGu0n2TtK_vkjPJwOf4XK9VUKl3kw>
    <xmx:G4CQaHVdaAfG97rmT5hbSNrwRYuUpKl4n132iSSKXOuyP4xRcVcsRISU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecaf1c89 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:23 +0200
Subject: [PATCH v2 2/6] reftable/writer: drop Git-specific `QSORT()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-2-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

The reftable writer accidentally uses the Git-specific `QSORT()` macro.
This macro removes the need for the caller to provide the element size,
but other than that it's mostly equivalent to `qsort()`.

Replace the macro accordingly to make the library usable outside of Git.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5bad130c7e..0133b64975 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -399,7 +399,8 @@ int reftable_writer_add_refs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(refs, n, reftable_ref_record_compare_name);
+	if (n)
+		qsort(refs, n, sizeof(*refs), reftable_ref_record_compare_name);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
@@ -491,7 +492,8 @@ int reftable_writer_add_logs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(logs, n, reftable_log_record_compare_key);
+	if (n)
+		qsort(logs, n, sizeof(*logs), reftable_log_record_compare_key);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);

-- 
2.50.1.723.g3e08bea96f.dirty

