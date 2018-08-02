Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB6B1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeHBNLA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:11:00 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:18702 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeHBNK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:10:59 -0400
Received: from lindisfarne.localdomain ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lBeMfoYRtbZX5lBeQf1fyw; Thu, 02 Aug 2018 12:20:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533208816;
        bh=Z87fNVlUgiLWXyYCK1rNd9Kj/rRINbKHoXgvpGDV/xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jEiYrI2W0iNyCPc/urhSuak+8cSaYTpd0moqNKii9Gv5m1pkk/HbS9U56AWxoSnux
         yoMkPpQXSnk4fHBiLrNPEWGr6s1EPY8CLpzpJCPlq8yxKX6YwmuauOL0dCRS+DujL8
         8ctLdfl3EYCKRLEg7Wj19wPylxh6WppbsE3Mr0BM=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=evINK-nbAAAA:8 a=PMjiGdBb5RKByhBRitwA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/2] Fix author script quoting
Date:   Thu,  2 Aug 2018 12:20:00 +0100
Message-Id: <20180802112002.720-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPCM9MCjf3WR1hhevtuzww289Kt+Z0H/0FvXnsxGPJsasXFZVrEBnJFxk0rikLOajhMsbJxYwD7h/fZs+g/6h0EUTuEWKXpM/10CfCtuLMTUbc5dfz6c
 b0U5Vzx/WKxxTG2WxAVmjaWHKyx1n6VeJW4xike8kSRwytnQqZfS/fuFDpwhnhAX3S0qTnNHCWpRxMil0KzobPGq082fNSe90YyqV8D8cLkD1oDoB0d0lOWb
 m1GP8OD3S88jFoEBN/HQeSl7ez6E9YDH2VdlgAGBD29pbnJZ/oVvZ5PCyhDEWa9U1NkIONnQwEaTvvJmtwNy0GvSpljiD/WiFxUZYwV3z3Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Eric for his comments on v2. The first patch hasn't changed
much, the second one quite a bit. See the individual patches for a
list of changes

Phillip Wood (2):
  sequencer: handle errors in read_author_ident()
  sequencer: fix quoting in write_author_script

 git-rebase--interactive.sh    |   2 +-
 sequencer.c                   | 137 ++++++++++++++++++++++++++--------
 sequencer.h                   |   1 +
 t/t3404-rebase-interactive.sh |  20 ++++-
 4 files changed, 123 insertions(+), 37 deletions(-)

-- 
2.18.0

