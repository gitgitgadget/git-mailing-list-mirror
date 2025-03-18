Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA922080E3
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299187; cv=none; b=DAhX5/PfnNQ5A8Qmv4RnF+fSUz9+egoF+DPQw4G2D/V4sMO/ZXpLzfID/1vwJywveLZKQ9UzbGiQ6caoIb02ESvlYCp7ZZ61iK3zHDQola4xrzWwVFA4+sfg5HXbQlkLAl2RPuehdspCQsYYyhGn0tdPmGmuGgzq4Dk5a5vxKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299187; c=relaxed/simple;
	bh=uW5bRQB4XXi6+E31aohFFA1T+pUDf31lBRQLmOnjdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umZP8M+3j+rvVirKVzr8dWd0OWo8SZwmcri1S5Nqg4fTkanHa9aGGIoZJ9w9UcCmK3Hp5t7SmeOOwwxAR8emvkm37eADUEk1/7TNOWSMgu9tOuj+0kVo4ms1yXIo2CXoxIPPd1bOZrQS7G8Vc86ijgJ8TndA7iA4/VoEX9zdJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzteBi8A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzteBi8A"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224171d6826so5077995ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299181; x=1742903981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=LzteBi8Am06M8jIl9W4c62O8SSmSTPcE6bCX5KJlisZvI09sYyCIInWWLr5yfNcJnu
         wf+5mBciVsXt759zbdHH09w70cycsx31qUBe1wwGFd6gXOslyRXDM2G2iHl1LEa5+yy8
         bVRi3+VT3OMmfNH5DfHtv0mlNNmBZXDshO7CUJOHuoeR39vCi9d5RiOeqzuSRqAsyA96
         WT3/m0z7qUncE1aK3rpXM+QeWE+iNcU9AsVEzOPWr/R7HNhAb0PM8R5nsXTZylgn8Ykm
         2e6r/MTrr7ob1LDQIPI0L2dGJhaD2Imgsl7pQyQytSjQ0aMsJx0JH5BbIjJ/aZmhvcvi
         JrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299181; x=1742903981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=Jh58hjIbeynoGrsEJ8jMzGLBo7q3BYzgKnwrVKXpny4o9Ntaa15yKixnBTqmB97RgW
         wn/IZZF6/ucBcO7WKWjGM5Mqt6Sxo7TDvHloEMgbfkhlZMkmku/pSklv3iXinw1CdNlw
         HxZg8vjBVla29Dj+B2X814mWptrLK8myjisbgXDsmMC4hh1q59mYZhN4xkn5YeZ3Q/j0
         +gkCw2saRVkj4q+23HpeXHaCBgXpFOkjnGjjVr0578JQ//1Z+QlLqRPt0lZ8mW8eVpKF
         RKzl/nrReqiW93clUBCO0MSw21APxzeoS6vcbcRlpweFcUDEqGxgnwtguxgWW30tJy6x
         ZsYQ==
X-Gm-Message-State: AOJu0Yy0WsbuIR8kHN2XfokjAGU/j/Si6tItnjrG4LMZjW2YgUrAmVbR
	xGA8g6OMR0ETa1lHSSDG2WoihwHHROzBd2zroOxpxW0iyYaODJcd7GEJnMi0
X-Gm-Gg: ASbGncskzFnGgePHyoIaM69yQo+Fs2QrLru+P9l3ahSbjzMBSosc2ykIllD0hbOGgXp
	CS4tiCAKQX2Li1TmmQj2IgRrjnxYk3Dn7X4SM86+GtqzkFVMj4X3Pmz5IwvZh+5T+0j7V+tljNA
	evtNnw6fME0W56rTL7OXYl5P0wUvV6v1sOM3mm+ZytF/7rlf9wdN+P0Of9pJSjFZ68+Y4FqTYHl
	+BIP1aio+XDXwD4d9K36KyyaAH12mADZTRWzSqwqcsptBmfT+YMBL7QIfrJ15HPN9SfjHExWeba
	g18Xi0t5zqnYOWSlxHU9N9cd3IRx4WBVpX39r0ya+1Tv4oGZhnFHidlpos2JqcwDe/GUvg==
X-Google-Smtp-Source: AGHT+IFyCHtIW5nCqo9oCA4DYK7TPkv6QnJKMkO+gqLp6nXW/UVdw/t4PetETnjmfIkoYscdSBVUIg==
X-Received: by 2002:a17:902:f70c:b0:224:191d:8a79 with SMTP id d9443c01a7336-225e0ac31aamr212965045ad.27.1742299181287;
        Tue, 18 Mar 2025 04:59:41 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:41 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9] builtin/for-each-ref: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:59 +0530
Message-ID: <20250318115912.2978992-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
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
give the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/for-each-ref.c  | 5 ++---
 t/t6300-for-each-ref.sh | 7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8085ebd8fe..3d2207ec77 100644
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
@@ -63,7 +62,7 @@ int cmd_for_each_ref(int argc,
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a5c7794385..9b4f4306c4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -292,6 +292,13 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
+test_expect_success 'for-each-ref does not crash with -h' '
+	test_expect_code 129 git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage &&
+	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage
+'
+
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.48.1

