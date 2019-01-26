Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573731F453
	for <e@80x24.org>; Sat, 26 Jan 2019 22:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAZWMy (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 17:12:54 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35108 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfAZWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 17:12:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so7747473vsc.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkkAI9B1Bd1DDz36qYwdo/KXr+HNg+x8Dd6wm+nKIWc=;
        b=W/a3LpRa/CFBVDH8gOIz76GbH56083OfNo8tCt/U4xAeBIOyikEXgeaxxcEfEVEpCJ
         EqKW9jS/D5of4FE5iyElJbseRbfYnTnU4LGj+Q9Ao173j0z4qgDU3lEY4xlxK8Op1K57
         cJR8AkXAbfK7GzO9JwyL+LbkkhPc4E6sfAQXivQzze+0gqptVPReBUOyRWId591Ouoo2
         XrfRDlWUz9KNmDrzWLlX8asNu14ZsZTotFwzIBH2GHDpKbHSidPWAXiOnvco63VdlN5M
         fatIKKaHCT/WFqsTia1QMhW07IFtGcTWASNiFQgMowYm7pwxzVcid+Jq0YKDlUB7p7oz
         of7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkkAI9B1Bd1DDz36qYwdo/KXr+HNg+x8Dd6wm+nKIWc=;
        b=kmtXaa/sqmlyaYhVlYfwphzrzKgLk7m0N8Vw3zc+g2gZqpm62TpI6get4958YAYrPO
         8Uaqjkm3HPu56CvUJt6K1p4qa74Z3X2Ql4xlZ09vFJlf+xUFpZ9jtYhOtOwqnJ2E9el2
         ihqEP0jD4C+h08ziFEMKdFXP7AfAPhkhCRuN9jnGifgToJ1Hn/VNK+WPUZgmWNXUmvPW
         p0CcNjt84Sdsp/1Xb1dY4xb+65ZoSClRqzi0lIqup8t4Cal9GrMabwndMoQgoSssx9+n
         /AZa3+oU//HceqZXKdr/i8VJMnu+MH4+86O6/jd+TN3jjBZ3siTFNcAVXBO9oXhyLY6R
         GNcQ==
X-Gm-Message-State: AJcUukfC/QjIBrn3kq+WLqffPcDUPABFL2pDOeCc9tR/5MFbbkXowarZ
        pwDoTGXs3Y+Rg+r8n5b7KKjf8Xj/+3rVJJ6N9Ck=
X-Google-Smtp-Source: ALg8bN4mNXdjdEW8C6EPRzUiMrCvtkQ+uJsndRLjdUjQHAnPkIBdmDUoOLy8ZO2qeeWN1M1v9Zfz7n2MdKDcRblMeFA=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr6973660vsm.116.1548540772656;
 Sat, 26 Jan 2019 14:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFjUgY5htSbPpnamPDRM3bCLNsQv-K35uXoRzaT2f85tA@mail.gmail.com> <xmqq8sz8fkfi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sz8fkfi.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Jan 2019 14:12:41 -0800
Message-ID: <CABPp-BFaVwwM17Oe+-RoP5wt2V58AD=dr01uNPuV=9r4yoF3Qg@mail.gmail.com>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 2:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Also, my first version of the patch actually showed all names, on all
> > lines, but I found the heavy repetition really annoying, and not in
> > keeping with how non-merge commits are handled (where original
> > filenames are only shown when they differ).  Granted, my change isn't
> > the only one.  We could just have all names shown if they are not all
> > identical, as you suggest and I also considered, but I liked this way
> > slightly better.  If others feel strongly, I can change it, that was
> > just my gut feel and preference.
>
> I do not have a strong _preference_; I am only worried about ease of
> use by consumers of the raw output, i.e. scripts.  From that point
> of view, --all-names showing all names always even when there is no
> rename is involved would certainly be the easiest to write a parser
> for, and lines being overly repetitive is a non-issue.  For human
> consumption, it would be a separate matter, but they won't be
> reading from the --raw output that lists blob object names
> repetitively (the object names may or may not be different, but they
> are all equally gibberish) before showing the human-readble part,
> which are names.

Okay, I've switched it over.

> > You could kind of ask the same question of -c -p, actually.  I looked
> > into that, but I was only interested in raw format output and --cc is
> > only about coalescing uninteresting hunks in patches.  Whenever git
> > shows a combined diff in patch format, it always lists two files in
> > the header, e.g.:
> >   a/foo.c
> >   b/foo.c
>
> Yeah, but with a new option, it does not have to stay that way.  It
> is OK to show a/foo.c, b/bar.c, c/baz.c, or perhaps an easy way to
> avoid overlong unreadable lines in these human readable output may
> be to only show b/foo.c to report the result and list the original
> names using the "rename from" "rename to" extended diff-headers
> shown in normal diff output with rename detection enabled.
>
> > ...  I guess the "combined" patch is already kind of
> > special, so it could make sense, ...
>
> Absolutely.  -c/--cc output with -p departs from the usual "diff is
> to compare two things" by having two +/- indicator columns and more
> than two '@'s in hunk header to begin with.  It is only natural if
> we are showing more/all names in --raw, we should avoid losing info
> in the same way.

This turned out to be easier to implement than I expected, with one
small wrinkle: We have the "a/" and "b/" prefixes, and switching to
"a/", "b/" and "c/" doesn't work due to things like the
diff.mnemonicPrefix setting -- plus I didn't want to plumb multiple
prefix options everywhere they'd be needed.  Instead, I decided that
instead of having a "from" and a "to" header, we would have N "from"
headers (since all parents are what we came from) and 1 "to" header.
I hope that makes sense, because otherwise I think this become to
unwieldy of a change.
