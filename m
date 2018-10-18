Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133951F453
	for <e@80x24.org>; Thu, 18 Oct 2018 20:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJSEqW (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 00:46:22 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:35891 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 00:46:22 -0400
Received: by mail-it1-f202.google.com with SMTP id p125-v6so1499073itg.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VtDeSvHNoUkDOKCMqqMq92rCqIZmFZBptDKQViDZPpg=;
        b=cM+bug3mc343vWl/Iv704IbKouXt5N8Gz+Fm/j9Syw80jzGSCyzAdWlsFQBEpBFzGw
         SePHMdjA/Nw8dOF8aQiGJxh3PI7bB5HiWJeVtg14CKo62P1Qt3Aeof1/Rz/xDy9/9gP+
         KvsgbLK/E3aP6erLkIbolXq3wNZ8DyYwVj76Fv4nC8fx9AwPBFmT/aAE9CX6AdbbhvmM
         NoPy2UxTa8P1s2hEzFrR5iQJ8ddDfaEITFviwEmcWRwOzr9E2JJZUF5e2LhMstAt+Rww
         VNu14BmkJiH1xJb0Fi6DoJykcQEC9N+Zuwq0PdWZWXIy0G5xadkPM5uFHdyLXdBhSgXN
         Hb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VtDeSvHNoUkDOKCMqqMq92rCqIZmFZBptDKQViDZPpg=;
        b=gUjiOa5sOPLp/0b0s1+T7lZGSNo122b4FtJnWpdDWYMWZqZgEMILBSgIgkPbdRfnjE
         bIPQLRsgfMPSVC5Mn75N76oweJ7htUoyPcEhcXeHB34p7btFbX+8fDxVyLRezpLJOvlJ
         NOY3qMCcl+Y8mQmF8UbPGThD+YFcoHD2EFVpolp2ykq+wYEUhZPl50Ua3flC4DWzQ6ue
         i1DOLV23IjevKQXcyleSNYkWvNOOGfozT42henoR0M7bj0f2UUgmdUQE9Flos8a0qEhH
         fvruas0jqBY0qkLfTxRf305MSO6BP2CGIVBXusVOvqpHteI8Qu1cYZaKdOK8VXJvfq5H
         k8mA==
X-Gm-Message-State: ABuFfogog5ZAj/aJp+IFRLN/vme52asXVawshAOkrNzWDdxXEot8cBo8
        61/G/wMhGYT8PrVFZ/LvTLdQH455+RYEnkJCObUHUN2bL+m3/nDcjRJCCkiLjvL+qobrapExMDf
        4uJmHdjlMIjNYY9VHnK7p47yuDBkzEJ7baNb7xP6hfAycJDKone9RDfF5SpMUGs1B/SnhhAkoEB
        Zl
X-Google-Smtp-Source: ACcGV62JYWBgsKBnfJed7ewy45XaJSqydwsOObrfeGpfNkcK6+pRHe2QpmKsWPq82cw/rTa6ooVwSHIOF+jTg0qVYBaY
X-Received: by 2002:a05:660c:310:: with SMTP id u16mr1506821itj.1.1539895415359;
 Thu, 18 Oct 2018 13:43:35 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:43:27 -0700
In-Reply-To: <cover.1539893192.git.jonathantanmy@google.com>
Message-Id: <8dc7bfb2e06e5fbb6bf4e0fb50173e7b291a7763.1539893192.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016215850.47821-1-jonathantanmy@google.com> <cover.1539893192.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 1/3] upload-pack: make have_obj not global
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because upload_pack_v2() can be invoked multiple times in the same
process, the static variable have_obj may not be empty when it is
invoked. To make further analysis of this situation easier, make the
variable local; analysis will be done in a subsequent patch.

The new local variable in upload_pack_v2() is static to preserve
existing behavior; this is not necessary in upload_pack() because
upload_pack() is only invoked once per process.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 58 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 62a1000f44..cb2401f90d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -52,7 +52,6 @@ static int no_progress, daemon_mode;
 #define ALLOW_ANY_SHA1	07
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
-static struct object_array have_obj;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
@@ -99,7 +98,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-static void create_pack_file(void)
+static void create_pack_file(const struct object_array *have_obj)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	char data[8193], progress[128];
@@ -164,9 +163,9 @@ static void create_pack_file(void)
 		fprintf(pipe_fd, "%s\n",
 			oid_to_hex(&want_obj.objects[i].item->oid));
 	fprintf(pipe_fd, "--not\n");
-	for (i = 0; i < have_obj.nr; i++)
+	for (i = 0; i < have_obj->nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&have_obj.objects[i].item->oid));
+			oid_to_hex(&have_obj->objects[i].item->oid));
 	for (i = 0; i < extra_edge_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
 			oid_to_hex(&extra_edge_obj.objects[i].item->oid));
@@ -303,7 +302,8 @@ static void create_pack_file(void)
 	die("git upload-pack: %s", abort_msg);
 }
 
