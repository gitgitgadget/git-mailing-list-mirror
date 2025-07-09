Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010A272E5E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047732; cv=none; b=nHVatJYtDewHmIxb3D3ioMLwte1QFR14r83ec0N3UfZuyM7q7hKu//bzhqAYEC+rRC0/AychqdVgREippL4Ndq8upc2RIJUg1+GaqDlnKzZ3D1Nby09zv9KSWQGmucmgV62sSN5wHpuN+0bqbjaJ/HsNz+0xXn2vMoIFW4jOwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047732; c=relaxed/simple;
	bh=oHTj3te2TRJsYQVXzSsNzHnDDJr+sQAu8o7DyABRj5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHFdFuPJDXc1lgxgcSduhBAbNEKv9ad8EpTdkg/Qcg84MiFnwatrD+VSr+d0bd/qGloshLYbnJ9W3BDSvYveLFsr9NRKG6Rdy7U+8H1x8Ms6mGiBvIoj6h06jiGrK5qj/Psv/wtSng/efG0YOZFq6KCHONYuh0JolVVKt+Ja85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bud4qRaY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqFLecYD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bud4qRaY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqFLecYD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E67A51400243
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047729;
	 x=1752134129; bh=xFVPWspxvJpBWImMY5KfR8K/l4iCVqZfYoaNWpzHX04=; b=
	bud4qRaY+G5TnRTPwsETju7R1TMd8NTthdICQafeyMTut3vriK181V5MmCYVynDN
	jTqSovie6qzvWor3GlA3EpG1Z9eo5R7zxEy4jH3MJ3/wj40V9uDG9ggPbh/n1bdL
	fYw5qRWRFvR9YigYlQiqR7q4WiNMt91UU3DTfuonJ1qaNxehcK6VOQuu3+xflXdC
	EiJBcaDPaEuEp8BC2t/5FnCuZNqpwYKQRCu/RBFPXNcFLO3SGSXMpWeC7DIgKTnQ
	6vD1DvxDgmAbzh9ktgicfVx38N0n2r+wCDL70SA4W/cQ7RcwFGIlZ35xmbW9OVYB
	4/ehNV/Q99+kfUlQM3NFRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047729; x=
	1752134129; bh=xFVPWspxvJpBWImMY5KfR8K/l4iCVqZfYoaNWpzHX04=; b=U
	qFLecYDq6PDGSTXf3NHP922EwfgF4gz+eDjtohCeMSdMOrmt7TCQvVofCwENPv9Z
	XRTbqy8cNuuicrgiCG85B0qty0f1ulc5i9yW6JNcIAfRSRF4oCjtRx8/ScL7z33T
	PZFAgQ+jZxj7q73XS3npFaeLzfwq5uZ9Y8nY7V29gx7pMAFBH+wI19s76VHBO2Mj
	M8yXhDLXXLVj8ZFHvV3RLxqerXWJA21x0F2jFJ2MNada/FIwmOC+qQgbH6a3QKrl
	n5ivvkmqnNj0vpFjEdCpiJDuirxjgWpwaCUiqTMBHfSxJLrGhgdleRqAMWxQHGmQ
	/YlazPWxxe5PgQmDJIk2A==
X-ME-Sender: <xms:cSBuaIaTRaxgYu6pF7tQK2sSJQnFBiW7qLpwOieEhrFXqaYjpl9tXQ>
    <xme:cSBuaFaf1ItA0sZv2q0zbZXXVAg4JpWeMNAR2rvpu_8YUaKoC9g24FkEBxV2rwtP-
    jfEoJw_3vMUBesYDw>
X-ME-Received: <xmr:cSBuaMWcbHCZ9Xexch9jl2Kjs7COCEbi6vK6WKAhSk43ehySgB8IfHJGKxxKw-raeknR407is1cj9n8PymFOxvZtWquP9e7IbsvUouTqiFIKtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:cSBuaE2z2G81isXtPRJ7B6nJWx-3wVmPMI-bH8wB6J5hQNsUxwycwg>
    <xmx:cSBuaLZyAiO2ixur7qrYuoE5PKKqF1ZHskEb2UYyH8RER_XIzElDFw>
    <xmx:cSBuaPpk4b19YT4UBJ5dd72A06HLs8s32-larXIA3fSsSuedQj_72A>
    <xmx:cSBuaPo5vBSiJD8cMoT6QDF2tldopjxungy1H9hrzh9Szy9_rF1_Tw>
    <xmx:cSBuaHxFewggwVL_S2u2FllgXCpcTfCLp1VHoNjNnFGjhLvWZNdCrlSL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4dd3070c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:52 +0200
Subject: [PATCH 4/8] midx: track whether we have loaded the MIDX
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-4-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When calling `prepare_multi_pack_index_one()` we know to skip loading a
multi-pack index that we have already loaded beforehand. While this
works well in case there actually is a multi-pack index, it doesn't work
when we already tried to load a nonexistent one.

This doesn't cause problems with the current layout, where users
typically iterate through MIDXs via the linked list stored in the object
database. But that linked list is going away, and those users will
instead have to call `get_multi_pack_index()` for each object source. So
if one of those sources doesn't have an MIDX, we may end up trying to
repeatedly load it even though we know it doesn't exist.

Address this issue by introducing a new variable that tracks whether we
have tried to load multi-pack index of a given source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 12 ++++++------
 odb.h      |  1 +
 packfile.c |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index 416b3e8b54f..6d3a166fa01 100644
--- a/midx.c
+++ b/midx.c
@@ -728,13 +728,13 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	struct repository *r = source->odb->repo;
 	struct multi_pack_index *m;
 
+	if (source->multi_pack_index_loaded)
+		return !!source->multi_pack_index;
+
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	if (source->multi_pack_index)
-		return 1;
-
 	m = load_multi_pack_index(r, source->path, local);
 	if (m) {
 		struct multi_pack_index *mp = r->objects->multi_pack_index;
@@ -745,11 +745,10 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 			r->objects->multi_pack_index = m;
 		}
 		source->multi_pack_index = m;
-
-		return 1;
 	}
 
-	return 0;
+	source->multi_pack_index_loaded = 1;
+	return !!source->multi_pack_index;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
@@ -839,6 +838,7 @@ void clear_midx_file(struct repository *r)
 			if (source->multi_pack_index)
 				close_midx(source->multi_pack_index);
 			source->multi_pack_index = NULL;
+			source->multi_pack_index_loaded = 0;
 		}
 		r->objects->multi_pack_index = NULL;
 	}
diff --git a/odb.h b/odb.h
index 8e79c7be520..b39534dd55b 100644
--- a/odb.h
+++ b/odb.h
@@ -62,6 +62,7 @@ struct odb_source {
 	 * should only be accessed directly by packfile.c and midx.c
 	 */
 	struct multi_pack_index *multi_pack_index;
+	int multi_pack_index_loaded;
 
 	/*
 	 * This is a temporary object store created by the tmp_objdir
diff --git a/packfile.c b/packfile.c
index 546c161d0c1..e5d9d7ac8bc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -373,6 +373,7 @@ void close_object_store(struct object_database *o)
 		if (source->multi_pack_index)
 			close_midx(source->multi_pack_index);
 		source->multi_pack_index = NULL;
+		source->multi_pack_index_loaded = 0;
 	}
 	o->multi_pack_index = NULL;
 

-- 
2.50.1.327.g047016eb4a.dirty

