Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF37220248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfCZRxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:53:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50815 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZRxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:53:35 -0400
Received: by mail-pl1-f202.google.com with SMTP id b10so2582575plb.17
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KtrLp1nt1otiM2BjvOWUfQWRg943+4IuhVcK+NueVSM=;
        b=vz2AetqFQ5EQhWBm8QaPXQszg546nbinU6HTq5KiILkFTqoIbv/LF13EYpHGVMn/VG
         GoWFcc3pIHvs9tXSmoHPGlAdmKTiRcxj7TzL7PpRk83MXEQcvIpeLlBM16V77TD9voan
         g0YdIcxil20jTPC1rvgll8lB67RbO+HdoI1rFDk+Rl4KBr7oA3PVirMD+c8iyFY3VgFl
         Y88ZpsGXrfaBeXQAt1xdY2zGcCCzUXPBOoBlmbWDnHYBaHLCQmQClXDbLLQYwX6nVNP1
         EtkzNyTud5Zo3YZ01w9cDYbMde6+tO2PLTsg1KLkYF++hhOxmx2h75s1e9IS8YsYhEyy
         p9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KtrLp1nt1otiM2BjvOWUfQWRg943+4IuhVcK+NueVSM=;
        b=IDXh2oO7oIcZ7Vw/mcoVal6DwaCDyOPeVwGExdL18lOVkMQrxt/m2eq9iPc8dccjCc
         vuGAZAJuW7M/uzcmruNhBJrNC+1YHnKA6XSVDrjeyGgpEMIw/dQL8HdVqmhrir8zqK9S
         V8YHyA1wm1IRiKIftrufqNhtptCE0jkqdVmhcKDBC/V2lqh0UMPuFuh68syR0cUfYGgl
         h49VMuXNUIzzeNZuUSrDkkvo71HM/glhTz8hW1CtsrkyAFgd/uwU9GNPIHpgs7lKrPrt
         DsPy3n0+1ZFjw56USEoyzKGJk5nyk7e1FEm0PBYCQtwh043VQb8XV2+bkpHdUKpbPyvn
         CN+A==
X-Gm-Message-State: APjAAAWcvvJObPhL0MNNfEfDz0TBXcAAnCO+X7aOUf+mZvlHPP3MosjS
        15f8zaxpmV1b2Xi0XqOPzE65CwkKqJ77bc/4L67CoLU7CbxpYRX2mpKUET3fcdZpewAu7tKTF9B
        bKwCTc0TRQUKA8XCGJ4p26ldmVp/auWjEAxvT1zlgaB7qGf+75gXS0WUJJHcQTRW5lQt59wUopG
        38
X-Google-Smtp-Source: APXvYqzYbctq2n/o0ytgjHrS/6Hwx03djAba/hXLhZQxETU/P/mo9ROoINWiweZUBC0dkg3YcdHJPfyfkjpibsN4mjUA
X-Received: by 2002:a65:6548:: with SMTP id a8mr1672371pgw.442.1553622815029;
 Tue, 26 Mar 2019 10:53:35 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:53:26 -0700
In-Reply-To: <cover.1553622678.git.jonathantanmy@google.com>
Message-Id: <943b1cbc61dbcc498a9e34d7d39dc8617cb99195.1553622679.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com> <cover.1553622678.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v2 2/2] fetch-pack: respect --no-update-shallow in v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        pclouds@gmail.com
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
 fetch-pack.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a0eb268dfc..4831eb6a25 100644
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
@@ -1649,10 +1674,11 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		die(_("no matching remote head"));
 	}
 	if (version == protocol_v2) {
-		if (shallow && shallow->nr)
+		if (shallow->nr)
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

