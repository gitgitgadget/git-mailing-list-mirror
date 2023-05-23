Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E2C7EE23
	for <git@archiver.kernel.org>; Tue, 23 May 2023 09:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjEWJA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjEWJA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 05:00:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD4FF
        for <git@vger.kernel.org>; Tue, 23 May 2023 02:00:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f60444238cso21336795e9.3
        for <git@vger.kernel.org>; Tue, 23 May 2023 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684832420; x=1687424420;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z5oBz3cMENCQsHyrJdcBcJmlfszc3aIZ3i/GX16RLo=;
        b=E+7XK6M9JOcm/r66+XYRcK3T19ovvxN10E9lty1mcZPfXKYlHypfGNJW00jPFUH6CC
         dzMU9kN5RSVZI/Nx4NZcM2jvm0ISgDlD6bjQ7p2drRNiEZnYbv0mET7qiuw8lQGMBHwO
         D6vUai1bj65+6X/xPbB1ALAyETy8MlQh7wiHEUolsnrNBontmtZXqun7rF5ObGEjuo2L
         ++8lRkMAq+yZh8iqFSAxi6e6byOgaWP81aALkHu4meWbCbZCxYAJBdBFKf4ZDbcjUUZy
         vOR2ef/QRTgWnUceHvUGJohqoj53sqXY4W5m9aY6IbaWgmilrYGg4pBAuQH4Y4bwJrLU
         Pe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832420; x=1687424420;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z5oBz3cMENCQsHyrJdcBcJmlfszc3aIZ3i/GX16RLo=;
        b=KTyQmmc8uOlzFBPNxWOUJH7AtT6LK9fhmI/QUlE+OEGt9J04Skq+zL5tnqYuoGMMxM
         uygQc88ZtSuv5sDvzIRj6rdx4OV0snXV7Urs4g6wQ6Lw3huAo0QeX1NwDi3Vbxwr59Pf
         VnidBqmLDS5sBM6MhfY8Uo6HgEXzkarlSaapHU6Hj8YBSpoha7ox/ZihtYuSBJtgLArU
         S4X32AIW2JSHz1ZEV9msJBGdyaxbhO7tvwVTO8Lyt9EU1joXKTniWLwcZSfigRtG8O4L
         8oD/WHaWAmOaRxs7kJ8D6UYKldBavVhVAngUdPXzSOgbL8gc0dV08hPuD/+VXzAl3C9q
         kfkg==
X-Gm-Message-State: AC+VfDzfkXFxyk86V2M5ZUrcB1NB/uoIKB6Ga0njnB9TdVcGl3w0crMr
        FEKS2fZ+35JdjYM65zcjzdH7tu/dM0I=
X-Google-Smtp-Source: ACHHUZ6UTj1Ahhkrw+mUnm4btSadU1pYB0uE9FCAvhlrIfKNYkKpLPC+xm/GxKXgPsZtBtXVMGc+Sw==
X-Received: by 2002:a1c:f402:0:b0:3f4:23a4:7a93 with SMTP id z2-20020a1cf402000000b003f423a47a93mr10436253wma.25.1684832420018;
        Tue, 23 May 2023 02:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdcc2000000b003077f3dfcc8sm10258432wrm.32.2023.05.23.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:00:19 -0700 (PDT)
Message-Id: <pull.1533.v2.git.1684832418299.gitgitgadget@gmail.com>
In-Reply-To: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 May 2023 09:00:18 +0000
Subject: [PATCH v2] ls-files: aligin format atoms wtih ls-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Martin Monperrus <martin.monperrus@gnieh.org>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

"git ls-files --format" can be used to format the output of
multiple file entries in the index, while "git ls-tree --format"
can be used to format the contents of a tree object. However,
the current set of %(objecttype), "(objectsize)", and
"%(objectsize:padded)" atoms supported by "git ls-files --format"
is a subset of what is available in "git ls-tree --format".

Users sometimes need to establish a unified view between the index
and tree, which can help with comparison or conversion between the two.

