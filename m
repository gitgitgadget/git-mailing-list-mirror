Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83BC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiCCA6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCCA6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:31 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B8151C78
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:47 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f4-20020a17090ac28400b001bc40aa09fbso4334911pjt.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=lpWeoscgF/HbR+PJcJOd/gRmJGY2SqoyQP4UFUV7M1B903kZydEOw310UK/eSdOsr+
         fVSQW8ymVFFwDupoeL91mWDAG+o1JLsdO/q3FpDSAXClm2ouZCOrS/DLtKV0kZ24/wIa
         8KHxFMgUfY+GWaJNncR2Z6qmfCqlz0f/pIQWBhigpnrCTYAmKhA33Dse7BqNx+wHAQ4y
         Sq6/4JsZAxaxyFAHRxBQllpGeBU7mWYaBb6qtphvYYBnjrXnrf/Iri/u4SWRzH6zbR0Z
         3JjnqEAib0Ooih3+Tk1AtoF6np+lh7hADRbu+tT72+DCPcr0+zxigvVoWZOgQeWyXi7Z
         iaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=iWzHGROC5CxbObJoeD+Q9uGYYIlut1Eh0Z/BmyTUkXyF/ZIWFQfJzbY0rjNcQ2aBgV
         IIpW7n+CY5tP0RtNBjG6rXM0QBEq9BOyuzf2jK6oqTQtoDjAtl+yzFXn9EPxuQ4KI6Fv
         PQtlvdo45tdTMCmMOojqpBIMfb4ihjLteggLjN390ERZG85aCO7wEFx7IfCkLQGcY9nc
         R4lrItG8WAmj83e8GbzfAMYG7DonOP/+T+jph5LUJQV+/Ay7zyrLwzSzWCe1lx33Vw93
         qlI17HHZGv/DHNrevnoUpw9qR4PXh7TjqMIZISzfLz4nYM+Jse7s1lb1WHiZ+fH3yFIK
         d7AQ==
X-Gm-Message-State: AOAM533VAmNJp8FhZNL8/6Wgqs3t1k7hApB5LEEdNjMMGs11Oa4La/hp
        leajLU5CfMJj5pOhN0TUOhbXO9/98PDKVXfm7YPVqaOOMHeYVyKN9hLq9rzCVERa2F4JiYyiNyg
        Jw/RSqZa1Bj6UoiNYs896t+ov7x4S9W0Avj9apwS/GTdLKCOkWCUKE40NIseyEDk=
X-Google-Smtp-Source: ABdhPJzAdBQI8qPtjQ1/MaIDrcJ5HFFC779mAT9yGvG5CxvLySffW4i2Bwo2rCNwAo1BuDgdfXa2rWsuNylXVA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:22c4:b0:151:99cf:66f2 with SMTP
 id y4-20020a17090322c400b0015199cf66f2mr4846972plg.47.1646269067092; Wed, 02
 Mar 2022 16:57:47 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:17 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 03/13] submodule--helper: reorganize code for sh to C conversion
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

