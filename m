Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1430EF7C
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299790; cv=none; b=Rqcj+JM/Yk1pjzaswA2ZqLqVKnOUC6Gxuc1ZkPWYj6VE3q/0EvS9nSlqYuuOSFDFnTfeo3oQcRu5MCYc/Wu0S2Uo5vtBtZumU09yQ1C/KU5q8ImPTzTaEpgfP96DpvqwCabfy+52+SX2CzHuzIRZQaNJw/qpqlabzBDpU3skQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299790; c=relaxed/simple;
	bh=LuvP1aLMQ12piTt7QyMW4CTquBquHmykOz0PlizjjZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1VV1c2+uU57VPvbyk6tNJOa74QFfTEaIu0tJFS7DX2P9YSIGBpJ8QrubfDwe7HZsIq+2bumThUaPBDlOxHeHK1OsvWsjukThS3il2HSrT78956araGYYjXb/GjamyGyy3inzzhowADJjt/1j28/Q6WsfmvC8z80uyjKfKGoOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A4E+I6de; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khVRIX6d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A4E+I6de";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khVRIX6d"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCECE1400159
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 24 Oct 2025 05:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299787;
	 x=1761386187; bh=ivOnRKDbBz12ItfsTVj1h46XpWPUYDb80FXxAHeCmW4=; b=
	A4E+I6de1B95scXz8rRThoHRsHS6gfK3rc9UNfBXFz+1C3Nd3Q0rmvYUmpHP4Psa
	/nSdTl6+We8H/g3wDh1AwP/r3JMC5KBgz8pBSb9Oqwm2rdocgdmVQDRriwQnIKTT
	1KKOpe/45pUVpRzUm9vGy0syNu0Bs6CBrVud9N44onhNaXlK4T3EoJEOWviWb1Er
	h1K1ne59NupgWd0P9RfQ7JyWCco4utyawcPhDctwLRcL20R33MDaALBJhuIG3yqB
	HY4SpHegZE3pFoP+mINYHXwDSvepplGMdG3noz3Dlgfx0Y0raqQ6u6i9YF1iIcFy
	Kbz2PcmurfGvS02TdbSXlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299787; x=
	1761386187; bh=ivOnRKDbBz12ItfsTVj1h46XpWPUYDb80FXxAHeCmW4=; b=k
	hVRIX6dk51uTqwCFdNLus04UC/bhEG1ZYgwPmCcwFsnwCWBGo+5bTiXqNf83VIGT
	n/H7d2vjC7V9BmRDCFMcqaBQsgHnm/f1gQt2bwwmirC8LImE01HBZKsiEO9grGr6
	yVPEAwIff63djh9+PTeI+xFxXa+2aXegm5eaBtBK+gYOOY8cVyh1PllIP4V0SV8G
	RrE1Lf2XEn29WG6/kIHn9RLNmT9fYtzHS6cNEUm8aPSXuFLo4KpConnNd7IH3SZX
	hyDH3/xco+igff+1FgNlyRHx72TKt1AvFdNx+RWqa50/8wkzghZDSaqwzW3X6buU
	zrKvF14nsAXBbIVhSY9jg==
X-ME-Sender: <xms:S037aHnm2pAgCH95JuyWPnP6qCGNrIulcVrvwU6p370gmEwEONf6FA>
    <xme:S037aBzscGSzwZBbC8lqTyYnflYWXJkwdkoOEznaAygf7a_P4pY7wdEq5-pgLtFif
    U471lGyr8al3FFksVAHdc5fQJyqzVIApfmTJJQ1732o30hx3kfo>
