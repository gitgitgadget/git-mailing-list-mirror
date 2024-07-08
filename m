Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EF1AACC
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445735; cv=none; b=C15zEWPPoBMQLKsEDC0gK6XzAgvq3ZDWjBEgdJHLoAa8HhcJeCSPl/63UbQQM7ui2bCsD3ccI5uaxaUUYVjvMaUdP7PjPuDW6iimTQtqUPOZ3LmMS1DD331kmzhNBZOF/Sg9Gl8daG7BnY4Og3TthpQMsl0gNFCsUFapJxrau6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445735; c=relaxed/simple;
	bh=jQghWynB7l/myLbFQEpmq/CunycbaK16wPnKbUtPY+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7DlOg9FOgg58AFeTcRV8yi5ciNGhamGtq9eJOlKetd3nJDHfZwmesGCJlYEfRmiCxOz+5lgX5LG/w5xVIZpH6CZ2QCg4wWncOP6EgF9muupn5VTFviEwq2QcVl7nSLhAxc4WUPLBlOs26MHWQx4F3hAI1nK3cTEKdNGqy7hYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRD04kt4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRD04kt4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b1207bc22so2117716b3a.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445732; x=1721050532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcHdesL+nRhq/wtl9I6I0uiecL39HaGJC1i/WB2Rjzk=;
        b=KRD04kt4HLTPaPdL4mH9VBMmw/8IQ6dwiZXQCMFVHYRlcM1eOthEemf5wC0AtO5IzS
         53LJbh3nAZPZdM48xIZMV5BIboJXsKZ3EeUv17K6iCKifmwEHNIg0vfC/e7SgkoxcMeU
         st0W4e3ZKNiZU41c5Q+iY7HvF5/kpCwmlUfIdX3LOQBLY1JY2s3IPmkKRI5GHDT8EXXb
         WsOPi2TxHeEQEjjAVKyjDFR4iKKBSFcfkddQfT81Mn2kkDAFHz4eeatS/ybZvomrwrwx
         PRBFlm+tQIOo12IbAb+7RxWRO9s8kFj8e9qqK7OMNSZC47sIWIJbbXUkxuMeHWkf5y9s
         sYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445732; x=1721050532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcHdesL+nRhq/wtl9I6I0uiecL39HaGJC1i/WB2Rjzk=;
        b=XJCQPFeqeThErjKm6PSUVWmyWXEemTgtrIQ6X8fuwdmuDZGBpfL5VWJVdhAvjlAYmv
         wPcVF8sV/CnGw0ptETFQ61aAiCBgN5vJ3YzmNaMpZmAPI3tBXSfVgY8QQFvi5b3zOxD4
         +aTkSIeOO23PhdhbhzszvUFRYjZOxDVQcpmbRuaPOg5v8sSAF5Jtd0Tu/OeynXOlgreO
         HW/iyvE/cYfV3xlVfm5K6dYYdbnPYcRcPnC5BSsDXC3Q00ie2funftIKTsGie+3SECtR
         GMPKINpRrSZgwWGn3FV3MbjGvtfkapjOUaKVgZ07O72VEJj1buwVtq5XTMluGHZRCJTf
         BotA==
X-Gm-Message-State: AOJu0Yzu7VfA5q9JhmCFYTXnG9nE4dRimIFDMUZXpUZRSg0yr8y4VDwq
	2YAOHT39wn9F920bvQp8SC2hROf5+la+XpmWF/w4F5vjBPK7hP9bQqmivGDx
X-Google-Smtp-Source: AGHT+IGx6+pvFBdxGOZ7RKFE2/NDbM4S/++9BgBb3dEtghBj3vkwTAIOSqsX+F1nAr/xkaSj/U2h6g==
X-Received: by 2002:a05:6a20:9191:b0:1c2:9288:b93a with SMTP id adf61e73a8af0-1c29288cb2emr673245637.37.1720445732366;
        Mon, 08 Jul 2024 06:35:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb4fa258f7sm57730795ad.169.2024.07.08.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:35:31 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:35:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 3/9] fsck: add refs-related options and error report
 function
Message-ID: <ZovrI1yRmS0X2BHu@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Add refs-related options to the "fsck_options", create refs-specific
"error_func" callback "fsck_refs_error_function".

"fsck_refs_error_function" will use the "oid" parameter. When the caller
passes the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the caller.

Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
macros to create refs options easily.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 22 ++++++++++++++++++++++
 fsck.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fsck.c b/fsck.c
index 7182ce8e80..d1dcbdcac2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1252,6 +1252,28 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     const struct object_id *oid,
+			     enum object_type object_type UNUSED,
+			     const char *checked_ref_name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, checked_ref_name);
+	if (oid)
+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
+
+	if (msg_type == FSCK_WARN) {
+		warning("%s: %s", sb.buf, message);
+		return 0;
+	}
+	error("%s: %s", sb.buf, message);
+	return 1;
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index f703dfb5e8..246055c0f9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -135,11 +135,19 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     const char *checked_ref_name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	unsigned verbose_refs:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset oid_skiplist;
 	struct oidset gitmodules_found;
@@ -173,6 +181,13 @@ struct fsck_options {
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

