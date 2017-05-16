Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C489F201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdEPEAy (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:00:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33177 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEPEAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:00:53 -0400
Received: by mail-qk0-f195.google.com with SMTP id o85so20720405qkh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTACtszxX4Il0QcKyEXqNqXCsPIErQ2ARuoWQR1yfOU=;
        b=A63u31NrXVNxaZAN+hE31ohVWCxdTw020R2K9+QQ5hrs2i2pgaQpWYTanota6P/gL/
         tXfx2uEuAjUQ3VG0VerqRMmDAhz1ID0OaMWPotLfpxe7t752pkhdf2EX8IYVwMF43RIT
         rbxNbzkuf2331CeN+V0ms4O0Ep3GI3kIA+vt3+rFltAeriTjju6GT7HxE9t9uVu1qKSh
         m9I5KImoKlceJywKJsF0U1s9wuTpVA9sBRxOgjPnre8XVyeBR/qPMAhzidnJG6nEUk69
         5DFKfL3aXPqloCJI2OFp1uScgQPfvnlYgSJ/PGgsjUFctCIJCF09YON0AY/ceQSpm9at
         Gvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTACtszxX4Il0QcKyEXqNqXCsPIErQ2ARuoWQR1yfOU=;
        b=dct60fXW4LLQ31Q/EhWwb0NmktGWHSKcC896s5r8XtV4fvLf3OyDfIGiEPTminBR0p
         a/Yq75Er++ScAO6ULjMUFfN+MGTJRC7o2v+SnlS1tddiO1kQ9MV+NJ0K5vcUMAnvN/1E
         jE8YcIaKq7T8rfr7EbM2NXHABI9OKTE+FjJq02vsdm53taeqsKv+465WQZx83PPdGPqM
         AMTvFinmul2HC+THh4HVhZjMOmJaNzcS8N2bGlidRtlPCYppw3gd74EmYvMlmL5WjOTQ
         QvhyncImT9c1uDnEBeRoTmTmFHwEQE0l2rQ2cGnpGO3KZvMDAcku9dOKE2IZxuGViVce
         1tWw==
X-Gm-Message-State: AODbwcAKVja/860f+ZFaNSjpDcjJA2JrOMUC4drHNJl64/af6cJgCK3q
        DopE+GFbMx40pg==
X-Received: by 10.55.16.220 with SMTP id 89mr8023915qkq.254.1494907251704;
        Mon, 15 May 2017 21:00:51 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id h14sm10068049qta.18.2017.05.15.21.00.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:00:50 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2 0/4] Port git-add--interactive.perl:status_cmd to C
Date:   Tue, 16 May 2017 01:00:30 -0300
Message-Id: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of a patch series to start porting
git-add--interactive from Perl to C.

Series:
v1: https://public-inbox.org/git/1494009820-2090-1-git-send-email-bnmvco@gmail.com/

Travis CI build: https://travis-ci.org/theiostream/git/builds/232669894

I have applied most of the changes suggested by Johannes and Ævar (thank
you!). The one exception was Johannes' request to make this a WIP patch
series with a sort-of "design" of what's next to come. I did not do
this because I still have no clue...! I'll begin experimenting on
update_cmd() to see if I gain some insight on this issue that I could
bring to this series. I do think this would be a good idea, though! :)

-- Daniel.

Daniel Ferreira (4):
  diff: export diffstat interface
  add--helper: create builtin helper for interactive add
  add--helper: implement interactive status command
  add--interactive: use add-interactive--helper for status_cmd

 .gitignore                |   1 +
 Makefile                  |   1 +
 builtin.h                 |   1 +
 builtin/add--helper.c     | 285 ++++++++++++++++++++++++++++++++++++++++++++++
 diff.c                    |  17 +--
 diff.h                    |  19 +++-
 git-add--interactive.perl |   4 +-
 git.c                     |   1 +
 8 files changed, 309 insertions(+), 20 deletions(-)
 create mode 100644 builtin/add--helper.c

--
2.7.4 (Apple Git-66)

