Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F1C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545F2221F4
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wi6xkL9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgDPVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728554AbgDPVST (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:18:19 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9937FC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:17 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id o32so41823uae.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mlZVcgSGsMFPSkhEvXcL6VAWzNPRA2llGfOlBIisbmg=;
        b=Wi6xkL9e2GsBlcYmOXbUztdlqXeZEixwQN9+rTMH8KkZvMbYYVBqD80+0npiKInUlr
         ef3ei6frEqL+AfLXCsOYTW7dUyp74hfu7BdR+8n8lwkWEE4w3VKu+SnMHlyx6gudcEpJ
         1kh2a5qwbEiqXR6NeTRa2cVYjY9PgrapFb2aj9GETrUdVZEbHDJG9rlbp0l7VrtiY12c
         c8HBs4UAQioO2Pkp7rx62Dj4ori1/APx1A/goS2IAX1v1KmYOlJGjzywaX1Awdy8CQ+E
         HaGToAop3HE/oWlO2/sJil1S1DUgal9RCbp3xqWe0yNjaV8IWhfSz9U9cyqh2JsrPHr+
         FMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mlZVcgSGsMFPSkhEvXcL6VAWzNPRA2llGfOlBIisbmg=;
        b=bIaebv1Q6EYXgA+q+DHay1ZoQqCABqt9wEtBmhqai+370XRymNetEByPYg/YqAWMUJ
         QCcOJEvTdfMbKvf/MP1HNzwHCTAhBmtnsFUDP/q/JEkdZAp2lRDuLQYutTlH1h5WbLp9
         hsz5zKyZx/0f+ISXdt/dXBQQBNAQ3yBSi/OZvIvMGHpyyhDVWCu4AQBQolfmJKM31YeC
         ZZqXu2wjLv51fgi489Ve9zb8nF9rR73pXNfmf02T1YVBNcLUd9g7ZzFitjbQ9XNNP7ja
         vtpR+IXihiba1zsZks5JOiw5hkba7hFXinp4SAzd0WDi51AgqPQFQVM/Ts4LNX1SS8X9
         6aJg==
X-Gm-Message-State: AGi0PuaM23rNPdcZXBo3BV8QjEroRRFHj7jCpVI1vBV39tZG4VD6naeF
        RK83aab4auNz8EbZyqFrrbn5FF7vMDbvZwSD+ly2IdjeGFi57zZ3tlYS3iL+mBpDDm2C5d6Watp
        UB5W7dNHst56tCRIPCpbbQgxR15lp4PgJBrLAzAMBs9KHNeiDq7EdD5l5t/MegzG3y4DhpOjguQ
        ==
X-Google-Smtp-Source: APiQypIZV42C4U8khrrAUapONmzMrjLYBgGebCEUpkXaLie8xcHItm3fMjDmifhtcxmGXv33ujNVRnr8ssTiglDIqFA=
X-Received: by 2002:a1f:9b52:: with SMTP id d79mr25468762vke.61.1587071896420;
 Thu, 16 Apr 2020 14:18:16 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:18:02 -0700
Message-Id: <20200416211807.60811-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v13 0/5] git-bugreport with fixed VS build
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two changes from the prior set attempted for 'next':

- https://lore.kernel.org/git/xmqqh7xk45l4.fsf@gitster.c.googlers.com
  squashed into "help: move list_config_help to builtin/help"
- Danh's SOB line changed to use the correct identity in "bugreport: add
  compiler info"

When generating this series I did base it on
dd/ci-swap-azure-pipelines-with-github-actions in order to get the
vs-build CI target; the results are here:
https://github.com/nasamuffin/git/actions/runs/80163844

Thanks.

Emily Shaffer (5):
  help: move list_config_help to builtin/help
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info

 .gitignore                      |   2 +
 Documentation/git-bugreport.txt |  52 ++++++++++++
 Makefile                        |  18 +++-
 bugreport.c                     | 142 ++++++++++++++++++++++++++++++++
 builtin/help.c                  |  86 +++++++++++++++++++
 command-list.txt                |   1 +
 compat/compiler.h               |  41 +++++++++
 compat/vcbuild/README           |   4 +-
 config.mak.uname                |   6 +-
 generate-cmdlist.sh             |  19 -----
 generate-configlist.sh          |  21 +++++
 help.c                          | 131 +++++++----------------------
 help.h                          |   2 +-
 strbuf.c                        |   4 +
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 ++++++++++++++
 16 files changed, 460 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.26.1.301.g55bc3eb7cb9-goog

