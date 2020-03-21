Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12785C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CBC20753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL+BWaXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCUJWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38434 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so9831342qke.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT4Sx+tSiVsN/fSK9K4GX5MlFsY2JuB7NQZzi5CNb34=;
        b=EL+BWaXAhAVT5SPGQThXD12r1GACwTD8Ae8KyF+Ak4sL8gvd7CW1Fzu5b+2Dyb8ti8
         I5tE6IXMzZ3d2CNpxQqlu8yvdRx4mGfwQBFBL8hCGGJxSMGy7DGWjuctpjyVKJ+VsP3U
         r3khGNl9JaL5QYJo/yZLwNV1O8C4p9Lc8iggJRTKBYfwQ7wyrdK6fF7zrABjllpNQq7v
         CJ3yrZF8Q80FWT+gWJ82GcqznxBFQ6vNFNf5i1wjo8vsgPOriDAKI65ERgDuNDuZoGix
         eQS1nmopxc1C5/6+g9osF6WZQ/JDH557JdDynVqc1rgeXNEVcSB6mEyMgMofEjcxp9jc
         jR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT4Sx+tSiVsN/fSK9K4GX5MlFsY2JuB7NQZzi5CNb34=;
        b=IXAO2TMhr+SfRMRXMm3W8pyiEoUKrmWVxhyVg3S3EjNg8VC1Aw/PdBNTd82sNyluuU
         PvIaplg2WceMP310UdYaZXdXTNLS7KF5K1Jkc0gSdSBiXwFXhu7iXK3zblNuVb+x6hcV
         8B3ubG5+4wCbfeaY4uzzx/QFhxANxyDZkWyGdJPMBRIy9rF/jA6Dk+jfyLhhmJa2oRxI
         h8B/H/QLOgxERnuSEHK0wUnD7DAUavNKirjBYp04HWzfcfgxjqodwWr2DySx6/Rc5R7X
         NlHe1Waf+ANmq5b/pgbtvmtWy+6YhHFShLsLTioczO/+tQ2yDWfIB41T7o2OJRw/XCjH
         /prw==
X-Gm-Message-State: ANhLgQ3TsiPbGL4KhD8r+s+H3jGp3Heaptn2JdgnyKWcG/SGgGJQM10j
        xL8NeJljMLBptD/oKdM7VXITQ7Lr
X-Google-Smtp-Source: ADFU+vtmMfUBq6ExaTHZiM5cbXP04CuUeDADQkDJezyPVlYVdFL8YZS0jgMx/Yuu+rD4eZHbPau4cA==
X-Received: by 2002:a37:9dc9:: with SMTP id g192mr12273918qke.50.1584782537358;
        Sat, 21 Mar 2020 02:22:17 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 04/19] sequencer: make read_oneliner() accept flags
Date:   Sat, 21 Mar 2020 05:21:23 -0400
Message-Id: <4f9708682877f4d3689781009dc2695b913eff29.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will need read_oneliner() to accept flags other
than just `skip_if_empty`. Instead of having an argument for each flag,
teach read_oneliner() to accept the bitfield `flags` instead. For now,
only recognize the `READ_ONELINER_SKIP_IF_EMPTY` flag. More flags will
be added in a future commit.

The result of this is that parallel topics which introduce invocations
of read_oneliner() will still be compatible with this new function
signature since, instead of passing 1 or 0 for `skip_if_empty`, they'll
be passing 1 or 0 to `flags`, which gives equivalent behavior.

Mechanically fix up invocations of read_oneliner() with the following
spatch

	@@
	expression a, b;
	@@
	  read_oneliner(a, b,
	- 1
	+ READ_ONELINER_SKIP_IF_EMPTY
	  )

and manually break up long lines in the result.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c49fe76fe6..abb2a21e9d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,6 +419,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+
 /*
  * Reads a file that was presumably written by a shell script, i.e. with an
  * end-of-line marker that needs to be stripped.
@@ -429,7 +431,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
  * Returns 1 if the file was read, 0 if it could not be read or does not exist.
  */
 static int read_oneliner(struct strbuf *buf,
-	const char *path, int skip_if_empty)
+	const char *path, unsigned flags)
 {
 	int ret = 0;
 	struct strbuf file_buf = STRBUF_INIT;
@@ -444,7 +446,7 @@ static int read_oneliner(struct strbuf *buf,
 
 	strbuf_trim_trailing_newline(&file_buf);
 
-	if (skip_if_empty && !file_buf.len)
+	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && !file_buf.len)
 		goto done;
 
 	strbuf_addbuf(buf, &file_buf);
@@ -2488,7 +2490,8 @@ static int read_populate_opts(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
 
-		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
 			else {
@@ -2498,7 +2501,8 @@ static int read_populate_opts(struct replay_opts *opts)
 			strbuf_reset(&buf);
 		}
 
-		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
+		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!strcmp(buf.buf, "--rerere-autoupdate"))
 				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
 			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
@@ -2530,7 +2534,8 @@ static int read_populate_opts(struct replay_opts *opts)
 		strbuf_release(&buf);
 
 		if (read_oneliner(&opts->current_fixups,
-				  rebase_path_current_fixups(), 1)) {
+				  rebase_path_current_fixups(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			const char *p = opts->current_fixups.buf;
 			opts->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
@@ -3667,7 +3672,8 @@ static int apply_autostash(struct replay_opts *opts)
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
 	}
@@ -4291,7 +4297,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		struct object_id oid;
 
-		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		if (read_oneliner(&buf, rebase_path_stopped_sha(),
+				  READ_ONELINER_SKIP_IF_EMPTY) &&
 		    !get_oid_committish(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
-- 
2.25.0.114.g5b0ca878e0

