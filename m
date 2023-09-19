Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C8CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjISUAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjISUAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 16:00:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7949D
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 13:00:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf6e47b5efso50065805ad.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695153641; x=1695758441; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmRWr6WiSoRCUhhenZjVuCVKqdOOE3L4/s5NdbEYGA8=;
        b=HC0gUiAP8wbC76ZXJeuIEfBBI6SwEBmJ5QJsPTPAcYxvUnM3ULZf+RN0bMuwiepSMC
         +KVQeBTajNyLZCQAd9Hb6SUbTfvdKlFLwqrnWsfN8VH2Yt4zN58+Rt+nga3FtU3dpUyn
         KJRWstZ5EgSvqUb2w49qbQhhIKikb+go6WldMURbQJRc/XIWr+3opbqFWdndX19QtqI3
         6k/8sb+XJi6nfXwKX024qabG7o7KO27N0IdtomBQRr3+JQq9CGRYAAYqzPUNCp5/F0zY
         YDVzlRyg2qRKyeUght6Qgh0t2fI9UEghAw1dk53AJSguq/hsiTU/58A4McdvKIMl1fIv
         rJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695153641; x=1695758441;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmRWr6WiSoRCUhhenZjVuCVKqdOOE3L4/s5NdbEYGA8=;
        b=xDND8o2C0UqI5w5cC0uDEXaBs1zfvKKFWh0If/tajxUyV9d9Q5EynQ6+BbUNrGY3hB
         TfrI+ZX1GZsOfhZyAzzlTPGVFjin3O8C8VGGYWIXf0H/UoobYOtUHNLEno907aH12K6y
         MLL2wF7sz1zkAQEtoVw2HRQHAA2KyN9/Z4zvQE3seVt3EzBveTW66LRVuSVgtp0BdTd6
         kY0RmSDbhSXd6sVhB0nMrrbGcTgDpBRrcZol0k4eqXEhvoSjqP94ctyy4BehLx5X64dY
         3KJ/PWsayWEOz4P3i7kpKsvEWmAlVJZ1c299SO4NaEofVWzEgeuvqP1RgwqY/gXDMQqg
         78QA==
X-Gm-Message-State: AOJu0YwT/HO7rWOQuQsmNgtFQTT/aviRRanFu8Mv9Xtf1W8LsbI/xsM4
        86mCK5j+zS+BCFG5Glxdhl9pwdbkqe4=
X-Google-Smtp-Source: AGHT+IE6+tA+yrvG0zf1C1ZXmkHYHqdPYF6wrnHFGev2O2OrmQZbAfY8/n+NgOgiM6o60uCRMWu5EXTC8CE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:f545:b0:1c3:e2eb:f7ba with SMTP id
 h5-20020a170902f54500b001c3e2ebf7bamr4330plf.13.1695153641006; Tue, 19 Sep
 2023 13:00:41 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:00:38 -0700
In-Reply-To: <xmqqmsxmdhdw.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqmsxmdhdw.fsf@gitster.g>
Message-ID: <owly7comj5ll.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> [Cooking]
>
> [...]
>
> * la/trailer-cleanups (2023-09-11) 6 commits
>   (merged to 'next' on 2023-09-12 at 779c4a097a)
>  + trailer: use offsets for trailer_start/trailer_end
>  + trailer: rename *_DEFAULT enums to *_UNSPECIFIED
>  + trailer: teach find_patch_start about --no-divider
>  + trailer: split process_command_line_args into separate functions
>  + trailer: split process_input_file into separate pieces
>  + trailer: separate public from internal portion of trailer_iterator
>
>  Code clean-up.
>
>  Will merge to 'master'.
>  source: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>

This isn't ready yet (still need to reroll).

> [...]
>
> * la/trailer-test-and-doc-updates (2023-09-07) 13 commits
>  - trailer doc: <token> is a <key> or <keyAlias>, not both
>  - trailer doc: separator within key suppresses default separator
>  - trailer doc: emphasize the effect of configuration variables
>  - trailer --unfold help: prefer "reformat" over "join"
>  - trailer --parse docs: add explanation for its usefulness
>  - trailer --only-input: prefer "configuration variables" over "rules"
>  - trailer --parse help: expose aliased options
>  - trailer --no-divider help: describe usual "---" meaning
>  - trailer: trailer location is a place, not an action
>  - trailer doc: narrow down scope of --where and related flags
>  - trailer: add tests to check defaulting behavior with --no-* flags
>  - trailer test description: this tests --where=after, not --where=before
>  - trailer tests: make test cases self-contained
>
>  Test coverage for trailers has been improved.
>  source: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>

Did you forget to add "Need more reviews"? Not sure what the status is
for the overall series (modulo your targetd comments for some of the
patches).
