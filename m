Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A19C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiCEAPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCEAPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4656244A02
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:14:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d2d45c0df7so85464777b3.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=EVBA4K9Xc37rlYtd0UIINOLY1lOleUPylVJC6WfpFcfryRaF4h+B83yXnEWD0DSoSq
         FKtsaMEEmdxxohg9ZFYZvHyH8Zr1EWB7N/6rq3gCmP8s7veePVRM6eH14twMk+7n50Ep
         CNDA2RegS/FbCwEucgvRB3ffXPfMeJBshLELRR9QUU2Jsc4Gzj+K5JZjIrenU24f16LY
         Nezy7kRdFVbnkjsdsslk1cSjAD7nv2roE0Ex8yY1qwq2WAhp7z6iCgsnSqkLETSFuOLM
         aGsaQ7fKZWQ4gsaa9PFQuNbILfwG0LiY0P3JEexPWK6lt97G0xaVQhranwwCzX+yW5F6
         kpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=1+GInKeccqd7lkxsfAoq5uVP7hXSIiZ3TwSA6te6k+AZa/uLz1XocavPCOJUmx2uWs
         iY76fXH4j1BSBHhCTKMjKPIuFfcfAv9alRW6h9sx7i3+MfDrwPb1R+OwZJ1m5DeYR4j4
         qyajV+hf6NNfFfOf+3Rzh7PDGYuSWO+XTAkDzYNqXoD7JZyLnHTF9RlhfwtU0Mez1QBo
         fCicktiHaYE+6qJISknMCZnACJMW0ClIuCcxkMlMoj2wBacEr1s+gZBA2AaYUpShQ4F/
         SbogeK+nZyG/FVInx+O0JDYkFOMsJ3chBNgEhJ6wbCu9xsDW07sBBgQIC+iKiNV/x+DA
         34nQ==
X-Gm-Message-State: AOAM53183i9ySOooRegddSdRNwiYEBxUns7nzr7FS7JpOuFMHnuYlnrY
        iA17RmmH9qhU2F7iJXgUdFGwwRAIxEn7wBkwGmAsUSkEFnWUA0x0VAfGRRQoo1eHVWGUhYcMrlQ
        cle30BvDFX0nbVvMwVYgsaggAVknl71y12MWz/VAUhWbLn8ee0hMui/+HDh9r9Co=
X-Google-Smtp-Source: ABdhPJzcDlnVjkAqwRgH5AhaQaBRe8apukXIR4eS/0M+LmG187G9dtrsrqfIAd9cMM4qWO19TJVkDCJASCF8sw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:107:b0:622:942e:3959 with SMTP
 id o7-20020a056902010700b00622942e3959mr941630ybh.280.1646439298013; Fri, 04
 Mar 2022 16:14:58 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:51 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 03/13] submodule--helper: reorganize code for sh to C conversion
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a function, update_submodule2(), that will implement the
functionality of run-update-procedure and its surrounding shell code in
submodule.sh. This name is temporary; it will replace update_submodule()
when the sh to C conversion is complete.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c11ee1ea2b..1b67a3887c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2452,6 +2452,16 @@ static int do_run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
+/*
+ * NEEDSWORK: As we convert "git submodule update" to C,
+ * update_submodule2() will invoke more and more functions, making it
+ * difficult to preserve the function ordering without forward
+ * declarations.
+ *
+ * When the conversion is complete, this forward declaration will be
+ * unnecessary and should be removed.
+ */
+static int update_submodule2(struct update_data *update_data);
 static void update_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
@@ -2618,11 +2628,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 					    &update_data.update_strategy);
 
 	free(prefixed_path);
-
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data);
-
-	return 3;
+	return update_submodule2(&update_data);
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
@@ -3022,6 +3028,16 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 				    force, reflog, quiet, track, dry_run);
 	return 0;
 }
+
+/* NEEDSWORK: this is a temporary name until we delete update_submodule() */
+static int update_submodule2(struct update_data *update_data)
+{
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		return do_run_update_procedure(update_data);
+
+	return 3;
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT

