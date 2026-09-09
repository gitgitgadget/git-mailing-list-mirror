Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07F534476
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952401; cv=none; b=hfUM0b8jvxDWK/uw4sqF8BZulkcfxLxySuk1VHUCmiDV2JrWw6pMzhmakGn/phaEoDofNMAJGMc+pTDjPFw+6b5PFB7oReZx9sKVTT5swOwFdqccZcy7HCKek/rzxNMKk0xgJ11M3TrV+Z7C22Q3YxSwWC5BKl9g0VhgMc5GhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952401; c=relaxed/simple;
	bh=FmRrAW03iknEuUm1yOwuJmz7BP3f4O1d98mWJKVry3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6jXY9MGpbtzTWv5hkFAXz8g79ZxWM+gK0HkjHGxT6Qe65IjJgw8Paal3ubd5LEWq6JBr8lrO8G9qu3jRcEM6OESyPpSHZ+CyVXeN7DVps75GGncvOZvHrgsSxtLaAPf8XbuYSUv0fKMatevdM4BPTIDZPwDRyrb6Mnsn/c/xLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tb3gf7TO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q0wIrkO5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tb3gf7TO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q0wIrkO5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BF497EC008B;
	Wed,  9 Sep 2026 07:13:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Sep 2026 07:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952395;
	 x=1789038795; bh=B8ddc6J63vyYE+PCDu0OnS4GpmitHceLsWFopuxHdho=; b=
	tb3gf7TOOHn4izi1GKk5/4Q4rFtD5IsqKBXaomCtxjj1PMQZGrWc6vHnlccUELBm
	niSIDZo2WlE97a24WKhOrKuIaD/HjsAwkatvCqNvEq5CMo/FiHZj/8Nfsaa8hH+2
	RX8tixwR83k3cucHNlzldAiqpIfFj8R8RCiYmlwSh4rZOqNpu9dhLX8jOCouX7oo
	4/jp70XOOio2s9E2PV5fYgjZr2TAk0zXkggAsquUoojCqQImDC/4HW2sz/fzTnAK
	zXShIScjwv2iY8d4USk5iTUNJg3t8zjjm22REQlr2YJTeq4EYVsJfOJJi+KzwHaD
	kcbkqA5+IiixAGhXLkmNTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952395; x=
	1789038795; bh=B8ddc6J63vyYE+PCDu0OnS4GpmitHceLsWFopuxHdho=; b=q
	0wIrkO5cs60uEOh6fGaUHPAJ3hCopycsyZYrb2C35EmmYxCWbHjCQLB4WSSOA2lh
	wQ2yCmXj/ys+uNHH8DtXC1/lzc08LFb1Im7s3WDQs9PmfHG/O51qpmKAST5hollc
	cxbwdJbFLIRkbKHwIpKCgLR4q+ocYMmrQSUYWZecnuqw05e5JQBORg3LR1yf0WvO
	xYWdrFt9EGdTbjuuxIq45YzfW9skJFjx2PB8NXVmy0tYA3OXCw0729PhymnZRGCF
	9EzwJH28XEK66Mf5yP+9/Mwaa0VfPIBJwDiO7jNn53g/Y/dpUbddcmAhG7wS8R9W
	FZ6rLaxxaVWYn+qqqLlxg==
X-ME-Sender: <xms:Sz-hahkcVCBYhAvX1_-etsi40O2BBYu9rcprTvAZO8OmKHJx-03_2g>
    <xme:Sz-haj0tSU3ioqOl5nXHWhCo9Iy9AW1Cr5iSWHomUhRp3gGSN2Pcs35MBg1t7rLTL
    fRzO8HTPtTO6B4hRy5nJLFaszMQv4rTAYCl1LCYqfanO60g7Zsm1yg>
X-ME-Received: <xmr:Sz-hasoe865lX5wKGOCAEoX60n38vkcUI3WHHBmjLmVSimxj8IMK1sEV2VSpw5_gFni4cQ>
X-ME-Proxy-Cause: dmFkZTFuFX1vLSfOhguMqgbeiHmMoSXDksUKaTRjHLF/iepXHafa1k3i5rIj14VU4bzdiO
    aCrO+oRf0RYLNdIlQPoaktwWVBI1vx3oSaQyMvmD9SIBrrrHXYBCqSSfDb3ECUFyr1QSav
    MRGuMhAd5eveedIjKB4xByEE6TkyWRfH9GzHvHrt/TgHV6OlHMdBOhXuhBryl0MpuqMmf4
    Fb7HwmUuAoTCX4gJlwF2KBvDbHqvYxtvEDl6kH5Ewj0bhglOOjMPqNhTDrqnE1n/7tBssC
    00DxzIePos30Tg4ZsojTsexxOS5iUz7ZLudWY/EYqDpRkpMn1fwAsVL8ozD5bqcvmUbiny
    OLdrQDQbqQcSSwCd7bWYhtPvjap6SbgyLWutmOiCreXWPNVPugPWwQcBhf+1KiI6mygQRY
    MFYFWHAHPGXLTbUtEeO9DFZz6oDwpYY355SIOAUwwWDvoqtOSpiz0TvOccJ9ocPPctGlSL
    4/jvV6KdmKuIskblcnoQ8748pgaTlN7yNUI9S/hhMZJRkIiybT+NprahvNl9gxTLui/W6d
    OOlqCJktqGZiclma/tvjRcxah/TDxttbIPcNNlWv+371so+kqQp+m1b0NPCUuZ65nUCi9y
    3JEkLX0U1qlI9nX0nBv+kxyQJepva4SV+OffvjIbOI3RasnOPzdH1xKWaNdA
X-ME-Proxy: <xmx:Sz-hagemhVIt77EH5c7VC6wWhzoENMOEaU3HIDI1TEDMMdvdJI4XLQ>
    <xmx:Sz-harowxwPxxqSN7PRKI8nDZXV6e5grfYj3EskjctaqVgwEbvKlIw>
    <xmx:Sz-hahEppRdN2KqvcQaCp4QqOJAQPPeKM0wjOkUbJ8S6UflM5FlV0g>
    <xmx:Sz-harvVzpVQTV7Ssw-v4F4M1ZkKJbYgai04BMQvX3nmALbn3ieWYg>
    <xmx:Sz-haoLlGlzL6XiUUqsHRUk9wvX367BjJwpykt-w7pQCjy7JBu7O8aL_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e404ac5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:54 +0200
Subject: [PATCH v3 08/13] refs: expose function to parse reference URIs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-8-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

