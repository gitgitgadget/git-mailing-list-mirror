Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D66C433E3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881732078D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+8B3CMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgHXXcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgHXXcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 19:32:14 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4114C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 16:32:13 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so9960148oid.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTUJviRxzkSB9Fekq9c0GAvhC6yUNSyg9SG2nK3kT/8=;
        b=j+8B3CMrJmd6s5khpNmktn0uqSZuF9aONmfXzduDVD4fQeIaZsdCJerpKiav4ld0rQ
         R0lBxoixAhVuPWUwpqjUD7TOfaamZAUAfi7cQMnMAmNiaSA7slViVSD11i83t8uSqfkw
         QmfOzZTLLOrqM7QihwsIIwcCoy+UvQQ/zkBpefn87JwUGRf+0hN6RyIWxdWQbCxhkYet
         XbKGui9xe2lVkaByz+lis3ke0milo83wohsSHaUkn8BiHQy7/U4mNtXXDv7+5xlrID+L
         vDu/uNXuFQnwpKAWFYhayGJjnLHUrB7F8t1f77UGDAIwHAaCVPaADHfXlvwjrUhAsok2
         GtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTUJviRxzkSB9Fekq9c0GAvhC6yUNSyg9SG2nK3kT/8=;
        b=FxDB9/WT8pA/ha6QHFwaEOGQh2BZDenesBObbv8EZydxySAQi7DCucCI/pQ0toKUks
         34linB42k8lT9HqA7giDg6kSBadKBsz++sDTUPboGhn0Id4QrAOeD5AAgJncK1A0zqry
         eYvcobQqddghT7HR2lxelI5+Mo9wjRzbRFe+YnlWMeLdbYD7QYpkIk/ixxRbtD9JPmFG
         ZJiHpPk9QYkAHq5gO7WqY/ATA7trAthknjjQTn+SzGeGzo7x5UPLWQ/qojhush1NN+DT
         g6TQwQZKWF2XOiD+lilIvugk+0GUXLT+JwbEDXQ+jm3xEOJRCeRMiGt/YOuvXbTrCPa3
         fUnw==
X-Gm-Message-State: AOAM531q05VrPk6BJT3aiirhRsoJVwoDcAsx4LklD86YSrd5JPqwP0b2
        HmsDGjwmyhcTyLggvAAA7gbgnWrrUZGlJoIOzYLGH9Jyv4JTJ3rJ
X-Google-Smtp-Source: ABdhPJx/KYCFz6FgIUcLyDbXD42FqL+deB76vTvJaP/EvBE7RJ+TITdyhA8wtIVBD+3O2SnH4SFK5CGo+K7picGXTjM=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr1092082oic.64.1598311932105;
 Mon, 24 Aug 2020 16:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
 <xmqqeenz95bj.fsf@gitster.c.googlers.com> <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
 <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com>
In-Reply-To: <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Tue, 25 Aug 2020 05:02:00 +0530
Message-ID: <CA+CkUQ_eRqOB8Ushg-BcEmjRxEZSs7tmPnZcb8GUTwz3R55Xhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Eric Sunshine <sunshine@sunshineco.com>
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

Hi,

On Mon, Aug 24, 2020 at 9:19 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Aug 23, 2020 at 8:56 PM Hariom verma <hariom18599@gmail.com> wrote:
> > On Sat, Aug 22, 2020 at 12:47 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > > ...an alternative would have been something like:
> > > >
> > > >   else if (!strcmp(arg, "trailers")) {
> > > >     if (trailers_atom_parser(format, atom, NULL, err))
> > > >       return -1;
> > > >   } else if (skip_prefix(arg, "trailers:", &arg)) {
> > > >     if (trailers_atom_parser(format, atom, arg, err))
> > > >       return -1;
> > > >   }
> > > >
> > > > which is quite simple to reason about (though has the cost of a tiny
> > > > bit of duplication).
> > >
> > > Yeah, that looks quite simple and straight-forward.
> >
> > Recently, I sent a patch series "Improvements to ref-filter"[1]. A
> > patch in this patch series introduced "sanitize" modifier to "subject"
> > atom. i.e "%(subject:sanitize)".
> >
> > What if in the future we also want "%(contents:subject:sanitize)" to work?
> > We can use this helper any number of times, whenever there is a need.
> >
> > Sorry, I missed saying this earlier. But I don't prefer duplicating
> > the code here.
>
> Pushing back on a reviewer suggestion is fine. Explaining the reason
> for your position -- as you do here -- helps reviewers understand why
> you feel the way you do. My review suggestion about making it easier
> to reason about the code while avoiding a brand new function, at the
> cost of a minor amount of duplication, was made in the context of this
> one-off case in which the function increased cognitive load and was
> used just once (not knowing that you envisioned future callers). If
> you expect the new function to be re-used by upcoming changes, then
> that may be a good reason to keep it. Stating so in the commit message
> will help reviewers see beyond the immediate patch or patch series.

Yeah. I should have mentioned this in the commit message.

> Aside from a couple minor style violations[1,2], I don't particularly
> oppose the helper function, though I have a quibble with the name
> check_format_field(), which I don't find helpful, and which (at least
> for me) increases the cognitive load. The increased cognitive load, I
> think, comes not only from the function name not spelling out what the
> function actually does, but also because the function is dual-purpose:
> it's both checking that the argument matches a particular token
> ("trailers", in this case) and extracting the sub-argument. Perhaps
> naming it match_and_extract_subarg() or something similar would help,
> though that's a mouthful.

I will fix those violations.
Also, "match_and_extract_subarg()" looks good to me.

> But the observation about the function being dual-purpose (thus
> potentially confusing) brings up other questions. For instance, is it
> too special-purpose? If you foresee more callers in the future with
> multiple-token arguments such as `%(content:subject:sanitize)`, should
> the function provide more assistance by splitting out each of the
> sub-arguments rather than stopping at the first? Taking that even
> further, a generalized helper for "splitting" arguments like that
> might be useful at the top-level of contents_atom_parser() too, rather
> than only for specific arguments, such as "trailers". Of course, this
> may all be way too ambitious for this little bug fix series or even
> for whatever upcoming changes you're planning, thus not worth
> pursuing.

Splitting sub-arguments is done at "<atomname>_atom_parser()".
If you mean pre-splitting every argument...
something like: ['contents', 'subject', 'sanitize'] for
`%(content:subject:sanitize)` in `contents_atom_parser()` ? I'm not
able to see how it can be useful.

Sorry, If I got your concerned wrong.

> As for the helper's implementation, I might have written it like this:
>
>     static int check_format_field(...)
>     {
>         const char *opt
>         if (!strcmp(arg, field))
>             *option = NULL;
>         else if (skip_prefix(arg, field, opt) && *opt == ':')
>             *option = opt + 1;
>         else
>             return 0;
>         return 1;
>     }
>
> which is more compact and closer to what I suggested earlier for
> avoiding the helper function in the first place. But, of course,
> programming is quite subjective, and you may find your implementation
> easier to reason about. Plus, your version has the benefit of being
> slightly more optimal since it avoids an extra string scan, although
> that probably is mostly immaterial considering that
> contents_atom_parser() itself contains a long chain of potentially
> sub-optimal strcmp() and skip_prefix() calls.

"programming is quite subjective"
Yeah, I couldn't agree more.

The change you suggested looks good too. But I'm little inclined to my
keeping my changes. I'm curious, what others have to say on this.

Thanks,
Hariom