-static int got_oid(const char *hex, struct object_id *oid)
+static int got_oid(const char *hex, struct object_id *oid,
+		   struct object_array *have_obj)
 {
 	struct object *o;
 	int we_knew_they_have = 0;
@@ -331,17 +331,17 @@ static int got_oid(const char *hex, struct object_id *oid)
 			parents->item->object.flags |= THEY_HAVE;
 	}
 	if (!we_knew_they_have) {
-		add_object_array(o, NULL, &have_obj);
+		add_object_array(o, NULL, have_obj);
 		return 1;
 	}
 	return 0;
 }
 
-static int ok_to_give_up(void)
+static int ok_to_give_up(const struct object_array *have_obj)
 {
 	uint32_t min_generation = GENERATION_NUMBER_ZERO;
 
-	if (!have_obj.nr)
+	if (!have_obj->nr)
 		return 0;
 
 	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
@@ -349,7 +349,7 @@ static int ok_to_give_up(void)
 					    min_generation);
 }
 
-static int get_common_commits(void)
+static int get_common_commits(struct object_array *have_obj)
 {
 	struct object_id oid;
 	char last_hex[GIT_MAX_HEXSZ + 1];
@@ -367,11 +367,11 @@ static int get_common_commits(void)
 
 		if (!line) {
 			if (multi_ack == 2 && got_common
-			    && !got_other && ok_to_give_up()) {
+			    && !got_other && ok_to_give_up(have_obj)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
-			if (have_obj.nr == 0 || multi_ack)
+			if (have_obj->nr == 0 || multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
 			if (no_done && sent_ready) {
@@ -385,10 +385,10 @@ static int get_common_commits(void)
 			continue;
 		}
 		if (skip_prefix(line, "have ", &arg)) {
-			switch (got_oid(arg, &oid)) {
+			switch (got_oid(arg, &oid, have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
-				if (multi_ack && ok_to_give_up()) {
+				if (multi_ack && ok_to_give_up(have_obj)) {
 					const char *hex = oid_to_hex(&oid);
 					if (multi_ack == 2) {
 						sent_ready = 1;
@@ -404,14 +404,14 @@ static int get_common_commits(void)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
-				else if (have_obj.nr == 1)
+				else if (have_obj->nr == 1)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				break;
 			}
 			continue;
 		}
 		if (!strcmp(line, "done")) {
-			if (have_obj.nr > 0) {
+			if (have_obj->nr > 0) {
 				if (multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
@@ -1065,8 +1065,9 @@ void upload_pack(struct upload_pack_options *options)
 
 	receive_needs();
 	if (want_obj.nr) {
-		get_common_commits();
-		create_pack_file();
+		struct object_array have_obj = OBJECT_ARRAY_INIT;
+		get_common_commits(&have_obj);
+		create_pack_file(&have_obj);
 	}
 }
 
@@ -1254,7 +1255,8 @@ static void process_args(struct packet_reader *request,
 	}
 }
 
-static int process_haves(struct oid_array *haves, struct oid_array *common)
+static int process_haves(struct oid_array *haves, struct oid_array *common,
+			 struct object_array *have_obj)
 {
 	int i;
 
@@ -1287,13 +1289,14 @@ static int process_haves(struct oid_array *haves, struct oid_array *common)
 				parents->item->object.flags |= THEY_HAVE;
 		}
 		if (!we_knew_they_have)
-			add_object_array(o, NULL, &have_obj);
+			add_object_array(o, NULL, have_obj);
 	}
 
 	return 0;
 }
 
-static int send_acks(struct oid_array *acks, struct strbuf *response)
+static int send_acks(struct oid_array *acks, struct strbuf *response,
+		     const struct object_array *have_obj)
 {
 	int i;
 
@@ -1308,7 +1311,7 @@ static int send_acks(struct oid_array *acks, struct strbuf *response)
 				 oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up()) {
+	if (ok_to_give_up(have_obj)) {
 		/* Send Ready */
 		packet_buf_write(response, "ready\n");
 		return 1;
@@ -1317,16 +1320,17 @@ static int send_acks(struct oid_array *acks, struct strbuf *response)
 	return 0;
 }
 
-static int process_haves_and_send_acks(struct upload_pack_data *data)
+static int process_haves_and_send_acks(struct upload_pack_data *data,
+				       struct object_array *have_obj)
 {
 	struct oid_array common = OID_ARRAY_INIT;
 	struct strbuf response = STRBUF_INIT;
 	int ret = 0;
 
-	process_haves(&data->haves, &common);
+	process_haves(&data->haves, &common, have_obj);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(&common, &response)) {
+	} else if (send_acks(&common, &response, have_obj)) {
 		packet_buf_delim(&response);
 		ret = 1;
 	} else {
@@ -1392,6 +1396,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
+	/* NEEDSWORK: make this non-static */
+	static struct object_array have_obj;
 
 	git_config(upload_pack_config, NULL);
 
@@ -1423,7 +1429,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			}
 			break;
 		case FETCH_SEND_ACKS:
-			if (process_haves_and_send_acks(&data))
+			if (process_haves_and_send_acks(&data, &have_obj))
 				state = FETCH_SEND_PACK;
 			else
 				state = FETCH_DONE;
@@ -1433,7 +1439,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_shallow_info(&data);
 
 			packet_write_fmt(1, "packfile\n");
-			create_pack_file();
+			create_pack_file(&have_obj);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.19.0.271.gfe8321ec05.dirty

