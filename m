Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73C72028A
	for <e@80x24.org>; Sun, 21 May 2017 14:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbdEUOLV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 10:11:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36039 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdEUOLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 10:11:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so14570657pfb.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CgsbrqCTWHqai8Ouhvg8/jO2D3KpEsR2DpobPVjj26M=;
        b=lUA5fa3fwY50kia1147YTDYdXmkK7ZgnBleByjAn5KnEsEycJo+9pUkC6Pz2/lieex
         fsoxIl3ZJeOdsS5EYTVwxJkjUOASCzfM9n6NNoPoyC30QPZpruJ0956SBEf86SdJy+Tm
         PuyYYaTZf2bII4HTaCGAwEsGPRdXgpsgpnUH7aI4oHOXPHlKTQ5j6YeT6dOhy7I8J6gt
         /Pii7f9ZS/9hCutJyyemlUcY5Mu4lxxfb25DwRyVPFdReGH5mKa29AzBgQhO/G7+DrWG
         2S3zjJGdNQPoB0ZjcxAGOuTwshQjW3TQuvsN6t5klPCHap+J9AX/3ypggGd5XQOIdQVl
         E/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CgsbrqCTWHqai8Ouhvg8/jO2D3KpEsR2DpobPVjj26M=;
        b=l2/16gvvY+i0adqb7J/RukxNglCOzCu4sLE4OaF0NtWZzG7Vsq4uacNfQ5fuloj/cR
         T2wTqmYtXtYtn11JvFB/SnFrQ9NR3AQE8+CkuA7zfcYz99OsmCrgjusG2aJhT6ipKf5D
         CdCJ9Jmw0Y6sGI+R0GxIe7NbObdaAXWrHol4hpQEFvQ/TRqcL+G7zJV3czHOw1ID03sN
         72La+0NcJ3fm2f2I7AWZ6zHGji80YoMurItSLdM/lUuK6oWp2A3xCvDpZCKWZ0r3UN5l
         LE9KYpPVAfYWfn1c7QdoSmtdKVeuK12paEQOu6kdj5caiWe+AFmC9LNhLGk+W2sdCDWP
         3Dig==
X-Gm-Message-State: AODbwcBqA74mbopF8t/Kh2jDJKh+1xFs7lMibMs+6pF/fCSQOHTvKllC
        Kz90sluDxCGzrQ==
X-Received: by 10.84.215.15 with SMTP id k15mr22694405pli.104.1495375880116;
        Sun, 21 May 2017 07:11:20 -0700 (PDT)
Received: from localhost.localdomain ([116.87.142.169])
        by smtp.gmail.com with ESMTPSA id d2sm1370302pfb.110.2017.05.21.07.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 May 2017 07:11:19 -0700 (PDT)
From:   DOAN Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     animi.vulpis@gmail.com, j6t@kdbg.org, peff@peff.net,
        gitster@pobox.com, git@grubix.eu, pclouds@gmail.com,
        karthik.188@gmail.com, DOAN Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
Date:   Sun, 21 May 2017 22:10:59 +0800
Message-Id: <20170521141059.2767-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.13.0.67.g10c78a1
In-Reply-To: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting from commit 949af06 (branch: use ref-filter printing APIs, 2017-01-10),
`git branch -v` doesn't treat CRLF as line separator anymore.

Quote from git mailing-list:

> Here is a recipe to reproduce the error:
>
>    git init
>    git commit --allow-empty -m initial
>    git branch crlf $(printf '%s\r\n' subject '' line3_long line4 |
>        git commit-tree HEAD:)
> The reason for the "bug" is obviously that a line having CR in addition
> to LF is not "an empty line". Consequently, the second line is not
> treated as a separator between subject and body, whereupon Git
> concatenates all line into one large subject line. This strips the LFs
> but leaves the CRS in tact, which, when printed on a terminal move the
> cursor to the beginning of the line, so that text after the CRs
> overwrites what is already in the terminal.

Reported-by: Animi Vulpis <animi.vulpis@gmail.com>
Helped-by: Johannes Sixt <j6t@kbdg.org>
Signed-off-by: DOAN Tran Cong Danh <congdanhqx@gmail.com>
---
 ref-filter.c             | 19 +++++++++++++++----
 t/t3203-branch-output.sh |  3 ++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..b3c2276a5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -967,7 +967,8 @@ static void find_subpos(const char *buf, unsigned long sz,
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
+	while (buf < *sig && *buf && *buf != '\n'
+	       && !(*buf == '\r' && *(buf + 1) == '\n')) {
 		eol = strchrnul(buf, '\n');
 		if (*eol)
 			eol++;
@@ -975,12 +976,22 @@ static void find_subpos(const char *buf, unsigned long sz,
 	}
 	*sublen = buf - *sub;
 	/* drop trailing newline, if present */
-	if (*sublen && (*sub)[*sublen - 1] == '\n')
+	if (*sublen && (*sub)[*sublen - 1] == '\n') {
 		*sublen -= 1;
+		/* also drop trailing CR before that LF */
+		if ((*sublen) && (*sub)[*sublen - 1] == '\r')
+			*sublen -= 1;
+	}
 
 	/* skip any empty lines */
-	while (*buf == '\n')
-		buf++;
+	while (1) {
+		if (*buf == '\n')
+			buf++;
+		else if (*buf == '\r' && *(buf + 1) == '\n')
+			buf += 2;
+		else
+			break;
+	}
 	*body = buf;
 	*bodylen = strlen(buf);
 	*nonsiglen = *sig - buf;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5778c0afe..29b392066 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -13,7 +13,8 @@ test_expect_success 'make commits' '
 
 test_expect_success 'make branches' '
 	git branch branch-one &&
-	git branch branch-two HEAD^
+	git branch branch-two $(printf "%s\r\n" one "" line3_long line4 |
+	     git commit-tree HEAD:)
 '
 
 test_expect_success 'make remote branches' '
-- 
2.13.0.67.g10c78a1

