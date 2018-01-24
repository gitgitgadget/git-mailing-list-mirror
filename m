Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BE41F404
	for <e@80x24.org>; Wed, 24 Jan 2018 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeAXMeu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 07:34:50 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:2921 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeAXMes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 07:34:48 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id eKGDelQgfmITaeKGMe9R5X; Wed, 24 Jan 2018 12:34:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516797287;
        bh=zDZfJ9zwNrrosiEN8taTPR5R94sz0sIFwPyIn2LbiTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bEbrIEauU5RNkZUB2R7gGp2bqlRM+abz5HngNXUQB3rKrqHnMOtvfbTyaR1EtSjPm
         1Py06vJNVp/yf/8kwjredoXRJzhopA/X87rVHyfvm2096T5kp0D2ZPnsbinSz6qX2N
         75CCKj0lx7LmdKTVUewxCwOGkv89QtRGb4uthj9A=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=evINK-nbAAAA:8 a=p_DDcB0Xm5zArCMBzKIA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/3] sequencer: run 'prepare-commit-msg' hook
Date:   Wed, 24 Jan 2018 12:34:19 +0000
Message-Id: <20180124123422.10637-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKE3F3m0UwNxDODH5H6+WzMFvE5y/DShFgYiNSNYnKFkjGXCunH8Xlny+SkFTdg5I+3f9bxNAZrP4xE2GqKMqSq7o/I/GO/UmiNea1f0qllH6+kvsTys
 Whe1s2qtC0976RW5+cjwGlM9BFuS2SzG2+1EirSI9K+wTEBwdGNW69rYrv7f0KWP8ofnLVEZoxCn4cUeC80lHFUhqMn381i1kw/3rYc5ys73CJNk9kBsLI+r
 ykr8BK68ZKLmTBl/prXKfgpI89x6eNyxp7GMX/Lvwqsn7G3VyOhuyWnQ4WpYQ30pmxKmHcu6uEyCGVgcmnbt4uwBIWJMmcMVi04DHbZgKr6sLYRL+Bwzkg7b
 1oWiimQlZEXWPLxpmdsDB6UnpFIWnjIkjEFfcwLw3GFFZWyQDHx4KAv5gvIN5urpinRFLlf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The new test and the test hook scripts has been updated with some style
fixes spotted by Junio. I've added an extra commit at the beginning to
update the style of the original hook, so my later changes are
clearer.

Original cover letter:

These two patches add some tests and fix the sequencer to run the
'prepare-commit-msg' hook when committing without forking 'git commit'


Phillip Wood (3):
  t7505: style fixes
  t7505: Add tests for cherry-pick and rebase -i/-p
  sequencer: run 'prepare-commit-msg' hook

 builtin/commit.c                   |   2 -
 sequencer.c                        |  69 +++++++++++++++----
 sequencer.h                        |   1 +
 t/t7505-prepare-commit-msg-hook.sh | 134 +++++++++++++++++++++++++++++++++++--
 t/t7505/expected-rebase-i          |  17 +++++
 t/t7505/expected-rebase-p          |  18 +++++
 6 files changed, 219 insertions(+), 22 deletions(-)
 create mode 100644 t/t7505/expected-rebase-i
 create mode 100644 t/t7505/expected-rebase-p

-- 
2.15.1

