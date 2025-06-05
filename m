Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F271DE4F6
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139460; cv=none; b=biJ6u+CBEqvxbuuoQyDwlfsYEbVZpkpZasOaksx5sn/ka6gF5Jn/ojQ7w6ZifwxDpWIoQfX+nLKIB7aN9vlJuB5nYRMFKUohVjzZJv8cXm+xE4nmG9lTKtxtpGV66M7pnDuKld2ucH9zttRjmZvoMq7l0CI5xBYWA4neFfgml94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139460; c=relaxed/simple;
	bh=MU9UJ6z3KRPqVDUT6mH8WA2uXEtZdTTE+Jhr2rRY+2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/pPrvVcvfq6CwEuSpoSjMc2xtMiPjiUondG2PxoxRifUCfvlIBFiVkztgAd2xZdKbg/1WJFnGp3mDxnE44M6KrsNUzsFMCe5Eh9pW5jiBP2zb6D/AYMl9pc8oLdgzkzW6VC1Ceufj7P7TlKI4N33NFSkszJu1ZXzWh7og2WWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VAd0Kt7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQ3O6ax3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VAd0Kt7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQ3O6ax3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 499751140107;
	Thu,  5 Jun 2025 12:04:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 12:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749139457; x=1749225857; bh=iV/ah7p/EO
	GIxJVDiOjmD0JMN95A6FMXP0BwhjJOPCg=; b=VAd0Kt7R1IBLp9Gzq80AgM4eNA
	PmGlzoPPM1edPGNZg9kjGu8zH5ypQjIPgt7ZKDU9I+HNwP+f2fy4UXW7DPW4sKpS
	06YejmPq4f6cDxuvqiEbj5xaBgsSNuWeKWBTpfP1JRVmukiMxtSwXPYoE/tCjoLM
	8+RaU+SW+zqAD6B/whCSe/37Wrmn+HI2aFVPuRRhjQwLpk7GE3zx8fBF5r82FhWd
	l+0i5GPbUxefSI8DAaVljz6NH+aZ6kVMp0n69KxM3q/lsYA/5mvN3ddZSgwERwMl
	0jj6oTt5cVGvt2b0VQRxW/7Ltphjo346dEikDJUdWrZvEgECjAt0hPvQEDRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749139457; x=1749225857; bh=iV/ah7p/EOGIxJVDiOjmD0JMN95A6FMXP0B
	whjJOPCg=; b=jQ3O6ax30TgF734++3bSh4x507vULJ9H3X0Im+wrePI6GkWMxs+
	BaX98lXvE/AaS6asCaE9z4s+tRBRFZF4qs+yYry6tzekiJRqDHVYD+YlCvSauB8d
	nMyzfYZLxXS2vBPXYGotFap7szgWPk8XpsA/7QsFw0WDYkB2nDiVdIg2AScjncp9
	uVXtHkvQcRvLUaSgwmuOJ1eb9NcJDoJRFXHRX16tStSg4M3dRGez9bbbNuC/13S0
	x7+hODuoyKChySBpyKQk+569TdUAz1xUrLxLCk98EuOyOuisoOwKsyC+kbqPUH2q
	LFx3SCZQxj3Jn7V2T4hcaZvDpRsdtpzSmBQ==
X-ME-Sender: <xms:AMBBaFT5DusWPpWWqbMgYHi60ixrkAL3zsf8NcAi-5qIPyjB6NWViA>
    <xme:AMBBaOy8x4JDU1TBouj-OoVOUWckMfGI4fH7_PG7Kff0jwQooAS3wjJo4gtdD70GL
    7CevgDZzrU0xVFkBA>
X-ME-Received: <xmr:AMBBaK3Qt-tn0bYY0k5uREET5xXLzvjxefcQuMSLtCz9N_Lu_35inpDJ17Cm51AxcJODpY6VjyWzP8A_0tk__9qLQKKZSUnmTWI2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AMBBaNCzHi2DnXow6oXwOyhM1k0eP1PpXUMQQStkEnCDTTNfjztBOg>
    <xmx:AMBBaOgzoyuowFXtD1UKHl48IUSGaOoWiGvnU7A2ggUpsIJt3UPtgQ>
    <xmx:AMBBaBom5r9K6JXnyM771vXaAI5hONUGAgEl-jRl8i8Dul13aqMNYg>
    <xmx:AMBBaJgmz5mB_qxpaaoyigXPPf20GUvyBVoPoVUQdvBtcCFfM14IcA>
    <xmx:AcBBaEGJ19JAICJq2ti8gg7RCcZ1Q8ZdvxSnqi_h0ayYaVH6qlkfubdq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:04:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
In-Reply-To: <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de> (Johannes
	Schindelin's message of "Thu, 5 Jun 2025 12:57:35 +0200 (CEST)")
References: <20250604205505.GA1510724@coredump.intra.peff.net>
	<20250604205513.GA1510819@coredump.intra.peff.net>
	<9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
Date: Thu, 05 Jun 2025 09:04:15 -0700
Message-ID: <xmqqh60u9nuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Mine was driven by the failing `osx-gcc` job, and curiously after
> (changing all the `l`s to `L`s and) rebasing to your series, I still have
> this:

Thanks.  Will queue but we probably want to reword the proposed log
message to also refer to Peff's changes (i.e. "That series covered
some, but here are a bit more")?

>
> -- snip --

I have been meaning to raise this since this is probably third or
fourth time in the recent past, but every time I forgot to do so
X-<.  This is not something "am -c" recognises as a scissors line.

I'll queue this on top of the other three-patch series.

Thanks.

--- >8 ---
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Thu, 5 Jun 2025 12:57:35 +0200
Subject: [PATCH] curl: pass `long` values where expected

A set of patches posted by Jeff King earlier covered some fallouts
coming from new typecheck warnings cURL 8.14.0.  Here are to fix
some more instances of the same new compile errors observed in the
`osx-gcc` job of Git's CI builds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-push.c   |  6 +++---
 http.c        | 22 +++++++++++-----------
 remote-curl.c |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 591e46ab26..f5a92529a8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -205,7 +205,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
@@ -213,9 +213,9 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
-	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 }
 
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
diff --git a/http.c b/http.c
index ecbc47ea4b..d88e79fbde 100644
--- a/http.c
+++ b/http.c
@@ -1540,9 +1540,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 
 	/*
@@ -1551,9 +1551,9 @@ struct active_request_slot *get_active_slot(void)
 	 * HTTP_FOLLOW_* cases themselves.
 	 */
 	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 	else
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0L);
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
@@ -2120,12 +2120,12 @@ static int http_request(const char *url,
 	int ret;
 
 	slot = get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
 
 	if (!result) {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1L);
 	} else {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
 
 		if (target == HTTP_REQUEST_FILE) {
@@ -2151,7 +2151,7 @@ static int http_request(const char *url,
 		strbuf_addstr(&buf, " no-cache");
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2170,7 +2170,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
 
 	ret = run_one_slot(slot, &results);
 
@@ -2750,7 +2750,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->headers = object_request_headers();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0L);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
diff --git a/remote-curl.c b/remote-curl.c
index 6183772191..b8bc3a80cf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -970,8 +970,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 
 	slot = get_active_slot();
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
@@ -1058,7 +1058,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	rpc_in_data.check_pktline = stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
 
 
 	rpc->any_written = 0;
-- 
2.50.0-rc1-198-g2c07f1279d

