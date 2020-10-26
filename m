Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440AC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E5E2087C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP8yoT09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394412AbgJZW2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:28:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41730 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394061AbgJZW2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:28:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so11581688oih.8
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+ZvLhQpM+r8+0x5f/A4v0DDqBeY3J2uVZ+UHsxf4u4=;
        b=vP8yoT09Bt2srfPrEp7ZgfBroHwg6BqmowOo52E3bSsGQh33ChC0b6RKz253cm4qww
         PLwZYx+y2xLUiFU9bEaSrcjpCefHdcUpOJKnZSIPQmnFwNqE0R2NMnfCVsDu9FLFUyZy
         lsUhXu4a32M+tNi5VS7VOsNI8WRdKNeFZq3PoiDRqpfBygGHMzy+ekPkzZRYTlVgZ18i
         e/emStkxt/nxi0HdBu+i7jZBBX9sGWy0yo4nIf8Gf5nzD/Ut/wWZvbOkKcqzxqCNrekC
         V/q0PGlGzBeXB3EFzq+2JNWFsznBaMbRE0NHSEnMcgUMhRIJMCk2TJIzDQMEkxdYrMI+
         g4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+ZvLhQpM+r8+0x5f/A4v0DDqBeY3J2uVZ+UHsxf4u4=;
        b=UlQAwjJEfx9pqcsQcHzkQKZnanA7TPuwc1nFSrpZrv0tHth58TRlgdr8SFrPvLhR0m
         yMWik/xxZ+0GsJGOsNcJoIV0hPX2KsdBAI2sE5wHE1AH3T39UelPA0VNxgkhIxVeg77C
         pikCCVwPjMrTAA/dG9ZsgF0xxH6JSQcaha4G7D7mGtBd6xI/iU/y+xBXNZTOYu064RVY
         mBTGzskBYZAbfc2awWuNw1pvDMZavS0suZ8GoP7nSnPffRR2NVw0VLrOLoHfdq2Ik/yi
         NFS1lNi/mLhgRrg4L2HsPgWcUztzh2fi0oqvE836jQuf5aEXcS5y3wFSzBgWfezVPSKf
         3Z/A==
X-Gm-Message-State: AOAM533pSzRW5CMc/BYlv4xkydZWjxNVyjF4EFNTbMgpt1Q68cKtuJxl
        O3TPjYMocMZ4QEGhrWUppfjhbqWvSoPiWA9jiHs=
X-Google-Smtp-Source: ABdhPJz5GFMhJHeTPINBDtYQG6sVZ2Dmk0EyQYrZ/OIbfVVLGVyNLe0D4huQxTrv7LsOwMbSDOAyMwKqOrOlmlcXY04=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr12058766oic.31.1603751316046;
 Mon, 26 Oct 2020 15:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
 <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com> <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
 <xmqqa6w8emxn.fsf@gitster.c.googlers.com> <CABPp-BFtzeOHS=ptgzkrpOL3gwvE6bSaRgxLO1QJ284J08i-mA@mail.gmail.com>
 <xmqqsga0d4f1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsga0d4f1.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 15:28:24 -0700
Message-ID: <CABPp-BEToXsTiF+7C12-aZFYFFxR99j1aGmMAi3VXfGUM_OrXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 3:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:

> >> > +     /*
> >> > +      * Additional metadata used by merge_switch_to_result() or future calls
> >> > +      * to merge_inmemory_*().  Not for external use.
> >> > +      */
> >> > +     void *priv;
> >> > +     unsigned ate;
> >>
> >> I'd prefer to see this named not so cute.  Will we hang random
> >> variations of things, or would this be better to be made into a
> >> pointer to union, with an enum that tells us which kind it is in
> >> use?
> >
> > I don't understand the union suggestion.  Both fields are used.
>
> I thought "priv" shouldn't be "anything goes, so it is 'void *'" but
> is probably a "union { ... } priv;" with associated enum next to it
> that tells which one of the possibilities in the union is in effect.

I guess I'm still not following where these "possibilities" come from
or what I could have said that would have suggested possibilities.

priv is a pointer to a private data structure.  The data structure is
defined and used only in merge-ort.c and not exposed to callers.  That
data does need to be passed from merge_incore_*() to
merge_switch_to_result() (or to merge_finalize()).  Since those two
are separate function calls invoked by the caller, and since callers
shouldn't touch any of this data in priv, it's passed as an opaque
field within merge_result.  Thus void*.

> > Would you object if 'ate' was named '_'?
>
> Either is horrible name.

I'll just rip it out, for now.  It isn't relevant to early versions of
merge-ort anyway, and when I re-introduce it with yet another horrible
name, there will at least be more context for others to suggest a
better name for me.

Besides, the variable isn't at all necessary for the algorithm; it
exists solely as a way to catch a small gotcha in API usage of later
versions of merge-ort, which I otherwise didn't have a clean way of
detecting.

> >> > +/* rename-detecting three-way merge with recursive ancestor consolidation. */
> >> > +void merge_inmemory_recursive(struct merge_options *opt,
> >> > +                           struct commit_list *merge_bases,
> >> > +                           struct commit *side1,
> >> > +                           struct commit *side2,
> >> > +                           struct merge_result *result);
> >>
> >> I've seen "incore" spelled as a squashed-into-a-single-word, but not
> >> "in_memory".
> >
> > I can add an underscore.  Or switch to incore.  Preference?
>
> Anything shorter would get my vote.

Sounds good, will do.

> > Yes, your reading is correct.  We don't touch the index (or any index,
> > or any cache_entry) at all.  Among other things, data that can be used
> > to update the index are in the "priv" field.
> >
> > I'll try to add some notes to the file.
>
> Sounds good.

:-)
