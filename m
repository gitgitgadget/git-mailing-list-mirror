Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA387C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 15:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjAKPnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbjAKPm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 10:42:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B229719C2B
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 07:42:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d17so15467172wrs.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PktTF6Vdnr4Zwx1AMhhQLUmaPfX4Ly7aBpJEqdCITAg=;
        b=W/JBVodNiymq20RYjdRhMp5w9f7c46XFIL7f9ijuUXR1sePWgOTbRVPx8xRpqAbAuG
         ZfhPCSLJlfBeTrrr80t6adqU6kmMtMZ1Y2C3Fws2esaxQB0VSLf1LuQ3NwqURbzwQYJu
         +eXqwrrrwlQ8CUbZXTVVSZFph4xE7HZJN+fbfM8ywvP6+z4sk1LqKwx8JFFiZDxIm93r
         S7zoIBQZyET7rkgf6tAuGjLjEqEoDItk+KeqPcNtO0t0RbcUgrRj5e8gmn+Zq/gakyi1
         3wXY3hawNctC1giHBp/zlr8M8uDcBBKtvRPsmgcBw2OsQsLg8s7fcWdPglg7S3/huIfE
         Gzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PktTF6Vdnr4Zwx1AMhhQLUmaPfX4Ly7aBpJEqdCITAg=;
        b=EkFQ5aSMBkMqk2mPZ5ZgrZ30OP4rN5JSiJZO87eGgXKGGZ/ynS55ul+bhZLKxWo6yW
         QgYsvOLLPMklQWrpozL9p6ROHe/sUSIrvFvwT0Kta7tmr1tkKbE9XOCIKYfcl0/cvsZh
         Bqk2pvUStFVkVrUfrAw5XraIu0+G/jZE14txTNh+l4S74MCP1F71R3lU72oHraSXS4E3
         CCt3wo9bgY0iF8fEAL6iQGkWcEdlueYioRAcqQI30M3iYlojv4+CkKOROB0alRcFZsKi
         8tYzMBqhaE58oW4/QVrrTwt29yPAqbqsmsT3wxfci25OpElsyVU8LKiGbWsTEQVrmZc+
         6YAw==
X-Gm-Message-State: AFqh2kpdrFrcdTg5/0FlCCo/b6irlXzQ00/thcfqX3aInbx5JLNb+7Lh
        MVu1qKhv+IHSBTzvOgrTwe2315q4Dq8=
X-Google-Smtp-Source: AMrXdXtp1x6NVe/yqnQcqt6H8yhc1cPJXJmcp/yFFY9U76jovimPrKDFhtkgkhGpyzEaMkwqHbqkPg==
X-Received: by 2002:a5d:488b:0:b0:242:5ae0:5b41 with SMTP id g11-20020a5d488b000000b002425ae05b41mr47293003wrq.33.1673451742990;
        Wed, 11 Jan 2023 07:42:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm18174621wmj.36.2023.01.11.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:42:22 -0800 (PST)
Message-Id: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 15:42:21 +0000
Subject: [PATCH] ls-files: add %(skipworktree) atom to format option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because sometimes we want to check if the files in the
index match the sparse specification by using
`git ls-files -t`, but `-t` option have semi-deprecated,

So introduce "%(skipworktree)" atom to git ls-files
`--format` option. When we use this option, if the file
match the sparse specification and removed from working
tree, it will output "yes", othewise, output "no".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: add %(skipworktree) atom to format option
    
    git ls-files -t is semi-deprecated, but in face we need to use -t option
    to check if a file in the index match the sparse specification.
    
    So I think this feature can be migrated to git ls-files --format, add a
    %(skipworktree) atom to indicate whether the file in the index match the
    sparse specification and is removed from the working tree.
    
    v1: add %(skipworktree) atom to git ls-files format option.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1458%2Fadlternative%2Fzh%2Fls-file-format-skipworktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1458/adlternative/zh/ls-file-format-skipworktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1458

 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             |  3 +++
 t/t3013-ls-files-format.sh     | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 440043cdb8e..0e50307121d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -260,6 +260,12 @@ eolattr::
 	that applies to the path.
 path::
 	The pathname of the file which is recorded in the index.
+skipworktree::
+	If the file in the index marked with SKIP_WORKTREE bit.
+	It means the file do not match the sparse specification
+	and removed from working tree.
+	See link:technical/sparse-checkout.txt[sparse-checkout]
+	for more information.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a03b559ecaa..d1a27f28f01 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 			      data->pathname));
 	else if (skip_prefix(start, "(path)", &p))
 		write_name_to_buf(sb, data->pathname);
+	else if (skip_prefix(start, "(skipworktree)", &p))
+		strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
+			      "true" : "false");
 	else
 		die(_("bad ls-files format: %%%.*s"), (int)len, start);
 
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index efb7450bf1e..ac8b865c275 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -92,4 +92,26 @@ test_expect_success 'git ls-files --format with --debug' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --format with skipworktree' '
+	mkdir dir1 dir2 &&
+	echo "file1" >dir1/file1.txt &&
+	echo "file2" >dir2/file2.txt &&
+	git add dir1 dir2 &&
+	git commit -m skipworktree &&
+	git sparse-checkout set dir1 &&
+	git ls-files --format="%(path) %(skipworktree)" >actual &&
+	cat >expect <<-\EOF &&
+	dir1/file1.txt false
+	dir2/file2.txt true
+	o1.txt false
+	o2.txt false
+	o3.txt false
+	o4.txt false
+	o5.txt false
+	o6.txt false
+	o7.txt false
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
