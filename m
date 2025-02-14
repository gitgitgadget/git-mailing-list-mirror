Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE281C84AC
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574152; cv=none; b=cAR4p2ICmu93NO1SNIbk84/ulR4xKjlOFZnJ3tVcoFPrL8qA6rJhICHFcbcfBi1xyVEydF7YiGOfhjl1oBvKwJl7xWrTkgxNXa2+iK+2ts7CwxsF/BotN4j0l5Bg8r3NXiUC4P1ueqk5rowvH862lmIKbHAuuRfIE0IJaLKRVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574152; c=relaxed/simple;
	bh=X7xjuDEfAOz86RnuoIVN5/mhhZuj0sVqm9b9mwWcSUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCtyC8fZ9MJB1AHbHbjI1e5TC6U+BzvGC6k1gy2YRZsjY0cdlhQ2NgqPklMICMUIvGMJ8Ah/C5YASby//Hz2beca01ju/Pxr6VBAzdm5B9+XPOFCJNNLrfoOW+VVftIJTluiJi5zfvXT9aIFJ0WRg8n63LMRF1rOQGS+VtG1Xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMP6T07u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMP6T07u"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f2339dcfdso40368015ad.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574150; x=1740178950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RENv/JkGIHtFGSPxuODKhFNXAHbrnX0mE10E35XZaIk=;
        b=fMP6T07u/+gk92VfswIpKXb+HpBL3fr1MoYLezeCe72HomNUXlKuaaltb47qPEUkWC
         LBrhedyD6usaiLglajcx+NuEvXnayhx0TqGci9gI10uPJuCqM77xkDFlgPq86HfFdJl5
         py1OtptUxG56rf2A1DTqMioESijnWpjoog5JwkHR36fbcBUdEYAKzLofz+Gggo9oQlz0
         ptQ66Q/uksrwu5yR7a/VwDSwrP25BvUELr5e4L1GE3iZFxR9EwMJtrKYXw1EJX4RRHpT
         80o+CdsZGj70+dhoibx5HQVp6wIxloy4magZp/Wb4T8hA7Y0J5hRqfVusP8ttQhFonUV
         wUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574150; x=1740178950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RENv/JkGIHtFGSPxuODKhFNXAHbrnX0mE10E35XZaIk=;
        b=s83fyvwArvicxNW73GCJbXv1X2NDKKHYRg/E1IjYEZ1xJ6cwMnQSWHln648Ilsge20
         jaHCTWCy/KRT/hdOKZuUhtOxiAxGdrppjZ2VNhXqTkzCFRwGTd0g2xXIUWdEXk1Uc0dg
         rmWMcu5azMUkpVN2t96p5L7YEzaEMzUYoUmdH8gm8g8OypWD7cWdW0H/2EJMzjekB2Dx
         bePZyXgjyVeBMEsBqfatbr9znmoEQ4NVF3wF6HjcuKK7tGX3+v2s/qkZwiyPaItZRYLo
         sguZ9A0Oaw2x5i8UoURDla1bs/zk9Dgct3UPRWGmBHohKR1uZz86u8I2wC23mgXi/RxX
         Jh/A==
X-Gm-Message-State: AOJu0Yx8BkYMdEpxFa0AI/BXbZA6O1koWAhKDKhoEfy5HyRGjS13UZKz
	eWXRMS5y0rFyAMI7LnIA/AsHGZkcCpVe5lvzs3D7Yn8UzmLsXDJ59T1iFaaa
X-Gm-Gg: ASbGncsjOTR67eoiCtd/9GjFsAV/5wdn2QHLh1xwBIqnvVvZKvGlKY5j2wfDyhre+6+
	Fz3sCoDnWuY3xUbPWluZxkd7gopGh+SfMLUfRtHI7+dWGG5pfBM3r688fdG4NbUpUqV4vYMoOwg
	fBmd0hm2qPOOKV4gOSi9tShwtKinnAtyb+MoFhvZe5jrdZY/XEPkQmuHhtWsLYV2qI7wN1sbL1T
	P4dUl8Ht8/QmghKf/vkXJv/YEd+Msdmwr7EW3hUsxm8iqGS89tH6sNZbsz25hSCzGiYBKPxhenC
	cue+DfnHDwInhVZ9vK2NnIXijJmncNl7HSF2eO8S
X-Google-Smtp-Source: AGHT+IFxO1xiimFo9yIYfVJlzSYGbEsXpHoygvFotvXf6LqK4SkBiUhZd4FmKaBbvRYtL798kiDYkA==
X-Received: by 2002:a17:902:ce89:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-221043951fbmr15616865ad.1.1739574149522;
        Fri, 14 Feb 2025 15:02:29 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:29 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 4/7] builtin/pack-refs: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:20 +0530
Message-ID: <20250214230210.1460111-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/pack-refs.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit, without having to consult much of the
configuration file. So it is safe to omit reading the config when `repo`
argument the caller gave us is NULL.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 4fdd68880e..5c18230b6d 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -15,7 +13,7 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
@@ -39,7 +37,8 @@ int cmd_pack_refs(int argc,
 			N_("references to exclude")),
 		OPT_END(),
 	};
-	git_config(git_default_config, NULL);
+	if (repo)
+		repo_config(repo, git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
@@ -52,7 +51,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
-- 
2.48.1

