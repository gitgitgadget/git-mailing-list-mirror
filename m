Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B54C7618B
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCNBxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCNBxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 21:53:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8A231E1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i9so3968273wrp.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678758820;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/XfEhXKBkAFVnDlSJprYjSe5mimGStsOiyTu7d9d9w=;
        b=LsAHOczqaMej8urKTm+P3/EZLDlA6orA8tf0od3qiqvCu9Y+utb5NTf9UIeYqkns3F
         4XkMV5drJBCGFgF/VkhRseuSOamM24RxwbmjQBveDtuB4wiGnhnPTYvSbmhF30YC/nOa
         f/A/e9YEnKytnyZtIWjVwCEk0SpfWv1sp2SH7DgDr6rLzySkTERqWLSAxkfAeGoAjkiF
         2oHjh0ifd4FWo9YvmHX4Ygd1MSSl9WmMV3JQqNVcl1iHq1++JFn01prQ/gzY3XcldfiA
         0bgZ6cU1W+GnPixHj4zg6Yc+84nGn9EGEU+GawTv8keYxJ9G4361j7hs1MyLIu7oKirf
         VGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678758820;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/XfEhXKBkAFVnDlSJprYjSe5mimGStsOiyTu7d9d9w=;
        b=LvFD6ec0274pIR2KOoalpbz8b3Jh9wpbDGGJwOFmgerE3YPC/0FbOJw9n7Np7fNmoo
         XQ8Rubtx9rP1W3W+AxExtG03d6QHOaidwPc+fE6EjB+qHy2yt2XrMTCYWiqfyVNrRFno
         zTHcJJH+jlROGEAFv87DHnD7AyHVDk7Aj3tYWtTRUaoFSnpKbOFI8WFsIhB4l+pRiBGc
         wjTQvqQ8bh8WU5KO7+dz49nKcFnBStDcDgX5dKmCZ38MErCEDs+Hb7tMQFYOBnKq9n+V
         JVfl3OZTWjQrus+rD3Y90P6lEeCAXwdrhpuxp+cjoQ90QL9PjoxfZMCNQQqbOqcUlzss
         jE2w==
X-Gm-Message-State: AO0yUKX3jfzeB+grP9CdjYWTXd8rL2iZbFMBzSpMx8JSrAKceeE5BOVb
        sRf7WmlQxA44uSXAcgAHsT5VmP9Xyhw=
X-Google-Smtp-Source: AK7set+dRWGHvrO0j3LbSFrj7QPf37QH4VBFQIWYozAgc8XypkDlWKQZb52SpMFsWoB7PXm/MdeI1w==
X-Received: by 2002:adf:fa4e:0:b0:2c7:7b3:36c6 with SMTP id y14-20020adffa4e000000b002c707b336c6mr23602589wrr.52.1678758820324;
        Mon, 13 Mar 2023 18:53:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm803077wrv.32.2023.03.13.18.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 18:53:40 -0700 (PDT)
Message-Id: <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 01:53:37 +0000
Subject: [PATCH 1/2] diff: use HEAD for attributes when using bare repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

(a4cf900e diff: teach diff to read algorithm from diff driver,
2022-02-20) does not support bare repositories. Since running diff
on bare repositories is often done on Git servers, it would be useful to
allow bare repositories to also take advantage of setting the algorithm
via the diff driver.

Teach diff to check against the attributes from HEAD if a bare
repository is being operated on. This change also allows custom diff
drivers to work with bare repositories.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/gitattributes.txt |  4 ++++
 diff.c                          | 33 +++++++++++++++++++++++++++++----
 t/lib-diff-alternative.sh       | 10 ++++++++++
 t/t4018-diff-funcname.sh        | 11 +++++++++++
 userdiff.c                      |  9 ++++++++-
 userdiff.h                      |  4 ++++
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 39bfbca1ffe..15488bd92b2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -758,6 +758,8 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+When using a bare repository, the gitattributes from HEAD will be used.
+
 Setting the internal diff algorithm
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -785,6 +787,8 @@ This diff algorithm applies to user facing diff output like git-diff(1),
 git-show(1) and is used for the `--stat` output as well. The merge machinery
 will not use the diff algorithm set through this method.
 
+When using a bare repository, the gitattributes from HEAD will be used.
+
 NOTE: If `diff.<name>.command` is defined for path with the
 `diff=<name>` attribute, it is executed as an external diff driver
 (see above), and adding `diff.<name>.algorithm` has no effect, as the
