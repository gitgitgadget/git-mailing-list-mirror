Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4540BC433EB
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF662072A
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHDLiKlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRECJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRECB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:02:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439EC061343
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:02:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e12so20765658ybc.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RDeUk6T5Cdlun3NuSjpMkJH6p/HD+IaMGum9baql2Gk=;
        b=wHDLiKlwis932n/K2rXQuRg3YoZSBgGtclTZlAKyAcesrWvulce4ZRU7bebwvGyDoy
         XXteqizC4FS9Hi5EDr606kArSjnEAKsseAuR6LxjkJWbRp/z4mx5a+IjTpLhV1o7s9a/
         rgPeLKj2GXBR6Hf/G31goZTOakQVr//XwlM+rhgpMPkkrVpWGh2IuLJRbrfGQqCErXY4
         d2E0QzdV9Flett4v0VXofDyguSSMvGnxi8vL9Bab9zEOM5T7g2KE8QBL3S9xcZZrR5C+
         J96s9v3YaUpbdaxkxRjBzSWVY9Y8FfcGhDGwklRGT4oOMezWOTPTG7eh/3TCQGCU53Y7
         Opxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDeUk6T5Cdlun3NuSjpMkJH6p/HD+IaMGum9baql2Gk=;
        b=pzpbv9fQXdy3S/JQiUrM4X69jwbWjmFu+Mi/yXbykns0JWBOGrt8SdC8nOMy/+8aFx
         elN2IEFQj5b7jrZp78CPRv92mVZfT11Q8vITPhJtNyC+1GduLw9rfJI2mKPKIOja9aaL
         A3b8eQRtLx0rjZUvmNy5bPa4yQyZVc+mIYFBMP80GGNwPrFZUW3s3wmg+OMVvihDEHeC
         3soVDSTAhhkPzLEjQqwFJSSk+DjzL2Er2nHd0zIXhGwfsW5w+kWdKs2KxCCED01a8MDR
         Vm5wD+/yq6WfvhApEJnZYA6I1hRiezkMbCpr/2SnV60gOnnlYmXuqWhiL/EpUpHV4Knf
         +mWQ==
X-Gm-Message-State: AOAM530WApLsYsuIKGpghRoWsoym0Gqc0c7fybQQWb+hFYpl2JE+GZrq
        DpTviAD6wkH/rmctCpmiUZGrIE4DjslgHrQTX/L4931MFEZyuQ6OZ1JgaZb3TQUMV0TnROFk5cu
        P9SULMHApnFP66j8stZ+u9vcASq3KmYOTTmLSbv/Ugiec9hG5fxr6d76Rh/mUkdmGVUz68OBVn0
        G8
X-Google-Smtp-Source: ABdhPJzfTtRIkkyhGL5MmYSajXJYEWctwevteVJTbg2tA0OqPTzIgvA9V709ZKIl7T7nj98cw5cyuNtCYkZN90Iexckb
X-Received: by 2002:a25:187:: with SMTP id 129mr1513722ybb.448.1597723319942;
 Mon, 17 Aug 2020 21:01:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:36 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <4e72ca62583a2938509511818ce6bef8af24c271.1597722942.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 6/7] promisor-remote: lazy-fetch objects in subprocess
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to lazy-fetch missing objects in a subprocess instead of doing
it in-process. This allows any fatal errors that occur during the fetch
to be isolated and converted into an error return value, instead of
causing the current command being run to terminate.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/partial-clone.txt | 13 ++-----
 promisor-remote.c                         | 46 +++++++++++------------
 t/t0410-partial-clone.sh                  |  2 +-
 t/t4067-diff-partial-clone.sh             |  8 ++--
 t/t5601-clone.sh                          |  2 +-
 5 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index b9e17e7a28..0780d30cac 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -171,20 +171,13 @@ additional flag.
 Fetching Missing Objects
 ------------------------
 
-- Fetching of objects is done using the existing transport mechanism using
-  transport_fetch_refs(), setting a new transport option
-  TRANS_OPT_NO_DEPENDENTS to indicate that only the objects themselves are
-  desired, not any object that they refer to.
-+
-Because some transports invoke fetch_pack() in the same process, fetch_pack()
-has been updated to not use any object flags when the corresponding argument
-(no_dependents) is set.
+- Fetching of objects is done by invoking a "git fetch" subprocess.
 
 - The local repository sends a request with the hashes of all requested
