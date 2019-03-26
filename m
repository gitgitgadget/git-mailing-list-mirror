Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D239F20248
	for <e@80x24.org>; Tue, 26 Mar 2019 19:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfCZTbd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 15:31:33 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53787 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZTbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 15:31:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id f7so206217pgi.20
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=un6dj5SXCZw1KfkrajSyDwN3y+4VbTuumKOjqJg43Do=;
        b=jquW1gH3kxRBC8HXi119W+pPyn0AOOMhVPZEa5e8F6rbSsx7SaU5b5nraHgvEIC9/x
         zKDLkzm8NarmT1JFqWcW2NkafzkdHM8CvKzrs/9acWIi8SY1wTrHkKYyUO9qVErjea3m
         Nottn4P4/Qx7WkicaC7MOuHCSAN/YZHSsu+cWyxuhifIv3Z79Ta6Dw3QMUdVsnXE/53n
         Rfw4bwhi/zY5MqNp+lsITav3l9AsIKxdPQZEe6WUXSAMkHncPKBhj9rBTmGQZTA1DuFI
         gXQLtnH/3+wAfVRPl/7qyeHCbkzwLsCyphVQWICpwMfnDFJOu30P8BcRLNQxVe406m72
         EiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=un6dj5SXCZw1KfkrajSyDwN3y+4VbTuumKOjqJg43Do=;
        b=nM20td9m33NWXFv/iOpjPgVFnPQAw24VkiazP90A/EWyLRWQNbGn0WGV6VJkX5KoxY
         dB+RY25/LH1psaB7JJlmG14ktdgaoVwihS7ggbsdLZbLVBUVoCwNytbNbYAgVmOVLeMC
         NMK7IM1MnOSmtjT0l4rsEFqU+QixNJ+EVYC6lf2dj3ukgoWk4OiK/voiSY8niC19yRVU
         et+1NNBbBypkI6KIGxNei6HYAo7++PRmGOu1sAWnsbXbys1r3ZntHQ2kPYw9Mwf3uAQw
         ZC1n8ZiySFRlHtmpbNvlPfThCbRw2Yvzam7CJ1+4ZZEaBWLAPT2tZuzRKAmrVxXX1K7I
         E0kA==
X-Gm-Message-State: APjAAAU3qQNDr5mdhExpUKn7ZRLsnbLimvJBBSlQi1sGCVEKRV1Pj5wK
        72MwRdX5Q8h70d00dXkxA7DzrgbGs86upA5B8D63DCVTS2rPdya+uugn6umDB5B1Uxs3b9mVHOK
        u9ifMh4Yah0G85deBfDNTSqVxw7s4kdmTJsdWp6Uu3p5WO4Lk6KtxivuQuN/HAFzjIauJThjUTK
        AJ
X-Google-Smtp-Source: APXvYqz/mtXatT9yMkZkDKPBv1flZ/HUV37UedQBq4X+d3yacZvZpjsTc8m4vjwiI8UWuVuz33ZtOn7CpW3XCRCDcIgz
X-Received: by 2002:a63:2045:: with SMTP id r5mr30045997pgm.394.1553628692582;
 Tue, 26 Mar 2019 12:31:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:31:21 -0700
In-Reply-To: <cover.1553628494.git.jonathantanmy@google.com>
Message-Id: <3f65698610c1e3d1bc8acf76a24a6cabc554ff9b.1553628494.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com> <cover.1553628494.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v3 2/2] fetch-pack: respect --no-update-shallow in v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In protocol v0, when sending "shallow" lines, the server distinguishes
between lines caused by the remote repo being shallow and lines caused
by client-specified depth settings. Unless "--update-shallow" is
specified, there is a difference in behavior: refs that reach the former
"shallow" lines, but not the latter, are rejected. But in v2, the server
does not, and the client treats all "shallow" lines like lines caused by
client-specified depth settings.

Full restoration of v0 functionality is not possible without protocol
change, but we can implement a heuristic: if we specify any depth
setting, treat all "shallow" lines like lines caused by client-specified
depth settings (that is, unaffected by "--no-update-shallow"), but
otherwise, treat them like lines caused by the remote repo being shallow
(that is, affected by "--no-update-shallow"). This restores most of v0
behavior, except in the case where a client fetches from a shallow
repository with depth settings.

This patch causes a test that previously failed with
GIT_TEST_PROTOCOL_VERSION=2 to pass.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index ebb24ada24..4831eb6a25 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1253,9 +1253,11 @@ static int process_acks(struct fetch_negotiator *negotiator,
 }
 
 static void receive_shallow_info(struct fetch_pack_args *args,
-				 struct packet_reader *reader)
+				 struct packet_reader *reader,
+				 struct oid_array *shallows,
+				 struct shallow_info *si)
 {
-	int line_received = 0;
+	int unshallow_received = 0;
 
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
@@ -1265,8 +1267,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		if (skip_prefix(reader->line, "shallow ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid shallow line: %s"), reader->line);
-			register_shallow(the_repository, &oid);
-			line_received = 1;
+			oid_array_append(shallows, &oid);
 			continue;
 		}
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
@@ -1279,7 +1280,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 				die(_("error in object: %s"), reader->line);
 			if (unregister_shallow(&oid))
 				die(_("no shallow found: %s"), reader->line);
-			line_received = 1;
+			unshallow_received = 1;
 			continue;
 		}
 		die(_("expected shallow/unshallow, got %s"), reader->line);
@@ -1289,10 +1290,31 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing shallow info: %d"), reader->status);
 
-	if (line_received) {
+	if (args->deepen || unshallow_received) {
+		/*
+		 * Treat these as shallow lines caused by our depth settings.
+		 * In v0, these lines cannot cause refs to be rejected; do the
+		 * same.
+		 */
+		int i;
+
+		for (i = 0; i < shallows->nr; i++)
+			register_shallow(the_repository, &shallows->oid[i]);
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 		args->deepen = 1;
+	} else if (shallows->nr) {
+		/*
+		 * Treat these as shallow lines caused by the remote being
+		 * shallow. In v0, remote refs that reach these objects are
+		 * rejected (unless --update-shallow is set); do the same.
+		 */
+		prepare_shallow_info(si, shallows);
+		if (si->nr_ours || si->nr_theirs)
+			alternate_shallow_file =
+				setup_temporary_shallow(si->shallow);
+		else
+			alternate_shallow_file = NULL;
 	} else {
 		alternate_shallow_file = NULL;
 	}
@@ -1337,6 +1359,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
 				    struct ref **sought, int nr_sought,
+				    struct oid_array *shallows,
+				    struct shallow_info *si,
 				    char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1411,7 +1435,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_GET_PACK:
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
-				receive_shallow_info(args, &reader);
+				receive_shallow_info(args, &reader, shallows, si);
 
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
@@ -1625,6 +1649,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
+	struct oid_array shallows_scratch = OID_ARRAY_INIT;
 
 	fetch_pack_setup();
 	if (nr_sought)
@@ -1653,6 +1678,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			BUG("Protocol V2 does not provide shallows at this point in the fetch");
 		memset(&si, 0, sizeof(si));
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
+					   &shallows_scratch, &si,
 					   pack_lockfile);
 	} else {
 		prepare_shallow_info(&si, shallow);
@@ -1680,6 +1706,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	update_shallow(args, sought, nr_sought, &si);
 cleanup:
 	clear_shallow_info(&si);
+	oid_array_clear(&shallows_scratch);
 	return ref_cpy;
 }
 
-- 
2.21.0.155.ge902e9bcae.dirty

