Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEDC1F454
	for <e@80x24.org>; Wed, 26 Sep 2018 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeI0Av3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:51:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeI0Av3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:51:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id y13-v6so3420024wmi.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=50ccNn8SEcBXoIFPgSG40RsmaUyKRlXZNHUG5hAjwI4=;
        b=G8iyc8+EkcVAAEGgjs1AffbTHTpHOPMQW5wT939ZPkV6SxK7RNJpOSi3s68Lc57CKy
         CXI1d5RAlbRPElkyVVVKyYPWwSIKRKQs9clYUIlW6a7LE2J/tFwyEhykLSYxHTt3mlEk
         oMwPkGCmwA9wJ0XCr7/Wg7NOaxVOSKjUL3abeElksNCQq8n/rzmtHtn/r4y57zXC1c77
         CcDqgdNjbnKR9QnStersQXl8EiOKyq6h4Gu6yn+ziy3x4zcxH88/T/8nGH+DfSNRDcye
         7XmWziIcniIwbKJJileLCInipTmtnrIZPMzi/QQohJpZPavuCRaExP6qeUcMTDpomi2F
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=50ccNn8SEcBXoIFPgSG40RsmaUyKRlXZNHUG5hAjwI4=;
        b=Cht4HBzI0jwOVsS7dzgSi7rOi5dPjicezUfefOA4LmylnGz9ZDypXkgcWKMMk6DshS
         IlFPw6889r4RZROQip1xOIdsyzCn+alxzNTTGQz6JlN+0DjLvIUL9IrKJMtZrNYh+0Ve
         IBa4gUUp3KXnm1UNCYwapLckIJCcLiL8at1bPQXp1HaqKvV8dkOR1eH+MuDC2YKoswX0
         ZyelvbUv8loUHcgIDHvkbWJqPJ3LYcZ2SiinqFPCQYTE692ZCRhhTEiRKXllK47R6tBs
         vD7BTdK/2k2Z7IhaGoZjOdTN1k12qp0tU7WEKCNy3NhvcmVUbXAzMigG+0RU9vFd/Xa/
         rREw==
X-Gm-Message-State: ABuFfogaiwYnHwnaQTi+iiBN8L1b5bExv8JcZdUwZh3/3NG530x38S5m
        8aB0yOQZtCJPL0oxtMHRF7I=
X-Google-Smtp-Source: ACcGV60UhrFXhBtzDZhqqnfLZAb/kWBvufQkZkfrv0z/+Yh4Osc5XblAZcRPCckbipaaVCQkm1cBfQ==
X-Received: by 2002:a1c:1ec5:: with SMTP id e188-v6mr5472271wme.1.1537987031215;
        Wed, 26 Sep 2018 11:37:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d6-v6sm170611wmd.2.2018.09.26.11.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:37:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 00/21] Convert "git stash" to C builtin
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
        <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
Date:   Wed, 26 Sep 2018 11:37:09 -0700
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Wed, 26 Sep 2018 01:33:11
        +0300")
Message-ID: <xmqq8t3oksve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Hello,
>
> This is a new iteration of `git stash`, based on the last review I got.
> This new iteration brings mostly code styling fix issues in order to make
> the code more readable. There is also a new patch "strbuf.c: add
> `strbuf_join_argv()`". By making some small changes, the code is now a
> little bit closer to be used as API.
>
> Joel Teichroeb (5):
>   stash: improve option parsing test coverage
>   stash: convert apply to builtin
>   stash: convert drop and clear to builtin
>   stash: convert branch to builtin
>   stash: convert pop to builtin
>
> Paul-Sebastian Ungureanu (16):
>   sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>   strbuf.c: add `strbuf_join_argv()`
>   stash: update test cases conform to coding guidelines
>   stash: rename test cases to be more descriptive
>   stash: add tests for `git stash show` config
>   stash: convert list to builtin
>   stash: convert show to builtin
>   stash: mention options in `show` synopsis.
>   stash: convert store to builtin
>   stash: convert create to builtin
>   stash: convert push to builtin
>   stash: make push -q quiet
>   stash: convert save to builtin
>   stash: convert `stash--helper.c` into `stash.c`
>   stash: optimize `get_untracked_files()` and `check_changes()`
>   stash: replace all `write-tree` child processes with API calls

