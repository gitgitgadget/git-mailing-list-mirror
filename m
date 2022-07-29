Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E95C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 09:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiG2JGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiG2JGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 05:06:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600031B797
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso4952508pjq.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+ZbNougF/wSxwgd4qIi42pUrwOHU1UKeNnzLQ3A78=;
        b=KEmQc1SRTSeJdi8NxwLsNXQAkmax21+xTX+6iy80u8GDXD+FAS8w7HUSHBr1OwGLnT
         mcayZ7dR5U71ygIxe82gRAs8MhiRgruZaOGtN9yQ92D5nxpKT9cetVyOnKkpqVSw0/Fj
         8KvOuRGVZuw+OiR+ai6I8g+OcXIRuSljvZ7xzg27Fyvy/JAponxEYy+bmqVVYBeNG18d
         VbL527D5dI4lENgh0bCS+NlxAjn3IGfuY4xeU11J6hxMgQzVMnLcn1wxXTS3QHm7Gz1T
         YESw2suD8GA/TYNjl1etc4o++q9zpN7jv8it5r22YykZelrMs6SVw4Y/Sq41V+BM4RHM
         8PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+ZbNougF/wSxwgd4qIi42pUrwOHU1UKeNnzLQ3A78=;
        b=V0xxDw8yNCvSX6RjASxxgtlu+1qDSerP2yhPr1vuBOeNka92NtWRJDoZ8hzZL56WGI
         1tdjy2jRrMsreyD00Ymk8yPBOARhT4Cm018Lch7hHbrRG/fb2jAP4NZ3dawaI2uQfRG1
         Kna2atyivG1DmKG69UfcyYRFowiqDbAWyKrk6B6a7LEAMI8LRKq/r22VlDSLciNbr9MB
         VgoIxMaanDb/NkiVy+L25kOnqyOUMkv5ETcr4ZOHKFlGVAWFf1dcDWxjI0xTR22lIRaP
         w/s78EY7aoe7R47uUARxtMk1gA5M9IUBCIQ9s8XKHF8cYC2Ckp67PeX0SGDxRoH6uNEB
         6rIA==
X-Gm-Message-State: ACgBeo0Piv5k84y3t9mp6ucKzV2NGPXE+MliGEtV0F7pwUC9MqecIGE7
        roMIxcOUr3MngkHmuAM3rEvRhvPPUts=
X-Google-Smtp-Source: AA6agR5VFrAwJsMkYOjsdAcuD82tnY2obsrgJbGdHmc3OGlOG6thGf6y9nGmmVAPZxI/UmYUIQ7jHw==
X-Received: by 2002:a17:90a:d3cb:b0:1f1:82ca:3ba0 with SMTP id d11-20020a17090ad3cb00b001f182ca3ba0mr3737520pjw.236.1659085592609;
        Fri, 29 Jul 2022 02:06:32 -0700 (PDT)
Received: from localhost.localdomain ([113.173.163.90])
        by smtp.gmail.com with ESMTPSA id x28-20020aa79adc000000b005286697ec68sm2289538pfp.133.2022.07.29.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:06:32 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] submodule--helper: fix build warning with gcc 4.8.5
Date:   Fri, 29 Jul 2022 16:06:23 +0700
Message-Id: <2466aa5019bd950df4b77d24182f1ec848069d1b.1659085438.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.37.1.560.gdfb9273964
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

list_objects_filter_options's first field is a struct, it must
be initialised with {0}.

Fix: 3851346be5, (submodule--helper: replace memset() with { 0 }-initialization, 2022-07-28)

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
for-branch: ab/submodule-helper-prep and seen

Feel free to squash in

 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3e00c9929..8285c69bde 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1727,7 +1727,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options = { 0 };
+	struct list_objects_filter_options filter_options = { { 0 } };
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -2595,7 +2595,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options = { 0 };
+	struct list_objects_filter_options filter_options = { { 0 } };
 	int ret;
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
-- 
2.37.1.560.gdfb9273964

