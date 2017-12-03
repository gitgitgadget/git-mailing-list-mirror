Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F295120C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbdLCWR7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:17:59 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:42105 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdLCWR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:17:58 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so8419046itb.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/9cvefXJmGaQlYbwG/GC7XxoUGAmGaqBLHSNxlVWGQ=;
        b=SuJpoWRPxcA8vDKnXZHtdZhWoylQhYP8HCF6KVCaCCSnIZOfiJwmxHUS49pIq2UH/1
         GGpnMgjwO6UU5FP5/pMtKS0oHe1CZ4LnfmNhd88D8chx5bzwPGxy7vf0HLrsa1V+n5FI
         CUofXlwFyi/eUkSbjLae0VefcYi1wwvX6mOBBEjFWyb1j7oUl2/hao1e6CcXEc5eCDgX
         a8oc2sQLcURzY0ROJI8kMYSsu5JpbJVhH2ADAmric0LGsUycj4hEJwdfzxdgbPlpAbLy
         H171OBIRHB+lwDISNc1g1kNUC8rAEqrWhCBmCr06lhKw3z8f2tL4Izo/MZQRBLVuYFdf
         YRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/9cvefXJmGaQlYbwG/GC7XxoUGAmGaqBLHSNxlVWGQ=;
        b=KoetMSshAYxtj63E5fh421RIozPI4tC9BU8BKtzpc2RkxhxWixezVJjssQ/hZWH6Hw
         xGXUbztny997hJy6dtHu3NLIFeB3O6dJKRo1HOSVhsCpldAwnD+VXvTlO2e5qId67RBE
         fWsf6gCw3D3kiOe0iq/Xr+CGLE+kpq/Hy/JfFmiiusVzUqjHPPBiGOl+psamKuZCc5D1
         fI0NIi6/KFn2TrcF3pUUKt/FwKMN3+q8s6Hqrdlr772c8MU/AuRbaTguK78PYlvI8s7s
         1f+DErNVgEtzvGsZyrG4cclnfNtJtaKqnBh0ue/y2V9iQsTKvz9OKholUNAURGVD7ste
         yM1A==
X-Gm-Message-State: AJaThX5mx/H7WDt2EbSee/E7TARxsRu78+QUQqXskq8vaNeHRlGJd/BD
        SprBes+IzBbk/BnErQHSZfnmlh/6
X-Google-Smtp-Source: AGs4zMaRcYPgzo1It4AjQQxViGuwISbtKDlW5dss4wj18Nls8ehzCwN5N+NSRWgi3t3+9nPHy1whBA==
X-Received: by 10.107.107.23 with SMTP id g23mr22282911ioc.283.1512339477476;
        Sun, 03 Dec 2017 14:17:57 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:17:56 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 0/9] rebase -i: add config to abbreviate command names
Date:   Sun,  3 Dec 2017 17:17:12 -0500
Message-Id: <20171203221721.16462-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

This series will add the 'rebase.abbreviateCommands' configuration
option to allow `git rebase -i` to default to the single-letter command
names when generating the todo list.

Using single-letter command names can present two benefits. First, it
makes it easier to change the action since you only need to replace a
single character (i.e.: in vim "r<character>" instead of
"ciw<character>").  Second, using this with a large enough value of
'core.abbrev' enables the lines of the todo list to remain aligned
making the files easier to read.

Changes in V2:
- Refactor and rename 'transform_todo_ids'
- Replace SHA-1 by OID in rebase--helper.c
- Update todo list related functions to take a generic 'flags' parameter
- Rename 'add_exec_commands' function to 'sequencer_add_exec_commands'
- Rename 'add-exec' option to 'add-exec-commands'
- Use 'strbur_read_file' instead of rewriting it
- Make 'command_to_char' return 'comment_char_line' if no single-letter
  command name is defined
- Combine both tests into a single test case
- Update commit messages

Liam Beguin (9):
  Documentation: move rebase.* configs to new file
  Documentation: use preferred name for the 'todo list' script
  rebase -i: set commit to null in exec commands
  rebase -i: refactor transform_todo_ids
  rebase -i: replace reference to sha1 with oid
  rebase -i: update functions to use a flags parameter
  rebase -i -x: add exec commands via the rebase--helper
  rebase -i: learn to abbreviate command names
  t3404: add test case for abbreviated commands

 Documentation/config.txt        |  31 +-------
 Documentation/git-rebase.txt    |  19 +----
 Documentation/rebase-config.txt |  52 +++++++++++++
 builtin/rebase--helper.c        |  29 +++++---
 git-rebase--interactive.sh      |  23 +-----
 sequencer.c                     | 126 +++++++++++++++++++++-----------
 sequencer.h                     |  10 ++-
 t/t3404-rebase-interactive.sh   |  22 ++++++
 8 files changed, 186 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

-- 
2.15.1.280.g10402c1f5b5c

