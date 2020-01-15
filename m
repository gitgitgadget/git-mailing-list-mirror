Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95749C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629B32084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7WxDQOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAOU3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:29:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38008 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOU3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:29:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so16726140oii.5
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsLld8C4nqcwR0kgzYldnzIs5wk3ISvLNT4LpImzyhY=;
        b=l7WxDQOEiv+J6NQo/UDlaD4bhSTM8MsnscYfO6YAJupdK1WRqrYEEzlyk1je9sVBWZ
         nlgQ3NlnliNcRN9rQIMa6fVQ1JdDnMeBO0jlgVx4jzAhBXsMkT/iz3DMPEtIrTUhqgAP
         4pCUn2/3WTcL0u993YarXXjtAze4V8ODthr1Wz8DST8dLXt0W5pHYyFA6pvkFxgnhrr7
         OO9UmlK5Q20beJOIZbWijxtA1A/6HrnIHu9jsmRsBEVh3UFi/rKI5a88h+oKUUa135pD
         Czm5SS6F/DkBE2fEHublYtUw/7GKaXgkUtngp60XHumU5gtRuZ1Yey6HI7qRQgW+ZnlA
         QtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsLld8C4nqcwR0kgzYldnzIs5wk3ISvLNT4LpImzyhY=;
        b=cI19Q9P7z5rVN59vjZcYXfS0C05BF2wXpFn5XriCbvxb4LcHimcZGRLttUjQa118hv
         yET7jIcjWyacqRQrB90uf9q0it1ThK7yGuRy4UCfFoY0Evml80tA65ZichZQZwXfTLst
         bbbQF0YFesQAIVJ6201Liv8H2/4UwkEjeqqhbsmZWZpwu0LKZpZrIaguMrw8H/Vl6K0D
         60vn5sdgsUwQCPSBwrFB9TE0wiTv9LXLa3dWKY2h2AvcAsjc/sM3ipSJSqCM7xbP80RQ
         SUQFIpQjJpF02QIOjEuVAkW92UpUuWA03+mTFR5yVSozhgquXPKRBRbfIFo9OjKrZDZr
         xQPQ==
X-Gm-Message-State: APjAAAU9dN4LKqIspvlzpDNIqS5DIdKC1VTYUZAzM4AOD+ZGZSp6ZeSP
        +6PC4AHtknx8JyjoajFenZeTwamNV5vgVRvvqoM=
X-Google-Smtp-Source: APXvYqwbgvzlIrfWSAWq9HmBkcZxVvGeTP7JXHMHK7h1WON56yGcIhw+URxr+ihvAY4q14RorpcvAIRV5WkxVvozVFM=
X-Received: by 2002:aca:ba88:: with SMTP id k130mr1368414oif.167.1579120139011;
 Wed, 15 Jan 2020 12:28:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
 <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com> <20200115202146.GA4091171@coredump.intra.peff.net>
In-Reply-To: <20200115202146.GA4091171@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Jan 2020 12:28:48 -0800
Message-ID: <CABPp-BFQDkpcm57dTwH+AiMsocxTro4ZuvhK2eAZzfHutWjq3Q@mail.gmail.com>
Subject: Re: [PATCH] dir: point treat_leading_path() warning to the right place
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 12:21 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 15, 2020 at 02:21:18PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > Restructure the code slightly to avoid passing around a struct dirent
> > anywhere, which also enables us to avoid trying to manufacture one.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Thanks, this looks good.
>
> I wondered briefly whether this:
>
> > @@ -2374,12 +2362,13 @@ static int treat_leading_path(struct dir_struct *dir,
> >                       break;
> >               strbuf_reset(&sb);
> >               strbuf_add(&sb, path, prevlen);
> > -             memcpy(de->d_name, path+prevlen, baselen-prevlen);
> > -             de->d_name[baselen-prevlen] = '\0';
> > +             strbuf_reset(&subdir);
> > +             strbuf_add(&subdir, path+prevlen, baselen-prevlen);
> > +             cdir.d_name = subdir.buf;
>
> ...could avoid the extra strbuf by pointing into an existing string
> (since d_name is now a pointer, and not part of a dirent). But I think
> the answer is "no", because in a path like "a/b/c", the loop may see
> just "b" (so offsetting into path isn't sufficient, because we also have
> to cut off the trailing part).
>
> I did notice one other small thing while looking at this code:
>
> -- >8 --
> Subject: [PATCH] dir: point treat_leading_path() warning to the right place
>
> Commit 777b420347 (dir: synchronize treat_leading_path() and
> read_directory_recursive(), 2019-12-19) tried to add two warning
> comments in those functions, pointing at each other. But the one in
> treat_leading_path() just points at itself.
>
> Let's fix that. Since the comment also redirects the reader for more
> details to "the commit that added this warning", and since we're now
> modifying the warning (creating a new commit without those details),
> let's mention the actual commit id.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 7d255227b1..31e83d982a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2308,9 +2308,9 @@ static int treat_leading_path(struct dir_struct *dir,
>          * WARNING WARNING WARNING:
>          *
>          * Any updates to the traversal logic here may need corresponding
> -        * updates in treat_leading_path().  See the commit message for the
> -        * commit adding this warning as well as the commit preceding it
> -        * for details.
> +        * updates in read_directory_recursive().  See 777b420347 (dir:
> +        * synchronize treat_leading_path() and read_directory_recursive(),
> +        * 2019-12-19) and its parent commit for details.
>          */
>
>         struct strbuf sb = STRBUF_INIT;
> --
> 2.25.0.639.gb9b1511416

Looks good to me; thanks.
