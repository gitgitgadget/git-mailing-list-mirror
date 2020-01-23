Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C48C33CAF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEAC22464
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJFu8bSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAWP04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:26:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAWP0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 10:26:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so3539468wrh.5
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AF4XPBohCJ/8kZxT4u1C5qNT8jN772TR4+8ICBYljhk=;
        b=nJFu8bSiLOEkOdqcGIAqdCBlW3VquQt9jGP0cOc8+34smVg9+Q0/0VCgB6kkwxhybx
         awAwcPuE80+4GUn8UZEW2gRk1d3OBNUTjV3E3xqQiQKOmnL1FQ22RRTUkFpVSuuqypqY
         spIrPBjx0HflwhdVg2P32RY3cvAoy+g8Ib3lTlIKI5LPWIfZUDhiIPLNouag1070xQ3q
         PcvA6x1uSz3oP8twcE7fjDUiXLV52flNYXnz2fQ/RHsSJPX+4zKZiB7WHO73bXdxaAjt
         PVbCRSU8rfk6+nYSWLus6qyzvd2mpH3kYv1lFisxsu12d4kkBbgfZjHKydBrNXyNzIJ9
         jQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AF4XPBohCJ/8kZxT4u1C5qNT8jN772TR4+8ICBYljhk=;
        b=pH8QQ0Igkl0fSwortv3PBzwOSaloPNpTO99jE61POYkUWdKAyPkd8WTrbtfcKfsnfR
         4n5AmS2dByCNkNxh6hyX6riQwV8ekyN4EheKoxLkFBVZxAB3LGZYlzm0qyBgJZIB8qYI
         bwyyApUwWjpe2vOoCiYz7e08Hz7U6ipOheWoFFH71MQNKRzdYP11jpNnAUivHbG6V7M/
         syTwrFMtRh6iW7WkDNv+QGMjQ7Ji4rO3NfPdOPDtovCtak6uvVbBYIo3EC352Bi3rydL
         2u4f2+8Ca1OyVC9ygzBTsHBJIshzVKL5NCmHhE+gic62Q+p3M+dkybBO8eqmVe0trWbO
         fEyw==
X-Gm-Message-State: APjAAAVy98IszRqB55K4zxDhxrFPrVULoQ9oJuzy79cjylS1ek/4/S3b
        ZNyFovouOgwBnVvKj/ACq2h3amHI
X-Google-Smtp-Source: APXvYqyYlRfYpqCu5hiKgMh/e4/kNQ5lU5km6W88x2L4ZMj2fs6WaFaNCNsZEpK87oTqzReKRsem+w==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr19190971wrn.29.1579793212241;
        Thu, 23 Jan 2020 07:26:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm10292907wmh.3.2020.01.23.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:26:51 -0800 (PST)
Message-Id: <1db2a699ba3749bfb4ab1c048492f76f82830ee6.1579793208.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
        <pull.510.v2.git.1579793207.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 15:26:47 +0000
Subject: [PATCH v2 4/4] fsmonitor: update documentation for hook version and
 watchman hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
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
