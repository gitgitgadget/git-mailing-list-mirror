Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92129C433E0
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE7061A40
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCYXiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 19:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhCYXhq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 19:37:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31291C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:37:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 12so2062849wmf.5
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aY8P7FiEec1xX98s9FbiP6jjYZpiFby8AbhTivRL3Ys=;
        b=svCOR19flw1jV5EySBOd4N23RGsEV0Ybg+twwYoiDV1R76iMe8kVLP9mwCWNoCVJi2
         41DNJtIa3OrSyC3oKIoJHNlXbpXtRLC3bTeuXBzJSFEw/vccTIPWtGx/M8nc3tOYzq9X
         dz2YJ8o02CZ3wVU2SUb6m9lpqiEw+378Y+ZMG+hp91XMTTwV8TqX3tXgemXIymN9tk3T
         +zyHHTNiKahYRbXiYm2GiQyMTTZlMXKMt0ZVOOpjSkQ+k+ZO45N3T4LTA5ePFrXu9nDd
         ZPDMXWNIjA026n+E1CDdksrbbTBRBm0VPac1R4SQ9o+H2d+pcUYtR4RRaDXF3TPfhz5R
         nvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aY8P7FiEec1xX98s9FbiP6jjYZpiFby8AbhTivRL3Ys=;
        b=a9cjDQ+zKrpjsel3Dny6Su/WUy0r9H1nf12Pri6Wn6io16IdYjmpOxg1/4IgjyOvFu
         r05zY0XtpAPLNV6cXdNpU8c7zG9vMhe5j7DQxmzBDVNjXQfYQZQZa5veB+e41HTE7g8M
         nbN91hA+1QbDG5paj0tPsmZcCaz/LvkgWgGBZ7DGOFUiPTWFji+sULfvQB4qMGSGdNOG
         baPCyfjvqNi8BbEAti4RQQXiirJzwWCN914rQPTQuj7Y39bbqC4SP78YCYNzyZKohutS
         pQaEzAPBifFoMaaNOj7hQ2chVBducl7y4Zd7dJYA6T5P2v0RKNSEUlp1NboG3LkRmyfW
         sdHA==
X-Gm-Message-State: AOAM533TLgUtBeuzCteINCqAaDaa2as0JaUWFh31MYQcnibFdkHgAdE4
        ylfg9j4lnSImO1Jjm6maSdQmozLz+/AHNtMwrE0=
X-Google-Smtp-Source: ABdhPJz1OBxhaF0xlTq2mJ+C5+Xd8c9dlGd2vQK/hWNlySD9hvK89IF6c84e3VVbHBg8cQh6mHYPjQ==
X-Received: by 2002:a1c:1bd7:: with SMTP id b206mr10398875wmb.189.1616715464483;
        Thu, 25 Mar 2021 16:37:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id d204sm8559512wmc.17.2021.03.25.16.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:37:43 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v2 0/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Fri, 26 Mar 2021 01:36:48 +0200
Message-Id: <20210325233648.31162-1-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

Small amends, here and there, and fixed/reverted the whitespaces

Stavros Ntentos (1):
  pathspec: warn for a no-glob entry that contains `**`

 pathspec.c                 | 13 +++++++++++++
 pathspec.h                 |  1 +
 t/t6130-pathspec-noglob.sh | 13 +++++++++++++
 3 files changed, 27 insertions(+)

--
2.31.0

