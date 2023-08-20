Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA4CEE49A5
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHTSz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjHTSz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A70E0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so25083115e9.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557452; x=1693162252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8bXc1I6w16t7CNkhnvF8ziZgiBaWx2LXIHCxTkEX+M=;
        b=UGvT6E+dCPuebCs3UL11tSCjPYy+K4hMjCGs8BGoIjiTRNM9+hXWY5nKNCLm7O8oqj
         sRntVv6565lMR92oIi9wHoaf8f/I4mgnmGixDPTakayzHxoDld3G3z5RZXyYKTA7WBGe
         4L00E+E0/PndaZnluHvoJNC/zlGD7jYaOKcQ2Cz6WcbYTwfFFLCSPa35u8koFJmUk/j+
         klr5QnZ5TKVzDTsbQTft+eFLnFgkdl1tPihVF4sQTAKGi3pdyrnoexVVZb4NEgyTCcP8
         PPMhWmD0nBa1QFLPKkJMQEzNBabKYtMVLb5x0XlNFqA9LG8/pRIpKFvoiHe6b5xjZLHZ
         /Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557452; x=1693162252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8bXc1I6w16t7CNkhnvF8ziZgiBaWx2LXIHCxTkEX+M=;
        b=dYujlQB+7BdsJL0OY9D3UNmr0yzwq4hFgyek/nzVmC+lyXgi0VHkUlklYpFDUoGQMX
         Yvd0qFpi6KEMx8Z7j/2Il17FpgeCbf/8y59ZdMohjPrFIANKn4D61+c7QXV2S+oE8m82
         oj0KvLgNuHL0rezLQ/8bWx7UI5us5thD5GC4CrVNKyeDY0uQhr+E/vjnQ14oNyiGq1jI
         WsAuPcFqswy/+yEOg0J1HwOri+AA9r1iPBHYJoWyT44AF/5huxUMcezy7c0WhWhRLfI5
         PpDlroTVeyGQLPCuVTCLY6OqdRsm6ritHULFbbzZcKUoufUM36jLTmvRxMOv0liFGgZm
         3YJw==
X-Gm-Message-State: AOJu0YyNtGIzGyYuYCiHsPs8NWXNjGxiddWs2Bcej5NN85377xd4d+6b
        snwIqlR++4I8QnZm5bM1GDx5Fcf+Iei8sdm9
X-Google-Smtp-Source: AGHT+IGMEjh4377iWkMq7Tphz7FSwodUHClgqfUMbw/8HpsMQQphTsW3XcKlAnJUqlRg5DQCgbBHPw==
X-Received: by 2002:a05:600c:364a:b0:3fc:521:8492 with SMTP id y10-20020a05600c364a00b003fc05218492mr3409276wmq.5.1692557452065;
        Sun, 20 Aug 2023 11:50:52 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:51 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 0/8] pretty: add %(decorate[:<options>]) format
Date:   Sun, 20 Aug 2023 19:50:01 +0100
Message-ID: <20230820185009.20095-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for sending another version so soon, but I realized that I
hadn't removed the use of a compound literal from the first commit where
I had added it, so it still appeared in the patches. The overall diff
for v5 is the same as for v4.

Andy Koppe (7):
  pretty-formats: enclose options in angle brackets
  decorate: refactor format_decorations()
  decorate: avoid some unnecessary color overhead
  decorate: color each token separately
  pretty: add %(decorate[:<options>]) format
  pretty: add pointer and tag options to %(decorate)
  decorate: use commit color for HEAD arrow

Junio C Hamano (1):
  pretty-formats: define "literal formatting code"

 Documentation/pretty-formats.txt | 47 +++++++++++++-------
 log-tree.c                       | 72 +++++++++++++++++++++---------
 log-tree.h                       | 17 ++++---
 pretty.c                         | 76 +++++++++++++++++++++++++++++---
 t/t4205-log-pretty-formats.sh    | 32 ++++++++++++++
 t/t4207-log-decoration-colors.sh | 44 ++++++++++--------
 6 files changed, 219 insertions(+), 69 deletions(-)

-- 
2.42.0-rc2

