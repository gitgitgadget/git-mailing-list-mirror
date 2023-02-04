Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846BC636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 16:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBDQRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 11:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBDQRC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 11:17:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D38252B9
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 08:17:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so7033329wru.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZmFLA/GjUUtdKIC5PODmhU9qBNXZDEjyzIb1Say0RI=;
        b=BGwBLcc7mZuXOlqujiUAKM2N2QFlbCFy2wBACNpbIjNvW6aJVaTYiQAeVOkBS7rqcN
         lUs9yQOq/3cCffCNXMMP7wltfGlr21VaA5uaUjMPMSVz+gpb0GGIGJvzXESkTn4hrX91
         BNS7KeCrKgR/Ql13JHat+4mScpF2NJUhfTCaYlVORUFCyRAtf+Vj7oH9wrjVcndUodsJ
         8lA/5x37owq10sXPaVDdKnRUS3tZK/x4pMTB62QIyGuUioE8MQeiqjm72hrvvl/9LEvJ
         ZTYqy+kJXWLAAbQb53dkyq7ensQtNrVwtbdaw8skn1DOlYH80d8cTLcdGAkigu1DmMLL
         TZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZmFLA/GjUUtdKIC5PODmhU9qBNXZDEjyzIb1Say0RI=;
        b=ayx5YLTPSgBynsQeSdOYC4GrXKzu0N7jNch/OXWJTNzTMpptZlfcZrTMzt2m2Uibx+
         VTR3PjtgCyHNEhf5xjWjP7qpy58xz2S9b+QkBBg5RDvbwE+lwadI4AtcaqENpvnHNdRi
         5OEIxtRbm0AbirUgp9xoW2x33lWyKLzDZwm2xjxX2XKCNhZxGwBDkmRHa42R3IFiDE1J
         pMTwYFMAWdBFlD/7sUCXamkhlFGp5ODzFclw8aEDmkM3m2+ismRKjwCbBoWZ1H9qryZM
         mSJ0CHXuiayZZ6pyhLiYYtRH1ShWHAXA+V0GJ9aLCbEGoPXsT66QrTm2SJ6/vCzPTxOV
         4gzA==
X-Gm-Message-State: AO0yUKURO9kR4Sl5ePOo5nk7totzuZNFa2vQdPPmzMLs0QIrcwDcQN4L
        SYvrMTFQNBeYSSEP/NRHs1JfOC+ZbS8=
X-Google-Smtp-Source: AK7set9WOU2cnZT6Zcq8oCwKeSvhLMDzienmQeO2ktfdPUye8YZZTpWid4dVAoe34yOU10+O7G5WGw==
X-Received: by 2002:a05:6000:982:b0:2bf:b199:c7eb with SMTP id by2-20020a056000098200b002bfb199c7ebmr11380410wrb.54.1675527419497;
        Sat, 04 Feb 2023 08:16:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw17-20020a0560001f9100b002be25db0b7bsm4756895wrb.10.2023.02.04.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 08:16:59 -0800 (PST)
Message-Id: <15e77743f7f19994ca2c3da626e57962275383a0.1675527416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.v3.git.1675527416.gitgitgadget@gmail.com>
References: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
        <pull.1458.v3.git.1675527416.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 16:16:56 +0000
Subject: [PATCH v3 2/2] ls-files: add %(skipworktree) atom to format option
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
        <pclouds@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because sometimes we want to check if the files in the
index match the sparse specification, so introduce
"%(skipworktree)" atom to git ls-files `--format` option.
When we use this option, if the file match the sparse
specification, it will output "1", otherwise, output
empty string "".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  4 ++++
 builtin/ls-files.c             |  3 +++
 t/t3013-ls-files-format.sh     | 16 ++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 440043cdb8e..4902c311927 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -260,6 +260,10 @@ eolattr::
 	that applies to the path.
 path::
 	The pathname of the file which is recorded in the index.
+skipworktree::
+	Whether the file in the index has the SKIP_WORKTREE bit set.
+	See link:technical/sparse-checkout.txt[sparse-checkout]
+	for more information.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a03b559ecaa..bbff868ae6b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 			      data->pathname));
 	else if (skip_prefix(start, "(path)", &p))
 		write_name_to_buf(sb, data->pathname);
+	else if (skip_prefix(start, "(skipworktree)", &p))
+		strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
+			      "1" : "");
 	else
 		die(_("bad ls-files format: %%%.*s"), (int)len, start);
 
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index efb7450bf1e..65939d38444 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -92,4 +92,20 @@ test_expect_success 'git ls-files --format with --debug' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --format with skipworktree' '
+	test_when_finished "git sparse-checkout disable" &&
+	mkdir dir1 dir2 &&
+	echo "file1" >dir1/file1.txt &&
+	echo "file2" >dir2/file2.txt &&
+	git add dir1 dir2 &&
+	git commit -m skipworktree &&
+	git sparse-checkout set dir1 &&
+	git ls-files --format="%(skipworktree) %(path)" "dir*" >actual &&
+	cat >expect <<-\EOF &&
+	 dir1/file1.txt
+	1 dir2/file2.txt
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
