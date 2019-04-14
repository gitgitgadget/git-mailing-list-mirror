Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A7920248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDNVJt (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:09:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36653 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:09:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so19208030wrd.3
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+2HoTlWWVjYTZ88dQVxmIRNi7dZ2M3XriYmao/1nMQ=;
        b=sD3/h3BauutZq0dAxluzkwnz/Vlrpm5YoLJyanYkN7hdWgeaudNPnPlG0bPNqzrd7x
         62fzU6u3IfYElljCaES44s0EU/czLkCfqdjQkMj8sZdEwvH1ItA2oZsJxtTl38GjBE6y
         VVp63bJ7zac01+8YIhwf0TeX1tn9vStdVSv4XS6d7+7EpzqtxuATmqjNRTN2QTXACo1I
         6L4MHDMZDMJ42ZxdDQUyNCaTaatbPrEU4arWoX3BhTyTwi/tAoh0PMlIQ6j5a3gsSh8Q
         94i+VOGKl5fVVQRjcqo2wj/8w6YX1NbhI6wY5txAr0b9e9Jih7cwJqoGIik3NaPkh51N
         vJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+2HoTlWWVjYTZ88dQVxmIRNi7dZ2M3XriYmao/1nMQ=;
        b=CWwajA8Dvs43/9zPJNZkPE+RIXl2Ej1pT08wUcYV54sNjNmNE7CxAKQ/FqrQQCKsAT
         tbNIXF1Zwqvt56w8IrdgJrHFv+peB5fAb83vy9Ld5tuCaItGUpU4ZhMgZUNTpuU2F0gx
         dRBRXxmh02Z5Ss7zqRzXd9f5zN92auDer/1/xl7VmHGDI+/o1hxDtEHkPpVWmuoWUZIW
         LzBCyIFgq4XITaRfcmmLwMLwHeZmwSJVUXonFJdj5vLksRAtoJiMZwSkWI2X+0LVvzB7
         c321mC/z/fkCtbFzDqVRNM7dENR8/Geh/G9BavdkrySWK04XGJZwWbGOy9oOU1feKVu+
         ql3g==
X-Gm-Message-State: APjAAAVRuTTfSgAqJf+UUQw4NP90gDzLIuAdVft7rYpTJ5sIp8g0fYZm
        2zZ8P3MWaJu24jdm2wnjkadWz5D7
X-Google-Smtp-Source: APXvYqxrbD5hwSUvzYBtUk2BA9fuQIyE4JiyUKX9n6Q00B/6LgZyJiA3iSWt7IiGjFVTfbpPClBZnQ==
X-Received: by 2002:adf:c788:: with SMTP id l8mr43822065wrg.143.1555276186678;
        Sun, 14 Apr 2019 14:09:46 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id o20sm14020781wmh.21.2019.04.14.14.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:09:45 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 3/4] range-diff: add section header instead of diff header
Date:   Sun, 14 Apr 2019 22:09:32 +0100
Message-Id: <20190414210933.20875-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently range-diff keeps the diff header of the inner diff
intact (apart from stripping lines starting with index).  This diff
header is somewhat useful, especially when files get different
names in different ranges.

However there is no real need to keep the whole diff header for that.
The main reason we currently do that is probably because it is easy to
do.

Introduce a new range diff hunk header, that's enclosed by "##",
similar to how line numbers in diff hunks are enclosed by "@@", and
give human readable information of what exactly happened to the file,
including the file name.

At this point, this is only a marginal improvement in readability of
the range-diff output.  More interestingly however, this allows us to
add these range diff hunk headers to the outer diffs hunk headers
using a custom userdiff pattern, which should help making the
range-diff more readable.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index f365141ade..aa466060ef 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -33,6 +33,7 @@ static int read_patches(const char *range, struct string_list *list)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	FILE *in;
 	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
+	struct strbuf filename_a = STRBUF_INIT;
 	struct patch_util *util = NULL;
 	int in_header = 1;
 
@@ -90,8 +91,37 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
-			strbuf_addch(&buf, ' ');
-			strbuf_addbuf(&buf, &line);
+		} else if (starts_with(line.buf, "--- ")) {
+			if (!strcmp(line.buf, "--- /dev/null"))
+				strbuf_remove(&line, 0, 4);
+			else
+				strbuf_remove(&line, 0, 6);
+			strbuf_rtrim(&line);
+			strbuf_reset(&filename_a);
+			strbuf_addbuf(&filename_a, &line);
+		} else if (starts_with(line.buf, "+++ ")) {
+			strbuf_addstr(&buf, " ## ");
+			if (!strcmp(line.buf, "--- /dev/null"))
+				strbuf_remove(&line, 0, 4);
+			else
+				strbuf_remove(&line, 0, 6);
+			strbuf_rtrim(&line);
+			if (!strcmp(filename_a.buf, "/dev/null")) {
+				strbuf_addstr(&buf, "new file ");
+				strbuf_addbuf(&buf, &line);
+			} else if (!strcmp(line.buf, "/dev/null")) {
+				strbuf_addstr(&buf, "removed file ");
+				strbuf_addbuf(&buf, &line);
+			} else if (strbuf_cmp(&filename_a, &line)) {
+				strbuf_addstr(&buf, "renamed file ");
+				strbuf_addbuf(&buf, &filename_a);
+				strbuf_addstr(&buf, " -> ");
+				strbuf_addbuf(&buf, &line);
+			} else {
+				strbuf_addstr(&buf, "modified file ");
+				strbuf_addbuf(&buf, &line);
+			}
+			strbuf_addstr(&buf, " ##\n");
 		} else if (in_header) {
 			if (starts_with(line.buf, "Author: ")) {
 				strbuf_addbuf(&buf, &line);
-- 
2.21.0.593.g511ec345e1

