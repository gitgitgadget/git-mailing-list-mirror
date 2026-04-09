Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7937B018
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719480; cv=none; b=ZDzQjr2NJoWpqYD+Oec7p7aeqlkdn3MT3VSfkktm1X3SrtMDOWWkGxA7YoNc+uZmRi59ey+X2HO1X2bC/PsAInqFxXjodt0Vluoly9MZpTCmG4Udph5V5JGU+vhoZusXm82++TL59lCNvtEA+1afHPnpTtYp6CN0kl0JMX91Ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719480; c=relaxed/simple;
	bh=C1bWSAnUvcRx4wg4PadiJaoTYGEplTcq1qLCfj02sg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSX0GqEURPtSH+7pbDsYnAS+yQPRsCafKSra26avnJ7lR2WK6Rjke/99sCXGcb7MeuVn2GrjeURaYSYGmPa78c5dp58gKQyJUMkX4fKGBRF9SBFOC1F6+MSpK5E3WAyRP3PCDK4+bMcSuWGgiZP8qN9t7EEapFzodAKcUq3xqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FPpX7pEg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=az9Y9ADH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FPpX7pEg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="az9Y9ADH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2368D14001F1;
	Thu,  9 Apr 2026 03:24:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 03:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719478;
	 x=1775805878; bh=f3NRdNKSy0ZnqnEwr6jevVUvUW+/ZFW8lu23bZFebiI=; b=
	FPpX7pEgALUAzpwwPR0iaQ+tWsrAll6mBlJP9LuCUkHZakQuh4XDi6pXKvLvlnJw
	XrophvN4LduDq7hvcfNYmuDvogv/IdsxD2XYxRjqWjcBJzAiwNtkR7qsr9NKCTJ7
	3sHgGpTZwFYfuML+sR/u3UH+bwOQg4j0xu/IEhCMjPxfIrSZbhZEEyutS62qyFx2
	RNeGWpzv9ehSQ3bhipUmS5jm1LO5g+UV7NpBo9JZtdpFejdAFA0rwc/q9Yio8chb
	7KNfpTZFzbT16+ErslK2Mv2A79D2ovxKqua2A9x6asktB8phzGR5KDwMfVKHQ32I
	kfyC6x1DDB/dPs3qWOoiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719478; x=
	1775805878; bh=f3NRdNKSy0ZnqnEwr6jevVUvUW+/ZFW8lu23bZFebiI=; b=a
	z9Y9ADHnJ/KCldO+LiLbutx1VRNHDXyP5eO8+Uu0GDEPk2q3mDssruCYSGckznxc
	W8tQbQ6DSKFo47zbKGP435mg3oHaUpQa2TB5zjVfcqDfdVITuON75TDmBpZUPV59
	+vQK6zFVDqSGozqroSN+JzLHESMs6x3tprtI7EfzoybTrhIHoV73SWtFRuj4rPgy
	hckGu6xpogbuQAtfUmq097wExav37zO7k8JU7onj0JtUVGfxyyBpC2byMBXqnSta
	Y3OrP3OeQ9M3XesxojS5Q3O8udiffmyF/dVNsLMmMeWeswQcGmeHfpRDgtFMS/U6
	SgFYTZ5HX2E4fObRPleaA==
X-ME-Sender: <xms:NlTXaSnZlFGbOnrS3w8K-ldjfKZ-rh4zSmvCov5xXWu4JohJkP1xzQ>
    <xme:NlTXadFUxWv3bOWP8EWAbZkFbgqgah1YptK3A3AUQShu0ikuqTlE9A4kpHczZES_o
    vkysz26Txzedai7hdNUIlIZm7iNlrk7SQF207Y_zjNZ4PPLBIzg>
