Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFCB1F406
	for <e@80x24.org>; Sun, 14 Jan 2018 09:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeANJgw (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 04:36:52 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40310 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeANJgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 04:36:50 -0500
Received: by mail-oi0-f65.google.com with SMTP id u83so6542889oie.7
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KKtWsxQwXz1/MEWv7vd06YFJtWTy//RZ6uTy8/1pXhg=;
        b=KejNfmxxdjhnWrYoh5QDwUDOsmX/Q90ES2x3SLvAamPGYY6XSQB8ZwEtbsUdWENTVP
         RlsjWOyJZK+9aq443KiXTPn0UF7uuSduj3dua0vqEbapV4hSbSn0/f9sNBR3hoqgvY1F
         nl53/9xRv0AvSHBZ8XuY9U9hFwnvCmkzonMuMqe+wOtD3kH1UGnLt6OvqVwe9EA3FnbB
         /4PEHW3hGUZRVz1wG2xWYnal3kMuGvQ4olzRLRARQekRC/XFTGnJHZ5QdH1B/TfmmHA2
         rctciKEWnka4+C0x+jTUMCT3ENUJqqvuIbGSa3XW9ldtq55cWSmNunIv7SwSQ8du7Hs0
         K6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KKtWsxQwXz1/MEWv7vd06YFJtWTy//RZ6uTy8/1pXhg=;
        b=aRUdcc7EUa68L+572qyaXTtZu118d5CIAOlccdbNOBRfg303TTBD0lIuiiLrhKizyp
         ptkLbxJwJegLH1w4wgebZ7OcerutJDbPwdmjWMZG79RmBtlYrvEQJwFyfj3k5iAjItKU
         E3V3ppqLf0+xCXaixEUMDQxuV+ha8CgH5OYHQElNQV+u1C7NUwC6uQ9BOAe/0yAjY81U
         HVM8wTV7qu8UJ0cCkqk2ZqJaSVgfcgDxa7nPMxYIYjjd7A035A6XXr3suM7kcVjR8kF9
         R3cEP9lNlQQN7GanWZHovzmPyOt4BS0a7fkky7NstOQMIL/wVgNJMyOB2KhWC5noTo1k
         6teQ==
X-Gm-Message-State: AKwxytfuQAo3Quh/uIBuUl43h1TBBetaYCUBS6AL5tDdBvaCcnOpMgb6
        Hi2SzG6MijXaSN6VACrxQGydv66cz2kYuEYuxqA=
X-Google-Smtp-Source: ACJfBosV5FBTyQlR8IJm1enSjIVh5mX1Vr0ozOU5NpByURRkP9BF69fqRwWXaQoBxhi1B8/Fe9DuArOAa5Z5du7TBE8=
X-Received: by 10.202.171.195 with SMTP id u186mr7572601oie.253.1515922610125;
 Sun, 14 Jan 2018 01:36:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Sun, 14 Jan 2018 01:36:19 -0800 (PST)
In-Reply-To: <20180113223715.GJ2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com> <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180113223715.GJ2641@hank>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Jan 2018 16:36:19 +0700
Message-ID: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/3] read-cache: don't try to write index if we can't
 write shared index
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 14, 2018 at 5:37 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
> read only", 2014-06-13), we tried to make sure we can still write an
> index, even if the shared index can not be written.
>
> We did so by just calling 'do_write_locked_index()' from
> 'write_shared_index()'.  'do_write_locked_index()' always at least
> closes the tempfile nowadays, and used to close or commit the lockfile
> if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
> introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
> 'write_locked_index()'.
>
> After calling 'write_shared_index()', we call 'write_split_index()',
> which calls 'do_write_locked_index()' again, which then tries to use the
> closed lockfile again, but in fact fails to do so as it's already
> closed.
>
> In the current version, git will in fact segfault if it can't create a
> new file in $gitdir, and this feature seems to never have worked in the
> first place.
>
> Ever since introducing the split index feature, nobody has complained
> about this failing, and it really just papers over repositories that
> will sooner or later need fixing anyway.

Actually there's one valid case for this: you're accessing a read-only
$GIT_DIR (.e.g maybe from a web server cgi script which may be run by
user nobody or something) and creating a temporary index _outside_
$GIT_DIR. I used to do this when I wanted to do "git grep" on some
SHA-1 a couple times. Doing "git grep <SHA-1>" directly (a couple
times) pays full cost for walking trees. If you prepare an index
first, you pay it only once.

> Therefore just make being unable to write the split index a proper
> error, and have users fix their repositories instead of trying (but
> failing) to paper over the error.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index d13ce83794..a9c8facdfd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2471,18 +2471,15 @@ static int clean_shared_index_files(const char *current_hex)
>         return 0;
>  }
>
> -static int write_shared_index(struct index_state *istate,
> -                             struct lock_file *lock, unsigned flags)
> +static int write_shared_index(struct index_state *istate)
>  {
>         struct tempfile *temp;
>         struct split_index *si = istate->split_index;
>         int ret;
>
>         temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> -       if (!temp) {
> -               hashclr(si->base_sha1);
> -               return do_write_locked_index(istate, lock, flags);

I think this code tries to do what's done near the beginning of
write_locked_index() where we also bail out early:

-- 8< --
        if (!si || alternate_index_output ||
            (istate->cache_changed & ~EXTMASK)) {
                if (si)
                        hashclr(si->base_sha1);
                ret = do_write_locked_index(istate, lock, flags);
                goto out;
        }
-- 8< --

the only difference is it does not realize that it can't do "goto
out;" like that code unless something goes wrong. I'll try to prepare
a patch that move tempfile creation out of write_shared_index()
instead. Patches coming in a bit..
-- 
Duy
