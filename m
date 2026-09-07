Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38441835B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811201; cv=none; b=d+uO3c2YDNZHbQ+4aMjJZ91q9Wkw/JJfmujC7IIB49zVYoblPGc3pjbZoN7H/2ZQEcetmND63aJeqz6hCkkjrZ6FKbkkGOHjIXOezGRtSoYinxqFolLDw6E4ZMrKvKHBNsh0iviNcIwNKixez2fUKsxwrNF9m8Ynkn7f6Qk/Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811201; c=relaxed/simple;
	bh=CU5LKe7T1wFCrFMmEuwrs7VeAdAb1p0c/ER0lUnAmj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZK/dDkE6hQWPGL68ZZ73npsEmNAMqwPgsn+rPGL+T2TJn5XPw8ISx5ZhcXHAJiqTVl/KXFTHMcT1bf0NitkenEu1REeHyzss21QTUAcbjm/5UuV0zvah2wKvl0Fb3KbrGEtPGfzX1kFWuD8w8Z3ZQTaVpZ/rhfHRnuxglFhE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N6sP41TC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N6sP41TC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=CU5LKe7T1wFCrFMmEuwrs7VeAdAb1p0c/ER0lUnAmj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=N6sP41TCkyIP/qZvgRFB/YVZnkPyY0F1JklySiy3CibnUwaRnFyZ4Au/kp9n2pyXZ
	 mR4HOvPpJFanwkomLZrU1mezEbfdHgIxSri5h97D0buz+l9899ENfvsAXQggQe0JPS
	 R9aFdO5SgpS+XZnY5mtZJiah5L2g6Q6W9f/b583G3M4cQw1v0mNAzFs+EmqvHbyFsi
	 waOP+pONNxotL0ZfX/Xb3UnySnFjcd75kvbTVucTcA4lJgSIQylpWqfIX0DiOMzIM3
	 eol15G1k6kzQXtLeNf4kGvLGZJDzQjFH0OtwuGC1Zhf/7Vdn/VnBlL00mfCOUWSlFf
	 ncU8CsXUCMKPcynYAi0MDkb47QxrmWok4UkV2UmvI1S3ZOro1OcIxZGQDylkuqTqy9
	 znZfrmWV8btScRlDnYEV61RXPrMrcl88+Vr9y/Wq1xQsaMISN8kmzfCRSf12HCR6r9
	 FYoA9nU5lBn/JsQBa9cXzyPrnomdBCz6EwhBMV7Q/To/gqyvxEK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 31DAD201EC;
	Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/7] hex: label usages of hex parsing for object IDs
Date: Mon,  7 Sep 2026 19:59:37 +0000
Message-ID: <20260907195941.1024289-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for a future change, label the hex parsing we're doing
for object IDs by defining a constant called HEX_KIND_OID.  This is
currently the same as HEX_KIND_MIXED, so there is no functional change
here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diagnose.c    | 2 +-
 hex-ll.h      | 2 ++
 hex.c         | 2 +-
 http-push.c   | 4 ++--
 notes.c       | 2 +-
 object-file.c | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/diagnose.c b/diagnose.c
index fc11cea229..9c652d36a6 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -112,7 +112,7 @@ static void loose_objs_stats(struct strbuf *buf, const char *path)
 	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
 		if (get_dtype(e, &count_path, 0) == DT_DIR &&
 		    strlen(e->d_name) == 2 &&
-		    !hex_to_bytes(&c, e->d_name, 1, HEX_KIND_MIXED)) {
+		    !hex_to_bytes(&c, e->d_name, 1, HEX_KIND_OID)) {
 			strbuf_setlen(&count_path, base_path_len);
 			strbuf_addf(&count_path, "%s/", e->d_name);
 			total += (count = count_files(&count_path));
diff --git a/hex-ll.h b/hex-ll.h
index fe698f0c76..9da76f17e8 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -6,6 +6,8 @@ enum hexkind {
 	HEX_KIND_LOWER = 1,
 };
 
+#define HEX_KIND_OID HEX_KIND_MIXED
+
 extern const signed char hexval_table[256];
 extern const signed char hexval_lc_table[256];
 static inline unsigned int hexval(unsigned char c, enum hexkind kind)
diff --git a/hex.c b/hex.c
index 6150bdcbf8..4e1e81af3f 100644
--- a/hex.c
+++ b/hex.c
@@ -9,7 +9,7 @@ static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
 	for (size_t i = 0; i < algop->rawsz; i++) {
-		int val = hex2chr(hex, HEX_KIND_MIXED);
+		int val = hex2chr(hex, HEX_KIND_OID);
 		if (val < 0)
 			return -1;
 		*hash++ = val;
diff --git a/http-push.c b/http-push.c
index b5c5bad3db..43b4b61c70 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1031,13 +1031,13 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 	if (strlen(path) != the_hash_algo->hexsz + 1)
 		return -1;
 
-	if (hex_to_bytes(oid->hash, path, 1, HEX_KIND_MIXED))
+	if (hex_to_bytes(oid->hash, path, 1, HEX_KIND_OID))
 		return -1;
 	path += 2;
 	path++; /* skip '/' */
 
 	return hex_to_bytes(oid->hash + 1, path, the_hash_algo->rawsz - 1,
-			    HEX_KIND_MIXED);
+			    HEX_KIND_OID);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
diff --git a/notes.c b/notes.c
index 99b8b15d81..7e9e3eb2d2 100644
--- a/notes.c
+++ b/notes.c
@@ -443,7 +443,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				goto handle_non_note;
 
 			if (hex_to_bytes(object_oid.hash + len++, entry.path, 1,
-					 HEX_KIND_MIXED))
+					 HEX_KIND_OID))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			/*
diff --git a/object-file.c b/object-file.c
index 892be4bbb2..c4bb3263cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1079,7 +1079,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_add(path, de->d_name, namelen);
 		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  algop->rawsz - 1, HEX_KIND_MIXED)) {
+				  algop->rawsz - 1, HEX_KIND_OID)) {
 			oid_set_algo(&oid, algop);
 			memset(oid.hash + algop->rawsz, 0,
 			       GIT_MAX_RAWSZ - algop->rawsz);
