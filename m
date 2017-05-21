Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A47A201CF
	for <e@80x24.org>; Sun, 21 May 2017 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdEUNmb (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 09:42:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36721 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdEUNma (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 09:42:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so14526221pfb.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CgsbrqCTWHqai8Ouhvg8/jO2D3KpEsR2DpobPVjj26M=;
        b=XW+zfAHNLpHUSEbYrz59Ox6O2K/JGKopdgpR8RmsSOhslEyQLariW+ruWOyvajGjsc
         lRbVFfKteYp74/jA+kA3hj1BWwnJfw3bSOAfGcCQZRJPhId+WHGxrSJWKfdS2hW2qtP1
         cQefn3WmhdAp1jeGo3r8CvPp3Fzti36ek3JTKY2yY44zSVInq9WpURld5rDuciNUofhN
         oHUvoKUB1OCX9bYbyoBmi946Xw3IKPpP1cRltsqyXGLdtt8UJz6ceOwJqa9w3xbtXURI
         heZt5ZLG5UffmDkeT9Iyw2O8Fo5rxMQSKQgU3D0R8MqZLrcjc0tgplrZ5q7OwQXRROub
         1LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CgsbrqCTWHqai8Ouhvg8/jO2D3KpEsR2DpobPVjj26M=;
        b=Vosp5nDY9QT1eAp9kpiNra4CcL7x9tG/rsxW5WLCunB2KiPi7VBPJhNFPVLlpFNfTT
         j3zPzowmNLs1uvtu5mWqlEM1bYEchVKfhBE0njAP6aIWoiZe8DriaTmCSeaxQmCGg1xu
         LAR2GcILof+6oJaglu9zX09hmQyrbq7Wj86dzdVcgtSDlrBuBl2E8Y6ObUZSDnbMRN1V
         F1B4xHOgnJDyPXlI1FMpp4fcz36Suxg5XNC6hnyGr8T7XYtHj7lipHOLHs3ql3VdxihN
         KeAQqXe3dAUcZyGtG7Vd1VMcwW1KMjis23rH4ssBq6qcuj0qsIm3v45gtXRvxgBWbvla
         xrpg==
X-Gm-Message-State: AODbwcCIkDtfU11kjHA5DIc2no2HT8rAcW6jbjLfUB4zH7R6AA0kGoSn
        x26zA9y8E0yV/HTlcj03fA==
X-Received: by 10.99.5.3 with SMTP id 3mr19549560pgf.104.1495374149939;
        Sun, 21 May 2017 06:42:29 -0700 (PDT)
Received: from localhost.localdomain ([116.87.142.169])
        by smtp.gmail.com with ESMTPSA id h71sm24113510pfe.85.2017.05.21.06.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 May 2017 06:42:29 -0700 (PDT)
From:   DOAN Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     animi.vulpis@gmail.com, j6t@kdbg.org,
        DOAN Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
Date:   Sun, 21 May 2017 21:42:09 +0800
Message-Id: <20170521134209.25659-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.13.0.67.g10c78a1
In-Reply-To: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
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

