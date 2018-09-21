Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B540D1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbeIUUTr (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:19:47 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41772 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeIUUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:19:47 -0400
Received: by mail-ed1-f50.google.com with SMTP id f38-v6so10898593edd.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Z951MyI6JO91GWB7OjeZSNKgo0oOaCES4OC4k1Na52I=;
        b=kJuYca5QdIUK9fmgAAK25HVkcu3Ty75DiEx3Z9jt9LesotDXuKfzCAa0swnEoEkxHq
         3yLBkrKzJpTdFcP9lEZpl5AuNC7y+lZRyyKOYdQm6iZbLOGZA9qHrRgUlR48GmzN1/vg
         f0VwGVjpTptEHWWJ120Q1qBThYpYz6MChgwE7vHF3I+FWh2Qsl3J/BRJvfYwcHHiic9U
         xqX44SF17gaqncqbZxq8aGhUTRnmSoNuVi0yspptQHkL5f49L4wCs2gWY3BNRwxN0uDv
         iVtK3xoyLpTwesjxjUVJ22U7qykcfDYiMA5OGl4DPVU042YgSLXvZ95LP3g1BBMHOB9a
         l9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Z951MyI6JO91GWB7OjeZSNKgo0oOaCES4OC4k1Na52I=;
        b=PBzqTtxnLdyU7gHoxKKTxgbcmcOd9MHshC3HwxvJFX8IWR1kOg28yO6jnFbKP2BHTr
         MOJie3ibxWtERH0DHDgADTlEPj1vaAii897ZJE7PHhHejx0fD98uQ8+fzTHToC6jYceT
         9q4PEyvd8QnZNx36H9UVLtzvIXMuPsbdfWPV/CXBce+6Tcjf1zwe2GPhVUxmQF6N8Fhr
         1o/t/xzt5tEYEJRD7l/wAZRKkZnJYheuChAXMzg1bO2D8FA6gEPK0SqHJ7l1RfegG8Wg
         bIUCcEqxpDq1gjhC5zz2lv9/69rvk3ntDEhDaMiy+0CZ8z1pg/yCRGU88Tuei1c4Nizn
         n2rA==
X-Gm-Message-State: APzg51DDU4ELQeDNubhG6mJGpCQaii/a+28sdBiW35jqdf8+Zwkq7D0Y
        z249XPrQt9UXvK6n7BKDUM8=
X-Google-Smtp-Source: ANB0VdadP5mJA+GK42FyM1ZuxDBDWycNdULRpkMML6Dv/d0Y2NjwBt9PSrJcxuLVOhRcxB8rd8uV3w==
X-Received: by 2002:a50:b6e3:: with SMTP id f32-v6mr9011443ede.147.1537540237253;
        Fri, 21 Sep 2018 07:30:37 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id g38-v6sm2332247edc.40.2018.09.21.07.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 07:30:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Segfault in master due to 4fbcca4eff
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 21 Sep 2018 16:30:35 +0200
Message-ID: <87pnx6kjn8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Junio C Hamano wrote:

> * ds/reachable (2018-08-28) 19 commits
>   (merged to 'next' on 2018-08-28 at b1634b371d)
>  + commit-reach: correct accidental #include of C file
>   (merged to 'next' on 2018-08-22 at 17f3275afb)
>  + commit-reach: use can_all_from_reach
>  + commit-reach: make can_all_from_reach... linear
>  + commit-reach: replace ref_newer logic
>  + test-reach: test commit_contains
>  + test-reach: test can_all_from_reach_with_flags
>  + test-reach: test reduce_heads
>  + test-reach: test get_merge_bases_many
>  + test-reach: test is_descendant_of
>  + test-reach: test in_merge_bases
>  + test-reach: create new test tool for ref_newer
>  + commit-reach: move can_all_from_reach_with_flags
>  + upload-pack: generalize commit date cutoff
>  + upload-pack: refactor ok_to_give_up()
>  + upload-pack: make reachable() more generic
>  + commit-reach: move commit_contains from ref-filter
>  + commit-reach: move ref_newer from remote.c
>  + commit.h: remove method declarations
>  + commit-reach: move walk methods from commit.c
>
>  The code for computing history reachability has been shuffled,
>  obtained a bunch of new tests to cover them, and then being
>  improved.

There's a segfault now in master when fetching because of 4fbcca4eff
("commit-reach: make can_all_from_reach... linear", 2018-07-20). I have
not had time to debug this, or found an easy isolated test case, but
this script will reliably make it segfault for me:

    #!/bin/sh

    git_dot_git=/home/avar/g/git

    old=v0.99
    new=v0.99.1

    rm -rf /tmp/srv
    rm -rf /tmp/cln
    git init --bare /tmp/srv
    git init --bare /tmp/cln
    $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $old:refs/whatever/ref
    $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
    $git_dot_git/git --exec-path=$git_dot_git push file:///tmp/srv $new:refs/whatever/ref
    if GIT_TRACE=1 $git_dot_git/git --exec-path=$git_dot_git -C /tmp/cln fetch file:///tmp/srv 'refs/*:refs/*'
    then
        exit 0
    else
        exit 1
    fi

I.e. you need to push the v0.99 tag to its own repo, fetch that from
another one, then push v0.99.1, fetch everything, and you'll get a
segfault:

    remote: Resolving deltas: 100% (187/187), completed with 48 local objects.
    To file:///tmp/srv
       d6602ec519..f25a265a34  v0.99.1 -> refs/whatever/ref
    14:26:44.505787 git.c:415               trace: built-in: git fetch file:///tmp/srv 'refs/*:refs/*'
    14:26:44.506708 run-command.c:637       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; 'git-upload-pack '\''/tmp/srv'\'''
    14:26:44.508831 git.c:415               trace: built-in: git upload-pack /tmp/srv
    14:26:44.509953 run-command.c:637       trace: run_command: git rev-list --objects --stdin --not --all --quiet
    Segmentation fault
    fatal: The remote end hung up unexpectedly

Same with refs/tags/ref b.t.w., not just refs/whatever/ref, I just was
initially testing this for some follow-up work on my series for checking
how fetching to various non-heads/tags namespaces works.
