Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9EC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB872071E
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 03:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHXDto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:49:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43576 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgHXDto (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 23:49:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id f24so4461675edw.10
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 20:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQu5L53DhM8SUtlzEyD/ZuvCg/oDesVTCJrpe9fC5Q8=;
        b=B3HbvUp+spm3GizT6PRs3IPNAOiO9cAvI8f1ejeGKodCczIIlr05aCE1Wg5H0FW0RC
         csyMC9tYo+q3xUlas6UkPMJYbPwKgrb4QofiD5Xj0e/ZJEgjZWi5CHxeFo84UGPncNt3
         QcqzUml95azTPWWwtEMhga3IbZY3tBJWVgttUykJkxgPJezGENN/XrvXy1pAbRfANTyA
         OhfLENKEfYSv015Qwfll/W+J4+dAZK68KhMF+ABMiju2Ztn2pXZWFJXd57xLhxMxYka3
         O7YYY8yYWOrqeckSRgF4bXhCzOqTme6OmC+YjJDMss1HHEfURIp1zYJ0V27Fd9uHwgx/
         fTWQ==
X-Gm-Message-State: AOAM5300rGlrSAalWX8ih13JO6lPX7K1eAItFZRlkUaVzYpObySoZSPk
        jVD3jbBaYlcrjTWunoYvXCu74Xww25r16Qj+EAV5K04o2eg=
X-Google-Smtp-Source: ABdhPJwhtBa+AEbFefFU6Jnq6wS9TyoCUYJiecYHzXV1h9DicpN9PdxTTM3N/dWKvl9zthBfrB8TxS76ZyRx1ilko5Y=
X-Received: by 2002:a50:b081:: with SMTP id j1mr3506267edd.291.1598240981838;
 Sun, 23 Aug 2020 20:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
 <xmqqeenz95bj.fsf@gitster.c.googlers.com> <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
In-Reply-To: <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Aug 2020 23:49:30 -0400
Message-ID: <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 23, 2020 at 8:56 PM Hariom verma <hariom18599@gmail.com> wrote:
> On Sat, Aug 22, 2020 at 12:47 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > ...an alternative would have been something like:
> > >
> > >   else if (!strcmp(arg, "trailers")) {
> > >     if (trailers_atom_parser(format, atom, NULL, err))
> > >       return -1;
> > >   } else if (skip_prefix(arg, "trailers:", &arg)) {
> > >     if (trailers_atom_parser(format, atom, arg, err))
> > >       return -1;
> > >   }
> > >
> > > which is quite simple to reason about (though has the cost of a tiny
> > > bit of duplication).
> >
> > Yeah, that looks quite simple and straight-forward.
>
> Recently, I sent a patch series "Improvements to ref-filter"[1]. A
> patch in this patch series introduced "sanitize" modifier to "subject"
> atom. i.e "%(subject:sanitize)".
>
> What if in the future we also want "%(contents:subject:sanitize)" to work?
> We can use this helper any number of times, whenever there is a need.
>
> Sorry, I missed saying this earlier. But I don't prefer duplicating
> the code here.

Pushing back on a reviewer suggestion is fine. Explaining the reason
for your position -- as you do here -- helps reviewers understand why
you feel the way you do. My review suggestion about making it easier
to reason about the code while avoiding a brand new function, at the
cost of a minor amount of duplication, was made in the context of this
one-off case in which the function increased cognitive load and was
used just once (not knowing that you envisioned future callers). If
you expect the new function to be re-used by upcoming changes, then
that may be a good reason to keep it. Stating so in the commit message
will help reviewers see beyond the immediate patch or patch series.

Aside from a couple minor style violations[1,2], I don't particularly
oppose the helper function, though I have a quibble with the name
check_format_field(), which I don't find helpful, and which (at least
for me) increases the cognitive load. The increased cognitive load, I
think, comes not only from the function name not spelling out what the
function actually does, but also because the function is dual-purpose:
it's both checking that the argument matches a particular token
("trailers", in this case) and extracting the sub-argument. Perhaps
naming it match_and_extract_subarg() or something similar would help,
though that's a mouthful.

But the observation about the function being dual-purpose (thus
potentially confusing) brings up other questions. For instance, is it
too special-purpose? If you foresee more callers in the future with
multiple-token arguments such as `%(content:subject:sanitize)`, should
the function provide more assistance by splitting out each of the
sub-arguments rather than stopping at the first? Taking that even
further, a generalized helper for "splitting" arguments like that
might be useful at the top-level of contents_atom_parser() too, rather
than only for specific arguments, such as "trailers". Of course, this
may all be way too ambitious for this little bug fix series or even
for whatever upcoming changes you're planning, thus not worth
pursuing.

As for the helper's implementation, I might have written it like this:

    static int check_format_field(...)
    {
        const char *opt
        if (!strcmp(arg, field))
            *option = NULL;
        else if (skip_prefix(arg, field, opt) && *opt == ':')
            *option = opt + 1;
        else
            return 0;
        return 1;
    }

which is more compact and closer to what I suggested earlier for
avoiding the helper function in the first place. But, of course,
programming is quite subjective, and you may find your implementation
easier to reason about. Plus, your version has the benefit of being
slightly more optimal since it avoids an extra string scan, although
that probably is mostly immaterial considering that
contents_atom_parser() itself contains a long chain of potentially
sub-optimal strcmp() and skip_prefix() calls.


Footnotes

[1]: use `if (!*opt)` rather than `if (*opt == '\0')`
[2]: cuddle the closing brace and `else` on the same line like this:
     `} else if (...) {`