X-ME-Received: <xmr:S037aDQbKKZz0MpmSaPWdaC8mVwZxlW78vjdmjPUj-GIMvPC4y0Vf8wT81gApszGn6-OagrL-TKghW0FiHyRXk1ISciE928bQQ0EjWxBoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:S037aEvO6Vu-qUWB4LO3UF55K3GH6oNj7oh6PnCP-6HD54qWIe52_g>
    <xmx:S037aFstLQoD38MyN2dKdP5r0ejOWW2KMkATQPOHjCDWOoSrV-VY_w>
    <xmx:S037aKz-imfp9st6CFLKQ7nhAYIlwSGHmhO8QyO3ahuZy5ZZzpF42w>
    <xmx:S037aLgAjPRGMyxM42exHMnl_kt7PY0CW1Uby5xs-JC3-h48Qrrfog>
    <xmx:S037aH1G6iW4g-YeFoLMLvreSKuYM_6eapXqXWv9uG8ym1E9avlibpp2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81cf6271 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:06 +0200
Subject: [PATCH 07/13] object-file: hide internals when we need to
 reprepare loose sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-7-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

There are two different situations where we have to clear the cache of
loose objects:

  - When freeing the loose object source itself to avoid memory leaks.

  - When repreparing the loose object source so that any potentially-
    stale data is getting evicted from the cache.

The former is already handled by `odb_loose_source_free()`. But the
latter case is still done manually by in `odb_reprepare()`, so we are
leaking internals into that code.

Introduce a new `odb_loose_source_reprepare()` function as an equivalent
to `packfile_store_prepare()` to hide these implementation details.
Furthermore, while at it, rename the function `odb_clear_loose_cache()`
to `odb_loose_source_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 17 +++++++++++------
 object-file.h |  6 +++---
 odb.c         |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index d7c6b1316cc..34c7fb434dc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1834,12 +1834,17 @@ struct oidtree *odb_loose_source_cache(struct odb_source *source,
 	return source->loose->cache;
 }
 
-void odb_clear_loose_cache(struct odb_source *source)
+static void odb_loose_source_clear_cache(struct odb_loose_source *source)
 {
-	oidtree_clear(source->loose->cache);
-	FREE_AND_NULL(source->loose->cache);
-	memset(&source->loose->subdir_seen, 0,
-	       sizeof(source->loose->subdir_seen));
+	oidtree_clear(source->cache);
+	FREE_AND_NULL(source->cache);
+	memset(&source->subdir_seen, 0,
+	       sizeof(source->subdir_seen));
+}
+
+void odb_loose_source_reprepare(struct odb_source *source)
+{
+	odb_loose_source_clear_cache(source->loose);
 }
 
 static int check_stream_oid(git_zstream *stream,
@@ -2008,6 +2013,6 @@ void odb_loose_source_free(struct odb_loose_source *source)
 {
 	if (!source)
 		return;
-	odb_clear_loose_cache(source->source);
+	odb_loose_source_clear_cache(source);
 	free(source);
 }
diff --git a/object-file.h b/object-file.h
index 9ecb26a4b35..a8d6cf513d6 100644
--- a/object-file.h
+++ b/object-file.h
@@ -37,6 +37,9 @@ struct odb_loose_source {
 struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
 void odb_loose_source_free(struct odb_loose_source *source);
 
+/* Reprepare the loose source by emptying the loose object cache. */
+void odb_loose_source_reprepare(struct odb_source *source);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -44,9 +47,6 @@ void odb_loose_source_free(struct odb_loose_source *source);
 struct oidtree *odb_loose_source_cache(struct odb_source *source,
 				       const struct object_id *oid);
 
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct odb_source *source);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
diff --git a/odb.c b/odb.c
index 5a5e770dcd0..b4196f0b323 100644
--- a/odb.c
+++ b/odb.c
@@ -1071,7 +1071,7 @@ void odb_reprepare(struct object_database *o)
 	odb_prepare_alternates(o);
 
 	for (source = o->sources; source; source = source->next)
-		odb_clear_loose_cache(source);
+		odb_loose_source_reprepare(source);
 
 	o->approximate_object_count_valid = 0;
 

-- 
2.51.1.930.gacf6e81ea2.dirty

