Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86F82027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdE3RcB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:01 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36529 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3Rb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:56 -0400
Received: by mail-pf0-f177.google.com with SMTP id m17so78263852pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fy1+i3PcHdYYZuat2iRuj0IRJ87Nh6X7+Tgy+fF8goM=;
        b=bNhuwr4aVEduodnvFXt7RUylEckQn51Uc6PCEwSpDCHNIT67iuW1FbmEtTQZDZla9m
         xM38OmhRdUZiP6M/ELQ7VtnKEUDJRSYZpozgS/L24XVLrJOvAHhs9svR19hGyS50JB6T
         dE8yY1iqGxHGt8zLtIlJfZhdX+r9yVRttdzq6Ah6XBWBXzw3sr6HQnRkZjXnzSPxdhUo
         nGzMNQ3mWt0N6D6uJul4jHHEThSbSK3egU230PigQBTv96+Vfuoyhdzi2QQFKWbwX+Y2
         k/N7SvmwUPeLIIHQwKWp6dbejFMO0agtwhXixpRaeSXbKFZ9d+9KwOREWs07Fsc7rDZy
         rdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fy1+i3PcHdYYZuat2iRuj0IRJ87Nh6X7+Tgy+fF8goM=;
        b=bZgRpU68quRrWkrFtx/J3kZfkRD7typeW9BiGJBsRSAaRi37sCrRAqx7VfajI4ox5j
         T1/NUzq5Aco3vrI8CPv7ySBqOV4nLd7LsCdi7Zi/pEAsio5Mo2XZAKhW/kLyd5dwlLz/
         QRNZEMPEu5yT4e/DDOWXXNTKfNe/Yk8usd71BZ/maB5QQ0lk/o199HkZWBpwvSetQjgD
         zOp17LCHiI84I32C0fyQgYvEcea0+p7MvOcc056PL91cv2JQNdGjitDtkWBRkjcwAmBm
         x/hN3j4MDuTgAth99xAKt4JHPgMJeUkwjVJ4ZETEHuhl0qh+IfDoOMrYKIhto5jLZr2w
         Xakg==
X-Gm-Message-State: AODbwcDDk+AVHj5vckPSh1tytTJgI1lVgUvOCRa++LuKgLJPZEP5KeaQ
        0u2fAAZS0b2lDfYt
X-Received: by 10.84.224.70 with SMTP id a6mr84985429plt.38.1496165516050;
        Tue, 30 May 2017 10:31:56 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 26/33] notes-merge: convert write_note_to_worktree to struct object_id
Date:   Tue, 30 May 2017 10:31:02 -0700
Message-Id: <20170530173109.54904-27-bmwill@google.com>
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
index 962e9b1bc..7d88857a8 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -292,11 +292,11 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 		    git_path(NOTES_MERGE_WORKTREE));
 }
 
-static void write_buf_to_worktree(const unsigned char *obj,
+static void write_buf_to_worktree(const struct object_id *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
 	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 
@@ -320,19 +320,19 @@ static void write_buf_to_worktree(const unsigned char *obj,
 	free(path);
 }
 
-static void write_note_to_worktree(const unsigned char *obj,
-				   const unsigned char *note)
+static void write_note_to_worktree(const struct object_id *obj,
+				   const struct object_id *note)
 {
 	enum object_type type;
 	unsigned long size;
-	void *buf = read_sha1_file(note, &type, &size);
+	void *buf = read_sha1_file(note->hash, &type, &size);
 
 	if (!buf)
 		die("cannot read note %s for object %s",
-		    sha1_to_hex(note), sha1_to_hex(obj));
+		    oid_to_hex(note), oid_to_hex(obj));
 	if (type != OBJ_BLOB)
 		die("blob expected in note %s for object %s",
-		    sha1_to_hex(note), sha1_to_hex(obj));
+		    oid_to_hex(note), oid_to_hex(obj));
 	write_buf_to_worktree(obj, buf, size);
 	free(buf);
 }
@@ -358,7 +358,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	if ((status < 0) || !result_buf.ptr)
 		die("Failed to execute internal merge");
 
-	write_buf_to_worktree(p->obj.hash, result_buf.ptr, result_buf.size);
+	write_buf_to_worktree(&p->obj, result_buf.ptr, result_buf.size);
 	free(result_buf.ptr);
 
 	return status;
@@ -393,7 +393,7 @@ static int merge_one_change_manual(struct notes_merge_options *o,
 				"deleted in %s and modified in %s. Version from %s "
 				"left in tree.\n",
 				oid_to_hex(&p->obj), lref, rref, rref);
-		write_note_to_worktree(p->obj.hash, p->remote.hash);
+		write_note_to_worktree(&p->obj, &p->remote);
 	} else if (is_null_oid(&p->remote)) {
 		/* D/F conflict, checkout p->local */
 		assert(!is_null_oid(&p->local));
@@ -402,7 +402,7 @@ static int merge_one_change_manual(struct notes_merge_options *o,
 				"deleted in %s and modified in %s. Version from %s "
 				"left in tree.\n",
 				oid_to_hex(&p->obj), rref, lref, lref);
-		write_note_to_worktree(p->obj.hash, p->local.hash);
+		write_note_to_worktree(&p->obj, &p->local);
 	} else {
 		/* "regular" conflict, checkout result of ll_merge() */
 		const char *reason = "content";
-- 
2.13.0.219.gdb65acc882-goog

