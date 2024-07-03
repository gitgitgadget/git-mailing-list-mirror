Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE685624
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014993; cv=none; b=NUvSCXlEajt+b9PJB5II+Zpqul/QdMtvmCvq3NUg0LVzpOtnZI2bS+0+udT3Mykr+XfzHPNE3K2qa0d8t+l5x8L/q/tYGMmhoA2hnz1fJajcIPa7dFwe3ZTUI/wIdF+gSnbwW60u15pbpyYah+6CsIRNXKkjXNrpDSOQc7DESek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014993; c=relaxed/simple;
	bh=J9JhzgxVnZi7kUwjZIrWhFBrhcDDsErZrHgSE8TNrHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHE1ITsohO02+fQCUs6QbXpUTpa7iGMQrwHPu+3Gge8J6uiwBYWL1YLYfZxQjHLHKyk5UyD8ZvVKKwXzb97B65KsKfefbP9lsYerp5AtNxbJKkPxN9+ccUMHtxUJLDOTouU5UX+64eDiWb+DQP5IYoTUNk/U3Ua+scnPblNqqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3+BHr5O; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3+BHr5O"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so3269196a91.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720014991; x=1720619791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh8siMXxU0DDHgTSZBdEsJyfN+izXvs/CbbfSpXoPos=;
        b=a3+BHr5OIqIf0NQVe6u/WjbzfXaG2e4bNPsseg6YCCJj46QjiR9drXXzzOkMFg1hIB
         Hf5JtPe1D9jxqT543YWQ3jvrichtVy1AsR/Ioa4n8A1lzbtyqMmIAqPqb4i0NerX7qkH
         PrFHaYYMAuUWQUG7S3da2R1klfG3ntG1H0+XOzZ/g4Ddp2HT28xtt7YFTYDimUIsSGJC
         ocJ3ZS7OGtFK8bYggG8NE5/AMo31HlaNNZ6rLz20wxt3RnwP+eESe7rQTDEhqbIqOc02
         oZkLZy9ugLh949mvMbOf9QZzOMKRLi5AaUj6avO3P83Bepu4VREqGFrwZsCeAaBtkdkq
         eGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014991; x=1720619791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh8siMXxU0DDHgTSZBdEsJyfN+izXvs/CbbfSpXoPos=;
        b=M/vY7DEsaM3vKHXitHwOweBr6bnhKA7uobYdB9zcNb0xshct+h/j8bzhP3iJwpxYay
         TMTwAm5/zkfJhUXIueMigruuOUC2CClehi5ZW2l9R0YaviNkxFty/ZYQWs90OtJt/pqa
         VHpViRLWvSfQT6lJiXDhAM0jtzsZfU3bOTDVNaFTMPZ/R6cdf6DX8yKzqDl+l6Zr5EBn
         ZLL6sg1WRC8gxyVanol+CvAz7D7mF8aZMbBxe2X6mhvIoob/FoA+RqKjmxj7w2hRF3x3
         3dxmcdNtzStd+Ky7Xxx4dP9IeOykYbUzIR0KmizoppR00RRFhftIVpUG1j2Oz8MBWqsj
         fkBw==
X-Gm-Message-State: AOJu0Yx9m2npaPx9aIHxJmC+mWG0YZsJkP/Bdz3Khtr5VC2bigF95C0c
	PQ8LoA5W3RK4Vi1Gw8CSVUKm8JdKnA7T2BulzEMY0+7Q1RegSHF0UY3C8Xo1
X-Google-Smtp-Source: AGHT+IHKercpxulnryj6F6PLRMFT0Cs5kOrf1zaqu5SqLDYy5AO/hwe161lC2HDn0z18NpeqdUn0LA==
X-Received: by 2002:a17:90a:ce82:b0:2c9:6c18:4ae5 with SMTP id 98e67ed59e1d1-2c96c185396mr2375180a91.46.1720014990836;
        Wed, 03 Jul 2024 06:56:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce6ec6asm10877558a91.26.2024.07.03.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:56:30 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:56:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 1/9] fsck: rename "skiplist" to "oid_skiplist"
Message-ID: <ZoVYjrfCFO0_K4Ry@ArchLinux>
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

Because we introduce ref consistency check. The original "skiplist" is a
common option which is set up during handling user configs. To avoid
causing ambiguity, rename "skiplist" to "oid_skiplist".

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

