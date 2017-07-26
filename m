Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015972089A
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdGZK1j (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:39 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:15482 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdGZK1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:38 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXTd3j25; Wed, 26 Jul 2017 11:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064856; bh=Xmwr13KYFhH+OY5kkzpSsKiDcfXVpoq9l6p4ne68e5M=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=p709tvhB51zM6JQ4d1hHts9oq6BhNzmBvuWBtYlheljIxv3nlzlkt4camFuqHZSYR
         oSuXKEV0zB+bUGmS/I7ZsfsEhZv/dq7wjUzxAOs4+NTki/FdCRSExznPrx25tEB7lk
         x+NorbKEWKI09WNLEr+wo3xpILzMtaHsCHVUM8l0=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=ZfuUPI_5IsI0JW1diPMA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
Date:   Wed, 26 Jul 2017 11:27:15 +0100
Message-Id: <20170726102720.15274-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfB2ylfJbwWxuHFp3B/RSb6+8YvZvEGqlfvLTKQwglx7SSYkvljdXlHEuZRgTYsGJ7kkGAhrWnM0xc99vrJLyuADut+VZ7qSZC95+s56QTZ2ibAThKaK6
 Bc12uc8dj2v/FsCWxepge9pCnDMf/uTw7VENxOBz3sTfOFImosMfYdd0AOZtEicoQ/Vj4dSBzwW+SAzAggjMI3zT2NKc7S/xSfGWg/uYEzyOSISoEY+TZw5X
 cmWiWIiV9B8L3FvMEdt/xsiV9AtxIOBDAOjFjr++Js/PTiovyFFrDlDLnnS/fBlP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches add an '--autostage' option (and corresponding config
variable) to 'rebase --continue' that will stage any unstaged changes
before continuing. This saves the user having to type 'git add' before
running 'git rebase --continue'.

Phillip Wood (5):
  rebase --continue: add --autostage to stage unstaged changes
  rebase -i: improve --continue --autostage
  Unify rebase amend message when HEAD has changed
  Add tests for rebase --continue --autostage
  Add rebase.continue.autostage config setting

 git-rebase--am.sh             |   1 +
 git-rebase--interactive.sh    | 111 ++++++++++++++++++++++++++++++++----------
 git-rebase--merge.sh          |   1 +
 git-rebase.sh                 |  76 ++++++++++++++++++++++++++---
 sequencer.c                   |  22 +++++++--
 t/t3404-rebase-interactive.sh |   2 +-
 t/t3418-rebase-continue.sh    |  50 ++++++++++++++++++-
 7 files changed, 222 insertions(+), 41 deletions(-)

-- 
2.13.3

