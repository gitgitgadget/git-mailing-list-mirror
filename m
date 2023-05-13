Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF14C7EE23
	for <git@archiver.kernel.org>; Sat, 13 May 2023 09:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjEMJLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMJLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 05:11:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D92119
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307a8386946so3723018f8f.2
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683969103; x=1686561103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljSjFU/UFzzG7O2sdZxg759R2eIoucc98/jOLN9qgoM=;
        b=VJ4nrFeEVJQjr30Zlw3xu1phXDBW9IrjFchlHWOprZFSd6iscnNaPDHnv/PH+oLX40
         puVK8aHW2we6XuSJcHPi9jw0NO+TATorT+Eclov6yPUp9+f1tdMUggI9dM7evZ9S/YlL
         SM7aNIknqFAWvVm7m0KDec30lBifchIPCpoxdVk11HIY8uty1rHkFbB8TUvderv4Iu3Y
         k5mS9O6x0+f5nhSbf2LJbzd2BfYwJNSICAB2GDGwfgIIg2qgs0awkIjklC4gN3MjHR/j
         C3/vmW/1eQm87N9c1uiugNN7md+bTlLtkggDSgbJBzY7HKsE7SN1GYv2hqWJhsAaa1fc
         IRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969103; x=1686561103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljSjFU/UFzzG7O2sdZxg759R2eIoucc98/jOLN9qgoM=;
        b=BH3ipvbQnhGAFiP1FxI+kLRuuJhCz+ifJOdRoS9BTcIJ6orIhtUxUhBHVzfgO+exkF
         +wodfM6xEPeiDw8RFADDwvdVrcA5t+l3c0IN3iL0d+vxQiVM3H5U8DN1WL3Np4C54nVT
         H6z7LFb0xQhhzEHBcW2qgwE/B1Hhg+KD99XL8V8tSXSanLEFoAsCVwd5lW8Ndz4xNSd7
         TSkVwUssko11iM23xrrkh9PfIbjhgN8YFl9nApVfWdBplab9FKhqCNuCj8+8UsQN/YG0
         BVPfhyHvIiEtobeCUpPJuB4EqUn5yqnLMfpPTdvHNDj4oa5ejLNxiTe3t9NsvrPrKGF0
         t5Xw==
X-Gm-Message-State: AC+VfDwAo58UtXLd/4GZhOoVparMYX0Piwy9rUzEcK/sFDjeBaKcokDS
        Q3teFjz5GoCxjiZK3nIyi7UyxTWn81Q=
X-Google-Smtp-Source: ACHHUZ68G8Zv5NAE+OxT7uA3F+eOA6TOZrUW/OBuL7s30Wt2N6Pnqu5wJ8L6+t6Mj+wN2AjQ+qcpjw==
X-Received: by 2002:adf:f58b:0:b0:306:2b85:8dc5 with SMTP id f11-20020adff58b000000b003062b858dc5mr20036217wro.37.1683969103069;
        Sat, 13 May 2023 02:11:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bc5c3000000b003f0b1b8cd9bsm31345671wmk.4.2023.05.13.02.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:11:42 -0700 (PDT)
Message-Id: <95f1d7140814cc1598d52a4cfab33bf8aa0bf83c.1683969100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 09:11:39 +0000
Subject: [PATCH 2/2] ls-files: add %(objectsize) atom to format option
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

Sometimes users may want to align the feature of
`git ls-files --format` with that of `git ls-tree --format`,
but the %(objectsize) and %(objectsize:padded) are missing
in the format option of git ls-files compared to git ls-tree.

Therefore, the %(objecttsize) atom is added to the format
option of git ls-files, which can be used to obtain the
object size of the file which is recorded in the index.
("-" if the object is a `commit` or `tree`) It also
supports a padded format of size with %(objectsize:padded).

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  4 ++++
 builtin/ls-files.c             | 25 +++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 28 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4356c094cec..1bc0328bb78 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -274,6 +274,10 @@ objecttype::
 	The object type of the file which is recorded in the index.
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
index 6ff764cda18..72012c0f0f7 100644
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
@@ -274,6 +295,10 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
 	else if (skip_prefix(start, "(objecttype)", &p))
 		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
+	else if (skip_prefix(start, "(objectsize:padded)", &p))
+		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 1);
+	else if (skip_prefix(start, "(objectsize)", &p))
+		expand_objectsize(sb, &data->ce->oid, object_type(data->ce->ce_mode), 0);
 	else if (skip_prefix(start, "(stage)", &p))
 		strbuf_addf(sb, "%d", ce_stage(data->ce));
 	else if (skip_prefix(start, "(eolinfo:index)", &p))
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index 3a1da3d6697..6e6ea0b6f3c 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -45,6 +45,34 @@ test_expect_success 'git ls-files --format objecttype' '
 	test_cmp expect actual
 '
 
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
-- 
gitgitgadget
