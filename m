Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E10205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbdAJL1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:27:36 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36249 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935165AbdAJL1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:27:35 -0500
Received: by mail-pf0-f195.google.com with SMTP id b22so12231017pfd.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuAwC56MPmZuze+tP+gg+Eglz2z62PJ13qhdXGJSH7I=;
        b=bjeRwLxLPk+Z29B92HOQZAYteNwPusyOfSQNWbQQj8yp0DiYhBn703uos9jvda64d4
         tQcBuaQRXhZbVTBmw3sK2eT+KvOFsjrkNL3gO1k4vNeqIiTMbm8FPYhYut7GQbLBX++R
         S4hylYpXDVJGdVTu6E0aQY/1o8TRVR2TebmFQto+VKAGDLoPfzDqrnPVP1KW5bGUyLbI
         h4EsFl7Qr8dtF4uUbcnSYFBGj6tsYM02h7zwV0yhhMmYjK9iFa5pB7fOUcB7flwLJQfO
         gaq9FWDH27l5nI1kfr8kPpUl93LrCuPmDjTFc0zMPMOYxMsSB5wvZRSkZAiNEZ/F6/UP
         MNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuAwC56MPmZuze+tP+gg+Eglz2z62PJ13qhdXGJSH7I=;
        b=OJfXTrdx6fabEcxmAzgD8PhYMpiAbsc3AL1L8gq/KkxT+E40q1QMlu/jt7EZ1LkXCk
         RaQRaethfUE+03V0xhZ54N4+eipxvlYWbSp18KYt61VPhmnAAnsKZgtbknOzKuOR5sui
         uhK7+Brzj0iTRd1mhoL08VmU8q7xi6kBclQAggmTq56OSdO58CN7Rw/X/+ueN2CuttnU
         6H90WLmzG7/8q1bRP1zxyRxuwD7ULO2/CAqHfK++24sRFO4l6dS4555jka9592DsN7Jc
         1TGR/wXsnUF1fMxO6B1LE3QL/zUkihuNGhB5loD+P4NRR0HmWhXkieGNf0ts6ofsoa85
         lg6w==
X-Gm-Message-State: AIkVDXIzA4IWq9Nvr8CZ7Opa5VtxwojAhzjDAXk/KggeRmDQnnhau7XUrqBMfhajmyKdGQ==
X-Received: by 10.84.128.67 with SMTP id 61mr4183523pla.153.1484047654519;
        Tue, 10 Jan 2017 03:27:34 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id x16sm4547876pfk.79.2017.01.10.03.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:27:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:27:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        Jens.Lehmann@web.de, larsxschneider@gmail.com, sbeller@google.com,
        mhagger@alum.mit.edu, max@max630.net,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/4] Per-worktree config file support
Date:   Tue, 10 Jan 2017 18:25:20 +0700
Message-Id: <20170110112524.12870-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's get this rolling again. To refresh your memory because it's half
a year since v4 [1], this is about letting each worktree in multi
worktree setup has their own config settings. The most prominent ones
are core.worktree, used by submodules, and core.sparseCheckout.

This time I'm not touching submodules at all. I'm leaving it in the
good hands of "submodule people". All I'm providing is mechanism. How
you use it is up to you. So the series benefits sparse checkout users
only.

Not much has changed from v4, except that the migration to new config
layout is done automatically _update_ a config variable with "git
config --worktree".

I think this one is more or less ready. I have an RFC follow-up patch
about core.bare, but that could be handled separately.

[1] http://public-inbox.org/git/20160720172419.25473-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (4):
  config: read per-worktree config files
  config: --worktree for manipulating per-worktree config file
  config: automatically migrate to new config layout when --worktree is used
  t2029: add tests for per-worktree config

 Documentation/config.txt               | 11 ++++-
 Documentation/git-config.txt           | 26 ++++++++---
 Documentation/git-worktree.txt         | 37 +++++++++++++++
 Documentation/gitrepository-layout.txt |  8 ++++
 builtin/config.c                       | 16 ++++++-
 cache.h                                |  2 +
 config.c                               |  7 +++
 environment.c                          |  1 +
 setup.c                                |  5 ++-
 t/t2029-worktree-config.sh (new +x)    | 82 ++++++++++++++++++++++++++++++++++
 worktree.c                             | 40 +++++++++++++++++
 worktree.h                             |  6 +++
 12 files changed, 230 insertions(+), 11 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

-- 
2.8.2.524.g6ff3d78

