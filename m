Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE8FC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386586AbiEBRNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386568AbiEBRNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5860EB
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s68-20020a637747000000b003aaff19b95bso7271086pgc.1
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=akw57T62qzLu5XOJTDKT0BdT9BIQ15RZPIpdPddN9QM=;
        b=elJI615I4aBweTgPpWNQhercIxGX6Nbx2SjQmVWb224EntEio3tc8CjOHCiYY/t2P3
         wTKrlI0Nmz0qgjzrk/HoHQ9BEed0TJT8j1GL4CYFgts2QfBlTaNsmPWq673HkbMrR/Jf
         zDm2Fy69MtWYLxPfkBAYuQEVv4xj7lb1ERCmEmzir0dMjCwNJrb2yMzgAOiVc57pNtla
         vord8HbP/01REK057sdxh2oQXZey/DuRa87ZYipgBqEqyPaFp7LGaDidAyK8kahTbyZr
         pDsTcLUqtVcQuQ1f5CfQijhv43HvevrYeuLfXL0EokRm9B9Ibkop07wyp5KqNQPcCBSa
         dqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=akw57T62qzLu5XOJTDKT0BdT9BIQ15RZPIpdPddN9QM=;
        b=bK5k0YL5KdSS177oXiXgqF2cXukjfE4+vGA+ihTwgL3B7UW7aAk4LKeZGWR8X4B2SO
         /gELl9kr1ROxuOP+c/e2MUtjQ+kp3zDw8PCER2nQOE6t8/ahA0jFSPWnbg5iR9oEriVy
         IX2kkJ3sJxKye4KDAEKxaN+n4/La10h0TNbpx+FKbK4EO9/hueLIYjukFvicI9KmZU1F
         e8im9nQT/5wqsNZ8/EhXoiiuBPNfNU5hqaiu7aRgjPIdxwY3WwYPbwxTfKtuNPLE4a/e
         nIkWt9NpSWTbEs3MGk8cnyBosTqm2Mp4+1F1XxfJ/+LKk4+ITb+bFFaE3p3hhfhq4UaZ
         n6jQ==
X-Gm-Message-State: AOAM533Z+eE8iKWB3zRIZLcCJPdDSflrxXzm0VfLjx3vIkqeDK0Mritc
        GQaIU0wVEw2TW6/yeOSmceusR3WmiceGWAGGyaSVYwupCqW9v+otaoX514VlkCu6/C0VXnBxIh3
        39ZmuRkC+NtpdrOBMsZ7XqpR4RbmpWqZzPPz5DSIxsqDQ033nTPtf2eYu7lz+HdifXw==
X-Google-Smtp-Source: ABdhPJy6MUXqJbLzphsUMHhLFd+3zRY0yyIydxnLPChv+7vb/ZP9j798yoQzdxFR+Qu41mpfo4RcdbDLzvNIvPc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:d2d2:b0:15e:b28d:8acc with SMTP
 id n18-20020a170902d2d200b0015eb28d8accmr1576958plc.4.1651511406748; Mon, 02
 May 2022 10:10:06 -0700 (PDT)
Date:   Mon,  2 May 2022 17:09:02 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-7-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 6/8] transport: add object-info fallback to fetch
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a v2 server does not support object-info or if the client requests
information that isn't supported by object-info, fetch the objects as if
it were a standard v2 fetch (however without changing any refs).

---
 fetch-pack.c | 14 +++++++++++++-
 fetch-pack.h |  2 ++
 transport.c  | 18 +++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 506ca28e05..938d082b80 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1639,6 +1639,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
@@ -1648,7 +1651,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-			if (!args->refetch && everything_local(args, &ref))
+			if (!args->refetch && !args->object_info && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
@@ -2035,6 +2038,15 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		args->connectivity_checked = 1;
 	}
 
+	if (args->object_info) {
+		struct ref *ref_cpy_reader = ref_cpy;
+		int i = 0;
+		while (ref_cpy_reader) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args->object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
+			ref_cpy_reader = ref_cpy_reader->next;
+			i++;
+		}
+	}
 	update_shallow(args, sought, nr_sought, &si);
 cleanup:
 	clear_shallow_info(&si);
diff --git a/fetch-pack.h b/fetch-pack.h
index c27018d48c..552fd7bde0 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -17,6 +17,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info **object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -43,6 +44,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
diff --git a/transport.c b/transport.c
index 08c505e1d0..b85e52d9a8 100644
--- a/transport.c
+++ b/transport.c
@@ -436,10 +436,12 @@ static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	int ret = 0;
+	size_t i;
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
+	struct ref *wanted_refs = xcalloc(1, sizeof (struct ref));
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -468,10 +470,19 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.object_info = transport->smart_options->object_info;
 
 	if (transport->smart_options && transport->smart_options->object_info) {
+		struct ref *ref = wanted_refs;
+
 		if (!fetch_object_info(transport, data->options.object_info_data))
 			goto cleanup;
-		ret = -1;
-		goto cleanup;
+		args.object_info_data = data->options.object_info_data;
+		for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
+			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
+			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
+			temp_ref->exact_oid = 1;
+			ref->next = temp_ref;
+			ref = ref->next;
+		}
+		transport->remote_refs = wanted_refs->next;
 	} else if (!data->got_remote_heads) {
 		int i;
 		int must_list_refs = 0;
@@ -489,7 +500,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	else if (data->version <= protocol_v1)
 		die_if_server_options(transport);
 
-	if (data->options.acked_commits) {
+	if (data->options.acked_commits && !transport->smart_options->object_info) {
 		if (data->version < protocol_v2) {
 			warning(_("--negotiate-only requires protocol v2"));
 			ret = -1;
@@ -532,6 +543,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 	free_refs(refs);
+	free_refs(wanted_refs);
 	return ret;
 }
 
-- 
2.36.0.rc2.10170.gb555eefa6f