Here is how these appear in my MUA.  I am guessing that 03/21 is the
right copy and 02/21 that appear after 21/21 is a duplicat that I
should not even look at (the same for 4 other ones with [GSoC]
label)?

   [  53: PSU] [PATCH v9 00/21] Convert "git stash" to C builtin
    [  57: PSU] [PATCH v9 01/21] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
    [  56: PSU] [PATCH v9 02/21] strbuf.c: add `strbuf_join_argv()`
    [  68: PSU] [PATCH v9 03/21] stash: improve option parsing test coverage
    [ 378: PSU] [PATCH v9 04/21] stash: update test cases conform to coding guidelines
    [  78: PSU] [PATCH v9 05/21] stash: rename test cases to be more descriptive
    [ 102: PSU] [PATCH v9 06/21] stash: add tests for `git stash show` config
    [ 632: PSU] [PATCH v9 07/21] stash: convert apply to builtin
    [ 199: PSU] [PATCH v9 08/21] stash: convert drop and clear to builtin
    [ 132: PSU] [PATCH v9 09/21] stash: convert branch to builtin
    [ 151: PSU] [PATCH v9 10/21] stash: convert pop to builtin
    [ 100: PSU] [PATCH v9 11/21] stash: convert list to builtin
    [ 296: PSU] [PATCH v9 12/21] stash: convert show to builtin
    [  56: PSU] [PATCH v9 13/21] stash: mention options in `show` synopsis.
    [ 165: PSU] [PATCH v9 14/21] stash: convert store to builtin
    [ 513: PSU] [PATCH v9 15/21] stash: convert create to builtin
    [ 339: PSU] [PATCH v9 16/21] stash: convert push to builtin
    [ 195: PSU] [PATCH v9 17/21] stash: make push -q quiet
    [ 430: PSU] [PATCH v9 18/21] stash: convert save to builtin
    [ 575: PSU] [PATCH v9 19/21] stash: convert `stash--helper.c` into `stash.c`
    [ 156: PSU] [PATCH v9 20/21] stash: optimize `get_untracked_files()` and `check_changes()`
    [ 130: PSU] [PATCH v9 21/21] stash: replace all `write-tree` child processes with API calls
   [  68: PSU] [GSoC][PATCH v9 02/21] stash: improve option parsing test coverage
   [ 378: PSU] [GSoC][PATCH v9 03/21] stash: update test cases conform to coding guidelines
   [  78: PSU] [GSoC][PATCH v9 04/21] stash: rename test cases to be more descriptive
   [ 102: PSU] [GSoC][PATCH v9 05/21] stash: add tests for `git stash show` config
   [  55: PSU] [GSoC][PATCH v9 06/21] strbuf.c: add `strbuf_join_argv()`

Thanks.

>
>  Documentation/git-stash.txt  |    4 +-
>  Makefile                     |    2 +-
>  builtin.h                    |    1 +
>  builtin/stash.c              | 1595 ++++++++++++++++++++++++++++++++++
>  cache.h                      |    1 +
>  git-stash.sh                 |  752 ----------------
>  git.c                        |    1 +
>  sha1-name.c                  |   19 +
>  strbuf.c                     |   15 +
>  strbuf.h                     |    7 +
>  t/t3903-stash.sh             |  192 ++--
>  t/t3907-stash-show-config.sh |   83 ++
>  12 files changed, 1851 insertions(+), 821 deletions(-)
>  create mode 100644 builtin/stash.c
>  delete mode 100755 git-stash.sh
>  create mode 100755 t/t3907-stash-show-config.sh