Therefore, this patch adds the missing atoms to "git ls-files --format".
"%(objecttype)" can be used to retrieve the object type corresponding
to a file in the index, "(objectsize)" can be used to retrieve the
object size corresponding to a file in the index, and "%(objectsize:padded)"
is the same as "(objectsize)", except with padded format.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: align format atoms with git ls-tree
    
    Users sometimes want all format atoms of git ls-files --format to be
    compatible with the format atoms of git ls-tree --format [1]. However,
    git ls-files --format lacks the %(objecttype) and %(objectsize),
    %(objectsize:padded) atoms compared to git ls-tree --format, causing
    incompatibility. Therefore, these atoms are added to the --format of git
    ls-files to resolve the issue of incompatibility.
    
    %(objecttype): get the object type of the file which is recorded in the
    index. %(objectsize): get the object size of the file which is recorded
    in the index, ("-" if the object is a commit or tree).
    %(objectsize:padded): same as %(objectsize), but with a padded format.
    
    v1: add %(objecttype) and %(objectsize) atos to git ls-files --format.
    v2:
    
     1. squash two commit into one.
     2. rewrite commit messages.
    
    [1]:
    https://lore.kernel.org/git/21183ea9-84e2-fd89-eb9b-419556680c07@gnieh.org/T/#u

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1533%2Fadlternative%2Fzh%2Fls-files-formats-expand-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1533/adlternative/zh/ls-files-formats-expand-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1533

