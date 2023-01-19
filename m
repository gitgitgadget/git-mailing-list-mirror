Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B4C38142
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjASReh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjASReb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:34:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408795593
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j17so2160094wms.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRr/xhIAtx6og2JPYbTn4gKBt0MKzrnOA+Mr8Tq9cl0=;
        b=ij7OTekWQzP2BiuP/6FQ4g4XcMiIPF7gbP0xdv/rK6TWhz2Ipq1BOae8fMw4eV4kJQ
         PAo0wQqcr0tIG6WYR+yhPFk0uWqt4+be97g2FcgH9IFHwsz1FrgfI9KgcRk/YrfzkaHd
         3G43kbYhgw1KoEE6Q1mdTHn8Kn3j2QoJuGVbu7uhKKOgtVDImqQVvaQTzgMvprjcYHJn
         PFropaUmOV+dEUsEBrFxzOxLMpiCPn7HX9IbNzdrOWW7Pm3vplAEfu2LkjciEOT1PK26
         Gl3yGdtXbdUpThwGQE3rpJlSz9ZZVENh30zsqtE7eCtlpzJdqTXzeLtZM67qhEva6BZC
         ckDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRr/xhIAtx6og2JPYbTn4gKBt0MKzrnOA+Mr8Tq9cl0=;
        b=0cDLRBkthaykSjdQ+1S0x0krEkrnP1ta6ArMM8/iG/jcm/GH/lLTDoXcIOFvvCAEvO
         WxXirD+cKX8LPp1mq6Y/zj2D7WqyVd4le6FNsFuDpZ8ccqjDvdtMc5adqqtrqkOgM6n9
         igdZpNABOJYYF8pUppS9WvIeO2FjnATuZN3Qx/xFgIoLgf2MZ08t5muLdAfAU84PSqLC
         am4boFxi2rRwpRxtzFW/A+kdR/89w0uzFWacqOzPnA+5zqweD4MPkBvQ9kjRYULtisbo
         /aF6aBg7NSN9xjUwG93hOg/ub3dVIWKMZMoXcqZPEhm2DCdlVLoueM08xcAQcqnui4nk
         lfaA==
X-Gm-Message-State: AFqh2krbBaO64VJtTEto4nX2h5QqIBYYhTaOjXJflAzbUzv2bMoZqtRg
        i/HuM/9sfNKCXKcbtRz15hfa5F216HQ=
X-Google-Smtp-Source: AMrXdXuI++6CfR+0HhJn+EKPAuIiLNBaolse1v213jfrfXcJ/RSBxspjSPLVorihbLGfvqd4MGL/tA==
X-Received: by 2002:a05:600c:4f45:b0:3cf:68d3:3047 with SMTP id m5-20020a05600c4f4500b003cf68d33047mr11048032wmq.41.1674149668714;
        Thu, 19 Jan 2023 09:34:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv8-20020a05600c548800b003b47b80cec3sm6590075wmb.42.2023.01.19.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:34:28 -0800 (PST)
Message-Id: <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
        <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 17:34:25 +0000
Subject: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
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
index match the sparse specification, so introduce
"%(skipworktree)" atom to git ls-files `--format` option.
When we use this option, if the file match the sparse
specification, it will output "1", otherwise, output
empty string "".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  5 +++++
 builtin/ls-files.c             |  3 +++
 t/t3013-ls-files-format.sh     | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 440043cdb8e..2540b404808 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -260,6 +260,11 @@ eolattr::
 	that applies to the path.
 path::
 	The pathname of the file which is recorded in the index.
+skipworktree::
+	If the file in the index marked with SKIP_WORKTREE bit.
+	It means the file do not match the sparse specification.
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
index efb7450bf1e..cd35dba5930 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -92,4 +92,27 @@ test_expect_success 'git ls-files --format with --debug' '
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
+	git ls-files --format="%(path)%(skipworktree)" >actual &&
+	cat >expect <<-\EOF &&
+	dir1/file1.txt
+	dir2/file2.txt1
+	o1.txt
+	o2.txt
+	o3.txt
+	o4.txt
+	o5.txt
+	o6.txt
+	o7.txt
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
