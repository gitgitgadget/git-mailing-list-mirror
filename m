Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762DC4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 00:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKXAzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKXAzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 19:55:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92013D49
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:55:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so212307wms.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbVAhrQl/WnaDgL4hblbJAnjV3QjseeL02V4xWRs3x4=;
        b=mTm0ThIGckaNpuLCoqV/xCne9RMDFYtFvcd8vpWIaX6ftH85vXKkEs6hjQcCtrH+Xz
         eViIxK3g/DjlQvpMYDIoryot8Njv/PaI+cHBYDYQxRp20Kyxwkv9ZyykrWia5zAxnt/q
         Ee5h4MHP/hn9ib2Bk9DfaFdLTjMwnakZ0FmHvQuRj2/DV4tJkwpDOHz1G9dCF5LCN3rQ
         X8dMDO90YkVZhKL+SiQRf2G3KdWxCUblSysNDz5CGrOcf5XRiAFkQFnzzmO0jLok5gF9
         OIe1rILXTh1YCFEcGQc+d62FzyDq09JeyMKmWHr517SVHNcuR3+Y2GyDEZlWUe7c48Ny
         Ja3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbVAhrQl/WnaDgL4hblbJAnjV3QjseeL02V4xWRs3x4=;
        b=mZPoPV/yS1ylxIHxZbsqo1LCPpKnZ4LDQyjedXxd2VNJYoxWcWcuyduobl7vbusK7m
         XeyksjscMDJKkgE2ET2IYMNnaSX3chwvlmrm/S+mvLJqC+a1w3jQItY23BaBDY8cFtLs
         1082jdF1D6RL5WNd1WIc6wpYnVNHDiY84I45VD9zIvw2DFr53AScLPl+kxJnm10cOqxh
         o6v0BJhjhaWIz1Syo2ofzywMRbu8/fSmCg6m3IiG0rS8NOWhjZe4ieO62a8p5uwlWjYg
         ra3PbOgwjjwtl+PPZZUxNEtRFjPpthCkORQg5NDZ+Kw7MnAkm7Q2mUMsGR6oYT/3R3tg
         OKPw==
X-Gm-Message-State: ANoB5pm5AMDF8EZLWWvCk7BI4kNTzB7w1ewYPIOi1yws39KX1WdWHEjk
        Kb06GUMNuWi1ZUlHw4bLJYI0i3LVohk=
X-Google-Smtp-Source: AA0mqf4JIGzRrgM4FjwvPduPiKicvx5Qiyi2NBoU7FASjPPHEly54I1y/nuFAtVY09hUgbbMylQq9Q==
X-Received: by 2002:a05:600c:3583:b0:3b4:6c36:3f59 with SMTP id p3-20020a05600c358300b003b46c363f59mr12524954wmq.100.1669251333858;
        Wed, 23 Nov 2022 16:55:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o42-20020a05600c512a00b003a3442f1229sm4278413wms.29.2022.11.23.16.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:55:32 -0800 (PST)
Message-Id: <pull.1382.v3.git.git.1669251331340.gitgitgadget@gmail.com>
In-Reply-To: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
References: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 00:55:31 +0000
Subject: [PATCH v3] object-file: use real paths when adding alternates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When adding an alternate ODB, we check if the alternate has the same
path as the object dir, and if so, we do nothing. However, that
comparison does not resolve symlinks. This makes it possible to add the
object dir as an alternate, which may result in bad behavior. For
example, it can trick "git repack -a -l -d" (possibly run by "git gc")
into thinking that all packs come from an alternate and delete all
objects.

	rm -rf test &&
	git clone https://github.com/git/git test &&
	(
	cd test &&
	ln -s objects .git/alt-objects &&
	# -c repack.updateserverinfo=false silences a warning about not
	# being able to update "info/refs", it isn't needed to show the
	# bad behavior
	GIT_ALTERNATE_OBJECT_DIRECTORIES=".git/alt-objects" git \
		-c repack.updateserverinfo=false repack -a -l -d  &&
	# It's broken!
	git status
	# Because there are no more objects!
	ls .git/objects/pack
	)

Fix this by resolving symlinks and relative paths before comparing the
alternate and object dir. This lets us clean up a number of issues noted
in 37a95862c6 (alternates: re-allow relative paths from environment,
2016-11-07):

- Now that we compare the real paths, duplicate detection is no longer
  foiled by relative paths.
- Using strbuf_realpath() allows us to "normalize" paths that
  strbuf_normalize_path() can't, so we can stop silently ignoring errors
  when "normalizing" paths from the environment.