Range-diff vs v1:

 1:  3f8884457d3 < -:  ----------- ls-files: add %(objecttype) atom to format option
 2:  95f1d714081 ! 1:  a99618c6048 ls-files: add %(objectsize) atom to format option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    ls-files: add %(objectsize) atom to format option
     +    ls-files: aligin format atoms wtih ls-tree
      
     -    Sometimes users may want to align the feature of
     -    `git ls-files --format` with that of `git ls-tree --format`,
     -    but the %(objectsize) and %(objectsize:padded) are missing
     -    in the format option of git ls-files compared to git ls-tree.
     +    "git ls-files --format" can be used to format the output of
     +    multiple file entries in the index, while "git ls-tree --format"
     +    can be used to format the contents of a tree object. However,
     +    the current set of %(objecttype), "(objectsize)", and
     +    "%(objectsize:padded)" atoms supported by "git ls-files --format"
     +    is a subset of what is available in "git ls-tree --format".
      
     -    Therefore, the %(objecttsize) atom is added to the format
     -    option of git ls-files, which can be used to obtain the
     -    object size of the file which is recorded in the index.
     -    ("-" if the object is a `commit` or `tree`) It also
     -    supports a padded format of size with %(objectsize:padded).
     +    Users sometimes need to establish a unified view between the index
     +    and tree, which can help with comparison or conversion between the two.
     +
     +    Therefore, this patch adds the missing atoms to "git ls-files --format".
     +    "%(objecttype)" can be used to retrieve the object type corresponding
     +    to a file in the index, "(objectsize)" can be used to retrieve the
     +    object size corresponding to a file in the index, and "%(objectsize:padded)"
     +    is the same as "(objectsize)", except with padded format.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-ls-files.txt ##
     -@@ Documentation/git-ls-files.txt: objecttype::
     - 	The object type of the file which is recorded in the index.
     +@@ Documentation/git-ls-files.txt: interpolated.  The following "fieldname" are understood:
     + 
     + objectmode::
     + 	The mode of the file which is recorded in the index.
     ++objecttype::
     ++	The object type of the file which is recorded in the index.
       objectname::
       	The name of the file which is recorded in the index.
      +objectsize[:padded]::
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
       	const char *pathname;
       	struct index_state *istate;
      @@ builtin/ls-files.c: static size_t expand_show_index(struct strbuf *sb, const char *start,
     + 		strbuf_addf(sb, "%06o", data->ce->ce_mode);
     + 	else if (skip_prefix(start, "(objectname)", &p))
       		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
     - 	else if (skip_prefix(start, "(objecttype)", &p))
     - 		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
     ++	else if (skip_prefix(start, "(objecttype)", &p))
     ++		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
      +	else if (skip_prefix(start, "(objectsize:padded)", &p))
      +		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 1);
      +	else if (skip_prefix(start, "(objectsize)", &p))
     @@ builtin/ls-files.c: static size_t expand_show_index(struct strbuf *sb, const cha
       	else if (skip_prefix(start, "(eolinfo:index)", &p))
      
       ## t/t3013-ls-files-format.sh ##
     -@@ t/t3013-ls-files-format.sh: test_expect_success 'git ls-files --format objecttype' '
     +@@ t/t3013-ls-files-format.sh: test_expect_success 'git ls-files --format objectname v.s. -s' '
       	test_cmp expect actual
       '
       
     ++test_expect_success 'git ls-files --format objecttype' '
     ++	git ls-files --format="%(objectname)" o1.txt o4.txt o6.txt >objectname &&
     ++	git cat-file --batch-check="%(objecttype)" >expect <objectname &&
     ++	git ls-files --format="%(objecttype)" o1.txt o4.txt o6.txt >actual &&
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'git ls-files --format objectsize' '
      +	cat>expect <<-\EOF &&
      +26


 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             | 27 ++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1abdd3c21c5..1bc0328bb78 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -270,8 +270,14 @@ interpolated.  The following "fieldname" are understood:
 
 objectmode::
 	The mode of the file which is recorded in the index.
+objecttype::
+	The object type of the file which is recorded in the index.
 objectname::
 	The name of the file which is recorded in the index.
+objectsize[:padded]::
+	The object size of the file which is recorded in the index
+	("-" if the object is a `commit` or `tree`).
+	It also supports a padded format of size with "%(objectsize:padded)".
 stage::
 	The stage of the file which is recorded in the index.
 eolinfo:index::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 625f48f0d61..72012c0f0f7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -25,6 +25,9 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "object-store.h"
+#include "hex.h"
+
 
 static int abbrev;
 static int show_deleted;
@@ -241,6 +244,24 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+			      const enum object_type type, unsigned int padded)
+{
+	if (type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, oid, &size) < 0)
+			die(_("could not get object info about '%s'"),
+			    oid_to_hex(oid));
+		if (padded)
+			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
+		else
+			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
+	} else if (padded) {
+		strbuf_addf(line, "%7s", "-");
+	} else {
+		strbuf_addstr(line, "-");
+	}
+}
 struct show_index_data {
 	const char *pathname;
 	struct index_state *istate;
@@ -272,6 +293,12 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 		strbuf_addf(sb, "%06o", data->ce->ce_mode);
 	else if (skip_prefix(start, "(objectname)", &p))
 		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	else if (skip_prefix(start, "(objecttype)", &p))
+		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
+	else if (skip_prefix(start, "(objectsize:padded)", &p))
+		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 1);
+	else if (skip_prefix(start, "(objectsize)", &p))
+		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 0);
 	else if (skip_prefix(start, "(stage)", &p))
 		strbuf_addf(sb, "%d", ce_stage(data->ce));
 	else if (skip_prefix(start, "(eolinfo:index)", &p))
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index ef6fb53f7f1..6e6ea0b6f3c 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -38,6 +38,41 @@ test_expect_success 'git ls-files --format objectname v.s. -s' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --format objecttype' '
+	git ls-files --format="%(objectname)" o1.txt o4.txt o6.txt >objectname &&
+	git cat-file --batch-check="%(objecttype)" >expect <objectname &&
+	git ls-files --format="%(objecttype)" o1.txt o4.txt o6.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectsize' '
+	cat>expect <<-\EOF &&
+26
+29
+27
+26
+-
+26
+	EOF
+	git ls-files --format="%(objectsize)" >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectsize:padded' '
+	cat>expect <<-\EOF &&
+     26
+     29
+     27
+     26
+      -
+     26
+	EOF
+	git ls-files --format="%(objectsize:padded)" >actual &&
+
+	test_cmp expect actual
+'
+
 test_expect_success 'git ls-files --format v.s. --eol' '
 	git ls-files --eol >tmp &&
 	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&

base-commit: 5bc069e383539824fd3a0d897100d44bbe1f8a24
-- 
gitgitgadget
