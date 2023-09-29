Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC39E71D58
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjI2VVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjI2VVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 17:21:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A41AB
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1f12cf1ddso22808497b3.0
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696022461; x=1696627261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rwYe4h6Z9Jg1gIRfLKp95ZvmJDBSMmUEcRxwVtc2KY=;
        b=Ojk7u9a3CjOuoa3HaRwB/28J27V0bYvjLKHh7AFHPvlOx6EaMLWEokU75LJEmDKXDq
         gDa8cIfz65vx0MdMjmcnLWgXVN86cr9lq3sHb33lcsCJwCBiP2OALB2F/V2ernNJsk4h
         PljOE36kqHobwHGoAe/91izrtbr0XW5a9yGsY00SAvcULtS6meF5pvROJzhiWttgheAf
         yQMBqeYbmgs4XydVy7Ew+XGdWYMAd11cXulCGdkF3xECXSITWbEmEcKlzV6n7hP6BYFj
         NFJ+VBP6zO/auy35+yd0KnLbTaT16w9xbmHnhXhqq+YoaEYYFmoy59KFzrOQRYeAri5X
         kYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022461; x=1696627261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rwYe4h6Z9Jg1gIRfLKp95ZvmJDBSMmUEcRxwVtc2KY=;
        b=Nl/bx6kQGL4yrUiC6v+2hWy5YRRa9m7xlqTHxRSIJxjZw/62lR4/6GobSPLCmSyDq3
         J4VcMD19Zpmsym7FJ7SlsoaM6fKAkj4uasDOpz7IUKCnbMeJXOK/FtzxWp/3poIiiM7z
         0/jr/88LH6CYfsTTtjaoNdjMg5bXA/3z9LsAO8VWbEw/9LGRB9sA2AnPx4l1aESdslXm
         mQ8BR/k0YISbGUbMxd4GlSteKTzaaBNMp85bkCrpQRkk2wj6h9Og3QPAMUw/D9mLz+sh
         D//VjH/ZZAeDJyr7l0I8LTx2uDC4w7W6qgktetTclv0JYofT7bmQTcBln4vzQDXt0m1j
         cZDA==
X-Gm-Message-State: AOJu0YxOOpNnNj6LjWpTQJ+SNJ4LMe6BhCLhI0fIuTbawmiAwMH6g6C3
        HeQxZfA5DKw36IcBt/oGD/EVz0TQS2BLFOMPfH1wfPsZ+WobNUAvS1QBjhKxEQmVeDLsVexiBXq
        CaVG0AtwSbL39MttM5IqEV5Etj3S2IpoErYF9vKt5D0RQr5c56zO/1T5NI2bK5tqstuA2Nqq6yB
        no
X-Google-Smtp-Source: AGHT+IFghsh+N2dPVLjrHT65YwSaScv++Fp0CI9NtgjpMf/3nFFuE+rET8ADOKxaFzmp9ZyU7FLTUmOkYydTv3E7W8cq
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:b708:8deb:d032:67cf])
 (user=jonathantanmy job=sendgmr) by 2002:a81:9982:0:b0:59f:4c14:ac5e with
 SMTP id q124-20020a819982000000b0059f4c14ac5emr120874ywg.2.1696022461415;
 Fri, 29 Sep 2023 14:21:01 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:20:49 -0700
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com> <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <c9e7cd78576527571fd70b953e340b5bdd196221.1696021277.git.jonathantanmy@google.com>
Subject: [PATCH v4 2/4] wrapper: reduce scope of remove_or_warn()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Calvin Wan <calvinwan@google.com>

remove_or_warn() is only used by entry.c and apply.c, but it is
currently declared and defined in wrapper.{h,c}, so it has a scope much
greater than it needs. This needlessly large scope also causes wrapper.c
to need to include object.h, when this file is largely unconcerned with
Git objects.

Move remove_or_warn() to entry.{h,c}. The file apply.c still has access
to it, since it already includes entry.h for another reason.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 entry.c   | 5 +++++
 entry.h   | 6 ++++++
 wrapper.c | 6 ------
 wrapper.h | 5 -----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 43767f9043..076e97eb89 100644
--- a/entry.c
+++ b/entry.c
@@ -581,3 +581,8 @@ void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
+
+int remove_or_warn(unsigned int mode, const char *file)
+{
+	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
+}
diff --git a/entry.h b/entry.h
index 7329f918a9..ca3ed35bc0 100644
--- a/entry.h
+++ b/entry.h
@@ -62,4 +62,10 @@ int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 			   struct stat *st);
 
+/*
+ * Calls the correct function out of {unlink,rmdir}_or_warn based on
+ * the supplied file mode.
+ */
+int remove_or_warn(unsigned int mode, const char *path);
+
 #endif /* ENTRY_H */
diff --git a/wrapper.c b/wrapper.c
index 48065c4f53..453a20ed99 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
-#include "object.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -632,11 +631,6 @@ int rmdir_or_warn(const char *file)
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }
 
-int remove_or_warn(unsigned int mode, const char *file)
-{
-	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
-}
-
 static int access_error_is_ok(int err, unsigned flag)
 {
 	return (is_missing_file_error(err) ||
diff --git a/wrapper.h b/wrapper.h
index 79c7321bb3..1b2b047ea0 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -106,11 +106,6 @@ int unlink_or_msg(const char *file, struct strbuf *err);
  * not exist.
  */
 int rmdir_or_warn(const char *path);
-/*
- * Calls the correct function out of {unlink,rmdir}_or_warn based on
- * the supplied file mode.
- */
-int remove_or_warn(unsigned int mode, const char *path);
 
 /*
  * Call access(2), but warn for any error except "missing file"
-- 
2.42.0.582.g8ccd20d70d-goog

