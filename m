Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3CC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6842561245
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhFNOn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:43:29 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:41806 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhFNOn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 10:43:28 -0400
Received: by mail-oo1-f53.google.com with SMTP id k21-20020a4a2a150000b029024955603642so2694128oof.8
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8Yp+S5N+PGRE0YaaUs0VTmCUT47Gpe/PcDmZY/gVA0=;
        b=WNZMXNJsnBbIKJeYwa5f4rIPhChdUIobZPM7D+Mmhs1jgbWd1fbSF5qeFS4Dftg8qV
         BhCyja2WEx+rK1oq0YgwAcLalKypOWxlzugtMXFzwgJlHpcg9jjwhOzCxlxUpqXZwPgW
         OWgINDEkqj/0vccCxW1qBFg5UyGIt42JRWzBtnkCZldzjsY7nGtBBbyQRbDfAdQcC80U
         KW3w8yS4qrTcjMLwaZGqDb/GZY0IlivqQJ5XQ/mFRk7cilXpQo1tUH9kpBEaPy9ENr1s
         69W/uVMfc7m4AW60+9sy6qQG9kUizCaAe1NM7L0Lv/YLzcu5NSmjiK2+OjH/FNIqBstM
         EwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8Yp+S5N+PGRE0YaaUs0VTmCUT47Gpe/PcDmZY/gVA0=;
        b=k+d6kQnx2PFbpeUaI7vZs/gjUDRE7YaCowCkgSvCEh6P+e/OGv9sEp7yFqHYX9X+qs
         mn4Dr0GjsWSW4VroWvh/Ie2Ijh+1gHqYc/hqhKcqUfRFpnyMLMMmnDCBxcx5OuWBQTzN
         v6t6A17oaVafjHJpbkX8n5RLV+sox8QMPXAkeq5VxGEBcLTw23hlPJ2q2gmRr1Bgad6J
         c5l7YCfRaFn19HE+jU7jgeX9SutKfff15EKC5aspL9/4kxJyDgLciIMzDSUUchIWcAoY
         YqUx01rjgdoN+YEMckwKS/pcYz5E/AZ6GPaH7gY436foK7UvJF0wLjV5vSf6oow2m4Fj
         zBQw==
X-Gm-Message-State: AOAM53172nyL6bYfNW3Kvl14Sm0DFeT7Qzx2FWC1tpXABDH4N+ZJk8wa
        HBagtOTPofX7Fyy70cRlezfjbN2DzNwEl2UVf94=
X-Google-Smtp-Source: ABdhPJy2q4Pa9aqlZjiMiteJ6ohYnlm/hmyCnGLcbpdyKGUmjJl2MK46YnHUEAgSCjZrhCbRg97eyorDFk4W0zl+Lc8=
X-Received: by 2002:a4a:b789:: with SMTP id a9mr13265149oop.45.1623681610253;
 Mon, 14 Jun 2021 07:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
 <60c588d452750_3d86c2085c@natae.notmuch> <CABPp-BE4r=Nhw2sJS++7Eh1K5rpyWgg+f8vDTf92JBayt1B_cA@mail.gmail.com>
 <60c63bc3f616_41f452086b@natae.notmuch>
In-Reply-To: <60c63bc3f616_41f452086b@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 07:39:58 -0700
Message-ID: <CABPp-BHh9dfuOV3wM_K7Zks4hzry3RDxjsaxrLztLDy0FtELCA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 10:09 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Sat, Jun 12, 2021 at 9:25 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > Eric Sunshine wrote:
> > > > On Sat, Jun 12, 2021 at 8:44 PM Felipe Contreras
> > > > <felipe.contreras@gmail.com> wrote:
> > > > > The original explanation didn't seem clear enough to some people.
> > > > >
> > > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > > ---
> > > > > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > > > > @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> > > > > +For example, if you have a linear history like this:
> > > > >
> > > > > +    ---A---B---C---D---E---F
> > > > >
> > > > > +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> > > > > +commits, but doing A..F B..E will not retrieve two revision ranges
> > > > > +totalling 8 commits. Instead the starting point A gets overriden by B,
> > > > > +and the ending point of E by F, effectively becoming B..F, a single
> > > > > +revision range.
> > > >
> > > > s/overriden/overridden/
> > > >
> > > > For what it's worth, as a person who is far from expert at revision
> > > > ranges, I had to read this revised text five or six times and think
> > > > about it quite a bit to understand what it is saying,
> > >
> > > Can you explain why?
> >
> > I tend to agree with Eric.  I think the example you chose is likely to
> > be misinterpreted and your wording magnifies it.  A..F B..E simplifies
> > to B..F which is *almost* the union of A..F and B..E, it's only
> > missing A.  Off-by-one errors are easy to miss.
>
> Yes, but right before it's explained that the ending point is F.
> Not E, F.

I think this is somewhat of a useless distinction -- not for the end
result, but in terms of helping users understand.  We started adding
an explanation to the manual because users misunderstand how
"start1..end1 start2..end2" is treated and we want to correct their
misunderstandings.  In that context, the only misunderstanding I can
think of that is dispelled by specifying F is the endpoint would be
"two ranges are intersected to get the range of commits that log will
operate on".  I've never seen users assume that or make such a
mistake.  I've always seen them assume that the "two ranges are
combined with a union".  In that case, F matches their
misunderstanding, so this part of the explanation does nothing to help
correct their assumptions.

