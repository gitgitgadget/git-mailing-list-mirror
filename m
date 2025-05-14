Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481627F75F
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230768; cv=none; b=bQw0plSosnPOuuYnHP2qcRyIABuTDwPmwGWa7SPltKbzp4usgtbYf5RoqUQ8HKr7j9IkIqqWDm6MSPVY3qOdNnIetWb2XaVnEb+Ro0ssmYr2QZYFrMdQ0y/JHl6DZYGoRsU3RChUri/A48IynpoM+YE72w+8qWcexW6HyLDYqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230768; c=relaxed/simple;
	bh=wBgvLTmXEa+wzpzYfKPT/BRblgAb0TSGIbZy85CDnu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaQfupCAmZCdSGb18vUkOnPATuq8hQH80x2JrZb+/4sDqqSZL6vD8Ym2rP2srpYm3EY96A8WvxiQE85VrSPkgvVUigdizSUlgqJbtB1gQidqaQKy2F1OcgbD2T9SCZ4O2DrkiQH1jivq0JTHyVcdlkZ5Ay0CkYBEO0b1bLBqhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwEpMqs7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwEpMqs7"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e78fc91f30dso5959916276.3
        for <git@vger.kernel.org>; Wed, 14 May 2025 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747230765; x=1747835565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlgXRsYPYw+9YRGjyoSuj5lC5Kb9k2HN9PczRXo3yNk=;
        b=UwEpMqs7gHAG6QD7ueHGg1koyNSbKvgFBNzaj3zlB5sEfLqWCuew6tIjh5pCjkx1b8
         VUvHMcc9nWX9tfCktLTcxORBV2qfrhAeZMB7kl9hqMSAu01H/moH6UBbekugbn3uS8NG
         H9UGDBuH6r3r+yzodxkBs7L4KJuzTITXtha59hgCmZstIzNBxvpcnzEQ137EINMjahUn
         j6CWrEbqNmLALcTP4+8Xo22EeKehjvbJf9KkJT7nxLU3ZxJ89rq8C/S+INJ6lYRndKWb
         a85NUwP16/dkcV3qP7oifTcJT7/x9UWxOX2e+O8YrQn3R+HXcoILo/baMzFA+RGDfeMU
         QWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230765; x=1747835565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlgXRsYPYw+9YRGjyoSuj5lC5Kb9k2HN9PczRXo3yNk=;
        b=UGf1wWwViWG5fAY5rteIBkuxFdj/NGNg9DN07GqoUv3i5rWQRcavYEEZvEjWLdqlzM
         PkmNhGibBOfXT9vZv5DRdnpOSYQILog1CsWYqYsfBqFQ0MuAfVkQONK3Ctg1201R6qtG
         nrPUGLMjAlSk32i4eHe5SDSK5NqS9Q/sIobRkF9L1VhS3O2d69OkJSvNBhZ7CPZ8moRK
         +eHIvhaMyC4OIVi6DSvjZBAH7xmP6e1eQYLI15lrbpAc71sQZJzVGVFKpiyUJAXEUOi8
         SBiaUrN/WCVnHYFczJPsu2uZmxHIdT6awGEJOGbjFX2YiFhPmDGQyYW3Xl2K7l/80F9i
         +BEw==
X-Forwarded-Encrypted: i=1; AJvYcCVfAOnve4Te0A6XQZm2uhPqqGOmRNvlj9yblqd6shJVcaUUOY7W0A8ALM4gq8S7fkhOnRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOw4VQHuiYg4fOf+8SQ0f+KBUYGskHEK2e0tLb7LKFKe9ezu2v
	HmUxigt44JjgcPqmOl29A+wes+M0WABjb3WxP+VRZNBZTqKAT3km
