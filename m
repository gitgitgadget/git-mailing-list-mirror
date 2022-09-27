Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF045C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiI0WMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI0WMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:12:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C810963B
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h62-20020a636c41000000b0043cc1874c79so3194009pgc.5
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ORXlNCBbtZ7cl2JoqVvtSvS+OM74e4IRJJLbj/ovKnQ=;
        b=NTc1FplZoX9W3PAwUnxTLjaRIMzFCYaLcBClNJi2uOas7ToEp7qSjox1Pyn3HANMyI
         Yeym86EaNQzuFCJrlChZ/+591/Wk9Kxy/0aexoDyDkC/bBkWOzgezZ087b7Aocz7Uoe5
         a6MOrgnqOw3DgF3V1vBK9/fBcqHDVvnN9CnXjgCJ1KusGBOFtvJqhOJdfQhPZejijVDS
         gfXtrn0FcMY3YHQ2tPeDuTrZQBGBnhRbq5qqf8jRwHxcmEfbbE4fltVmrJLMerr2UpAq
         OYYHdkmfAnybr4tpjFR25RlvP3+7+coDlLPeOqQcgAqiVuKz9+B14k3z2QxFCNosmBhB
         Wt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ORXlNCBbtZ7cl2JoqVvtSvS+OM74e4IRJJLbj/ovKnQ=;
        b=INB0JEicFvXAPIyasdRWuaKtFBO0F+5J31K2chHa62KK0D5HXNVpv0bPw+0eHrwlIF
         1ZrABb3B0XvVsdKf5T31njDY6tiZx3w+8dIW9+qD92+EvSfblmKALKiECM3sieFQn/n0
         v4vX0d7jYcrFoN+TTyN7uX0Aj6DTKp+GCA0A62DTSh/sJ0jbyWQGyvK/Fjxq/82cA4yV
         Wm2SLKiFuBAvyWhs7vzQ0FE9meAIYKYYjKuURlcFxuvUzfsiXfdlNmeJFp8FE7ILWjpL
         3hkcY3ACYP9VSCtT5VOTjLD5udI1ffg5GcBFYIm3jPIJr2g0x5J3+rr5FGfy1Cql9lga
         BeDg==
X-Gm-Message-State: ACrzQf2/CgNhWui8QeTD9ffKvilTd4dSEjmIuqz0jEp6QNRdoVgOOBgE
        EFvLo8d12D7VYJk7puMKrUYqvXmg1jTY6hgVOOL9ciOajJr8CG2IGWWrRvN01dT1vehPONfDFUQ
        YMGWsdtCg6xVInJ6U6DJec4rqUNCFhKRA5euC0jdoMfijPszCFhb7Fov386LaLdluij7aoWE/Il
        u8
X-Google-Smtp-Source: AMsMyM5BkeiENwgQ9HIk1RfvmFLs2StZA8axqtHK7jkK2tcWZuwPl82ZkotfZCRzp1/SLMjHDE9v3QciWJY+95MkSHP5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:95a2:0:b0:541:123f:bcac with
 SMTP id a2-20020aa795a2000000b00541123fbcacmr31747517pfk.52.1664316760248;
 Tue, 27 Sep 2022 15:12:40 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:12:30 -0700
In-Reply-To: <cover.1664316642.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1664316642.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <7f6412eb8ce0c47a7645b89fab171a212353f8b2.1664316642.git.jonathantanmy@google.com>
Subject: [PATCH 2/2] promisor-remote: die upon failing fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, an attempt to read a missing object results in an
attempt to fetch that single object. In order to avoid multiple
sequential fetches, which would occur when multiple objects are missing
(which is the typical case), some commands have been taught to prefetch
in a batch: such a command would, in a partial clone, notice that
several objects that it will eventually need are missing, and call
promisor_remote_get_direct() with all such objects at once.

When this batch prefetch fails, these commands fall back to the
sequential fetches. But at $DAYJOB we have noticed that this results in
a bad user experience: a command would take unexpectedly long to finish
if the batch prefetch would fail for some intermittent reason, but all
subsequent fetches would work. It would be a better user experience for
such a command would just fail.

Therefore, make it a fatal error if the prefetch fails and at least one
object being fetched is known to be a promisor object. (The latter
criterion is to make sure that we are not misleading the user that such
an object would be present from the promisor remote. For example, a
missing object may be a result of repository corruption and not because
it is expectedly missing due to the repository being a partial clone.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c     |  4 ----
 promisor-remote.c | 11 ++++++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5b270f046d..5e30960234 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1599,10 +1599,6 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (fetch_if_missing && repo_has_promisor_remote(r) &&
 		    !already_retried &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			/*
-			 * TODO Investigate checking promisor_remote_get_direct()
-			 * TODO return value and stopping on error here.
-			 */
 			promisor_remote_get_direct(r, real, 1);
 			already_retried = 1;
 			continue;
diff --git a/promisor-remote.c b/promisor-remote.c
index 8b4d650b4c..faa7612941 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "transport.h"
 #include "strvec.h"
+#include "packfile.h"
 
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
@@ -238,6 +239,7 @@ void promisor_remote_get_direct(struct repository *repo,
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
+	int i;
 
 	if (oid_nr == 0)
 		return;
@@ -255,9 +257,16 @@ void promisor_remote_get_direct(struct repository *repo,
 				continue;
 			}
 		}
-		break;
+		goto all_fetched;
+	}
+
+	for (i = 0; i < remaining_nr; i++) {
+		if (is_promisor_object(&remaining_oids[i]))
+			die(_("could not fetch %s from promisor remote"),
+			    oid_to_hex(&remaining_oids[i]));
 	}
 
+all_fetched:
 	if (to_free)
 		free(remaining_oids);
 }
-- 
2.37.3.998.g577e59143f-goog

