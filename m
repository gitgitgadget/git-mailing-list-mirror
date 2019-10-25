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
	by dcvr.yhbt.net (Postfix) with ESMTP id B42171F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391209AbfJYCvx (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:53 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45245 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:53 -0400
Received: by mail-qt1-f201.google.com with SMTP id n34so655369qta.12
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pRrgZ12LQ5OWBU3mb17YcqPzidyZOAWK/eh1o+ayz7k=;
        b=a5LalvxN6d2dW4zG1oY3xWF05JS8V7hzxXOsZdXEB6U8eK2AYY/B0Y4Vmty9kHASMT
         5R4/Pph19b9jXvoD5nf1xSopM7U2lTKvqIktOYtyCAK6UJnhprujyjLoucOVoRrIy1gx
         MkwqXN76TUmWf2SqgI5s3sRQQbm4gMBURyt38dR5732q+kGE8EmhN4/C6C2w4CNeiPbb
         Olm6F2nyiLIn48bK0AvRXx+sGvQCdaoJndh9pOvtzYv7gtgO87zn9l0ZA30ryWcls9cz
         momUsbPw6uAYzOWnpzyomaxFzjtJ8TnIs2ke9PetGKktph/S90vgg2ZZD/WIN32YXTj1
         n/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pRrgZ12LQ5OWBU3mb17YcqPzidyZOAWK/eh1o+ayz7k=;
        b=VH3/Z3G3xtdBaLC3Dmb+nD6bRcYRPzidZCkuGsuZXf6+iD/Q1ZrrjVpbtsTiV7FUrJ
         k+RRzMWUzh0jArDbzR7Ht1kPdDybacYAMavfsxSXnGTprG5ALKq1pu9fDJDQv3U04v3l
         ph567VaturS9h6SB+cpxfYR4lTqO0GTM6vNF2rS8olDIsz8f9XP+xczVBrgCpTJocjwq
         O2NA4G7flBj6/TG8cmbI5W9c0St3WtFnXeZi7tSm6p7waTbIguZwzxVMteRMg6R9G8Sm
         T+P5mbp/D3Jd08YvP/LVa5glMKjbX6hsDHvgr5VYYdnB8aJ9GbOcHNkSjeKeRbGYkNiI
         OfKA==
X-Gm-Message-State: APjAAAUmQrsU9gLeAKEQGS4fi72Rq7e0yKuuY5eplru3r4yv8iddc2UM
        kfl/UlIFM1CngzSDiydL6QYzKJ16aGbDbYS06U11+aE08xeLIeTRKaNWBd+UM5k2Pb2vcwZTFDF
        lJCEVeLfsd1xXou4LJ3qfUlTHqAT/iIjrhDQZsOokNfuOk1JFfqgocDwMF8aM6r14BAqFP1yr9g
        ==
X-Google-Smtp-Source: APXvYqwWz49wo7ikqWqk6DivbQQJjKYKD9QhqKXU6r3aYmjrZOP0ZQALsC4saw48k4D7A0q3Y4ixbYoC1D5o46WHrCE=
X-Received: by 2002:aed:3b54:: with SMTP id q20mr910981qte.151.1571971912266;
 Thu, 24 Oct 2019 19:51:52 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:24 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 4/9] bugreport: add config values from whitelist
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach bugreport to gather the values of config options which are present
in 'git-bugreport-config-whitelist'.

Many config options are sensitive, and many Git add-ons use config
options which git-core does not know about; it is better only to gather
config options which we know to be safe, rather than excluding options
which we know to be unsafe.

Reading the whitelist into memory and sorting it saves us time -
since git_config_bugreport() is called for every option the user has
configured, limiting the file IO to one open/read/close and performing
option lookup in sublinear time is a useful optimization.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++
 bugreport.h         |  7 +++++++
 builtin/bugreport.c |  4 ++++
 3 files changed, 61 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index ada54fe583..afa4836ab1 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,10 +1,24 @@
 #include "cache.h"
 
 #include "bugreport.h"
+#include "config.h"
+#include "exec-cmd.h"
 #include "help.h"
 #include "run-command.h"
 #include "version.h"
 
+/**
+ * A sorted list of config options which we will add to the bugreport. Managed
+ * by 'gather_whitelist(...)'.
+ */
+struct string_list whitelist = STRING_LIST_INIT_DUP;
+struct strbuf configs_and_values = STRBUF_INIT;
+
+// git version --build-options
+// uname -a
+// curl-config --version
+// ldd --version
+// echo $SHELL
 void get_system_info(struct strbuf *sys_info)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -53,3 +67,39 @@ void get_system_info(struct strbuf *sys_info)
 	argv_array_clear(&cp.args);
 	strbuf_reset(&std_out);
 }
+
+void gather_whitelist(struct strbuf *path)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	strbuf_read_file(&tmp, path->buf, 0);
+	string_list_init(&whitelist, 1);
+	string_list_split(&whitelist, tmp.buf, '\n', -1);
+	string_list_sort(&whitelist);
+}
+
+int git_config_bugreport(const char *var, const char *value, void *cb)
+{
+	if (string_list_has_string(&whitelist, var)) {
+		strbuf_addf(&configs_and_values,
+			    "%s : %s\n",
+			    var, value);
+	}
+
+	return 0;
+}
+
+void get_whitelisted_config(struct strbuf *config_info)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addstr(&path, git_exec_path());
+	strbuf_addstr(&path, "/git-bugreport-config-whitelist");
+
+	gather_whitelist(&path);
+	strbuf_init(&configs_and_values, whitelist.nr);
+
+	git_config(git_config_bugreport, NULL);
+
+	strbuf_reset(config_info);
+	strbuf_addbuf(config_info, &configs_and_values);
+}
diff --git a/bugreport.h b/bugreport.h
index ba216acf3f..7413e7e1be 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -5,3 +5,10 @@
  * The previous contents of sys_info will be discarded.
  */
 void get_system_info(struct strbuf *sys_info);
+
+/**
+ * Adds the values of the config items listed in
+ * 'git-bugreport-config-whitelist' to config_info. The previous contents of
+ * config_info will be discarded.
+ */
+void get_whitelisted_config(struct strbuf *sys_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 7232d31be7..70fe0d2b85 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -56,6 +56,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_system_info(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Whitelisted Config");
+	get_whitelisted_config(&buffer);
+	strbuf_write(&buffer, report);
+
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

