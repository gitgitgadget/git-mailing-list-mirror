Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202DFC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 06:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11052076C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 06:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMtUjks9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHZGSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHZGSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 02:18:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D6C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 23:18:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id md23so1245618ejb.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUEYl7b/bYxORX3yivPH7Fb3f3Om0eorEnDKFNfJWAs=;
        b=pMtUjks9c1InrqIolLmri5XSXCnqr2BCFMgRSJmmFkoexpAfQYkUsXvSmevlWNqt6I
         Aw0WyfwLhWK1Xut1gDnSnm2Tg6emheecU804Va8WBfvXwFZz5MoQl4Uozj5E2v2b58+o
         KxOSI6zHihWh4zT9whWn/g9l++RWhcgLQbFF2y3XVKXH9bGDs42IERLydK0TDp6Z9f60
         BR09nc5G61N0tcYWuOW5o04jEYWQVgBS8i8d1UTqd/7rR4/vp+kordSeW0NxrsRr46QX
         aM8Vf/rxpbxDP95inuNI6KSlcQzILKXpaz7fULVd54AKAc1TAQxwL5CBJFP24qKOkMV6
         wufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUEYl7b/bYxORX3yivPH7Fb3f3Om0eorEnDKFNfJWAs=;
        b=ollPxZpwRoamvRMOfKy9r+jUc9xS5J4fpFesSaZsVQhMlKChQjkJ/amXeLCxx/FHTu
         sDDvOKQ0UK7whyKy24vW+s6jAddc9O9EuQxSqNMGiCvx5QiGtmKctQxZV5VkSc0DJvpk
         hf4+S/0OTOAMnoPZWOHNqmgDz3o1MlsVz8uykpt/FQqXpy+V5IPPz1CJ5lQ9nBwexDMA
         J5hZV5blGGFUfIsRQzbczF3sRUndoPi8ELJd5cIhy6SKk/tEGj2E+07DEu9B5BZVgEOl
         wYVvV+NNKFvu1kZueLcNv29aSjG6wrHu+9bjXgP5NjYXIOkmS27+YDi70pxBFB6k2nVb
         HjDg==
X-Gm-Message-State: AOAM5304OPjGOsoBoeY/PkMgiX7pwlbFYgS70tEqtGKxrTSqfTVAUtgj
        o+ogwgzoNWVQ5+TLcoT0lJQUXGn8ti7Lq++QdxE=
X-Google-Smtp-Source: ABdhPJzgRnQZNuL6pLrIA2JxAzDTsaAhEfGo9JN4oTebgJPkgQFU3aMZJ2GYn/qf2qws+rioNNzQBxnNOeZjuMosI5w=
X-Received: by 2002:a17:906:4007:: with SMTP id v7mr14584640ejj.197.1598422722010;
 Tue, 25 Aug 2020 23:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
 <xmqqeenz95bj.fsf@gitster.c.googlers.com> <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
 <CAPig+cScdV1ORSbqDuUiOEvCd6TYgkR=3GK8OCUu4yuoKVy5Pg@mail.gmail.com> <CA+CkUQ_eRqOB8Ushg-BcEmjRxEZSs7tmPnZcb8GUTwz3R55Xhg@mail.gmail.com>
In-Reply-To: <CA+CkUQ_eRqOB8Ushg-BcEmjRxEZSs7tmPnZcb8GUTwz3R55Xhg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Aug 2020 08:18:29 +0200
Message-ID: <CAP8UFD03Am94_84FvRPxEdt_AG74864eQ4TimggKtUYWjJYqCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Hariom verma <hariom18599@gmail.com>
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

On Tue, Aug 25, 2020 at 1:32 AM Hariom verma <hariom18599@gmail.com> wrote:

> On Mon, Aug 24, 2020 at 9:19 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Sun, Aug 23, 2020 at 8:56 PM Hariom verma <hariom18599@gmail.com> wrote:

