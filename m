Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04886C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjBWIGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjBWIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBD4C6D7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j3so5872797wms.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9qzaDFEfBqpAh2RNG3iSiFMBaiPM1J9KlsUGohgR0g=;
        b=SelKdOkd5ubMuoJuCSS5cQspkRozeobFKHXbuZWzZg9aq9u7G3L1C9XsfHPvq7CBfZ
         /GoeWmRjwf0j6X7XVLiyRmdllnjXx2Ydzuha81T1kvTaDdzOvTK459V5iF43rYSNL52A
         HttHwH1G/ldFq+fjLBYqOnjBpaDjvgtJwLd8u67zDay4BHqukCPLVsT9SyWc4BkdA5ML
         es42Ws7OOHC8WeFl9v8UpVHXDYNzTbVxBUPOP4mGhMT1N/P5Y673xu0tJoXc78zt6y/0
         l0sDi0cGHwOiS55lB22s8kPhVpnPFzhoUZKWZb/twOznFUi5YwIqPhIkn9NSkeazYzcr
         HG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9qzaDFEfBqpAh2RNG3iSiFMBaiPM1J9KlsUGohgR0g=;
        b=PZ6dYLXsIWQ/1WWfqFTDzhH/Xzq0/Zfmx6HLl9LrPibUKLMByXh7khtpVPC6700n4S
         LfZUScosO1l+BQy0F0ndUEHwJaMKpjY+ZEnGjkZF7e/ZSmXwcIBq2aRq+RJIHyvFS5ly
         bFARjg4pC5FNNNeR48G4vKtMLMlpY1XkgUQ+PfAnlTIRIXv1mueE3tD7txKG2WJlhhBS
         /NintQrNNrxim+ZI/52MTO5dCBrS/jxPTmJsG7QJ2QSTGy5mWpyIepIuJ7z6SRyx/ssE
         JZuCKn8GXWwA6/1vUNqsI31ScrHAZYDLcFVX2bQIR6/2R2RYisO3kRMtDFb5rqrWK5Pz
         IXrg==
X-Gm-Message-State: AO0yUKUzu3Z4lUbctSTOLS0dWYfmJOQ4BsjIb38ik7Q/kXDPIdJA/qWe
        0DsQqTzze+xFbRMn6K2K2EGBjzADEgs=
X-Google-Smtp-Source: AK7set+UvICq4NQvKJrvFO6yXfSzfoypIe8qZTO/2qMTtdnzvworTaitRiwyw6uMBi5c0KDaZfzIcQ==
X-Received: by 2002:a05:600c:755:b0:3da:fd07:1e3 with SMTP id j21-20020a05600c075500b003dafd0701e3mr2804168wmn.22.1677139535282;
        Thu, 23 Feb 2023 00:05:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003e6efc0f91csm8807094wmk.42.2023.02.23.00.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:35 -0800 (PST)
Message-Id: <faeb191198a3f8771fb9a6492dfb2434ea8b878f.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:21 +0000
Subject: [PATCH 16/16] diff.h: remove unnecessary include of object.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diff.h b/diff.h
index b90036f5294..f80bd297ca5 100644
--- a/diff.h
+++ b/diff.h
@@ -6,7 +6,6 @@
 
 #include "tree-walk.h"
 #include "pathspec.h"
-#include "object.h"
 #include "oidset.h"
 #include "strbuf.h"
 
-- 
gitgitgadget
