Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEE2FF641
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727721; cv=none; b=D8G4+OpSYUqh0ci8gbV+1rwqMj39z6hBe4MHrRq6My/u2bzzoVMzodygU/metZjK2cH+JZPJ+TxTCVWbLb0t3TNLLC0mBO2PUetQSjxZGazlePErlwQgvnQ+jiPzQueK2396baputOjAdp1gkSDoDl8PipUIM3ZCLmvCWaNmmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727721; c=relaxed/simple;
	bh=vEQiEdFmgwha3CqPocJlDDXQiDN9AjJyLRLMVdd/dAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaMzScoQAQ6qPcnQUwvL6dE7g9tD5r2y13/qFZmAO0Du3yA8si9oZOtBpTs8rs5tJcPGEpmyjIxn3C0uu+GGknjnbLCAkb5y64VvQC1cH+s1lDXELv0tEHSezVlcTVAJ5ElhbSpSIKxzglQiUlTGSzTWkmbf4ODMVra7VUxOPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMgEwUbP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMgEwUbP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so44282125e9.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727718; x=1791332518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBo49VmDuD+AmUpdtgWekP4yOgXL8AU8JgXYYRJ1CQ4=;
        b=RMgEwUbP0LmwZKLxTHGkUr66++Zpr/SZH4q4hl1SR1UheOaYo0wnModUYPIroHx3BA
         /n/xFyp7BGv1QGSfQH40QjSnklMMMCxsXNlBXJm/orZ1zYR4jzbr8mSTbN5sfpXwJRFT
         u+rpNYJnENmkFKmxQi39AYPvDBkNNaKVH4K/IeHGio8c8oAKjKldEGH7wauJfe7fkn3Y
         JaKeNfpKuolnk3z07pulbPiifQ+9JPQFwiV9p3Iolax3F7YmL+EBAOL1hdhuF6Cxzlsr
         RsKjOgW7H5vSyF8EI2pm8xfyoC8AtZxOVeubR1xvwVmsl/RHOCMFhXZiSNP7qbv9o6Vi
         OlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727718; x=1791332518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBo49VmDuD+AmUpdtgWekP4yOgXL8AU8JgXYYRJ1CQ4=;
        b=tK0W6fWXJRdVnjS/xR/en+8gp//4qolRrVqR0U4Z9KhadmalsHz5lzmpTgoZ59+2Zf
         k8Dy5vdtnVKfHW6m1FYQ0zmwxTvszuIlUl5VQZ8slRJAbKCYxRhHn0e76NO7FnuecIAX
         jnqzl6iXnZToyMpgs5qqzEogwqgKlHZN0iYyU80u4bJNRpp21qxO7kXABVb41iZUBS6u
         e1dUN1hceYk04AJoYm7Dxnc3mWcfAuIM9mOdB4nvk2s3IvSnemLAiZliFCWTwMLURBQV
         mH2xCmLU092t1u53BK5c9Ah2kS6KnLbtsWJDzh3NohHikSC5Z0VbBI1z0rnphIqXBh/T
         1rVw==
X-Gm-Message-State: AFuF++nIfAYbA2Hw5+klomNOr4sEONaTbgDUXxKwsIkU1Ul+uiJjwqQf
	Q82mpFX5lgTuLTrHVo2QwQqamcwId25w+IJWIavDQPJLYxdu0KZvQcr/
X-Gm-Gg: AYBFou0gGHx2t7vkbwSMHV060ZnIT+YU1KrHpryPmygeApf+93O/AyoY+1z5Nb1T1+B
	z+apxR//KGAXzLNSlZxHTOIrpQ4+05qitekGnoLIja57g2q6OstOuTp0vRftiUAZMa03VS94HI0
	18VBw+ZUQ+RJqlgsGhssPrPG0r2ITRFEgaJsy8zeAdwcGKwBKFpjUpn+2g5mxverSq8vDHFs0o7
	HGXlYxsJcVlbdK3jNlcnQ/yVX4X8OGCWJt355MSOTZyGaH3Yc0FUtCTP9ZAjGxbHNogZ9sqldeP
	+4XFNqMCVONcN/F7IsAzDQjPW1nJtbW3r3ac9xQPfj40nRtONxFJc2F6HGbnuoRA5Wtbff3Fwcc
	i6wUcz8IrBqxnoXFIhF976Skft2/mVPoK90QnJ2wG4GZLbMhYeKvSgGxGLdEDDgK5P+9glKN4jP
	p18e00httZV5KQYyqchFteocfSng2iXxotnCSZ0djhLm4Hi03fbxYhUC6/JghNXzUFoPyyJcTH3
	OEF/hY1iDf6otgfaLS5VXktXCMxgpqmPqNMiRIb8zZhq6uD3kl4Akdf1ZwFAYVAWUF3GaiOZSCg
	aNJ5TvvVC6ZZ1uvm1GiCRsyGM+baojbHvd9Bsw2MnW8WR7s+cXEO/pnxt6+eyuZ+GqWNbdn9EOb
	ra/VxzxYbZkdDllYrqJJG7g==
