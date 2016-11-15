Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB872021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030202AbcKOXNa (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:13:30 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33405 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbcKOXN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:13:29 -0500
Received: by mail-pg0-f52.google.com with SMTP id 3so71735360pgd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvzVX4s/y8DpmuyyIZSzEuXcTDGfw+rqBENoujmAlUI=;
        b=NgtyS1HQsV79Fl4lvmxlY9+1Z9HYaUgHrm5w5LlPKJuT3iqd0+6vnQunJ3j9tpLoOU
         efty2tq84A+71HhfP8pviApZvDz9T5iQ01CE/OczWKWx7Znfmq1UYvcPErcgS2MMMKPz
         5tNQIPsr8JxV2SQIKv2Ty20JujQzEby8w/ggjxREU3dvSHD+UqAfL/Jdv8Q1P7DCfGoc
         Me0GR4VLkH2yYF7s3A+9kmD7cOG0SHDrdyMTpsPWdDw/3US/XRRKsZl9qNBRJuFbbaCb
         2Lg4hiN7Sxc7gY/v40zBAzyv+q2aLs3UbO+RVxZt6aYnzI2cQwGIuIVAmuTPId5whgUq
         PpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvzVX4s/y8DpmuyyIZSzEuXcTDGfw+rqBENoujmAlUI=;
        b=OHiBZ57XAKvKhz7trSKnynJ/+pEu5etQBAALdHM+uLd57Pc9Tw+e4CaEkQICb/hNwZ
         bIX6BH1lQdHQdPNMpLZkpTpj1mAMfSjhN16QmGtKTN6Htmp/535JBvLDHlWS2xhgM1+p
         SYmGOELb+yCwBc8evQpn0Jy1FLyTN6PZACfWzLTHzbWRnQ2eKtgBHINdUO3AiRXZGN3s
         flyOXhdSYQunJeKWy4pu9nqKKXC8n7QKxEdmpNFp+aMHF+0iEHSw2X9g33n+iUP1sNg0
         gSBbXdBvAy7iT/OgeIKhoxfTGe28dmN5bVJi3RBjCEtRH4Yjeadnb1ivZ6HvCMBAMFbq
         ojJw==
X-Gm-Message-State: ABUngvfO566mWf3NZibzHdiokdbcNn0LGIMPFqJ6y5WV+8Nj0M6wMMEKhdyIh1+Kmqzva12f
X-Received: by 10.99.153.26 with SMTP id d26mr1160792pge.44.1479251219630;
        Tue, 15 Nov 2016 15:06:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id l69sm31452491pfk.34.2016.11.15.15.06.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:06:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/16] update submodules: add is_submodule_populated
Date:   Tue, 15 Nov 2016 15:06:39 -0800
Message-Id: <20161115230651.23953-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is nearly same as Brandon sent out.
(First patch of origin/bw/grep-recurse-submodules,
will drop this patch once Brandons series is stable
enough to build on).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 11 +++++++++++
 submodule.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule.c b/submodule.c
index c9d22e5..97eaf7c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -914,6 +914,17 @@ int fetch_populated_submodules(const struct argv_array *options,
 	return spf.result;
 }
 
+int is_submodule_populated(const char *path)
+{
+	int retval = 0;
+	struct strbuf gitdir = STRBUF_INIT;
+	strbuf_addf(&gitdir, "%s/.git", path);
+	if (resolve_gitdir(gitdir.buf))
+		retval = 1;
+	strbuf_release(&gitdir);
+	return retval;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
diff --git a/submodule.h b/submodule.h
index afc58d0..d44b4f1 100644
--- a/submodule.h
+++ b/submodule.h
@@ -61,6 +61,7 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
+extern int is_submodule_populated(const char *path);
 extern int submodule_uses_gitfile(const char *path);
 extern int ok_to_remove_submodule(const char *path);
 extern int merge_submodule(unsigned char result[20], const char *path,
-- 
2.10.1.469.g00a8914

