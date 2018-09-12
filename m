Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC071F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeIMA41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:56:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38895 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMA41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:56:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so3680579wmi.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=89AAt1UXUNdwTkVQw/cC/hqLVY+o3TpDnVwDkrBQ2Us=;
        b=VgAK7kiiIdcAdWn7d1nqEoT1R6EVA64RiJqEeDPjMtpAJUaWl7BQPMUhCLpIMCnrbT
         /BNUPS7p/x+mraswulRxEjKRL9a5nbniwmbsP55XyP4FS/pO+D9CCbkKc+E50PBgs9Oe
         WL50GNkLnz6Y0jWRvekLMYZQtryctP6xHBJUc0MVRTOWuuCpb1DyKJLsHuH0hm0cPyJX
         gtkCm7uiGEPCyh3k7/6Fd1Vz/DrlGimkLPEHqrEucNkvQXbu2lbRn9sy7IhX4zr89Wll
         dac1rVz5nToYHSuVtursbr1kCDuzcazRtdHUoIBBAxjWZjbk8ZWCfc69iy6MYLcXPpmY
         ZuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=89AAt1UXUNdwTkVQw/cC/hqLVY+o3TpDnVwDkrBQ2Us=;
        b=fuWa1wRmegZC8EczpieUFcamW3wUXL+fL0aZJ8J2nG56JB71QW4XRoeukAa/Jrl26v
         RSEProt4w2FnFgqtrkmoGqlfrrlElhj13FTlJ7R7B8JdkHUW0/rLmNNnf+0LpJevBu4n
         oBrpIEo+IIXyydrXzkysgamEgMZ+JaNtPuAmobZt0oOBil2BPGHPKt1M6pqkiV0Mey2k
         U8FlvKsQRQlL0bCf9AmbVsPTP+b1MAO1Z2yA9jI9829GW5CXqnru/UjYdeLiZQIPNo07
         R4N/pj8j/XuE4F/fnbtEiVKRZl/fzCwamZYKKNhSB9NJWskhpmDWpLtR/BRlNany3TPq
         SPPQ==
X-Gm-Message-State: APzg51DMxeKx+Z98hP7POvSJt8wV7d+ZbW1TapU3rXbsKRMh8H7JQ88G
        UzDkhDprt/78pb/pkOAiVTY=
X-Google-Smtp-Source: ANB0VdYxQbKhKZkRgL0Ndz1GepD2WdJjCcR6hKpOPzwV4BvKb5F74iZRnCRUk++sNZhDX2jABjjalg==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr2872074wmg.149.1536781820849;
        Wed, 12 Sep 2018 12:50:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w4-v6sm1956754wro.24.2018.09.12.12.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:50:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v4] test_dir_is_empty: fix edge cases with newlines and hyphens
References: <CAPig+cQSg-t6KGj3s0LJi+FU7LSQMNTmSHhMJJH=PgMUU9GWOA@mail.gmail.com>
        <20180912183534.7486-1-wchargin@gmail.com>
Date:   Wed, 12 Sep 2018 12:50:19 -0700
In-Reply-To: <20180912183534.7486-1-wchargin@gmail.com> (William Chargin's
        message of "Wed, 12 Sep 2018 11:35:34 -0700")
Message-ID: <xmqq7ejqlclg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin <wchargin@gmail.com> writes:

> While the `test_dir_is_empty` function appears correct in most normal
> use cases, it can improperly pass if a directory contains a filename
> with a newline, and can improperly fail if an empty directory looks like
> an argument to `ls`. This patch changes the implementation to check that
> the output of `ls -a` has at most two lines (for `.` and `..`), which
> should be better behaved, and adds the `--` delimiter before the
> directory name when invoking `ls`.

AFIAK dot and dot-dot are allowed not to exist; "at most two" is not
a good test.

Quite honestly, our tests are still run inside a sort-of controlled
environment, so if it _requires_ use of things we have avoided
depending on, like "ls -A" and "xargs -0", or the fact that most
filesystems always have "." and ".." even in an empty directory, in
order to be resistant to funnily-named files like dot-LF-dot, I
would say it is not worth worrying about these funny names--instead
we can simply refrain from using such a pathological name, can't we?

In other words, is there a real-world need in the context of our
test suite for this change?

Also, I find that its support for directories whose names begin with
a dash red-herring.  All the test scripts in our test suite knows that
they can prefix "./" to avoid problems, i.e.

	test_dir_is_empty ./--wat

So it appears that the only problematic case is when we create a
directory, create a file or a directory whose name is dot-LF-dot and
nothing else, and then do something that ought to cause that file to
disappear, and make sure that the directory is empty, e.g.

	mkdir empty &&
	echo foo >"empty/$dotLFdot" &&
	git add "empty/$dotLFdot" &&
	git reset --hard &&
	test_dir_is_empty empty

We do want to make sure funny names can be added with "git add" and
"git reset --hard" to HEAD that lacked those paths with funny names
to remove them correctly.  But the funny names used in such a test
do not have to be $dotLFdot; you can use "${dotLFdot}X" instead in
the above and can ensure whatever the original test wanted to
ensure.

So...