X-Received: by 2002:a05:600c:3b28:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-4a01502f919mr11035785e9.11.1790727717748;
        Tue, 29 Sep 2026 17:21:57 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:57 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 30 Sep 2026 01:21:48 +0100
Subject: [PATCH RFC 3/5] fetch-object-info: return a status instead of
 dying
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-backfill-dryrun-v1-3-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

A subsequent commit needs fetch_object_info() not to die() when the
object-info capability is not enabled on the server, so that it can
fall back.

Make fetch_object_info() return FETCH_OBJECT_INFO_NOT_ENABLED instead
of die()'ing when the server does not advertise the object-info
capability, and propagate the status through the transport layer so
that callers of transport_fetch_object_info() can act on it. It is now
up to them whether to die() or fall back.

cat-file now dies by itself on FETCH_OBJECT_INFO_NOT_ENABLED, so its
behavior is unchanged.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c   |  4 ++++
 fetch-object-info.c  | 17 +++++++++--------
 fetch-object-info.h  | 18 +++++++++++-------
 transport-helper.c   |  6 +++---
 transport-internal.h |  8 ++++----
 transport.c          | 29 +++++++++++++++--------------
 transport.h          |  7 ++++---
 7 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8870a210ec..f4758f2203 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -726,6 +726,10 @@ static int get_remote_info(int argc,
 
 	retval = transport_fetch_object_info(gtransport, object_info_oids,
 					     results);
+
+	if (retval == FETCH_OBJECT_INFO_NOT_ENABLED)
+		die(_("object-info capability is not enabled on the server"));
+
 cleanup:
 	transport_disconnect(gtransport);
 	return retval;
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 0a58308f9b..7e4c922d27 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -52,13 +52,13 @@ static int parse_object_size(const char *s, size_t *res)
 	return 0;
 }
 
