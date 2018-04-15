Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36811F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDOPgm (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46023 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeDOPgj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id q5-v6so18572003lff.12
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtOX0tAz7pqRLBhn8U2jsGGLvPj4TzYcPgLjw5PWwck=;
        b=uXLXmV71fQ3luSAXnW6R9VkNKdW9k4A62vuOuv7Vz9GnnU0if600WC9YK53GS4PDO/
         TnPN+fuSVgMTa7ELfxbn/qN/5hql1kcSe0RHSl1eIOeILJtx89R7WCVBxOvSd7XnCp/X
         hNeBj4qSdV2d+qF9+L00++URANTMK8cjAdsNArRGaTmxU/2iD/wkT18VOhBpJ8T5295L
         ZR6q4lWKZ+T1TgV3SunYJC+HKRk/NMlmbfcGoJzfFtXk1LpM/WlPhYAl7/Lj2BeOR/dF
         zJjmHahmPjc+Sm2fO6C4S8hOIGHPFuBSHUh/wgCb6NTNMK+M9aBUog5LeAmSZcFVhmfD
         k0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtOX0tAz7pqRLBhn8U2jsGGLvPj4TzYcPgLjw5PWwck=;
        b=uTYDYuo0Y/xSBVh8Pi1h5Mc6seT1QkbxykoZ5ag0lKkzvIhELQzSy03v6bccFovxyV
         IkMEzZ+0jSEb60pm8lvRK36EUnBgo6ccEyBG8U9BMpRdTAFIQkjHZm1+ALlGTYwwqzCb
         KsyfEp8SG7aPGW989hz7XiUBOpYh3x2VlXLQWpH7mLzcdomR6CS3LZ8Uuybwa3yITXmX
         r1i/GFnKvEu/lzNgNc3fri6XoD5JdvzXnJguOyoKFQvwwpOHbkluw2u7BzV1Qg9x+Z1B
         4MuQXfCiu2GBaJW0rD64I+VFtoMrpWv0i6PbstcJUfEnEVEbfN5eF5ENgQoJZnXK0cSz
         3YxQ==
X-Gm-Message-State: ALQs6tBYBrrCvp1fjkSsy+cV0pqDLBD0E/yyDLiSaqY4dnDBwQNgqeIW
        yOPP9mdmhPkVLFkY3/Hm1tjF8w==
X-Google-Smtp-Source: AIpwx4+/erT4AfjJBwDbmOYnlKeX+T7BQBPLwwYs5rY2hJZFuFVnTl7VcvAToD6fhEqWz+BMx4BgQQ==
X-Received: by 10.46.157.201 with SMTP id x9mr1827485ljj.135.1523806598159;
        Sun, 15 Apr 2018 08:36:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 7/7] pack-objects: show some progress when counting kept objects
Date:   Sun, 15 Apr 2018 17:36:18 +0200
Message-Id: <20180415153618.32019-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only show progress when there are new objects to be packed. But
when --keep-pack is specified on the base pack, we will exclude most
of objects. This makes 'pack-objects' stay silent for a long time
while the counting phase is going.

Let's show some progress whenever we visit an object instead. The old
"Counting objects" is renamed to "Enumerating objects" and a new
progress "Counting objects" line is added.

This new "Counting objects" line should progress pretty quick when the
system is beefy. But when the system is under pressure, the reading
object header done in this phase could be slow and showing progress is
an improvement over staying silent in the current code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c77bea404d..6a1346c41f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -46,7 +46,7 @@ static const char *pack_usage[] = {
 static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
-static uint32_t nr_result, nr_written;
+static uint32_t nr_result, nr_written, nr_seen;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -1096,6 +1096,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
@@ -1111,8 +1113,6 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1123,6 +1123,8 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
@@ -1130,8 +1132,6 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1716,6 +1716,10 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
+	if (progress)
+		progress_state = start_progress(_("Counting objects"),
+						to_pack.nr_objects);
+
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
@@ -1726,7 +1730,9 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
+		display_progress(progress_state, i + 1);
 	}
+	stop_progress(&progress_state);
 
 	/*
 	 * This must happen in a second pass, since we rely on the delta
@@ -3209,7 +3215,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"), 0);
+		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-- 
2.17.0.367.g5dd2e386c3

