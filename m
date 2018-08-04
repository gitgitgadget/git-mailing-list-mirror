Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C386D208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeHDEBy (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 00:01:54 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:46855 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeHDEBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 00:01:53 -0400
Received: by mail-io0-f202.google.com with SMTP id c5-v6so5424797ioi.13
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 19:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kL7/WlhKo9FIrH8goikjIVUsN+qELC/t4o72iPh1RmM=;
        b=ogukJA8+qJ7+j0mdRK5/u/QHnjs3YWGlDN8a72H4+lWPbwrok5NUfRkC7lPbHPTLi+
         AWq0RlYLoNor56WMTduYHVwdA6BWRCXbae8eNM+AUTIGE/qec1TudYV1Lnz6yrhFcJht
         8Oblq7wHdpBkTBnbdnp9+Xm0rilly8SIGvnTK4BFkAc0YrQfBaL32lJpz5cY4vRLmejD
         7NAGZEXC9X2aoxPlhSyvxSVD58a1hH4TdF9PBakhObScuQaNMTntWh8QdolusTRqfjh5
         aYumsnqFAP1Qpj318dXsmL4oy1HpHinJrgNXnNs7+U4CN7PDTYd29K+OjUJSBCUTiJv8
         OK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kL7/WlhKo9FIrH8goikjIVUsN+qELC/t4o72iPh1RmM=;
        b=bFlq2IPzMvx5oI5CkcG4cKFEJPcvYayv/do78e1KNbHDpAiCppXBcETuRh9g0z8P3x
         tyWKWT1+syFm88JKvOVY+X6kPcp1HpZizJ4SfuttJZmBbrblI3cvb8bdepoTu0Tq7aib
         FLpBaINleIgUFVtuyl5MMth+21QAVrRt5WHVSl1FtWN/f4DLnmivxi3+wVsW4CyRjxvT
         B7nx/oWIWxG7NMn918Mx43Tf2vTXrzTUMHx5BJYWqdlUTx4RkWloqjiwUuX6u/ccL4mg
         bAbEtDqW15W1cF+AWnQ+DhabcjEIxzrrAiZowMu9cD6U0tFxgqz3LUdMvkYH91v+CDAO
         iG9g==
X-Gm-Message-State: AOUpUlH7L9yYJQumg8zhGH2i3ev+nJfZ2Ux6heDccZpNe3iv+DGVe/f/
        CdLRy9lf67RjB7XHs31/MhX9XJeLkSbl
X-Google-Smtp-Source: AAOMgpfwHzYrihWtzRbdMop72qYRz5qhGegFmjCeI7tGTepTOP2F9CnCBbQXOMdfH5D5af7VcQkkSKLtwMnC
X-Received: by 2002:a6b:f719:: with SMTP id k25-v6mr3730005iog.133.1533348183448;
 Fri, 03 Aug 2018 19:03:03 -0700 (PDT)
Date:   Fri,  3 Aug 2018 19:02:55 -0700
In-Reply-To: <20180804020009.224582-1-sbeller@google.com>
Message-Id: <20180804020255.225573-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] Makefile: enable DEVELOPER by default
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     avarab@gmail.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewer bandwidth is limited, so let's have the machine of the
(potentially new) contributor warn about issues with the code by default.

As setting DEVELOPER, the compiler is stricter and we may run into problems
on some architectures. But packagers of said platforms are knowledgeable
enough to turn off this flag. (Also they are fewer than the number of new
contributors)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Resending with <git-packagers@googlegroups.com> cc'd.

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 41b93689add..95aa3ff3185 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,8 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
+DEVELOPER=1
+
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
 
-- 
2.18.0.597.ga71716f1ad-goog

