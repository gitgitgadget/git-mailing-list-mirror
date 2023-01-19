Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2BEC00A5A
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjASRMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASRMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:12:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D14F368
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:12:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d8so3025921pjc.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ZhBq8cE82eQMcdSJ9I6skLw9RF4ltC7IjpYAr3DpXU=;
        b=JIy7awbNppvalYqvGdeTYTAKLTMu0khYkTM30Wwg/2KoLqUc5+ZYFuFO4+t3RFNzOV
         QlAf6jwsF19RrvRcq6OIwgQWlHK1z45YwVh1SddzNdFRz4TXATt+fwcoZZyQrLeLU5Hq
         OQUT+7JgvfGDWBqAFvszuTXsg3AVQc2ckUSBvaxT8e4XY6leqt1EXgJs0wzVNKbfd3xz
         tXe9IjSyIDOWO6qkMEJ0MHmiEMtEPcDkcOBf4+b5IDD6bK+4vx0g5bMkQQlyL2gmiTFd
         7aSQ6NOFK6/r0J9ivsbIIGkUBlL1rg89OkRSpS2w/ukQuCyBtHzr8TE0pZRH2a7zKmKE
         JFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZhBq8cE82eQMcdSJ9I6skLw9RF4ltC7IjpYAr3DpXU=;
        b=aQc6RbbDH3fhAlX5X8B0LZb77piPlgTLYDW3V91A9x1TUWJlT1txfsCRXp3aO6TUHm
         xTpibf0ULvS4qij5MQQrxSDOEcRZE1Ik4C7mkV6ZRPiKsoamWY2UgSR9pivJG4qBZSbh
         e1PuQYROEtwxIXD/cSagAAxAqZsNfGZCOIj+ykc4io8E9DN1xveJSdwsiyOxaoK6KCjG
         723quvbWQH1YpX4kDcdVNJgB3FBTvOcYv29z2a2+1mk+YptImn5dtjPOSbA3uqMX1Q4m
         t/no6ZXNoJpG2+3Ny+jjxq+wPCsK356hL9/XXOeFAyPb9UlUhpWyGLHj6KL/56JRJM6D
         PXgw==
X-Gm-Message-State: AFqh2krcRkrDBECXkunuwypAmKqZCm3WKM0Y4ds76JQ3b1LTcEl7u0Mf
        AqalP+K5O+NzRM3uPck2uPB4qKy++sI=
X-Google-Smtp-Source: AMrXdXsrDKMZe1c5zrY6hPH0zjlIqji/WRIiuH5DqIYsBy5RB4Ql06iT+JFlXJ9vzyKGS6rzQG+wlQ==
X-Received: by 2002:a17:902:9b8b:b0:194:812b:6737 with SMTP id y11-20020a1709029b8b00b00194812b6737mr12569965plp.23.1674148361602;
        Thu, 19 Jan 2023 09:12:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001745662d568sm95573plo.278.2023.01.19.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:12:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] checkout: document -b/-B to highlight the differences from
 "git branch"
Date:   Thu, 19 Jan 2023 09:12:41 -0800
Message-ID: <xmqqtu0m1m9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing text read as if "git checkout -b/-B name" were
equivalent to "git branch [-f] name", which clearly was not
what we wanted to say.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-checkout.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git i/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index 4cb9d555b4..dcff44196d 100644
--- i/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -146,14 +146,16 @@ on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
 -b <new-branch>::
-	Create a new branch named `<new-branch>` and start it at
-	`<start-point>`; see linkgit:git-branch[1] for details.
+	Create a new branch named `<new-branch>`, start it at
+	`<start-point>`, and check the resulting branch out;
+	see linkgit:git-branch[1] for details.
 
 -B <new-branch>::
-	Creates the branch `<new-branch>` and start it at `<start-point>`;
-	if it already exists, then reset it to `<start-point>`. This is
-	equivalent to running "git branch" with "-f"; see
-	linkgit:git-branch[1] for details.
+	Creates the branch `<new-branch>`, start it at `<start-point>`;
+	if it already exists, then reset it to `<start-point>`. And then
+	check the resulting branch out.  This is equivalent to running
+	"git branch" with "-f" followed by "git checkout" of that branch;
+	see linkgit:git-branch[1] for details.
 
 -t::
 --track[=(direct|inherit)]::
