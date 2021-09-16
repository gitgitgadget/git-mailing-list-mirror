Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54F3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A08D60EE5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 09:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhIPJb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhIPJb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 05:31:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DAC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 02:30:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v5so14217696edc.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S+ab3QbDVVZZckC0WVwH+cdjIbto09d5zi2B09LRsy0=;
        b=oP++e8fwsfSRatbTRWBwMhg6IlyYLaGOt2Rz73WD2aXbegPFlq5R6aKZckSi/QGZF0
         RPpN/z87aX5WNZO+WG/5HPUDf9AqYcUsX6Cde6tmgzBIIOdoQfY8PIvwc/JQn5FuGJ+F
         vfvBnY3pfTlh2QudMNTe0sIfhvyeS2n//vbVQTEaluniDMjF/I3z4IurY5zZGov5GhzX
         pgQrXbQ8zJVuYWCNstRNRauS/wYCWAMj/FihJix4W7Uszht9S+qj6ZMofBQypGP5PQML
         4DrhjRR1DDoks/ZOkHZPHPcehyJtshgNJPB5f4mgZtohSV5Fk2zzn9dhNfO+XA0jrlPE
         Oceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S+ab3QbDVVZZckC0WVwH+cdjIbto09d5zi2B09LRsy0=;
        b=GlttPIdhgSwnk2sEtw1qyjuUfoiOvuAnTY+eS8lAFJZDzv0I6Ur1o5hRMOP1rNBZ7C
         5ZuyST8otrqnUXa7yCRDtHcJfXdIuzwL9I3D5jjLzPL9R5Q2gUuqrZEiSAMhaPH81au0
         eykonidNsQWPqOK5wO6dv96Tg2bBXqRhje2QH3YLjschhP7eZ3nz3zO+rHn4/30X1lMO
         TwxcUpnUrevGeoQZdD1VEHe/lJu2GTheIgD55PQJsvuz2Fs7k6Ol0A6Gd7w2I9+8qYuv
         C3AkqSXbncxyDTgqGB2kk1oaguAg2JTD9s9cQjBgGe8pMVkJNfbJDZDA//4doCiK48Yu
         AACQ==
X-Gm-Message-State: AOAM533JTcScelR83jn62J+F/uQ9yQBknjCG72vHTbmPJ55LPV7f0zl3
        UybFTcNtazIJsOzirda1e/k=
X-Google-Smtp-Source: ABdhPJzq3/XJciabui8rnzQn7aeImPsrEkb1mfNnq9GLuQHLaMW0nHmBcOKX/jJG5cwva7ZgvS0VvQ==
X-Received: by 2002:aa7:d895:: with SMTP id u21mr5365739edq.300.1631784603508;
        Thu, 16 Sep 2021 02:30:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cb10sm1132104edb.18.2021.09.16.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 02:30:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        Andreas Gruenbacher <agruen@gnu.org>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH 2/2] diff: --quote-path-with-sp
Date:   Thu, 16 Sep 2021 11:06:42 +0200
References: <20210915223316.1653443-1-gitster@pobox.com>
 <20210915223316.1653443-3-gitster@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210915223316.1653443-3-gitster@pobox.com>
Message-ID: <87ee9ohnqd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Junio C Hamano wrote:

[CC-ing Andreas Gruenbacher who's currently active in GNU patch
development, and Paul Eggert at his current address, in case he's
curious about this blast from the past.

Both: The full context for this proposed change in Git is at
https://lore.kernel.org/git/20210915223316.1653443-1-gitster@pobox.com/]

> Long time ago, we had a discussion with GNU patch/diff maintainer
> and agreed that pathnames with certain "difficult" bytes needs to be
> quoted to ensure the resulting patch is machine parseable in an
> unambiguous way [*1*].  Recently, we saw a report that found that
> GNU patch is unhappy with our diff output for a path with SP in it
> [*2*].

It would also be good to mention 4f6fbcdcf96 (Functions to quote and
unquote pathnames in C-style., 2005-10-14) here, which is what came out
of the [*1*] discussion you're citing, and that also link to the later:

    https://lore.kernel.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/

Where you quote a message of Paul Eggert's that didn't make it into the
archive, but which AFAICT accurately summarizes the behavior in
4f6fbcdcf96.

Whereas the [*1*] you linked to is still the early proposal of handling
UTF-8 specially (not quoting it), which doesn't appear to be what either
GNU patch or Git went for in the end (both fully quote some fairly
vanilla (also in latin1) UTF-8 when I tested it).

It's still not clear to me if what was agreed upon was accurately
implemented by Git at the time, but that GNU patch had a bug vis-a-vis
the desired discussed behavior, if the bug is Git's, or both etc. Does a
fix still need to be made in GNU patch?

There's also a mention of busybox's interaction with this behavior in
https://lore.kernel.org/git/YUK7Bl9uzNE1YErg@tilde.club/; has anyone
(you or Gwyneth) sent them an FYI about this in case they'd like to
adjust the behavior of their patch tool?

> Teach "git diff" and friends the "--quote-path-with-sp" option, that
> encloses a pathname with SP in it inside a pair of double-quotes,
> even though there is otherwise no byte in the pathname that need to
> be encoded in the octal.
>
> As an earlier parts of t/t3902 (outside the patch context) shows,
> output from "ls-files", "ls-tree", and "diff --name-only" all follow
> the same rule to decide paths with what bytes in them need quoting
> and how they are quoted.
>
> This experimental option deliberately refrains from touching these
> output and affects ONLY the paths that appear in the patch header,
> i.e. "diff --git", "--- a/path" and "+++ b/path" lines, that GNU
> patch may care.  This is to minimize potential damage this change
> may cause to tools and scripts the users have been relying on.
>
>  *1* https://lore.kernel.org/git/87ek6s0w34.fsf@penguin.cs.ucla.edu/
>  *2* https://lore.kernel.org/git/YR9Iaj%2FFqAyCMade@tilde.club/
> [...patch omitted...]
