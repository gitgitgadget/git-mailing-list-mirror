Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B801F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdHPR7J (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:59:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37993 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdHPR7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:59:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id y15so2942020lfd.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5686U/8wxw5Z8SUErCobA/19TDhSRsHW+fd3TGvY3sw=;
        b=rPVAsyT8YVe+yrq8qjxCW17+Mn9RKm+ix4OsPDa5xwgGYA9oaXQXZOvNouaTDnxOdI
         x77ASqVBx6eruX/oJ5Pdb7RjkEbGl3LMsZUGH/NVTXROWY6mUOjDiDMDk2jIuYAc08lB
         2CRnMLXqirFlRkhIZxU9nnYAphn5UxvYFGHavlX4nOijd2y0Lx9rltPOJTwy5AGlhd7w
         gfob+Ap+rMFNIKO5xrvvdlLUcaRauKZJuYJS2YkG9Y2fdJGx/0T6iywHwtNJpjflU52e
         xVZqFHjGdjLGj8V7JeJuMj06zVagGclzg/GuXvxkEGPwBtgReF9iA/c/mqwHSQpLvIK1
         Xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5686U/8wxw5Z8SUErCobA/19TDhSRsHW+fd3TGvY3sw=;
        b=Tg0qhFU5rv5kaILuiMXyKjoQokFeJV4BFJ511KTbtT5ihDgu2AOK3Dib7we0i/ryD9
         OZXGp/W3akpC7gR1Cxl0Iq9hOIjmu9ES1EagfdA0/AxLTCXv2YvrxQJXH5W0nCEnuM30
         xdO2yQmNtRYg3K+X6KSHeuiwUNrcmoYM90SQlbyMMlWOVlD4Op7h8sQZMLdv69PwZovX
         SLYyiH4dDJJMRWhtFgX+Vml3YksJ9A2OTWukiMh9QYhVa87D5vWCtb1DoIflA7vSf2si
         ZNRAZSujgdihPbLH/aqzkwB8dxeP4/ter8mIZpNFjwcefApw3YA53SSgVR76Ali1sWnG
         eNWA==
X-Gm-Message-State: AHYfb5ijKjbXCeqxlnDL2qMHopWLPr4V3Q4xg23iVNWQYR+lz615eBDp
        LEGE582jB+aVoYuced4=
X-Received: by 10.25.99.90 with SMTP id x87mr1027180lfb.116.1502906346817;
        Wed, 16 Aug 2017 10:59:06 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c64sm361245lfc.4.2017.08.16.10.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 10:59:05 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH v2 0/4] Modernize read_graft_line implementation
Date:   Wed, 16 Aug 2017 19:58:21 +0200
Message-Id: <cover.1502905085.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v1:
- the first patch is dropped to make it easier to merge
- free_graft is now static function in commit.c

I don't know, what are exact rules about adding Reviewed-by footer, so
I didn't add any.


Patryk Obara (4):
  sha1_file: fix hardcoded size in null_sha1
  commit: replace the raw buffer with strbuf in read_graft_line
  commit: implement free_commit_graft
  commit: rewrite read_graft_line

 builtin/blame.c |  2 +-
 commit.c        | 55 ++++++++++++++++++++++++++++++++-----------------------
 commit.h        |  4 ++--
 sha1_file.c     |  2 +-
 shallow.c       |  1 +
 5 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.9.5

