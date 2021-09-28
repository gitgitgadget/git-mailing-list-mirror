Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A002C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBD611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbhI1UM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbhI1UMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BCC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w5-20020a654105000000b002692534afceso179479pgp.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nEK0YW4RyngRwSrhB2/a1MiORL8rUO3dHHdC1i3zZNE=;
        b=J2Bhxl3wybzauM0BFE0AkvHpralOYFMa9Zk70A+mZQ/ydMPFoJk6W8DuuJa3U3KYWd
         LHOCJJeuL5dynFUkH5tOk0iw2sX9Hpp0ttLSviIz4rFJNUlO4MxzLlIGLNX5OsJ9H7Ct
         Viak/iIGZuB6naPj5uI5GN7xyOltiS7BF4yvJ9jcROs7ECoyIuGcMy9u/Rang1cOcNuB
         XiYFhImPq59SFdcYuakLuJ+qVFakHuzQzwzHkvACsPicWHGQ63UvAl6RmCcwp8h+KxL9
         dlFg17TFwErLIVoFIDVzL+ACqnXnPOxUMgds1cSUAKDA/AhDFietqk5JUTip9bRzn2gJ
         VV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nEK0YW4RyngRwSrhB2/a1MiORL8rUO3dHHdC1i3zZNE=;
        b=7bRi0N/a+JCghjCn9p6r0vYtM+p8nCBB5qpsMX7pDYPKThpxeGSyK5mnz0mqtnUsGC
         KmVUncx04jHGm4epnaFB40dIENHx2N1l8uSkQnRxIIhrGFMVMccqitelIzVwiTF1/ZBB
         RS+P0pB3SlDT5nep0UIxn3SZIjZuOmxmIHQaMQBFsQzR46kpHuovgfSlSx/K/7a/Zsm1
         /CI4ETnEQrrngW51HsQVe5yJbkMTcMtWtEdOmztGSlr0yur/ktHVW0O1im91arRKd/S3
         1gxiPYVq6EZS+jlSzAzfQvTgusakbjjB2CvVLTosewkA8eFh7UdBZyZh9Qw9gG+rdwOY
         W4Bg==
X-Gm-Message-State: AOAM532RzC1jFN0FPti7W8TFxmifx5GKtTP7bbpPy7uSCozlY1BTAi0n
        3QaTK9EOLDrX6IIuF24eaSUDls8M1Gj6DMAPKiWpe810TfzajTQ2LXTAunYztgrtfd9J40JJg0u
        d28kF4NeL2zxfrYC1194jEZoXcPnm/NOBvnzNn5HqBPOziK4/BeOumSjL2fJdmNJ0lb08Mr8+zV
        vo
X-Google-Smtp-Source: ABdhPJwpDoiJLebQGutOM5Nr19iXDYfsTAM1xFxCEEuCtOBLheve/1AF61YF6nyPGv3mchaR90rFwPicKBdIZa/bkbIR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:64d6:b0:13e:59fe:8124 with
 SMTP id y22-20020a17090264d600b0013e59fe8124mr1085596pli.89.1632859872642;
 Tue, 28 Sep 2021 13:11:12 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:52 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <9c5ce004b283788763df0e574edcf7f77b166370.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 6/9] object-file: only register submodule ODB if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a35e03dee0 ("submodule: lazily add submodule ODBs as alternates",
2021-09-08), Git was taught to add all known submodule ODBs as
alternates when attempting to read an object that doesn't exist, as a
fallback for when a submodule object is read as if it were in
the_repository. However, this behavior wasn't restricted to happen only
when reading from the_repository. Fix this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index be4f94ecf3..2b988b7c36 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1614,7 +1614,8 @@ static int do_oid_object_info_extended(struct repository *r,
 				break;
 		}
 
-		if (register_all_submodule_odb_as_alternates())
+		if (r == the_repository &&
+		    register_all_submodule_odb_as_alternates())
 			/* We added some alternates; retry */
 			continue;
 
-- 
2.33.0.685.g46640cef36-goog

