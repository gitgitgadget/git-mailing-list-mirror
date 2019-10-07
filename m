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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A3B1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfJGWf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 18:35:26 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42908 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfJGWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 18:35:26 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so11132405pgv.9
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=MqXwEARbDXCNksxYAQsjOPkaHRgBlJTJ/Q9kS5NOciY=;
        b=ZpKFe4fRhueWm3ZbEX4BFLY/elpSsClLocUZnpe0v4oV1U1uYmYBzM0FrgXgRr9Dmq
         l3ACjAOOuL98ZktMmhh5N3rB9uWVCcgDA6t5YjEuFiNpFNTSrnWtPgEw+uu5W9tygtA6
         UF1Ao6N8OURc19zSe7MOBUu4I321pRqm8QceS9SSmvBqw/fsaVJ0h1KNUGYBFXrhAsCJ
         2Mn+EeJHfgA2x4UejEYP56pKLGKK6N6ZHrDEf0Xgc1epOsnTM0l29KnshohOpbS7u66R
         Lk0WSlo24mKcD9lg6c0JPoB0+DxlU48m6OaKzdPSEVy12oGnvt+ACmTyIFI13LRloxnQ
         W+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=MqXwEARbDXCNksxYAQsjOPkaHRgBlJTJ/Q9kS5NOciY=;
        b=MnSgsm5s2TEGxOJJ0cmo+FCfRSqo09Ifv9QXdLj1PkffXPMRKm/rxTZ3elA0h/t4Du
         EfnQli2Dxk69WJdu5h1FPakE3FRdzLCYNLqVhDSExmp1snwj5yh7jsPI9YT9sZ/wJFNE
         lqOVmZJFW8FPntOqlYsDyZgiEUMxsioPKMk+N9jQyDSLnyi70FLkUlMD2WR9FN1oAAJw
         BRhEkbaciWMwWSXwioShuFRnOO3AWrDgn0iQ9KlCBOO0mdY+tLW5aVwZKPdCtXDvCvWr
         Ss8IfrSMNsTQJuz4/JTlWylxsibDKHA7PVQwBHayu+kbQcAi+WHjAgwFZ3ZcZY2sGzlZ
         EFcA==
X-Gm-Message-State: APjAAAUHKu726UHvaEy2kK5EeFjLHTKDCV08r9K//9uxlstiIMwNlzdl
        4R4aFIx89b5d3PlRoZK6RhR3AoYKVeJim97yNngFdDd/8hlnR7F4wqCMcS8Oo4TuZ30saHNfnEK
        uxzotq0m6Ms5ntuxBEhy1RF2el8bSOB64j/Os9uccf1BC/7T19jti3GQCJCn9Peo=
X-Google-Smtp-Source: APXvYqwAlPPJ9nPkogpOxMMswtQifL6i9Nzvk3yBmIDYUhXzsSP2ANxtcew7akt5gBZ9eKrwmbbAVLWFmDxURw==
X-Received: by 2002:a63:347:: with SMTP id 68mr13586915pgd.244.1570487723889;
 Mon, 07 Oct 2019 15:35:23 -0700 (PDT)
Date:   Mon,  7 Oct 2019 15:35:16 -0700
In-Reply-To: <cover.1570487473.git.steadmon@google.com>
Message-Id: <fe6108b6f98247582f8819c89a76249d477c2df3.1570487473.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com> <cover.1570487473.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 2/2] push: add trace2 instrumentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions in transport.c and builtin/push.c to better track
time spent in various phases of pushing:

* Listing refs
* Checking submodules
* Pushing submodules
* Pushing refs

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/push.c |  2 ++
 transport.c    | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3742daf7b0..cc1292a566 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -357,8 +357,10 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
+	trace2_region_enter("push", "transport_push", the_repository);
 	err = transport_push(the_repository, transport,
 			     rs, flags, &reject_reasons);
+	trace2_region_leave("push", "transport_push", the_repository);
 	if (err != 0) {
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), transport->url);
diff --git a/transport.c b/transport.c
index ae558af944..83379a037d 100644
--- a/transport.c
+++ b/transport.c
@@ -1145,8 +1145,10 @@ int transport_push(struct repository *r,
 
 		refspec_ref_prefixes(rs, &ref_prefixes);
 
+		trace2_region_enter("transport_push", "get_refs_list", r);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
 							       &ref_prefixes);
+		trace2_region_leave("transport_push", "get_refs_list", r);
 
 		argv_array_clear(&ref_prefixes);
 
@@ -1182,6 +1184,7 @@ int transport_push(struct repository *r,
 			struct ref *ref = remote_refs;
 			struct oid_array commits = OID_ARRAY_INIT;
 
+			trace2_region_enter("transport_push", "push_submodules", r);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1194,9 +1197,11 @@ int transport_push(struct repository *r,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
+				trace2_region_leave("transport_push", "push_submodules", r);
 				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
+			trace2_region_leave("transport_push", "push_submodules", r);
 		}
 
 		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
@@ -1207,6 +1212,7 @@ int transport_push(struct repository *r,
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 			struct oid_array commits = OID_ARRAY_INIT;
 
+			trace2_region_enter("transport_push", "check_submodules", r);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1217,15 +1223,19 @@ int transport_push(struct repository *r,
 						     transport->remote->name,
 						     &needs_pushing)) {
 				oid_array_clear(&commits);
+				trace2_region_leave("transport_push", "check_submodules", r);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
 			string_list_clear(&needs_pushing, 0);
 			oid_array_clear(&commits);
+			trace2_region_leave("transport_push", "check_submodules", r);
 		}
 
-		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))
+		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
+			trace2_region_enter("transport_push", "push_refs", r);
 			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
-		else
+			trace2_region_leave("transport_push", "push_refs", r);
+		} else
 			push_ret = 0;
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
-- 
2.23.0.581.g78d2f28ef7-goog

