Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEC22F167
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997275; cv=none; b=WLkSAbacYsiu5QnJ+fPUueHmrgVOnlimrd06rlyY8wRwURLBxuj6U9pm4n+0RSerWuMqKqv5+KMfNffPI1I9aP8soby5t083igjbkh3/eb55hHJickif3i8PwwOjCgZ2RbLDxR6Qx872Nee8AaUT+jZtGlXxxDxQUa3AHnGYpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997275; c=relaxed/simple;
	bh=+8lhNbO8XPOdY5A43YAY7YE3kig8QN5Jq9lbPzOCfIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+EO36msfkxR8OCO1WMhu1Ad1p0R+thTY/gmaUrGbKvDpVpWFsQth4gzlOvYJpoerQPzZL6oBht4DDr7DxMzUUP31H/xP787aS3vfvyiLe+J41Kq2NxcEgxrDfNPCtEVtzRPKNzEizA0bDje31JQwxbgTcAja9SDbnMewHP00kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xpdrrl8a; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpdrrl8a"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso2761835ad.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997273; x=1740602073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/46wBVN4NTNuX5Jw8zskBcm1kjlaa9e2wbbYyQJRjro=;
        b=Xpdrrl8apRU+nKkUV6zuchVFD1SDjL0j+yrahIjGYmOIoGZKtAF01TtCpEbPJRAAOk
         H0wQRVwckBfaK7etRzLqmYnpUNj/MR/UeXIfqFWf+vXdvKIlR5sMN76Kwn45xQsHLxZX
         hjbm0vDueyi4vU0jVBvOvXSIw5egQuRycVjOA8bLeN6UfempKCqhyUvitxUhX+Qlff9d
         25rDsiLYbYPz01ueFyGa8YHlJKLA3pqi6MHlIp0O1IohlWQ3CDKQFDOr5KTY2Vv+FJw5
         Ub8FbF1nEkkoAqGIRUsbxruUCUqwtuAfOGkyM0bcCkLKZ2U6HKENHxVPpOU4tCilVwQq
         dOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997273; x=1740602073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/46wBVN4NTNuX5Jw8zskBcm1kjlaa9e2wbbYyQJRjro=;
        b=GMvhst/Q8MnrfzLtD7iycJpIHFoInvwHfjf7qPkBTg1Mk8DlBF+NXtpkIdqLCz30WF
         yTSvtyQJUJB619TVdNCZvfRntnGfy/yHKpD0DjSsdxX/ovUEIOgKI9GS9+koZM2H5jsc
         BfRZy0xSb01duM3skgnk/3Uh4CF60wM2UbvnKpRbDw91ezWFO4I2pfzSXzeVKAUAT+ti
         4/ivq7nREmVK60ygX9Yl2PmQ6uQYz4LAnFQctmqJpdZMeQp0NSprNJ35/dI7rY7Ylc4O
         /YUJNMHDxOMx/aDKIXlEEownG07ehuqtJ3KF98aYcP41V3mmojugo52VTZAlZxW6iz0m
         U5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWGy5DDyj+5alqtI2nvrLQLGBcAuLMQ6bXqYcKRisMg7w4wiZhcJ6eae+E9U6UZ6bj4Kts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/t0yrqGxF7A+5ZWR+hL4z+xKkKUt1OgIgK7mscni2UsCGpNj
	19ILOq7Gd9buiuU2ohhjS7BkQs2b52i3is93pnTPj8ktzXcQk0S9
X-Gm-Gg: ASbGncsifRnF9ZHfh4SLn9jcJRbwvtPLmVrbOA0oWBDBqipKC17KTcOAKyFXK/vRC/e
	LglKHFahPtNwRhV6o51kuktT/kVuVQv0UAt+zUOdKBcMJwJ4Dwj2cOgwyhbyphYVR83cdCP+MDA
	vsR7d7SP3tZFDfEHv3A0/alZNOVcJANGmlvKbVsH4802RSMiHWYTa83DUW3zqud5efYAEuohhPs
	5v5wR4V/3lL6No8PA8dKCL9XysrbkaAbTtF/6xcsJ5ypI2S/g5lB/J044R9M7ZJHlXWJPA5D97B
	O6ErFNed4f75juiyc+NIHqj9aHIEJwNVU+Gl1IRj
X-Google-Smtp-Source: AGHT+IEqcrRYaw4VtCjKX4lto5gSoiy5jyTugTIqe2xrgYTTCqcBOe8anht7cmXssnfAPAiC37u1zw==
X-Received: by 2002:a17:902:ea11:b0:220:ea7a:8e63 with SMTP id d9443c01a7336-22103f19fc8mr296754705ad.17.1739997273006;
        Wed, 19 Feb 2025 12:34:33 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:32 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 11/12] builtin/for-each-ref: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:59 +0530
Message-ID: <20250219203349.787173-12-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/for-each-ref.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_for_each_ref()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit, without having to consult much of the
configuration file.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/for-each-ref.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 649689c92c..0f73f47fab 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -20,7 +19,7 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
@@ -78,7 +77,7 @@ int cmd_for_each_ref(int argc,
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
-- 
2.48.1

