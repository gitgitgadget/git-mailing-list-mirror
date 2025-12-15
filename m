Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107630C618
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784196; cv=none; b=XlDOgple9Q4ZClss1tiPx/5E6+2fHwKPGKKRtm6ZLUSDkSbj03jRIJUTy9JrGof11sl+DU/jkrbRwCNC9sAfpVHGxCdf29G1inAqUtasGVYhwV3d57cHiROyjvukgdgfAkkaEoM4m8/oI/i0Mkr84WuPKuisDw/bXeLdgvLDrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784196; c=relaxed/simple;
	bh=InIlYGS3wprgDvv9CqZNJi3poO+/rIbQcipI2FKJK3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgZxz3jThtZA67x5AlOL5Irm/6uK91BanKBdzTJQyfq6mIpR3HdpLiDnUVZHZRCVKiaST8uUR9D10vh4gfmYXSCWsI/VwnKqtNFZSKLtlrkyGJti4L1U/KRDvobXmKn1p2JsiJxMx73gzaAKbO6g8M6le8G4mCzmpduDRQXyzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tdwulkqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uabNJJyB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tdwulkqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uabNJJyB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E981BEC0077
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 02:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784191;
	 x=1765870591; bh=KZGzEo0k7+Pqn18eqoqnRYlOhhn6k0F1U6MYKpeLICE=; b=
	TdwulkqyeXzfRM4/WGdapVgsckBonvMwg3oG3DTvkYrgZxfKbRS++p7WoEFml9f4
	LL8Nite24GoaCOeWb0BowVtedhz5I3jgDxJyEKQu0nsveOYoGTS+GJ8boxZL2+oR
	b+tZ+IwxE69U8pS3xQmh5hSS9Jeb0h5nFZRZW4zwakdfuFDCz8PricJ/HmxmAe54
	+yDsCaazcebV6PDVHINvt6f3yb/gVbc2uDfZ3ICaOCH30KaQujxg8vThCgwi1n4O
	EiFPyZSOURhzYqrbhL/Z3RgxurlO9NxsLKBIFC19nraMQsqX8leveHgFRrrjqTuG
	I6RnPxJxTzq29FSrpt06Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784191; x=
	1765870591; bh=KZGzEo0k7+Pqn18eqoqnRYlOhhn6k0F1U6MYKpeLICE=; b=u
	abNJJyB1MaJVeRzpk9NzLjv/v9gbo2HScGQlpte0jO9vTYd0f0C8XXTH6TfbnYSs
	/36tswIZLjkWr6zgPOW2cqqX7NIvCgPSEzfp4jtZWCD/HCqxFtc2Oo4auRF381pc
	iV22JbIt0o/nCvuBX0XU8W1CAx0CHBLwsSs+woz9ltTWpum0pUAow4yv86j7bAwj
	dqya7YSMVTdisXduOuXUfiqSfi8fhv90OMail57RY9aFzMWL4itSb1NDxlZEjHjC
	IJ1CsQztSuS+S2l8jrWJC0kjejEGpGZOaygUcLzq/+OC7zrCIuk3Sy1DYvV1cMIr
	nvYAEaEFdkkaWDmyQNuyw==
X-ME-Sender: <xms:f7o_aUhfUipY-LkPDBf0L7o-CZPGC6w7B0tTXh6uy6GC-uQqvENNug>
    <xme:f7o_aT9WrfOxCgGKEqoXJFU4B2FWhil2bYni4aOb6gIkGPrwoFDNY96KEpNo_LgEW
    WDxwACjzGj0TDX8CpjSlyUBv14XLiIfRiNQIgspvP4KRDli_eusQNw>
X-ME-Received: <xmr:f7o_aRu-gByk67HCDnJAi92w4iHPfycgGqAwHclE4Tcf6pDhNayT9EFY5tPUtc7yUNbiV-HmUGAdtwCv7IvA9AL21bBG3wLJS82C2uBJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:f7o_aaa09uDye17ObQM6y_tJoYZ3tdtMeWjYj7CKNps1lp8iehQmAA>
    <xmx:f7o_aRoEhY0irFYP29HlX54vl3jSlwyz12enCZFZcAnlE9_iQXZzKg>
    <xmx:f7o_af8H9dg6JexevSDjRJ1GUgJUdc7jPWT1Nikk2-zOq5KTVmzw2Q>
    <xmx:f7o_aQ-LlhV-UIdJAV9i0zKxjeWoT7X23PmBotQfKlqB0DY3lc7mzQ>
    <xmx:f7o_aZh5OYlXaI9atcOU-SnoNTCL4siJT8enLhE6QOyWlS5Bs6bOiwY0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4800e413 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:21 +0100
Subject: [PATCH 02/10] packfile: pass source to `prepare_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-2-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When preparing a packfile we pass various pieces attached to the pack's
object database source via the `struct prepare_pack_data`. Refactor this
code to instead pass in the source directly. This reduces the number of
variables we need to pass and allows for a subsequent refactoring where
we start to prepare the pack via the source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0a05a10daa..ab86afa01d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -975,10 +975,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 }
 
 struct prepare_pack_data {
-	struct repository *r;
+	struct odb_source *source;
 	struct string_list *garbage;
-	int local;
-	struct multi_pack_index *m;
 };
 
 static void prepare_pack(const char *full_name, size_t full_name_len,
@@ -988,10 +986,10 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->m && midx_contains_pack(data->m, file_name))) {
+	    !(data->source->midx && midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->r->objects->packfiles,
-					 trimmed_path, data->local);
+		packfile_store_load_pack(data->source->odb->packfiles,
+					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
 
@@ -1020,10 +1018,8 @@ static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
-		.m = source->midx,
-		.r = source->odb->repo,
+		.source = source,
 		.garbage = &garbage,
-		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);

-- 
2.52.0.351.gbe84eed79e.dirty

