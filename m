Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243C6C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E797420769
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLfyZK4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELXmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 19:42:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98517C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z14so14797430qvv.6
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WyHtyNLSONeu/oNIdTcJupywiCy28BYBxN5wrR4Zrtg=;
        b=jLfyZK4WzLyGmQur57fuUXZuYbcpJquPNtOQL6hREjxRWffGrLQktfFq1HsshGKG6J
         Qh7W9y4t9baQur9ZhjOyFB83hmCZoQmbG4duzxBh6gw14mGavNukSVO+OH9VIa37X2GB
         HiAehpvNSXSA1rnNYRfTw5j7B70S1XennIJVr/Y5zjb+9sS824sN7gfsZUSri9zFk+4z
         Wc2A0si/JKJJpuFHcz3UIkQIpVpZhh/0wSn5a9vgy1XmRQPox9hqv/L0pkxYpZJGxYH9
         M/1r2DC4mKVVWO01ccpGCOD/FT6LIxg6xrC6+KzUGi7v+I5ahnhbAFAJKuxidvx6eb0A
         6Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WyHtyNLSONeu/oNIdTcJupywiCy28BYBxN5wrR4Zrtg=;
        b=BqpTpN2QkJ2UnLB3lFKhYWyGPngWCdLw8z+7iLhaG2TSXlcz/MPVSAIBn750bA3wjq
         voKGf6vxBZVg+KmfNC1owBjpmHIHx1n2HBL0XepAAqPVBCkchQl+Rr13H+6CeUdkwCDo
         UuUr6vHSCf3CA01uLlmagO0bTewdfyj7X5eZvI3iyV1KvLA6EoZgodzVlCCEyuoLIXcH
         XmCztXb9mbZaMo+to+ApjappTGgDRD5kGH6l/It9+vhaeljxNAGRWAqCvQQDa89rP69K
         Xce//xFUnsO40kt+ELnZ7065YNOXg1xDm0J/qiNi+Ms6L2aJcIryrag1fWatkSfsUau7
         cJjg==
X-Gm-Message-State: AOAM533pMrYuk7k/mrWVZCL8/pB3K8KkyO2xHfOp+IAuCgpBkL4KzyTc
        F3HcBMBaiH/2HR7/vUrEmmIYfGUiwu4e4G3lUulLM0eLJxY/ZpDKT+6HDOkKN1m6hojp91+r6aT
        7rKwPg7eGHfbRBGGy02pfOgvDM5ibPiCwIEqL7uA4Gc1yyD2TGdBQda6UlgLah2xv9f60HOmz4Q
        ==
X-Google-Smtp-Source: ABdhPJxh3muxh8gikcjzUYqbRj9AMmgbI0XJzNhsHzCUNhp6krvSB6NQ7SpZRAxL/GMD5DwDpHF/e70Hzn4RYRaT3dU=
X-Received: by 2002:a0c:f4c1:: with SMTP id o1mr10575831qvm.189.1589326938627;
 Tue, 12 May 2020 16:42:18 -0700 (PDT)
Date:   Tue, 12 May 2020 16:42:11 -0700
Message-Id: <20200512234213.63651-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 0/2] bugreport: collect shell settings
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: To avoid merge conflicts, this is based on
es/bugreport-with-hooks. It doesn't rely on any of the content in that
patch and the conflicts would be straightforward to resolve, but they
would be annoying. (If that's not the right way to go about something
like this, let me know - I've got a handful more bugreport topics to go
after this one.)

The first patch in the series captures the shell we use during build
(e.g. to run GIT-VERSION-GEN) and the second patch captures the user
shell at runtime.

 - Emily

Emily Shaffer (2):
  help: add shell-path to --build-options
  bugreport: include user interactive shell

 Documentation/git-bugreport.txt | 1 +
 bugreport.c                     | 6 ++++++
 help.c                          | 1 +
 3 files changed, 8 insertions(+)

-- 
2.26.2.645.ge9eca65c58-goog

