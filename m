Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D4E1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGQOlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:41:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39093 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:41:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so12077566wmc.4
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8Z567y3WSYFVT4MEV/SNreiKz86Ye7xfQZPbw9GqJw=;
        b=mGJqEIUXyNavoER6D9TDp3chmg+OF1YgSwzKwGlbgJnke15K3JNYcKqcKe6V+KOEik
         LLKuURcwiYqMt+63H7Lfn7P/1Ogvp7AsnoSDCfTEKwyy11dnLBMaNmnjLEOjbDGFnY+x
         TJtnOK5b0WpAMXFBdklJmYVS6v5TMfxnLCQgM44H13GXVzuzdn7E4qk4lRnJuQsWQHJz
         yXO2g05mfKL2CTh1pCTLZO91Y78dX0kppWSJ/OCO5J7dUaljxO5NQaemt1I7Qw+er9vN
         pGhe9cgBuDWHRNsKcoE2H4lsE5PT7xUO8ND6nuNUL3ctQ+dmw0fE43m/vhuJEMAb65GT
         Ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8Z567y3WSYFVT4MEV/SNreiKz86Ye7xfQZPbw9GqJw=;
        b=rZf3/avtFUAt+2cE8N7BG0rrQ6Xi3NsIH5YpZTxTgfZwRdDFQJ8I2VipPtYdqhturR
         A/joLEDe259e2RdIkFdQEA1fbsLlFJcdOdBseHAg6M1MV5kvT2oRtrid7eRLDWMZnErC
         bPNMVJ8pO2PupMpqQ59x489KhZNRMm8E5ak2bCB6g2ygsl/20eN2NqevcbGIyXjR6Sre
         yB40Ow6LZ3pTsDRUTdpFbA+zUXoxOirr80ZGPkT2JOyOwBmCRebqJW9wPuXRZqEqsSqq
         +CzKHriUK11hkosJ9MZZi1ppg6YuvCBc3akwcDdUh5G9+9Pb2D/R9c0AZ3ZD1NU7X620
         RxGg==
X-Gm-Message-State: APjAAAXVQ6gWj3mlKEXFNnDoPxlAhLb63cZwV+B3s89b28HIwq9sNIGH
        orLQasTM7ThEuRTFKdMbtqBv3x6f
X-Google-Smtp-Source: APXvYqzYfOsjUPOR+uc6h2mJaHiF4+Jr5EouxC6Iz2sou07YgZNeWmVgYttb9wypjqCvMlfRsxT1ig==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr37271492wmu.137.1563374510881;
        Wed, 17 Jul 2019 07:41:50 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:50 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to `--edit-todo' and co.
Date:   Wed, 17 Jul 2019 16:39:09 +0200
Message-Id: <20190717143918.7406-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
dropped a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when resuming a
rebase (with `rebase --continue'), when editing the todo list (with
`rebase --edit-todo'), or when reloading the todo list after an `exec'
command.

The idea to extend this feature was suggested to me more than a year ago
by Phillip Wood, if I'm not mistaken.  I postponed this until four month
ago, when ag/sequencer-reduce-rewriting-todo finally hit master, but I
had to stop because of other obligations.  I could go back to work one
month ago, when I did the bulk of this series, but I lacked time to
polish it, so it waited a bit more.  Now, I think it is in a good shape
to be sent, although it is still RFC-quality to me.  The advertised
functionality should work well, but perhaps there is some flaws I
missed.

The first two patches are new tests, demonstrating that after the
initial edit, the check is not done.  The next four are what could be
qualified as omissions from ag/sequencer-reduce-rewriting-todo, but they
are quite important (IMHO) for the rest of the series.  The last three
actually extend rebase.missingCommitsCheck.

This is based on master (9d418600f4, "The fifth batch").

The tip of this series is tagged as "edit-todo-drop-rfc" in
https://github.com/agrn/git.

Alban Gruin (9):
  t3404: demonstrate that --edit-todo does not check for dropped commits
  t3429: demonstrate that rebase exec does not check for dropped commits
  sequencer: update `total_nr' when adding an item to a todo list
  sequencer: update `done_nr' when skipping commands in a todo list
  sequencer: move the code writing total_nr on the disk to a new
    function
  sequencer: add a parameter to sequencer_continue() to accept a todo
    list
  rebase-interactive: todo_list_check() also uses the done list
  rebase-interactive: warn if commit is dropped with --edit-todo
  sequencer: have read_populate_todo() check for dropped commits

 builtin/rebase.c              |  2 +-
 builtin/revert.c              |  2 +-
 rebase-interactive.c          | 67 +++++++++++++++++++++++-----
 rebase-interactive.h          |  6 ++-
 sequencer.c                   | 53 ++++++++++++++--------
 sequencer.h                   |  3 +-
 t/t3404-rebase-interactive.sh | 82 +++++++++++++++++++++++++++++++++++
 t/t3429-rebase-edit-todo.sh   | 44 ++++++++++++++++++-
 8 files changed, 224 insertions(+), 35 deletions(-)

-- 
2.22.0