> > > Recently, I sent a patch series "Improvements to ref-filter"[1]. A
> > > patch in this patch series introduced "sanitize" modifier to "subject"
> > > atom. i.e "%(subject:sanitize)".
> > >
> > > What if in the future we also want "%(contents:subject:sanitize)" to work?
> > > We can use this helper any number of times, whenever there is a need.
> > >
> > > Sorry, I missed saying this earlier. But I don't prefer duplicating
> > > the code here.
> >
> > Pushing back on a reviewer suggestion is fine. Explaining the reason
> > for your position -- as you do here -- helps reviewers understand why
> > you feel the way you do. My review suggestion about making it easier
> > to reason about the code while avoiding a brand new function, at the
> > cost of a minor amount of duplication, was made in the context of this
> > one-off case in which the function increased cognitive load and was
> > used just once (not knowing that you envisioned future callers). If
> > you expect the new function to be re-used by upcoming changes, then
> > that may be a good reason to keep it. Stating so in the commit message
> > will help reviewers see beyond the immediate patch or patch series.
>
> Yeah. I should have mentioned this in the commit message.

I agree.

> > Aside from a couple minor style violations[1,2], I don't particularly
> > oppose the helper function, though I have a quibble with the name
> > check_format_field(), which I don't find helpful, and which (at least
> > for me) increases the cognitive load. The increased cognitive load, I
> > think, comes not only from the function name not spelling out what the
> > function actually does, but also because the function is dual-purpose:
> > it's both checking that the argument matches a particular token
> > ("trailers", in this case) and extracting the sub-argument. Perhaps
> > naming it match_and_extract_subarg() or something similar would help,
> > though that's a mouthful.
>
> I will fix those violations.
> Also, "match_and_extract_subarg()" looks good to me.

I am not sure about the "subarg" part of the name. In the for-each-ref
doc, names inside %(...) are called "field names", and parts after ":"
are called "options". So it might be better to have "field_option"
instead of "subarg" in the name.

I think we could also get rid of the "match_and_" part of the
suggestion, in the same way as skip_prefix() is not called
match_and_skip_prefix(). Readers can just expect that if there is no
match the function will return 0.

So maybe "extract_field_option()".

> > But the observation about the function being dual-purpose (thus
> > potentially confusing) brings up other questions. For instance, is it
> > too special-purpose? If you foresee more callers in the future with
> > multiple-token arguments such as `%(content:subject:sanitize)`, should
> > the function provide more assistance by splitting out each of the
> > sub-arguments rather than stopping at the first? Taking that even
> > further, a generalized helper for "splitting" arguments like that
> > might be useful at the top-level of contents_atom_parser() too, rather
> > than only for specific arguments, such as "trailers". Of course, this
> > may all be way too ambitious for this little bug fix series or even
> > for whatever upcoming changes you're planning, thus not worth
> > pursuing.
>
> Splitting sub-arguments is done at "<atomname>_atom_parser()".
> If you mean pre-splitting every argument...
> something like: ['contents', 'subject', 'sanitize'] for
> `%(content:subject:sanitize)` in `contents_atom_parser()` ? I'm not
> able to see how it can be useful.

Yeah, it seems to me that such a splitting would require a complete
rewrite of the current code, so I am not sure it's an interesting way
forward for now. And anyway adding extract_field_option() goes in the
right direction of abstracting the parsing and making the code
simpler, more efficient and likely more correct.

> Sorry, If I got your concerned wrong.
>
> > As for the helper's implementation, I might have written it like this:
> >
> >     static int check_format_field(...)
> >     {
> >         const char *opt
> >         if (!strcmp(arg, field))
> >             *option = NULL;
> >         else if (skip_prefix(arg, field, opt) && *opt == ':')
> >             *option = opt + 1;
> >         else
> >             return 0;
> >         return 1;
> >     }
> >
> > which is more compact and closer to what I suggested earlier for
> > avoiding the helper function in the first place. But, of course,
> > programming is quite subjective, and you may find your implementation
> > easier to reason about. Plus, your version has the benefit of being
> > slightly more optimal since it avoids an extra string scan, although
> > that probably is mostly immaterial considering that
> > contents_atom_parser() itself contains a long chain of potentially
> > sub-optimal strcmp() and skip_prefix() calls.
>
> "programming is quite subjective"
> Yeah, I couldn't agree more.
>
> The change you suggested looks good too. But I'm little inclined to my
> keeping my changes. I'm curious, what others have to say on this.

I also prefer a slightly more optimal one even if it's a bit less compact.

Thanks,
Christian.
