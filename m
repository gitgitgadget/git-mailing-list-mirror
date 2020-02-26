Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CECC4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2080222C2
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGw66RaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBZKQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55752 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2299207wmj.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ApF8omRMb4ahLbzg0ivu2WjyQ0oftdDyuoUNycZfSM=;
        b=XGw66RaBn2h0N+FJYKDuo9fahufjGE8uiKomKh7XFs+Zdvo3jpiXa+zlr4oAfrXpDg
         +YgTvJFRvUaFP64uQRn4pmYOoPjpsO8vsUbO+FxO+M+I2AVk/7Dv9cq4UFw32RF6MTOa
         VBjwMCpcgcKZ/WIhMzL5S+YM/0xbTcrrJjMeqdqgGkmNM/qxpJZ8v+3vJ99eW7djo3/G
         yeYtPIryBp6pP4+DJ52TBnCz2aX2wN3xsoBkX8IpGOikCYzzTlwWkK+AA2kHUzKKR1rM
         3oR8Zv6sZ8WTU5QvdO1wcter/ZZ96qtpHakNIWsy8uAvK9/U4U1kfQVqUmRZyPcRLt4V
         wBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ApF8omRMb4ahLbzg0ivu2WjyQ0oftdDyuoUNycZfSM=;
        b=UgohttlKoJDhJRzAFnmRdCHTw/hfkwwTTrr7fvknWlN0p8+7aUVPO5WT/+qgN48Pmu
         ph+UxCUHqOXsedlm/SzaOrxzZij/jzzuvt97Un0kkhzuKFNcepJD+cVZx7w5sbv8naZ1
         mc9Imdc/hQHq/aX/rJc7U+t5Q1nr/KmlAhDg/Du5nohijTHh2mgoA8cYGMDkxKq/IIk7
         8OKxKAHHs8/aIs30rADpW6V0CKEZ6Wp37U3rUYABYz5xWDfpm6t4xeH5JkChdQlF9mbc
         M6qct7TZ0boMWWgG2Xzku0a+YUINggWs/n2I+4vM0ioN/PTNI2mAZuKa6z/QYP7CF+bo
         DmYA==
X-Gm-Message-State: APjAAAUqzcDI828koB2voisWp4cncX8fx5oUCvD3LhzZxZ8I3onivwjr
        8bEZox7upGlOV4NKFWpB7mMGg60D
X-Google-Smtp-Source: APXvYqwG8boHlTPqmIVZWwUTczERGzblkHgyBzKMFNqv52yXtDo0JtPjKMwjPummFaXWXxn800bNug==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4575636wma.24.1582712165456;
        Wed, 26 Feb 2020 02:16:05 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:04 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy][PATCH 00/10] Finish converting git bisect to C part 2
Date:   Wed, 26 Feb 2020 11:14:19 +0100
Message-Id: <20200226101429.81327-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This second part depends on mr/bisect-in-c-1 and it is formed by 
reimplementations of some `git bisect` subcommands and removal of some
temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2.

General changes
---------------

* Rebase on next branch: 5900a2a8f9 (Sync with master, 2020-02-25).
* Improve commit messages.
* Amend patch series titles.
* Reorder commits.

Specific changes
----------------

[1/10] bisect--helper: introduce new `write_in_file()` function

* New patch to refactor code in `write_in_file()` function and use it in
`write_terms()`.

--

[2/10] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C

* Fix `repo_init_revisions()` and bisect_next_all` calls after 
rebase on master.
* Add blank line.
* Remove goto statements in `bisect_skipped_commits()`.
* Add `clear_commit_marks()` in `process_skipped_commits()`.
* Use `write_in_file()` in `bisect_successful()`.
* Change header return type and internal returns to enum in 
`bisect_next()` and `bisect_auto_next()`.
* Improve code comments.

--

[3/10] bisect--helper: finish porting `bisect_start()` to C

* Change header return type and internal returns to enum in `bisect_start()`.
* Improve code comments. 

--

[6/10] bisect--helper: reimplement `bisect_autostart` shell function in C

* Change an internal return to enum in `bisect_autostart()`.

--

[7/10] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C

* Change header return type and internal returns to enum in `bisect_state()`.

--

Miriam Rubio (1):
  bisect--helper: introduce new `write_in_file()` function

Pranit Bauva (9):
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 bisect.c                 |  11 ++
 builtin/bisect--helper.c | 388 ++++++++++++++++++++++++++++++++++-----
 git-bisect.sh            | 145 +--------------
 3 files changed, 358 insertions(+), 186 deletions(-)

-- 
2.25.0

