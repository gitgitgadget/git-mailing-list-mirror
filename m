Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917FE1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeGQA45 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:56:57 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:55083 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA45 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:56:57 -0400
Received: by mail-yb0-f202.google.com with SMTP id a12-v6so18009076ybe.21
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0jPxiTpp8ITtt6LnADS8UI6iRRey1udD2Rn3xtLin80=;
        b=QU+G291L9Ec+gTRzV5Z9u60nm/AnBexYhkxg04Kg+oTaKnCh4RxC/vaP8MQ2eULhG7
         J0MRSSL2MujlgfGdaKry/2adxQIhs6Ld71bOi3xY1AaTUQM3Y0x3PiVo0niVzi1ltKWv
         rEdkm4+jrrezn3jgzKrYYnHVgYjYh+PhRpvmE3lMWIm8R1q03e430dju3Rs1zA6fM3CH
         8SR4StiMKTRhLEB1hLc5U6Et0x/N1N17xDUgCoBj30UiZo6l6T02EcSTiSKlsg1lBwRm
         YbhjThuPlhUM1GSPyoL8UYe0fKrr3Qa/h2cHmpRAMCgmNvm82cg5J7mX1iarY1kGsKuQ
         1OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0jPxiTpp8ITtt6LnADS8UI6iRRey1udD2Rn3xtLin80=;
        b=MoXCndTBvmFZZw1IZMJ5tvzCoSEVuILYSXysvyhCIlv9pURhJc8kvoNw0DsMQh1nts
         afAhD3YmFB3j/Ln5gjoLR3sqQR9Y40jPe/5MP5nSr+N0kKLo4GWC2efEKmqpbxUq6OXM
         UGMf+ey+Ov8is9YvPC+smwFtv3stAerri9qtuemb6UkvClbG6hGloEyQelHUWloEKDCQ
         +M9a21oFLxLVRqqcLfE4NJ6DWn95WqUkUFVYnPU4r1fXe8Z9qPH+8QDOzBCkJQ5e+CXo
         IVkTp4SHyi/7RcJxGKt6T91ExfJrEpwu4Vfq7xVlznUeycWmq4ScyLgbBh+C3EQNOd9E
         OQLQ==
X-Gm-Message-State: AOUpUlGNIwSDkStRFBRcEMxounuKgr+2TQR5S+h/7f+rVqBzZPvyNOJk
        Z3pjeQSB/OjjfATUw2GiqccoaTZnEoYkeeynmNIFBtPY4/gEnT35KH0VQRjdgHZIg3JuLnSV/sg
        hw/g0Hp1DtMsie/t8cbQWq+0id95JMzPMUAzWMtJaCJK/tIcVSyF4/o2z+7Oq
X-Google-Smtp-Source: AAOMgpecaYoqB9mBaqknq7RJ8i6s/X6TcAcHe4Qd7o/Akd3/hFNv9ObyrQG0FBHup5oqvHuk1mTUMlLYcoda
MIME-Version: 1.0
X-Received: by 2002:a0d:fa44:: with SMTP id k65-v6mr5728129ywf.82.1531787227448;
 Mon, 16 Jul 2018 17:27:07 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:52 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-5-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 4/6] builtin/submodule--helper: store update_clone
 information in a struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The information that is printed for update_submodules in
'submodule--helper update-clone' and consumed by 'git submodule update'
is stored as a string per submodule. This made sense at the time of
48308681b07 (git submodule update: have a dedicated helper for cloning,
2016-02-29), but as we want to migrate the rest of the submodule update
into C, we're better off having access to the raw information in a helper
struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 96929ba1096..fb54936efc7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1444,6 +1444,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct update_clone_data {
+	const struct submodule *sub;
+	struct object_id oid;
+	unsigned just_cloned;
+};
+
 struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
@@ -1463,8 +1469,9 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 
-	/* Machine-readable status lines to be consumed by git-submodule.sh */
-	struct string_list projectlines;
+	/* to be consumed by git-submodule.sh */
+	struct update_clone_data *update_clone;
+	int update_clone_nr; int update_clone_alloc;
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
@@ -1478,7 +1485,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -1572,10 +1579,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
 
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "dummy %s %d\t%s\n",
-		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
-	string_list_append(&suc->projectlines, sb.buf);
+	ALLOC_GROW(suc->update_clone, suc->update_clone_nr + 1,
+		   suc->update_clone_alloc);
+	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
+	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
+	suc->update_clone[suc->update_clone_nr].sub = sub;
+	suc->update_clone_nr++;
 
 	if (!needs_cloning)
 		goto cleanup;
@@ -1718,7 +1727,8 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 
 static int update_submodules(struct submodule_update_clone *suc)
 {
-	struct string_list_item *item;
+	int i;
+	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1737,9 +1747,16 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for_each_string_list_item(item, &suc->projectlines)
-		fprintf(stdout, "%s", item->string);
+	for (i = 0; i < suc->update_clone_nr; i++) {
+		strbuf_addf(&sb, "dummy %s %d\t%s\n",
+			oid_to_hex(&suc->update_clone[i].oid),
+			suc->update_clone[i].just_cloned,
+			suc->update_clone[i].sub->path);
+		fprintf(stdout, "%s", sb.buf);
+		strbuf_reset(&sb);
+	}
 
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.203.gfac676dfb9-goog

