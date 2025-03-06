Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B018BB9C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271820; cv=none; b=aGVD2rS2/hZj12fKpUil/3SDfB4tN2VwCs0Gz/inNNlOevZjMTEzO2JyJV7TCrB2gikO8ayNTBfB9w4BGDQb1iSd6bZjwM/LhBYBBuVoSwg82/3M3FY8R6DgUgpzB7uiGsmxA7AeQ3s1fQBWvW/DKkKjPRyCD1ZG8BiX03ZwsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271820; c=relaxed/simple;
	bh=uW5bRQB4XXi6+E31aohFFA1T+pUDf31lBRQLmOnjdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ3CYgtQRj1l7x5CNgnAjLOt1LSvzf6QOvabeGNOxgD9CVaKrK/c7j96MdOb1rXEUyIxb+Dxx2NGhavenu3zsF3e9cl1h85g7Ia/aZev5wHYmKqUqEwUqvfzG1dAcM2vwtu3WNIhACZWo9D6KCsWfqP1BlJ1KidYx19RZ/MzTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMKAIcOe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMKAIcOe"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so1608441a91.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271818; x=1741876618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=ZMKAIcOeJH/Jnjy+0I6nEfCdvLvgiLLJuFLUkBOQd8SbcRzzta4nbFQssIeRR1/vb2
         9T2RTUi3Is/nXIEsFh6xBXiMnbPaeHgggOdfqzynxVI29Y8CIF1i7B/UPHxHvYSKHKLK
         I7q+FFJV5NyDW7III3d3gQ+WYs3j+5iY1jx2cKmukucEFiq75ZPPE0C6zzBb1PtRiUBU
         3kvFTACaJ8FryLVzlu8UdqZM0kQunTsgVzkrx/zRfw4sgPnSPUCPspdihhjIqGkrKExh
         Gk0rLTKA9/yYsRIumQkbUu3QgxyDi5ADrQdfinZRXNxc9LXpl1OtFaKNSaLZOhSEo0WT
         XooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271818; x=1741876618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=aAXM+WFX6JeP+qwVI9zS/AjpYAB6eu4JATSWhmthhlz0ZYeQHxo8EvddWXWDff+TOK
         /DkCe2m3vhcUnuCcXfeAHThFA9emRvz9E37VgHVPNKaSVVUeXw3bTbLELd7tH+nD5k3U
         XVN7PBLN0oi4X4mNZc3SMkj7oUP/2JMPGxC2w5eOKbrt5EhNUtzFUxE5d+6ZqH2peSQ6
         XXSQn0h5pyNz7bIYOjLzPo2rdwf2BjRHxN9ku/O1mFLF0+Y2W3h50Y9dgWl3XWMyNo8N
         F9BcaL4Urh8TqdOiaMDH4YmOa7FOLKvchtd/Hl6/0vVoWMHyqIzCQjvpZh/sUONAI11P
         DUaQ==
X-Gm-Message-State: AOJu0YxCYkiUeUZSZaYcoZwSL+XGSWEYrA6lhPEv8Zx/xDkvUiyn+Rq5
	POBnm/A40kJTeKOUUtyBXVC27hvPyixCafqjdeFcR2QrYMaiQQLYc/eHN68u
X-Gm-Gg: ASbGncs15FHuVTHiKv23un0UL/YmONqeRtO0bXPH2ZmPIzf1motcLMmrudZk3UPVEqo
	5mpi8i6ocIrKjsUOU7WfKM9E1h3fLRtYlV1MCo3JWVXwKHy4EaxTkYJCHk6qi+V6Ec48JcEKxtP
	99yqxYguIwjvlce0xs04cfU+l/IPsf2WusklXc2aiceWXj+9PKuszHvi95QfY0H4lBEg3GpJket
	zUn4lfXLyJQvLJF87sav2NmhzYIkVj3cObKxTtdyruN2SKIaJ+j+rsVRJeu1g5Wix7DC6MzFAsm
	o608aVNPh2RZ7uWgofOn+f9ON9eHWJ9/CuuYSfJ1bgPqDAZuc3Cn3cxozSyzo4l3pCcpkA==
X-Google-Smtp-Source: AGHT+IECRxGOwLAHturm2xg/PmK8xT+vu5FxJEOI7WGFXftm/Lg2ZWmq6FoVSqoc8r1jQ0dLN6Fteg==
X-Received: by 2002:a17:90b:2692:b0:2ff:58b8:5c46 with SMTP id 98e67ed59e1d1-2ff58b85d9cmr7657216a91.8.1741271818271;
        Thu, 06 Mar 2025 06:36:58 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:58 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 7/8] builtin/for-each-ref: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:51 +0530
Message-ID: <20250306143629.1267358-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
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

