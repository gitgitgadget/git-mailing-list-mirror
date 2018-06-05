Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1FA1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeFEMxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 08:53:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFEMxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 08:53:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id m129-v6so4882921wmb.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyttUPnuTsr1LnRbKPOK5NJIyNMFqXhi6oMuHzlUwtU=;
        b=DKSifZv60Ece/+483c9E0RbB3+Agjlsbt29F6RXkjP6oMoPfOphujkSpYHaKNCNL3q
         QokJ80k6Uf8Q0p76xkwerZls122lX3U8R1+v5OwThJT3792JwJ49PUIuPwFAEg0QxjdP
         A6Cqx0H1u1De4QeuUOONWTvS1YJNo7WPqh3Ynr6h6BQ+XbsJMRotfP+XU9i0jQsJwZI/
         SRVfYRA9MV79K7R3nbMSC+yc5Ao6p/XZPqOjO5JJfz9cJQCq4AS9N8j3BCMjmWU/oqdb
         2gmcBNAM0FcqqUZfvvD3UerWMBqZXgHRsb1BMmj0FeFrPSSM9WDM2RcbuanQmkuge35t
         u1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyttUPnuTsr1LnRbKPOK5NJIyNMFqXhi6oMuHzlUwtU=;
        b=Mxkev2CXVldqmS706jeAToKgTi6HZoc+fAseSsOeCab/VOOpN8sCeZusOMmxm2T5sI
         FD42Q2lbLzxHYUNBC92YIsB4OSANiJAjDG9/R7J0mKDnwdn+/bAIHwFEWG0HgY/+iLBq
         Y+xMZOcCfW/nX8rPFN1KJ/X3fpBTIx7/IjR6oxBcw1KhltgZSXvjKjMDoOZeAuTwG4qT
         BbxWpwrmRVaDuc4S8b4/HdaTe0QDLp4ldULtLPMl7Vx3VS2I3uyiRhQ9pIfV6ck+IVGd
         5WU731IEj79raUEMNce/tBpAJQzVZKrtuY1S+esLI1ytpyeteSjoeCHQG/HKNSzGa2DK
         82XA==
X-Gm-Message-State: ALKqPwcJJHU9g+3TOKwfHJa5qChZUiz216cyQWDcxCG756T03Ea1nidt
        VUoAbS4/Tf5XlYo4fi8WFcLgdGGT
X-Google-Smtp-Source: ADUXVKL5zIbt9atblE5xnPfpWRkZOixIHVGxH0E4Jj0uxuLxeZ2X3mMif7JT7K+kJX9e8YTg4Rkv3Q==
X-Received: by 2002:a50:95f0:: with SMTP id x45-v6mr29104405eda.99.1528203225937;
        Tue, 05 Jun 2018 05:53:45 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.googlemail.com with ESMTPSA id i38-v6sm4439480ede.41.2018.06.05.05.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 05:53:44 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 0/1] rebase -i: rewrite append_todo_help() in C
Date:   Tue,  5 Jun 2018 14:53:33 +0200
Message-Id: <20180605125334.14082-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180531110130.18839-1-alban.gruin@gmail.com>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites append_todo_help() from shell to C. The C version
covers a bit more than the old shell version. To achieve that, some
parameters were added to rebase--helper.

This is part of the effort to rewrite interactive rebase in C.

Changes since v1:

 - Renaming the parameter to insert the edit-todo message from
   `edit-todo` to `write-edit-todo`.

 - Clarifying the `write-edit-todo` help message.

 - Dropping the commit that removed newlines in the messages.

Alban Gruin (1):
  rebase--interactive: rewrite append_todo_help() in C

 builtin/rebase--helper.c   | 10 ++++++--
 git-rebase--interactive.sh | 52 ++--------------------------------------
 sequencer.c                | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.16.4

