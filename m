Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7421ABAC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357149; cv=none; b=JNDUFUlaHrKaOWeo6l0U+PPMTF7hBj5lWyVk5f79vkEOdvBx3hG8lECl/Hfu7FBznOd/4cm0u4upzwl1ADzSDLneto/JKi7w/gMowO0Bl8004EdXB6WvLP1ZCgFO+sbLizBkEpSujPf5YNpbqBgHklCgvs1rX7fF+Au4R0RtBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357149; c=relaxed/simple;
	bh=d8b7Bzs/NfmorixL/Rk68wqPV4+s6+8iOOchSDgavuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBRxQzSxJdUftg03p+zny9xwq0D4gV+7SRLz9PKcpk+Ri98SvAnO67X/iovpPPC9EeDJeogOXP/bpgxIe9xnywZ0U+U+KsCBCtba1GFNRJHeZ/6ZpvVMLRp0+5Q3Hs/JPm2tXsM/87zBszYP3wmF0bhP14AF33NbrSHuQJwzDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDiojTX3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=41pNgCCd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDiojTX3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="41pNgCCd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4490525401CD;
	Fri,  7 Mar 2025 09:19:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Mar 2025 09:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357146;
	 x=1741443546; bh=er5VNE4MwJeSYQ3kvnqv2V+NHWCOiX0C4nuYTfZ7rMg=; b=
	KDiojTX3oQb9Tpv0zNElCVDDxeNGzo4A2QoPxxnHpOBikIk99k8Wdvnp9hA3WoEJ
	Vkp/EMxegJsL3gNd0b3pEkyx+UZMOlGKnU6FNi/HHu+dhNrTzaLU0emqMjWevPje
	NIIr+j2peSjHAAr03kVr0wiyXSEtaffe+5doxx7hedMUb7luwhmKSGvqmOcj0Tvf
	ZjUkQzMDbiMCFKEj9zlNl6lGh0jesorTCO8amigV7Q5zYSk2EADTSjzfbVPXsskW
	N0VU7lKz7NZZ83ARcuPDNXrdNDeP7dhXkfOnvOEh170+VRVeZPhnxFx8EBrI10Th
	fo9vh5mKRJVp0w6BLZ90Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357146; x=
	1741443546; bh=er5VNE4MwJeSYQ3kvnqv2V+NHWCOiX0C4nuYTfZ7rMg=; b=4
	1pNgCCdXFjsA3otZZMpbFg/EdERxhuJpMgsoFSluS5q5csvfzgA3V5Mguy53Y6vy
	CrNy+HlMEw7pugU+8bnlJmVlDIqLofkRlFMfcMKJpY/sMCBwy1jOY6VtxNnQWtNj
	F4dEc7Y/ZWOApKBLE3p6YEM3ieaLEGQ4F8rJHZd6sZZbFd8clAbf9Q3L3KPFNwvl
	V6KNC+vZy3lMF2B9PVdp3i7I1uzoHzsfUqqO9/qtDayYlVVRtTQ4rZM+ANL72TEe
	LzcRaDzO7R+aG5xsp4UyE8BrtEeN8htiRsjYZof+rZStK1QoKaqOBV2U7MipNWMq
	sU9loryEC1jn4pMN2Qknw==
X-ME-Sender: <xms:WgDLZ0wE5N999qLNm2tQ5EdH1a74p5ZtP8EV6gjBRxkrXpezYT-bFA>
    <xme:WgDLZ4Q4-FXEovDRtIehe0-quIHai-8Ps2R8HSWscylenepmLpOkkDS8QkY-UVbSR
    XGshsFwf3uCSWynBg>
