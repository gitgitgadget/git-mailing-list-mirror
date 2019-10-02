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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8C81F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 23:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfJBXth (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 19:49:37 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43352 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfJBXtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 19:49:36 -0400
Received: by mail-pf1-f201.google.com with SMTP id i187so715617pfc.10
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 16:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=hfLMzXPeDYnKSQdJnB0ygtFFCgsvCyT0ONFB8t5nQws=;
        b=BvhBX/K3sQAK2Rk+KjjRp3kefPtwmWTysKdoI04+/qT1i2VR1UsgVxkChMFLZpzDnf
         Hyb8TMse9EcZc7kEaWqi1k5T/Y6GGxyRVmXnvY7j02D0DgdEuNo4GaVEin4npTyBgKMZ
         Bgy6KAWTd8UIcquKPnBPAlNKq7giYyT2AN11Q4CnZlDz9OOsVaBYgq/tmY6+2vvjWwlV
         HQ8CLHtu5KynooIb45qps96/NkR5O2v3f3r6hZfJthrjvbF+eVgp3vii3v0YW14tK+6P
         yIO3V6CwpT7zdsvNtKX3OAF3KWG70Y1EBAXAgU8BWLFtLeGntUe2XlM1qh5IaiGeE0b6
         gKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=hfLMzXPeDYnKSQdJnB0ygtFFCgsvCyT0ONFB8t5nQws=;
        b=H4MBsTrwpWDLlBfodBoIPaUlBlRI3uZb7WQ6oDYDixAwrwpB7zJjAmLBB+h8SR0Wf0
         ZDFDDOTn1co6TdhCLPWZSPlxfRPyd68AOGpDctCeSxEnnuZV7fE4/8L089RPWZcD+sJ7
         a0LZVCbVA0wJuNNydKq64H/OyKLCjlmgaeahBUxtiIkiYpkBMR2xut3zHeCrtmstTOE4
         2HS7VUtm8sf4G5nS/8l4worlWLjfphI0mdfteh2kuRvCoa26WAR6iGNXVx63w51Od0Yp
         5w5ICZDMoTfT+9+LH8glihqaG0/2Vmc7So3ReewNuGE8Yn7SY3iEhMzAwwS6KvtxR6tM
         yUGw==
X-Gm-Message-State: APjAAAWxQeuEaRlc3w9KF0NtAFWLrCOgtJmJjkoK6oVEe3pWtQ+cr71j
        KL/G0cg0aHiGehCShdBxd8IMzFbf5mHNKflj1avNyzpJWjskspySucq7UYk0RIAwqJugks6/U8H
        r2t2jNCzxapmc6RULDY0FVqu1cfQCZFokLNw2Y+OCtn23FJrr/yFZwBFXL6BdHb8=
X-Google-Smtp-Source: APXvYqztueUhda8iIAvzWgYWCf1aZlBKbG/zF4If1BgIpxId+D+z/mz5/yFKmnDhWukhx/MWbIdtv+wyDhD+xw==
X-Received: by 2002:a63:eb4c:: with SMTP id b12mr5959406pgk.1.1570060174273;
 Wed, 02 Oct 2019 16:49:34 -0700 (PDT)
Date:   Wed,  2 Oct 2019 16:49:28 -0700
In-Reply-To: <cover.1570059953.git.steadmon@google.com>
Message-Id: <348b99edf3e736f11ea13793610f2e0433875fab.1570059953.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 1/2] fetch: add trace2 instrumentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c and builtins/fetch.c to better track
time spent in the various phases of a fetch:

* listing refs
* negotiation for protocol versions v0-v2
* fetching refs
* consuming refs

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/fetch.c | 22 +++++++++++++++-------
 fetch-pack.c    | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 67c0eb88c6..ee3dc085bb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1071,8 +1071,11 @@ static int check_exist_and_connected(struct ref *ref_map)
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = check_exist_and_connected(ref_map);
-	if (ret)
+	if (ret) {
+		trace2_region_enter("fetch", "fetch_refs", the_repository);
 		ret = transport_fetch_refs(transport, ref_map);
+		trace2_region_leave("fetch", "fetch_refs", the_repository);
+	}
 	if (!ret)
 		/*
 		 * Keep the new pack's ".keep" file around to allow the caller
@@ -1088,11 +1091,14 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
 {
 	int connectivity_checked = transport->smart_options
 		? transport->smart_options->connectivity_checked : 0;
-	int ret = store_updated_refs(transport->url,
-				     transport->remote->name,
-				     connectivity_checked,
-				     ref_map);
+	int ret;
+	trace2_region_enter("fetch", "consume_refs", the_repository);
+	ret = store_updated_refs(transport->url,
+				 transport->remote->name,
+				 connectivity_checked,
+				 ref_map);
 	transport_unlock_pack(transport);
+	trace2_region_leave("fetch", "consume_refs", the_repository);
 	return ret;
 }
 
@@ -1337,9 +1343,11 @@ static int do_fetch(struct transport *transport,
 			argv_array_push(&ref_prefixes, "refs/tags/");
 	}
 
-	if (must_list_refs)
+	if (must_list_refs) {
+		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
-	else
+		trace2_region_leave("fetch", "remote_refs", the_repository);
+	} else
 		remote_refs = NULL;
 
 	argv_array_clear(&ref_prefixes);
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ccc6294ea..c016eeab1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -382,6 +382,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		state_len = 0;
 	}
 
+	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
 	if (args->no_dependents)
@@ -466,6 +467,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		}
 	}
 done:
+	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
@@ -1378,7 +1380,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
 	struct packet_reader reader;
-	int in_vain = 0;
+	int in_vain = 0, negotiation_started = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
 	fetch_negotiator_init(r, &negotiator);
@@ -1421,6 +1423,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_SEND_REQUEST:
+			if (!negotiation_started) {
+				negotiation_started = 1;
+				trace2_region_enter("fetch-pack",
+						    "negotiation_v2",
+						    the_repository);
+			}
 			if (send_fetch_request(&negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
@@ -1444,6 +1452,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_GET_PACK:
+			trace2_region_leave("fetch-pack",
+					    "negotiation_v2",
+					    the_repository);
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
 				receive_shallow_info(args, &reader, shallows, si);
-- 
2.23.0.444.g18eeb5a265-goog

