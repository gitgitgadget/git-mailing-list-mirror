Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12D23C8B3
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997271; cv=none; b=BIUjn5zLpeLVgTAmxtnk2/T8kWgzMsXtDFX0KQPt5pZgFsQS0+jPI9wSo5iyYZaAaqkwbnTp3Z4cmlpxVGBiAD2XEKzRRDle3b4hnD3TL90xn6b9y/xiaWCS6Vqy8FPM2501h4CSNc7noWK5DG2KPuu1UqVqDJBLQmRmw8tXsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997271; c=relaxed/simple;
	bh=r/dQdrA18FPS6wqf9HgMJ8hjxkc9IynhPHZcvS46bFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsnm79t15abGMDcNAzT/WoEa3fQGF33Vw0CFYGq9ipmPyUXnly0DWdlY2Quzx+90pPvD5arnzxhdOKD6hEGjiP6DA2XBKaOYxlx2k+8iYyTrV9VtC503X6PnLLhmd8GL9PJpto0JkqG27zSeQkIlz6/qOs45isAtK7Q93NCTO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtSkm8ZB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtSkm8ZB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d39a5627so2446245ad.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997270; x=1740602070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etws9vFdvPOXGxA4DQzZvLi6rQk0V++mAQK8vA0BNeM=;
        b=mtSkm8ZB3ETNvu+6QvADscWFDLYly/fcehFNNr4+dmgeoKnKJj8Mz3GjMroi/0Z2yb
         6iPNU3vfPhNB9FewQzGpXXAiefPBt+gq4qhoPBT/G/5fufgM8iME/NUkauCgE9lg4Fn3
         fAQc364seX5uyAzEdWwXxvLjIb909I+DsWc/8gm1Ay1jbKfJ1BYfbcQYgSSCd/5NPR6m
         CkeIYJLjOqHBJBVffy5i3gjLE2qhV8UX32wmCedz8AaBAqS3B8X58lidIUbDXEAZvhVn
         DjtR6/rrqHhAIv9iKj/fMpcFkBp3QVFOX5DY/XLHs8JrIz0LOtXQzaRRADzlO3deMwVR
         ZV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997270; x=1740602070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etws9vFdvPOXGxA4DQzZvLi6rQk0V++mAQK8vA0BNeM=;
        b=qQpGmWkHUidmdsQK+tcqv07FWL+OjqDmlh9+eghIIcRw2x+WV9oO/Ay13vCJ+vQV1b
         TWBN0Q0GxcUGKrWickKi9sk+roCyaeUmRrTPhHSzyMxxxwEyiS+LfIIZwBfatn/Hh5Ce
         YIJOftuhhRnvufRPiLVJjPT2sA2dImpl6pt3qz5x5HqRJZ7cIpJfoW2Fldducia8q5v/
         5i4wvrK4Gby9Oepc34LBxe703ot4DEPaN9NOaLwTyrqcqNVDQGZijEuHDiHA5Ds+5zV7
         IBa+MQB7n7Ec5wxIPE78NZKknzXzIlsjp8i5QjRmGHW77NZJ46mklAaPGrbPICfN9IDU
         w6mg==
X-Forwarded-Encrypted: i=1; AJvYcCUaat2+4LfTTFBPAUWR4fk7quoT2gAOVeiDFmN3iDLEKng+DcHQiZVLDd5Zpz6dOoFgmEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSbQt9an2qIhQTePuJjTw0cAepk0cdbOcZ5OHNCZ6X6opWb7F
	yB521tZuJ3RNvj+gAgYeFgUxhhWrLU5g4fFLIuUqQXi0aspMtigJ
X-Gm-Gg: ASbGncs9/WzhlqkOu3vXZx0vfJjuifykGH/ZSBez4P30F4M/YaTMNn6bbGkf4o7UUU2
	8mnMhRRilcHeGc60ioaQo6pJBpghIqncZT0cEdzNzEmAU3k7XiYPuxc8s4hupBp9RMiYo5df1H5
	tPkb1svjgurjdZQaD8gmgzyraJRjrCJbK0Je1wR/moQLG8RS4csINrNVYRaNQq/GB0wkjMkyi0a
	JaToQRvFZlm2CwCkGDGf+/7+sxcPWsANCsnoUPveLigESofGbDu9rcj9J07gUXejngchy8rZ9NM
	sj1XbbMEMuMyN186IiS2VqArY9xWdM/La46Oh0jr
X-Google-Smtp-Source: AGHT+IFLtSU4s0iQhFVJZYJLNziRO/IBjvObxYQcsbrr4h2roSOKFM3p6KD0JO2KjhqlZD0IE3aeSA==
X-Received: by 2002:a17:902:ec85:b0:220:c911:3f60 with SMTP id d9443c01a7336-221040bd357mr314775645ad.47.1739997269705;
        Wed, 19 Feb 2025 12:34:29 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:29 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 10/12] builtin/for-each-ref: refactor `cmd_for_each_ref()`
Date: Thu, 20 Feb 2025 02:02:58 +0530
Message-ID: <20250219203349.787173-11-usmanakinyemi202@gmail.com>
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

Move `git_config()` call after `usage_with_options()` to avoid NULL `repo`
check.

When "-h" is passed to builtins using the RUN_SETUP macro, `repo` passed
by `run_builtin()` will be NULL. If we use the `repo` instead of the
global `the_repository` variable. We will have to switch from `git_config()`
to `repo_config()` which takes in `repo`. We must check for NULL `repo`
if `repo_config()` comes before `usage_with_options()`. Moving `git_config()`
after `usage_with_options()` eliminates this need, as `usage_with_options()`
exit before calling `repo_config()`.

This will be useful in the following patch which remove `the_repository`
global variable in favor of the `repo` passed by `run_builtin()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/for-each-ref.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8085ebd8fe..649689c92c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -63,8 +63,6 @@ int cmd_for_each_ref(int argc,
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
-
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
 
@@ -80,6 +78,7 @@ int cmd_for_each_ref(int argc,
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
+	git_config(git_default_config, NULL);
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
-- 
2.48.1

