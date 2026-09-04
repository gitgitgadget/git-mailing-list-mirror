Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64D471263
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518194; cv=none; b=iLODEddXKljBg0WZ1xU08skKlm3UCe+4fyGqLtOVGtdO0N81oEAptjSorsFUYSi1NErNzGclntxNaIRWI3m/EXD3l2kC+Tvpfsaxbk3txSaYBAPms6dDLOm2debiDmW+oV1Sg78/uoK9trk5svlXpQsSazgNRi4Caoa3Ump3cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518194; c=relaxed/simple;
	bh=kZ6PP6N1H8nb0acl7atQoFUzOVn63MLRLrfCe2ThUcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHuxbMv+5+cNfnjQW50k3ZrgjbwsKhOnGmPfI0jYOz2TmMJZDact9v0iuRP+NqRZpDItaxFqamKDBI5YQMsfvndz4bQFPsqsbEZDIySyuEyoHS+di+DRXwdW0uN6NPDrWjv2dh/LGz/EY0jpek3Y6rrp/27trzqRU4ogWKoqcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tAYxZ2eE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiMNnsry; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tAYxZ2eE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiMNnsry"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DFB631D00128;
	Fri,  4 Sep 2026 06:36:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 06:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518191;
	 x=1788604591; bh=XEQX/m5B6XKnv+PVMhyZq8Ehs+q+GxEQta/Sxj7hBoY=; b=
	tAYxZ2eERcX4KdKKqmcaT91ufBAUw81MQKm7gVHvEcNbBdF9F2gGi54w/6l/su2T
	6RvoOUPh2/VHksdkRzJaDVyjnVU4o+5ZNRbSRXOJBrg4F/L9GXJHBsgVZgCTdWqB
	PQ+t2qx6qTXx3bcIP1KSOqppDuhqsxv3E8gAg4R1rTz7esaWJnkSX43yZK+2DpaL
	lA4BqbDUMAFxhPrJl1ucrG5/yrxe7ou9vtkrdkMhXOehgt6oUB0JaQcRJU7iW6kP
	LDkJhhWjxOiJWtWpT5C8pAOVseob8NcsXfJfxYHKZb4Fm6JXM2Vg80/3M8WRvmYa
	OUjn2Q1btP8O72/muA0cfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518191; x=
	1788604591; bh=XEQX/m5B6XKnv+PVMhyZq8Ehs+q+GxEQta/Sxj7hBoY=; b=H
	iMNnsryJCO8Dv3M1RzGN2WyhWj1zKA87WcrV8/+YLYLcTtHKKI69YjkaFYywtHlE
	i5IFiCi7xgyTe4mrpLbwMXI/inxwIo7UlzaiFgalK4Dlf/NDKwNLOoOZmSrKTjXL
	86dynnJvdyr67PhKab/LdUWGrTvIgq2nUBAuxZTQ8OSR+PZ+VEiJCkSROzzg2Og6
	UhMuqdw3XIIwDZGdyLY1A39lHAvciWkHTUYb7wjipNu5jT4zYymOVE/XCkrkYjoO
	2TBVe+Pjiu0ClhduvF/PhgYzxDPvlxo4gSqD1VR2xq+/9Eo9YrTAn/D8Fpw/+usX
	0/W0281UDdAXmUct6ECRg==
X-ME-Sender: <xms:L5-aai5sKRaa5t14SQFdqK5mFCObawB_E-Ajd5zRGM_8oFPzxCm_LQ>
    <xme:L5-aah4D0B1-MD9R3X1sgWrDA3-vgzzZlNBdI7YZvphB3RnruZkAJxnxursBMFgMV
    LA_9PQ_sVxMCTHndphEDDMuoSPd5ZblxiIewOPo6RkJD_DRG_p9ePI>
X-ME-Received: <xmr:L5-aavE9T6wh56uIwEuGO7PkRJh4Lc5_Mh7cPcH70CSJH3gTclTdVZzTr8oR2NKeFRSrFQ>
X-ME-Proxy-Cause: dmFkZTFYpI5YUAbKMCQ+FaxAfKa/jnPu5n1MN1s6kO/J6Q/EKj1wq5/lsr8TBXj7slJ18D
    3eLwMp37HCXBTCm0UrW0C4TmuYb9jCyPuoQgpSOWobGPz7vG6D/Zeg+nS5DLTCR7clwVuM
    oPpyBj1/qDGQlVmano3Yy4uGDCBQazXdQrePlKQtuIl8QmMexYdwJOsUFtk/8x5hYY/xw4
    r4nkuKDSOmBtjI6Rzj4/vzVc0hK/sd5Eirfe4sAruy7bVekZVr6SFT2EIjGD4hJ0ZhK2zu
    +2r+nN1UgJHwVr5ToQNixVeEanjJttxJOn1rUVCYb2T9JS2UCAlk+sZGd5wmcFx0zbMzJS
    1d7RgawvliTl3ErOtklnASsbjtkp5X0I8snbpO3g57P3kAr/yaoW9d1COP1HeO1nMfug2H
    ZX7Y5RwjKdTIEKoOussBQm7xc38+GNRhpQ+ycEt956kLdaKm5SYqpQ66fOU9SvXTfNRE0i
    9uAXzvtBJ27pX62xJbLipNp9muCa2PuDt95wEVS8o7UJh4iWGAyzRGo/dzIL3aszvI7fel
    7LHtZEbxOy9RgrOKj37/HZRZFgJVOVEFpobCly0fRv3uKYt75ZOU2I+4k2lCqAQo3qhxz5
    7aO8lPfOvR3F83/0lkvVUjz01K/QQrF3JkfRt14cV847PRWDUYb9aatKptjA
