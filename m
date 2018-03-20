Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989F81F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 11:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeCTLLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 07:11:15 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59339 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTLLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 07:11:14 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yFAYeoeajwheayFAdepoFf; Tue, 20 Mar 2018 11:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521544272;
        bh=ZicdfKh/3P+qh2eXf3GPRRksMay98mix1uAnxwXFH+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=itFXVJf2jm2qyahy1msJQQb12AfkWvmowr1Yw1kTNBVnCVPnrtDhAFMbK13XZqn63
         7+WQ5UzDFsEkRofhea6iYJQssIwZjUfR73Od3Ij1Ys9jCaNmxYttHOwQNb+KZfMljW
         HrZ78NDYKV0nfBBSQrGsPOA/E2sMXsYyCKcf3boQ=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=w3G8n6pFqufhU1wDDgYA:9 a=RfR_gqz1fSpA9VikTjo0:22
 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/3] rebase: extend --signoff support
Date:   Tue, 20 Mar 2018 11:10:54 +0000
Message-Id: <20180320111057.23862-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314111127.14217-1-phillip.wood@talktalk.net>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfOAGVB2xxj9b/iOdl1KdjaqEvfrKcosXCv/NL2APz4xEaYiB7YS8XWy5QIU03EpbnCforVKC1N+xhVLLrMC+LG1WzHtdm+vg2vgw9locFyzrNgwGbVkt
 9w5F3zDkh84AvPlsodqZ6RHBYEcJKOwAq3KYdeQEeTR9y2kls8E3uzexgx61RkfYP0nEkJ0o1MSwuuU2ogGCmXSQHlgG4SNF021EDpVpcrn6ZehFkgTBN7s2
 rJBt8wYuCb0WXQXyE46NgqWzhlLig4KIOOED2R2DeJX0NF0Hi++wHKjH06OxjpSW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the feedback on v1, based on that I've added support for
--interacive --signoff and --merge --signoff. I've split this series
so the fixes from patch two in the last verion are now in a separate
series [1]. The tests in this version depends on those fixes. The
third patch is new.

[1] https://public-inbox.org/git/20180320100315.15261-1-phillip.wood@talktalk.net/T/#t

Phillip Wood (3):
  rebase: extend --signoff support
  rebase -p: error out if --signoff is given
  rebase --keep-empty: always use interactive rebase

 Documentation/git-rebase.txt      |  7 ++--
 git-rebase--am.sh                 | 79 ++++++++++++++++-----------------------
 git-rebase--interactive.sh        |  6 +--
 git-rebase--merge.sh              |  2 +-
 git-rebase.sh                     | 27 ++++++++++++-
 sequencer.c                       |  8 +++-
 t/t3421-rebase-topology-linear.sh |  4 +-
 t/t3428-rebase-signoff.sh         | 38 +++++++++++++++++++
 8 files changed, 114 insertions(+), 57 deletions(-)

-- 
2.16.2

