Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7AF211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeK3JGI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:08 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43297 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:08 -0500
Received: by mail-lf1-f45.google.com with SMTP id u18so2616458lff.10
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJWSebu9hRbBNujOKBT+GL62fkmoJCsEgWfy6ko3Hw4=;
        b=S2GbiVUlB/eljd6ah+82X4xaN/agsccafXl6vum6jqdgRWcIj8p0L9EpMjSMfIb1+g
         m8L7j9op8H28euwga31GAWpLK5RvIZssEu6riDXIHG7AWPsmGWaY3soWllpkniteJS1s
         +Ct6TGbmDOFy9axSxpHNedDIbC5ausgc/ak6bgdwYjgsAjnuX7WxmfsXFlE+twMSn4l6
         ZyXO0XxEkjQaECdb1zrcJD907qyCp1jsg1Th+7hnprGJYpHZ4tMyf5oZplVuCFdbqDJz
         QOK+scGm3vfGGiHCFVxfitSkkmmr8E2B2i6cxvjqlSLdsJpT0F1hOvobEbzlp4afOeT7
         pErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJWSebu9hRbBNujOKBT+GL62fkmoJCsEgWfy6ko3Hw4=;
        b=N0YV/trUkA425uuTPqHU+JCKcuLQwDI7qoXj47z9bV6sWEhUrPp4NsMVFWWfOk+nmL
         qoF4pjWgDuQih4XsZjOs4ZnkukjFoMJQgjEcc6SI0msnakAAj9QPgpbde9fINsSn9hek
         19UyxQH4cG2qzE4SpFjht6vUlL2KPeKIZEifXjg8mRCaMDnz8VdpchD7lVYHBofFR+fE
         d/Z4AhP4j1PhAF/YRQXg9Hrd816lyX8oXb4pYDTI5Xo7qSfiuqm9nzzqtayGCMHaTH9q
         RaM7VZTq2pI5osFYxIffxyMDpOZ/0m5cMxhZ19ndMcQI1dLjjNERKyatF6P0TMDTRYbt
         waGw==
X-Gm-Message-State: AA+aEWZ6NKLA+TmlbOSoKfgAxwRRn5+eYC48PkJWx6dFbWC+lAYrryGv
        fwVHa7+6171fqYfOf08cux4=
X-Google-Smtp-Source: AFSGD/X52bQzg8w2F/XikkfyQ1AomvwbbXBtj88ItHm0Zi3kyN4StwgjlXA9Fx5uNmqdnl5fZncmcQ==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr2270908lfd.9.1543528752069;
        Thu, 29 Nov 2018 13:59:12 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:10 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
Date:   Thu, 29 Nov 2018 22:58:35 +0100
Message-Id: <20181129215850.7278-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 sees switch-branch go back to switch-branch (in v2 it was
checkout-branch). checkout-files is also renamed restore-files (v1 was
restore-paths). Hopefully we won't see another rename.

I'll try to summarize the differences between the new commands and
'git checkout' down here, but you're welcome to just head to 07/14 and
read the new man pages.

'git switch-branch'

- does not "do nothing", you have to either switch branch, create a
  new branch, or detach. "git switch-branch" with no arguments is
  rejected.

- implicit detaching is rejected. If you need to detach, you need to
  give --detach. Or stick to 'git checkout'.

- -b/-B is renamed to -c/-C with long option names

- of course does not accept pathspec

'git restore-files'

- takes a ref from --from argument, not as a free ref. As a result,
  '--' is no longer needed. All non-option arguments are pathspec

- pathspec is mandatory, you can't do "git restore-files" without any
  pathspec.

- I just remember -p which is allowed to take no pathspec :( I'll fix
  it later.

- Two more fancy features (the "git checkout --index" being the
  default mode and the backup log for accidental overwrites) are of
  course still missing. But they are coming.

I did not go replace "detached HEAD" with "unnamed branch" (or "no
branch") everywhere because I think a unique term is still good to
refer to this concept. Or maybe "no branch" is good enough. I dunno.

Nguyễn Thái Ngọc Duy (14):
  git-checkout.txt: fix one syntax line
  git-checkout.txt: split detached head section out
  checkout: factor out some code in parse_branchname_arg()
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' and 'dwim_..' to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split into switch-branch and restore-files
  switch-branch: better names for -b and -B
  switch-branch: stop accepting pathspec
  switch-branch: reject "do nothing" case
  switch-branch: only allow explicit detached HEAD
  restore-files: take tree-ish from --from option instead
  restore-files: make pathspec mandatory
  doc: promote "git switch-branch" and "git restore-files"

 .gitignore                             |   2 +
 Documentation/config/advice.txt        |  10 +-
 Documentation/config/checkout.txt      |   5 +-
 Documentation/detach-head.txt          | 132 +++++++++
 Documentation/git-branch.txt           |   8 +-
 Documentation/git-check-ref-format.txt |   2 +-
 Documentation/git-checkout.txt         | 140 +--------
 Documentation/git-format-patch.txt     |   2 +-
 Documentation/git-merge-base.txt       |   2 +-
 Documentation/git-rebase.txt           |   2 +-
 Documentation/git-remote.txt           |   2 +-
 Documentation/git-rerere.txt           |  10 +-
 Documentation/git-reset.txt            |  18 +-
 Documentation/git-restore-files.txt    | 167 +++++++++++
 Documentation/git-revert.txt           |   2 +-
 Documentation/git-stash.txt            |   6 +-
 Documentation/git-switch-branch.txt    | 289 +++++++++++++++++++
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitcli.txt               |   4 +-
 Documentation/gitcore-tutorial.txt     |  18 +-
 Documentation/giteveryday.txt          |  24 +-
 Documentation/githooks.txt             |   5 +-
 Documentation/gittutorial-2.txt        |   2 +-
 Documentation/gittutorial.txt          |   4 +-
 Documentation/revisions.txt            |   2 +-
 Documentation/user-manual.txt          |  54 ++--
 Makefile                               |   2 +
 advice.c                               |  11 +-
 builtin.h                              |   2 +
 builtin/checkout.c                     | 380 ++++++++++++++++++-------
 command-list.txt                       |   4 +-
 git.c                                  |   2 +
 parse-options-cb.c                     |  16 ++
 parse-options.h                        |   3 +-
 sha1-name.c                            |   2 +-
 wt-status.c                            |   2 +-
 36 files changed, 1006 insertions(+), 332 deletions(-)
 create mode 100644 Documentation/detach-head.txt
 create mode 100644 Documentation/git-restore-files.txt
 create mode 100644 Documentation/git-switch-branch.txt

-- 
2.20.0.rc1.380.g3eb999425c.dirty

