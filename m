Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3911F453
	for <e@80x24.org>; Fri, 25 Jan 2019 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAYQ1u (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 11:27:50 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43094 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQ1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 11:27:50 -0500
Received: by mail-vs1-f65.google.com with SMTP id x1so5986913vsc.10
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=igj54GAEkteLtTLaMIooONaNVxQJlBqz4QHCFn3UZ3Y=;
        b=LnXlLa9zGN+ArkP5KNh0xYgo0yyhycfGTsWVPbcvav7AMm7QTpWphD+R4beNQTutJ3
         KjLFiqNGLUYBt/KVgxWiEMtpLXo3WJcCZ9uQD33/OutxDJ4x46JA4pMk2NdKXKgGxqVz
         9K2QN5zVvlOmVATOpYwAGA6eHl7kxoH+eatItMFD6M6qhPbHCKQFcDx2/fTiN7xEKwQE
         qK9IGKQhwvvroM/OFOz180Im6AouBp3yJ9Lokb7ejFeknNnx7dm9fQR1I1tEf3BP/hrr
         1TRfvBEzPkUmp+qVbY9l0DURWP1Vi84+/i1eF/3kKMh8oHySuC350gO9ApHg1geBdzbD
         dcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=igj54GAEkteLtTLaMIooONaNVxQJlBqz4QHCFn3UZ3Y=;
        b=PfP3KBoZtA6HB9yCoKj/wmRhjgb6CpFir1lOi2AfYO5Fz2FEWbUgJCNiMV8SLCLKtL
         fci8rm3fhwcW3djwk5Gz95q4wYswpAdQwG+daY/9dtAUR6nHcGB1daCpy4kQOZ6b/39h
         vG/uhTO6geDEeelFogddJ2AEXTTp820HjpOgB/e7g0TKpmIwuh19v115ywtIbVpQGy7m
         7o8mHzcwn0IQQ7tqug07yImEsurYYOvoTH5/OKfuyMczq0O3CgJN+AcPSquaJ9Co/Ht1
         ZkMjGYGmjsAdNTDyB8o8IP2yo/OmUJ+H7G4IKuUjNubopqxmPiDWpMB1C4VKMAkKhDxv
         lDJA==
X-Gm-Message-State: AJcUukdAyEOyw0liY611Y7VgP+49Mrmuqz+B8A79xOi9e9bkLNxgDZjq
        sfHBfxHIfbUNzeZlpHyj7u7shpeIgsfJSuUnJrc=
X-Google-Smtp-Source: ALg8bN4ZLF5BgaXUIkyDjvALSHbCWC+vr5jN5RbZp83KDrkyd5OKqvE/vEqZbhGo9dpOe8RbhCSeJDxyas716g6kebo=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr4975230vsm.116.1548433668533;
 Fri, 25 Jan 2019 08:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <20190125021950.GV423984@genre.crustytoothpaste.net>
In-Reply-To: <20190125021950.GV423984@genre.crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Jan 2019 08:27:36 -0800
Message-ID: <CABPp-BH-7iuSYmxA080UUbuKSEy32-T58oDKNajmFyeFWfauEA@mail.gmail.com>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 24, 2019 at 6:19 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Thu, Jan 24, 2019 at 08:46:54AM -0800, Elijah Newren wrote:
> > The critical part of the patch is the few line change to
> > show_raw_diff(), the rest is plumbing to set that up.
> >
> > This patch was based out of Peff's suggestion[1] to fix diff-tree to
> > do what I needed rather than bending fast-export to cover my usecase;
> > I've been running with a hacky version of this patch for a while and
> > finally cleaned it up.
> >
> > [1] https://public-inbox.org/git/20181114071454.GB19904@sigill.intra.peff.net/
> >
> > As an alternative, I considered perhaps trying to sell it as a bugfix
> > (how often do people use -M, -c, and --raw together and have renames
> > in merge commits -- can I just change the format to include the old
> > names), but was worried that since diff-tree is plumbing and that the
> > format was documented to not include original filename(s), that I'd be
> > breaking backward compatibility in an important way for someone and
> > thus opted for a new flag to get the behavior I needed.
> >
> > I did struggle a bit to come up with a name for the option; if others
> > have better suggestions, I'm happy to switch.
>
> Maybe --all-names? You should definitely let other people chime in on
> this as well; it should be obvious by now that I'm no expert on naming
> things.

--all-names may work.  Two possible worries:

1) Would people expect the output when using this option to be of the form:

::100644 100644 100644 fabadb8 cc95eb0 4866510 MM    describe.c
describe.c    describe.c

In other words, even if there are no renames involved, would they
expect us to show the filename from each side of the merge?  I was
trying to make the combined diff output format more similar to how we
handle non-merge commits; we only show more than one filename when a
rename is involved.

2) When looking through manpages I have often found an option that I
thought was related to what I wanted, only to discover that a short
semi-ambiguous option had a much different context in mind than I did
and thus performed some operation entirely unrelated to anything I was
interested in.  I suspect that this won't be a highly used option, as
such, a longer name to disambiguate seemed reasonable.


Of course --combined-with-paths isn't fully descriptive either, and
making it even longer might be annoying, so...  *shrug*

>
> > Range-diff:
> > 1:  29e9ddf532 = 1:  29e9ddf532 log,diff-tree: add --combined-with-paths options for merges with renames
> >
> >  Documentation/diff-format.txt      | 23 +++++++++++++---
> >  Documentation/git-diff-tree.txt    |  9 +++++--
> >  Documentation/rev-list-options.txt |  5 ++++
> >  combine-diff.c                     | 42 ++++++++++++++++++++++++++----
> >  diff.h                             |  1 +
> >  revision.c                         |  7 +++++
> >  revision.h                         |  1 +
> >  7 files changed, 78 insertions(+), 10 deletions(-)
>
> I think it might be nice to see a test for this option so that we avoid
> breaking it in the future. I'm also curious how this works with -z, and
> a test for that would be interesting as well (as well as illustrative of
> the format). For example, is it still unambiguous for machine parsing,
> even with oddly named files?

I'll add a test for both with and without -z.
