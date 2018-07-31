Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7F51F597
	for <e@80x24.org>; Tue, 31 Jul 2018 11:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeGaMzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:55:35 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:30348 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbeGaMzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:55:35 -0400
Received: from lindisfarne.localdomain ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kScrfkUhMbZX5kScxf0euy; Tue, 31 Jul 2018 12:15:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533035744;
        bh=8MhL+nj1GZyNdbpPcwpXwyrtsTvRVVkmoQNGMNP4cUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UVfYJnDeUkn4b/ZeP14Abp/21vupo6/3OqOla3LsLJVLhxeq76NdPbSP3riWIxzNL
         vd9uonPlp5bfTAuEMIgcrNIYpnzJ1bcGldexXHvmWiiWKPkeqaagcE785hOdc3Muvy
         6qGTGAXuZkn2uQ8/Vb5xUcmmrHjRaYVaCKez/4so=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=evINK-nbAAAA:8 a=E_6ASKlpEjd644IWBvMA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/2] Fix author script quoting
Date:   Tue, 31 Jul 2018 12:15:30 +0100
Message-Id: <20180731111532.9358-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGijJ1FDt99tUfjMCSiWQURazLhtuGQ9x90FCdaTjpwO5x2kpRKzkFI5vHS6sKRA1bBjdO/pfLPQgV9Kg8wCQcQhaZhXh1Tz/izgB9MbEweNVH42EggG
 C+QyvL6WczXbdjg25V5S44qexhFU8hR9q1zy/X0Hb3wrx1Dyfa3ROp2UzLpw0R7eKzgd7TIdSA3wlY+0KnmWiZjvH69IV0QnhPjokBBpTjtti0wcCb4PVQNv
 Cg8Fq1hDmIxZXgeXJGWCI7DlKdq/vGjAGLIqJ4PjjcyjfDRsRxUrcGan3gCP07w4qBVDMYTXHy/VlQVJBIZMoxE3LvoLeMmGNte0OZrHh5w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These build on Eric's patches. The first patch would be better if it
was integrated into Eric's patches. The second is a rebased version of
my previous patch for fixing quoting in the author script with some
additions by Johannes and rebased on top of Eric's fixes. The special
casing for backwards compatibility in the second patch relies on the
quoting and the missing trailing "'" from GIT_AUTHOR_DATE being fixed
concurrently.


Phillip Wood (2):
  sequencer: handle errors in read_author_ident()
  sequencer: fix quoting in write_author_script

 sequencer.c                   | 72 +++++++++++++++++++++--------------
 t/t3404-rebase-interactive.sh | 17 ++++++++-
 2 files changed, 59 insertions(+), 30 deletions(-)

-- 
2.18.0

