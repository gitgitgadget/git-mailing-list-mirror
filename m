Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374601F453
	for <e@80x24.org>; Wed,  1 May 2019 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEAKOT (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:14:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEAKOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:14:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id c12so24077977wrt.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=DrOMdS6wf4nZR0J9eeE3AOMrOv2SwqK/spJ8ieFOLwY=;
        b=kvwm3LjGwfSDOubCMMUrQB+eHV/FJUaYiMEKCgA2Lxp4aE6EG46PhbKY8LfWooopQ2
         Mt+3CjNZPU/yP+hgOAuS8SDcqkOuBkvW85zYTkpsB0mJyxF92o7XBgz0boH25paPU8u/
         tAwkAs8BDrRvq9tCntxEvIX97OZiheJJHY+PwJsI9yypRDxjRdJjNR/Kcd3q6Y9EtVs0
         7PI9p791MExr+CUnVpGr7+9TUSKZ5V1aoEmAM48x93PjpMuWGRET4eAMBxTw+NJxgCVI
         BL1Xuj+IGM0/XhBV5qfmMfquEMANALM46slUSUFrNyfjudQ/Kr+meUyPVhg6ZaFg5MOL
         2isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=DrOMdS6wf4nZR0J9eeE3AOMrOv2SwqK/spJ8ieFOLwY=;
        b=gblae546SrlxVYlO4bQhJpzaCMzpYg10ZrFLlvvzyR69z31Gc3LwlxgRok027v/B6k
         1ne+/uilWJI8LJc44VIb5/idnhTP94pBZ0kHWPkhUFMyFSEcuwm+EtE2ifybDhXX43zD
         n8Mse0shTG3G8+xg6Zyk/s4Qpwoyq96SFNgtVyzAhgXM9tsK1wwFs480q2+bHw9HAGXf
         O2mczvUX7dOMlCEKVXhv76odKp44VJv2JobAR9vA/rzHX1nTpHYtPxdb+WPB5wFKYkrf
         zg9Jf6+t3ye9G6Avf9j3s0v88PxfRPGX+MHOvMCzB3zupgZgajrz1Kpk2X8AkbXFSzPe
         1pfQ==
X-Gm-Message-State: APjAAAVuAd3BbGjhxmI9ltvDbO9pnuDsrdXRQZXPmYq78S8Ff7cISivU
        U1iy8uon7zmiHYnrOiSreylAsRRE
X-Google-Smtp-Source: APXvYqxMsWRRAVN0v7eoIA/qQkmvyv3s++SQqRXki0wTysNV9c9jl5K6WQcSfIY0SDrd1rmXXw9H9A==
X-Received: by 2002:adf:ce0b:: with SMTP id p11mr43232059wrn.196.1556705657151;
        Wed, 01 May 2019 03:14:17 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id d16sm38114498wra.54.2019.05.01.03.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 03:14:16 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] read-tree: improve untracked file support
Date:   Wed,  1 May 2019 11:14:01 +0100
Message-Id: <20190501101403.20294-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These two patches teach read-tree how to avoid overwriting untracked
files when doing '--reset -u' and also how to respect all of git's
standard excludes files. I'd like to see the porcelain commands stop
overwriting untracked files, this is a first step on the way. I'm not
sure if we want to add options to the porcelain commands to protect
untracked files or just change their behavior and add an option to
override that. I'm leaning towards the latter but I'd be interested to
hear what others think.

Phillip Wood (2):
  read-tree --reset: add --protect-untracked
  read-tree: add --exclude-standard

 Documentation/git-read-tree.txt | 19 ++++++++--
 builtin/am.c                    |  8 +++--
 builtin/checkout.c              |  2 +-
 builtin/read-tree.c             | 61 +++++++++++++++++++++++++++++--
 builtin/rebase.c                |  2 +-
 builtin/reset.c                 |  2 +-
 builtin/stash.c                 |  7 ++--
 t/lib-read-tree.sh              | 11 ++++++
 t/t1005-read-tree-reset.sh      | 63 +++++++++++++++++++++++++++++++--
 t/t1013-read-tree-submodule.sh  |  3 +-
 unpack-trees.c                  |  3 +-
 unpack-trees.h                  | 10 ++++--
 12 files changed, 170 insertions(+), 21 deletions(-)

-- 
2.21.0

