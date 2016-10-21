Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CB820229
	for <e@80x24.org>; Fri, 21 Oct 2016 23:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbcJUX7z (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 19:59:55 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34101 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJUX7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 19:59:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id r16so64802910pfg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 16:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ODTSkVUtckPe/QBmLLat83ZjH6bWRmyxNoJr991S/Q8=;
        b=mTge/ikQi4KYu7D66HuXjW+fYNAa0beV2IE17rxYPJVjRJRiKedJANGuoKgl+ZtJ/Z
         Y6Xa7KH3c+MJcWYnQGxAbmqqmDJuY1zHzFIZvhcR+3mwIQN2jCEzG1zN5sFCdQZCccnY
         GYqgPjY+fPIm93RSgz7ZsHA1HHluaizVm6Djb0zbnemEQ0Ket8hFBhAmAIIN5OggUoj7
         uPuc7tyifjtZlrOdhm3U+9HU5z+V0MW512XLBUHsRIiVjQ0ZHObFxpjkxiMCvuE/0MOS
         tdtIpvGDAOw/DtTqcgs6l9ENUiNG8PiNefa0k87CezAqcJn1BROJDfQ+9OzQRmy6KlWe
         t6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODTSkVUtckPe/QBmLLat83ZjH6bWRmyxNoJr991S/Q8=;
        b=Ol9F8XsUCNUrQ2N9BXZo268DI/RT/xR8psauInrf14vp4RqTwhlUls8E6a7fFsDoAV
         eMTCTksVqvVxlGbpm9Pz2XX2dC/lh7WWKtsoZShk9vxmZejEBrYFXamtUQsXjs5rinKX
         Ka4X2TCtWm7QCkNVCo0g85Mn+YK4vETVSKddMvAPomWJMqd0mtb/u3TUdwNGR+bHAzrJ
         QcJvtUwk66FoLS31D9vepaLGP4XivEhDA6AZFdDi4nCVqxRTjZtgub2JxPupXuIYNH9W
         2wT+QYYOdSU7VyTzd7MYvSOmb4Dr5qq5GBkoJF6H7Dr0ZWmCK2cvkyURjVJ81ELXxaN1
         s3ww==
X-Gm-Message-State: ABUngvfZTj+tlViRsrAFpDEFEqvL0UqDC2P8OG9mtm2d8shJBRtsOGT/THCIrieEBMUuEP0q
X-Received: by 10.99.48.69 with SMTP id w66mr5142550pgw.109.1477094393659;
        Fri, 21 Oct 2016 16:59:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc9c:7559:8571:d165])
        by smtp.gmail.com with ESMTPSA id yx8sm7604595pac.29.2016.10.21.16.59.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 16:59:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Fix submodule url issues
Date:   Fri, 21 Oct 2016 16:59:36 -0700
Message-Id: <20161021235939.20792-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.507.g2a9098a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous patch: http://public-inbox.org/git/20161018210623.32696-1-sbeller@google.com/

First fix our test suite in patch 2,
then patch 3 is a resend of the previous patch to normalize the configured
remote.

Thanks,
Stefan

Stefan Beller (3):
  t7506: fix diff order arguments in test_cmp
  submodule tests: replace cloning from . by "$(pwd)"
  submodule--helper: normalize funny urls

 builtin/submodule--helper.c  | 48 +++++++++++++++++++++++++++++++++-----------
 t/t0060-path-utils.sh        | 11 ++++++----
 t/t3600-rm.sh                |  1 +
 t/t7064-wtstatus-pv2.sh      |  9 ++++++---
 t/t7403-submodule-sync.sh    |  3 ++-
 t/t7406-submodule-update.sh  |  6 ++++--
 t/t7407-submodule-foreach.sh |  3 ++-
 t/t7506-status-submodule.sh  |  7 ++++---
 8 files changed, 62 insertions(+), 26 deletions(-)

-- 
2.10.1.507.g2a9098a

