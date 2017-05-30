Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837962027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdE3RcC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:02 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35491 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdE3RcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:00 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so78341521pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwgIkmp1xmwg+gwZYP+6w+X4PxQmfZu1vbqlATnEupU=;
        b=Yon77PSEGMD7k43EtiMgxKGtykKN/cMQmS5Dy4syJkUn6PkHLoLpJdUAeZpKAm4Ket
         IukQduMWfI8P6mhWpszYs822BZhnRFXRNdKT7JqGD8YopnqLPQr9sHj54d6rJJaYmhEz
         tYK4SPa86gfcvRrzzZIxNEnRCfmlxwQT2b4xDwEx8QWetkxFVco4XBt9VVX9SgaFHXxW
         Mx9XA83PbUUKZRwujcKYsaXKJTF5oNVSwwJHHlJ01zA4V7DsHjouNuZHK4GPZ54AP/vB
         Za3PcMMgi4zgilQD/QBoWna7XDW1MChXVU3EmweXsqp3xMbo2yDdUelA5SzLUk6v+/QR
         HtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwgIkmp1xmwg+gwZYP+6w+X4PxQmfZu1vbqlATnEupU=;
        b=Py5aA7V4p3h13SFjVQ8sM/t4PnZVAckZaxZ1rMBO3kRirhho7jrm6CtbK9bvZ0DTJq
         2rjsLcYgistema5Jh7c188/eDnbjz4HDZ5nPHzNl8x4l85YN3h+Wc4537R0A63PbB0XJ
         69Ky/zfni7wTCSGhljXHq6mp46ukPuH/m1QNDifTSrBXzz1HxDiFGiVe0nhSUIe8xKy4
         pXiwKED0NzohIE+cNgy2TkGGzvIl+67O+6XTw5FFH5w0h2iAUOfA9XbTYa/aQOdZ0orE
         YiosAtfB+koOtdBLIvD/32JxGyR3/GtSstrv57/kBpUkl8FmN3UJNYytDlLg/SgSdriD
         A2Ow==
X-Gm-Message-State: AODbwcD2znqZujHDtUzGZ0ROkGkfd0X/RgWE4Dz+Ys/e0xnZwuG4ovgc
        9PinEraXP2DCwFu3Dax3vw==
X-Received: by 10.99.155.17 with SMTP id r17mr6103692pgd.109.1496165514314;
        Tue, 30 May 2017 10:31:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 25/33] notes-merge: convert verify_notes_filepair to struct object_id
Date:   Tue, 30 May 2017 10:31:01 -0700
Message-Id: <20170530173109.54904-26-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 notes-merge.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 55dbb3659..962e9b1bc 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -22,21 +22,21 @@ void init_notes_merge_options(struct notes_merge_options *o)
 	o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
 }
 
-static int path_to_sha1(const char *path, unsigned char *sha1)
+static int path_to_oid(const char *path, struct object_id *oid)
 {
-	char hex_sha1[40];
+	char hex_oid[GIT_SHA1_HEXSZ];
 	int i = 0;
-	while (*path && i < 40) {
+	while (*path && i < GIT_SHA1_HEXSZ) {
 		if (*path != '/')
-			hex_sha1[i++] = *path;
+			hex_oid[i++] = *path;
 		path++;
 	}
-	if (*path || i != 40)
+	if (*path || i != GIT_SHA1_HEXSZ)
 		return -1;
-	return get_sha1_hex(hex_sha1, sha1);
+	return get_oid_hex(hex_oid, oid);
 }
 
-static int verify_notes_filepair(struct diff_filepair *p, unsigned char *sha1)
+static int verify_notes_filepair(struct diff_filepair *p, struct object_id *oid)
 {
 	switch (p->status) {
 	case DIFF_STATUS_MODIFIED:
@@ -54,7 +54,7 @@ static int verify_notes_filepair(struct diff_filepair *p, unsigned char *sha1)
 		return -1;
 	}
 	assert(!strcmp(p->one->path, p->two->path));
-	return path_to_sha1(p->one->path, sha1);
+	return path_to_oid(p->one->path, oid);
 }
 
 static struct notes_merge_pair *find_notes_merge_pair_pos(
@@ -140,7 +140,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		int occupied;
 		struct object_id obj;
 
-		if (verify_notes_filepair(p, obj.hash)) {
+		if (verify_notes_filepair(p, &obj)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
 			       p->status, oid_to_hex(&p->one->oid),
@@ -201,7 +201,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 		int match;
 		struct object_id obj;
 
-		if (verify_notes_filepair(p, obj.hash)) {
+		if (verify_notes_filepair(p, &obj)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
 			       p->status, oid_to_hex(&p->one->oid),
-- 
2.13.0.219.gdb65acc882-goog

