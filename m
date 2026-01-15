Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68236D50A
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475116; cv=none; b=Heo8irog+2m6zGvL/X4NpHfn+E3VDHML8kiE4bB6wgOKRNMviXhCV+kvfGgxxeJ5Npoqon/bn+Me3yJWsYuwuOBPwIx6cnoayhaoj5lwa4NXVIZAJCO0F8lKzPNsU8cgskP3OrckRX9BxJgTVb1z751PG1xEPkMmy0VfMySW55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475116; c=relaxed/simple;
	bh=4cR+fBpFhyFSPeP+rEkMuAae4qvEjCwBvnPlF68ygEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWHEYULyK7P0M/5lXc5/reD8CPeynWBK7av5IPnRBbX4cWI5gUJjWpi8RmfnaybbCbb3VAIZ8GCs/owJVZ+ftOt7DQxbR95qebmrlnJ9t/0kVYy4NfEoN38UQzgL4zFi6hhT3Efj36eoi/kd/9AIFZxLFnN/TYDeDNvSFhDdJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dMrR/mDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSH8Wu9h; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dMrR/mDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSH8Wu9h"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 213B21D000E0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 15 Jan 2026 06:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475108;
	 x=1768561508; bh=gEoUMdQ7VQ28qX6EAb8IP7oDU2K3ZiiQhe+OUGwunbM=; b=
	dMrR/mDBTKYSHeGqVQ5lp7loi3uWCVd2iOW3RUNGXj3e8SOlM8FU1W+DOi2/a4rL
	1ERffheE9EPc5/3Dk7V4uzFz01mEzBeo5EQ81S69GGWBdheSFuoU7/mto2mnP128
	S912E2J7/E7ancpTA8VmSgjI78LPmIW81U2XsbqguPbAI0HGP+CaQU9VYddVV/6k
	gSzuVGsuBNEBipSqpEhOvnCc76uE0gFuD/m0w5azvxoqIkKR9tH1L7hzOQ89cSnr
	uAkW+QmVY1q/ske9dyN4p7nMW8ApwBm9lUWRBN8PGskE/N+Iui+o5OrTuH+am42L
	6Bhx1Q9U789zIGIkz0NP9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475108; x=
	1768561508; bh=gEoUMdQ7VQ28qX6EAb8IP7oDU2K3ZiiQhe+OUGwunbM=; b=S
	SH8Wu9hA9PEOR9ddXKmAND0/g035JjN7kaf65tqoNBHzfZ9vmEgBiQHhti7+fw7Y
	B/7oozn94YEVCle8Bs8laWIJ7DFGlOAtQGR4hM0sbDy7d8HkR2ZGkTzfbMaZyZJQ
	ZQzZfz+dt0MM1CZK0p/8y3DlM6Ui2V1x3gVEaWIJpJwqlM5BHbppoLbRAULDPJ0y
	x59hTVjFqCmZDOGNxjJnIplqwRQ0CHWIVji7sgDvaBmSLSZCsiDAY0c2rVSZ2sBC
	ADZEtieJg7m5QFLyyX2vjytr+oSg+ssJrWrESxKgWOwTBVPoLY3ruGtSp98I8XeC
	A7DxeQox0Lk4x4DbGvu5Q==
X-ME-Sender: <xms:5MloaarPi74hJ9asaSOubrK3UDdovOziYGmZtr564M6SvWS-44gmSQ>
    <xme:5Mloafk7ckEgVo3iQ34wOyjySSZZnksLzmOxsqnw30UQcQal_xbcJ5DVZCvfkGWIN
    jflZv7er5LcditW49GFqa1EiDSriUe4DNtzcMaVexXEx0SKQ3se>
X-ME-Received: <xmr:5MloaU2qMzMnYm5-38nAV1bXUw_ArfW-qtVCbWBwtNVKirwVvjTwN3iDcBi1C2wzFBPnD3JQIGcn4PT9fGu3KakButk4xf_0h0LsGBS0Bg3rCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:5MloafAxcmUv0zKea5q0eN1p55xG1QuB4-__w59YRfHeRoxs7Lv0fw>
    <xmx:5MloaZzY4ZQ4HOZ6d2MidwjJc4PNxbUvonMdRXVeCDKUqJeQKt2uRw>
    <xmx:5MloaVlPQAa8tiJ5CHV6Hm8ihOngCxcRJymcChCB_3mQEjXZW2nsCg>
    <xmx:5MloaWHIttOf6BAllE5o6XRhYLbUeSZsDeEg09SuVxoQfq0qoA61fg>
    <xmx:5MloaWLdFqmxbdlUSMnfyDmeJLMA8CMqDFDdqlIdlSNmke0EaQB-MUmt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb45636f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:34 +0100
Subject: [PATCH 05/14] packfile: extract function to iterate through
 objects of a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-5-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a new function that knows to
iterate through objects of a given packfile store. Same as with the
equivalent function for loose objects, this new function will also be
agnostic of backends by using a `struct object_info`.

Prepare for this by extracting a new shared function to iterate through
a single packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 78 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/packfile.c b/packfile.c
index 79fe64a25b..d15a2ce12b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2301,51 +2301,63 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, unsigned flags)
+static int packfile_store_for_each_object_internal(struct packfile_store *store,
+						   each_packed_object_fn cb,
+						   void *data,
+						   unsigned flags,
+						   int *pack_errors)
 {
-	struct odb_source *source;
-	int r = 0;
-	int pack_errors = 0;
+	struct packfile_list_entry *e;
+	int ret = 0;
 
-	odb_prepare_alternates(repo->objects);
+	store->skip_mru_updates = true;
 
-	for (source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *e;
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		struct packed_git *p = e->pack;
 
-		source->packfiles->skip_mru_updates = true;
+		if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		    p->pack_keep_in_core)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		    p->pack_keep)
+			continue;
+		if (open_pack_index(p)) {
+			*pack_errors = 1;
+			continue;
+		}
 
-		for (e = packfile_store_get_packs(source->packfiles); e; e = e->next) {
-			struct packed_git *p = e->pack;
+		ret = for_each_object_in_pack(p, cb, data, flags);
+		if (ret)
+			break;
+	}
 
-			if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-			    !p->pack_promisor)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-			    p->pack_keep_in_core)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-			    p->pack_keep)
-				continue;
-			if (open_pack_index(p)) {
-				pack_errors = 1;
-				continue;
-			}
+	store->skip_mru_updates = false;
 
-			r = for_each_object_in_pack(p, cb, data, flags);
-			if (r)
-				break;
-		}
+	return ret;
+}
 
-		source->packfiles->skip_mru_updates = false;
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, unsigned flags)
+{
+	struct odb_source *source;
+	int pack_errors = 0;
+	int ret = 0;
 
-		if (r)
+	odb_prepare_alternates(repo->objects);
+
+	for (source = repo->objects->sources; source; source = source->next) {
+		ret = packfile_store_for_each_object_internal(source->packfiles, cb, data,
+							      flags, &pack_errors);
+		if (ret)
 			break;
 	}
 
-	return r ? r : pack_errors;
+	return ret ? ret : pack_errors;
 }
 
 static int add_promisor_object(const struct object_id *oid,

-- 
2.52.0.660.gd05f3a8ea5.dirty

