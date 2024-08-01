Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA33A1DA
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525218; cv=none; b=HnUU/5PcjXGM26jL3s2K3DYYG28AtUmEFw68GkvwKeihpwMaO+byDXWh175ux7NzboU6FNeZkCztMy1vib2goatSkBk3nUw81yyXD/fD2aTNjLWDjHW+RH9IIXUKmlX1VTN5mYrwuOBCj+emSuXqT9h6WuAgVT9xkx+z8LFXu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525218; c=relaxed/simple;
	bh=um5c9AAeW/wdAvSIUcmrMHrd9z2JtsMO+Ko9AbjVtks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMvZRa8zyEp4sh47rBXNUlixuESsRvfw6CTu1xv2Fw8T4aErJQEgGpnV/vMDgBdX81mUBPf2tNIbUW8etd3VE4IAJozchiizR99MyAwEadI4oj9C3xbXz2T0KlHi2K/HXfemtFFDzBx/nUyx6eAKcthZc8S+dLyd1gNe+e2QlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXOcBGwI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXOcBGwI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc491f9b55so57252195ad.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525216; x=1723130016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLlGp5Upqqr8ky9vVK99rNVEaNiHcQgkZmpa6IH8Ep8=;
        b=TXOcBGwIR8K1eeaNJff7Czv2Go7zcP12oBfse1vrU4kibMlhD5NsuXoMuqqxm3i9UK
         yrrCNp8oakMpuDN3fE3N9mxeBk5tnGV9/4ZAGvJteaOHlCYpJU2UJQ9re7gxoghSfHBJ
         SDCGz6meAekoML3XPV897sB7bxi2Wo7wTKrIsSrSrPcWMOQS5I0wWCm4OS36TtRV+jVt
         lWN5ZVXZ9FfKLIBkVns8zxB0P39e1xLkpnmMIUqXgvVjkzSWH5BcaWQMaNsfm0x7MkAO
         H1D5GyEXWCODdV1mFrndJlLAjS77EKzHcEkt7NKuO9yxRnYyLj8usHoZ+t9b2wi8avOP
         fAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525216; x=1723130016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLlGp5Upqqr8ky9vVK99rNVEaNiHcQgkZmpa6IH8Ep8=;
        b=MTzzFgGjr5IbzdzsHh3qN2IpVLFERpsqBkL4nwqCo3Lm8V/GbGET88v1idRyNW0Apq
         +gQvOGuLU0ojCLB/5qmBEY89YCQAr/strjOoN6F+L9bIHq8BQWjgXcbMbmsvdMgg9t/4
         i8ggYbMZ9iWHDjnpYcwGOHrvoUudl5DvvSq2SBl6TRzXJLoLgA5sscjQKft8eUOf8mQm
         Tgk4U4IuLW0Y+TXCocLGsBJUddZoFUMI9fWWkMow31PkXsLtfF04BSyQZKhp7IXw3rjn
         OHGg2JyxkQ/zBtJ3bgad6JHT8iIibKsfMqM+K0DhC5d3U6FPqfMsAYTieD5PzCzJYMJ3
         mPUQ==
X-Gm-Message-State: AOJu0YxpLWs+40aPRmZ2/iud9ggQxwpn0euW7GjWe1fE52QgkN/gmKJR
	M31aj7KVjCFebd/jwmdfg0U1YP1QPnx0t/MaCso2CIxB92c7loKW6HpHlA==
X-Google-Smtp-Source: AGHT+IHuJvPYGlu/Hl4SSakkbr+MbA9kTqlojjgfi9tw+uWaFATqlekTi9G7U34sJmX9G4/iHNRpBQ==
X-Received: by 2002:a17:903:24f:b0:1fa:8f64:8afd with SMTP id d9443c01a7336-1ff5722eb62mr6872345ad.11.1722525215867;
        Thu, 01 Aug 2024 08:13:35 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff3d64sm139967215ad.299.2024.08.01.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:35 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:13:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 03/11] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZqumN5cfsQYHlU5X@ArchLinux>
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

The static function "report" provided by "fsck.c" aims at checking error
type and calling the callback "error_func" to report the message. Both
refs and objects need to check the error type of the current fsck
message. In order to extract this common behavior, create a new function
"fsck_vreport". Instead of using "...", provide "va_list" to allow more
flexibility.

Instead of changing "report" prototype to be algin with the
"fsck_vreport" function, we leave the "report" prototype unchanged due
to the reason that there are nearly 62 references about "report"
function. Simply change "report" function to use "fsck_vreport" to
report objects related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4c1f8bc44a..b394a9e397 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,16 +226,16 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+/*
+ * Provide the common functionality for either fscking refs or objects.
+ * It will get the current msg error type and call the error_func callback
+ * which is registered in the "fsck_options" struct.
+ */
+static int fsck_vreport(struct fsck_options *options,
+			void *fsck_report,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
-	struct fsck_object_report report = {
-		.oid = oid,
-		.object_type = object_type
-	};
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -243,9 +243,6 @@ static int report(struct fsck_options *options,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, oid))
-		return 0;
-
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 	else if (msg_type == FSCK_INFO)
@@ -254,9 +251,9 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, &report,
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
+	result = options->error_func(options, fsck_report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -264,6 +261,28 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	struct fsck_object_report report = {
+		.oid = oid,
+		.object_type = object_type
+	};
+	int result;
+
+	if (object_on_skiplist(options, oid))
+		return 0;
+
+	va_start(ap, fmt);
+	result = fsck_vreport(options, &report, msg_id, fmt, ap);
+	va_end(ap);
+
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
-- 
2.45.2

