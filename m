Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED148C4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7BA60F38
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhHKIPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhHKIPq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 04:15:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF4C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:15:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b7so2490454edu.3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VfmNFEn0tsnpKfpnfs/RPvJ2yzlr+Gwd8gBpFZHBlGU=;
        b=p6r6Hpu1ucuyF+PTaSmHClyrUK34DWJqT7NpnFfwKPTCEMViKT7aOVhq5hsU90DBb7
         SnvG4Y0tG2QWpayVsWFHZzkHlE5tXFSI5dVuponUt+QZuMMh3yQnoss8WjSQ23R/C94h
         Au/C+kWqvFRIwllcHy8ivOV9wTNhzV/fxtotq4Mjb0d+MLzYK0fRmvEz0FhXa/Oc5FG/
         u0hYjrWDTViyKxI+rbTU+E2meqEVezTatx2m5ViNrHHMS6SuKBHh+BBEMKYVRP/4hdEm
         Az6bPbm2++ONXlPpV4bXxPBqThKGIGst6w1tH3NvgBwCqqIeNg+I1bzIZrZVeSow1r4I
         e2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VfmNFEn0tsnpKfpnfs/RPvJ2yzlr+Gwd8gBpFZHBlGU=;
        b=BQKI0H4rxLp7pWS5cV/jzOJ2xOmwQ0lte1FWthuK0fkmd4UxVPvPMTNYVVPo0kzhKt
         fIig65jcLa5Fw4zeGPV5zZpS+LH+B6Q+souZn68yBp5SrFzrs/n2QzsKW1ewWPZ04uSs
         lvrtpVNMbJTfWZBV+1hef8PkDqfxY4+OYKU6K2vbd9bWQuGvIevfKvBmJQUVzFrux8Uu
         HoWZZ0WgpQ81iNRxZHVQtu7BoGmnOLO6bmfDnncLYDsbzBWyuyW3LIdhN9y6BjWw3TK7
         Xox0j7CIW1O+P81G4fbiPOEuu//rpqIEmRAEV449Cve+/Y+fxxdEL9tHBGo0MEvsnd0y
         YCcA==
X-Gm-Message-State: AOAM530g07Ti/9v8VCIPcYrutw0yDnlH5pr7XXH/v0afLDs+iOhbG8YY
        muWUQde8RfhjVhoBWRWL3jAP1GEYQABWFNA1epA=
X-Google-Smtp-Source: ABdhPJzA9oiZfarpne4xOcaK2v1y/3v9rZflzCPujFgzlugG124HpPZig8Kyn91Bm2TUzSazITKUgU/F5XZqeUscFTU=
X-Received: by 2002:a05:6402:1289:: with SMTP id w9mr10068181edv.127.1628669721467;
 Wed, 11 Aug 2021 01:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
 <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com> <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
In-Reply-To: <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Aug 2021 10:15:10 +0200
Message-ID: <CAP8UFD3bgWVH9pfEmvYSO9vs1sA-9vpoocTKqv=jS8zZBLZGWw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 4:20 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=8810=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:04=E5=86=99=E9=81=
=93=EF=BC=9A
>
> > > parse_object_buffer(), let's take a look at the result of gprof again=
:
> > >
> > > We need to call grab_sub_body_contents(), grab_person() to rescan the
> > > buffer and extract the data.
> > > What if we can combine these multiple scanning and parsing into one c=
ompletion?
> > > At least intuitively, this has an opportunity to improve performance.
> >
> > Yeah, but is there a way to check that we indeed scan or parse the
> > same objects multiple times? This way we might get an idea about how
> > much scanning and parsing we could save.
>
> I think find_subpos() called by grab_sub_body_contents() and find_wholine=
()
> called by grab_person() are evidences that we are repeating iteratively.
> But the proportion of time they occupy is too small. 0.0142% and 0.0109%

Could adding traces help with measuring how many times we call
functions like get_object() or format_ref_array_item() for each
object?

