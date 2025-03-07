Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283F33DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390557; cv=none; b=RS4TBt9ehWf7TGqsOE7SxwsOyRA+sgqgFzPWuiJ2Fo6z5/F0RLv2+8SmyKDNcYWq8m0SUp2gfrNGcIN0qgyLyUqgP04sFq4lCgIzvIPg1/Srj0InFTqNPTyxonmCd3gH9XTB1PYZRZWKpiF62jZv90lMVII4yqrBl4D+mTn808c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390557; c=relaxed/simple;
	bh=JAJbSWuFJgB3UDNULyyBg5saO01KET8wLRD6PmDumWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8hmIrl6ZLdMrd2+Ss2hy8HbIsM0byYIOicSjO/kO7TMnXBbw8fjxdQdxkmuHGdu2TmeWIJq5TlUM8hamlyK1laZEA332cdzTUgl0zQdMMumhBFMqKblqaUnfWK/77KwTVKe9IG/T9EJijQ8vYEbZXcePScagzjHdyUAWXUCcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezq3e5Fg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezq3e5Fg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224341bbc1dso17082005ad.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390555; x=1741995355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=ezq3e5Fgc+Eov+nrIxl6+H3XfZnJSIkE+sYix3naYhFoRg05cDMfzSsgFnOEWkcMqd
         ORXOORa2VCZSWZd9mOW0jCFCc6kfNwco5xLVfZ6njYtHRaXCjgoF02cKhAvULYy5eysT
         511mTJSOPi2YF1EohkMkdiVBNJhyFceyTJlTtZB7by0yaFPYN4TKoDAg5e4j03fvS+ZR
         pFfV4oMmVn00RO6DU4VY3G3YIrwGS04zjC1UMBjXnkzJJdtkiTL4osJhVW3iaPY74A9l
         Tj011WksPqANstwxoBPH3F1AjRCALA6kOV4Hw4BLAMFEb2Dr1dX6TcnZBtDJfI5yJLGu
         02dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390555; x=1741995355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=volApn9N3Pr73SDQPvveft/qlWjVq+0q1yvOQLxuaLC6uC/CGdIxLdAmaKCS4LE+fm
         HoM/Kq0dCYXMz9S84mHLVotj6QErpCAntXPHwq/a6NivlrvbHGVGYx0XJYnjBQbLETlo
         6ttr+vTZowegDLIt9h50XONU6pdSp7LQVOqnw6CvC0Cc/HePfYT3PasyaFNLexP8v7Kt
         isCzaQVEqD+az+xSZSUTuKvHf4csOFfuLqxeshIU+O6YxpHbRJ+Yqbc/UOwcWHfEHkNx
         fUnC2RKZRr/rUPFtEq4SXkbLi6i1eesHwR8NmTlyPKYVTRFUlje4cf5ZadKGlioJR5Cf
         J/GA==
X-Gm-Message-State: AOJu0YycdvdAB24NsZZ42Btemf5KgtVXQ+8DadVUEuRUEdTbFrI5cIqC
	5rQCk3rTJmeb+fAM8k8ZSZFatgmcJWFTziPb/fBNb123bh0OUAuPJ/HMZfTVmD4=
X-Gm-Gg: ASbGncvk9qVcQLmwKYJJ6klipXjqGjEIsng26C+dnPDcErSHxqynSRNdQgnbCGq3cQ+
	HqyO57V0u8IN/SWTTo52PzZAW9XMHHTIAPMP8FNqxF4DNjMv3HrbXoFxv/AfmAtzhGsNCf2xTXw
	UkWNpe+yDe3ug5HTgJqk43AXjukfhPBORgH1Z+zlDuxst+FuSymcyzCFMKBrvDFFVQGZ1tHOvR2
	O5zX1cZM4CL7W4RKQzv35s/tp45hjFMPO/M6Ce2XS5xTeC7cefSRLSoVR8mqTG2xMREarWquSEQ
	K+PuGod8PDs7sbwtwM8kpM5jxIPMIJArifEYuB5BkrqoaKGwpvvVN6krzRZbV+Z1pQdjAg==
X-Google-Smtp-Source: AGHT+IGGd7XKJiFQyYHqm4XMXZ1d8xCHMYMDfIYuB7x7x3QdwDBBAz5T02ki8I7yt0ZPhdEhQHVZ4w==
X-Received: by 2002:a17:903:19ee:b0:224:1943:c65 with SMTP id d9443c01a7336-224288874b9mr91862555ad.14.1741390555451;
        Fri, 07 Mar 2025 15:35:55 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:35:55 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/8] builtin/verify-tag: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:01 +0530
Message-ID: <20250307233543.1721552-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c  | 7 +++----
 t/t7030-verify-tag.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f6b97048a5..ed1c40338f 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -35,7 +34,7 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
@@ -56,7 +55,7 @@ int cmd_verify_tag(int argc,
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(the_repository, name, &oid)) {
+		if (repo_get_oid(repo, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..2c147072c1 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-tag does not crash with -h' '
+	test_expect_code 129 git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage &&
+	test_expect_code 129 nongit git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage
+'
+
 test_expect_success GPG 'create signed tags' '
 	echo 1 >file && git add file &&
 	test_tick && git commit -m initial &&
-- 
2.48.1