X-ME-Received: <xmr:WgDLZ2UAhyYyTtQ7YzW7UDy_rHn4YvuVjeWtlX-e7oJCaIaDA376hNiM-Y7CPzWaWQRnBZSif2KpraZBuY6jr6M4VBFnvGhEuPFYHN_sW8B8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WgDLZyhV1ekQ77-lFGJGE2mfaqExaDZdSX6hRGUgXIXS1lBtX3KtFg>
    <xmx:WgDLZ2D2eqfaYI7AAERniO_jNHErHyB1_CnOPDXsFpxDLmTQs2awIA>
    <xmx:WgDLZzLDG6qOuVc6I5elU257RjuyNL1oSCAiWmAqoIuGrL4KJpe5zA>
    <xmx:WgDLZ9CZ5h9B1xdDHDp2g9xOLDfRjYaL4OypzZAVMAZdwBlTjGsc-w>
    <xmx:WgDLZxOdslXjyHegDdeHFG-NEXzw2pY1xYFEWZXRo1ELivhPgdmUgjD8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c292c57c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:19:01 +0100
Subject: [PATCH v3 08/12] object-file-convert: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-8-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are multiple sites in "object-file-convert.c" where we use the
global `the_repository` variable, either explicitly or implicitly by
using `the_hash_algo`. All of these callsites are transitively called
from `convert_object_file()`, which indeed has no repo as input.

