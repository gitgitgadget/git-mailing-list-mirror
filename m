Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A414C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29070206E6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGsdkOzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgC3Mnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:43:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46761 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgC3Mnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 08:43:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so21362882wru.13
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qs8lCqC/b1YaO14g4pHi7qUgEW5RAQFWiM8oJ3SfNP8=;
        b=KGsdkOzIQ9B3Iy12Dv91TRnrMCqKofPRtyAL7yOdwIhnIzKjWQvLWpCfJpONqcRH9i
         AKxhdTHu3pAuhzmp+dK8g38IYsBWSd0FFDIA4TkNfPSlbkpRvkkCdzrj85KAClbxz82/
         FszgR1yATC4nsHmJph1xgqvP5e4I2f/SOrxbYZE4shgJct9miwzUzifwj2KOv13ejWCJ
         TrSn64fxS9lEX/HUEg8l4mSHoRck9BYRjyMCMxQOXGTpP4mZtcWqbBC43pog1qFwPWsW
         DUfFd+DTTDIV9/z+I3P6FXqCPJkY3fAnndQXYRonlJkUO5orEASAqhibPZgPf1tB7n3z
         tV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qs8lCqC/b1YaO14g4pHi7qUgEW5RAQFWiM8oJ3SfNP8=;
        b=Enn/cs4FjIkQZdid8LkWGgit08s890/tXC1/8V6XyE/swd0AhtvQTxsSykXB8kQboJ
         l0+ccpmt511UgDRBt43s58TEdwBThqFWif2Eegz26+w5uMrDxJgz5/gUR75F6nTz9CIj
         CxQOFGh0SikqzVMCP5uhoJ3NG3bUxaDCv2n+vjb9WMQwokT1vzxM7dbtsMs5pp8ka5iM
         PkBOLdjbHz1cYXeY4dJunzSh4TC/jMTak5Of5kXDiyX/nRGRNgoKbRIAZy/Eo0UVMmZ3
         X/TNI4Fxk+Htd3JVBscG+ALEiVTtCyKDTc8N3aHkiIaILjIbZHJVfAloLJCNB75KX31s
         dcsg==
X-Gm-Message-State: ANhLgQ2jJBsWE/VZHbieWYl2rGO0TXhvuxVxAEVr2CLApFSafm1Bf2PB
        aoWC2PXEqhsbQG3nYjbhPAxFBEtt
X-Google-Smtp-Source: ADFU+vsbgq+kDW+IhChNvh/CPTNotsstERJu5Xd+VTly+DAZvidl9ZDxe1+R2l8rkSmrr1YDoqqiow==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr14718636wro.227.1585572214925;
        Mon, 30 Mar 2020 05:43:34 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.googlemail.com with ESMTPSA id 9sm20228480wmm.6.2020.03.30.05.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 05:43:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, jan.steffens@gmail.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 0/2] rebase --merge: fix fast forwarding when `rebase.abbreviateCommands' is set
Date:   Mon, 30 Mar 2020 14:42:34 +0200
Message-Id: <20200330124236.6716-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Alexander Steffens reported that when `rebase.abbreviateCommands' is
set, the merge backend fails to fast forward.  This is because the
backend generates a todo list with only a `noop', and since this command
has no abbreviated form, it is replaced by a comment mark.  The
sequencer then interprets it as if there is nothing to do, and fails.

This patch series fixes this issue by teaching the sequencer not to
abbreviate a command if it does not have a short form, and adds a bunch
of regression tests.

This series is based on 9fadedd637 ("Merge branch
'ds/default-pack-use-sparse-to-true'", 2020-03-29).

The tip of this series is tagged as "rebase-dont-abbreviate-v1" at
https://github.com/agrn/git.

Alban Gruin (2):
  sequencer: don't abbreviate a command if it doesn't have a short form
  t3432: test `--merge' with `rebase.abbreviateCommands = true', too

 sequencer.c                    |  9 ++++++---
 t/t3432-rebase-fast-forward.sh | 24 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.25.0

