Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987C820899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbdHRB7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:59:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38720 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbdHRB7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 21:59:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id y15so5370405lfd.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8znhBS04HUeZPZka283aH5flOq/XcWeIMrS+5xxFM1o=;
        b=elol/RYsKIKR70Y1geqzepSDL1IoUD1ZZUQagQP1kueLp9iXpvY5RK2kKKGQnLUQEL
         LQAE05XkXVwQoJ7z+abKPh1CdkLr0LJqEUJi9YY4CNUy9G53RwhH/FCd0I66g47f7hAc
         ajY/t6r3sMzNKUVhxbMR1gnu6Klk3go1meJLSEqtr0iqrxfxRqlWiUyjjrV18f3pMXw8
         j++5fkdWOThS/x5G4EVuvA373/r0z89bO8FHYdFybVWX5FNi7AshFgMyLxOJqoyDfw8D
         YNCPD7vIGZzbMl69yxOhjuKJ5BElLExQqnMd1ffUflf0MCXzVsTagJhLVwqb9ay+jhpE
         ZnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8znhBS04HUeZPZka283aH5flOq/XcWeIMrS+5xxFM1o=;
        b=KFdnXyvzqVmZlqqRKQdEPO6pi9EmVdjPEnPyac5k13+PYEEPFiEYP3oc1TnvQqYUwg
         fi6Ht8YrlSV2KnFZ8wNCYFlBgX/nWR6chuR0j81+/bpmGoFszPUgMimUUDrFTOuY6ej7
         5mNOl50yzxy5J8jLtPNXDwgxbhIa+CeZowfEQLTBEV8Etb+pPEXskt+169U+tskNGtpg
         DYGQOO1/xhMtPO2ZWCPKbD3KK5bzSIr3Tf6mWqV99rEGou9d1LpUzsJ72FYN3LaSxWe2
         rmxTzN3ZSr1aPAvnjP/5IoTHnEbhLGi0iaXs62RoQvgDwsnS7lSJ2qRnWTQkZhLaz0OE
         1xng==
X-Gm-Message-State: AHYfb5jhGqUDlPP5wUVXwWfU2FYZsPyef99sXWf8l383ytZdQhUMM1Wx
        oRDIU4JykmWi+J+Xoow=
X-Received: by 10.25.170.67 with SMTP id t64mr2325904lfe.98.1503021581141;
        Thu, 17 Aug 2017 18:59:41 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c23sm363156lfh.79.2017.08.17.18.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 18:59:40 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] Modernize read_graft_line implementation
Date:   Fri, 18 Aug 2017 03:59:34 +0200
Message-Id: <cover.1503020338.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
- commit implementing free_graft dropped (no longer needed)
- several more lines moved from last commit to commit replacing
  raw buffer with strbuf
- fix for memory allocation separated from change in hash
  parsing
- commit_graft struct uses FLEX_ARRAY again, meaning free_graft,
  memset, nor oid_array were not needed after all

Patryk Obara (4):
  sha1_file: fix definition of null_sha1
  commit: replace the raw buffer with strbuf in read_graft_line
  commit: allocate array using object_id size
  commit: rewrite read_graft_line

 builtin/blame.c |  2 +-
 commit.c        | 38 +++++++++++++++++++-------------------
 commit.h        |  2 +-
 sha1_file.c     |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.9.5

base-commit: b3622a4ee94e4916cd05e6d96e41eeb36b941182
