Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F10C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6582078D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpeFlKmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHZUsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgHZUsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 16:48:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85389C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 13:48:53 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so2741665oic.7
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qwVBIwIc+ANF7Vlv8mWBKvg2IcoVhTDedzQboAIrQA=;
        b=LpeFlKmLkuYw4Xlp+MxcZ2paIspj0nifO03jtT5T7jdIcl8gvmsWYgc/EwxJGY0aU8
         f2WThQBtOwgF5glHtQi6TD8L6+2wy3zFa14SNzNTDh3Xz8svoS63khQqUqeBeBMqcJqX
         HgvZ1dCsE8AZV6zsUDQZJ+lakSxYxBJWAxeENQdPYm/mmhdAgXMGi4A6UGPv3Kf9EOI+
         OkhJMUAuaidvc/3V4fRUF+uPHX68Ctg1lpznCtT8EyAVg0Kq/EXNSRv4JsTjwHn03IaB
         aZ5RlduFWInpDySoigBpFUlnr2Vh4+Kge2WPGWKwz/K8exZrZiiD7hNmRPb8QS4Fp8VH
         2PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qwVBIwIc+ANF7Vlv8mWBKvg2IcoVhTDedzQboAIrQA=;
        b=pPtACOZunRzvhaadVS7hWOhGYRXA3E4kkEGeJD1X1eXhl01cygg09vse2XI7Ro7OKu
         4ZAHNxNjg1gXvNL2yDzyJSdAJ/leu+PcTyl2idISFQUUtnCRvfkCG2UHsrsp2QdiVmMa
         nfkvD1KZABHG74vStcWsEePPjNgomQle5k7eFUqylYnft/cLbKtYgguWJJ0/P3myKZTR
         J/q2T+AWCAGWZbnj/A3JsnAZmpZgnveJ9EcOE3G5Dmi9SilBCeNt6w6hgIOmb2MwgmhT
         lC4v3r3Oek0l6hQZWlb/UUEWk+xA0fmh5a5JHbVjtT7viHwEvWAbU7Ayc5fvuLxqPg/N
         Dbkg==
X-Gm-Message-State: AOAM530oUI0S+YQgqy4DH399xfwaFC1OwseR28tI9dmveLVWqj6pRW1q
        KIV6/MCW1CaLAPabHdzOzkFtgvASgxbsTfwHyozYnlpg8tQ=
X-Google-Smtp-Source: ABdhPJywyex/Li8BHeUMfzynAky1wwyyTYyriEtwxxehk9vpKVZbWsAn/CJRwQ5EQ+w4XrYTnfL6Y0rJWqnUzy8Iazs=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr4730603oic.64.1598474932681;
 Wed, 26 Aug 2020 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
 <xmqqeenz95bj.fsf@gitster.c.googlers.com> <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
 <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com>
 <CA+CkUQ_eRqOB8Ushg-BcEmjRxEZSs7tmPnZcb8GUTwz3R55Xhg@mail.gmail.com> <CAP8UFD03Am94_84FvRPxEdt_AG74864eQ4TimggKtUYWjJYqCg@mail.gmail.com>
In-Reply-To: <CAP8UFD03Am94_84FvRPxEdt_AG74864eQ4TimggKtUYWjJYqCg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 26 Aug 2020 20:48:41 +0530
Message-ID: <CA+CkUQ_M=q9bkxjM9b+5DRkRBoFRnzhnsCUB-gX9GEeW6H5SVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 26, 2020 at 11:48 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Tue, Aug 25, 2020 at 1:32 AM Hariom verma <hariom18599@gmail.com> wrote:
>
> > On Mon, Aug 24, 2020 at 9:19 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> > > Aside from a couple minor style violations[1,2], I don't particularly
> > > oppose the helper function, though I have a quibble with the name
> > > check_format_field(), which I don't find helpful, and which (at least
> > > for me) increases the cognitive load. The increased cognitive load, I
> > > think, comes not only from the function name not spelling out what the
> > > function actually does, but also because the function is dual-purpose:
> > > it's both checking that the argument matches a particular token
> > > ("trailers", in this case) and extracting the sub-argument. Perhaps
> > > naming it match_and_extract_subarg() or something similar would help,
> > > though that's a mouthful.
> >
> > I will fix those violations.
> > Also, "match_and_extract_subarg()" looks good to me.
>
> I am not sure about the "subarg" part of the name. In the for-each-ref
> doc, names inside %(...) are called "field names", and parts after ":"
> are called "options". So it might be better to have "field_option"
> instead of "subarg" in the name.
>
> I think we could also get rid of the "match_and_" part of the
> suggestion, in the same way as skip_prefix() is not called
> match_and_skip_prefix(). Readers can just expect that if there is no
> match the function will return 0.
>
> So maybe "extract_field_option()".

Makes sense to me.

> > > But the observation about the function being dual-purpose (thus
> > > potentially confusing) brings up other questions. For instance, is it
> > > too special-purpose? If you foresee more callers in the future with
> > > multiple-token arguments such as `%(content:subject:sanitize)`, should
> > > the function provide more assistance by splitting out each of the
> > > sub-arguments rather than stopping at the first? Taking that even
> > > further, a generalized helper for "splitting" arguments like that
> > > might be useful at the top-level of contents_atom_parser() too, rather
> > > than only for specific arguments, such as "trailers". Of course, this
> > > may all be way too ambitious for this little bug fix series or even
> > > for whatever upcoming changes you're planning, thus not worth
> > > pursuing.
> >
> > Splitting sub-arguments is done at "<atomname>_atom_parser()".
> > If you mean pre-splitting every argument...
> > something like: ['contents', 'subject', 'sanitize'] for
> > `%(content:subject:sanitize)` in `contents_atom_parser()` ? I'm not
> > able to see how it can be useful.
>
> Yeah, it seems to me that such a splitting would require a complete
> rewrite of the current code, so I am not sure it's an interesting way
> forward for now. And anyway adding extract_field_option() goes in the
> right direction of abstracting the parsing and making the code
> simpler, more efficient and likely more correct.
>
> > Sorry, If I got your concerned wrong.
> >
> > > As for the helper's implementation, I might have written it like this:
> > >
> > >     static int check_format_field(...)
> > >     {
> > >         const char *opt
> > >         if (!strcmp(arg, field))
> > >             *option = NULL;
> > >         else if (skip_prefix(arg, field, opt) && *opt == ':')
> > >             *option = opt + 1;
> > >         else
> > >             return 0;
> > >         return 1;
> > >     }
> > >
> > > which is more compact and closer to what I suggested earlier for
> > > avoiding the helper function in the first place. But, of course,
> > > programming is quite subjective, and you may find your implementation
> > > easier to reason about. Plus, your version has the benefit of being
> > > slightly more optimal since it avoids an extra string scan, although
> > > that probably is mostly immaterial considering that
> > > contents_atom_parser() itself contains a long chain of potentially
> > > sub-optimal strcmp() and skip_prefix() calls.
> >
> > "programming is quite subjective"
> > Yeah, I couldn't agree more.
> >
> > The change you suggested looks good too. But I'm little inclined to my
> > keeping my changes. I'm curious, what others have to say on this.
>
> I also prefer a slightly more optimal one even if it's a bit less compact.

+1

Thanks,
Hariom
