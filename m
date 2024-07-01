Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55B16C86C
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847151; cv=none; b=VvEBIE5gV7MvWgZrqBU7Jo4rxK7HZGVCOlqDC8wlwqScwpg4gkejdl5ig0dBoGdCejuUAo3cSkGhrgESE1xRi/xhAqieW21oJG3HVFxWNKiSpYEaJ634H/y7p/25GV0qCYwQl9Nk+WKTuHahuqai7ar19wEgJd7AziKf24vdQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847151; c=relaxed/simple;
	bh=dsaTLS3fn+VIVojIl7dTSvZY6EgnBwo84f4JcqcZMm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUz/YE8jHicQqNnRM/ZyXhxJPyAuRGbGKSGfbuRSNzPVXDgM4SQZ62iLZTNWwaNQeLJi99Rz3zzxqdbmnuVF7xHba4sIaIjP1nP/2Gv4c4v7mXezTW7vNkhuM+ZVV+k+iCKmgfX1m5HfIwkDU98WupGk0VO3udnzvPyPqmBPb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWyhOxRq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWyhOxRq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706683e5249so1913348b3a.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847149; x=1720451949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnbI6Cvo/G3iaJXJWddJFkMbbVKogedsLKFcUq0PrK4=;
        b=fWyhOxRqa2AA8Gg8H0NOS0Z4NFkgcls3ACBzMexx2QilfWoBa3LU9p2MY2N7yXAguv
         463eUMH4wMyH43kzUz90N5VcX3T3m6VOKdNsWSO4xqqpocMEfSZCCIjkOFhQ+oECbhsF
         RfjAXx5FI1prgNRBLdr+bIOvkAqZ7VNrFElst+bM/DOODBuyifLgzmZDSq6ESrvWorDa
         zIa04fMg5MeJZXS9ao9e29wus9UZ0Uik8eYG/qijBR6edQHKCCQfajoIw5cur7ndVXIc
         OXPPsvxAeM7Paglad2QRV4aG4kNmT8JDWLf09O7yQI89Lk4sAo/eWJmZBG8C5+WOhsuL
         Gqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847149; x=1720451949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnbI6Cvo/G3iaJXJWddJFkMbbVKogedsLKFcUq0PrK4=;
        b=GNW2l45vS3AHYHQYnmxTi56b+MciMqvWRPs5pCgSSFzaLsnYeZwxobDKf3j5iPqHRL
         09yz08NE1LmwBFgrMJc+YFEygS097KRGHTE/Xu44GA9nKiw0u1Wb5RtA006GIAM9lhO8
         sPTf0Cd0vG15IWTkQHDL9QBKUjzX8Yr64grN1azfAKn7pTJx3JKQLNYcfA8ylM8hVVkA
         FoaFsCkHwPF+EexWXheqlRIY7CwLGrZGNDj14mn+OzPbkq3o5rG8h0REKVQdSXS7YEP+
         xnbbPkc0HO/N3zzyFCVOBYEEPXMtgjaZ3EJrpZUkbvk1eqGxO0sb6CY0v7bTcbgJVDBJ
         yFAQ==
X-Gm-Message-State: AOJu0YyvZ59j234bxVFxkSuFkQbYR7GkX3eqNDq7HZQYvsYwO4FA0HP0
	hhF5mo/x0WXn+qPOticxL3fzlQSL2H6AhSSDCFbXY1zNn/+Gae9BXCCNCQ==
X-Google-Smtp-Source: AGHT+IFDLIWNOCMlnoV1Xub7b4x/V9Fp6P3Wb60k/DEFr+lFuXU5wag+sLOrd0107iNWgHQb0QmXIQ==
X-Received: by 2002:a05:6a00:218e:b0:706:5f74:b97b with SMTP id d2e1a72fcca58-70aaaf10da2mr4134991b3a.23.1719847148828;
        Mon, 01 Jul 2024 08:19:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708024694basm6628151b3a.51.2024.07.01.08.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:19:08 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:19:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 02/11] fsck: rename "skiplist" to "oid_skiplist"
Message-ID: <ZoLI6UU5utHX9CV5@ArchLinux>
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

Because we introduce ref consistency check. The original "skiplist" is a
common option which is set up during handling user configs. To avoid
causing ambiguity, rename "skiplist" to "oid_skiplist".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index e9848f2678..04d0aa1766 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,7 +203,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1);
+			oidset_parse_file(&options->oid_skiplist, buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
@@ -220,7 +220,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 37b6f6676f..0c581ef082 100644
--- a/fsck.h
+++ b/fsck.h
@@ -143,13 +143,13 @@ struct fsck_objects_options {
 struct fsck_options {
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset oid_skiplist;
 	fsck_error error_func;
 	struct fsck_objects_options objects_options;
 };
 
 #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.oid_skiplist = OIDSET_INIT, \
 	.error_func = fsck_error_function, \
 	.objects_options = { \
 		.gitmodules_found = OIDSET_INIT, \
-- 
2.45.2

