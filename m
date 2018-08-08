Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B411F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeHHWLu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:11:50 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:57556 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeHHWLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:11:50 -0400
Received: by mail-it0-f74.google.com with SMTP id e6-v6so3517961itc.7
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q2yLM+0utUalT4EYFhCewwc6abKAVJVNZmqG0RlRM+I=;
        b=lvOoComh1ze8bwAlUoN0aPRMw3B6dQFb4hM71668J2q94/Vh4X0RqO3fGZVvcNcJU0
         t/6mQD80AvUYbrGK+U++gKzTa96N/zbf0Bd5ICPnA13Tzq3vC+M6o6gW2Ca+gyApB5ks
         PiKb5hPaGbf9qTKk/14IurtBUvNVZkoWwArnqe9sSftyTyLbjax7X/P8ZJSO/PUq2jo9
         VZqpUJFuGMcnXkgqjtuDo2zomMSj4DcpSJbPC0IOF0gDOhrH2i+vGn34te3RzuMr8C+Y
         vSBJh4uM5B4AE6jxsBlPSnUQe9LUX8+b/AozpuoqeihM+0ohrkqwY4kAdshhUija3KJm
         84+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q2yLM+0utUalT4EYFhCewwc6abKAVJVNZmqG0RlRM+I=;
        b=nylog0t3gZcY1TkfNusCv5OtuIdobOAO94esNmiEt7jxz4rMdVzNCbndhX0qbtxxH+
         tyzquXRvsfuWx30KAvcSq7fGDr7RbJlx1mA+J7MscgPQ4h9a2Kf2MQm/3O6kn28qbgBl
         hqVjnRZdsQrTCD/CcJvula3fMVsB5Zp1mp+lyRwjX1bOFh7+TomuL50HdZC5oup4+75U
         jSmRy0HDFhW73BDsCbsAC8LePyi8JyQcy9XffE6XpQjpzBdB1G2PdWewfRrWA7G6Xz1l
         lqbLLI8bRW4phVJMb2E9FvvyP8qF4u9Z7O4w+5eLGBq47htO/x04N13bsvo1srZIvaLy
         iUgQ==
X-Gm-Message-State: AOUpUlE0v/aKJcyZsCoWlDqLt7QaQou7SL3eX31qx2QLk/WVOmfAYbJy
        4fye+Y0FGdIi51sFcpkCipFfa/Fd0bYc
X-Google-Smtp-Source: AA+uWPxDbSaIl8cveyZ/h3mAKwEx/bdyxsQ1eRpYz7ZlwdEo95wjFPCRLFqRuJZOszQChlnNwzkzQeIee/Mt
X-Received: by 2002:a6b:2306:: with SMTP id j6-v6mr1784614ioj.51.1533757837777;
 Wed, 08 Aug 2018 12:50:37 -0700 (PDT)
Date:   Wed,  8 Aug 2018 12:50:20 -0700
In-Reply-To: <20180808195020.37374-1-sbeller@google.com>
Message-Id: <20180808195020.37374-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180808195020.37374-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 3/3] git-config: document accidental multi-line setting in
 deprecated syntax
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bug was noticed when writing the previous patch; a fix for this bug
is not easy though: If we choose to ignore the case of the subsection
(and revert most of the code of the previous patch, just keeping
s/strncasecmp/strcmp/), then we'd introduce new sections using the
new syntax, such that

 --------
   [section.subsection]
     key = value1
 --------

  git config section.Subsection.key value2

would result in

 --------
   [section.subsection]
     key = value1
   [section.Subsection]
     key = value2
 --------

which is even more confusing. A proper fix would replace the first
occurrence of 'key'. As the syntax is deprecated, let's prefer to not
spend time on fixing the behavior and just document it instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-config.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 14da5fc157e..1ac2eab9482 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -430,6 +430,27 @@ http.sslverify false
 
 include::config.txt[]
 
+BUGS
+----
+When using the deprecated `[section.subsection]` syntax, changing a value
+will result in adding a multi-line key instead of a change, if the subsection
+is given with at least one uppercase character. For example when the config
+looks like
+
+--------
+  [section.subsection]
+    key = value1
+--------
+
+and running `git config section.Subsection.key value2` will result in
+
+--------
+  [section.subsection]
+    key = value1
+    key = value2
+--------
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.18.0.597.ga71716f1ad-goog

