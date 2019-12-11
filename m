Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF6FC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3022527
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsmEZ9yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLKWJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:09:39 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:38051 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKWJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:09:39 -0500
Received: by mail-vs1-f74.google.com with SMTP id q9so39912vsn.5
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BKsWejc7814hdEQJJNbt7BZM0vwYCnd54NRBfqfzSn4=;
        b=EsmEZ9yxDp9QYHxM/nUW4EkRVGcLy82BCRv4uq8cjeww8jSn+EQmtiz5E68r8xf00C
         3NMUbu1izXEPtN1pk2QKe4L7dAjobO7cs7tjjJX5/BXJvY/vZCbibmg5b30X0qUeMr8r
         Ra6646zzTP5k/zf0XENPl9YmqYPV3LszGtUGx1Aj6++A9dX5n06DaT9EgqsNEsuGbriM
         6HxPnzC7fmlCKb1xN/5/gkaVsnBe4q4DSzQJz4YUM3/jJBSuHnGZ22if3oSgxxP5Zo5W
         UVRxWuhaa8TGwtrjSzKdjqYsSnKzM+t8tFXxEPZuEKiEi7Ra1f3729z74vHTD07yJU21
         nsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BKsWejc7814hdEQJJNbt7BZM0vwYCnd54NRBfqfzSn4=;
        b=UBgK/0esVmek2BLCH1ifsD023Vz7XmcePIboBtQs9hn+v3mcrYxQaXqNFVFFw4IDAH
         42QIAXoTuO2e8pZAXYYoz9tVHSrH5nHj/sQh9pKlBq8u9IaHcYGfeo4h11lNhUryb84X
         W9HKmj+CmIpkWFFGwDIeWvWHEjyU9S3godyJPRhLrnKWKLxtGsNjP2QV3T3oyC8vRFvK
         kv81Tf9/JbwN6Er2lMrEXndrLX0Cm6cQyo8caglWqPAxPt6Ztf4KltWcf4cjo9IB623Y
         6w17fe4uE87vJoF7RIuJ3QFa4AH2Ue3ZJY5vJ0qzo2tFRX72YIAnr66a4M2e+oIU8a2a
         HHqQ==
X-Gm-Message-State: APjAAAWWHL6NeQCEdfWfaiP+d2aceH6wSLyVQi2ukg9HJILfxSFZROsY
        mf8U2ke/V5TeKc0VEon2Cgf5fD6P8I/e10iqr0OseiyqUzZeP0bAZeNYKGqP0VXfwzXNzVv6soM
        iSGOWdWmWI96oO6r/+pGsEaLgDI2F6dgDpD9NFwwCrhzN75AM76KnrPFQp7FUS8gZY57sgkbkJw
        ==
X-Google-Smtp-Source: APXvYqyFHh6L6zIBsseihTmkPBORFFRnGKu8pmoek8Cy18P76gf3m7dIDMK8XG7On3fLHZAPNMXgEdp+59wpTyF09FY=
X-Received: by 2002:a1f:5e13:: with SMTP id s19mr5809413vkb.12.1576102178514;
 Wed, 11 Dec 2019 14:09:38 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:09:33 -0800
Message-Id: <20191211220933.48678-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH] config: add string mapping for enum config_scope
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user is interacting with their config files primarily by the 'git
config' command, using the location flags (--global, --system, etc) then
they may be more interested to see the scope of the config file they are
editing, rather than the filepath.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Note: This commit has been cherry-picked out of the "configuration-based
hook management" topic, at
lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com

It turned out that I wanted to use it for git-bugreport as well - to
explain the origin of the configs we are printing in the bugreport,
without directly exposing the user's home directory path.

This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
which I believe hasn't been mailed yet; but that change is targeted
towards the builtin config command, rather than the config library.
Since I wanted to use the library, I'm sending on my own now. Maybe
this commit will be useful to that change's author.

 - Emily

 config.c | 17 +++++++++++++++++
 config.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/config.c b/config.c
index e7052b3977..a20110e016 100644
--- a/config.c
+++ b/config.c
@@ -3312,6 +3312,23 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
 
+const char *config_scope_to_string(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return _("system");
+	case CONFIG_SCOPE_GLOBAL:
+		return _("global");
+	case CONFIG_SCOPE_REPO:
+		return _("repo");
+	case CONFIG_SCOPE_CMDLINE:
+		return _("cmdline");
+	case CONFIG_SCOPE_UNKNOWN:
+	default:
+		return _("unknown");
+	}
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 91fd4c5e96..c8bf296dcc 100644
--- a/config.h
+++ b/config.h
@@ -303,6 +303,7 @@ enum config_scope {
 };
 
 enum config_scope current_config_scope(void);
+const char *config_scope_to_string(enum config_scope);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
 
-- 
2.24.0.525.g8f36a354ae-goog

