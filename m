Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549B13C3D3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525240; cv=none; b=pLdqPXebGgB3AU6nsXMpNMhUyw4QwMid+sSEPSIBuSNEPzEm+ifIlRQw6K0+0Wg2qyRnOUfkRsKD4Y8Wkf5EQQRUD7k+40NtAfN2FSEn/HPmTyA+jatQTONLwKkxxwd/r/8dnTLbzw3bNSUEVUDBCopltFKTusxy3D5/RSQ4VvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525240; c=relaxed/simple;
	bh=b9TeBjnI+jum7AEuxDXZ4/MnmzQsGwYWpzi5ak23yco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/B3GGCCrp6m4WLMRcbxMMFOLx4j6NfiANkAGuSt6sh4lci20Z4UkNp2grjFoEyi8yo+S34LlZIE8uwxjI/Q7I/nwyGt/whSBGN16xXLImmfpB7wTHWV4nyYd81h3d1gI2lj7LXYlurO2uQdVLdI3SgsUqSNISU/HzbVFCBXIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAph++uC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAph++uC"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-71871d5e087so5386809a12.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525237; x=1723130037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyzDdaHjOxmEoIAO34N4rOjR3UvM+wVxuEtNPmA378Q=;
        b=BAph++uCoFYJnw5O9UMC7FB9+JVV/Kj6M2dFqT/2hUscRFNb/JXG6J9DjKxHL1kek4
         A4kVF9wv8F7D0QweHWe5r0WCyDSdl5EznI0JovpPeA9kEfWSirWP+c9LU0bfSM/sER9H
         VW6NISl69/NmE/NjDFa/vjACsnGSlyVVQizx30bsSVYEqlT3WUq5dxAd/fqGco3GX/Rf
         2dGo6gNqwN+0idx1Fwp/l7NvZyqyDbHMBDoyKqYSa27XP+3b0EoRdkIS8MV7u9RGm6ui
         MjZMM14BN2AD/DfkRCb5SkD0V7uzNUu7eCSsXlS71pSJBm7jCPBc64+4HeNvaoo4mjho
         R8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525237; x=1723130037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyzDdaHjOxmEoIAO34N4rOjR3UvM+wVxuEtNPmA378Q=;
        b=T40zwX50w+0PoFICiiDkA3KJiEFdBDxBiP4W5N1affFDFWwOKyC9417+wU61tB2F+M
         WHDPQsA7hMj+XRzQXmeGJxsEDb2kcZOSF97wdqnIZOsbrxVlZlUUBv41nNsjrMEE5/3W
         l2nGYuWzvNv8QEGN8wHgL+fWlN6y91pLOwniK8QhzOd9BoMsUcv4X37atNKv1JFbrP8F
         k6OnicPMXp8ItMuod0WY1GjVcwMxWKgrbacw8gksufcvSZT42d+k/VV0oXn+Dijwk2hR
         sQ+H4lGX4ka7echksxzCkD/DwVO0MEA2afcEQiH1us/mcFYPU+qZL9eJlxxP7cIsSn3T
         pbbw==
X-Gm-Message-State: AOJu0Yzw48NyxJ1R1JWF39eRTVzHd+wK8Mf0/btmc6I59yuMSdwrEv3j
	ClpU8DgHqpIiGKP/d/WIaTPoQ2o8TgKR2yJOQ623cXO2uhmiP1KF6e+kpw==
X-Google-Smtp-Source: AGHT+IH8CwrXYyU2UynF0fJo5WROzi6Q7TsY5UQhUI5vNi3oO3WrOFtxcLkBcUmianEPrUZhyO1tBA==
X-Received: by 2002:a17:90a:f02:b0:2cd:ba3e:38a5 with SMTP id 98e67ed59e1d1-2cff9469006mr594546a91.21.1722525236900;
        Thu, 01 Aug 2024 08:13:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf176sm3459372a91.43.2024.08.01.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:55 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:14:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 05/11] fsck: add refs-related error callback
Message-ID: <ZqumS7l6FjFz50DG@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

We have introduced "fsck_report_ref" function to report the error
message for refs. We still need to add the corresponding callback
function. Create refs-specific "error_func" callback
"fsck_refs_error_function".

Last, add "FSCK_REFS_OPTIONS_DEFAULT" macro to create default options
when checking ref consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 28 ++++++++++++++++++++++++++++
 fsck.h |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/fsck.c b/fsck.c
index ee888c1417..f0ae760c86 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1253,6 +1253,34 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     void *fsck_report,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct fsck_ref_report *report = fsck_report;
+
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, report->path);
+
+	if (report->oid)
+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(report->oid));
+	else if (report->referent)
+		strbuf_addf(&sb, " -> (%s)", report->referent);
+
+	if (msg_type == FSCK_WARN)
+		warning("%s: %s", sb.buf, message);
+	else
+		ret = error("%s: %s", sb.buf, message);
+
+	strbuf_release(&sb);
+	return ret;
+
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index 0918c28d0f..2276ea7e34 100644
--- a/fsck.h
+++ b/fsck.h
@@ -133,6 +133,12 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+int fsck_refs_error_function(struct fsck_options *options,
+			     void *fsck_report,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
+
 struct fsck_object_report {
 	const struct object_id *oid;
 	enum object_type object_type;
@@ -181,6 +187,9 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_error_cb_print_missing_gitmodules, \
 }
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.45.2

