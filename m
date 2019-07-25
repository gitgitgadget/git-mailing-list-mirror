Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46FE1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 20:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGYUMN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:12:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44746 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfGYUMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:12:13 -0400
Received: by mail-ua1-f65.google.com with SMTP id 8so20358088uaz.11
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faqqZzvV2d3HruZLpz7XD67fXarggOjYiqnDODSODdo=;
        b=lAkt1OeLG6k0OEOgPcjcD+2kTBJpyacnD/T0sxcbFBi59NjSDKrtqb3P5TzrPhAzxo
         ThhJFnQr4arWnMwDgip+DI77MPJYt1voopk28/uiftKn35LCppf0yAZJINNHyY/BRMnQ
         7M1NVCUdfwVG6xKxOWmrlcBpZmKhJAPECYeX/uWD3hVWgEUO2/LX7k5dtWRg9W0a/SLB
         kfEVZrkWClyz5lxeoy6yFhHzxA85TmXGKf4lpilrLFkp3+M08/HvgLAJPhI9XzPM7Zd+
         IYYtvmQxDNziOiGDdb/sHenGH1Bu9qAcZOodZNNKk1fOqYIoZvMdzL9IyexrthfrFnT8
         poSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faqqZzvV2d3HruZLpz7XD67fXarggOjYiqnDODSODdo=;
        b=Ln9OYtTHfcFASCvLew25yMlKCTqf8OuYBJj42zl1JayzBQ4Uqi6muSN65O8GHhz/Yz
         OSBS76NjUxis7QmQCvMMIv2iq0Mu2peccrqh11Z3d2KIoZjXh04PVNGfSudxE0upcBP0
         L+f3J/xb4bceBxhfnZ2VDi3K4K9rNEdTVq0EIFTlpsNkoj8y+Y3sPKEeFytncCVUHR0R
         ZNgd0v5Y/653ddNe4lWgR0OucR3HAzGi5p/2KjdOmarHO3xpElKSl82aZsgKllM9u1DN
         FDIKu7/EM0xyhHmkVebXlxKVHPUzGHqK485IWbBT9zqtl9GGwBD2z79vfzuw+HM5vGKi
         Smcg==
X-Gm-Message-State: APjAAAX/k87880bMtgAqq2OPRy9F6rBXTXF/FGbfLZ3TRa8pDykZwgVd
        fBh5yf9Yn0V5So00L6AvngftGun9qBPoILYX9VE=
X-Google-Smtp-Source: APXvYqxci6TDidBLCMG4CRLKANZdpHn3z72NZKJSFAtQCMFTpxAbOnv1Hp8v3nV4vMykqyqPcvBcl1MNcVs5R61pg+Q=
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr26661512ual.1.1564085531994;
 Thu, 25 Jul 2019 13:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-5-newren@gmail.com>
 <nycvar.QRO.7.76.6.1907252142470.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907252142470.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Jul 2019 13:12:00 -0700
Message-ID: <CABPp-BEfqsCn11kHEAdHX9+fFv6iiSLV9TTL5XaZ_aDccNft6w@mail.gmail.com>
Subject: Re: [PATCH 04/19] merge-recursive: exit early if index != head
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 12:51 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
> > We had a rule to enforce that the index matches head, but it was found
> > at the beginning of merge_trees() and would only trigger when
> > opt->call_depth was 0.  Since merge_recursive() doesn't call
> > merge_trees() until after returning from recursing, this meant that the
> > check wasn't triggered by merge_recursive() until it had first finished
> > all the intermediate merges to create virtual merge bases.  That is a
> > potentially huge amount of computation (and writing of intermediate
> > merge results into the .git/objects directory) before it errors out and
> > says, in effect, "Sorry, I can't do any merging because you have some
> > local changes that would be overwritten."
> >
> > Further, not enforcing this requirement earlier allowed other bugs (such
> > as an unintentional unconditional dropping and reloading of the index in
> > merge_recursive() even when no recursion was necessary), to mask bugs in
> > other callers (which were fixed in the commit prior to this one).
> >
> > Make sure we do the index == head check at the beginning of the merge,
> > and error out immediately if it fails.
>
> Very clear commit message.
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 37bb94fb4d..b762ecd7bd 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -3381,21 +3381,14 @@ static int process_entry(struct merge_options *opt,
> >       return clean_merge;
> >  }
> >
> > -int merge_trees(struct merge_options *opt,
> > -             struct tree *head,
> > -             struct tree *merge,
> > -             struct tree *common,
> > -             struct tree **result)
> > +static int merge_trees_internal(struct merge_options *opt,
>
> In other, similar cases, we seem to use the suffix `_1`. Not sure
> whether you want to change that here.

Hmm, we do seem to use `_1` about 2.5 times as frequently as
`_internal`, but both do seem to be in use to me (e.g.
init_tree_desc_internal, convert_to_working_tree_internal,
repo_parse_commit_internal).  `_1` does have the advantage of being
shorter, which makes lines fit in 80 columns better, but `_internal`
seems like a clearer description to me.

So...I'm not sure what's best here.  I don't have a strong opinion,
but I'm inclined towards laziness and leaving it alone unless someone
else has strong opinions.

> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     assert(opt->branch1 && opt->branch2);
> > +
> > +     if (repo_index_has_changes(opt->repo, head, &sb)) {
> > +             err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> > +                 sb.buf);
>
> I know that you did not introduce this leak, but maybe we could slip an
> `strbuf_release(&sb);` in at this point?

Ooh, good point.  I'll fix that up for round 2.

> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void merge_finalize(struct merge_options *opt)
> > +{
> > +     /* Common code for wrapping up merges will be added here later */
> > +}
>
> I was about to comment that this complicates this here diff and that we
> should do this when we need it, but I just peeked into the next patch,
> and it uses it, so I leave this here paragraph only to show that I
> actually reviewed this part, too.
>
> And of course, if we have a `merge_finalize()`, then a `merge_start()`
> does not sound all that bad, either.
>
> The rest looks good to me.

Thanks!
