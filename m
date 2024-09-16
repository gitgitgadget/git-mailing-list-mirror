Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9411553B7
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489742; cv=none; b=jmurH+VNz7uQ5H37CSsOeL0QTduO3mdf5v0XO0qBFrnoXX5b8cqtLFY27CEKBDiyNlq4UyW/kXIp+PH0KxrKR2oY1qwPynDJ8bpQqF6lkqW3xnmtbCWN9C2WhHLhwMuOzaqKtMpuyz7lH2rQ7HeKQfCE1G6yLB4XONgNdmlviT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489742; c=relaxed/simple;
	bh=2+Bq3FBnqX171CNqTpECpWVS1f+rbB8lKjzw4ZEBpd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHbz7BRe7FgVsCeX7SmgJqKql01mFxgVSyPCXiJxhG/AEUqXxNYhLGxgsAqhNcQCJ8wgZuVzA4Ur328qTarhGnw+yrsOkjI8Q7l6krhnn6LGkPOzii/b9jNBP5hIqOaizkecsj7aNRIVV4Ia4WiNPNNhQlM4P3g/KlVWpZxX8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jFZT9L96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5dBcIZ2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jFZT9L96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5dBcIZ2"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DE8ED13801DC;
	Mon, 16 Sep 2024 08:28:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 08:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489739; x=1726576139; bh=LogQC2+zgq
	2QN3Z1XvrDXhPS4tNisnkunFZv9gfh958=; b=jFZT9L96O82UUy/ymNZGYtt5+Y
	QZ7cudJ6fupymZBiL/uGFFPVF7POEl8Zh3kV5FkDhLdRNXs/xa1a1l2OlHHZqCNn
	lCs9cKpC6JsF7s7tnG2OltLtCkLMyfE6Og8nMQMHQCjKHR+klxrc+Oli8WZzvSQb
	nq/S4jdc31K2UJlJLur6TT8iDFf3tjVDv2cO/8fQmxHK8zKGCH85Uhh9/Jv7A2J9
	QfiqTiWNlK6VIAMZm56jN79SzvjPiUz2WXQVtLsDfBhx0HWUg5q41dUiNKYzZIGH
	03rCDxWz2Z/qy11YfXEXXCfYI4NcZ/yrWIj3ZnIppxoBCRZQX4oFepzj85zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489739; x=1726576139; bh=LogQC2+zgq2QN3Z1XvrDXhPS4tNi
	snkunFZv9gfh958=; b=r5dBcIZ2SWJ+OmipCMchVkzWOlqIW4kmd9WHXlxEH6Wy
	iqY29P4/aOyoavUBmHWlb8ZgFMOiQJ41JAy9FgUKz8JvbsDN8hkbfB3hI7sxvJHO
	St0LM64uREE/XpwVni6dd4rY6Qaw9HRrkKt7xIm+dQ3D1GNS1aQk60PIR1n/sEBM
	4O+jgTqybcYoHpj3d+dgPIia0Ehkoij+FZqSH3T4KDximHVTuMttjJD8D2EidyUd
	y5PZY2Y90gywm2VXb+T0hRdmcA6wBN2RsESkr6xWnmjk5pnUFH+gzLTeGT+BzSNu
	N2IawNA0dFC6kIWV2ZPs8MzSzhwi65DxzJ/vhjQP9w==
X-ME-Sender: <xms:iyToZk1MVFthrJRB3-S8aiMFxD1xre8Teas4FJoj5LVIJ8-nAvUnbw>
    <xme:iyToZvHGYwRh-jqe0sKwqanbHdzxFX5aSnkKAOTDKqfPP1Pw5EkPCYoFXrcJjEgdY
    X8X0CivmrDAgeNDPg>
X-ME-Received: <xmr:iyToZs6SxN7gMEirgzTaNNMFo74dcNej18Lj96hwsjqRG2UxGbFdboEqDeX04zUIemgRxh9LTMrJNNKSmn_5kE_A5gcxBBG51QF4QEqeSv-Vaxv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iyToZt0BY7QP6x0MIyQdFCYvd-JC1oAt1hZK-dKt73JmVlXQ5Cn_Qg>
    <xmx:iyToZnEd1FvoLwmwQNM86eifW4Lm9lu_o0RvWrOEfROd19BoVDg0UQ>
    <xmx:iyToZm-r1k7xLH0G43Y__pL-un-HUvNfvGtypkX5tf7UCFFb6-DE7w>
    <xmx:iyToZslJXi7F_9Q4i6LjI428FJ28mET84rjAkkX0GiUTIynTEAWzxQ>
    <xmx:iyToZsQHwcHiWHu_bVmtFs8-D3UW2H_EXrvqJ5TLuRx9L-eKoOcS9TqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d3ef8b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:41 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 14/22] reftable/stack: handle allocation failures in
 `reftable_new_stack()`
Message-ID: <f5583cc2300eeebd14dfeb0b5106a6e80418c681.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `reftable_new_stack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 060b2c1b90d..1b77c9d0146 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -56,10 +56,16 @@ static int reftable_fd_flush(void *arg)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       const struct reftable_write_options *_opts)
 {
-	struct reftable_stack *p = reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name = STRBUF_INIT;
-	struct reftable_write_options opts = {0};
-	int err = 0;
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *p;
+	int err;
+
+	p = reftable_calloc(1, sizeof(*p));
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	if (_opts)
 		opts = *_opts;
@@ -74,15 +80,23 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 	p->list_file = strbuf_detach(&list_file_name, NULL);
 	p->list_fd = -1;
-	p->reftable_dir = xstrdup(dir);
 	p->opts = opts;
+	p->reftable_dir = reftable_strdup(dir);
+	if (!p->reftable_dir) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	err = reftable_stack_reload_maybe_reuse(p, 1);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	*dest = p;
+	err = 0;
+
+out:
+	if (err < 0)
 		reftable_stack_destroy(p);
-	} else {
-		*dest = p;
-	}
 	return err;
 }
 
@@ -171,6 +185,10 @@ void reftable_stack_destroy(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err = 0;
+
+	if (!st)
+		return;
+
 	if (st->merged) {
 		reftable_merged_table_free(st->merged);
 		st->merged = NULL;
-- 
2.46.0.551.gc5ee8f2d1c.dirty