The only place their misunderstanding disagrees with the correct
answer for your example is on the other side of those ranges.  They
would have gotten an incorrect answer of "A..F B..E" == "A..F" ,
whereas the correct answer is "B..F".  That's an off-by-one error, but
I think they're likely to miss it.  Especially given that folks
already mess up the left hand side of single "FOO..BAR" expressions
with off-by-one errors.

> > You make it more likely that they'll miss it, because there are only 6
> > commits total in the union, and you are trying to explain why listing
> > A..F B..E while not be 8 commits, which readers can easily respond
> > with, "Well, of course it's not 8 commits.  There's only 6.
>
> If the reader understands that no more than 6 commits can be returned,
> then the reader has understood the point that the operation is not
> addition.

Who in the world ever assumes that "two dotted ranges are combined via
list addition"?  I've only ever come across users assuming the
operation is a union (or, equivalently, addition on sets).  I don't
understand why you even try to make that point, and think it's a
distraction that does more harm than good.

> > When you do the union operation, of course the duplicates go away",
> > and miss the actual point that A got excluded.
>
> But that is not the point. This is the point:
>
>   Unless otherwise noted, all git commands that operate on a set of
>   commits work on a single revision range.
>
> You are missing the forest for the trees.

I think you are missing the boat.

That sentence on its own is completely insufficient to dispel the
misunderstanding.  All that sentence says to users is that if they
specify what they think of as "two ranges" that we'll somehow treat it
as one; but since users are prone to think that "revision range" is
interchangeable with "set of revisions" (especially since we defined
A..B elsewhere in set operations), this will merely make them think in
terms of what set operation they need to perform on the "two ranges"
to get the set of commits the operation will function on.

Most users I've seen simply do that via applying a simple operation to
combine two ranges into one.  Everyone I've ever run across that
misunderstands this "two range" thing, does so in the same way: by
assuming that the two ranges are combined via a union to get an
interesting set of commits.

The example you provide should attempt to help explain why that mental
model is mistaken and provide them with a corrected one.  Your
response to Eric suggests you're not even trying to provide a
corrected mental model, and your response here suggests you are trying
to only correct mistakes of the form "take two revision ranges and add
them keeping duplicates" and "take two revision ranges and intersect
them", neither of which I've observed in the wild.

> In the context of gitrevisions(7) the user has just been told that:
>
>   1. We are trying to specify a graph of commits reachable from a
>      commit, or commits.
>
> The user was shown this graph:
>
>   G   H   I   J
>    \ /     \ /
>     D   E   F
>      \  |  / \
>       \ | /   |
>        \|/    |
>         B     C
>          \   /
>           \ /
>            A
>
> And that B is A^, therefore doing `git log A B` is redundant, as is
> doing `git log A B D`.
>
>   2. The caret notation `^r1 r2` means commits reachable from r2, but
>      exclude commits reachable from r1 (r1 and it's ancestors)
>
> That means '^D A' will exclude D G and H.
>
>   3. The two-dot range notation `r1..r2` is the same as `^r1 r2`
>
>
> Now, whith this context in mind, we are trying to hedge the corner-case
> of `r1..r2 r3..r4` in other words: `^r1 r2 ^r3 r4`.
>
> The user has been told already that C..A is the same as `^C A` (I'm
> changing the order to be consistent with the graph above). And to make
> my point clear I actually don't need two starting points.
>
> So how about this:
>
>   Commands that are specifically designed to take two distinct ranges
>   (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
>   they are exceptions.  Unless otherwise noted, all git commands
>   that operate on a set of commits work on a single revision range. Just
>   like 'A A' coalesces to 'A', 'B..A C..A' is the same as the
>   single revision range '^B ^C A'.

Your example here almost seems to suggest that we do an intersection
of the "two ranges" to get the answer.  It's certainly not your
intent, but I think the users I've helped would be prone to read it
that way due to your focus on coalescing, and due to your selection of
an example which happens to give the correct answer when using the
intersection misinterpretation.

I would be much happier with something like this:

"""
Note: There is no shorthand for getting a union or intersection of
multiple dotted ranges.

Commands that are specifically designed to take two distinct ranges
(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
are exceptions.  Unless otherwise noted, all git commands that operate
on a set of commits work on a single revision range.  Thus, just as
"A..B" translates to "^A B", the expression "A..B C..D" translates to
"^A B ^C D", i.e. all commits reachable from either B or D, as long as
they are not reachable from either A or C.  This is much different
than you would get by trying to do either an intersection or union of
the two separate ranges A..B and C..D.  Compare the differences on the
following simple linear history:

    ---A---B---C---D---E---F---G---H

The command

$ git log A..E C..H

would be the same as

$ git log C..H

(since E is reachable from H, and A is reachable from C).  In contrast,
the union of A..E and C..H would be A..H, while the intersection would
be C..E.
"""
