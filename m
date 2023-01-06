Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6650C6379F
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjAFUhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjAFUgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C605C09
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m7so2347810wrn.10
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=KeKDSqisfxKZd4BVngSHCJnSKqJhF0u88n/Fbap/saTgPxPexumr75gB8Ju+UIHGbu
         +2hwWtkS5rFm9Tl/Vc4Kxnsj9VWGeje6hFC9u/kwFSFC4FoMCIq0kjXkF8bXAixQDebz
         bX0+mZkN+Tck6cBnO4/mbcZzFG5qr4lHmtBcUoA8oCsJ/rJ+ZGmBPW08zMEiaMHC8cii
         bGi6KIyPx832Vi9oJMMln+2ENd6tAuIeRpy17wpAfBasn8JMEq+ao+iNCftp/VNjg/sb
         iHt/U+AX4rkDpb7NjfQtKcQ/JUV/ThR0c7BA2TRc86FBAwxrnKYLU8XQDbqUAxAbfD8H
         Mg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNFrRUzAOuNSF8t1leDfh9Tj6xawIPV4QkdV6yQMg+U=;
        b=u4WenS4wLpHo0LydX8aAqENhghF0YOFApiHhQCLf3jwmj/B7YlwwIZwr+ISzSVsecy
         DWC5iSBTrTKIaalZGIByNnXoEW3MSdkNdmRK21eMacqUUp8NOpILljB45D/53cNh6w/W
         1e6NNPS7shDBy0q+vs2/OkZxN66onX4F17r6PJxkzI+ar/F9I1WKWX6US9ug9VL+TtEi
         39uirervLDQcMiHRaXXDnjtToo/vh4l1/LHnEoE8Ei1mYWe2eKKaVOnbizGoFRwkhPha
         EdLDDWcaYnuNKAVJFGz2ITJRpd1evR5DLvGubYmZUs6sBSPgboKJ5YDcjgr3s1df5u/i
         Gfdw==
X-Gm-Message-State: AFqh2kpvoBdMXPB0VQqKsq/zU6Bq30E2GitZLoF/KMueCOFPLeFoMJvj
        AIsQqjcRd+hVriUL+TpaNqMszCPhC3o=
X-Google-Smtp-Source: AMrXdXtJ8Xq6q/UzINg6CRiIcb6DdWOJzjr6SVSaLP/3TBtJzYBV5cf2BMGdv33IyJnlM7r6xyCv5A==
X-Received: by 2002:a5d:54ce:0:b0:242:8bc1:fa08 with SMTP id x14-20020a5d54ce000000b002428bc1fa08mr32879054wrv.27.1673037411949;
        Fri, 06 Jan 2023 12:36:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002423dc3b1a9sm2030635wrm.52.2023.01.06.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:51 -0800 (PST)
Message-Id: <afcfd27a883d16009a2c55c3dcfb5ade07132b50.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:43 +0000
Subject: [PATCH 6/8] bundle-uri: drop bundle.flag from design doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Implementation Plan section lists a 'bundle.flag' option that is not
documented anywhere else. What is documented elsewhere in the document
and implemented by previous changes is the 'bundle.heuristic' config
key. For now, a heuristic is required to indicate that a bundle list is
organized for use during 'git fetch', and it is also sufficient for all
existing designs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-uri.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index b78d01d9adf..91d3a13e327 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -479,14 +479,14 @@ outline for submitting these features:
    (This choice is an opt-in via a config option and a command-line
    option.)
 
-4. Allow the client to understand the `bundle.flag=forFetch` configuration
+4. Allow the client to understand the `bundle.heuristic` configuration key
    and the `bundle.<id>.creationToken` heuristic. When `git clone`
-   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
-   client repository to check that bundle URI during later `git fetch <remote>`
+   discovers a bundle URI with `bundle.heuristic`, it configures the client
+   repository to check that bundle URI during later `git fetch <remote>`
    commands.
 
 5. Allow clients to discover bundle URIs during `git fetch` and configure
-   a bundle URI for later fetches if `bundle.flag=forFetch`.
+   a bundle URI for later fetches if `bundle.heuristic` is set.
 
 6. Implement the "inspect headers" heuristic to reduce data downloads when
    the `bundle.<id>.creationToken` heuristic is not available.
-- 
gitgitgadget

