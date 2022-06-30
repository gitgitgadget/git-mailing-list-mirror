Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DEC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiF3VT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiF3VTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B54D16E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so363482wra.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QXTVh5Qm6iit5ZJEERJ5pQzNNyNVLQZG3E5ppXvFz7A=;
        b=GAKgSrdP0qK9sAh10WT2fIZPSbsazXuLfzqwxDxDiRLe29r9DuUZallmayhSt6MEsw
         IIqoAv2FSdsOPypCX69N9XrISFBjjkA5cs88Cs9WxtoQ4O4CJmP+IOsTlqok1d0w0MgF
         fi88avNj9SYrzMtNZQjLWSMBybN+x6L/4/gUpYYM1o0fmNJUuBeq3Qi6oscn1sG06/JC
         PMzHsnT8RAxLlnC5/TQCjGQ4OzE1kuitIt1sRi+r+DjRJxm00ogqkZ/0MzmuTDCdRdaK
         EdI6e3xN0p4CzztPDqqtBF7EJsxVdbGRuUtco67kxlRbKueLF2zjP5EwDlPUtdSxFmze
         4o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QXTVh5Qm6iit5ZJEERJ5pQzNNyNVLQZG3E5ppXvFz7A=;
        b=q7DHeVqAV7iUW6A4+Te3qUkZuoAVJryD6wBcgF0n2e/zNMX9hHfmgM14VpXDrhXnmA
         TWj8WxXydfa40LfIm0Nx3BdoZACjaGBufVtIJM1H1N2tOMt7gIa04xKuu6g5u5VJidZV
         eOu6FMeVHDhPPSEKWwtLfCpTxvfpAwIPqHJuMjNDM0KSyo/1P00MzUXeDVpsGV6ynpei
         208b4bw9hHLp0mtS/CzmIxoHBBho01qiO4BngEnH3iw0j1Kl9SHfvbHpTpIonex18Gr2
         vO9UXFNE9mHPEA2zb2A72Rgv5CX5NYq1/wK8Bc6cGsoshKESRb8HoE8xx7MjrP03BE+9
         in5A==
X-Gm-Message-State: AJIora9wQk3rsBmNJAN7BxDDoNqKVcv7L8v0Z0vs/y+wQPROc2g2qkFQ
        t7TdHOLeBg286qPXwMJ8Vn4fyWP1Nkw=
X-Google-Smtp-Source: AGRyM1vjCofnf5n8LWsl5hjrpBffj4nObWrMxJRRZnvtOFUIFlgJqqMo+qWhk3Hm3QReYorNI66dPg==
X-Received: by 2002:adf:ed05:0:b0:21b:947c:c97b with SMTP id a5-20020adfed05000000b0021b947cc97bmr10218165wro.509.1656623988315;
        Thu, 30 Jun 2022 14:19:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm8727745wmq.20.2022.06.30.14.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:47 -0700 (PDT)
Message-Id: <6e556c412e9283cfa9f9be4bfe4e9c813a53bf52.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:27 +0000
Subject: [PATCH v2 07/18] submodule--helper: rename "absorb-git-dirs" to
 "absorbgitdirs"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Rename the "absorb-git-dirs" subcommand to "absorbgitdirs", which is
what the "git submodule" command itself has called it since the
subcommand was implemented in f6f85861400 (submodule: add
absorb-git-dir function, 2016-12-12).

Having these two be different will make it more tedious to dispatch to
eventually dispatch "git submodule--helper" directly, as we'd need to
retain this name mapping. So let's get rid of this needless
inconsistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 4 ++--
 git-submodule.sh            | 2 +-
 submodule.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f0702d0cfa2..1a84ae8efd2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorb-git-dirs [<options>] [<path>...]"),
+		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -3389,7 +3389,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"push-check", push_check, 0},
-	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
+	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 0df6b0fc974..1c1dc320922 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -552,7 +552,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
+	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
diff --git a/submodule.c b/submodule.c
index 4e299f578f9..2af16c647d5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2374,7 +2374,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.no_stdin = 1;
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 			     "submodule--helper",
-			     "absorb-git-dirs", NULL);
+			     "absorbgitdirs", NULL);
 		prepare_submodule_repo_env(&cp.env);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
-- 
gitgitgadget