diff --git a/diff.c b/diff.c
index 469e18aed20..51baf893bb0 100644
--- a/diff.c
+++ b/diff.c
@@ -29,6 +29,7 @@
 #include "promisor-remote.h"
 #include "dir.h"
 #include "strmap.h"
+#include "tree.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -4443,6 +4444,27 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 }
 
+static void get_userdiff(struct diff_options *o,
+			     struct userdiff_driver **drv,
+			     const char *attr_path)
+{
+	const char *commit = "HEAD";
+	struct object_id *tree_oid = NULL;
+
+	if (is_bare_repository() && o->repo->gitdir) {
+		struct object_id oid;
+
+		if (!get_oid(commit, &oid)) {
+			struct tree *t = parse_tree_indirect(&oid);
+
+			if (t)
+				tree_oid = &t->object.oid;
+		}
+	}
+
+	*drv = userdiff_find_by_tree_and_path(o->repo->index, tree_oid, attr_path);
+}
+
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -4458,8 +4480,10 @@ static void run_diff_cmd(const char *pgm,
 	int must_show_header = 0;
 	struct userdiff_driver *drv = NULL;
 
-	if (o->flags.allow_external || !o->ignore_driver_algorithm)
-		drv = userdiff_find_by_path(o->repo->index, attr_path);
+	if (o->flags.allow_external || !o->ignore_driver_algorithm) {
+
+		get_userdiff(o, &drv, attr_path);
+	}
 
 	if (o->flags.allow_external && drv && drv->external)
 		pgm = drv->external;
@@ -4586,8 +4610,9 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	const char *other;
 
 	if (!o->ignore_driver_algorithm) {
-		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index,
-								    p->one->path);
+		struct userdiff_driver *drv = NULL;
+
+		get_userdiff(o, &drv, p->one->path);
 
 		if (drv && drv->algorithm)
 			set_diff_algorithm(o, drv->algorithm);
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index a8f5d3274a5..0d99af83dd2 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -121,6 +121,16 @@ EOF
 		test_cmp expect output
 	'
 
+	test_expect_success "$STRATEGY diff from attributes with bare repo" '
+		echo "file* diff=driver" >.gitattributes &&
+		git add file1 file2 .gitattributes &&
+		git commit -m "adding files" &&
+		git clone --bare --no-local . bare.git &&
+		git -C bare.git config diff.driver.algorithm "$STRATEGY" &&
+		git -C bare.git diff HEAD:file1 HEAD:file2 > output &&
+		test_cmp expect output
+	'
+
 	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
 		echo "file* diff=driver" >.gitattributes &&
 		git config diff.driver.algorithm "$STRATEGY" &&
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 42a2b9a13b7..451af08c611 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -63,6 +63,17 @@ do
 		test_i18ngrep ! fatal msg &&
 		test_i18ngrep ! error msg
 	'
+	test_expect_success "builtin $p pattern compiles on bare repo" '
+		test_when_finished "rm -rf bare.git" &&
+		echo "*.java diff=$p" >.gitattributes &&
+		git add . &&
+		git commit -am "adding files" &&
+		git clone --bare --no-local . bare.git &&
+		test_expect_code 1 git -C bare.git diff --exit-code \
+			HEAD:A.java HEAD:B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
 done
 
 test_expect_success 'last regexp must not be negated' '
diff --git a/userdiff.c b/userdiff.c
index 58a3d59ef8f..2305d363244 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -408,6 +408,13 @@ struct userdiff_driver *userdiff_find_by_name(const char *name)
 
 struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 					      const char *path)
+{
+	return userdiff_find_by_tree_and_path(istate, NULL, path);
+}
+
+struct userdiff_driver *userdiff_find_by_tree_and_path(struct index_state *istate,
+						       const struct object_id *tree_oid,
+						       const char *path)
 {
 	static struct attr_check *check;
 
@@ -415,7 +422,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, tree_oid, path, check);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git a/userdiff.h b/userdiff.h
index 24419db6973..f9cd7c238de 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -33,6 +33,10 @@ int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
 struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 					      const char *path);
+struct userdiff_driver *userdiff_find_by_tree_and_path(struct index_state *istate,
+						       const struct object_id *tree_oid,
+						       const char *path);
+
 
 /*
  * Initialize any textconv-related fields in the driver and return it, or NULL
-- 
gitgitgadget

