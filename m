Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68211F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 23:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfJBXtk (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 19:49:40 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41186 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfJBXtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 19:49:39 -0400
Received: by mail-vk1-f201.google.com with SMTP id u123so231154vkf.8
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=UprPYrepAY5h9AAZedBDIHbfqDboqFL59p1RPsmZshU=;
        b=YR6GKzltSmPOqdeFbcqACC2cnSbmejnwAKUqHyXDsLtPIkuoJiCT08aBn9NJTrRi1j
         lAnqLo9lA5YVYxoTPR9L7lbrnlpK1Kh+VVvXP7PzKVGew2JcYvnt+CPRdKLOkUi6vSbX
         2kkO1V0IHQVEswRQQRy7XBmyLnHBwP40hlqlkTNKLBVh/Woox8fSgu8azY80XuE59J34
         5c547eXqcrq9OgXpzHguWUq14N4LaqysF2aW9EWf5i949grbyS6ptdvQByBULqBfkHp1
         6F83E77wx1wkpUnGa3vx5zryB9PLAia1D4Rg72G+5mSKAYp82k/ZDmuUb+YMs6Bm0mrC
         WSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=UprPYrepAY5h9AAZedBDIHbfqDboqFL59p1RPsmZshU=;
        b=hORQ0/ZvZGmto+1ptowP2YJgVjUeO6qHi9TtdSaAypG9SWvJj6WUhugEgHQC3B7yEq
         4RG8N43k39T8erS4zqTdqg+wzDZT9syv2Glx+vvRoSE3FqOe7ExMmxzmd3LGnCxp0AZz
         YJgEQ6bXvHVhkgQrdAcZYQ0Q3IrE8KzpUIlUEQoF396uVIh6IbP03ARTUzOG47i6nTZV
         TTNFX8ivEX/PD9+3bvezRUwJbHuCoSVhQvVwda8ZCBs8sqrMiZziP5jAJ2BETfDrRs+0
         NwmtJJNLQnrMXgtTcXHRuZylJGz0hNla05J95tvU7oTOEYSGb8nqJV/pNC9jNN6yLzuC
         2rxw==
X-Gm-Message-State: APjAAAXjeM26qEcm/0oBOZc6yjpUbeQ1XWE92R7GDgIlCT6m/DwJfdn/
        tEdYwDgl/fS2f+m4XY2Ct768pbYOOOXJ8qGp2eNf0eY7QL3Bl8GBDlWjne9aW8XYCpM+wjDViql
        SLKS0r1O8GI3S67sBh1uBv3B77HCbzlUodCYE4TkYfbWtDy8i2h6PVebVTVwXCvI=
X-Google-Smtp-Source: APXvYqzpevBWwgW5bpgfFlq3TIzuI3wqHFSI864vavunOyeTdEUdO8V3cIEG+Jzu2nyfXkP5/C0gVW7ipuDNCQ==
X-Received: by 2002:a05:6102:3032:: with SMTP id v18mr3408002vsa.203.1570060176956;
 Wed, 02 Oct 2019 16:49:36 -0700 (PDT)
Date:   Wed,  2 Oct 2019 16:49:29 -0700
In-Reply-To: <cover.1570059953.git.steadmon@google.com>
Message-Id: <054936f40b8232516763ec90bf44ad50d86d7b65.1570059953.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 2/2] push: add trace2 instrumentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
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
index ae558af944..f313f288de 100644
--- a/transport.c
+++ b/transport.c
@@ -1145,8 +1145,10 @@ int transport_push(struct repository *r,
 
 		refspec_ref_prefixes(rs, &ref_prefixes);
 
+		trace2_region_enter("transport_push", "get_refs_list", the_repository);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
 							       &ref_prefixes);
+		trace2_region_leave("transport_push", "get_refs_list", the_repository);
 
 		argv_array_clear(&ref_prefixes);
 
@@ -1182,6 +1184,7 @@ int transport_push(struct repository *r,
 			struct ref *ref = remote_refs;
 			struct oid_array commits = OID_ARRAY_INIT;
 
+			trace2_region_enter("transport_push", "push_submodules", the_repository);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1194,9 +1197,11 @@ int transport_push(struct repository *r,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
+				trace2_region_leave("transport_push", "push_submodules", the_repository);
 				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
+			trace2_region_leave("transport_push", "push_submodules", the_repository);
 		}
 
 		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
@@ -1207,6 +1212,7 @@ int transport_push(struct repository *r,
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 			struct oid_array commits = OID_ARRAY_INIT;
 
+			trace2_region_enter("transport_push", "check_submodules", the_repository);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1217,15 +1223,19 @@ int transport_push(struct repository *r,
 						     transport->remote->name,
 						     &needs_pushing)) {
 				oid_array_clear(&commits);
+				trace2_region_leave("transport_push", "check_submodules", the_repository);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
 			string_list_clear(&needs_pushing, 0);
 			oid_array_clear(&commits);
+			trace2_region_leave("transport_push", "check_submodules", the_repository);
 		}
 
-		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))
+		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
+			trace2_region_enter("transport_push", "push_refs", the_repository);
 			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
-		else
+			trace2_region_leave("transport_push", "push_refs", the_repository);
+		} else
 			push_ret = 0;
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
-- 
2.23.0.444.g18eeb5a265-goog

