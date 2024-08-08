Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFE12C7FD
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116227; cv=none; b=Be8A/DzXf35P+uxCxSHif4eBZhmeQNepupdExjzslWMZWLtmpcfn00Doiff83W/LBkqU+F5HMpwi3Nug5xc5/GqecWs50YstKdjPIzZO2RJBFxfhjrGhzd7mHoFmQAVibRToRYBaf4cFeC89vg/PjtcSY7Uld1E0rY4a73GT57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116227; c=relaxed/simple;
	bh=amDj2c5gDZRBhglehafDqExLCk1rzcqUdwLMoGAS4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxqCPxznSdX53TT+ydvwEI9km6VT6J4y/GPGgCZBjXx5VYxZN+BFOHKj97IzMQnZfv1rvH8dWPzsR2iXdhTYE2AWxZsCL5NHPqoffNoW053QkX17d1HK2X+D8HMHkVpaIs2DyPpx8E/yRPgJnAz4FyHpT5gJq+zcfVtnLe2X/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrDzSmZK; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrDzSmZK"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3dc16d00ba6so615485b6e.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116225; x=1723721025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijt50yIi5MF0RHPoiFN0m67WlBufRjXujnKRkvfb7lM=;
        b=NrDzSmZKzm4prmBOQ96t8pCSFgJqjgKpZEAGjjdUnklDsu0KYSIG+K/f4KgI6/QzIe
         SDUStsqOHlgGrahOEvweTuO4u0jP1DXD67/VSLt7DNucqThj8CV3SnHqvoABICumSOR9
         yEhz0b/fDxrkP4Zvugn781YiqXVzhzTfIUB2u7PdDDZeXrQzUcXi2ndVWRCN4SR5+M1z
         cDayoyUmwIyh773NcNdAqZGAg3RxXKs8jQfkcGiHKq06yS1aKnvxGK7xTOyiuHjG/+/t
         JuChS5Ci2A+oSghDpfNsL6AfhNizpWObI8OBCKt9riPc/RdXUfiXdfhpKtnTnb5o2nXx
         0iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116225; x=1723721025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijt50yIi5MF0RHPoiFN0m67WlBufRjXujnKRkvfb7lM=;
        b=m7/A/Ipw73XeC4WbLYmyHsmJb9XpiWfIgQfMjnfKd+PVN5Msc3r6Ryq31AAEGG9avk
         Dt8oB5+wEBhK3HSzHbpME1jvee6oZ+P/dCVuYj++ceKkDGgLBMvB74HXT0bmgwGflvwK
         dyaDZJvcrvT2GDmoDG4/p4Q0mR7EV3ejGUwu1+7n2BOA6ixvqkGXTvZr9atm5IRp+4Im
         PjvdJTgZIKcgH9XCTplAMiV+6T99WrmPPXSQcqpbjgU4Jg6dohK9AXdXIC+yPzSYwopp
         SaTUt5OxIni8pBdEifR1VkizLKNQgZvG/l8TXpC2g0QssjowYSv6gmHz4NTkV3dawUl7
         9DHw==
X-Gm-Message-State: AOJu0YzlvLKQdbMJc2QurCAnOIz6LbHCQgwAvzoLWf+b6U1q9NZEgoDP
	+KpFdoB2At20g/U2DFVHcHn20ayaIcyvvK2OcFzMrD2FxZ9YNSa63EGM2MssJHM=
X-Google-Smtp-Source: AGHT+IGFAnho68lKzCre3hfBI2Fw3dkiCjM+w7UJmcD4wh0MTV/mx1qbcF2MXKWHeMCZBIN+vJ6o5A==
X-Received: by 2002:a05:6870:f69e:b0:260:f97d:6473 with SMTP id 586e51a60fabf-2692b78b6femr1783315fac.38.1723116224726;
        Thu, 08 Aug 2024 04:23:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a08csm950979b3a.31.2024.08.08.04.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:23:44 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:24:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 1/9] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZrSq3Z8tYrGwBOqC@ArchLinux>
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

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.46.0

