Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FF198A21
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501299; cv=none; b=aQeky73OjPnBPwGa37FnoWn+I2WZ8XL8suXBYAR6GJm5BihBcpygiENUbCsiRytFFZaLeGANmpmcFH3awBb+YY90ueSln1pfNEWfZ/UPlCJw/Z3yiQb9mNnGACSkrrRwx5jSxDM2Y1OC5JosEwgezDlvxABwieDtEbb5TAz1a5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501299; c=relaxed/simple;
	bh=gAYs8CyXA1H3bGEqVclb+J0L1NDMKEeYcPjei11IgsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZCvyjom8+Hib63ROl45eWKl5sVMXdNHAjutgsrke5PH9D2aejSyHHEFELiSU9VFTmawbKEai4xrgDExspsl1fzVUMYIcLtF1F47NTamCb70c07fxTtYhnMB6zVd8HDWoTYICHyUGDV8qIv7G2KX2QnRoS71WncF86EHgj6OjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDTbyO2E; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDTbyO2E"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-710437d0affso5996562a12.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501297; x=1720106097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPBTS4gkLF2FTufbmj7RqHbt4e8xUZlgv4Z+cV2JT9E=;
        b=MDTbyO2EbTUBZNqMU87HJEgmqLPR9efeFnVxUAmQXu32IE8GUUYSqLrHyWwLEAYtci
         kVRVBJk4Qpaud1qAPc6PI46nuA3sSpee9QN9dQLY3G61qjJumuOIA9JI4aJ0xjOUsj3D
         /54yXc+jCoaneF38OGuXrMrAeC43jQHStz9GyF9NMgqW3brmxulY+wBl6LkDua3r99Ev
         yQhrtTg4fP5JQRC0fuY2ZwFfIcX5dUUcT9VwdENTBI3QvcNPQHKa6IOglbX4Rj7AkLa7
         byzP81tfewkfaGAOOIz/u1Joz8mapjXDWXmWR6j6UI4mNbBg2JMb2p1JDZrvUHOx4/pK
         dWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501297; x=1720106097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPBTS4gkLF2FTufbmj7RqHbt4e8xUZlgv4Z+cV2JT9E=;
        b=onBKnLFJ35W6HUqP0qOefWd3ouL0MulFvz+cc7jQ57KBb1nX/7uFSeIfUk5IKLWZf/
         AAZwsUOQ8zkqdYvKdPoh3hGsGnfGcOzdxhLVGt1X2OFqSJarH9adv9IgnStxNTsjENul
         Aq6OVP2yUzA2QWv95dmJ03QISk1kkIWH4h3NpRmJUe92/M2/v3R/r+HiOg3i4k4FJc+F
         aqhD5Lf5O8lnUzRtQl3F4eZkaAn0GQlvIx5GYOUc50APAJjMMBPWhSuayKUfD2P+x+Zu
         E68pnyxYH6Ps6bLH1Kzk7pwFlt+m6pwPPDmC7e1N+2fudBKH/TGNk8UvbljsvRxNI9bg
         f2fQ==
X-Gm-Message-State: AOJu0YyyUpok2v0r6j+7W63D/OH4r9m/DdDOUfDsclm2eLGNxlUaW5yT
	UjnxKeO7bKLtjM2x/R1MY7GXiKlnrq+HedLYbu6QyEBKiSgMDUPAXxadzQ==
X-Google-Smtp-Source: AGHT+IG0Fy26pP3SLzEBN7Y4Yu5/ujsC7LwABn1znQR8B48ejLU1IWJ9O5N8LVDFDCxBD9cb7anwfA==
X-Received: by 2002:a17:90a:c24a:b0:2c8:6a66:32bf with SMTP id 98e67ed59e1d1-2c86a663328mr10645247a91.39.1719501297055;
        Thu, 27 Jun 2024 08:14:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8fe8ce765sm1598238a91.21.2024.06.27.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:14:56 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:14:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 06/12] fsck: add "fsck_refs_options" initialization
 macros
Message-ID: <Zn2B7q0Ai1c81lEf@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT" macros to
create the "fsck_refs_options" easily. Add refs-specific "error_func"
callback "fsck_refs_error_function".

"fsck_refs_error_function" will use the "oid" parameter. When the caller
passed the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the user.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 23 +++++++++++++++++++++++
 fsck.h | 19 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fsck.c b/fsck.c
index 5184d17736..4869566d19 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1285,6 +1285,29 @@ int fsck_error_function(struct fsck_objects_options *objects_options,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_objects_options *objects_options UNUSED,
+			     struct fsck_refs_options *refs_options,
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
 		      struct fsck_objects_options *options,
diff --git a/fsck.h b/fsck.h
index 70d5e78ae6..e903845690 100644
--- a/fsck.h
+++ b/fsck.h
@@ -140,6 +140,14 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *objects_
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
+int fsck_refs_error_function(struct fsck_objects_options *objects_options,
+			     struct fsck_refs_options *refs_options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     const char *checked_ref_name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 struct fsck_options {
 	fsck_error error_func;
@@ -150,6 +158,17 @@ struct fsck_options {
 struct fsck_refs_options {
 	struct fsck_options fsck_options;
 };
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.fsck_options = { \
+		.error_func = fsck_refs_error_function, \
+	}, \
+}
+#define FSCK_REFS_OPTIONS_STRICT { \
+	.fsck_options = { \
+		.error_func = fsck_refs_error_function, \
+		.strict = 1, \
+	}, \
+}
 
 struct fsck_objects_options {
 	struct fsck_options fsck_options;
-- 
2.45.2