X-ME-Proxy: <xmx:L5-aaqQuas_L3LvM1__bEr_WCW3-1NEFl6omVvSCGa665EK-U2fA1Q>
    <xmx:L5-aaouxE9eO5bwWMgymjFuZ-_C6t-iWwm02KKPYuY77phlL3QbWrQ>
    <xmx:L5-aapxloRjvnf5QPonelNMLzAqjGY5g9bb6VbNSHKt0aCsaNFl78w>
    <xmx:L5-aai4eZ03G4O7v5Mm7G6NfRt88m9Vs7IPhV_1BROP7ibccwF4rVQ>
    <xmx:L5-aagr6drl81kpr-YJerDYGq8QY_uSgViEUUx5Ti6poaSws5ku82HdB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0b0611c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:08 +0200
Subject: [PATCH 07/11] refs: expose function to parse reference URIs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-7-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the next commit we're about to add more sites that want to parse a
reference backends URI into a format and payload. Expose a new function
`ref_storage_format_by_uri()` that enables this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c  | 23 +++++++++++++++++++++++
 refs.h  |  4 ++++
 setup.c | 48 ++++++++++++------------------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/refs.c b/refs.c
index 92d5df5b71..951db56113 100644
--- a/refs.c
+++ b/refs.c
@@ -54,6 +54,29 @@ enum ref_storage_format ref_storage_format_by_name(const char *name)
 	return REF_STORAGE_FORMAT_UNKNOWN;
 }
 
+enum ref_storage_format ref_storage_format_by_uri(const char *uri,
+						  char **payload)
+{
+	enum ref_storage_format format;
+	const char *schema_end;
+	char *name;
+
+	schema_end = strstr(uri, "://");
+	if (!schema_end) {
+		name = xstrdup(uri);
+		if (payload)
+			*payload = NULL;
+	} else {
+		name = xstrndup(uri, schema_end - uri);
+		if (payload)
+			*payload = xstrdup(schema_end + 3);
+	}
+
+	format = ref_storage_format_by_name(name);
+	free(name);
+	return format;
+}
+
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format)
 {
 	const struct ref_storage_be *be = find_ref_storage_backend(ref_storage_format);
diff --git a/refs.h b/refs.h
index 9979446d15..ee3b8a62ef 100644
--- a/refs.h
+++ b/refs.h
@@ -17,6 +17,10 @@ struct worktree;
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
 
+/* Parse a reference storage URI in the format "<format>[://<payload>]". */
+enum ref_storage_format ref_storage_format_by_uri(const char *uri,
+						  char **payload);
+
 enum ref_transaction_error {
 	/* Default error code */
 	REF_TRANSACTION_ERROR_GENERIC = -1,
diff --git a/setup.c b/setup.c
index dfe05d9a03..3be7dac452 100644
--- a/setup.c
+++ b/setup.c
@@ -632,21 +632,6 @@ static enum extension_result handle_extension_v0(const char *var,
 		return EXTENSION_UNKNOWN;
 }
 
-static void parse_reference_uri(const char *value, char **format,
-				char **payload)
-{
-	const char *schema_end;
-
-	schema_end = strstr(value, "://");
-	if (!schema_end) {
-		*format = xstrdup(value);
-		*payload = NULL;
-	} else {
-		*format = xstrndup(value, schema_end - value);
-		*payload = xstrdup_or_null(schema_end + 3);
-	}
-}
-
 /*
  * Record any new extensions in this function.
  */
@@ -689,16 +674,13 @@ static enum extension_result handle_extension(const char *var,
 		return EXTENSION_OK;
 	} else if (!strcmp(ext, "refstorage")) {
 		unsigned int format;
-		char *format_str;
 
 		if (!value)
 			return config_error_nonbool(var);
 
-		parse_reference_uri(value, &format_str,
-				    &data->ref_storage_payload);
-
-		format = ref_storage_format_by_name(format_str);
-		free(format_str);
+		FREE_AND_NULL(data->ref_storage_payload);
+		format = ref_storage_format_by_uri(value,
+						   &data->ref_storage_payload);
 
 		if (format == REF_STORAGE_FORMAT_UNKNOWN)
 			return error(_("invalid value for '%s': '%s'"),
@@ -2069,16 +2051,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			 */
 			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
 			if (ref_backend_uri) {
-				char *format;
-
-				free(discovery.format.ref_storage_payload);
-
-				parse_reference_uri(ref_backend_uri, &format, &discovery.format.ref_storage_payload);
-				discovery.format.ref_storage_format = ref_storage_format_by_name(format);
+				FREE_AND_NULL(discovery.format.ref_storage_payload);
+				discovery.format.ref_storage_format =
+					ref_storage_format_by_uri(ref_backend_uri,
+								  &discovery.format.ref_storage_payload);
 				if (discovery.format.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-					die(_("unknown ref storage format: '%s'"), format);
-
-				free(format);
+					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 			}
 
 			if (apply_repository_format(repo, &discovery.format,
@@ -2806,18 +2784,16 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 
 	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
 	if (ref_backend_uri) {
-		char *backend, *payload;
 		enum ref_storage_format format;
+		char *payload;
 
-		parse_reference_uri(ref_backend_uri, &backend, &payload);
-		format = ref_storage_format_by_name(backend);
+		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
 		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format: '%s'"), backend);
+			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 
 		repo_fmt->ref_storage_format = format;
+		free(repo_fmt->ref_storage_payload);
 		repo_fmt->ref_storage_payload = payload;
-
-		free(backend);
 	}
 }
 

-- 
2.55.0.1007.g17ff1f9808.dirty

