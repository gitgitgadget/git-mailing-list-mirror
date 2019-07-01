Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127491F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGASCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:02:32 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43094 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGASCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:02:31 -0400
Received: by mail-vs1-f68.google.com with SMTP id j26so9475516vsn.10
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LG5NKbtYkNa0cm8ED8JDEAQ253RxiE+LYb43GnnVn6M=;
        b=AXIWi3DhrpunJYVLe21Esd8ScNFtbbIeM/zBLrfFjtINfIvosHT1nPAHiQZlmyIFmd
         2w8WtIWbsjcx7qcsAXVedQzTePloetNyl5Sy4QRyeK3/Zm3k8ua3hwOoetedFyPgOZvU
         BGPKl+bJ7rtMk91COgJnflAD6u5a7hwzILKIkJIRU4OdglcC6zs4HdPAs1oIlMU2tDtT
         5jbkdI7svbYJgWW0V3SUG9+BgZOBft5jS3/WdpKMSY2NhGQWmpieeTjiL84pqyTMzo6y
         liTQ+jb+GiWYDtffH+CkvG68ng3fVhrHA3pHbuwsJMKbDCb2RzV4ia1ThYOGCPaf7f5B
         9Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LG5NKbtYkNa0cm8ED8JDEAQ253RxiE+LYb43GnnVn6M=;
        b=MymilKIQkwpJOtHrzSQgAcKUX1rajMPkAj4piGyhkFqX0dfqOPXs0yrAxH21qbFomu
         Qlk0ex7LsviupmMqxfQryKuvllwfuemgVPr49zQvzDEboNqnFvur0CeshuaRpDHa+zuG
         D5TUJhE1oWlvjKnGdz7O4C0Kx9afUvUEsTK4obEtBnEkWHxNa6jx3auBDR3Ai+V+i+pS
         C47ZwG6V3hdrNIbwa8E2+g+CyXlYejwJVLCZMR2/0L+Fk/CAXCbH2xdz8Af+Mja7XyKY
         Og45nm/1J3pl1D1mSmjMTOSnJ8I83+3kcjsPx6T3wc6PvBSFMac742lkUphYY1Ellyy6
         HQyg==
X-Gm-Message-State: APjAAAWlxX30cBtkQA1N02tsvJoclLKYQHnRoJUEjOK1w28uxl+0ig6Y
        GhugRJH0hm9WUNCnjRGnLOzo0Ktml4pq7entiFQ=
X-Google-Smtp-Source: APXvYqx9PIAMzz+b4Nk4CxxV9rTwWZd90gD7DMstj/St1vBIYI172bgB+oKkPz1eSDAVzbpuvk5NVS9IwJ0sZQSoJvY=
X-Received: by 2002:a05:6102:252:: with SMTP id a18mr15529101vsq.53.1562004150833;
 Mon, 01 Jul 2019 11:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com> <3AA3CC52-84FE-4FD0-8977-D4FBCF0DCE2C@gmail.com>
In-Reply-To: <3AA3CC52-84FE-4FD0-8977-D4FBCF0DCE2C@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Jul 2019 12:02:19 -0600
Message-ID: <CABPp-BERu_Sd6YYtVPBrjuHz_Yc0_f3rgvYESQB8EuUs-8jCUQ@mail.gmail.com>
Subject: Re: [BUG] Symbolic links break "git fast-export"?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 8:01 AM Lars Schneider <larsxschneider@gmail.com> wrote:
> > On Jun 24, 2019, at 5:33 AM, Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Jun 24, 2019 at 5:05 AM Lars Schneider <larsxschneider@gmail.com> wrote:
> >>
> >> Hi folks,
> >>
> >> Is my understanding correct, that `git fast-export | git fast-import`
> >> should not modify the repository? If yes, then we might have a bug in
> >> `git fast-export` if symbolic directory links are removed and converted
> >> to a real directory.
> >>
> >> ...
> >
> > My first reaction was, "we regressed on this again?", but it looks
> > like my original fix for directory/file changes only handled one
> > direction.  Thus, my commit 060df6242281 ("fast-export: Fix output
> > order of D/F changes", 2010-07-09) probably *caused* this bug.  We
> > should probably just sort not based on filename, but on changetype --
> > send all the deletes to fast-import before we send the modifies.
>
> 060df6242281 is interesting! If I revert the changes in builtin/fast-export.c,
> then the "t9350:directory becomes symlink" test still passes nowadays.
>
> Plus, my my new test case passes too:
>
>         test_expect_success 'when transforming a symlink to a directory' '
>                 test_create_repo src &&
>
>                 mkdir src/foo &&
>                 echo a_line >src/foo/file.txt &&
>                 git -C src add foo/file.txt &&
>                 git -C src commit -m 1st_commit &&
>
>                 ln -s src/foo src/bar &&
>                 git -C src add bar &&
>                 git -C src commit -m 2nd_commit &&
>
>                 rm src/bar &&
>                 mkdir src/bar &&
>                 echo b_line >src/bar/b_file.txt &&
>                 git -C src add . &&
>                 git -C src commit -m 3rd_commit &&
>
>                 test_create_repo dst &&
>                 git -C src fast-export --all &&
>                 git -C src fast-export --all | git -C dst fast-import &&
>                 git -C src show >expected &&
>                 git -C dst show >actual &&
>                 test_cmp expected actual
>         '
>
> Do you think it would make sense to revert the qsort change
> in fast-export? I haven't bisected yet which other change made
> the qsort change obsolete.

No need to bisect; it was the other commit I pointed out in my last
email, commit 253fb5f8897d ("fast-import: Improve robustness when D->F
changes
provided in wrong order", 2010-07-09).  The original bug was
fixed/worked around in two places, because Shawn specifically said the
fast-import side being more robust was okay but that fast-export was
buggy and needed fixing.  See
https://public-inbox.org/git/20100706193455.GA19476@spearce.org/ and
the thread around there.  (It'd be really nice to be able to cc Shawn
on this...sigh.)  Reverting the fast-export change would be okay if we
replaced it with a better change (something like sorting deletes
before modifies, though maybe with extra work around renames as
discussion elsewhere in this thread is touching on), but if we
straight up revert that change it would leave fast-export in violation
of the stream format.

Hope that helps,
Elijah
