Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DE7E56B
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445701; cv=none; b=Ch5+ndUvRCy8dBxZ476UGnFwgHw/xF3bdoihHWrVyxQNsdHpSbF/gR/db5gM2zZYqJK0Vxts7wflIhuhLX4GRxzhsgdDo4aqYcbULQwwWLQo7p9nP3Nd88GRMEpO8pzhu8qfYv817E2IibwpvweaNEJRR8CJnBZTNoDoFWvVH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445701; c=relaxed/simple;
	bh=nycjV37TTb1EMpM2gyThgp+bmn7jaBmTUoyOy0ApM9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXMSDFhLESHr6Bn8JaR3zzlXJ6nsaRgEyP46aRuICplR2t6I6KoFJXmTiAh8+a0xOPYVoIFJtYJXsqLsVzlyN1qT6XjZKeZX4di3Dj25rHZXurzOmML3V7bXOdZuVjjUMp7EJLotOhSbNX9kNwt0RJgGPWRp7xdfgoHZBACmcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqsYVlte; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqsYVlte"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-710437d0affso2040768a12.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445699; x=1721050499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq3HFRiqgeZP9G/nbnXlXeDs48S1/9Pv3Tpl1a8zqCw=;
        b=IqsYVlte7TQyS3LCpEel1PHkhzmAKMmnc8cBDm2P1viP+EWOJkuHNicR+UtD4Kc9ET
         /gGRNU+fGUvLFd5JTcv6MWvGB7dADoseNdU5hjgUbtnnzedsyInWYKvx9/OdFes4VpMr
         5gP3HouZZstfcyYlFJPIaRaoo998uWL/ZLxhV+3jUyiZ9jioUxr3spBXuCL50NEzGL/K
         6ukB8X9MFd5tYLwnoIayzmpoeaiYwXR3zm+24F067zzHLDp0EeXVx3itPvhT2QVm+iXE
         +ehdS+7sBtIORsk49oED1G/6+4w/LvRplhzxk2PKB82Agd4yWjqsMH+Ytl8xD+Tw0jAV
         VA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445699; x=1721050499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq3HFRiqgeZP9G/nbnXlXeDs48S1/9Pv3Tpl1a8zqCw=;
        b=uGFu3hQossgC9UShkTyJ5rCFW3mJc2udZVboOiPRo76ZWca67gEJx31BkmgbSDPgHj
         /TKNLxfNRr3pW9BBessBxhnI+zQAdUG91wv7N3BGNVIfEye80uHid5rsktZljr6+s3Mt
         Pr9UMt3HkRQKGb0lUPieaPl6BW85MG+WRsWajT134RVbjCLmOp8FVqoTI3hKNAiq8BGe
         tHZ+muYYvhC5o9F+Z6PtCY4HZ3nJIBux5obcKgZ+ePn2W+2iXTamGhyA+m+r+WGfuAVn
         nzvD2aVEeQ15sLBQ1+ZttskyIi+QM4FSMj9brkUk2isrYGSx3GKkQZYZ+ZwR/Z0ZaS69
         rpkg==
X-Gm-Message-State: AOJu0YxP3et0ZqnUnlj0RiwDLpJfvq0f1oaxCsp/avc/6uWyhzMEpFpn
	NeapAACluWg7C/0OR/hdx0019EhkI5Wo0rGtFIe88DBMFx9QBV2h9paxRhqy
X-Google-Smtp-Source: AGHT+IE8irY1HiaQhenUhXnDT5TlilNz4MMXF3jiRjFkE+rkJ6wOfGzD+EDlduj23g0viDb9Y1CICA==
X-Received: by 2002:a05:6a20:3956:b0:1c0:f2d9:a45a with SMTP id adf61e73a8af0-1c0f2d9a76bmr2583751637.1.1720445698457;
        Mon, 08 Jul 2024 06:34:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb93d6a240sm19913415ad.291.2024.07.08.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:34:57 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:34:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 1/9] fsck: rename "skiplist" to "oid_skiplist"
Message-ID: <ZovrAe_P0vf9dbPZ@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "oid_skiplist".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..1960bfeba9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->oid_skiplist, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..1ee3dd85ba 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset oid_skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
-- 
2.45.2

