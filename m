Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E493EC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D0564EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhBZKjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhBZKhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 05:37:23 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4AEC061756
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:36:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x9so4286589otp.8
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4vCrSo4o5nYLtvVctbOR6G+C8xI3849YhJQGc0sqFo=;
        b=fs2/rybmsk7SWPKabhBuIVsLW7wxkO0Weu+/UvdrljYa6X4jzMdj1RN+3zk++IS7D2
         3LqoR3CrtLksE0Yf+Wp6liWbLS3CQcoO61k7ej9qXRhZhq9zV4o4uLzb4roaA41XAiVz
         GMSCvk+nI+hUVRHtZfd5e6zfokL1EHL6/X6HWtTFYEj3FgoSmWOs0oQdpZ4FkxbC51c6
         c1c0cZ7xN+VaBdvbN+PNvnClYrTdYDj3Cjq6egN8tSK5XOpGjvs2gGk506AobMVSdEtX
         73b2PYS3dvnupmPHPStSkez5/91jRLqVtg52uPaMS8oyx/lEZal/my49aC+x8b75JmUY
         xI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4vCrSo4o5nYLtvVctbOR6G+C8xI3849YhJQGc0sqFo=;
        b=sXJ375hNTFjv6kc6CGiCDSSmTRABJfrOhPspyBSovsGLAJ4bc5RCMwmW1VmXEfmfBd
         h2bfY+EUgRhOQjJWJ+cFWdIpcbkbcIXpqsOMbKM3wSqUtKqw6VcgzoCNRO4mVuDXbNIk
         Pci2mVo6pJHMzoO1V2LczjcuhcAvrzXuZHLeGSiBYIdut91XUxuBdd97nzpjaCU9eQLp
         R7/Lq25taj1dDMYb7cvvGpyObvqYDC2djiUx9Fcdt+zBn5PE5aNmNg3aMhdg2VJmYL6h
         34CztvTmjkCXdGdmnEflowhP2Uh3QqFnVL5JkERqzzpCLSK54cNoJQuvsDewifDhry5T
         gnJA==
X-Gm-Message-State: AOAM531jQlUJfjdeBohraW5kob/4B0vt4iptv8zE2EMUH9a761RQ6rAq
        qjy1LdhwWwhO2aDvpMtrvkqZHzFmEzUi4BRkVco=
X-Google-Smtp-Source: ABdhPJzUy35ZdGEMkmY6sWFtoYnLebe9wtH/2ZDxFFhi/16einy4jXpIkrZheHC2og8WGgCZ39qSCleT4SqKurEu+zY=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr1768339otq.210.1614335802667;
 Fri, 26 Feb 2021 02:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210225100855.25530-7-charvi077@gmail.com>
 <xmqq4khzub4m.fsf@gitster.g>
In-Reply-To: <xmqq4khzub4m.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 26 Feb 2021 16:06:31 +0530
Message-ID: <CAPSFM5deG5Z0RSPZe2rf1qs9BS8j2_84ECybiOf_LA3yLR-r-g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 26 Feb 2021 at 02:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > +--fixup=[(amend|reword):]<commit>::
> > +     When used without options, lets's say `git commit --fixup=<commit>`,
> > +     it creates a "fixup!" commit where the commit message will be
>
> Be careful to use word 'option' that refers to something other than
> what a casual reader would think of an `--option` in the description
> of the `--fixup` option.
>
>         Without `amend:` or `reword:`, create a `fixup!` commit where...
>
> would be sufficient, no?
>

Okay, I agree this is more clear.

> > +     the subject line from the specified commit with a prefix of
> > +     "fixup! ". The resulting "fixup!" commit is further used with
> > +     `git rebase --autosquash` to fixup the content of the specified
> > +     commit.
> > ++
> > +When used with option `amend`, let's say `git commit --fixup=amend:<commit>`,
> > +it creates a "amend!" commit to fixup both the content and the commit log
>
>         The `--fixup=amend:<commit>` form creates an "amend!" commit to...
>
> > +message of the specified commit. The resulting "amend!" commit's commit
> > +message subject will be the subject line from the specified commit with a
> > +prefix of "amend! " and the message body will be commit log message of the
>
> While that SP inside the double-quote may be technically more
> correct (and it was inherited from the original), I think with 'a
> prefix of "amend!"' is still understandable and a lot easier to
> read, especially because you'd mention "amend!"  a few more times in
> the same paragraph below.
>
> The same comment applies to "fixup! " above.
>

Okay, I will fix it.


> > +specified commit. It also invokes an editor seeded with the "amend!" commit
> > +log message to allow to edit further. And it denies to create "amend!" commit
>
> "amend!" commit log message -> log message of the "amend!" commit
>
> denies -> refuses
>
> > +if it's commit message body is empty unless used with `allow-empty-message`
> > +option. "amend!" commit when rebased with `--autosquash` will fixup the
>
> with the `--allow-empty-message` option.
>
> > +contents and replace the commit message of the specified commit with the
> > +"amend!" commit's message body.
> > ++
> > +When used with alternative option `reword`, let's say
> > +`git commit --fixup=reword:<commit>`, it works similar to `amend` option, but
> > +here it creates an empty "amend!" commit, i.e it does not take any staged
>
>         The `--fixup=reword:<commit>` form creates an `amend!`
>         commit similar to `--fixup=amend:<commit>` creates, but it
>         records the same tree as `HEAD`, i.e. it does not ...
>

Thanks for pointing out these changes. I agree these are more clear
and will fix them all.

> > +changes and only allows to fixup the commit message of the specified commit.
> > +It will reword the specified commit when it is rebased with `--autosquash`.
> > ++
> > +Unlike `--fixup` without options, `--fixup=[amend/reword]:` is incompatible with
> > +`-m` commit message option.
>
>         The `--fixup=amend:` and `--fixup=reword:` forms cannot be
>         used with other options to add to the commit log message,
>         e.g. `-m`.
>
> Again, why is `-m` so special?  Shouldn't -F/-c/-C also be
> incompatible?
>

Yes, they are also incompatible. I thought to highlight -m because `--fixup`
allows the `-m` but I agree to reword it in above way with slight change :
s/e.g. `-m`/i.e it is incompatible with `-m`/`-F`/`-c`/`-C` options.
