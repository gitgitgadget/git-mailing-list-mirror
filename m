Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096CC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A5564DF5
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhA2SZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhA2SXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:23:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A94C06178B
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md11so6231061pjb.0
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=SvoBm+NPT/k9yV8AI1ePCs0iwYtrPqo9sERH+f78nbLeKjMqAHWCE6oUYrmm+bPXJx
         t54sK7pmNyDTtkeTAE43eK+Rl2r4rQsKEzGi0uyRYoyGcChG4toK3p1ZE9Ne0tVo+Kn3
         8w6rEGACOvbioe/Mgm8c+CNXSgsOpbsnjTAHA5dGlym0BtyYC0bgdxhoWWLn6sX8q84w
         DlbhJZJCW62QiZMZ66oPZmJKX6mBeAqmi1nTPuVXBxjsWPO75spZUiVTorhwPDurfu/M
         XFI/tqNZPKwC1FkuswJ06KbodCdCV8941sPnBoYAY9JptoQMCtuu69pQrHCJGrcpnJhp
         Ld7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sN6HX1BqV3b1XdRd5cbt+4ED2RdKrpGKUBRJZU//UU=;
        b=n4A8MaYgVrwMQQwEc1yskOETsfx1Q9He5OPfyH1fQA7K5D9/ts0x6m7XSHEsquCjh/
         vneXvICA9OzYyoArtYwzZl7ANG+2jvBOlCqIH6Ya0HjKQyUQErR+ThzJ2bepVMMFrLX1
         yY6GCQiBMU4EuiSNkdlTMjsdZN5fZ/PCzGeIjri25kmZkzBV+OuaUyQOsa/Mp+Ts7KDK
         YYMx26l3Fbcze+OYb1YPbXtDXTNfJ5jn4RiwqBScpZwQSdZ2v6wiYeUp8wvsRaQv811K
         GwQ4yLR3RR62a3m4EW9CuUZ24Iw20uZGyOeOxFWCOd2WRxxgvX7BpDju5wzzw1jPGLnt
         FVtA==
X-Gm-Message-State: AOAM531Urh6jAVfjBOwdq9h7Bx0/hwMFtkI5wUSjxYs2LsOYndM8ekXh
        8oh9vb9RpUnlKuEGcBB63niND/b7i6g=
X-Google-Smtp-Source: ABdhPJz7c1zMHeyFqGfcfWnXxeqze+2/1vo8Gik+V2gquWBnMGEizR3pNFDIKVWnCaiCLJZR6eshNA==
X-Received: by 2002:a17:90a:5b0e:: with SMTP id o14mr5752668pji.106.1611944546170;
        Fri, 29 Jan 2021 10:22:26 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:25 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 5/9] sequencer: use const variable for commit message comments
Date:   Fri, 29 Jan 2021 23:50:46 +0530
Message-Id: <20210129182050.26143-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use and reuse the comments.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 09cbb17f87..6d9a10afcf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1732,6 +1732,11 @@ static size_t subject_length(const char *body)
 	return p - body;
 }
 
+static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
+static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
+static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
@@ -1741,7 +1746,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
 		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
-	strbuf_addf(buf, _("This is the commit message #%d:"),
+	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
@@ -1770,7 +1775,7 @@ static int update_squash_messages(struct repository *r,
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header, _("This is a combination of %d commits."),
+		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
@@ -1794,9 +1799,9 @@ static int update_squash_messages(struct repository *r,
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
+		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _("This is the 1st commit message:"));
+		strbuf_addstr(&buf, _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
@@ -1812,7 +1817,7 @@ static int update_squash_messages(struct repository *r,
 		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
+		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
-- 
2.29.0.rc1