Refactor the function so that it receives a repository as a parameter
and pass it through to all internal functions to get rid of the
dependency. Remove the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/tag.c         |  2 +-
 commit.c              |  2 +-
 object-file-convert.c | 29 ++++++++++++++++-------------
 object-file-convert.h |  3 ++-
 object-file.c         |  7 ++++---
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d3e0943b734..7c173535cb3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -172,7 +172,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	if (compat) {
 		const struct git_hash_algo *algo = the_repository->hash_algo;
 
-		if (convert_object_file(&compat_buf, algo, compat,
+		if (convert_object_file(the_repository ,&compat_buf, algo, compat,
 					buffer->buf, buffer->len, OBJ_TAG, 1))
 			goto out;
 		if (sign_buffer(&compat_buf, &compat_sig, keyid))
diff --git a/commit.c b/commit.c
index 6efdb03997d..48aeefaad31 100644
--- a/commit.c
+++ b/commit.c
@@ -1380,7 +1380,7 @@ static int convert_commit_extra_headers(const struct commit_extra_header *orig,
 		struct commit_extra_header *new;
 		CALLOC_ARRAY(new, 1);
 		if (!strcmp(orig->key, "mergetag")) {
-			if (convert_object_file(&out, algo, compat,
+			if (convert_object_file(the_repository, &out, algo, compat,
 						orig->value, orig->len,
 						OBJ_TAG, 1)) {
 				free(new);
diff --git a/object-file-convert.c b/object-file-convert.c
index eba71955cf7..7ab875afe6c 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -63,7 +62,8 @@ static int decode_tree_entry_raw(struct object_id *oid, const char **path,
 	return 0;
 }
 
-static int convert_tree_object(struct strbuf *out,
+static int convert_tree_object(struct repository *repo,
+			       struct strbuf *out,
 			       const struct git_hash_algo *from,
 			       const struct git_hash_algo *to,
 			       const char *buffer, size_t size)
@@ -78,7 +78,7 @@ static int convert_tree_object(struct strbuf *out,
 		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
 					  end - p))
 			return error(_("failed to decode tree entry"));
-		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
+		if (repo_oid_to_algop(repo, &entry_oid, to, &mapped_oid))
 			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
 		strbuf_add(out, p, path - p);
 		strbuf_add(out, path, pathlen);
@@ -88,7 +88,8 @@ static int convert_tree_object(struct strbuf *out,
 	return 0;
 }
 
-static int convert_tag_object(struct strbuf *out,
+static int convert_tag_object(struct repository *repo,
+			      struct strbuf *out,
 			      const struct git_hash_algo *from,
 			      const struct git_hash_algo *to,
 			      const char *buffer, size_t size)
@@ -105,7 +106,7 @@ static int convert_tag_object(struct strbuf *out,
 		return error("bogus tag object");
 	if (parse_oid_hex_algop(buffer + 7, &oid, &p, from) < 0)
 		return error("bad tag object ID");
-	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+	if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
 		return error("unable to map tree %s in tag object",
 			     oid_to_hex(&oid));
 	size -= ((p + 1) - buffer);
@@ -139,7 +140,8 @@ static int convert_tag_object(struct strbuf *out,
 	return 0;
 }
 
-static int convert_commit_object(struct strbuf *out,
+static int convert_commit_object(struct repository *repo,
+				 struct strbuf *out,
 				 const struct git_hash_algo *from,
 				 const struct git_hash_algo *to,
 				 const char *buffer, size_t size)
@@ -165,7 +167,7 @@ static int convert_commit_object(struct strbuf *out,
 			    (p != eol))
 				return error(_("bad %s in commit"), "tree");
 
-			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+			if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
 				return error(_("unable to map %s %s in commit object"),
 					     "tree", oid_to_hex(&oid));
 			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
@@ -177,7 +179,7 @@ static int convert_commit_object(struct strbuf *out,
 			    (p != eol))
 				return error(_("bad %s in commit"), "parent");
 
-			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+			if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
 				return error(_("unable to map %s %s in commit object"),
 					     "parent", oid_to_hex(&oid));
 
@@ -202,7 +204,7 @@ static int convert_commit_object(struct strbuf *out,
 			}
 
 			/* Compute the new tag object */
-			if (convert_tag_object(&new_tag, from, to, tag.buf, tag.len)) {
+			if (convert_tag_object(repo, &new_tag, from, to, tag.buf, tag.len)) {
 				strbuf_release(&tag);
 				strbuf_release(&new_tag);
 				return -1;
@@ -241,7 +243,8 @@ static int convert_commit_object(struct strbuf *out,
 	return 0;
 }
 
-int convert_object_file(struct strbuf *outbuf,
+int convert_object_file(struct repository *repo,
+			struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
 			const void *buf, size_t len,
@@ -256,13 +259,13 @@ int convert_object_file(struct strbuf *outbuf,
 
 	switch (type) {
 	case OBJ_COMMIT:
-		ret = convert_commit_object(outbuf, from, to, buf, len);
+		ret = convert_commit_object(repo, outbuf, from, to, buf, len);
 		break;
 	case OBJ_TREE:
-		ret = convert_tree_object(outbuf, from, to, buf, len);
+		ret = convert_tree_object(repo, outbuf, from, to, buf, len);
 		break;
 	case OBJ_TAG:
-		ret = convert_tag_object(outbuf, from, to, buf, len);
+		ret = convert_tag_object(repo, outbuf, from, to, buf, len);
 		break;
 	default:
 		/* Not implemented yet, so fail. */
diff --git a/object-file-convert.h b/object-file-convert.h
index a4f802aa8ee..9b3cc5e533d 100644
--- a/object-file-convert.h
+++ b/object-file-convert.h
@@ -14,7 +14,8 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
  * Convert an object file from one hash algorithm to another algorithm.
  * Return -1 on failure, 0 on success.
  */
-int convert_object_file(struct strbuf *outbuf,
+int convert_object_file(struct repository *repo,
+			struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
 			const void *buf, size_t len,
diff --git a/object-file.c b/object-file.c
index b3e0276b2a4..b0e237a2acc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1793,7 +1793,7 @@ static int oid_object_info_convert(struct repository *r,
 		if (type == -1)
 			return -1;
 		if (type != OBJ_BLOB) {
-			ret = convert_object_file(&outbuf,
+			ret = convert_object_file(the_repository, &outbuf,
 						  the_hash_algo, input_algo,
 						  content, size, type, !do_die);
 			free(content);
@@ -2510,7 +2510,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 			hash_object_file(compat, buf, len, type, &compat_oid);
 		else {
 			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(&converted, algo, compat,
+			convert_object_file(the_repository, &converted, algo, compat,
 					    buf, len, type, 0);
 			hash_object_file(compat, converted.buf, converted.len,
 					 type, &compat_oid);
@@ -2550,7 +2550,8 @@ int write_object_file_literally(const void *buf, unsigned long len,
 					 &compat_oid);
 		else if (compat_type != -1) {
 			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(&converted, algo, compat,
+			convert_object_file(the_repository,
+					    &converted, algo, compat,
 					    buf, len, compat_type, 0);
 			hash_object_file(compat, converted.buf, converted.len,
 					 compat_type, &compat_oid);

-- 
2.49.0.rc1.455.g4cd33545ba.dirty

