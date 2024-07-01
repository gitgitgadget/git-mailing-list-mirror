Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92F16D4D4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847172; cv=none; b=LVpTDPUbGIwJEBaGSMIdKjWYInnZQ6r3/EyTrjDWkVWSA1EiqRi2ps3cYW26uoTeWsAvMdwhhFyAbI9XWsH80qlOMwbD3xd9oP+4DSpkG9NMaabtyFO4v0O1b2QgF0k00glFU4xpiEMvBhZ9gCHPju1nuufGFxfpl+td5y7emoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847172; c=relaxed/simple;
	bh=LyT/a3fNobFZ/qBtr1Ep/9gNuj8Pn3GRv5NlobbiPBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGBeDQpQobdipBvxRDU9gmm+yd3LxGJ8DGgfqL4olW/byu+dHxttnEheelsiUGIZFLrMRubcFjWFT6EH5hwWLXkfPQJ+WDepLPVdERsKhC434krC9Q4/x3MZDx9B5ca9f1lcn0eqRHVCnSHQdHcli+RS76ySr/np5k/RFT6GVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2HW6pHn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2HW6pHn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa75f53f42so14193835ad.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847170; x=1720451970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTnAk1FJCenoFnbILdZkpFlp775NAM+IjbM/MigQhes=;
        b=d2HW6pHngdUOaiq0wOIOh0Z2iJs8jpRczTY/+tTWGNLMv5iomYjPgkdrcTKy4e+q++
         mKc6E2RNGBrRPjc0dfjQ1ku19roNNynl5IHFhyC/+SuPaHxWgtFt+q4VF3q6lMvrWcln
         v4NkHPLREZOaXXVMCyHzT1BhAXdgtw9WTnA2MB/OqF3+eSt43eSMccZarVFph4LB4lCH
         aEpuxaLisExRU4ThROtq6uMWgmXDBhP96VPc71TNxmV8jII3MCOkV96aD1ykS2nSALHZ
         3FgNwSiHYtmO/jt/DQlfoT6vjL5wyC984hG5Fw+IvBEfUcYUhq7Bw94gYgpv0osEWcGx
         GpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847170; x=1720451970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTnAk1FJCenoFnbILdZkpFlp775NAM+IjbM/MigQhes=;
        b=i2pS0mAwuyixXwkInigXRFtRWb35W98M3qcv58Wb2FLxfIHGsSZgRBI2gAQfKWTdjX
         2zGzvZyHSAB4r9q3y49AMMc9cS6nSQmAh4i1z9E7LTdYy4e0axhbJOoYk72vpb+u5XSt
         VGOZHUfaJj2DPEhZPtOTtDlnfkE97zaFuW/ctJvJy/IGAcTmTZH0O6Excw+SaT5Rsq7A
         0f7zqtQZP5IcuAB170BVG0HcTZH+B4+eTpzTxxpo9zrBZ9wruvVh5+8tEE6WsJJ8QK/j
         gnaEZXHqCOdHzOPjBTVIKnN/hKgrdMl8B3qO8kKew+3YHbDkZDwYQUCdOP4r4hapGAXR
         9x4Q==
X-Gm-Message-State: AOJu0YzdiTYjwkKpxLsVLYOi8wziyArtKsnkW+4Rpnyl9Tie26OP5MdC
	rBYuqoP7wJYRB61+xUwepoj3RFO7I8QM2OI7La1j5jqOwCZRElKiUDsN9g==
X-Google-Smtp-Source: AGHT+IE8R5h+DMqXX4+Z891cNcN3ANrmqkF41kIzqPIiT9w71B/4oK4+OrlS7H9oPmUtceAlOCJQ5w==
X-Received: by 2002:a17:903:22c6:b0:1f8:36f1:ac5a with SMTP id d9443c01a7336-1fadbce7b72mr38931415ad.44.1719847170102;
        Mon, 01 Jul 2024 08:19:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac155c382sm66321885ad.189.2024.07.01.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:19:29 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:19:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 03/11] fsck: add "fsck_refs_options" into
 "fsck_options"
Message-ID: <ZoLI_ip6a6fVXFMz@ArchLinux>
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

Introduce "fsck_refs_options" to represent the refs-related options.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fsck.h b/fsck.h
index 0c581ef082..ff7281b410 100644
--- a/fsck.h
+++ b/fsck.h
@@ -131,6 +131,10 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_refs_options {
+	unsigned verbose:1;
+};
+
 struct fsck_objects_options {
 	fsck_walk_func walk;
 	struct oidset gitmodules_found;
@@ -146,6 +150,7 @@ struct fsck_options {
 	struct oidset oid_skiplist;
 	fsck_error error_func;
 	struct fsck_objects_options objects_options;
+	struct fsck_refs_options refs_options;
 };
 
 #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
-- 
2.45.2

