Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00599C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C048F61B3E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhKPDob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhKPDnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:43:25 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F15C0432C2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:39 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id bf17-20020a17090b0b1100b001a634dbd737so358817pjb.9
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ovhGGjx/wV4HZCFK9ookVk79ZGwqkaqksZFjIYIIUx0=;
        b=NBg6HIvBP6+WIt8kjEhAOrl2PpxPCxDmr7Q565nvcipcFENnQXkGeTbX6zmtURr2LU
         3AhJU+h0eM7gUpKAf2LeXx5c8560r25l6OrVTI2zMUFH0s0C1CgGt3CRBHL3+98VBUXu
         RWwjqIboiclezJHnY/WjFrmQgDLBUi36wKuUCuhu96HciAaZN/utrKKstcZwmF339mvm
         Jal/6Cic4O/ayu6d/vS4+Zq2XeXnr137UvuAjAHZs8eiwM9kBE7/XLnz6MfDspnZoI5J
         7XKCahPjNtJ3sKti3aowosKemrLF0dsSpTZB80cJAsHePglnKRDd6ZSXfxn2TAosmNqp
         m4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ovhGGjx/wV4HZCFK9ookVk79ZGwqkaqksZFjIYIIUx0=;
        b=Z2ECFEv0/Kj4M+UofsOArJ39TABvxJtH5tUGgukgBiKljmG7CnDcNsBl+UIAadJYAr
         haIaXSPTYDbGN1dc7KQDzfm8If+16kkVl8Vvp9l3oTASs+17qQ1NF7DEmTSXzHn0eoav
         7ePxc4Wyx/uzWQt4VOL8Gj86VJCCyAjO2LKScU5YoIUThgI911V6tDezmKCvdOmW9Clu
         f5XVWXLfIvR+5OYFrfnWXLiqsEcXtYbrPeM0xj21idKUfZZeKSexOw0M5ZmLWS4oJqoM
         qubIXM7G9WayMhe8cgtDbBUT2dgKpcD9oJrV2j4kv01CPfp7c+c4aMM0qPlmoHJBD8Pj
         Dqmw==
X-Gm-Message-State: AOAM532/Nhl2iM8e+y0fLB/4ClYGn0fPSb1NbSBg8t8ByF3ckEG2d6Xq
        mcXEJ4tlzvWQT03P15Ln2H7qPbYQP2sTlB/oHvIvlKsV5W64sg3sWdENJpA8bwMo/79CH73EAsn
        hZX04JTZzYI2RTAmPOHZbQOswFRUJ992hwSWskd0WALp/88/zFxOXV5gu0UBVXoGgQZhtp6bf3M
        CD
X-Google-Smtp-Source: ABdhPJz5pkBCODL8fEJIcaoG1VKo75D/5MBQrydq9cKGbg/YqDbDFbEIdFpm2C2Ye9T6Y5Bd9QVuqfDLLSf7L9A1Irkf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d2c1:b0:141:f710:922 with
 SMTP id n1-20020a170902d2c100b00141f7100922mr3863169plc.7.1637020838853; Mon,
 15 Nov 2021 16:00:38 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:00:31 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1637020610.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v3 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com,
        peff@peff.net, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a version that starts a second traversal of the config file read
when encountering the first remote URL. No user-visible changes from v2,
but hopefully the algorithm is simpler.

I've also added the user-facing documentation and a test of what the
glob pattern should match.

Some people have suggested avoiding the forward declaration in patch 1,
but I found that there are 2 functions that call each other, so the
forward declaration cannot be avoided.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  11 ++++
 config.c                 | 133 ++++++++++++++++++++++++++++++++++++---
 config.h                 |  44 ++++---------
 t/t1300-config.sh        | 100 +++++++++++++++++++++++++++++
 4 files changed, 246 insertions(+), 42 deletions(-)

-- 
2.34.0.rc1.387.gb447b232ab-goog

