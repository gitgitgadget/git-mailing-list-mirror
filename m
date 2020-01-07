Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FFC33CA1
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137E2081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpIaORLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAGTEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:04:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39027 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgAGTEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:04:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so493835eds.6
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AF4XPBohCJ/8kZxT4u1C5qNT8jN772TR4+8ICBYljhk=;
        b=TpIaORLUTw+9bQpGUgAxfONl1bPSbkpm3VIhHyIDRfuXfCfRbCYomYrxmTcwmpyhTi
         EZjYae//JRuqJejD6JaShTgq8DsXw9aX5tu8Q29nNxbz4VutnCkPs0sfmrEHN+jUFNOo
         FXG963cppPuSdfNm9RUrP/pndkqPjUztiDq8IK6/YnkK4Dhi7NzMmZDPHmDwoqm0qLMs
         sRoeIQ9w3kKCW3BudSi3GYNh7aWnqU52789ZrcsSgt1qzQWahi65h1aQQpxX9PHmp03F
         fCcqpvTmHi2jL+euqNJf26eQI9IzL0+ZZNNl7Lj2v8EyDTTlc95CIN1tHcwSEEaTUirD
         746A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AF4XPBohCJ/8kZxT4u1C5qNT8jN772TR4+8ICBYljhk=;
        b=jVhodQXhz2XkqMRMPw2IaHt5DapVSwztgLwmeeVXKw0RU5vZffbmtY36nKLrrQshmz
         auTXqz3LA40HWzXh74ODZ4NSIAv1QA4mHkj8YXvh9xBFUKsQIggaw9k/uLJ4OFLP6N0i
         ybgPP141C49niOT4doF+K0PlUiiew+8tzPo8J76fIgLRRlE35XGkbUclVNdWEbQHkglj
         6C2zyG9WibJLD87295UB1faU8hU+mqGVA4fgfKeaONUidyqAHOWQ+xryUJhM7o1CIk6j
         qUROw+G/C/qqT5+CTxbHKHiK7mVKn2f7Z3OlZNiy6S3WuKRVHcFp3NSR0mcwMhshBOhC
         5wcg==
X-Gm-Message-State: APjAAAXRmeuMkELaliJ4r+0ZqGqM13QZfFwE7vAFfaX48WQDPizbxhHN
        +WXj1QWKaCJRUnkh13p1ZgIQNEJ/
X-Google-Smtp-Source: APXvYqzgzNLKf92VTXD1gn+Cdj9EBK2BMj18p+cr7+OrztD7MHABzJTxXxjnPffv/qtG3W0Wr3HsfA==
X-Received: by 2002:a17:906:bb0c:: with SMTP id jz12mr886163ejb.298.1578423875681;
        Tue, 07 Jan 2020 11:04:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm19259edw.73.2020.01.07.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:04:35 -0800 (PST)
Message-Id: <8d381b7d44c431328a44f53ba1e59271e8720d94.1578423871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.git.1578423871.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 19:04:31 +0000
Subject: [PATCH 4/4] fsmonitor: update documentation for hook version and
 watchman hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

A new config value for core.fsmonitorHookVersion was added to be able
to force the version of the fsmonitor hook.  Possible values are 1 or 2.
When this is not set the code will use a value of -1 and attempt to use
version 2 of the hook first and if that fails will attempt version 1.

Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
---
 Documentation/config/core.txt | 11 +++++++++++
 Documentation/githooks.txt    | 13 ++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 9e440b160d..74619a9c03 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -68,6 +68,17 @@ core.fsmonitor::
 	avoiding unnecessary processing of files that have not changed.
 	See the "fsmonitor-watchman" section of linkgit:githooks[5].
 
+core.fsmonitorHookVersion::
+	Sets the version of hook that is to be used when calling fsmonitor.
+	There are currently versions 1 and 2. When this is not set,
+	version 2 will be tried first and if it fails then version 1
+	will be tried. Version 1 uses a timestamp as input to determine
+	which files have changes since that time but some monitors
+	like watchman have race conditions when used with a timestamp.
+	Version 2 uses an opaque string so that the monitor can return
+	something that can be used to determine what files have changed
+	without race conditions.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 50365f2914..3dccab5375 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -490,9 +490,16 @@ fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
 This hook is invoked when the configuration option `core.fsmonitor` is
-set to `.git/hooks/fsmonitor-watchman`.  It takes two arguments, a version
-(currently 1) and the time in elapsed nanoseconds since midnight,
-January 1, 1970.
+set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
+depending on the version of the hook to use.
+
+Version 1 takes two arguments, a version (1) and the time in elapsed
+nanoseconds since midnight, January 1, 1970.
+
+Version 2 takes two arguments, a version (2) and a token that is used
+for identifying changes since the token. For watchman this would be
+a clock id. This version must output to stdout the new token followed
+by a NUL before the list of files.
 
 The hook should output to stdout the list of all files in the working
 directory that may have changed since the requested time.  The logic
-- 
gitgitgadget