-  objects as "want" lines, and does not perform any packfile negotiation.
+  objects, and does not perform any packfile negotiation.
   It then receives a packfile.
 
-- Because we are reusing the existing fetch-pack mechanism, fetching
+- Because we are reusing the existing fetch mechanism, fetching
   currently fetches all objects referred to by the requested objects, even
   though they are not necessary.
 
diff --git a/promisor-remote.c b/promisor-remote.c
index baaea12fd6..6e647610e9 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -3,6 +3,7 @@
 #include "promisor-remote.h"
 #include "config.h"
 #include "transport.h"
+#include "argv-array.h"
 
 static char *repository_format_partial_clone;
 static const char *core_partial_clone_filter_default;
@@ -12,39 +13,34 @@ void set_repository_format_partial_clone(char *partial_clone)
 	repository_format_partial_clone = xstrdup_or_null(partial_clone);
 }
 
-static int fetch_refs(const char *remote_name, struct ref *ref)
-{
-	struct remote *remote;
-	struct transport *transport;
-	int res;
-
-	remote = remote_get(remote_name);
-	if (!remote->url[0])
-		die(_("Remote with no URL"));
-	transport = transport_get(remote, remote->url[0]);
-
-	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	res = transport_fetch_refs(transport, ref);
-
-	return res;
-}
-
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
 {
-	struct ref *ref = NULL;
+	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
+	FILE *child_in;
+
+	child.git_cmd = 1;
+	child.in = -1;
+	argv_array_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=null",
+			 "fetch", remote_name, "--no-tags",
+			 "--no-write-fetch-head", "--recurse-submodules=no",
+			 "--filter=blob:none", "--stdin", NULL);
+	if (start_command(&child))
+		die(_("promisor-remote: unable to fork off fetch subprocess"));
+	child_in = xfdopen(child.in, "w");
 
 	for (i = 0; i < oid_nr; i++) {
-		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
-		oidcpy(&new_ref->old_oid, &oids[i]);
-		new_ref->exact_oid = 1;
-		new_ref->next = ref;
-		ref = new_ref;
+		if (fputs(oid_to_hex(&oids[i]), child_in) < 0)
+			die_errno(_("promisor-remote: could not write to fetch subprocess"));
+		if (fputc('\n', child_in) < 0)
+			die_errno(_("promisor-remote: could not write to fetch subprocess"));
 	}
-	return fetch_refs(remote_name, ref);
+
+	if (fclose(child_in) < 0)
+		die_errno(_("promisor-remote: could not close stdin to fetch subprocess"));
+	return finish_command(&child) ? -1 : 0;
 }
 
 static struct promisor_remote *promisors;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..3e454f934e 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -203,7 +203,7 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	rm -rf repo/.git/objects/* &&
 	rm -f trace &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo cat-file -p "$HASH" &&
-	grep "git< fetch=.*ref-in-want" trace
+	grep "fetch< fetch=.*ref-in-want" trace
 '
 
 test_expect_success 'fetching of missing objects from another promisor remote' '
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index ef8e0e9cb0..804f2a82e8 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -20,7 +20,7 @@ test_expect_success 'git show batches blobs' '
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -44,7 +44,7 @@ test_expect_success 'diff batches blobs' '
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -127,7 +127,7 @@ test_expect_success 'diff with rename detection batches blobs' '
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD >out &&
 	grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -175,7 +175,7 @@ test_expect_success 'diff --break-rewrites fetches only if necessary, and batche
 	# by checking that there is only 1 "done" line sent. ("done" marks the
 	# end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --break-rewrites --raw -M HEAD^ HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 84ea2a3eb7..f82b0dbb5a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -702,7 +702,7 @@ test_expect_success 'batch missing blob request during checkout' '
 	# Ensure that there is only one negotiation by checking that there is
 	# only "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client checkout HEAD^ &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
-- 
2.28.0.220.ged08abb693-goog

