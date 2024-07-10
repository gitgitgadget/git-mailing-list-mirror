Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AC15E97
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622843; cv=none; b=BWclkgkKJTa2usXvUeRMA5lW2UKhrEst48jVZWwMrT2q5Aa4hqh40WgQoMq9SwRNRhK649BVCOkuCgt107XmXNGZ5/J0KYYQXEWiRSasKSalfqKuJ1iwdQTodVQWcuegB8Py26yJ4du0BFZV7k+0+trepSwNtch7WTgNGuI8kro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622843; c=relaxed/simple;
	bh=d22MuLqwwGwy4T1ex88Ppxiz9N5B9QWDXhD3St/OXYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLY32mPAbujIT/Y4fEXiQuzKBSAK/i7kcj9bGCMa6GfxlvjI68p41YLoDjaZCn+c4WFC84WkRfXwhBzOf+5+tJZfZ41UGamDD/kRygTDxp5V13ybuB3SYMCfhJhM21WWL9A7W5PdyTiV1SMVYKJy9M5EMDC76gLfBocan57+y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5dUeFhM; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5dUeFhM"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f70a708f8aso194351539f.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622840; x=1721227640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huRw9gOLam/UdXn7OYApFuO/P191l4s0XsIrfqxFHxg=;
        b=K5dUeFhMmvTWIg8sslMRW+ZDD+FGW79omdySRqjoZyqS20MxF1UIJ3HgzH/t1NFaR7
         6W2DZoX4mQEwhXT1qx9EKqvSJ6gwwZToSuyfEEnUEAOR0Phf4T4+ui+fHch+oiKNwmz+
         23c+RSu/hTgqQZnoQp9wTuh7j9AHFqyM9pzqfZVF+zvvm89Q9diVGy2/fWvU8LTKmLWG
         3Fl36cuh9HjMANGUgndaX/saVp3N/V7L8zfqID1ZMHermiCIA3Gujish08C/+J4t2HGD
         oMUG3ISDGLx8//H5x8p4zmFQ+lkepc8n7feprn9KpWS3LM2F0I2/Lo66TkJqOye7KeJ6
         yARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622840; x=1721227640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huRw9gOLam/UdXn7OYApFuO/P191l4s0XsIrfqxFHxg=;
        b=fH3m9KFwCTqMoo5rVRGZkvtTBDNnjll/ggASpMQ3sVwExO/HJSskpvOAd5TX+4o93t
         8NgmPcAx66s2CwZqWMT8R2f56tvYIz/vvq+4HVin9cijfK0U2V4YDKLZE2gRay7lJIXn
         sV1sHXd1mUhcPG8dq1l8XqiEgX6dBTHLvPjqYOAQhrrRI1fJVEQOJkF8o2Heo1zvckfS
         eE6HEv4YebGuRGJhMnYrwKHZCIrmwZ1qdRsDSNjYlPjvubQOudtEWxDtkc7/XzfVqvOv
         X5eS0IxDaTRjqPnszBNN5RSF85hHDEIQuj9IBU3TYhdBM/plO+OD8ECvTtrvJlQ4+0vx
         8PBw==
X-Gm-Message-State: AOJu0YyLrZU7jl5OVU2hd74GIQsPICuND3Bp0b3WwHAEqBg7DgR3vR1o
	VIq8mOh34BZoXImGTbTRFZaIk84GfdPtNDYI8OV6kUIKuWbnXKnWA61I4w==
X-Google-Smtp-Source: AGHT+IHzgOJ9+HC/IOMXLmsS+fmuBSHQnRHf7G2U1GHdI4L7V9AcUWFQCIjKKX6WXJJ50fpU7jXCkw==
X-Received: by 2002:a05:6602:1581:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-7fffe62c346mr813851539f.1.1720622840288;
        Wed, 10 Jul 2024 07:47:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm3024581a12.22.2024.07.10.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:47:19 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:47:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 04/10] fsck: add refs-related error report function
Message-ID: <Zo6e-WdPpSjMhPPV@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

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
 fsck.c | 24 ++++++++++++++++++++++++
 fsck.h | 14 ++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/fsck.c b/fsck.c
index e1819964e3..f14ac533b0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1252,6 +1252,30 @@ int fsck_objects_error_function(struct fsck_options *o,
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
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, checked_ref_name);
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
index f88e5faa94..fe5d4d2ad9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -135,6 +135,13 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
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
@@ -173,6 +180,13 @@ struct fsck_options {
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

