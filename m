Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB8DC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDAPLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDAPL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:11:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0723697
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h17so25177034wrt.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLKg0DwoqjoHtaoct0QH6EK00i9tJDM3G325lXtJOdw=;
        b=JpgFUGJZ6V7MCsVVjR2iamiazy/SHBQtmgUW4tz5FKPQ6cjt5YOnY19slNnci6ab/3
         y4pyw4tf9iBLBNUMkVFwcRj4Di6/Pn6jtIVREgOX/BjdUr8fFsQvLd0dPva6tt9LitOA
         MVs7aO7LMFAXYbB3D9px52ko0xfaW7jTYIdeOg5GYGLje/GYoEKcIDSXHptrpg8CJfVo
         euyCj5C0v+DgW01XCZz9cOaKFUXyZI8ANGnpmNuFF22FJCpollVafX3SezmhPNohrq8t
         yxVnWSmYDVxs0+cg9vS0REeZ71j009xz/A+uj79SWXENSH50xFUPVRqm1JVoaQM7d1bb
         njSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLKg0DwoqjoHtaoct0QH6EK00i9tJDM3G325lXtJOdw=;
        b=HeT0SzAsLtnCaIaAM4L4cTYgAwA25dlTOnraVSkgxGQs7g6esV2LLfL9fWwvtNKlL7
         KlJCw66KEEzYPsIvc0UHJYFLvSY4XfXiMYQ8NcwfGxI//ImqutgRm6JOnDZau75QB8QD
         wOYt8FQ9Umr2nophBBiVKtavp6H3FGI8nArSrzZymkFgmqtTa6wfJt1wbV0DODB5cHsD
         jnZZpZQd1BG8SCsRbiRBODu9OP2jzxk7fmFwzATPLxtpBZg1gv0ctAX8/jxSUr7MLW23
         NS3rv+6tyaaN5bZid+DJWTeYCAk46/cUp5DSxfA3xVI6Xa92CKzSzPS/4HYkz1KFqqUX
         ZdwA==
X-Gm-Message-State: AAQBX9e3FqPOZrAtDRdCxkrmo152ft5/FpwjLt6dCOkgdXkFmM6m5axx
        rUmjlkUcGEfXnzOW9A/xyhLjY2Q2qXQ=
X-Google-Smtp-Source: AKy350Y0jAMBQzbmhHAz2LHE5Th9RN+kvJttPxAN4M6oZMOUSRRzYnPj1i6rXiarsWfaKdDTslMMwg==
X-Received: by 2002:adf:f9c3:0:b0:2d5:5610:e7b4 with SMTP id w3-20020adff9c3000000b002d55610e7b4mr22536661wrr.64.1680361853188;
        Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b002e45f6ffe63sm5111296wro.26.2023.04.01.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
Message-Id: <ec79da0235ea41d9a265aa7d441ed05c496015a6.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:31 +0000
Subject: [PATCH 18/24] treewide: remove cache.h inclusion due to pager.h
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 column.c   | 2 +-
 editor.c   | 2 +-
 pager.c    | 2 +-
 pretty.c   | 2 +-
 progress.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/column.c b/column.c
index c89c90328a6..ff2f0abf399 100644
--- a/column.c
+++ b/column.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "column.h"
 #include "string-list.h"
diff --git a/editor.c b/editor.c
index 7c796385493..b34e10606d2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/pager.c b/pager.c
index be78c706644..63055d0873f 100644
--- a/pager.c
+++ b/pager.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
 #include "pager.h"
diff --git a/pretty.c b/pretty.c
index c4671603b56..0bb938021ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
diff --git a/progress.c b/progress.c
index 96a8e36a52f..72d5e0c73c1 100644
--- a/progress.c
+++ b/progress.c
@@ -9,7 +9,7 @@
  */
 
 #define GIT_TEST_PROGRESS_ONLY
-#include "cache.h"
+#include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
 #include "strbuf.h"
-- 
gitgitgadget

