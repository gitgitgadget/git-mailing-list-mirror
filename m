Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5E15EFB6
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847205; cv=none; b=JuBNrMqf3WJOi0WS6xe6fmnmv48fRvX1+M066ufjOu/Uzsn/bBCkTOClqrRNEHzQlW8ORXPsBo6iLnS06DqA8lqLSAu2pLUxUgkSVH3Pzd/LfU3d4hGeAXoI73J1BqHOKquPXKjKudPOq3cJyw3P3DvYXriuuJ0vEqksDc854LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847205; c=relaxed/simple;
	bh=gOOYUXUXMC/TJqZqn98LPak7tNYuDPhFNAt56MaQdJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJO0IDt7dWuiTQm18PAxf6U4cVtYtWIo7YX8R05Pm6FqQEpGuAfhdE7AkT7BuAcRaCRv1+4gLEm3VW99G4CytHiuxLO4fq0z3sKJdB72arGRRBy92gJ6ozmjH+AzzhYD4l6ST0zH3SevPFaHhkqoubR6T92aQtnD1bORP0QXvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEcM4WoL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEcM4WoL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so1515003a12.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847203; x=1720452003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/iWgs0hBMPDgOBUfW+8UyV5H1//6gIpwQ6qwzn9IC4=;
        b=UEcM4WoLa+aJl/dC1uG6p+4qTvnpU7TQvWDmLnt+eRz2YXXCbpfn+eO4TjP2xgBhDv
         v4eT/BN0rVH36aLBDHbgWerNbPKjg0pV3gZWAgngvtNhBfNGhsn3IHVrzU+l7/dtDDNh
         ODc7M1DG8jK7k/z3uHPxjK8JSrJKHbnkkeOkbvXajiIBwqgJmN5NxOvXva8qZrJJeqFf
         9Ys5ZgeACKJjy+55uS70CkpXZx6EklitkcI4MQzUiJC5hV4lLGWcmVxOQOBTyBHGxvVI
         A9ncftfhuBaeTNqEHBcz0PASnuA1GQJKWeD/TPpXYKj7lJDFLwvXb2f7UyLZq9NlbE9d
         WRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847203; x=1720452003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/iWgs0hBMPDgOBUfW+8UyV5H1//6gIpwQ6qwzn9IC4=;
        b=X3apYsY7uZ+GQsJmSbY23kP83cqSoUvzt/3g8iMPFBQ0L6r1Kz7c6yMdy0xQZQdXfv
         aIJ3zUzbYKwgOSfX0PSZp21rLN6MrRQ972yPgB+QEO1+VV9clnbxVVTK3M2q5mNM3zMs
         Mxt3X/H3lWilEYr3DHxWWQsC/ryVs4qaKhzViK/LWbMY/Z07dB9zsmBvUH8vQHL4b70P
         K6h/NYYBLKyH9BWH4woI9207W/16kacJz5Y+iq/5z3Z+NSjpbipBe9hlRF4DRKEbjoWT
         4JqLPGPXhwtvupQ6WlL5mC8vcI3bgRyjyz/HciW1m/FQzx5ELG2iKNJrvtO043IQWG2h
         cjhQ==
X-Gm-Message-State: AOJu0Yyt6MFmQtQrUkC9A8sVSBxJEuBThwhX8SH7RwpoS0mmm0pA3oFo
	sfWW5/7ayii7+Ue9rw8v0m6zkWPLlXcqP0EI7mnUGIap/jE0fA2XuT8iwg==
X-Google-Smtp-Source: AGHT+IGG5W0/syRA6ZbbjmKSOk6s4J759Mx9mMwOGDL/WrmcFyhmdqPEZvYDL27CN977TZKRSTSgSg==
X-Received: by 2002:a05:6a20:a106:b0:1bd:2a6f:511b with SMTP id adf61e73a8af0-1bef613f40fmr5747078637.20.1719847203063;
        Mon, 01 Jul 2024 08:20:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8d83sm66175375ad.16.2024.07.01.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:20:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:19:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 05/11] fsck: add "fsck_refs_options" initialization
 macros
Message-ID: <ZoLJH2yILjSQzuE6@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

Add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT" macros to
create the refs options easily. Add refs-specific "error_func" callback
"fsck_refs_error_function".

"fsck_refs_error_function" will use the "oid" parameter. When the caller
passed the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the user.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 22 ++++++++++++++++++++++
 fsck.h | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/fsck.c b/fsck.c
index 31ae8d57ce..ea00fb4790 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1251,6 +1251,28 @@ int fsck_objects_error_function(struct fsck_options *o,
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
index e611b3b65b..887fe2969f 100644
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
 
 struct fsck_refs_options {
 	unsigned verbose:1;
@@ -188,6 +195,13 @@ struct fsck_options {
 		.gitattributes_done = OIDSET_INIT, \
 	} \
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

