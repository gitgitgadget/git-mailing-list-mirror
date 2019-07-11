Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB00F1F4B6
	for <e@80x24.org>; Thu, 11 Jul 2019 18:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfGKSHU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:07:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41842 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKSHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:07:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so6779151ota.8
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T5HgDcmCmGFRLPxSmjAeyz1noFR9+xePQ7dovYxMi2s=;
        b=FdDlAg0XvdBpg6gZzK3+9bX+F1+qQdkaz47MxovO0i4SW4Mpt4CESzQis2bK1l3+/K
         OqUDQ9/7aTtpymwpuXbB/CDvojyRbGBwAXBR434aMReMT7g1oJXi0N5KlR08GaQjaEKG
         gujkUe3xyfBOHvRdWyoHBjI+xHhjtXzTBqjbkycpyErud1La4fkAYJLEYcvqrkc8YK5h
         vGLWEKxs5ZkF4i054ndDx+A8oNOgAWrusw17tXgbuUloCtN7evcSHkUSAL8g04X0G0ar
         IqjAbstEqKvZU1Mi/iZgV6lvjUnp4Ml+IK/0sLrLwxG3sym/8kyR3Hk1oOfWEzzu9rJO
         i/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T5HgDcmCmGFRLPxSmjAeyz1noFR9+xePQ7dovYxMi2s=;
        b=Cl2JzWlPEiaV9qIU+3krgWxaVc/Cu4pVGoPY5822sFKPzs8MK26czvbmRqO00aI+9Q
         21ijcCki6/ciYh1u/5CLbVAewkz8pP0wWC0AABBhXejZaPeslkGhhAekG20nQ2CO/g6Q
         aR/Mznfcq1xNTwKgwuViVNmIHsvxT630zRwXM9s1w3Re9LZeGX3FwsvonQ4Uf2kMx4aY
         8/2UprqrunR4mcfK0T3Byhmw+UTpswon8UVxMRERR10Y/cxgzdFNKJeT8pdggYhLoTqE
         2OFoTewW9kJF1WNF3txGx521kO1VwZlBHxP3l30BZzyqANFsFbZyGKrieVWCLUPr7SiO
         a6cw==
X-Gm-Message-State: APjAAAVKDgIe/5upVyK3VZvK5nNmegjHmy4Z7eAVkyfpF1VDNP5brIOO
        tjxKx9p+Qw1gYd9QmqBFDE/ekwzs
X-Google-Smtp-Source: APXvYqyERePZS08kfwN3LXbrP3vMgPKnsTI6qWqsoqfa7iNiigf1aeHnEGPRXP4heGcGfqwqNbkylw==
X-Received: by 2002:a9d:61c7:: with SMTP id h7mr4148425otk.357.1562868438782;
        Thu, 11 Jul 2019 11:07:18 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id 132sm2131545oid.47.2019.07.11.11.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:07:18 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 3/3] tests: rework mailmap tests for git log
Date:   Thu, 11 Jul 2019 13:06:44 -0500
Message-Id: <20190711180644.30417-4-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711180644.30417-1-ariadne@dereferenced.org>
References: <20190711180644.30417-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to prove that the --no-use-mailmap option works as expected,
we add a test for it which runs with -c log.mailmap=true to ensure that
the option successfully negates the configured default.

Additionally, since --use-mailmap is now the default behaviour, we
remove mentions of --use-mailmap from the tests, since they are
redundant.  We also rework some tests to explicitly define the
log.mailmap variable in both true and false states.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 t/t4203-mailmap.sh | 49 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..3d6086ff96 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -422,8 +422,8 @@ Author: Some Dude <some@dude.xx>
 Author: A U Thor <author@example.com>
 EOF
 
-test_expect_success 'Log output with --use-mailmap' '
-	git log --use-mailmap | grep Author >actual &&
+test_expect_success 'Log output with mailmap enabled (default)' '
+	git log | grep Author >actual &&
 	test_cmp expect actual
 '
 
@@ -437,18 +437,33 @@ Author: Some Dude <some@dude.xx>
 Author: A U Thor <author@example.com>
 EOF
 
-test_expect_success 'Log output with log.mailmap' '
+test_expect_success 'Log output with log.mailmap enabled in config' '
 	git -c log.mailmap=True log | grep Author >actual &&
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Author: CTO <cto@coompany.xx>
+Author: claus <me@company.xx>
+Author: santa <me@company.xx>
+Author: nick2 <nick2@company.xx>
+Author: nick2 <bugs@company.xx>
+Author: nick1 <bugs@company.xx>
+Author: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'Log output with log.mailmap disabled in config' '
+	git -c log.mailmap=False log | grep Author >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<\EOF
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 EOF
 
-test_expect_success 'Grep author with --use-mailmap' '
-	git log --use-mailmap --author Santa | grep Author >actual &&
+test_expect_success 'Grep author with mailmap enabled (default)' '
+	git log --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
 cat >expect <<\EOF
@@ -456,16 +471,34 @@ Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 EOF
 
-test_expect_success 'Grep author with log.mailmap' '
+test_expect_success 'Grep author with log.mailmap enabled' '
 	git -c log.mailmap=True log --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'Only grep replaced author with --use-mailmap' '
-	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
+test_expect_success 'Grep author with log.mailmap disabled' '
+	git -c log.mailmap=False log --author "<santa.claus@northpole.xx>" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'Grep author with --no-use-mailmap' '
+	git log --no-use-mailmap --author "<santa.claus@northpole.xx>" >actual &&
 	test_must_be_empty actual
 '
 
+test_expect_success 'Only grep replaced author with mailmap enabled' '
+	git log --author "<cto@coompany.xx>" >actual &&
+	test_must_be_empty actual
+'
+cat >expect <<\EOF
+Author: santa <me@company.xx>
+EOF
+
+test_expect_success 'Grep author with --no-use-mailmap + log.mailmap=True' '
+	git -c log.mailmap=True log --no-use-mailmap --author santa | grep Author >actual &&
+	test_cmp expect actual
+'
+
 # git blame
 cat >expect <<\EOF
 ^OBJI (A U Thor     DATE 1) one
-- 
2.17.1

