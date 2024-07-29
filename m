Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C03C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259593; cv=none; b=pwvA8LzXMps2pv9OnNaWDscht5+6BrNzeildORhZAZSWAkjbjtq4mt3rJwYmLML8gjjXiqLT24FwjTuYv0FR2xOkVCGERuUZE/14Tzk1ToM39U5vhM5K37L9sidSWljtg2PeC6lb/z69xSdvnqfTcUCABuoRJmWijGfXaXyInQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259593; c=relaxed/simple;
	bh=wWP8bF/sPQDvbcCm4CeSTZLhRKkQj3XHJddpsuoY1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3ecK0JKxZjGHjSnFx39VtO32pKcqajykq0uh/Pj1sOeEYyf/gjiUfUtdMwD0QE4x1pHg00XUG60aMImUoIKG1okQoQPVVSh/mhaypuxEB6aP1UUa7jxsBd37IQP+t06qBvoqyDQTMNsG/wU8LEWKNe9FiXyP0uGjetTiAvGvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA9BLMwD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA9BLMwD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fcbb131so27085815ad.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259591; x=1722864391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynFHmapFj/WoKo3fn4fpxKUdKIY4lUbbqjHuoihCLYY=;
        b=cA9BLMwDiSPlOJ0qTxiB91q6bSCuWXQ3PPT/W50q5gJNR5H2Eb49ba5YLVT+JegZGN
         nhf31L9t9buBzgBD7cuuXJGGYE4xNsaYCacVCl8s+yEjAWiGl1P1ZnrSD2ZOaYbyONww
         SxzoMv8ZqStbbZPED/C/03yFMyuPkunHL84CsH4ytD+/O+/C7Hnql460E5Od+jtoi2pG
         sZbEPhpFMIYw5fU9Jw6EuOPS7ZuIhHkd0YnyRDx8aiZhSBtI6Y5GgVJ2UQUhzJHWnBxK
         va1H4B3hYF1JvFIylqdv5LJdTFCeslnjfItyQFAY/E08rTAWVKgTgd401LlJn98kU7Zv
         g1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259591; x=1722864391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynFHmapFj/WoKo3fn4fpxKUdKIY4lUbbqjHuoihCLYY=;
        b=eAO/qh5a2ltDzUyd4iDMQK4WoFbMSYQ9Hu9kaPrIQCdm1WGvPLHuHvKDPCY77JbnmW
         9VE4c1z+s11sxFzdmdwoVU9anLOSb3wpin41rRjn+BANWmkI6Y5qyNGFZNZIil7nVEhL
         DK9IbpCfug8ckdpDy2F9vTDqlrc7yQBjeA3KASh5OkBD1Xg69Dsvsvq3wjugwX047M8r
         OOLPGd6Yj52zcR8WFChcM+ulG2tohDB2yHFRWJfxM4RghvaXdifQnSOLopVnu+mjG//M
         6ITspCSXllzZnmlNZ+t14c+HwYnlGhebEJf0FSiceX5g2JOioCerIoYJ1leBTeL/iNvY
         tuSA==
X-Gm-Message-State: AOJu0YxqTJKLPabYPMvq+qv7h7h56PVpLrE0nmmz1inKp1DJWiIlk0aO
	CiLtSYuqjLngmT20/vtfiy1m+ubUoxW0F+ATGygFb6YPXYTaZoi1yE9EVw==
X-Google-Smtp-Source: AGHT+IHqFwvJG5hnwOOcEO9F174sfxJfLKrWr9v0IJrP5FOm+1rvE8mB/VyrOo6cfPZTD++9iptxpg==
X-Received: by 2002:a17:902:dace:b0:1fa:b7ea:9f0f with SMTP id d9443c01a7336-1ff047fed8fmr108336565ad.7.1722259590779;
        Mon, 29 Jul 2024 06:26:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f3e28csm82461015ad.216.2024.07.29.06.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:26:30 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:26:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 04/10] fsck: add refs-related error report function
Message-ID: <ZqeYm2J1LeXn_1-4@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

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
 fsck.c | 25 +++++++++++++++++++++++++
 fsck.h | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/fsck.c b/fsck.c
index af61fa90ba..56de29b4c0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1251,6 +1251,31 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type UNUSED,
+			     const struct fsck_refs_info *refs_info,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, refs_info->path);
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
index f53ac339d2..a4a4ba88ee 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,6 +136,13 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     const struct fsck_refs_info *refs_info,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 /*
  * The information for reporting refs-related error message
@@ -181,6 +188,13 @@ struct fsck_options {
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

