Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CE1891AC
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116401; cv=none; b=l2tk3TdpToSpsCfEKmE9duifrQ9t+2W/R3xHak7Gjs1bh3/t6+jcaBtwo0SNMjD9ruWsbj24oidyIed6EBJ1y66snxPnAmGuwzhGgG1tca5pDPnejboP0RFG7zpLtCF+Vgz0i7LSqnpDO4MqfQyZrZbZi4/9MV0Yyd5SemIwvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116401; c=relaxed/simple;
	bh=Ie40YCl5ccqbp8gITfQbtAEaPujh7QDuHN+DU5lRB0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG7ywVKooWBQx3pb4J4hunteMwpE+mqJlvRVfGtUQ96nahSXRDqHCHao5CYmeyrqu3REnsSMDvsuYBG//BZBJekYxmVb+o4cNTl5Ke9saJNv6OHrOAdcRyXYzXn0XBbkxWd9hvGI5tbYet253FR2f0W10i2LS5rhVpGtz/yRq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZBYzCx2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZBYzCx2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d316f0060so1325001b3a.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116399; x=1723721199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWB02mc2bGG7zgCHT2ZdCXTLKrOB9IdCm8/oCLM85dE=;
        b=RZBYzCx21Ga93swA9+31tjcCJgH3XkHQA8gzuQto3wIke4fNbmDPWoGniIQTcKo/vp
         pN8d4O9uvwLeSqS8/2UaUmovG/QfYmq3jTr0EA+SH6H51C9QrWK7kdGRh6PJEoXdozz+
         q9g1y3Lr9UH2UJ/1yvyKs+TftX0/AMvbYiSZryJLijJz9NcM+N9l33YOyf+UtLF+SgH6
         v05XYKrpJ7rFU7dkYBRb1Fx0mbcR3LIqu+xD8W9LmkbGupjxFO6C3DcCFprXlabPtQPZ
         eWL4SEp+C0qa4oGhTPB2pdI7S5U2TCAbOx2mByh+zrHCJHOsyqg71BypNGuTLJZa90Ut
         8Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116399; x=1723721199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWB02mc2bGG7zgCHT2ZdCXTLKrOB9IdCm8/oCLM85dE=;
        b=hJF1t+4SnC8Tz5kZMKr9u2aoc+I4iJkXT0E+fkSfvVZwiHsXWAX7bw+75+hLuKYuxj
         8YhkFsPiZkYNmxrqj0734ygWKegPsqAGQ1zBWICmJ4B53ZNKqhFkaLadaqJulF/0FnmV
         Ig0LOexsCQZU6oq94IeIfwBvTf5lR/aNUA5vU4YqhkXsItXAR56vrYv9AAzJFb7DAQDF
         Z13B4rj9L6+GTRAs+UKlxkMkYttTAq86Srdz0rUk8p0prHKZqiRofY5zWICDVB37eB2g
         vwOoYN5AkK0l4oRMwu7Rf1ud/RyD9MIJAVcbz0JruAVvlrFYwkzP0AbAgoHVw9rzlAKI
         KGtw==
X-Gm-Message-State: AOJu0YwCdW+4yHhPIui+vXCTBuCSHPdi4TL5Ynluck4SLJYS27LOViNv
	0H3OvZkRDV0C0TYasUP/QELIJ7A0b66NWJr8n/0+Xe1IDw3zEGk7MxxW9JAzO3k=
X-Google-Smtp-Source: AGHT+IEL4MGZKhu0z65UrYY44hh4gW+GNfdpwv20vThUW0CDctdonIEKl4YOsQuAM2so8NGRHLSmRw==
X-Received: by 2002:a05:6a00:244d:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-710cc811feamr2393938b3a.6.1723116398693;
        Thu, 08 Aug 2024 04:26:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2d090esm955932b3a.102.2024.08.08.04.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:26:38 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:27:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 5/9] fsck: add refs report function
Message-ID: <ZrSrjO2ltoJuppKA@ArchLinux>
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

Introduce a new struct "fsck_ref_report" to contain the information we
need when reporting refs-related messages.

With the new "fsck_vreport" function, add a new function
"fsck_report_ref" to report refs-related fsck error message. Unlike
"report" function uses the exact parameters, we simply pass "struct
fsck_ref_report *report" as the parameter. This is because at current we
don't know exactly how many fields we need. By passing this parameter,
we don't need to change this function prototype when we want to add more
information into "fsck_ref_report".

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
 fsck.c | 39 +++++++++++++++++++++++++++++++++++++++
 fsck.h | 25 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/fsck.c b/fsck.c
index 3614aa56a3..e16c892f6a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -280,6 +280,19 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, report, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1237,6 +1250,32 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     void *fsck_report,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct fsck_ref_report *report = fsck_report;
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
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index 3b80d02506..2002590f60 100644
--- a/fsck.h
+++ b/fsck.h
@@ -133,11 +133,23 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
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
 };
 
+struct fsck_ref_report {
+	const char *path;
+	const struct object_id *oid;
+	const char *referent;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
@@ -175,6 +187,9 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
@@ -216,6 +231,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 4, 5)))
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...);
+
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
-- 
2.46.0