- We now store an absolute path based on getcwd() (the "future
  direction" named in 37a95862c6), so chdir()-ing in the process no
  longer changes the directory pointed to by the alternate. This is a
  change in behavior, but a desirable one.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    object-file: use real paths when adding alternates
    
    Thanks all for the feedback on v2. Once again, this version takes nearly
    all of Ævar's fixup patches [1] :)
    
    (It seems like the linux-* CI jobs are broken? I saw this tree pass
    previously, but linux-* is failing to build all of a sudden.)
    
    Changes in v3:
    
     * strbuf_release() all strbufs
     * Remove unnecessary details from the test (since it's a one-off, not
       reused)
    
    [1]
    https://lore.kernel.org/git/221122.868rk3bxbb.gmgdl@evledraar.gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1382%2Fchooglen%2Fobject-file%2Fcheck-alternate-real-path-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1382/chooglen/object-file/check-alternate-real-path-v3
Pull-Request: https://github.com/git/git/pull/1382

Range-diff vs v2:

 1:  ed9e12c0051 ! 1:  9bc04174be6 object-file: use real paths when adding alternates
     @@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct
       	struct strbuf pathbuf = STRBUF_INIT;
      +	struct strbuf tmp = STRBUF_INIT;
       	khiter_t pos;
     ++	int ret = -1;
       
       	if (!is_absolute_path(entry->buf) && relative_base) {
     + 		strbuf_realpath(&pathbuf, relative_base, 1);
      @@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
       	}
       	strbuf_addbuf(&pathbuf, entry);
     @@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct
      -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
      +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
       		error(_("unable to normalize alternate object path: %s"),
     --		      pathbuf.buf);
     -+			pathbuf.buf);
     - 		strbuf_release(&pathbuf);
     - 		return -1;
     + 		      pathbuf.buf);
     +-		strbuf_release(&pathbuf);
     +-		return -1;
     ++		goto error;
       	}
      +	strbuf_swap(&pathbuf, &tmp);
     -+	strbuf_release(&tmp);
       
       	/*
       	 * The trailing slash after the directory name is given by
     +@@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
     + 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
     + 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
     + 
     +-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
     +-		strbuf_release(&pathbuf);
     +-		return -1;
     +-	}
     ++	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
     ++		goto error;
     + 
     + 	CALLOC_ARRAY(ent, 1);
     + 	/* pathbuf.buf is already in r->objects->odb_by_path */
     +@@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
     + 
     + 	/* recursively add alternates */
     + 	read_info_alternates(r, ent->path, depth + 1);
     +-
     +-	return 0;
     ++	ret = 0;
     ++ error:
     ++	strbuf_release(&tmp);
     ++	strbuf_release(&pathbuf);
     ++	return ret;
     + }
     + 
     + static const char *parse_alt_odb_entry(const char *string,
      @@ object-file.c: static void link_alt_odb_entries(struct repository *r, const char *alt,
       		return;
       	}
     @@ t/t7700-repack.sh: test_expect_success 'loose objects in alternate ODB are not r
       	test_has_duplicate_object false
       '
       
     -+test_expect_success '--local keeps packs when alternate is objectdir ' '
     -+	git init alt_symlink &&
     ++test_expect_success SYMLINKS '--local keeps packs when alternate is objectdir ' '
     ++	test_when_finished "rm -rf repo" &&
     ++	git init repo &&
     ++	test_commit -C repo A &&
      +	(
     -+		cd alt_symlink &&
     -+		git init &&
     -+		echo content >file4 &&
     -+		git add file4 &&
     -+		git commit -m commit_file4 &&
     ++		cd repo &&
      +		git repack -a &&
      +		ls .git/objects/pack/*.pack >../expect &&
      +		ln -s objects .git/alt_objects &&


 object-file.c     | 26 +++++++++++++-------------
 t/t7700-repack.sh | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 957790098fa..26290554bb4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -508,7 +508,9 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 {
 	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
+	int ret = -1;
 
 	if (!is_absolute_path(entry->buf) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -516,12 +518,12 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	}
 	strbuf_addbuf(&pathbuf, entry);
 
-	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
+	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
 		error(_("unable to normalize alternate object path: %s"),
 		      pathbuf.buf);
-		strbuf_release(&pathbuf);
-		return -1;
+		goto error;
 	}
+	strbuf_swap(&pathbuf, &tmp);
 
 	/*
 	 * The trailing slash after the directory name is given by
@@ -530,10 +532,8 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
-		strbuf_release(&pathbuf);
-		return -1;
-	}
+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
+		goto error;
 
 	CALLOC_ARRAY(ent, 1);
 	/* pathbuf.buf is already in r->objects->odb_by_path */
@@ -548,8 +548,11 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 
 	/* recursively add alternates */
 	read_info_alternates(r, ent->path, depth + 1);
-
-	return 0;
+	ret = 0;
+ error:
+	strbuf_release(&tmp);
+	strbuf_release(&pathbuf);
+	return ret;
 }
 
 static const char *parse_alt_odb_entry(const char *string,
@@ -596,10 +599,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
-	if (strbuf_normalize_path(&objdirbuf) < 0)
-		die(_("unable to normalize object directory: %s"),
-		    objdirbuf.buf);
+	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5be483bf887..599b4499b8e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -90,6 +90,22 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	test_has_duplicate_object false
 '
 
+test_expect_success SYMLINKS '--local keeps packs when alternate is objectdir ' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	(
+		cd repo &&
+		git repack -a &&
+		ls .git/objects/pack/*.pack >../expect &&
+		ln -s objects .git/alt_objects &&
+		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
+		git repack -a -d -l &&
+		ls .git/objects/pack/*.pack >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
