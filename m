Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E4C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CAC206C1
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JghNcAhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJSQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:16:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34371 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 14:16:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id x62so3437731ede.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NJJSQUsgs0fwQeM+Jw0QMKcH4s4MACTmaFXfYFnFr3g=;
        b=JghNcAhjtkkaSwzdO8UG27b7zfNo+I/V2HwwDpt8TC0nIyoOfxr7j8t56E2mfOkz9X
         /NxPZ6MKn6gzGfl8o95UR7xjWSC/XtJ2vbNje++6iH6eb/qLqrcXTlaWkOzsSIRNo9c7
         b+RMmWi/tCuxzMXjJfFoQU+XVQ2MJF/uTy5GST1ezJzbCmkTW3oOXc00oexNle7Mnkk8
         fShDjaTsyODNxIBUXDbzTOrSwtiy7a4ISKZ16IsHj64QUAeMWtKoJ6mJVIaz93hWpJzu
         BYiOAh+H0IzgG/aJlpKNVospHON7MTOvA2GUPADBBZ76N2r51r0Zmwd+cr2nepy+Bu2o
         CpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NJJSQUsgs0fwQeM+Jw0QMKcH4s4MACTmaFXfYFnFr3g=;
        b=jeL07rq9/JEGtbT4gHN8jsp4cRSP3iEOBvVMvCyV1v5HUA5m0bmdBWXTTsovbBIiJq
         yP2MlI5jEbDaEozxsuC/YWMj6G7Xsn6Ahk0dZdfcA+OO4zJA5zEmNHbgt/ojzv6jFe7R
         VbUNQwxOOKjSLojNAsUskbTaS6uduz1CZ/9RRHeQvRB6zAqYs8uW7lhgyY1w/xqbfbx+
         kLXIm+RyMcl9Is80gUrDHEJWSgLn8a1NDIH9SlW08Qa3LyoAxkYgxbLz7yW9zYo0AwTA
         T3HsZY7uKCd3TNmsqlt2CP/n4eDVwAXJ+8wbdCksiaXx1ntW3o1+Rfr0EzqiA59GBBYG
         b16w==
X-Gm-Message-State: AGi0PuZ19s2DXONKmveP3T5D2umyyZP0vLovR958VtduUl/Ih0BGfhov
        Ll7ZpaMWMMzXGvbhx0kBgW1HIKNi
X-Google-Smtp-Source: APiQypLNJCh1dICrlivG+Mm4Sq/8C43Kj94tOzwyiLHbilRPYBb+qH1DUZa/QsQ3tjtewE2lO4BVNw==
X-Received: by 2002:a50:8c01:: with SMTP id p1mr6029324edp.4.1586542615847;
        Fri, 10 Apr 2020 11:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm162898edu.48.2020.04.10.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:16:55 -0700 (PDT)
Message-Id: <pull.755.v3.git.git.1586542614.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
References: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 18:16:52 +0000
Subject: [PATCH v3 0/2] Explicitly fflush stdout in git clean
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch that was funneled through a Git for Windows PR,
read: it has been battle-tested.

Of course, the current iteration of this patch series has not been
battle-tested, so please do review carefully, so that we can prevent bugs
from slipping in during the review process.

Changes since v2:

 * Fixed the capitalization of "THerefore" in the commit message.

Changes since v1:

 * Added a preparatory patch that refactors all interactive input reading
   via strbuf_getline(..., stdin).
 * Adjusted the patch and its commit message accordingly.

Johannes Schindelin (1):
  Refactor code asking the user for input interactively

마누엘 (1):
  Explicitly `fflush` stdout before expecting interactive input

 add-interactive.c |  4 ++--
 add-patch.c       |  4 ++--
 builtin/clean.c   | 14 ++++----------
 prompt.c          | 12 ++++++++++++
 prompt.h          |  2 ++
 shell.c           |  4 ++--
 6 files changed, 24 insertions(+), 16 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-755%2Fdscho%2Ffflush-in-git-clean-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-755/dscho/fflush-in-git-clean-v3
Pull-Request: https://github.com/git/git/pull/755

Range-diff vs v2:

 1:  9d2ee78a9e4 ! 1:  072f95090ae Refactor code asking the user for input interactively
     @@ Commit message
          beginning and at the end of the answer, instead of trimming only the
          end (as the caller in `add-patch.c` does).
      
     -    THerefore, technically speaking, we change behavior in this patch. At
     +    Therefore, technically speaking, we change behavior in this patch. At
          the same time, it can be argued that this is actually a bug fix.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 2:  d3949e42004 = 2:  063d2aaa401 Explicitly `fflush` stdout before expecting interactive input

-- 
gitgitgadget
