Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4B1DE2AD
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053853; cv=none; b=UsmiDJhWUIM+INcNgX/BBFiE7+NjsjcZ5e4QL/7pccskhnMlNQj/sSRomxtLAF55HcyvpKgo/4/zzMoM0Sd8TQdEuyAkceo0ZJQtmADgUlU+N7xjysQ5LV2lHs306EUg6JJ4cduLpLO9EBfGogvYtj/vXhAS76DKTYlt8LsrtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053853; c=relaxed/simple;
	bh=U5UmxdP0VUcgF6+jd19fsyXjBriF4j1GaLyUcQUCgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnZ7dnLyq00d/gviDzX4h/sZF91uHvjgSHzCoew3/xNv3TJ3xrymCZLvslskbKm9v7vo5yWC9ggdoGDSepd+fkQ05HK13VzzR6cK1Li+QrBVcsZNBMFAfZuGJ3pCyKBoysvuTGWZ3nioyoldj/Zr1WA3qq+nV9oE3JOHF2JnzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rL0yyj6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRlR5SNi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rL0yyj6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRlR5SNi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF3262540096;
	Fri,  8 Nov 2024 03:17:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 Nov 2024 03:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053850; x=1731140250; bh=1IEBZcN26u
	FmhUHTrGjsQVwqKapfgJtMUTchElUueQI=; b=rL0yyj6CoZPSNGap/ky4zPC2lu
	HXJQU5vDB37FeQ1ZWMtW1aO/Apm2vRcmqAJGOdTxuGy8Wl+dzPAqz23NtwJzS/JG
	RuLK+qWS0ys2ofmNG85B4MiOZOLJrdGBZxv4VLsjuCufKcqUgwUsvjZVCBgCwORt
	pQp4mwdIA1wEbv6x+OhDUuqszoMuqxuPSwajxg0pkkh4X2ELIZk8nSwmADt5QShR
	b9g3Eq7LK3xH5+226QqhzEi9hWgLJb9kSaKFnVKU+SZ7PWiLJwAwE4/pxZAevxfb
	3zulFbD72vzRo88PO6yMrZM522tRzosEDnDbkATFl3W4AU/EQqm6sHBqgqpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053850; x=1731140250; bh=1IEBZcN26uFmhUHTrGjsQVwqKapfgJtMUTc
	hElUueQI=; b=LRlR5SNiFxit8eiW/MQFbOV5+JJz5gKsJ39cFCX1kzdAgxBYUWv
	M9isafioC8z5HuZSrLQHoFUOwmg4CYf4qt4ExDoWnDPtxpYieCPHqJX1oCpUg9SW
	PeMuVco7XQt2PyiOs0Pw9NK8kfX/8bpOORwvFmjxEO+FfnL4mQGcM4CPkrwlPnaw
	AjH4vN6pre5zNwpWvsUGU9YyuVkLPG0DtexWVuWNIFYAmZyzKx8RUm5FEoMLotyN
	o6TQH4uMzcQSR4YMcPjXcjCwrHftVJgX7lzJIgxVzVn7/Ndu0XbMPGWkpWBONECy
	Sj2pNZJwraCr4L7kZgOpzJ5IvC5IipZewxQ==
X-ME-Sender: <xms:GsktZ6JmT2cEhp7AzAQF1J0sLf3vHW2O33Qk9_aFtVpCu_v2qDSsWg>
    <xme:GsktZyJbUrSUK1gYAsEUK1vRvNY7SlFjKW1WAj4UYth7B3UvzvDvNeYx15nsr9J1V
    eQ-aP-IKZYL99dtuQ>
X-ME-Received: <xmr:GsktZ6uxqTsA1ygbLSQpFQK7qzbH0m-LB9DsQH0H-t6MKaZlY7IQtvWozuxLljsLWbJX67sKDIy0K0PVziNrFfVLbGJ9RV8z4PXIjATp2Hi6Ja4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghthhhomhhsoh
    hnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:GsktZ_azZzUN5SiKHK0UnNpCPgDVHGfONu4Vt9bjvkSK-jx4tckbwQ>
    <xmx:GsktZxZo4l_Yupt4hWqRcQCe2Oaf_DpGVg9tBfajv1T1KH-F77lrXg>
    <xmx:GsktZ7CxGMaUugXMKyOzHl7vps4eUt6T_gHnh6XGwDX3-u0kjpPEUA>
    <xmx:GsktZ3ZZBWk6-PwzaoYYa_9clJDY68hjgsRhCUVV8vV5QOZViqvHHg>
    <xmx:GsktZwVhQGklUT1Vk74jZPltrNsABOhWqRY3fsZrwBOTvKHfiPkY2LIi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a731d8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:17:01 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/7] reftable/stack: drop only use of
 `get_locked_file_path()`
Message-ID: <83949837a2970304c57e252065391f3c4dab956f.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

We've got a single callsite where we call `get_locked_file_path()`. As
we're about to convert our usage of the lockfile subsystem to instead be
used via a compatibility shim we'd have to implement more logic for this
single callsite. While that would be okay if Git was the only supposed
user of the reftable library, it's a bit more awkward when considering
that we have to reimplement this functionality for every user of the
library eventually.

Refactor the code such that we don't call `get_locked_file_path()`
anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2ac6a371516..223d7c622d9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1493,9 +1493,15 @@ static int stack_compact_range(struct reftable_stack *st,
 	 */
 	for (i = 0; i < nlocks; i++) {
 		struct lock_file *table_lock = &table_locks[i];
-		char *table_path = get_locked_file_path(table_lock);
-		unlink(table_path);
-		reftable_free(table_path);
+		const char *lock_path = get_lock_file_path(table_lock);
+
+		reftable_buf_reset(&table_name);
+		err = reftable_buf_add(&table_name, lock_path,
+				       strlen(lock_path) - strlen(".lock"));
+		if (err)
+			continue;
+
+		unlink(table_name.buf);
 	}
 
 done:
-- 
2.47.0.229.g8f8d6eee53.dirty

