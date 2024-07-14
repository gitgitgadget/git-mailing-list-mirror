Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B21FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960294; cv=none; b=nuRcQvvf/BDdNogYgkfNw5wamQgUv92AxHAnvWHPzff2TRnj2I88pGzR1KwD7JmbAoL7ou28syPj7CQPrF+dW9zBLAJYzpxQChBFPO7troDzndebraI/u6dDOs2EoCNIid7DjkkCfWQMYgYjjAVrpJahuP/yf2lhpcYWs8bK0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960294; c=relaxed/simple;
	bh=eIWq4uYDutHwHrFgl+3hACJFVYTFmRT7RgAU63MYuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN9LjRo7TzVVaPXSrWlLavso6ojDO+/FycxPOBig7xDVvA7PffE2Z8Ork96JrB2i/FrUy4NDLAQJZAeYLA43SKJZeC7nVaEf0RPMjJoefYYLFpDk34xiEP1CbgHO+XFqg1GzmiACWQdkpV2KLc1hhSEnoGYs5XE+i3OVcWrExiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA2s75nF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA2s75nF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso2760881b3a.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960292; x=1721565092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfu5IeCtwZoudyufnZa16NZFu/pUa0f5LKBXqywK6C4=;
        b=cA2s75nFX1KYo29vlWgkDaEsJ3Wbz7Raqua8UZ2gXk2jZbs4NvIfoNpc3eqsQZaT4x
         8YmI+FO+lAbmiwtILIfHhn9GPkPC0vER9+doNySjIxOeqNMZTiobQBIkBaNlyvBcPyx5
         DzEV9C3FqlJWAuVkjOshqgh/6u/cFVE92emorLrC8G8vFp84NZ2BvbYlzhJo+hccd5Kv
         eUqt/vOxhkTqbyAyhTH4AYzDy42Wsz6su0yYtVO2PfVAl8PxWSCrO5Z/ncDXy5jWSV4Z
         FxBpawYURvawwsg53mxQ/h848q3/+feR52w2PFD6fYNIR2HALl8RBsXGNFjLakoDAqTL
         iNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960292; x=1721565092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lfu5IeCtwZoudyufnZa16NZFu/pUa0f5LKBXqywK6C4=;
        b=qJhQ7keleLgxvb+UrlK21qZWeskcbhDLLxtVXQ2P6NQCKRAUElHtVLCRY0axZxySKG
         Z9KrSayfw7DtbDDJqMP90Uw6yT1/q74VFFn3UshSxEoSsLgDxZdnOUSx4cDAugi5OQjP
         h3hqdPJ7gKa42nXZkDHBbHPMx3D5cBZQMjdDrOlFzIcI+ec2wqZibJDCS1lMNNU0uIWP
         oDI0iNiz5t6SKjMZa5KOffF1g8cufKEoIIjX8Ph7aA6fKqWvayeRVhgMRcPy9PbDRG6C
         xSmetaT/0/vLgJp4KZnoKYpE94Zk4Wy92lXD4dTN2JLi9hFOZ2sFDzoHlvWtBnv5VRA4
         p+zg==
X-Gm-Message-State: AOJu0YycKu7P3dd19N1mpZxYGjojNcRubb5G5YK1AffS/tKr8W0+csE7
	MQ9fblf6+koXWi/UtfvtNzMnNLkoKodQQltEZ12ggqWg7wFEwVs5vukp6A==
X-Google-Smtp-Source: AGHT+IExjdsKspg+tc4xoh637+htDzqhX7t0JMiirae2EERi6gipYH7mvnTn542PO9jU0iALy4tJjg==
X-Received: by 2002:a05:6a00:21cd:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-70b434f3493mr21093541b3a.2.1720960291734;
        Sun, 14 Jul 2024 05:31:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b81972f56sm2282876b3a.84.2024.07.14.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:31:31 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:31:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 04/10] fsck: add refs-related error report function
Message-ID: <ZpPFKPJ4cw1V9U7M@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

Create refs-specific "error_func" callback "fsck_refs_error_function"
which could provide the following report messages.

1. "ref_checkee": "fsck error name": "user message".
2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
3. "ref_checkee -> (oid hex)": "fsck error name": "user message".
4. "ref_checkee.sub_ref_checkee -> (oid hex)": "fsck error name": "user
   message".

"fsck_refs_error_function" uses the "ref_checkee" and "sub_ref_checkee"
parameters to indicate the information of the checked refs. For loose
ref and reflog, it only uses the "ref_checkee" parameter. For packed
refs and reftable refs, when checking the consistency of the file
itself, it still only uses "ref_checkee" parameter. However, when
checking the consistency of the ref or reflog contained in the file, it
will use "sub_ref_checkee" parameter to indicate that we are not
checking the file but the incorporated ref or reflog.

"fsck_refs_error_function" will use the "oid" parameter if the caller
passes the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the caller.

Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
macros to create refs options easily.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 29 +++++++++++++++++++++++++++++
 fsck.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/fsck.c b/fsck.c
index d66ea4ef44..4d18f20b09 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1256,6 +1256,35 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     const struct object_id *oid,
+			     enum object_type object_type UNUSED,
+			     const char *ref_checkee,
+			     const char *sub_ref_checkee,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	if (sub_ref_checkee)
+		strbuf_addf(&sb, "%s.%s", ref_checkee, sub_ref_checkee);
+	else
+		strbuf_addstr(&sb, ref_checkee);
+
+	if (oid)
+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
+
+	if (msg_type == FSCK_WARN)
+		warning("%s: %s", sb.buf, message);
+	else
+		ret = error("%s: %s", sb.buf, message);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index 0b40d9ec28..7ae640ac6c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,6 +136,14 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     const char *ref_checkee,
+			     const char *sub_ref_checkee,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -174,6 +182,13 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+#define FSCK_REFS_OPTIONS_STRICT { \
+	.strict = 1, \
+	.error_func = fsck_refs_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.45.2

