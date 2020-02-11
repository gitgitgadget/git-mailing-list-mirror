Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D97C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9E020675
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qucu+BnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgBKPC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:02:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54643 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgBKPC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:02:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so3928044wmh.4
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=C4mt63mqse6stDZQ1oY11Ucu7UOnrxL3hVRp0xZHgAA=;
        b=Qucu+BnEOr6JEqR3yV+Wx8L7pWynVaFaWSo2MwAU052wRAxKhlf0OxAZsvGPvujhCL
         t/qjBbJscOtTGXXxMqOrWXPRxL39Bvp4B67VNu265HeDbniR7qTyapkQtl03vxF+AYFz
         zPz6JZ34tLSOV5PobRESOCajZtBZgfmp37Gf6NUY9hqAa9O7n+W3qfrEU2kTFLhE5S8u
         U0AF8g8ih9Wf09mbv/w0xOFpaBvJ7RZfiYpNwGgP1K66Vrjje9O0RiqV1CNQCgvX7wvI
         Wjlu51Wg4gXHMlV5tKRIGQs0EGUinRc+wF1XD5IlYotToDhg11UFl9u8u1oS5Rp18r8w
         Ae/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C4mt63mqse6stDZQ1oY11Ucu7UOnrxL3hVRp0xZHgAA=;
        b=tew7xKp5be1pHTUKpTEcFAqbrcP90m7sAYkzbCUI4swplfF+XLvD5erZNZqLZ4w6Bm
         NgfWQRkqCnR5iWKcUFmYKrjam1OdeUvfHLugJk8Ir1g4QUs7hF8XBRFnSQ1DbeMWxrfw
         v4xyc+dtPsK+/GzvggW6m1kJPTVhrKU11GU11H/WPbDd5HMAd61qDzh28wPu30kO9Yyo
         uj0M9et2P9CjUjg2lZXNK4Gbk1DLxto/uWm4VJQWNOD76vdK3d5NruLMrbvgmllPW+AW
         02VUkhFZjhT9zrxwXpSynGemcxiI3K6yEdudjTPbCxBqe37PkIGyiKzZoxTKJyvgRASh
         ZgLA==
X-Gm-Message-State: APjAAAV+fAJ7JBD9013/JmG+pNFvQCAFlLiChvTDZUHhwLp8x6kNFGct
        SYznouxTA5cqVYsSswjp0gBopLdO
X-Google-Smtp-Source: APXvYqzhdm+oUpk35ewZVIjrVzM7MVc/pv3/I/4na45mYgv5OZoQlYQ2y0r/GYRAaeYGtIiXbUujMQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr5939203wma.84.1581433345418;
        Tue, 11 Feb 2020 07:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm4117707wmu.14.2020.02.11.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 07:02:24 -0800 (PST)
Message-Id: <pull.546.git.1581433344.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 15:02:20 +0000
Subject: [PATCH 0/4] Sparse-checkout: Add subcommand and Windows paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/sparse-checkout-harden.

The sparse-checkout builtin currently lets users modify their
sparse-checkout file with the all-or-nothing "set" subcommand. It may be
easier for a user to expand their sparse cone using a "git sparse-checkout
add <pattern/path> ..." subcommand. To achieve this while reusing as much
code as possible from the "set" subcommand, the first two patches extract
methods from sparse_checkout_set().

As part of this "add" subcommand, I created a modify_pattern_list() method
that serves as the core interaction with the sparse-checkout file and
working directory. It changes how it constructs the in-memory pattern list
based on an "enum modify_type" that only has two options: REPLACE and ADD.
This could be extended with REMOVE in a later update. I started building the
REMOVE logic, but it was more complicated than ADD, and I didn't have time
to finish it right now due to other obligations.

Finally, a Windows user contacted me about using Windows-style paths when in
cone mode to add a nested directory. This case is fixed and tested in the
final patch.

Thanks, -Stolee

Derrick Stolee (4):
  sparse-checkout: extract add_patterns_from_input()
  sparse-checkout: extract pattern update from 'set' subcommand
  sparse-checkout: create 'add' subcommand
  sparse-checkout: work with Windows paths

 Documentation/git-sparse-checkout.txt |   7 ++
 builtin/sparse-checkout.c             | 141 ++++++++++++++++++++------
 t/t1091-sparse-checkout-builtin.sh    |  73 +++++++++++++
 3 files changed, 189 insertions(+), 32 deletions(-)


base-commit: f998a3f1e588d73ed7285cb14ac4839f63f6dc82
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-546%2Fderrickstolee%2Fsparse-add-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-546/derrickstolee/sparse-add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/546
-- 
gitgitgadget
