Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AC620D07
	for <e@80x24.org>; Tue, 31 Jan 2017 02:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdAaC2j (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 21:28:39 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33094 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdAaC2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 21:28:38 -0500
Received: by mail-vk0-f66.google.com with SMTP id t8so27989902vke.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TdRQYdL6tqyGbKZTrZ1h8l2fTmvH4apyse126YIXG7I=;
        b=oacbtFsE4E0s5tNphepH3cVX+tCpdd2olAO8qxTSxpQvnzivPstiHhjtzimtptIKub
         zx3RbV5lkavmDeMJs6TccK8gAjg52+0y/SxEMM7QFcw0uePuIfqjLcDC3KkKwhNaH2/s
         9PrqxDbn0b6UrNqtrrdSsXpR+Rj/+9+pX/6p66ku3t5A/ib0vWfo2UHIrImXWXXj2Qtk
         c3C73bekbb8GbxA2zfk5lc457OS4L0nRoaTE/310ycXhQx3Pnz9bm8Nez6uOswU8pmlu
         c/yOUxEoG7ugoMUMSi9Y+UzjKrhxDcs69Ilqcfx6oQQsO6bzvLsvc9YMqbtkpENUNaMZ
         Eibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TdRQYdL6tqyGbKZTrZ1h8l2fTmvH4apyse126YIXG7I=;
        b=D+YtY1cSeLc7SfWYyUSISsG67prEPpN63AqH01czZ9szL96edZh3crVZxXdHY1W4ka
         NkVtkLT2IaikLa1irp37PrgY8o+q7+bLI0van/MkeZfdYmD+an+Xmb5qMOJxwWy8vsZE
         gTuCaKrPo+fNRAFi1XJwbdWG5YZWX89y+h8kU8pJ/KScQbB0hUS4TjmlZqsQf1XAKjn3
         yRIfoKzwBBsiaR0SBMVlHTTMWkiVhV1k23R9Bs2GIiilukYvhRuqCSeKnRrhiQ5jbJWf
         I+6aYKsYG+PdjDajILUfgJvBNdvfy5ryTuC4vjGF4OFmJkSLgN8OtZKjuNivzEWUIdVE
         D+0Q==
X-Gm-Message-State: AIkVDXI4yE6uZQhWSNnmRsr2+gkQQ6nUajvxC2oh+UkrktbzwP4W7OlN2zssMDsQjnzahQ==
X-Received: by 10.31.63.133 with SMTP id m127mr12082366vka.42.1485829718035;
        Mon, 30 Jan 2017 18:28:38 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id 107sm5593324uae.23.2017.01.30.18.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 18:28:37 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] blame: draft of line format
Date:   Mon, 30 Jan 2017 20:28:30 -0600
Message-Id: <20170131022830.8538-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/blame.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 126b8c9e5..89c1a862d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -52,6 +52,7 @@ static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
 static int show_progress;
+static char *format_line;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -1931,6 +1932,19 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
+static void pretty_info(char* revid, struct blame_entry *ent, struct strbuf *rev_buffer)
+{
+	struct pretty_print_context ctx = {0};
+	struct rev_info rev;
+
+	struct strbuf format = STRBUF_INIT;
+	strbuf_addstr(&format, format_line);
+	ctx.fmt = CMIT_FMT_USERFORMAT;
+	get_commit_format(format.buf, &rev);
+	pretty_print_commit(&ctx, ent->suspect->commit, rev_buffer);
+	strbuf_release(&format);
+}
+
 static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
@@ -1939,11 +1953,15 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	struct commit_info ci;
 	char hex[GIT_SHA1_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	struct strbuf line_revision_buf = STRBUF_INIT;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
 
 	cp = nth_line(sb, ent->lno);
+
+	if (format_line)
+		pretty_info(hex, ent, &line_revision_buf);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -1968,6 +1986,10 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 			       format_time(ci.author_time, ci.author_tz.buf,
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
+		} else if (format_line) {
+			printf("%s", line_revision_buf.buf);
+			printf(" %*d) ",
+			       max_digits, ent->lno + 1 + cnt);
 		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
 				printf(" %*d %02d",
@@ -2007,6 +2029,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	if (sb->final_buf_size && cp[-1] != '\n')
 		putchar('\n');
 
+	strbuf_release(&line_revision_buf);
 	commit_info_destroy(&ci);
 }
 
@@ -2605,6 +2628,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
+		OPT_STRING(0, "format-line", &format_line, N_("format-line"), N_("Use pretty format for revisions")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
-- 
2.11.0.rc1

