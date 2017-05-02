Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340D9207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdEBEB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33634 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdEBEBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:23 -0400
Received: by mail-io0-f193.google.com with SMTP id o22so1895222iod.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1mrJjAyKfziu+2XHNlUFseRR1vKe2mxIgpWdhQd/88=;
        b=NMbju9N8SdH3bfbk82slsJc+7PKwd7ZiKQH2gS/BDt9xSMVRIhXvADBKk3Tkm2u4f1
         nejHqW22JYeyC69DfLcpuVc1SfUGH0g2ezOU2q4JcJFhLTzjQi8CYRfmP1gJmaFcOF7d
         JHEC8ypv0Ni7PsPmNEdePpYbHYEDO2GivKl+icrew9C/+XgfJ4/4xYX1ijjMCsVN3iW4
         fce4rsmjj5Dk11bH7ynAZ+FfcKAWYKGy5oV/61jcxcuJMgZLNLSN5jU3NEEYh2UiW0+P
         NFT0ASt4T7H1gJUQ3bkbengexvmQFsDePaNr4F+6lcBQujAm2CFuLvHogU6RjbQuFYpz
         oiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1mrJjAyKfziu+2XHNlUFseRR1vKe2mxIgpWdhQd/88=;
        b=PxOGAypx+sS2t1HRhx/D6qubnmUL1I9phfKXlK59Y5GQ+HVuilVrO5w3JK1y3M9o5+
         oRAAlxI6NfEa0LxgzHC1HEEWqua5MisAAWNt7EJ4zHOePHWJujo8BIz4GG/FOjPJF7vP
         wQzG5szF0/o72DbLxO0iOTOt1NChITj32cJv0FI0Cx4toVxuqlr77LlOgOUK7+H+7Pbh
         HghpblUjToRY0sbrFlBzqIPvBzdsLA7eUmNJPAbaoxrxSQp+On19Rs0Cpj2S4vIgSy9z
         yhhu1mT171pdH34Wrqgq5eHGudfBPuZaUmhIOiItWYksS8S6ViJf/cRy73rsMPkAagoO
         3cTQ==
X-Gm-Message-State: AN3rC/7UgT258svXT/UgIWuwno1cPlSiLWIX/4o3RRp50VGKT1DNuw3+
        +ucbsE1sdVWOpw==
X-Received: by 10.107.34.201 with SMTP id i192mr27860872ioi.222.1493697682243;
        Mon, 01 May 2017 21:01:22 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:21 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 3/6] rebase -i: add short command-name in --autosquash
Date:   Tue,  2 May 2017 00:00:45 -0400
Message-Id: <20170502040048.9065-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

teach `git rebase -i` to recognise short command-names when using the
'--autosquash' option. This allows commit with titles beginning with
"s! ..." and "f! ..." to be treated the same way as "squash! ..." and
"fixup! ..." respectively.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/git-rebase.txt | 2 ++
 git-rebase--interactive.sh   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 53f4e144444a..3e49d8b046ca 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -437,6 +437,8 @@ without an explicit `--interactive`.
 	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
 	"fixup! " or "squash! " after the first, in case you referred to an
 	earlier fixup/squash with `git commit --fixup/--squash`.
+	Note that their short counterparts, namely "s! ..." and "f! ..."
+	behave the same way.
 +
 This option is only valid when the `--interactive` option is used.
 +
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4fa621062cdf..61450064c5c4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -790,7 +790,7 @@ rearrange_squash () {
 	do
 		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
 		case "$message" in
-		"squash! "*|"fixup! "*)
+		"squash! "*|"s! "*|"fixup! "*|"f! "*)
 			action="${message%%!*}"
 			rest=$message
 			prefix=
@@ -798,7 +798,7 @@ rearrange_squash () {
 			while :
 			do
 				case "$rest" in
-				"squash! "*|"fixup! "*)
+				"squash! "*|"s! "*|"fixup! "*|"f! "*)
 					prefix="$prefix${rest%%!*},"
 					rest="${rest#*! }"
 					;;
-- 
2.9.3

