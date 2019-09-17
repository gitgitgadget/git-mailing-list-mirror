Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB951F463
	for <e@80x24.org>; Tue, 17 Sep 2019 15:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfIQPzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 11:55:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39775 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfIQPzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so2398106vsq.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xuDmxXph5YGE9A+re6ltYnk8FFI6XjnlJjGijILFQmg=;
        b=IeqqgLhXrHRM2bfBAIS0InZgV111cTwBKKX9b9J67jCKEWV9FNm0BbSZGhA374pMyI
         FQbqkUQhYlmbLnJ2HnEORyxJlkA6Uvpz94JkP5pwpuPtsNnDajmwPGNen7Llc7c0Bkdc
         Ox65TOZHsbM3K5/z3GYFFFm2zvrPZYaNRoJ+QTwodzQoecP+syvvlS5yxRFbAEFjg86x
         2QU/UwRCb9Y0zhVNDS+yKP7hvHtbPVoXnCNzvj1L6FvL0fveu7BamM1NxIlbxgMPtCDo
         z7IiKSRqSUeU8l9+9KX1vwiKAQPtzOV4CQuzIxXyD1XwZ2ghFN7RRp+XCZnG2hW1ayb/
         csLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xuDmxXph5YGE9A+re6ltYnk8FFI6XjnlJjGijILFQmg=;
        b=d6UoReefY1BCGQvWYNTOEvpct1C3XPdLkJ4uWNPTJUIK6PLnPDue9BX94+FZitqVA3
         JJAEbgP5gtfY4WeqCYItWXmrRO4SIlTYzCJgl6ArfYTS8ixtJR6LcT8jiJnBbUIFzXyd
         sjfcY1fuQmhqqdqm7JWbM7mt71mTe1osZbivf66aMGyqNyzvXZglbj/C6hN+o4+r7ARQ
         Cd6+OccfdkSXykGPwM+1apqGz3X27iCqL7PLF5ziOhDdZd264jOrDtxeNhlvSvvxsnMn
         hrK33HV090LAxZO7KEEPLPN8PVn0O99t0wjdXpULc3ZzKfaU8mFJrKML6jKhDAL0JCXU
         ndIw==
X-Gm-Message-State: APjAAAVwhXFLW5/7rIoAF6jNp68MbBfqLpdAZUrBNmgU3sq7+3nA3AKt
        MbZAz7ABy6vylQCSNQLjrY2j88QYap6oL1M5ZCI=
X-Google-Smtp-Source: APXvYqwNP+1moUu+9gQBaZOvU2tgr5DoM9Dfc3CKuxE4OZ2okG7alNyKVhkQgA2S6K/LkH+1KH9ZNDwLugeOas7lbhw=
X-Received: by 2002:a67:e8ca:: with SMTP id y10mr1464368vsn.136.1568735704289;
 Tue, 17 Sep 2019 08:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190916214707.190171-1-jonathantanmy@google.com> <20190916221501.GD6190@szeder.dev>
In-Reply-To: <20190916221501.GD6190@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Sep 2019 08:54:52 -0700
Message-ID: <CABPp-BEjsfPb8BYjdDGwwJE2GEbRDsujV2xD=c-0zygJCv4F0g@mail.gmail.com>
Subject: Re: merge-recursive thinks symlink's child dirs are "real"
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 3:15 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Sep 16, 2019 at 02:47:07PM -0700, Jonathan Tan wrote:
> > This was raised by a coworker at $DAYJOB. I run the following script:
> >
> >   $GIT init test && cd test
> >   ln -s . foo
> >   mkdir bar && touch bar/file
> >   $GIT add foo bar/file
> >   $GIT commit -m "foo symlink"
> >
> >   $GIT checkout -b branch1
> >   $GIT commit --allow-empty -m "empty commit"
> >
> >   $GIT checkout master
> >   $GIT rm foo
> >   mkdir foo
> >   (cd foo; ln -s ../bar bar)
> >   $GIT add foo/bar
> >   $GIT commit -m "replace foo symlink with real foo dir and foo/bar sym=
link"
> >
> >   $GIT checkout branch1
> >   $GIT cherry-pick master
> >
> > The cherry-pick must be manually resolved, when I would expect it to
> > happen without needing user intervention.
> >
> > You can see that at the point of the cherry-pick, in the working
> > directory, ./foo is a symlink and ./foo/bar is a directory. I traced th=
e
> > code that ran during the cherry-pick to process_entry() in
> > merge-recursive.c. When processing "foo/bar", control flow correctly
> > reaches "Case B: Added in one", but the dir_in_way() invocation returns
> > true, since lstat() indeed reveals that "foo/bar" is a directory. If I
> > hardcode dir_in_way() to return false, then the cherry-pick happens
> > without needing user intervention. I checked with "ls-tree -r" and the
> > resulting tree is as I expect (foo is a real dir, foo/bar is a symlink)=
.
> >
> > Is this use case something that Git should be able to handle,
>
> FWIW, Git used to handle this case, but it broke with edd2faf52e
> (merge-recursive: Consolidate process_entry() and process_df_entry(),
> 2011-08-11).
>
> Cc-ing Elijah for insights...

Thanks for the heads up.

Yeah, git used to get _extremely_ confused with D/F conflicts, even
worse than here.  Interesting that it took 8 years to find this case.
Anyway, the problem here is that a symlink involved in a D/F conflict
could be a symlink to a directory instead of to a file, and then make
it look like we have some weird nested D/F conflicts in cases when we
don't (i.e. make it look like not only "foo" exists as both a file
(symlink) and directory, but that "foo/bar" does too).

Anyway, being more careful to treat symlinks in D/F conflicts more
like how we treat files in such conflicts, using the way Jonathan Tan
suggested, should fix this issue up.  I put more details in my email
to him.
