Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1A2DE706
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578997; cv=none; b=QEv0pX5IVSYrcDrY4AxTYijT3MFEcygpdmARM+AJInOUMzhYBf1e6OELc6VPq3bGKmL8yq0uZyKgr9F0kktEmIB7IbQP2rMnXZJEWfkDY7DBmXRUoVpiZCLSV4QuByBIVm7hCESpv9jgtbIp61Ez4Pnv5eLxTwgEihPQC4S4rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578997; c=relaxed/simple;
	bh=Pf8uGwiX4s8MIKsr/bj6pcMnACRpZgfdOtuXo6z5tkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hl+T1t+H56F5kk03Z/ySvd6cMeNi+fqiiKpnVs878rA8dkucz1a7xOzZzdySMm5gKVXkkyKEMxUH4+n+u9+p9E7g33o+ccYFrgw2m+WWk+/ges24WkreaSHsB5wOwv1zqe6xPvnKxTvU+guvTfSPcQBOy2bIVxLoe88FHPQ/HSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tFWUhB9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jitELtb4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tFWUhB9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jitELtb4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E506214002DF;
	Tue, 15 Jul 2025 07:29:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 07:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578994;
	 x=1752665394; bh=mFDlX7llPXKIoMrkgCIC9IZtmVuP2GDCn7qg0Ilr45M=; b=
	tFWUhB9G9Fd+YvUEX9EfJpI04p2Lvgg10SV+ALzA3hM+OeLHkfxGdOZHi7wyAzxW
	ch268gq6ThGbCrbAYVLDhbBUUPRHNYvg+1Ft2qNuTmKqIVaXqVTKA/jsZ+xjTo3D
	E/arP2x7lNWHIscDoo5y36nETPvnPyMUkK3dgIUzlhQ4AAeskX62yEheR91zK6l8
	IPrHvED8luxv1Sj1zFzOEdsybH20yo+rB93OIE/OasmrO+ueP7opwVPeHtQ74aWD
	R2OYOgGPUBv/BnhcjEfXNwN3r+6J1nCoyd0UtopnJ3XloO8ApbTWKZPB9q1E+k0W
	Vg+3Za8mFJeppoC7YW74Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578994; x=
	1752665394; bh=mFDlX7llPXKIoMrkgCIC9IZtmVuP2GDCn7qg0Ilr45M=; b=j
	itELtb40ERMzxCsExFjTlsasfJtbFNd6j9R20gCMR8qiWibCqkCszOfN7LEfeMLR
	uWqTqiT/AqnYNFbjqGsCxWyWMO7lzKdYgkZB8wpFu6TEzhC31zcQhSdpMDwivSA4
	dxb1BErgBBgEq70O0TxW6Vfi4Zq/e+cvrKEphOzjizwJpkzObWFPFFe2WewYQ93o
	6IhGwBRXSa4j8YFoPEtQaLo9SVjopRZA1/FqNiCSQALhNDlLTwa8BFy457B7uao9
	1xBN9mMbqbJSPj5aCxI5CXMnfX/5Z835fI4n5cuYSzox+jNhXUcwoLi3APt7SQMn
	iNVBqoKxQC0Py++23b8yQ==
X-ME-Sender: <xms:sjt2aJWr-yn3Hn_5rQWC0jO0ULuoAB1VLdBOTEFPHnCj-hWo0MussQ>
    <xme:sjt2aEL6lc38_VfTSjOA6mxxvDHGZfxa4F52gI0T087xLimnnvAjAgDAF_rZwIWiy
    9P5JXVru1jabwzB3A>
X-ME-Received: <xmr:sjt2aB_oqhHcVx3gVufTu-8SClPa_RwC-APfHWKinEanc_QZLfkwy1s67kRO8bVgwEpvspCvL14NbZcVBzddsZChZkOO8bupHx-zZ5G-GQ4CUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:sjt2aPLkJZ62YdGvpU5cDjaXXOGtO-2zqPPlTX9uE52puwKeCv-Bvg>
    <xmx:sjt2aOk0gpv7Ao3XVYrdcy3AfQItwQz-2S6BPel_pzeiHgYubSo5Zw>
    <xmx:sjt2aLPwsI4guw3XZAHS3pgyOuINHHWemtCJ71CFyPkZvv_HcbOIJw>
    <xmx:sjt2aM00yPNStHiCnSox-yWDcGpma5tSxIKxuXeWlq-ZhTTZr85Eyg>
    <xmx:sjt2aI51ktCC4h6r0-zk5MIX5EwIGRgP6RoammBj5zOF0V_8AYM65EfU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33265729 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:24 +0200
Subject: [PATCH v2 7/7] midx: remove now-unused linked list of multi-pack
 indices
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-7-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In the preceding commits we have migrated all users of the linked list
of multi-pack indices to instead use those stored in the object database
sources. Remove those now-unused pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 18 ++----------------
 midx.h     |  2 --
 odb.h      |  7 -------
 packfile.c |  1 -
 4 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/midx.c b/midx.c
index 472d6bf17ab..7d407682e60 100644
--- a/midx.c
+++ b/midx.c
@@ -726,7 +726,6 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 int prepare_multi_pack_index_one(struct odb_source *source, int local)
 {
 	struct repository *r = source->odb->repo;
-	struct multi_pack_index *m;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
@@ -735,21 +734,9 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	if (source->midx)
 		return 1;
 
-	m = load_multi_pack_index(r, source->path, local);
-	if (m) {
-		struct multi_pack_index *mp = r->objects->multi_pack_index;
-		if (mp) {
-			m->next = mp->next;
-			mp->next = m;
-		} else {
-			r->objects->multi_pack_index = m;
-		}
-		source->midx = m;
+	source->midx = load_multi_pack_index(r, source->path, local);
 
-		return 1;
-	}
-
-	return 0;
+	return !!source->midx;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
@@ -842,7 +829,6 @@ void clear_midx_file(struct repository *r)
 				close_midx(source->midx);
 			source->midx = NULL;
 		}
-		r->objects->multi_pack_index = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/midx.h b/midx.h
index 639a6f50e45..076382de8ac 100644
--- a/midx.h
+++ b/midx.h
@@ -35,8 +35,6 @@ struct odb_source;
 	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
-	struct multi_pack_index *next;
-
 	const unsigned char *data;
 	size_t data_len;
 
diff --git a/odb.h b/odb.h
index f09dba1fe1d..09177bf430d 100644
--- a/odb.h
+++ b/odb.h
@@ -123,13 +123,6 @@ struct object_database {
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c and midx.c
-	 */
-	struct multi_pack_index *multi_pack_index;
-
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index ff33692f4b5..5d73932f50c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -375,7 +375,6 @@ void close_object_store(struct object_database *o)
 			close_midx(source->midx);
 		source->midx = NULL;
 	}
-	o->multi_pack_index = NULL;
 
 	close_commit_graph(o);
 }

-- 
2.50.1.404.ge9779f6434.dirty

