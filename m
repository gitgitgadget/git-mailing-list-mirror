Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350BE1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbdL1VD7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:03:59 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38148 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753843AbdL1VD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:03:58 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so29867038itr.3
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q+LHeOmQKQVTlLXcfw34VptlpJpScsWcfZKe4hp0m/M=;
        b=eKXuMQ4PmdrVR8C9WwRvB1d8M9MhUF488RdzPl6Fo4ak+N+0fEmrhX3eWOJ4vENV3A
         5p2l7BKKgbINkbwB7NaAfWjU2CREk3LEHReRVa+kymlrmXKh9Bz5seLu7oNb9M/F/9qW
         dNCO0EmlnH7Ho6EIIB40flHYQwumJMZeqs4EXdJ5c3zM/mqYQpm0SkR+HD8E4Oh3OOtP
         2fIKmJdiiFo5h7l/yK4UJ31t/DIIvkplFSvGq99ST72+TwPkXjxnDNUn918cdWEL3UpV
         DaAV+KnqgaTPE3ol+n7KhCtRIfShZdqaC120PPg/R8US7VpI/ygJGC8bt+S+xmwaZSSO
         tQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q+LHeOmQKQVTlLXcfw34VptlpJpScsWcfZKe4hp0m/M=;
        b=udTz0lXkPDXIqVryzzqeOuqKlPSkH7+qukSR1U6j4m66CiwkV7hbF34jjfTjh/xWpU
         EKGi4q8dSBEELC8kYCBx3BfX+OsheKimHqXuy68j94yVlw70T3W3LVTLwkmRwnkCITbd
         +MnPNPqxpPszpKFcjhF5E99t8Ryc/5MkE8nDG+54lTz1Rt5Dp0nDjBEx92rxXrBX1Fkj
         QFVdKpZGF/HqE3NghMIEle+OjgvDfpLFC/ZGHB+Z3xs+urMK//ilpw9JpFvnqKZ/Jj5M
         cZyzPZBgzr63uqlUq9ALXIHNPUtBKfr72FkAE8OxIEsMaEH+zwrRVhbNiJscH6wOLnCf
         uHQw==
X-Gm-Message-State: AKGB3mLz0JQS0wf7X2y5jUXYTSS3gLqF+m/PM6t/sqLDJ0zINIk0G79N
        uvl/l7i6TuSAS0W4grO9NmHPm1mDPBM=
X-Google-Smtp-Source: ACJfBotf1XaA1qAM/uvwd3jTKkgr2yWQVXpPDAzOm8/HrVMFM6/y3Dq/GYUwslJKd1sh+DkQsbjcsw==
X-Received: by 10.36.112.69 with SMTP id f66mr45030346itc.51.1514495037670;
        Thu, 28 Dec 2017 13:03:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d1sm12258697iti.18.2017.12.28.13.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:03:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] blame: (dim rep. metadata lines or fields, decay date coloring) 
Date:   Thu, 28 Dec 2017 13:03:41 -0800
Message-Id: <20171228210345.205300-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is picking up [1], but presenting it in another approach,
as I realized these are orthogonal features:
* dimming repeated lines/fields of information
* giving a quick visual information how old (as a proxy for 'well tested')
  a line of code is.
  
Both features are configurable.

Changes from sending it out in November:
* better commit messages
* rebased on master

Any feedback welcome.

Thanks,
Stefan

[1] https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/

Stefan Beller (4):
  color.h: document and modernize header
  builtin/blame: dim uninteresting metadata
  builtin/blame: add option to color metadata fields separately
  builtin/blame: highlight recently changed lines

 Documentation/config.txt |  23 +++++
 builtin/blame.c          | 216 ++++++++++++++++++++++++++++++++++++++++++-----
 color.c                  |   2 -
 color.h                  |  49 ++++++++---
 t/t8012-blame-colors.sh  |  56 ++++++++++++
 5 files changed, 311 insertions(+), 35 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

-- 
2.15.1.620.gb9897f4670-goog

