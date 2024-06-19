Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6F15A847
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834299; cv=none; b=KczhlE4cd+j5MMo//+kuxB29geIJYKGtHfrLnDz1yOunq28+ukaZOurA74+nS9EBeb2Mu5QPzW035cYaqFHKq8g+79rH9YlU9XtGi9Xkx+jmcAqWFYmwQIlweBdrkUoEDhhSZ47xIA6dJat54msL4twQTDF2BztvAfqZ+9XAfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834299; c=relaxed/simple;
	bh=jeBDt4N25odL5gjYkO/1pvS9qP3scKjXFEKA1GSznLw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mdOmp4uwf5cuG0eT5vRKHCzyjfi43wmZfhqRi3ND1AqATwWpQ/y0yKu8D2OksGZmSW/4yYWN7FXhH17Kq3xghGAB5IwlY5KAwuWyPfmTiEUktoIyJ5CCoJDv5xgGyAJzYWwdNVIAsJGCQeR+g7GMRM9AAFkXMIm7E1R7s8/1QAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIKSnrnM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIKSnrnM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f275c7286so198326f8f.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834296; x=1719439096; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq4iJbbzTxbfBzgAiCj5MdlIpvCzQiRWIi8aFAvrE50=;
        b=DIKSnrnMEjt3nswd2XT818OGviWFETJOkoaDrlYI0OVeBjirgWP8LlrNAa2EKiCvVH
         VDjM3HCRiCLH24dWPc46l3u/kdF5QL5UYgfjZub8nD9OaJmEgDx4yrBYMYklOWLfTouQ
         2Cueqp2rl2Zf4ocHzDPtPAFTOO9Tt9t7+sg6wad816/cWChdgzEZe2A/FltR3u8bmnFB
         2YeOiNaDeoOvPhlzDp9m0p2yeeOJORYFryLQFzDo2P6XwjKFqSnbWlSc+HloDkkkCKJH
         rbs3g1dTJC5Tgk/y2s5U8QGLFa2Utsadpq9oVJuZwd7q8w7v+wlVl5ji5lq1Ofb9KIiM
         VFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834296; x=1719439096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq4iJbbzTxbfBzgAiCj5MdlIpvCzQiRWIi8aFAvrE50=;
        b=WW0aRWx8p8BMQPpZ9lOLMsqolDD5iS48x9jNqLxOhliUOC/Hs3Xy2mZ1L4Dch/9M/R
         /xvUA8iBb3XALdFlpTD7r76H5HM9odZMEEIwyQOeGtiiGQYtUGJUNHj6G/wyr1lSgz0d
         QEC4fBdsygSJKcaYCKUaWSc5ZL5rt1wd3xu9zhzzkDztQ6q/WXdACamsYyBe0tXudY9n
         Wy1yX3dt8Hm1Lft+ZyGh/zZAXV7fL3u+ZpCZ9mW6gaJvaIwU1MAQsbOPb/b03G+rHoDp
         T0Xs3efipuG+De770df3mYc09cW13J51sJ3G6mLsa/RwwaJG2MjuIQtOnfZJUljhJ78Q
         BwUA==
X-Gm-Message-State: AOJu0YypSXE6oXobfWwnGfO+Uqgm2ydikEbZPpJe8KqiYEu8eLBmz+4A
	0i1eN/ExJZsLUQ7+DFg0o2ejDsXFYr3w3Af2RqCgGiMyenqBdLbUVBT8Rw==
X-Google-Smtp-Source: AGHT+IEsZWSHG7Puam+xKJ3J1Y7wlkdQNotVnyrF2v/esHICE2GB5rC+VoOj7uc9gqM0R/Keg9bs7A==
X-Received: by 2002:a5d:408d:0:b0:360:7829:bb93 with SMTP id ffacd0b85a97d-363177a3a72mr2983218f8f.21.1718834295803;
        Wed, 19 Jun 2024 14:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6355sm3959425e9.2.2024.06.19.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:15 -0700 (PDT)
Message-Id: <472efcaf1dde3dd590f34bde63c5ce6dcf72a531.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:54 +0000
Subject: [PATCH v2 06/17] index-info.c: parse object type in provided in
 read_index_info
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