-void fetch_object_info(const enum protocol_version version,
-		       const struct string_list *server_options,
-		       const struct oid_array *oids,
-		       struct packet_reader *reader,
-		       struct fetch_object_info_results *results,
-		       const int stateless_rpc,
-		       const int fd_out)
+enum fetch_object_info_status fetch_object_info(const enum protocol_version version,
+						const struct string_list *server_options,
+						const struct oid_array *oids,
+						struct packet_reader *reader,
+						struct fetch_object_info_results *results,
+						const int stateless_rpc,
+						const int fd_out)
 {
 	unsigned ask_size = 0;
 	unsigned ask_type = 0;
@@ -72,7 +72,7 @@ void fetch_object_info(const enum protocol_version version,
 	switch (version) {
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
-			die(_("object-info capability is not enabled on the server"));
+			return FETCH_OBJECT_INFO_NOT_ENABLED;
 
 		if (results->wants_size &&
 		    server_supports_feature("object-info", "size", 0))
@@ -188,6 +188,7 @@ void fetch_object_info(const enum protocol_version version,
 		    (uintmax_t)oids->nr);
 
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+	return FETCH_OBJECT_INFO_OK;
 }
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 663a7f3ae7..9d2750bc93 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -32,14 +32,18 @@ struct oid_array;
  * the server both advertised and answered with. An array left NULL means the
  * attribute is not available.
  * Release them with free_fetch_object_info_results().
+ *
+ * Returns FETCH_OBJECT_INFO_NOT_ENABLED if the server does not advertise the
+ * object-info capability, FETCH_OBJECT_INFO_OK otherwise.
+ * die()'s on any other error.
  */
-void fetch_object_info(enum protocol_version version,
-		       const struct string_list *server_options,
-		       const struct oid_array *oids,
-		       struct packet_reader *reader,
-		       struct fetch_object_info_results *results,
-		       int stateless_rpc,
-		       int fd_out);
+enum fetch_object_info_status fetch_object_info(enum protocol_version version,
+						const struct string_list *server_options,
+						const struct oid_array *oids,
+						struct packet_reader *reader,
+						struct fetch_object_info_results *results,
+						int stateless_rpc,
+						int fd_out);
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results);
 
diff --git a/transport-helper.c b/transport-helper.c
index d5a064d386..855b53da59 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -786,9 +786,9 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
-static int fetch_object_info_helper(struct transport *transport,
-				    const struct oid_array *oids,
-				    struct fetch_object_info_results *results)
+static enum fetch_object_info_status fetch_object_info_helper(struct transport *transport,
+							      const struct oid_array *oids,
+							      struct fetch_object_info_results *results)
 {
 	get_helper(transport);
 	if (process_connect(transport, 0))
diff --git a/transport-internal.h b/transport-internal.h
index 626ceaae2b..067134081c 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -2,13 +2,13 @@
 #define TRANSPORT_INTERNAL_H
 
 #include "connect.h"
+#include "fetch-object-info.h"
 
 struct ref;
 struct transport;
 struct strvec;
 struct transport_ls_refs_options;
 struct oid_array;
-struct fetch_object_info_results;
 
 struct transport_vtable {
 	/**
@@ -53,9 +53,9 @@ struct transport_vtable {
 	 *
 	 * Uses object-info capability of v2 protocol.
 	 */
-	int (*fetch_object_info)(struct transport *transport,
-				 const struct oid_array *oids,
-				 struct fetch_object_info_results *results);
+	enum fetch_object_info_status (*fetch_object_info)(struct transport *transport,
+							   const struct oid_array *oids,
+							   struct fetch_object_info_results *results);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index 25e2c14a7b..561764cb6a 100644
--- a/transport.c
+++ b/transport.c
@@ -433,11 +433,11 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
-static int fetch_object_info_via_pack(struct transport *transport,
-				      const struct oid_array *oids,
-				      struct fetch_object_info_results *results)
+static enum fetch_object_info_status fetch_object_info_via_pack(struct transport *transport,
+								const struct oid_array *oids,
+								struct fetch_object_info_results *results)
 {
-	int ret = 0;
+	enum fetch_object_info_status ret = FETCH_OBJECT_INFO_OK;
 	struct git_transport_data *data = transport->data;
 	struct packet_reader reader;
 
@@ -450,26 +450,27 @@ static int fetch_object_info_via_pack(struct transport *transport,
 	data->version = discover_version(&reader);
 	transport->hash_algo = reader.hash_algo;
 
-	fetch_object_info(data->version,
-			  transport->server_options,
-			  oids,
-			  &reader,
-			  results,
-			  transport->stateless_rpc, data->fd[1]);
+	ret = fetch_object_info(data->version,
+				transport->server_options,
+				oids,
+				&reader,
+				results,
+				transport->stateless_rpc,
+				data->fd[1]);
 
 	close(data->fd[0]);
 	if (data->fd[1] >= 0)
 		close(data->fd[1]);
 	if (finish_connect(data->conn))
-		ret = -1;
+		ret = FETCH_OBJECT_INFO_ERR;
 	data->conn = NULL;
 
 	return ret;
 }
 
-int transport_fetch_object_info(struct transport *transport,
-				const struct oid_array *oids,
-				struct fetch_object_info_results *results)
+enum fetch_object_info_status transport_fetch_object_info(struct transport *transport,
+							  const struct oid_array *oids,
+							  struct fetch_object_info_results *results)
 {
 	if (!transport->vtable->fetch_object_info)
 		die(_("remote does not support object-info"));
diff --git a/transport.h b/transport.h
index 39193d0077..c1671639d6 100644
--- a/transport.h
+++ b/transport.h
@@ -1,6 +1,7 @@
 #ifndef TRANSPORT_H
 #define TRANSPORT_H
 
+#include "fetch-object-info.h"
 #include "run-command.h"
 #include "remote.h"
 #include "list-objects-filter-options.h"
@@ -314,9 +315,9 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 /*
  * Fetch the object info from remote
  */
-int transport_fetch_object_info(struct transport *transport,
-				const struct oid_array *oids,
-				struct fetch_object_info_results *results);
+enum fetch_object_info_status transport_fetch_object_info(struct transport *transport,
+							  const struct oid_array *oids,
+							  struct fetch_object_info_results *results);
 
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe

-- 
2.54.0

