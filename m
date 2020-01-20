Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BACC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5E22464
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ6bHq0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATOib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:31 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36076 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOib (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:31 -0500
Received: by mail-wr1-f45.google.com with SMTP id z3so29847007wru.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfwvOlUBhCH+YRiQ6Wy1cfLJ97fGb59Bi/ITgp/OJkg=;
        b=kQ6bHq0pdzPlIAM8A/itZ/G8zKS0/M/dZsrx0P5Uer9NQbF+OR8bTolVtWoBbhxzwX
         Rxwco9mIyIHwTiqwjgG99dsVxwcwcw0sQm+MVrHLutXPDfgImGbfISmCB29+5WKlHECw
         ZCdT/Z4gYpVRIekMio+rSoN4FhPY5WU08lIjYL34UVYsonzi5yjbnZYe1dqOLs6Jc+4k
         27AQqZwdI7tCXL6w9JwjJHvWRrScu40VQ/peP+8XdNzh3dHyba1BsTVTL+vJO1p8vqPR
         pec1ON3W7QxvXmYP3gGdoHq+fOse2+GngwaVN+JUyMunuMQ0tinQ+whJRL1paqxe+BSD
         HQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfwvOlUBhCH+YRiQ6Wy1cfLJ97fGb59Bi/ITgp/OJkg=;
        b=Ekltuq5BW22DCw8vgj17UBZuhx0JnRbwfXjcPlgXvh+tMlJf4q7ImWdC0bvhkyG4ee
         HlrJ4+/7SrnXbDqf4hMusHNCqVzPb9Fy0eA7JHFmHXg3SH2UvH8Rqd8FHONsKewuQtZa
         43I8OchJQ1hoWP2Jjl7dt3D3rboagxIRk4xl6iQ9lcASB4Zgkq5K92uK9UmX9BWkw5EG
         8APLR5cxmb8RAAQgqjKQ3a395OWI8716SgWbGhyndS5bCdPL38KtCfLZ8oXy0wz0/4xt
         4TaIaPmRUpqkq9I3XdPxYOy2rxWSXWW1Nf9HZQOnudB+jeiPWabnWz4QLdA4/BcJXfak
         R2XQ==
X-Gm-Message-State: APjAAAUnnIcWUVJb3oVUQMkW5J4tJS6cOwPTFaid8jMDMjXFX2ycVlnh
        aLzGiz++nbkjx9qZyal+S5iYeDGD
X-Google-Smtp-Source: APXvYqwkrfZ/nrVDQX9ZmfcfISLeAMxkHfAmkWGtfFp8Wf1l7ft8qW4av22ZTp8MkCAr4aRKID5AIQ==
X-Received: by 2002:adf:a109:: with SMTP id o9mr18739133wro.189.1579531108935;
        Mon, 20 Jan 2020 06:38:28 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:28 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy][PATCH 00/29] Finish converting git bisect to C part 1
Date:   Mon, 20 Jan 2020 15:37:31 +0100
Message-Id: <20200120143800.900-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--- Changes since Tanushree’s pr117 sent patch series:
https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) ---

General changes
---------------

* Rebase on master branch.
* Improve commit messages.
* Amend patch series titles.
* Reorder commits: first clean-up/preparatory commits, squash or split 
commits.

Specific changes
----------------

[1/29] bisect--helper: convert `vocab_*` char pointers to char arrays

* New patch to convert `vocab_bad` and `vocab_good` char pointers 
to char arrays
 
--

[2/29] bisect--helper: change `retval` to `res`

* Replace one last variable `retval` to `res`.

--

[3/29] bisect: use the standard 'if (!var)' way to check for 0

* New patch to use '!var' and make 'bisect.c' more consistent with the
rest of the code

--

[4/29] run-command: make `exists_in_PATH()` non-static

* Add comment before function declaration.
* Move function declaration in `run-command.h`.

--

[6/29] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` 
and its dependents
    
* Fix `mark_edges_uninteresting()` and `show_diff_tree()` calls after 
rebase on master.

--

[7/29] bisect: libify `bisect_checkout`
    
* Fix `memcpy()` call after rebase on master.
* Introduce `res` variable to return `bisect_checkout()` output. 
* Fix `get_commit_reference()` declaration after rebase on master.

--

[8/29] bisect: libify `check_merge_bases` and its dependents

State: Previously sent

* Fix `check_ancestors()` declaration after rebase on master.
* Fix `get_bad_and_good_commits()` call after rebase on master.

--

[9/29] bisect: libify `check_good_are_ancestors_of_bad` and its 
dependents

State: Previously sent

* Fix `check_good_are_ancestors_of_bad()` declaration after rebase on 
master.
* Fix `check_good_are_ancestors_of_bad()`, `bisect_next_all()`
and `bisect_rev_setup()` calls after rebase on master.

--

[11/29] bisect: libify `bisect_next_all`

State: Previously sent

* Fix `show_diff_tree()` call after rebase on master.

--

[12/29] bisect--helper: reimplement `bisect_next` and `bisect_auto_next`
shell functions in C

* Fix `repo_init_revisions()` and `bisect_next_all()` calls after rebase
on master.
* Remove `goto` statement in `bisect_skipped_commits()`

--

[13/29] bisect--helper: finish porting `bisect_start()` to C

* Change `return` statement instead of `die` in error handling.
* Remove `goto` statements in `bisect_skipped_commits()`.

--

[21/29] bisect--helper: reimplement `bisect_replay` shell function in C

* Add blank line in `get_next_word()`.
* Remove `goto` statements in `bisect_replay()`.

--

[23/29] bisect--helper: use `res` instead of return in BISECT_RESET case
option

* New patch to split previous commit in two.

--

[26/29] bisect--helper: reimplement `bisect_skip` shell function in C

State: Previously sent

* Add blank line.

--

[28/29] bisect--helper: reimplement `bisect_visualize()`shell function 
in C

New patch:

* Reimplement the `bisect_visualize()` shell function in C.
* Add `--bisect-visualize` subcommand.
* Fix long code line.

--

[29/29] bisect--helper: reimplement `bisect_run` shell function in C

New patch:

* Reimplement the `bisect_run()` shell function in C.
* Add `--bisect-run` subcommand.
* Remove blank line.

--

Miriam Rubio (2):
  bisect--helper: convert `vocab_*` char pointers to char arrays
  bisect: use the standard 'if (!var)' way to check for 0

Pranit Bauva (24):
  run-command: make `exists_in_PATH()` non-static
  bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
    its dependents
  bisect: libify `bisect_checkout`
  bisect: libify `check_merge_bases` and its dependents
  bisect: libify `check_good_are_ancestors_of_bad` and its dependents
  bisect: libify `handle_bad_merge_base` and its dependents
  bisect: libify `bisect_next_all`
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
  bisect--helper: reimplement `bisect_log` shell function in C
  bisect--helper: reimplement `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: use `res` instead of return in BISECT_RESET case
    option
  bisect--helper: retire `--bisect-autostart` subcommand
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: reimplement `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (3):
  bisect--helper: change `retval` to `res`
  bisect--helper: introduce new `decide_next()` function
  bisect--helper: reimplement `bisect_run` shell function in C

 bisect.c                 | 146 +++++---
 builtin/bisect--helper.c | 776 +++++++++++++++++++++++++++++++++------
 git-bisect.sh            | 279 +-------------
 run-command.c            |   2 +-
 run-command.h            |  11 +
 5 files changed, 793 insertions(+), 421 deletions(-)

-- 
2.21.1 (Apple Git-122.3)