X-ME-Received: <xmr:NlTXaaFmr4QqYtt-BByU3hMVW9HLwT0eUPD5Yg5lZ_FSxfJDrIl3AKIaACmcPZJDCsZQlPqxRRXCfKbjR0vpcC7-6Q11CQ6cYm1TMAhqux4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:NlTXaSPUsLnXgks38S8h4rfLLDcJla1fE66uoIrx5qnbS6fqOrWznA>
    <xmx:NlTXaRFGt-MdSbdhZZ-17WcYdLa8m8bHpfvkgrnyRMeqCYUWlZtBew>
    <xmx:NlTXaRMle2EdxW5eQ5nQLxINViHAPwtUAm0YpUAbcz7AOvKRrfuZ1A>
    <xmx:NlTXaa-bcC-q3_epVLqg_OpJb0nWR4M5bWES0EdNi7tm4qPqnr4ydA>
    <xmx:NlTXaZuYNI_lXk4TcJtCySIjUeuLkSPC44S2Q7cTpNxu_JAJu-kyGIWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33674771 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:23 +0200
Subject: [PATCH v2 02/17] odb/source-inmemory: implement `free()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-2-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `free()` callback function for the "in-memory" source.

Note that this requires us to define `struct cached_object_entry` in
"odb/source-inmemory.h", as it is accessed in both "odb.c" and
"odb/source-inmemory.c" now. This will be fixed in subsequent commits
though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 25 ++++---------------------
 odb/source-inmemory.c | 12 ++++++++++++
 odb/source-inmemory.h |  9 ++++++++-
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index 60e1eead25..1d65825ed3 100644
--- a/odb.c
+++ b/odb.c
@@ -32,21 +32,6 @@
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct odb_source *, 1, fspathhash, fspatheq)
 
-/*
- * This is meant to hold a *small* number of objects that you would
- * want odb_read_object() to be able to return, but yet you do not want
- * to write them into the object store (e.g. a browse-only
- * application).
- */
-struct cached_object_entry {
-	struct object_id oid;
-	struct cached_object {
-		enum object_type type;
-		const void *buf;
-		unsigned long size;
-	} value;
-};
-
 static const struct cached_object *find_cached_object(struct object_database *object_store,
 						      const struct object_id *oid)
 {
@@ -1109,6 +1094,10 @@ static void odb_free_sources(struct object_database *o)
 		odb_source_free(o->sources);
 		o->sources = next;
 	}
+
+	odb_source_free(&o->inmemory_objects->base);
+	o->inmemory_objects = NULL;
+
 	kh_destroy_odb_path_map(o->source_by_path);
 	o->source_by_path = NULL;
 }
@@ -1126,12 +1115,6 @@ void odb_free(struct object_database *o)
 	odb_close(o);
 	odb_free_sources(o);
 
-	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
-		free((char *) o->inmemory_objects->objects[i].value.buf);
-	free(o->inmemory_objects->objects);
-	free(o->inmemory_objects->base.path);
-	free(o->inmemory_objects);
-
 	string_list_clear(&o->submodule_source_paths, 0);
 
 	free(o);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index c7ac5c24f0..ccbb622eae 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,6 +1,16 @@
 #include "git-compat-util.h"
 #include "odb/source-inmemory.h"
 
+static void odb_source_inmemory_free(struct odb_source *source)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	for (size_t i = 0; i < inmemory->objects_nr; i++)
+		free((char *) inmemory->objects[i].value.buf);
+	free(inmemory->objects);
+	free(inmemory->base.path);
+	free(inmemory);
+}
+
 struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 {
 	struct odb_source_inmemory *source;
@@ -8,5 +18,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	CALLOC_ARRAY(source, 1);
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
+	source->base.free = odb_source_inmemory_free;
+
 	return source;
 }
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
index 95477bf36d..14dc06f7c3 100644
--- a/odb/source-inmemory.h
+++ b/odb/source-inmemory.h
@@ -3,7 +3,14 @@
 
 #include "odb/source.h"
 
-struct cached_object_entry;
+struct cached_object_entry {
+	struct object_id oid;
+	struct cached_object {
+		enum object_type type;
+		const void *buf;
+		unsigned long size;
+	} value;
+};
 
 /*
  * An inmemory source that you can write objects to that shall be made

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

