Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A51D9A50
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590820; cv=none; b=KVy8Muz7BvIDnDQwru3FA0QhoOWVLXO7iDzSJiQpzhhhJRqALZn43IBRvLPCcM7k9BemmDYtWjh0M4Y/pig3glTuqi6d1ntXRwGGrhtps9PNYG+wIiEs3iMbITfSBGPRt1+DsqLAM70ZEdVWYiMEcEMoeYZB3H0ueh8ToAE3WRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590820; c=relaxed/simple;
	bh=d8b7Bzs/NfmorixL/Rk68wqPV4+s6+8iOOchSDgavuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRWC0aPJ/vkLbpSBOksTXbAvz4a026ho+c8qW1PQ0NvM3AjlHaYe+lUDUKxECQFRL+CLGkJLfpEk2BwLMqRN636GtIS7+FdP01ePKq/0lBPAENDuHgVNa4Z9KWNiVzoXDnP1nlhv1NSuTcoHAE2xp56SV2KkP/TUr0O5e4BjlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wd9ZkuPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4e/w3pO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wd9ZkuPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4e/w3pO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2B0E2540137;
	Mon, 10 Mar 2025 03:13:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 03:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590817;
	 x=1741677217; bh=er5VNE4MwJeSYQ3kvnqv2V+NHWCOiX0C4nuYTfZ7rMg=; b=
	Wd9ZkuPgbqpWkiGL3h65fb2SiY9N5/9PGZU1Mjtks+OgbYKAhDBqS7hYC8zPFnjB
	NiZScVMly0oy5Nqk1iKitIv1ZX6wtLHlR0phTjkvPsN0e4xm2thYA5a5QAPxRWPD
	07iPNbWrHGPkk38m5Sp/VIROQ6v0x4HNkAofyRU5abARboLtLIr2GOLrIPe42blX
	FCEFQNnykvz2L2O9DWqwWMJ2mR3533V8bBBxcSMokWLPikepAvKXTj4O+nxdwqtW
	EV0RSsi0J5VcOzY3wtjKD27Kjp/0/XIOhcOY/JfH0wr2DTac2VHxkG40oY0YiEpH
	uGBAI3PVi6jSUq/5saTaVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590817; x=
	1741677217; bh=er5VNE4MwJeSYQ3kvnqv2V+NHWCOiX0C4nuYTfZ7rMg=; b=h
	4e/w3pOvF2DgMxEr+CAkilIUpoFlvi6+tJ6G6jEsWKNflvLQT6xJgGC8aRFcEpk8
	LREfy/nH/J9qSreknc4m53B12NXUopWk2tM1yfUktWj2mp/HHaTLFc8I5Wt0MWDG
	7caZPfdMn3G5dEdEO8k2aoiD7zDHeUHI0QtpzuAaaG/9Vo+4YqTzDQdr5vkUXHW5
	c0jMy1G+8iZ3D3Ykbmb1XrN9NxOJK0nsaA+UMTcSITSmijrQQ5T43nZZBJWMYQqG
	M8+XJsOFN0m/pECZtYZRo2ucir5r8uq9TgoXMT371BYT6jTNFfIM2P2E/nSwGz8S
	AXiSJbIu/ECMeLor+4qOQ==
X-ME-Sender: <xms:IZHOZ3-eTh_oGbOXdIAj6i_vHx8nk0GNYX8aMpmbg6q491dpH57WSA>
    <xme:IZHOZzuy6X0T4AI83tK5ttfYNmKa1fDB4Lws68jRPAQt3WC3KJAIl73DEY_RyLHpd
    sney-q5_OJ80i_y5A>
X-ME-Received: <xmr:IZHOZ1A9ZgL1v0USJVpxAHr8puYMOAk3WqC8GptlWH8nqmiJ8qST7Zbql3BM0tzS-c8k0PaMc8SKoRn2EwEycGX6xSEgVcNNHMTKa-JYAZUDDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IZHOZzdnQQsTPx-p7hLmmmLrx15z4S0hRrLeKuVQhxcyVOFLkLi1RQ>
    <xmx:IZHOZ8MgjKJYJ6Nhk--OYlZ74TQ8DfHd1luE1M7fP2tx8AAkwOl0SQ>
    <xmx:IZHOZ1nBw-lWSQCpSHM1uWr1qnerILeX2pB4EDonOdxrKoLp4cYOng>
    <xmx:IZHOZ2vauEY5sRsHFGW22u8bLGYq1bosklLW5HGxkAWgIHK4WcuQEg>
    <xmx:IZHOZ5or5UhijOg7X3UAS-BsGmEH7BJoQIqwMIycWGS9-oyPmsLvgpPs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 273bb687 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:27 +0100
Subject: [PATCH v4 08/12] object-file-convert: stop depending on
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-8-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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

