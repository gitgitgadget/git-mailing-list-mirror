Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05BC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 07:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDRHAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDRHAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 03:00:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94BFCD
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:00:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38e3228d120so147002b6e.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801251; x=1684393251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaXw7d2ZnHKqqFaO1i03/8UvcTqehcN+SPuS0uzqTwc=;
        b=ExghFEwAJxeY/za/YU/S9GSet8YUdiIUOAQD4xOV4mMqN7HqDI/+Q+/hhJBSCS2zDM
         kbxrCZTkwHdd8mvyOhprvJ5IQcssapFkcpHg8Aebbby64+Z8YYYk62pVFteYhmc+i62X
         iW9AsNr8e3Z/bDt3APnZGuPilInACIAKw2DWW/lBPP/tMbYvqq3u8DS2UdkQj4dwkld9
         8/mtnq2B1pPLx0elZFK+TTSCwWjaG1KI6o01sj7NZ9yQSk8NVkEub8H7Vw7C44tJdiQE
         n+Nxpq1V/yGwvZUgqewA2KMU8RFDymcL+RgH23arAVkNAaPY4A0OhDP93QFqIp0dLdkT
         NWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801251; x=1684393251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaXw7d2ZnHKqqFaO1i03/8UvcTqehcN+SPuS0uzqTwc=;
        b=Bvkx8vAgKknNf1VcCGTWQuU3H+ZtkZ3dAxGeDfZPyWTCykDJV11JkY9MZ4OEqLFzfK
         eZnkQWG+CC2CNTZ/NwrmEugG7gObhNA1O1lTpSYcZmWXeHwoADT35kd8B0B9ahBclFju
         bIaQpSDZRVDnM8N+n8aRUn9TGKth7Pl0R43fOFqX5Pn4LasGJBUUEpF2TNfHMYeegwLQ
         ohyB5d6aHmDTWv7cty3L4isJnNr4kITHcCq9OjjfXAmKpUC/CZ/u+uJKaxDLJY235XUT
         jGreznTmCPw8ER+iSYTdAS1hJjwQJASKf82MCg0MCVCegXYFnLdt8BewasCKxfj4zpXp
         mhgA==
X-Gm-Message-State: AAQBX9frUNtr5WgLS/6yMYoWysNmcJ9+XfbJf3801sbA+fa2Q+dsrq4H
        WgFMdqgMv8Lqu6Q0KD93rJjw1k78jUI=
X-Google-Smtp-Source: AKy350bDRrri1eV5YZtbMBpyTqPPKswkcpWD3dST4wltdSl4d7Ws0/Ej0+A49Oa0nwvAS7lOQ3zwfg==
X-Received: by 2002:a05:6808:30a1:b0:38d:ec3f:311a with SMTP id bl33-20020a05680830a100b0038dec3f311amr563714oib.2.1681801251763;
        Tue, 18 Apr 2023 00:00:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s6-20020acadb06000000b00383eaf88e75sm5580961oig.39.2023.04.18.00.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:00:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Date:   Tue, 18 Apr 2023 01:00:47 -0600
Message-Id: <20230418070048.2209469-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230418070048.2209469-1-felipe.contreras@gmail.com>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callouts are directly tied to the listing above, remove spaces to
make it clear they are one and the same.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 6bb32ab460..8ddeec63dd 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -483,14 +483,11 @@ $ git checkout -b foo  # or "git switch -c foo"  <1>
 $ git branch foo                                 <2>
 $ git tag foo                                    <3>
 ------------
-
 <1> creates a new branch `foo`, which refers to commit `f`, and then
     updates `HEAD` to refer to branch `foo`. In other words, we'll no longer
     be in detached `HEAD` state after this command.
-
 <2> similarly creates a new branch `foo`, which refers to commit `f`,
     but leaves `HEAD` detached.
-
 <3> creates a new tag `foo`, which refers to commit `f`,
     leaving `HEAD` detached.
 
@@ -529,7 +526,6 @@ $ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
 $ git checkout hello.c            <3>
 ------------
-+
 <1> switch branch
 <2> take a file out of another commit
 <3> restore `hello.c` from the index
-- 
2.40.0+fc1

