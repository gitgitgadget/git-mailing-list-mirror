Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096FEC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E7E21D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjxHhnqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgIYUnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgIYUnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:43:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E969C0613DB
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:17:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so4115224pfn.8
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPwTwWMciFNQr44DivoHLlHcCa0IGFUr45AEmnt6fZM=;
        b=gjxHhnquxnuIs4gr5cbwFo2G4b72dis/Dl7kGy727JhPeEpeVB8x4py4MA/kxzjiPG
         zyeh5GtZmbNbtuI+d6JC5HUXcpR1+dgK0qs589vMeyv6ZFSGi1YuGEFrl2EaCv9DjGB5
         XtBmxUK5hK5i5u6MVhbVcPnmRIKciKuNw5UjfCuBZU9F07SLEVAc3WRCuZd/IJTNN05D
         tY27H8uKRdRI9Fxcqj/7yNmWoEHri/sPJ+mG0zXZP/U6LE7mdpBHTAdlRNiFi2+F/JSR
         e6ALq7zRUObK3n/9koLeNncAzFOV4D3JDyEnc6LCcP3sKt3l7IGqPry/AbbtBuBDBe4q
         42sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPwTwWMciFNQr44DivoHLlHcCa0IGFUr45AEmnt6fZM=;
        b=nmLzdVwtZ1OJxjKEexX8zzDwEFRdxD1AybKGWWLO6M20dneQklULvfdCBfCXE9MsGC
         tQu9XAOyg05+BcoiQ48pZu1UOfxc+B79UWOSCkih7r1WJzBlb783d/fdvynnWxq2M472
         IUWL9OzFtg370W6IVFUtq4d7uW1dPxdq+4M83Gfk1SeDNfqxweKLzDx73eXlOQyDCE9a
         XFWQZRfzvdXyO1Jnhm/uBcSEbleDPBz4O4XdHhweOvJLSClUgkN5mFKsvC4vl0e5FG3D
         SHzsBFFxR6tVZei5tUeRD/swlNIQwe32CLTae3Y34kV/nJUleSQ4FCLKqRudYtDlGbpM
         MErA==
X-Gm-Message-State: AOAM531H5SnWRo0RFOPev+fv08LUPs2PfeGti4ryXh/qLEk1tRQnWuA/
        Jk73ivL9SLcs02aWGZekzc7zaROuDI/eJA==
X-Google-Smtp-Source: ABdhPJz6G43o87xa0N5aWbz4phxhevMTyU7Wun7D37ez9oOMbtpQ7pexw4rncqh4gE0pDTrRQbzYcQ==
X-Received: by 2002:aa7:8612:0:b029:142:2501:3967 with SMTP id p18-20020aa786120000b029014225013967mr702345pfn.44.1601061420380;
        Fri, 25 Sep 2020 12:17:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-93-247-186.natsow.res.rr.com. [70.93.247.186])
        by smtp.gmail.com with ESMTPSA id i73sm3309131pfe.67.2020.09.25.12.16.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:16:59 -0700 (PDT)
From:   Evan Gates <evan.gates@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Doc: note minimum scissors line length for mailinfo
Date:   Fri, 25 Sep 2020 12:16:59 -0700
Message-Id: <20200925191659.31375-1-evan.gates@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a comment in is_scissors_line describing the requirements for
a line to be considered a scissors line.  While the existing wording
covers most of the requirements, there was no mention of minimum size.

Signed-off-by: Evan Gates <evan.gates@gmail.com>
---
This comes up after I tried to use --8<-- as scissors but git am didn't
recognize it because it's only 6 bytes.  I couldn't figure out why until
I cloned git and checked the source.

I am not subscribed to the list, please cc me in any replies.

 Documentation/git-mailinfo.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3bbc731f67..859829d32f 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -74,11 +74,11 @@ conversion, even with this flag.
 --scissors::
 	Remove everything in body before a scissors line.  A line that
 	mainly consists of scissors (either ">8" or "8<") and perforation
-	(dash "-") marks is called a scissors line, and is used to request
-	the reader to cut the message at that line.  If such a line
-	appears in the body of the message before the patch, everything
-	before it (including the scissors line itself) is ignored when
-	this option is used.
+	(dash "-") marks and is at least 8 bytes long ("-- >8 --") is
+	called a scissors line, and is used to request the reader to cut
+	the message at that line.  If such a line appears in the body
+	of the message before the patch, everything before it (including
+	the scissors line itself) is ignored when this option is used.
 +
 This is useful if you want to begin your message in a discussion thread
 with comments and suggestions on the message you are responding to, and to
-- 
2.28.0

