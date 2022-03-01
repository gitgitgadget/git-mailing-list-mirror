Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF97C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiCAEmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiCAEmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84E6E4FF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:42 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i7-20020a170902cf0700b0015163eb319eso1973162plg.18
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=UOCTtnj2IFZVX/1u9pZYH6npz+eV+7m7YUtI7CwEKo/WaLYsgQr9O+7An0TqvgVvVT
         JE7ajFJ3dB/v6zuqMXr5mN/4Dn2Iw+7Fv2mCSg5GKcG+hKlHM2rewPSFg3S/B7tJLGWR
         JiGDsd1lf3MK1PKEgiXtxA1KnlnBrTU7FBAgOXnS0l+dFwRGQ6GoUOMAt0IuJSN1HHG2
         9hj/uOAyfKFeb1M1hgPdmrei92UfJeaXp40onlhkqCH/PfYeTK5MaN2z/buF62gwL2H+
         xCeNixuuy3XWU02EdlBrsA2Gdb5fskY+IneWrz4ef0+GN3Ck+mNG2MjR2apee7PKWdlF
         vL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=UuWuWCYKd3qH9C4Gr941Qc3RoiRsSKcZBW/C4xKp3ZqJDk7sincf5JtU7ZL7FWe2XL
         WkkRu3ZE2Yrgz0OlvqeaWWBdzxUgQLnBaW4SsfjNRA0A11lVCO0W/vu0ndHSkEPIty3q
         rKU7ScR2hPjSddHzlOsTePPYdVVyF+G9qGF4JwYq9pHTt1jL+Tq5mqueNDd1l8kP1hyL
         aMm3muHaJ+cEmsRCYy8BK+sMc92SKbkD9lhhxwjluy389M+kIJ1/6vgT8ZgGnac+xcZD
         epivX2EQVTkxkZqnLwC+Bixn9JsKTCZHJPGMbzUH63K1fmPbJyp7c5WU15jXeBzBAnC0
         ZB7Q==
X-Gm-Message-State: AOAM532kKzYSCbi6BM1PGuQB6G6dUlK9fsBN/5ufUoo/pcs96BAbtSFu
        ZqooT3XUXcfjYHyhL9p0adFcZQdJsFmkr+gjMloM/dFdC1ao6YzHkx8KMKMJVnTY87CprHk5/cm
        KZsrlxvn3mm6JD6S1WzZDZhJITmMHO+xQs4lFIXycM85NgIQd7PoujqtLuU/sjQI=
X-Google-Smtp-Source: ABdhPJybO0ebHQBqD9YCxreDIJSFAx3vQIxeIDMXsia6yQ068J+QdB7GyM2nhEh25UsmqAAqKqKhmU8ymMP0Yg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP
 id mi18-20020a17090b4b5200b001bcb208dc5cmr452932pjb.1.1646109701917; Mon, 28
 Feb 2022 20:41:41 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:22 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 03/13] submodule--helper: reorganize code for sh to C conversion
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
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