If the object type (e.g. "blob", "tree") is identified on a stdin line read
by 'read_index_info()' (i.e. on lines formatted like the output of 'git
ls-tree'), parse it into an 'enum object_type' and provide it to the
'read_index_info()' callback as an argument. If the type is not provided,
pass 'OBJ_ANY' instead. If the object type is invalid, return an error.

The goal of this change is to allow for more thorough validation of the
provided object type (e.g. against the provided mode) in 'mktree' once
'mktree_line' is replaced with 'read_index_info()'. Note, though, that this
change also strengthens the validation done by 'update-index', since invalid
type names now trigger an error.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c        |  3 ++-
 index-info.c                  | 16 ++++++++++++----
 index-info.h                  |  3 ++-
 t/t2107-update-index-basic.sh |  5 +++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8d0b40a6fd6..42a274f9ce4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -510,7 +510,8 @@ static void update_one(const char *path)
 	report("add '%s'", path);
 }
 
-static int apply_index_info(unsigned int mode, struct object_id *oid, int stage,
+static int apply_index_info(unsigned int mode, struct object_id *oid,
+			    enum object_type obj_type UNUSED, int stage,
 			    const char *path_name, void *cbdata UNUSED)
 {
 	if (!verify_path(path_name, mode)) {
diff --git a/index-info.c b/index-info.c
index 7a02f66426a..9c986cd9093 100644
--- a/index-info.c
+++ b/index-info.c
@@ -18,6 +18,7 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
 		char *ptr, *tab;
 		char *path_name;
 		struct object_id oid;
+		enum object_type obj_type = OBJ_ANY;
 		unsigned int mode;
 		unsigned long ul;
 		int stage;
@@ -51,18 +52,17 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
 
 		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
 			stage = tab[-1] - '0';
-			ptr = tab + 1; /* point at the head of path */
+			path_name = tab + 1; /* point at the head of path */
 			tab = tab - 2; /* point at tail of sha1 */
 		} else {
 			stage = 0;
-			ptr = tab + 1; /* point at the head of path */
+			path_name = tab + 1; /* point at the head of path */
 		}
 
 		if (get_oid_hex(tab - hexsz, &oid) ||
 			tab[-(hexsz + 1)] != ' ')
 			goto bad_line;
 
-		path_name = ptr;
 		if (!nul_term_line && path_name[0] == '"') {
 			strbuf_reset(&uq);
 			if (unquote_c_style(&uq, path_name, NULL)) {
@@ -72,7 +72,15 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
 			path_name = uq.buf;
 		}
 
-		ret = fn(mode, &oid, stage, path_name, cbdata);
+		/* Get the type, if provided */
+		if (tab - hexsz - 1 > ptr + 1) {
+			if (*(tab - hexsz - 1) != ' ')
+				goto bad_line;
+			*(tab - hexsz - 1) = '\0';
+			obj_type = type_from_string(ptr + 1);
+		}
+
+		ret = fn(mode, &oid, obj_type, stage, path_name, cbdata);
 		if (ret) {
 			ret = -1;
 			break;
diff --git a/index-info.h b/index-info.h
index 9258011462d..adea453b197 100644
--- a/index-info.h
+++ b/index-info.h
@@ -2,8 +2,9 @@
 #define INDEX_INFO_H
 
 #include "hash.h"
+#include "object.h"
 
-typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
+typedef int (*each_index_info_fn)(unsigned int, struct object_id *, enum object_type, int, const char *, void *);
 
 #define INDEX_INFO_UNRECOGNIZED_LINE 1
 
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 794a5b1a184..9e0e77bbf9e 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -153,6 +153,11 @@ test_expect_success '--index-info fails on malformed input' '
 	test_must_fail git update-index --index-info 2>err &&
 	test_grep "malformed input line" err &&
 
+	# invalid type
+	printf "100644 bad $EMPTY_BLOB\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "invalid object type" err &&
+
 	# invalid stage value
 	printf "100644 $EMPTY_BLOB 5\tA" |
 	test_must_fail git update-index --index-info 2>err &&
-- 
gitgitgadget

