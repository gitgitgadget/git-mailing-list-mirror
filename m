Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DDC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB45724658
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrK8Zsnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLMIIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34374 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLMIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so5625570wrr.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aNXrykXjaip7Gt3NJPyE79aV54iuwbi/BvyEmKiedOg=;
        b=TrK8Zsnl98bdbLolTjXcxpGW0RCZTLv3FDHOF+BPzlScfDJWsj10pSVPUVeT8eSiIb
         uvA+q+UGwvbt4BNMchTdYTxo2JnGpqz3cMrcyEqJA2OS7+QrcFhu9IZTRAyge7ra0jfN
         /u2x0PUngU5RFSNKStFf+ZCYIjVaYPo09hZdTjvGNvM4rAnNi242KlNGc8lABc7MtEvi
         ewcRq0ayf1yUPK9udxWy9T+HQ6MdNBKWtdfhIc70ZiCLYkUixR+FEe74SNiHJwSeLYXh
         4IYhAiAClvGfS2xXNJTHZmdE/iX91fMZUqa+DOQD52/6WgA0kDhKzyRK4KsHEJZ+V7eN
         yvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aNXrykXjaip7Gt3NJPyE79aV54iuwbi/BvyEmKiedOg=;
        b=qXcNMY4T0CSfQGBImfbvAkxI+AxnyQCOmHYeqI2A+gdpwi49lguOoNPYt2ya1rzL4S
         39hnZFqo45cJVyvwcOxNip3KlLWvCP533+b30Weun+rpvYcHiUqWe18YmjczFPdCsbvH
         M85v9vbyQ4sKfFtKrACPNk0fuNJ1wYTDCpXZRGfP5Z0G4ELeth90pc9+kY6j659KU2Dt
         K/ocZDW3KyNYTB8yjlllB5JEqIU6gC5uBBs/AN8j3SaysMzqpR5OkGAeWjJ057LsA1hH
         LA5xeO/xOUbE1n79pgGII82EljvdvlxEquHc/TtbmYJlrwWDvT7+VaaprAjWYkqumony
         awIA==
X-Gm-Message-State: APjAAAVX8B9hCeYDdBqRojCKk5uuzbkYHQDaybh/eRQ04nX9B6IdXTxJ
        HKfGtxYUdsd/o8MxdH/7BbLPce6x
X-Google-Smtp-Source: APXvYqw+kkd34NaDxO96rJJZKL76YlSrwcTLvpL8b0/IOOldPlWykIHbRVQQRkA1whxWOsj4BeR9Pg==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr11769915wrx.304.1576224500638;
        Fri, 13 Dec 2019 00:08:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a20sm9600028wmd.19.2019.12.13.00.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:20 -0800 (PST)
Message-Id: <e7d218793b506d7e9116d9f3a3fabf220191bc72.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:03 +0000
Subject: [PATCH 16/19] built-in add -p: implement the '/' ("search regex")
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch implements the hunk searching feature in the C version of
`git add -p`.

A test is added to verify that this behavior matches the one of the Perl
version of `git add -p`.

Note that this involves a change of behavior: the Perl version uses (of
course) the Perl flavor of regular expressions, while this patch uses
the regcomp()/regexec(), i.e. POSIX extended regular expressions. In
practice, this behavior change is unlikely to matter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 50 +++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh | 14 +++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index fdbb1e3e22..fd72850c65 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1013,6 +1013,7 @@ N_("y - stage this hunk\n"
    "k - leave this hunk undecided, see previous undecided hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
    "g - select a hunk to go to\n"
+   "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
    "? - print help\n");
@@ -1072,7 +1073,7 @@ static int patch_update_file(struct add_p_state *s,
 		if (hunk_index + 1 < file_diff->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
 		if (file_diff->hunk_nr > 1)
-			strbuf_addstr(&s->buf, ",g");
+			strbuf_addstr(&s->buf, ",g,/");
 		if (hunk->splittable_into > 1)
 			strbuf_addstr(&s->buf, ",s");
 		if (hunk_index + 1 > file_diff->mode_change &&
@@ -1177,6 +1178,53 @@ static int patch_update_file(struct add_p_state *s,
 					  "Sorry, only %d hunks available.",
 					  file_diff->hunk_nr),
 				    (int)file_diff->hunk_nr);
+		} else if (s->answer.buf[0] == '/') {
+			regex_t regex;
+			int ret;
+
+			if (file_diff->hunk_nr < 2) {
+				err(s, _("No other hunks to search"));
+				continue;
+			}
+			strbuf_remove(&s->answer, 0, 1);
+			strbuf_trim_trailing_newline(&s->answer);
+			if (s->answer.len == 0) {
+				printf("%s", _("search for regex? "));
+				fflush(stdout);
+				if (strbuf_getline(&s->answer,
+						   stdin) == EOF)
+					break;
+				strbuf_trim_trailing_newline(&s->answer);
+				if (s->answer.len == 0)
+					continue;
+			}
+			ret = regcomp(&regex, s->answer.buf,
+				      REG_EXTENDED | REG_NOSUB | REG_NEWLINE);
+			if (ret) {
+				char errbuf[1024];
+
+				regerror(ret, &regex, errbuf, sizeof(errbuf));
+				err(s, _("Malformed search regexp %s: %s"),
+				    s->answer.buf, errbuf);
+				continue;
+			}
+			i = hunk_index;
+			for (;;) {
+				/* render the hunk into a scratch buffer */
+				render_hunk(s, file_diff->hunk + i, 0, 0,
+					    &s->buf);
+				if (regexec(&regex, s->buf.buf, 0, NULL, 0)
+				    != REG_NOMATCH)
+					break;
+				i++;
+				if (i == file_diff->hunk_nr)
+					i = 0;
+				if (i != hunk_index)
+					continue;
+				err(s, _("No hunk matches the given pattern"));
+				break;
+			}
+			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
 			if (splittable_into < 2)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 57c656a20c..12ee321707 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -429,6 +429,20 @@ test_expect_success 'goto hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'navigate to hunk via regex' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
+	_10
+	+15
+	_20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	EOF
+	test_write_lines s y /1,2 | git add -p >actual &&
+	tail -n 5 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
gitgitgadget

