Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF281F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAXUgv (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:36:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40405 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:36:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so5671122edr.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 12:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gd8yGmCXj7jXOS4GWHAqbT/YWUo01kcK+9oKsIvnrcU=;
        b=NUmfFqCSCLL+Iew3jqieVwwSXjfPJTI1is4hx1DZQl8n96aP1KP55lKGq6t0LnNGSi
         4n4VJeatqd3C/K9PLDMr+e79nKn3pJfHa7v5uSfE6EmZBiCsXZwbRB8Ccjzg2JlRnmA3
         2AK2s4VhJXAzFwUmMn9vmJp8aQ61YH/JFjLRE3DbFS+XeE+036i9UjeI9LcHiylVE1/b
         v3XgKU77GodzJHzteKQ5JZtpe2lVSMLPQcvdMHFQCSPZc6Njo8KhPTG2X6OBRojebfbH
         lKCF8xlOr99FKavrUZRBAGds54/kwIIVwWx52n1URNwhQUcZxk47x1s2/8C9BK8Phu6M
         OctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd8yGmCXj7jXOS4GWHAqbT/YWUo01kcK+9oKsIvnrcU=;
        b=icsno769kAQ7L2E8EZgvvLmAZYyXDAJd5Ilrqqa4fuQijtdugm7rsQMw4AOOVfoV1C
         uJq2V6hdikHabj/kPQwrgSdrObuvLGYwqy+Ic1RZcDFRzbrJwPcC6iQD736gf8KhclH1
         fup79dHttBnOV1W9He5pQQak+Em9OiaIGu09Rxv4kXFn0fuzd2yuToGxbkfvI5W/xoHM
         /3F1ZjUxPobLb6sf44RVzFzFVpzv2EZwjVzQNLlsSHulqyl2gjksasraWLOlZjPv5zYx
         OKw2QkFvp9cZGtybS0dRcVeERq+GZmWltpwH70P5eybQGDPF07Rmqfu9XoW5USesgNHd
         7Y4A==
X-Gm-Message-State: AJcUukeoH8zr7ykGvfU+tWo3UrBl4qvEF923OExUVyRdt9YrX/1iTPyl
        ZL+06xeV990JZZLk8EEF5EivOb7zCgSwRabIutdS7A==
X-Google-Smtp-Source: ALg8bN7r2kputCz+by1Gm6VdBBUoQ3D8bS3DVEUmcwmCpADzKhDLkH7lP2vtfPskt84gkcph/2a543eEUOwE5TvIpXk=
X-Received: by 2002:a17:906:c44e:: with SMTP id ck14mr7344613ejb.56.1548362209396;
 Thu, 24 Jan 2019 12:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net> <20190124123240.GB11354@sigill.intra.peff.net>
 <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 12:36:38 -0800
Message-ID: <CAGZ79kZR--VN2BiG=usyy=J=u59Up3XYpK4c9pJYQkX1Gby06Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 12:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > When we run "git log --cc --stat -p --color-moved" starting at D, we get
> > this sequence of events:
> >
> >   1. The diff for D is using -p, so diff_flush() calls into
> >      diff_flush_patch_all_file_pairs(). There we see that o->color_moved
> >      is in effect, so we point o->emitted_symbols to a static local
> >      struct, causing diff_flush_patch() to queue the symbols instead of
> >      actually writing them out.
> >
> >      We then do our move detection, emit the symbols, and clear the
> >      struct. But we leave o->emitted_symbols pointing to our struct.
>
> Wow, that was nasty.
>
> I did not like the complexity of that "emitted symbols" conversion
> we had to do recently and never trusted the code.  There still is
> something funny in diff_flush_patch_all_file_pairs() even after this
> patch, though.
>
>  - We first check o->color_moved and unconditionally point
>    o->emitted_symbols to &esm.

I do not recall if we discussed this or if I just had talking voices in my
head, but this was done deliberately to separate the implementation
of the buffering feature and its user. I thought once we had the buffering
in place, we might add options that also require buffering;
hence the explicit "move coloring implies using a buffer".

Having the buffer as a local static might be an iffy implementation
that should be fixed for clarify.

>
>  - In an if() block we enter when o->emitted_symbols is set, there
>    is a check to see if o->color_moved is set.  This makes sense
>    only if we are trying to be prepared to handle a case where we
>    are not the one that assigned a non-NULL to o->emitted_symbols
>    due to o->color_moved.  So it certainly is possible that
>    o->emitted_symbols is set before we enter this function.

Ah I see where you are coming from, as the code was written
I imagined:

    if (o->color_moved)
        o->emitted_symbols = &esm;
    if (o->distim_gostaks)
        o->emitted_symbols = &esm;

    if (o->emitted_symbols) {
         if (o->color_moved)
            handle_color_moved(o);
        if (o->distim_gostaks)
            handle_distimming(o);

        ... flush symbols...
        ... free &cleanup ...
    }


>  - But then, it means that o->emitted_symbols we may have had
>    non-NULL when the function is called may be overwritten if
>    o->color_moved is set.

I see. So either we'd want to have

    if (o->emitted_symbols)
        BUG("should not be already set");

or as Peff points out, make it non-static.

> The above observation does not necessarily indicate any bug; it just
> shows that the code structure is messier than necessary.

Makes sense. I should not have anticipated any new feature to be
added, yet.

>
> > To fix it, we can simply restore o->emitted_symbols to NULL after
> > flushing it, so that it does not affect anything outside of
> > diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
> > nobody outside of that function is going to bother flushing it, so we
> > would not want them to write to it either.
>
> Perhaps.  I see word-diff codepath gives an allocated buffer to
> o->emitted_symbols, so assigning NULL without freeing would mean a
> leak, but I guess this helper function is not designed to be called

Yes, this was done as to make the buffering complete.
We would not have to buffer any word diff as the color move doesn't yet
work on that.

See the NEEDSWORK in diff_words_flush, where we could implement
a word based move coloring.
