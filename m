Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097F41F403
	for <e@80x24.org>; Thu,  7 Jun 2018 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeFGKa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 06:30:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeFGKaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 06:30:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so17780655wmc.5
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+MMprjvJ9EXNOB5XXGYRbfRHt39fZoUH5Tcr3uN3OU=;
        b=X5/QIsypqgtzHqMgB4YKKeATF/pP0Ac2Y4KCzukdUowS90P9mdDi/NVSdj5lo/L62Q
         fcpFbsvD7JO0/Xo1gyrtZvCoZsPvvmQbWgeQjvuygUN2AGOJ2XvbVdUXZy4nojAhmWFh
         gnkJfJ569tdDKuLwZiJXpd/c9EDTU/JyTgBRo+/dectbajBbuLt2UquI4OTN0XrthWqz
         ISb2TGBU0bJT8ePshDRzaDCkCK5BGNoGe6VKeW7Fu4dFvx0mUdiwbk1lxyGRPPlMPq/N
         eHiWmWQdZZ3dMq8yrMbVh1wpBzsX4e6EsQt+AHmFY9mp+SGwh6rFIwCaBeJb8jq2uJEd
         QrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+MMprjvJ9EXNOB5XXGYRbfRHt39fZoUH5Tcr3uN3OU=;
        b=dYLRzqfrkzXAXBGF2+N2u3kClhpMIR8yPLvo24AljR6f+j/j2sIK+9XDQUapB0Sm9b
         Z9RwjuIfemAq2ItXGwdEC5F9LkTzlkbkYVFrQDj7N3KMsXgTKVtlmct/mTIVjaTj7fKt
         eahUhlwWqK9pZlsyb2mZJQizQTPfbAvKPAf55XxjawE1WDDiTjbaq6MLaan5KK45jL0O
         y3wP147tX8ZijcheSadbKC05tUNB+hUA09lvft17ANTXWPUjGpxHtxR9EAG+F21cgWqb
         mNpdpbpPbz6LLN//OEu0/sMPNz+WdQRX83+RA5Q2ETcLYYFiHipJDSG2JmERx+da6NKh
         xTOw==
X-Gm-Message-State: APt69E0GNEFtjYBfcqB+hL6f64o7BbWdgdGUpwnXHdhAVX+XljqsxffH
        vTNLot7vAEpBWpAugUPS8S4VBbK5
X-Google-Smtp-Source: ADUXVKIfunBCYt9VV/kgMX+bQdtv+OGwL085dvalVEoe7uUDrV12xFM84Wlj9w4eA1CkPToCGam/Pw==
X-Received: by 2002:a1c:6545:: with SMTP id z66-v6mr1109061wmb.86.1528367454353;
        Thu, 07 Jun 2018 03:30:54 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.googlemail.com with ESMTPSA id v138-v6sm1871573wmd.47.2018.06.07.03.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 03:30:52 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 0/1] rebase -i: rewrite append_todo_help() in C
Date:   Thu,  7 Jun 2018 12:30:11 +0200
Message-Id: <20180607103012.22981-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180605125334.14082-1-alban.gruin@gmail.com>
References: <20180605125334.14082-1-alban.gruin@gmail.com>
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

Changes since v2:

 - Renaming the variable `edit_todo` to `write_edit_todo` to avoid
   confusions, after a comment by Christian Couder[1].

[1] https://github.com/git/git/pull/503#discussion_r193392270

Alban Gruin (1):
  rebase--interactive: rewrite append_todo_help() in C

 builtin/rebase--helper.c   | 10 ++++++--
 git-rebase--interactive.sh | 52 ++--------------------------------------
 sequencer.c                | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.16.4

