Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA313D265
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116390; cv=none; b=GHIQBqVwhmsen2XXCzyqqHOqucI1xoOtVzL0K2RuXuOcn+4O0OikLGt3L9OPVhGfYaLbuLIZyBcG942LS3YxKjDrG8pdxVSl+SJ/fk8NEQqKhbcEfC6yuT64OVuP+TXep04feixGLS4Ei+WY36m8goxUjqLusdI14FtDRiF3yFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116390; c=relaxed/simple;
	bh=Wj1rtaGLFY/l7brZFBPulOWSUmwOZ/2ft0Qhe8YUxVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7PdCGTvlkqK997SsKwBSmdDRHxT40RATLpExJ58LWFphKNShVWIIAcUyrdAHZbPAa3dUgDiuWlKbr5nvVmDhwR2anf0H6ADBBAuDwA7GM0K6+dswjiSKD8aVs+QkdnW4fcIHAjTqpULjNP4lTm671TgmZjfX5O9GXr/I+bzgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAt2LV7j; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAt2LV7j"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so683922a12.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116388; x=1723721188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkZZIEVS0Fg9cfbQCgODvVKx1GInni4ZjRoAnjEwfsM=;
        b=kAt2LV7jYqRZBTFaM8mKXGfMWyCRZiedIMs0Xqho2ZrKqDM9W1spgnc0UQiv3aj0eL
         CbbxaMExfHQ4NEBMxADbsXLwM/AeWI014c/19bcM4g64j6UKS8wLF48hg3DXpf50A0s0
         NtfTZ4gY0udAFNuXc6Rn+IjLKEebixG0PBK54md/Ugl0jpeOuY8DkhdAwub5esqvl/d9
         JCNi6bdCN0JHuIU7RXkYhMZl+izd+B8/ggLEB5ZMqqYhFUbbLQGXHHB1pDBAuvRkAboG
         xu/Qa4l7ECo7Y0Q7A2OSkUbImJCFrgAWoKDtt9bkaq2AcGgxM48HxKJGWy5e+/BXZxxs
         4/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116388; x=1723721188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkZZIEVS0Fg9cfbQCgODvVKx1GInni4ZjRoAnjEwfsM=;
        b=dkHekj8IW7HV5TKZlPkXfe/aJDtPrtVYaCR3t9rGo+fX00ikJuU2kbJMYiLGdB87/G
         wJT8259xs4t0odr6WzJaS/0QD2JJFmpl7WNiHQzbBpdNVJFbRGmHg0pJyObo0sMV4sYU
         5RYwT5H+Ziw68TtoQ2i/q4DIDffTT6NcY2k5dRA/Wzj9GWAHYzKRFW6k+yFF0ISu++P9
         OaeYTxYqa+/rF5z5KVnEv7ovDxHc+akjVJsGe8yUdLawngBxN28sUjxarURRYX8j+kw9
         PLCylKnD3AUpBeqQU4oMOKJRcWw16tdkw8qsgVEraXxHHn9zljRkSWuPHk+6U8pcdYnx
         HadA==
X-Gm-Message-State: AOJu0YzSZKS91OheRyeuP3oTALxlbM9mJSkBRiLWWsd0YOPppECjn5VI
	sLKcVrjqE56sCii0V5LXX0oIZ+l8zCHgQgO9QtHO/n3x+GGvEKIjTrmNVWpmE7A=
X-Google-Smtp-Source: AGHT+IHSoO/KkZ27UMHEwX+i6E+uEr437RIpUgr189+wVnufohXVMFnmhcrGMCW+dTOsPBqaow+vEQ==
X-Received: by 2002:a17:903:22cf:b0:1fc:3dad:25ed with SMTP id d9443c01a7336-20095224ba3mr20288755ad.9.1723116388141;
        Thu, 08 Aug 2024 04:26:28 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2007d1184d9sm43612915ad.216.2024.08.08.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:26:27 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:26:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 4/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZrSrgRGwI_jldprn@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

The static function "report" provided by "fsck.c" aims at checking error
type and calling the callback "error_func" to report the message. Both
refs and objects need to check the error type of the current fsck
message. In order to extract this common behavior, create a new function
"fsck_vreport". Instead of using "...", provide "va_list" to allow more
flexibility.

Instead of changing "report" prototype to be align with the
"fsck_vreport" function, we leave the "report" prototype unchanged due
to the reason that there are nearly 62 references about "report"
function. Simply change "report" function to use "fsck_vreport" to
report objects related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index cca6ae144f..3614aa56a3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,16 +226,15 @@ static int object_on_skiplist(struct fsck_options *opts,
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
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -243,9 +242,6 @@ static int report(struct fsck_options *options,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, oid))
-		return 0;
-
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 	else if (msg_type == FSCK_INFO)
@@ -254,11 +250,31 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, &report,
+	result = options->error_func(options, fsck_report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
+
+	return result;
+}
+
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
 	va_end(ap);
 
 	return result;
-- 
2.46.0

