Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A46EF89
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780033; cv=none; b=UOT291VxauF15kMWTeONSMHQreSIf8+MjG+D7oCE2DIF04FtWHdhwM1W38H5PNNYAYm5CEwVyY5qed5UX+ZTURWbrgndveueB5hB5uxyQozbe5JVZ5sUz6IKxaabrKP4r29PXP0abgXcLWxE9J7G3xSUzxLAVvDRUQGvotNZK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780033; c=relaxed/simple;
	bh=kZ6PP6N1H8nb0acl7atQoFUzOVn63MLRLrfCe2ThUcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JF5m9SQEgOKOMZstJDT36KwKfFlvsKxfdxbZxovaufpYAXnzypDCbkcQxuR/1uuSG6wRkvwewIkjGRFsez0dEcHIfwYYk951cObC3hiDdVnhe8NOgB57ihPc9jJvekSxtGlq//1pvJAHXyqnAajUMVhhT0+ghpXfqaaPTGSQZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=in8fFXfn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXdtXLRP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="in8fFXfn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXdtXLRP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 98A54EC0232;
	Mon,  7 Sep 2026 07:20:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 07:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780028;
	 x=1788866428; bh=XEQX/m5B6XKnv+PVMhyZq8Ehs+q+GxEQta/Sxj7hBoY=; b=
	in8fFXfnO79ilv4IfjMW4+mPzj3EbzS8j/nTFdd5kkGz+2vyKy2dzXLOI5InOwsl
	JDPGqmPPdF2HEj/EXBTRFZGGHiRHgDNiI/dMTyM2QKcF63fhAOYDC68zalALY01V
	depyqhsrUUMHU7EOhbSvH5GMtpFHb7RwDaGKLbrUhW/y6seqSCoOquwIcNNwS4w4
	FEsuYXH+IE8/WICUes/Qvi9Y1+iAf2v7eoV4iI71LWw7Ym4c+R5tO0YJ8kIDvmB4
	cgkyjyeXJA6gXO9ZItmaW+iDk7qmaaCoeaFZ17HYvLbSrkuDmxQvpyJnxvhwazPw
	g/rLhwv8k7CSPZkJRZs66g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780028; x=
	1788866428; bh=XEQX/m5B6XKnv+PVMhyZq8Ehs+q+GxEQta/Sxj7hBoY=; b=B
	XdtXLRPD4PnjbSFbbPExoFL8jeDpeSdq2gNZOEPhqAmQtHUmUaN5UcRHbkQNev9/
	TsZ9ocbiG0g1toI72n/taKaZeVBPuJgbhOeNZ4Ffc/XfMh3GcMTddAuykyG1egRB
	whypW8CzR/3n7puyRPo3s7nJ6+bgfNdBgLZAsOG82G5tBRRdSQNUKEROZZU0RyrC
	3AmMeKr0mgfpiTWWDlZhcOAxWBS8TnFOV0979FcMQhM4oBrY5kRZekXSJHiNtaBZ
	JsvXXhnnNLwonWRNwRlDIfH8vNq2JVre5TSmNc4Foznh5fke1B3PUaVvjylFgD6E
	dFLxY/NTstNEo5iyHWkuQ==
X-ME-Sender: <xms:_J2eahCzfgI6judFF3hJ3JJ7w7eyQMnI2V6lKvxp6ZIhSmPdOHifsA>
    <xme:_J2eam-VZIlfdiPZF5_Ed0zsEtewqZEFKph9Wtm9l8H4RCuJXsagA8i30DmjPsJsy
    agHoYa4ZX7TN_6fm9KjEDLbaVUywhanSoIM6Km_MhzzOdcYHVH22Q>
X-ME-Received: <xmr:_J2eap9i5xZrGFPlGL2fv0X-Jzwc6pcC5zW__TyAxvA_2ZV2nmFw7A>
X-ME-Proxy-Cause: dmFkZTEAK+4goiDsG2Vmg+ED1KAmsv7YZp0N0BHxTCS367xRZk9Ys2RQ/ypkGiDHqXjXk8
    IfrsYpJC3kgu7tNLAHxpka6Q/g7Eq0NVfpnpxbBJ8jMyt48JqLOwADlJurbyrlCDydgb14
    Pc2Q6dpryZTbKJYnot3lpl/+Xggy8TcjlVWbkPP4ag/plZtkk6Kh6FtYGlp4J8DigPGi8+
    EhLNMEFOUUgA3DyHvEnEscg6zIFIBIBK7rK46EVuSYQqJYGNq9QZe/aqk4+h7rZPKK6qtX
    thLFXKQ1zQP83Z0RgtpsAxzn2SVh3M7w4DDwdIkvutBxMEdllU4lofdPVzGM+UuAN5OHoS
    /1coEex2assFD0dlxrW7SinTWvQn0ddCWlQCnCrr6NxUFU/JSqvlfB6c4z9F6ptVaqD4D4
    8rjXLO+0A3iXwKcF93us8cODeiG9+a6OHwp1iPDYho9Zy0i7mP4uC46bJdRGlg9Bii0qp1
    lEvSksbPOs6zx5A+2Fk84bArAArOGcD/10kXv+ihDgte3+HnrfpsGUxIHK5iiNeyAV1Hon
    eZ3VoJ6QdtVFMj5D7g9mTW4a5/xhsLcC+dH5AQa77+/jVrTLZj/chNCzPfBxrAfS/ruI5g
    mNej9Jy6J4Ft0ozvZLlycGDo8HNb/3SbU44kJqECMRJXs8PUb0CgMTN286kg
X-ME-Proxy: <xmx:_J2ealdbflj5Vw3pqS0U-b2zfAoSIxU-IhfckkTdiJnRxZWxWpuoBw>
    <xmx:_J2eaqGJckTWixn9yzRah2Lo8sDUKToUrClWAFQi48SfvNKXbbA3vg>
    <xmx:_J2earfAaJXotzzfnSVGzam3CQxsS8P9vAi_tdrvIS9uPC5Q-vCXmA>
    <xmx:_J2easGBRYPPaWb7SFNQ7koZ1elm0qlGaZLcfvLIJ_koAy-BM6109w>
    <xmx:_J2eam_AStZOpCHVPXrn4T2mNsL2y34AtX8glLyx5-J7t1Zy3SBNi4ZG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1321b4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:41 +0200
Subject: [PATCH v2 07/11] refs: expose function to parse reference URIs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-7-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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

