Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42644C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22EF206FB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plMNY4Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbgJONiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJONiz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:38:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A3C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a72so3201063wme.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrRB/AJ555F7Wy3pVZJmYc1kXEpOXqfBYxun0m5jfj4=;
        b=plMNY4FuT8oxObJqxRrhiju0/AYvzm7xtW+MdMbWnQ+aVYqbt13GINw3WwGgL+p+0p
         IMQljKqD67WDaTCGh5mbnl1CWCacN7oE0jkbKAN8H4kOLnBozgHhEOQO3fneB6sNx7xF
         QUDBj+a+7ej4VWTdKy8Ru4/XPeWOLVCV8TG9RuXjlBzLgPjAGmyNdA7grp6pH4e4buhg
         GllLRfxBBrH19BHlEUn2dcOeaWqdu/e/DmjOuo6P2ja+pt+INk8fGSCu3VOAGfgYLxzl
         z9EBIoJSqKgq+1GBQLvzdZoXbs0kEaPqvTZMUprimmjn0kxtQNyHW7pYGqbaLV5Z4gVc
         dNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrRB/AJ555F7Wy3pVZJmYc1kXEpOXqfBYxun0m5jfj4=;
        b=Tx5SgrVbmaPDqA9pO4keuRlQY1NgIvGHjbe5nltoqdibpCk/GcngKKffYiXtHkBr2a
         u9ckNXPs+aAgOxgQBdSveRHlCBj7+UhOL3kXubCAhzEDHjD204w3GUiOShSTR1L0Nbnl
         I3J4ISJ6G+vYtGzxuwpFkzjMoE5Iw2X96rhtOPaBDGVH8Q5hZ0tGUOnrCQ22JvtMYAFp
         3NM1gPF8VEQzjJL8+Ro7p1yjp5GHYTH7PH4YOY9pmmXC4LrMk//6fwe+ujGtdHwum8fu
         FUAkd5AWZEo5IL3AWsdC3Mm+8p9hyYCySMgc0SPHwpfYN93ykH0MEUILRC1HMmrU6rH7
         FUzw==
X-Gm-Message-State: AOAM532jZ4G9kzzpPSoJzmRevB6XsDfA+7RKg4qjXcwqigrmOfmtKRDZ
        rrL/xIPLdB+ZvT4CMOMDpofmzmm7LJg=
X-Google-Smtp-Source: ABdhPJwN7wTpqAxcbqTgDu62OTTGW1cxyaETDDTczERcaU3ochUNFDJm+/2HwlQ4eYUZXD9iBLY2Mg==
X-Received: by 2002:a1c:2681:: with SMTP id m123mr3985140wmm.138.1602769133914;
        Thu, 15 Oct 2020 06:38:53 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:38:53 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 0/7] Finish converting git bisect to C part 2 subset 2
Date:   Thu, 15 Oct 2020 15:38:31 +0200
Message-Id: <20201015133838.85524-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This patch series version is composed by the last seven patches of part2
set. 

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v11-subset2.

I would like to thank Johannes Schindelin for reviewing this patch series.


General information
-------------------

* Rebased on d4a392452e (Git 2.29-rc1, 2020-10-08).

Specific changes
----------------

[4/7]bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
    
* Add `oid_array_clear()` calls before return BISECT_FAILED;
    
---
Pranit Bauva (7):
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 builtin/bisect--helper.c | 187 +++++++++++++++++++++++----------------
 git-bisect.sh            |  81 ++---------------
 2 files changed, 117 insertions(+), 151 deletions(-)

-- 
2.25.0