I think it's interesting to have a better idea about how many times
functions that seem to take time like the above, or functions that
read objects, like oid_object_info_extended(), are called for each
object.

> Sorry, but my attempts over the past two days have not gone well, the cha=
nges
> here will make the program very complicated, the optimization here is not=
 worth
> doing.

Maybe but it would be interesting to document what didn't work and why.

> > > So I check the implementation
> > > details of `parse_commit_buffer()` and `parse_tag_buffer()`, maybe we
> > > can pass some "hook pointer"
> > > to these parsing functions like `oid_object_info_extended()` does to
> > > extract only the information we need?
> >
> > Would this also avoid scanning and parsing the same object many times?
>
> oid_object_info_extended()? I think it can set the pointer and extract
> the required
> value. Well, the problem it solves may be a little different from here.

Could you explain a bit more?

I wonder if we sometimes call for example oid_object_info_extended()
once for an object and then parse_commit_buffer() for the same object,
when perhaps calling only parse_commit_buffer() once would have given
all the information we need.

> > > I am thinking about whether it is possible to design a `struct
> > > object_view` (temporarily called
> > > `struct commit_view`) to store the offset of the parsed data in the
> > > object content. `parse_commit_buffer()`
> > > will check whether we need something for in-depth parsing. Like this:
> > >
> > > ```c
> > > struct commit_view {
> > > int need_tree : 1;
> > > int need_parents : 1;
> > >
> > > int need_author : 1;
> > > int need_author_name : 1;
> > > int need_author_email : 1;
> > > int need_author_date : 1;
> > >
> > > int need_committer : 1;
> > > int need_committer_name : 1;
> > > int need_committer_email : 1;
> > > int need_committer_date : 1;
> >
> > Is the above info specific for each commit? Or will the above be the
> > same for all the commits we are processing?
>
> According to the my previous thoughts, I think it is same for all commits=
.

Yeah, so I think it doesn't make sense to duplicate it for each
object. It could be a separate struct and we wouldn't need to have it
in a commit slab.

And I think maybe the above could be extended with fields like
"need_full_parsing" or "need_object_info" that could be computed from
the above fields. This could then help avoid several calls to
different functions when one could be enough.

Also aren't bitfields like the above "unsigned int" instead of "int"
in our code base?

> > Ok, so the idea is to use the commit slab feature to store the struct
> > commit_view instances. That seems reasonable to me.
>
> It's a pity that it may not bring much optimization in real situations.

Maybe it's because copying data isn't actually a performance issue.

> > > It seems that GSOC has only the last few weeks left, I'm not sure how
> > > far this patch series is from
> > > being merged by the master branch. Performance optimization may have
> > > no end.
> >
> > Yeah, but the idea for now is just to make using the ref-filter code
> > as fast as the current code.
>
> It seems difficult to achieve consistent performance. As we discussed
> before, the
> previous `git cat-file --batch` can only provide a few kinds of
> metadata that does not
> need to be parsed, and after using ref-filter logic allows cat-file to
> use more structured
> information about git objects.

So the issue seems to be that we can't detect if only a few metadata
that don't need to be parsed are needed?

Could fields like "need_full_parsing" or "need_object_info" that I
suggest above help with that?

> But this means it needs a harder path,
> It requires many
> traversals and many copies,

Could you explain why it needs many traversal and copies in more
details? And what could help avoid that?

> If we really use the logic in ref-filter,
> we can only do partial
> optimization, we can't expect it to be as fast as the old function.
> Unless we have the
> opportunity to not use the logic in ref-filter, but use the new atoms
> in ref-filter, this may
> has a chance to escape the copy in the ref-filter. I don't know what
> your opinion are...

Are you sure we couldn't detect in the ref-filter code that we need
only a few metadata that don't need to be parsed? And then skip
fetching and parsing data we don't need (without using a completely
separate code, like a fast path)?
