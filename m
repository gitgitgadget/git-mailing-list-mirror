Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747731FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbdCaX4a (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:56:30 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34435 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbdCaX43 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:56:29 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so84407167pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8dJJCBitFwTcM2knOQWS5d/taggulwidDxv9tj2SgQ=;
        b=rdjsgTkY4WNg/KT9yEigbX+DI/bRzPnJ3aCyJ8h4Y9qEmj11bYqEb+Pskvj6czRTS9
         xue9MG1y9O1r32E+c0pz8dx+oEgqTEmjlTuFC81i7e8neTSxxsGsRBms0nOUy8BOH5Ra
         rOWjvYLUxvJeNLUYq+Ig7Vttl75Bsa7SVjxQ3wOSvfckyY7dvQjWIML2xyUuBFSdxBBC
         0SE+xK7w/dbK4mMPmdk5A8GuS8o7LQ368SHtmUs//uICBbjrsCqN6jZ40gQtzO8HgSNQ
         2VSeYsQYwrui0DaQA8Owv2+NUYEnsRljfxqjtq1TVnMM10o7pzeqGQRR5zTCynslzlyv
         HtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8dJJCBitFwTcM2knOQWS5d/taggulwidDxv9tj2SgQ=;
        b=Oi9qL16jVrHkv6VGWlg4r2nURcBZDBXWqDcLvSKp4o1EyYAotfEwH53Kp0ghzuuK44
         cDC+1ZtNruljIx49wBXkoiNl0XjPL4LUBwqvWYJNC6YO44sVjo5IYlw5gpCHf7n9Qrwk
         eiEthb40li7J6vVB8Zn/cxy7X6vWH1Ma190lXDAmG2aVNYtzv2akh5EJw0OSt5o9nfU4
         s49SYqV8Lpdt/1lDWS+W4DpCQ9JAM8tB9Gjg4aHzd21svuqX0adLIW6pXfL2nJ6EWZhl
         kcZN1wYypGkW59TbD/LLv1NexOef0q/pNmNNltkGIvPQlfapmawof2eK2dNIUah8XLpd
         7aQA==
X-Gm-Message-State: AFeK/H1V88AxT87BuqN5jiu2H1K+J2KWffwNI9xS+k3XhH+AEXuvz/cCy/acUyJ9Av1q10M5
X-Received: by 10.98.79.65 with SMTP id d62mr4764261pfb.64.1491004589247;
        Fri, 31 Mar 2017 16:56:29 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x22sm12504643pfi.35.2017.03.31.16.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:56:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 1/2] push: unmark a local variable as static
Date:   Fri, 31 Mar 2017 16:56:22 -0700
Message-Id: <20170331235623.166408-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.564.g063fe858b8-goog
In-Reply-To: <20170331235623.166408-1-bmwill@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There isn't any obvious reason for the 'struct string_list push_options'
and 'struct string_list_item *item' to be marked as static, so unmark
them as being static.  Also, clear the push_options string_list to
prevent memory leaking.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e..a597759d8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -510,8 +510,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
-	static struct string_list push_options = STRING_LIST_INIT_DUP;
-	static struct string_list_item *item;
+	struct string_list push_options = STRING_LIST_INIT_DUP;
+	const struct string_list_item *item;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -584,6 +584,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			die(_("push options must not have new line characters"));
 
 	rc = do_push(repo, flags, &push_options);
+	string_list_clear(&push_options, 0);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
-- 
2.12.2.564.g063fe858b8-goog

