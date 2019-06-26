Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FC11F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFZXvG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:06 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43547 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id z16so507166qto.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWEVljm4oXRwl6Ea51BtQfB+u+x6RAceFHPjatbjBs0=;
        b=MIc0krv7jRRAGCNBRn6wyRDCcQQap4f6RzoYS8jh0vmv7X6YfK6jafXoQJBdigAwO5
         OCkbOpYZxhEaF5GlxzxqN+gJFXVpsVOpqrWTUJLrT9XnZS65HaCYX1Y2IYY23t1erDFa
         wWhlkMNeXWwg3vIM6BtN8L5WevUP2T2VHieJcvijU8wHM3ZRmiVAKho7nA9m2DOxd+jm
         6pOAx2VWnokZ++Rx99A4itCx0tm9BEnu4K/8GZtRCyauscAM472v874562CeBYTbiEp4
         OSW8Qfu+b1jgPMz+hVO9ZhKiM1CsdpsbBgPGvOakcux44OvvcqoM85Eu4L6D5Efui7R3
         q7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWEVljm4oXRwl6Ea51BtQfB+u+x6RAceFHPjatbjBs0=;
        b=IcluHivyVRALItxsH+Pa9OKRkqdpzqxkZHXk7cGDyzIw3nXEUAIZYc7WGpfQ76wj/l
         /7GVLTAyRS3Eg06dAtCIBZN4tggFp+C1EXuG7k7eEfZ5+MDHt68TX5Ipa13GodAFh2iP
         gqB07ylBjLgjAcwJYXfLi2rjUQT1zK0QCf5KH5vZ53TK9pKLbFQl6CmDfg/28sEyQTRb
         f91KhVe+IrLOo/dVsYzfNWGWLNE/Ns6+GKn6o4z/9/AYg/I5H7nw/VP7xsiX0gerHnyT
         zC38chTfHb7IDZIcoC2EMLOIprMzxhsI1a9M2py2lwBYEMBuRitXYixHDfeBAhQ16fDz
         iT0w==
X-Gm-Message-State: APjAAAVN3K3WqoPAieyUrm6UVfQ7tbIKjT+ID1O06fn9JgfposeJhH/U
        EruGvv8Mfp7rESMY57XCjwA3IaKmBShPNtSW8UsA9ZTTjzmv9pgu06EGpvMTmtimh66pSqGzcfY
        dWAxuO2SYpFnmttZkLZIDPyZsadEffMVPGirHG3Tk9A05Ly0KBMg2Lu17EGH1a+/N2aER0DpNWg
        ==
X-Google-Smtp-Source: APXvYqyICc4x+O+j4iOZaAp5lq9LMScDYV+28Ey3Umsk5qg5ROTy+HL1BsFiMEYZ/afMDY2O5+gUWUr7bMFednpg6TI=
X-Received: by 2002:ac8:26dc:: with SMTP id 28mr564576qtp.88.1561593064848;
 Wed, 26 Jun 2019 16:51:04 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:23 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 04/13] walken: add handler to git_config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, we have no configuration options we want to set up for
ourselves, but in the future we may need to. At the very least, we
should invoke git_default_config() for each config option; we will do so
inside of a skeleton config callback so that we know where to add
configuration handling later on when we need it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index daae4f811a..2474a0d7b2 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,6 +5,7 @@
  */
 
 #include "builtin.h"
+#include "config.h"
 #include "parse-options.h"
 
 /*
@@ -24,11 +25,36 @@ const char * const walken_usage[] = {
 static void init_walken_defaults(void)
 {
 	/*
-	 * We don't actually need the same components `git log` does; leave this
-	 * empty for now.
+	 * We don't use any other components or have settings to initialize, so
+	 * leave this empty.
 	 */
 }
 
+/*
+ * This method will be called back by git_config(). It is used to gather values
+ * from the configuration files available to Git.
+ *
+ * Each time git_config() finds a configuration file entry, it calls this
+ * callback. Then, this function should compare it to entries which concern us,
+ * and make settings changes as necessary.
+ *
+ * If we are called with a config setting we care about, we should use one of
+ * the helpers which exist in config.h to pull out the value for ourselves, i.e.
+ * git_config_string(...) or git_config_bool(...).
+ *
+ * If we don't match anything, we should pass it along to another stakeholder
+ * who may otherwise care - in log's case, grep, gpg, and diff-ui. For our case,
+ * we'll ignore everybody else.
+ */
+static int git_walken_config(const char *var, const char *value, void *cb)
+{
+	/*
+	 * For now, we don't have any custom configuration, so fall back on the
+	 * default config.
+	 */
+	return git_default_config(var, value, cb);
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -43,6 +69,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	init_walken_defaults();
 
+	git_config(git_walken_config, NULL);
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

