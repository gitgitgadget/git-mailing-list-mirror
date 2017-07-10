Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213B12035B
	for <e@80x24.org>; Mon, 10 Jul 2017 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbdGJXfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:35:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34343 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754832AbdGJXff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 19:35:35 -0400
Received: by mail-pf0-f179.google.com with SMTP id q85so57286529pfq.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=90G1NzGOwFdzZ3j63XxqbnaraLYBqKknnZZBWMmVtBQ=;
        b=ZpoVTfSu4gF+JNbVysO4zPTh0C9OYrmWmQk6AmUMYdGFNPDiCZ8TdIIIs6Zigwog4X
         UhVSH2/Zu1T3AGrmbY+9OhNXEVXCRRXCgSVapTkacw1ymNQ5+Ccc9Gp6kqm2BLXmgXON
         y+x1Mp69XWFa2wc4ScyDwg3fAJL8wgrJywW6L1QMc+7pE+LNYPrDWjAE+ie0T45WYOT9
         Y6jKutfYwJov8mQQ/t1j1Xk1oxiq0pwpLNXY6scDR9IyvsnYtyPz0qEEz9tsEU+vVzwb
         1CT6QLbDB1FjZ9l/VoTu6IBHWgDGt3mNEMyUJxg4Tpj7xB+Va6fLemOk2ii+T012W98S
         wu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=90G1NzGOwFdzZ3j63XxqbnaraLYBqKknnZZBWMmVtBQ=;
        b=ZTInpBT2E5raz2OETb2+NJI5uN8wALr/Ol0NG4YHL/p6lTQyT+ylvcrzen3q5O2Q1F
         jVJj7Hyjt91ch9OcPJo3+3xpIp3jQmD2BZ0L0VBWM/jedrh5FKWzAcwImdYBZDzScOTV
         e6s/5tPhjnsN/JMvHxUW1EMhsNUtUxw1jPspLUzfI6jiy0B2v/HMDgQk8rzYZdkW4PZJ
         pMfL7pL0ufJRlS0FoIcFimR54taJJ/Pbjpvg47nds/bKl8bOSEc0xwfvgJTWPNiWf3TV
         gKU+Q1wjDOgKmAINxaTCyPVD/eqAH3BlVMurgu3z0cr0NHGGwVbw6YqnuDYHuti9OOPP
         MXaw==
X-Gm-Message-State: AIVw112+WGwwXx+CXYPgExg4MmuxHaQ5gapPFMS8A6AQZMqyE+lt4tsX
        vvi4Tlwyku3JasPN
X-Received: by 10.84.229.71 with SMTP id d7mr20715875pln.231.1499729734423;
        Mon, 10 Jul 2017 16:35:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc2a:f1e8:36c9:e743])
        by smtp.gmail.com with ESMTPSA id l4sm20524255pgr.21.2017.07.10.16.35.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 16:35:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: pre-rebase hook: capture documentation in a <<here document
Date:   Mon, 10 Jul 2017 16:35:25 -0700
Message-Id: <20170710233525.11650-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.2.725.g09c95d1e9-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Without this change, the sample hook does not pass a syntax check
(sh -n):

  $ sh -n hooks--pre-rebase.sample
  hooks--pre-rebase.sample: line 101: syntax error near unexpected token `('
  hooks--pre-rebase.sample: line 101: `   merged into it again (either directly or indirectly).'

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio wrote in "What's-cooking":

> ... I do not know how well they are tested
> in the field by people using 'master' in their everyday workflow.
> Ideally, our release process wants to see more people using 'next'
> in their everyday workflow to keep 'master' more stable than any
> tagged release, but I do not have a good idea on how to encourage
> it more than we currently do.

Our internal release of git @ Google is debian experimental,
which is basically the 'next' branch + this patch + another patch.

AFAICT It is a resend of
https://public-inbox.org/git/20120308122105.GA1562@burratino/

As Jonathan is a Debian Developer, it is easy for us to base
our internal version onto debian experimental, but long term we may
want to base our internal version on the original next. :)
To do so, upstream this one last meaningful patch.

The 'another patch' from above is changing and hardcoding
the version number, which we do not want to upstream.

Thanks,
Stefan


 templates/hooks--pre-rebase.sample | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index 053f111..b7f81c1 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -88,9 +88,7 @@ else
 	exit 1
 fi
 
-exit 0
-
-################################################################
+<<\DOC_END
 
 This sample hook safeguards topic branches that have been
 published from being rewound.
@@ -167,3 +165,5 @@ To compute (2):
 	git rev-list master..topic
 
 	if this is empty, it is fully merged to "master".
+
+DOC_END
-- 
1.8.5.3

