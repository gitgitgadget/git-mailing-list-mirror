Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500291F516
	for <e@80x24.org>; Tue, 26 Jun 2018 16:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeFZQRi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:17:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32787 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbeFZQRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:17:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so17873800wro.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ho4idVj3Qn1qP07c62YIT0cCTRK660m2FTzovBnc+iA=;
        b=hBzfpX3g3yet/N+DXsPAzrNNM50drPBVW9FGBe0rlMmamM3MppWc2A1aTIKBMhchma
         jG4OkBhMYpPoZZiRppXECPCbsFjV7Tq3AullIrwIDKN4RPHRJUNKKtH2RWviIbV+xetr
         39qnSLl11zqHe6FHS0WotomuqjNwGaqpp/N864vRp1DZKmbopQ5crGNOqr+X2Wu0YpzG
         +SYP4f2lK6/x4mXadvnU0ZQIrg54pE1L1q1I0OFgNUpK2xIyAzIKQQamNKYHoQh3w9Jk
         vpP22fLVut/rr5HBPojQAPi+qO19IFSlSh7T4ftaCvvqhhyTAaAmCCaF/btIOD8P8SM2
         mPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ho4idVj3Qn1qP07c62YIT0cCTRK660m2FTzovBnc+iA=;
        b=ODF8gGtgY3NZPhqW/JbWyO+muNqD1MJ1NfuEw7wJUNUHjtgEooMSs3+Ze0YYofrne0
         LfXJifGrG2KpYmzLxprYk4C9hjmkWsQYqxGaCf8zqfuKsQJgAQPoonUFBcvLRWwOU51i
         RL2DuXZPNrGwF7a/t+R8xTiaKdVXd4sAXZMzA6Z/Udyli3AeMMrqBRflEBe7nZBlSmVC
         LL31Q1F+XefPzIJ4DivXrZrXQhNiMQxeHtF2gWRk65E6iSwM3KZJ4Ud7HhP0F1xR+/hF
         vd/girN81Au35R5yjq5tOCSTyvO0eVDYVPR/PPZ4f6ADHVaFXFu5NmdTfYesY99z0l81
         fU5w==
X-Gm-Message-State: APt69E2Sez5JEer78Y75cQYkq05JxO0XDwvR0kDxfqFn9eaywAqh8ie8
        oEG1B7jauwRANQuRD26Bn7+4ZZov
X-Google-Smtp-Source: AAOMgpc8MSym4sQdmBtHmDXQTyIemr+j+AbN2QGcOHuALFYn8EDgvLrqNYYhPcyaMMiaam7vohq3dA==
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr2204409wrn.254.1530029855129;
        Tue, 26 Jun 2018 09:17:35 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id g88-v6sm3790319wmc.27.2018.06.26.09.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 09:17:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 0/2] rebase -i: rewrite append_todo_help() in C
Date:   Tue, 26 Jun 2018 18:16:41 +0200
Message-Id: <20180626161643.31152-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180607103012.22981-1-alban.gruin@gmail.com>
References: <20180607103012.22981-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites append_todo_help() from shell to C. The C version
covers a bit more than the old shell version. To achieve that, some
parameters were added to rebase--helper.

This also introduce a new source file, rebase-interactive.c.

This is part of the effort to rewrite interactive rebase in C.

This is based on next, as of 2018-06-26.

Changes since v3:

 - Show an error message when append_todo_help() fails to edit the todo
   list.

 - Introducing rebase-interactive.c to contain functions necessary for
   interactive rebase.

Alban Gruin (2):
  sequencer: make two functions and an enum from sequencer.c public
  rebase--interactive: rewrite append_todo_help() in C

 Makefile                   |  1 +
 builtin/rebase--helper.c   | 11 ++++--
 git-rebase--interactive.sh | 52 ++---------------------------
 rebase-interactive.c       | 68 ++++++++++++++++++++++++++++++++++++++
 rebase-interactive.h       |  6 ++++
 sequencer.c                |  8 ++---
 sequencer.h                |  6 ++++
 7 files changed, 94 insertions(+), 58 deletions(-)
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

