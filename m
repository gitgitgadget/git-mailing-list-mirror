Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB9C6379F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3599A20708
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHIZDlRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgKWWq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732924AbgKWWqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:46:25 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09987C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:46:25 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f16so17503989otl.11
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vlp4517+rYeNAjB22eV9fKv+6tJv2eqe+DNzNrG6nc=;
        b=tHIZDlRS8nmRtCCEJUQXa47zHdttBamZeOXpyrbrjhaq1Szbu9P/CzQGXwR8bosnmh
         7zV4v1gE7GxUHU0LWsRoenuTxg0MHNW99puYeyTpYV5yOCrqbi55f0NerWxNXoNLoXCy
         NKYqjuof+7YG9Mg+9Mz/0DpXOAHO+0MmjXc+BIh7mJFBIcRboWZHAdNRhsOUvsEEnKL4
         e0+K/wdv/K+UcCSM7005NBqN1Oktfe6Nno4Mkt09ero/RAevSYxERQrCsKDUQjqJL9mn
         3XRfRFDHsuM9aNA3R78S+3CSrkjSg5i+tz8EDYPDnBFbQvMNWvkZqjRQPFs3J+6+/qjX
         J+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vlp4517+rYeNAjB22eV9fKv+6tJv2eqe+DNzNrG6nc=;
        b=ueyy831a5V7ydZw9yNXHynUTPvAU9b5ZZcjJKGm0Pd2t2r6fIOGgypKcrWhRdysEXf
         4TtJ3w1p8NVMTWQUqaFlwxcgbrSuTQhY+6KSPU50w9kT8qjteWGodCTRr9/gs/HJZkfp
         +bX+SXe2Mvu1Urobp93+bJnp58lKI20Z1ZnZ6mNfx5zhEhKQ+mHWkAobzoMNqGgvSa6x
         OWgqL4y14NYMkMdzkHjqlppPVSyqE45+9pIjNef4hlvHEoHjeHanErslI9VGlJSoG64g
         yfM0FCkevwwLH1CzN5qP30C7ucxjVvZuM1pvphEmRCDrv+ImHgOTCKdWa00eHSkaX+aZ
         ORBg==
X-Gm-Message-State: AOAM533oVRxuPtrvOcv7sD11hGxOhKtTit5+2Qh3qeStwWDT42BTCD11
        PJsIhOKs//12ghMm9LluknlOIKxUcvpQVw==
X-Google-Smtp-Source: ABdhPJwUWPA4nQ6sFhPdyJgJxnFOo7Oe6jcu7dxjJjX8SJTeCQ/4OSPd/n6AqcFcGfBbzrk3/uOm7g==
X-Received: by 2002:a05:6830:2151:: with SMTP id r17mr1243097otd.328.1606171584219;
        Mon, 23 Nov 2020 14:46:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c130sm3911699oia.33.2020.11.23.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:46:23 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 0/1] Reject non-ff pulls by default
Date:   Mon, 23 Nov 2020 16:46:20 -0600
Message-Id: <20201123224621.2573159-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to revive the old patch series [1], except the only thing it's doing is the
important change: adding the option to reject non-ff pulls.

Following this patch the next one should add a new default mode that warns instead of fail, and the
next one change the default to ff-only.

This leaves the interface in an inconsistent state, IMO, since I believe these should work:

  * git pull --rebase
  * git pull --merge
  * git -c pull.mode=rebase pull
  * git -c pull.mode=merge pull
  * git -c pull.mode=ff-only pull

But that can be fixed later.

Cheers.

[1] https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/


Felipe Contreras (1):
  pull: add ff-only option

 Documentation/config/branch.txt |  2 ++
 Documentation/config/pull.txt   |  2 ++
 builtin/pull.c                  |  6 +++++-
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 36 +++++++++++++++++++++++++++++++++
 6 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.29.2

