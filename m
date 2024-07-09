Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D2152160
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528526; cv=none; b=AsIJYhCn1c3Q9cZf3AMoXXw7SAxNnFH1h+xLDvKtJ7r0I2NFT93rJ9uo3oxV38zXPosXBOc6NFJdGLIZMSK0fIh9QxGozkZo3e4SAfHMZI6Me6p778mx7Q0KC/KciugqS40crFBX6cwaTxYrpAEupLE+aH6Y4EVQIrW9g88oR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528526; c=relaxed/simple;
	bh=sNdP/0RqI/pOGueXUMVaCQHQxBBY7yvrPGN8+HeRggI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyWWIfYdcEAUUGTmIon22qiWrl2Kx4YTqOYBB6wQkMkro1RxOcGVg1KvnaX/rYX/PZNN9Fm9TL6g5ak8Bi8CGnCnzGGCv/oB6C1syoMz9f/H8Eo5qMSvJsSG1ws1U44U28ZTi8MDPeTuDUKtu6vhFgM4MojFffd6DU0IGW8KBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmSsYooa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmSsYooa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fafb9a33b3so24614445ad.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528524; x=1721133324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ARqU6wDsSJE6slt1kRT1C+WNBlrB9xyUHC5u1AlVDM=;
        b=gmSsYooaQ5Q8///WwdXn/YQYGKjdRVYByr5+A2SsL9VNfBg1vBCTZSoJPUON8BHSjx
         NnAkx2M7n4EgjjRPoA4+BvtVhJXv+LB12w+4j+iUM01tWhBMuDsW8oTizaHV6yguQtYG
         k7F7Xx4/eLT5ZL4Cp9A59sfVSN+Y61uwWiyKsZzGXuxRBczNWARsAAW6VssxSUIVkF3+
         Px1po9oRYu+W+7SLxJH0fBPmY+NSoZvpkf3W+ZBFNEKhPTtauPProOHYHQtOzbqpCsO6
         oGtuUYG8dWi4aymugvtcR2L7QmIM/Pkri9+ZEa5X9CM80Vj+Lb4jz4MpTMxTjW2gGSJu
         lLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528524; x=1721133324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ARqU6wDsSJE6slt1kRT1C+WNBlrB9xyUHC5u1AlVDM=;
        b=kr1leI95STR90Zi/ZnLiX16M/OvgQnOj4csECDQ3fY/FTLzUXhmm86zdaK9UTBPP23
         qyJIF1NYT7114EDESOcSjHzol3b0bTh9sD5Ic7OMzZ9blXNvpEhdPqAXv3toGGgJLLCk
         Chr3SIbF0W74FPOpnLNUEa18m+dHrtBcw9c4YEAI/RxpM0QKkzdMXXPLO4Mu1D4EiX6a
         RPC3hWfAQZUnO+faB3aTfL8s15Wyr8CrUSGxCtVmnqToBZ+lPCBPAKUz2TxJVCuPDX8V
         L/lAT1GKIKfWeHpJTmxmw1OjBgkNzn5S8fFxqBHS9mg28DyARO1mHJslvPktmo6iUZ+e
         v+Yw==
X-Gm-Message-State: AOJu0YwK/FIxztT6fFru57lhaWT2zoVx+HfB3uSAgkMVnMSaewy6RLzn
	XPO3YdzcOgKgGN1xbPUS7Rx4azUVCyhQaO7PZomMgV07mJyBEUf9ANPRsqXa
X-Google-Smtp-Source: AGHT+IGcfPL3hnoZZGR/M88RdeiZgRASC7wfCKIZnkPo0DvM0cvR129sqKf146CylrKXY2m6xGsKhA==
X-Received: by 2002:a17:902:d48d:b0:1fb:53b4:55eb with SMTP id d9443c01a7336-1fbb6d0ae57mr21220095ad.17.1720528524180;
        Tue, 09 Jul 2024 05:35:24 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab8041sm15044975ad.135.2024.07.09.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:35:23 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:35:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 3/9] fsck: add refs-related options and error report
 function
Message-ID: <Zo0uiz1y6hJld2Rv@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

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
 fsck.c | 23 +++++++++++++++++++++++
 fsck.h | 15 +++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/fsck.c b/fsck.c
index e1819964e3..c5c7e8454f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1252,6 +1252,29 @@ int fsck_objects_error_function(struct fsck_options *o,
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
+	strbuf_reset(&sb);
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
index 8ce48395f6..ff52913494 100644
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
 	struct oidset skip_oids;
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

