Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFF36BCEE
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903207; cv=none; b=hK2NVGZRDghFYgmrxlWW9Xw9/lyKeQD3bCKiRaSoJ1kqIWpP5P4+EQIZaEC5rCC7fyms5ZA4tcstgIwIxTkbohQbzyvhyRQIcRHeOgalJBjtO55fYFEFtkc2OHQxLA9s9MFL36XkqoadE5DTvkK/sZMXdoNu/P2GH+Q7iesVmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903207; c=relaxed/simple;
	bh=LDgfKCKzd56XoMRcwZahActKGxDucFjNmXndLkLudQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki4khsI/jL8YZVsF8Mvu/94qKLP4IvuvcXVcObPVKp4hB2zFdOxJ9i6w+cnqw1PCHRuLH6BinVC0jDUgrqgBwpyhqKcF1k5WosSP6MMayX1gf9sNdo/xgUxm+NUhFzfgvIV+fuzMSFUJCEH+NdXZ6nJJK6TeeIqNqr/juO3bU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=foK3G66s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBgvat8W; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="foK3G66s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBgvat8W"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22DD3140021C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903205;
	 x=1773989605; bh=BulbMiwXRbZW5ObG5YkEmb9uQ1+nseNgzzhFLIvFEtE=; b=
	foK3G66sYjotmpyjgFOtzQ8R2xxdo7XQvC4KN6MvlKWBd0zDLaKSHkK8IYdqMCzM
	d5bVBL/5fCpaRCk3ojU77Htjk58qw2S8dUwnn2OdzeYnKD20XXNpWCUJjz32dTwq
	5KTZJj/+QpZtn2sr7U/cQzO+Xx1bngGDOH3Rbaq37wngnzLrE/ESBowcFVwsCKr9
	Iyl2XLWComNcB+qPxC9eSZs2Ns4B1FXbV5Uu3hHm/IE7k4c3dRM22GsL/PUH1Pfc
	ONjbBdvqTRqTP7aJ62ihAaV1dAVTryBqV5uUIeTaCB1/gOVWR0GaAvonDCg8OuS+
	b9BZcB306+fu9Zvkh8vZTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903205; x=
	1773989605; bh=BulbMiwXRbZW5ObG5YkEmb9uQ1+nseNgzzhFLIvFEtE=; b=w
	Bgvat8Wj4SjeMbEnsXH8Q4k0NVjyhHMCYdtUUjcJNCR1QdDikMj1Es3NhX7za6Ny
	+bx4TSKRg2sxltPjSccEAx8uUXtURC0DvBJwb01DC7uXhIF1mzZ5XDYYfTgh/C2s
	RxbAtn1erMXwQSpX9P8ylBq5/uVRAr9Zjf3MrCwOM2zddpN+Jj7LhfRRNnJQca5x
	7nYr+8I42KUzKklvi52WyF9ihs11/KJP6Z34YfAZ9LrYBPWd0iDjYo8upqyary8K
	ovvjSQuon/81NP4As5/u17Elxizgc4E+6S13DDzvWLBMp48AFG2MtKNU3OPQ5Yg1
	i4TJK+awnrb77Jr0E2TbQ==
X-ME-Sender: <xms:ZZ27afOw9y_SXLqeJw7Hs4OzRctbiLoRPvT1Ikf_2uGiR4rnZ4qvHQ>
    <xme:ZZ27aQ6-FHa7ToXPjrIyrNpkgcGLH00hhhQn9D3V9tygSIS5WRqNPYVnr2K-ORf9V
    Q83DWZITQTADNf7ltEuojPfZwqLgC6yU-fbrzuDFG0kd00nuLTDqsY>
X-ME-Received: <xmr:ZZ27aT7rn76laQJOs4_oj_AM6aqY6hbHnuOgWrijVZuAFff4XWjXky_gbDBQPrWAF5i3sFqZTNC6DNO3QO5MTJE0BGOcKK915E0qGp6zpQ4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ZZ27aY1eDuGl2H3gTHAuBj1PMgUGXjKusInmkk_ze--ZYmPgzJ-TMg>
    <xmx:ZZ27aXXlMc1DCxJaRpgcJ5S4E8n2rKdVu58S-0WrGAIsQOZorQau6w>
    <xmx:ZZ27ab697PHVS-WZk0Fj_fK4ZZmld4fktT-jNjRzfaQ_nKZGIqhejQ>
    <xmx:ZZ27aWKHbHISeLDAwYFEwasil8c_TCCiH3FrZDtavmr46ZONrrMcIg>
    <xmx:ZZ27aT9rO1s4UXH86AuBA9Yo6JoWC96Ksh51BurkBHo68gXQFU7jyF0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2131c20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:06 +0100
Subject: [PATCH 08/14] object-name: backend-generic `get_short_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-8-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `get_short_oid()` takes as input an abbreviated object ID
and tries to turn that object ID into the full object ID. This is done
by iterating through all objects that have the user-provided prefix. If
that yields exactly one object we know that the abbreviated object ID is
unambiguous, otherwise it is ambiguous and we print the list of objects
that match the prefix.

We iterate through all objects with the given prefix by calling both
`find_short_packed_object()` and `find_short_object_filename()`, which
is of course specific to the "files" backend. But we now have a generic
way to iterate through objects with a specific prefix.

Refactor the code to use `odb_for_each_object()` instead so that it
works with object backends different than the "files" backend.

Remove the now-unused `find_short_packed_object()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4c3ace150e..7a224ab4af 100644
--- a/object-name.c
+++ b/object-name.c
@@ -120,28 +120,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
 }
 
-static void find_short_packed_object(struct disambiguate_state *ds)
-{
-	struct odb_for_each_object_options opts = {
-		.prefix = &ds->bin_pfx,
-		.prefix_hex_len = ds->len,
-	};
-	struct odb_source *source;
-
-	/* Skip, unless oids from the storage hash algorithm are wanted */
-	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
-		return;
-
-	odb_prepare_alternates(ds->repo->objects);
-	for (source = ds->repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		packfile_store_for_each_object(files->packed, NULL, match_prefix, ds, &opts);
-		if (ds->ambiguous)
-			break;
-	}
-}
-
 static int finish_object_disambiguation(struct disambiguate_state *ds,
 					struct object_id *oid)
 {
@@ -499,6 +477,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 					 struct object_id *oid,
 					 unsigned flags)
 {
+	struct odb_for_each_object_options opts = { 0 };
 	int status;
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
@@ -526,8 +505,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	else
 		ds.fn = default_disambiguate_hint;
 
-	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
+	opts.prefix = &ds.bin_pfx;
+	opts.prefix_hex_len = ds.len;
+
+	odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
 	status = finish_object_disambiguation(&ds, oid);
 
 	/*
@@ -537,8 +518,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	 */
 	if (status == MISSING_OBJECT) {
 		odb_reprepare(r->objects);
-		find_short_object_filename(&ds);
-		find_short_packed_object(&ds);
+		odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
 		status = finish_object_disambiguation(&ds, oid);
 	}
 

-- 
2.53.0.1055.ga2ffed1127.dirty

