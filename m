Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3BA211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 19:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK3GPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 01:15:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeK3GPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 01:15:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1335885pgr.11
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LFIO5E0JKDAoU//aNnZkX1njm9iIU0nd1whwW2zw73c=;
        b=Ywanx9lcyT/1Yv7smS1VByYCN+DcJV7zpxTA0MBVZ9bXmc66+oImh/yPOS5HDf5rbI
         QMG6lLJW+QUhEz2r5vxhOOrwwCFIEZNifjP943pJ0drjDjpc/InuGQ6tBOHuKhnDPJJ9
         rIKkJhuMUwWFgEnDBFmYq/Kp/7vuplEIGW8YMFECnmEWlSxii+61Cn87YU4DrJy8bl+2
         Qot1jacvi4A+9PTp+lY2Gt1MuxbgqtAHH/kbavcIE6zgB02n8W6qAWXBurMMaAyCEMOt
         lgIplUGuLgkwwOVUr7BVqY7XfdomROXZBo5N5Py5wUorAqlnOAZHKEXOHlVA33rv/pnd
         IUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LFIO5E0JKDAoU//aNnZkX1njm9iIU0nd1whwW2zw73c=;
        b=MWnCBZif+YeTgs5zlcGcsojltiglckELn9kagYZF2uhlllFGd5VYtckC+PVEyxEQMz
         59/Ziryc2lArURlDI1pS4YU0TFumgrsCWkukr0lc3C197gUYuttcIyVAFh+Y1jzHzfrY
         hzQwFbuT6rwaclTDoa8itcYiWBl6GhLIGMOMwxAYKguTGcE05mmLxpxuPMX1ry+5xuc/
         ubVW5bLHJa3VAxH/YPGId7eFkAYWdWcBJOLZ5NLyaTotwYXXpPm+Ilp2PX0GzuQ1btiq
         mMqGLe0zgHvqRhX6EUGlshUqg7xz8vOkUJNVD8/O4hb5U+CSIwOOm4gfn1SkXulJFZ7b
         PU2A==
X-Gm-Message-State: AA+aEWYnsMR/NO/fY9KiU1Lag3/DQfEk3APT3WSGvt693ZdgHhaHcgRg
        BhOl14oGD0Eju0GQs8xGfWqcqmCzNXk=
X-Google-Smtp-Source: AFSGD/X8uJJ0semsceC+oDFjxFsmmjVyBjj7hjdtAI7vr/90XDK164nxOyKEhyjpCwT3BbF4CEx/wQ==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr2210228pgf.87.1543518561336;
        Thu, 29 Nov 2018 11:09:21 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 64sm3633235pff.101.2018.11.29.11.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:09:20 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:09:20 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 19:09:17 GMT
Message-Id: <pull.91.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix built-in rebase regression noticed by Debian's dgit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been reported on the Debian bug tracker
[https://bugs.debian.org/914695] that the built-in rebase regresses on the
scripted version, and later details emerged that this has something to do
with the reflog messages: they were different with the built-in rebase than
with the scripted one.

This here patch fixes that.

Johannes Schindelin (1):
  rebase: fix GIT_REFLOG_ACTION regression

 builtin/rebase.c          | 29 ++++++++++++++++++++++++++---
 t/t3406-rebase-message.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)


base-commit: 7068cbc4abac53d9c3675dfba81c1e97d25e8eeb
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-91%2Fdscho%2Ffix-reflog-action-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-91/dscho/fix-reflog-action-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/91
-- 
gitgitgadget