X-Gm-Gg: ASbGncv/6khHyaROuBZfKEbcNC0W0HVP7BhnE/OXnsUJfDPd3a4STobPcjwXmG6oXHD
	CABLEH7L5INQzXk7of5wAYgg96Qu2h3fBf3exvbXgHGuGvk7Cn/lJGkBZDFH+kYPExgfI5O3k0W
	IGZeiMarUytEeea00330OQIf8lovJPiuPfIKNkMiPRuKsb50hM77x+JFTmP/tqGL9nBUG3e+87b
	HS2Qielh0cLv47VRgOmDTNkxjsHVcY6TtBJsYXKCNNYPLJ/qH0FviLEfTD3NelqyQMcNCUoXPFg
	B2at4BFXtqCR86PkrEGKXKEIPEfeveMIGO4AtYV9CdJh29ljnGb0m8x8fOFfV6iZoYra9cJrPzS
	chgGf7J7F05QfMc8ndXsmk+yrAddo++d3HYwf0I0=
X-Google-Smtp-Source: AGHT+IHOyaMV7fGZntRHlz/SJ4kQALZQtXJHqNdJIZ6oubCjYIPRXBAlrLcW+KLkFh+7tudQGm7XKw==
X-Received: by 2002:a05:6902:230d:b0:e75:bea4:5ea4 with SMTP id 3f1490d57ef6-e7b3d5e5f95mr4305378276.46.1747230765472;
        Wed, 14 May 2025 06:52:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd6518b1sm3170642276.45.2025.05.14.06.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 06:52:44 -0700 (PDT)
Message-ID: <7534cfc7-751c-488c-9a98-6f422e5d0a81@gmail.com>
Date: Wed, 14 May 2025 09:52:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/4] scalar reconfigure: improve --maintenance docs
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
 <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 From 0f5dc1cb6d697c7d8d3c126f3640c2f58fcfda43 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <stolee@gmail.com>
Date: Wed, 14 May 2025 09:50:32 -0400
Subject: [PATCH 5/4] scalar reconfigure: improve --maintenance docs

The --maintenance option for 'scalar reconfigure' has three possible
values. Improve the documentation by specifying the option in the -h
help menu and usage information.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---

Adding this extra patch on top to improve the docs. I could resend
as a full v4 if needed.

Thanks,
-Stolee


  Documentation/scalar.adoc | 13 ++++++-------
  scalar.c                  |  4 ++--
  2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 387527be1ea..4bd5b150e8e 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -14,7 +14,7 @@ scalar list
  scalar register [--[no-]maintenance] [<enlistment>]
  scalar unregister [<enlistment>]
  scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files 
) [<enlistment>]
-scalar reconfigure [--maintenance=<mode>] [ --all | <enlistment> ]
+scalar reconfigure [--maintenance=(enable|disable|keep)] [ --all | <enlistment> ]
  scalar diagnose [<enlistment>]
  scalar delete <enlistment>

@@ -165,14 +165,13 @@ reconfigure the enlistment.
  	registered with Scalar by the `scalar.repo` config key. Use this
  	option after each upgrade to get the latest features.

---maintenance=<mode>::
+--maintenance=(enable|disable|keep)::
  	By default, Scalar configures the enlistment to use Git's
  	background maintenance feature; this is the same as using the
-	`--maintenance=enable` value for this option. Use the
-	`--maintenance=disable` to remove each considered enlistment
-	from background maintenance. Use `--maitnenance=keep' to leave
-	the background maintenance configuration untouched for These
-	repositories.
+	`enable` value for this option. Use the	`disable` value to
+	remove each considered enlistment from background maintenance.
+	Use `keep' to leave the background maintenance configuration
+	untouched for these repositories.

  Diagnose
  ~~~~~~~~
diff --git a/scalar.c b/scalar.c
index 847d2dd2f58..355baf75e49 100644
--- a/scalar.c
+++ b/scalar.c
@@ -675,12 +675,12 @@ static int cmd_reconfigure(int argc, const char **argv)
  		OPT_BOOL('a', "all", &all,
  			 N_("reconfigure all registered enlistments")),
  		OPT_STRING(0, "maintenance", &maintenance_str,
-			 N_("<mode>"),
+			 N_("(enable|disable|keep)"),
  			 N_("signal how to adjust background maintenance")),
  		OPT_END(),
  	};
  	const char * const usage[] = {
-		N_("scalar reconfigure [--maintenance=<mode>] [--all | <enlistment>]"),
+		N_("scalar reconfigure [--maintenance=(enable|disable|keep)] [--all | 
<enlistment>]"),
  		NULL
  	};
  	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
-- 
2.47.2.vfs.0.2


