Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFDC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 05:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB0A6101D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 05:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhDUFwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhDUFwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 01:52:30 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973DC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 22:51:56 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c15so34037177ilj.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r7bRnE5Igd5njw0BEwIQV+mEGlzCsGWZx9gPQ50MVqM=;
        b=O4l7M0kz7CacGCsTZBu723ZcchUHEtgcqUegJIsz1fbjkcVW6jTKPhUBA43ZiCqTxC
         TV9TJovgxiC5l+uDBFc6/JtXelXUTFZRKJYiPbFjkuRhnEwRK2ssH+n5US9D6nz3ZMLR
         PDZG5QJzHXpVEI4fdC2z10PHyDnSSFZJpJIg/XTJvs93dFe0PdavYQey4NauZQL5hXsd
         Ep4lrahx77TmzxxfGq78PdOBSd6NB7/maGN0c0zYYOnwGIvRKQhUOUlpORIi+Gc/TN8u
         6YxjfRJEWUDbN7gwLE3cLgEj4gytbxwMfrBAHgj/TEM9ycAB+S7X/PuZp6JeAnIAoXQI
         x1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r7bRnE5Igd5njw0BEwIQV+mEGlzCsGWZx9gPQ50MVqM=;
        b=oQOf6HtI6BI3Q0Fuzh3qNO7GPesH3iyYu52MN16JKyOLZtofk4cLjrUpY3QaiYFAuk
         omaH6rw3vMzSvqk6+0AjkY7bbJ9qpnyTmH37K6MlLzG5O84MuZmLu7ZUhzVq7wLsJbXZ
         /Wo+ZFBwXB2Rmocqkmrlk4KWRomcoM08m6fqZnfacPjBXrtipC1WRMKi+tjq3GzQWrGG
         gN1UduR0dwzRZjzORaK1LpNnOoiba0jtiLI5vwuFPsuJjhPcLrheyJgKkI2P1065Kntc
         XMrJjh2RjHinEJ5QfvKVdyLUJZVjGy+WK954/aBWgK6wkX8Lc2snZDggO/oONOdMcD2U
         m1IA==
X-Gm-Message-State: AOAM531TggPpID/9wm6n9sPT03QzTQ/jOENR3tWJZx1E/gsEXq2S+ETq
        MrytIYOb+NISf+otDXpat0zWyFevJuT5ZeDZ3YRuzLngY8tFJbJXaBU=
X-Google-Smtp-Source: ABdhPJz3U5d2AhUAFVBk72tB4YalCBxVqQCvzIoxHvFOaGbSE5LHqvqHjHqT+IjzJ+yvMvzWh91pZZ1hbj9B/GnRPpI=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr23509428ilr.259.1618984315821;
 Tue, 20 Apr 2021 22:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
 <4c4eded7-3bb3-7ae9-6455-468b9522978c@web.de> <xmqqeef47s5k.fsf@gitster.g>
In-Reply-To: <xmqqeef47s5k.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Apr 2021 13:51:44 +0800
Message-ID: <CAOLTT8TQfFjgcwQrf88SgMOYubwy1TsX7qgN2TbLZp=daTZ2Bg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: get rid of show_ref_array_item
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?UmVuw6kgU2NoYXJmZS4=?= <l.s.r@web.de>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
> >> @@ -452,10 +453,9 @@ static void print_ref_list(struct ref_filter *fil=
ter, struct ref_sorting *sortin
> >>                      fwrite(out.buf, 1, out.len, stdout);
> >>                      putchar('\n');
> >>              }
> >> -            strbuf_release(&err);
> >> -            strbuf_release(&out);
> >>      }
> >>
> >> +    strbuf_release(&out);
> >
> > err is no longer released, and it is also not reset in the loop.
> > That change is not mentioned in the commit message, but it should.
> > Why is it safe?  Probably because format_ref_array_item() only
> > populates it if it also returns non-zero and then we end up dying
> > anyway.
> >
> > That makes leak checking harder, though -- it's not easy to see if
> > err hasn't simply been forgotten to be released.  I'd just retain
> > the strbuf_release() call at the end of the function -- it
> > shouldn't have a measurable performance impact and documents that
> > this function is cleaning up after itself.  Thoughts?
>
> I should have responded to this comment before it was too late,
> sorry.
>
> I am OK with documenting the assumption that we will die when err
> gets populated without coming out of the loop and not releasing at
> the end (because we would not have anything to release when we got
> there).  I am also OK with resetting(err) in the loop (which will
> be a no-op as err.len would always be 0 at that point, or we would
> have died) and releasing(err) at the end.  I found it a bit funny
> to be not resetting in the loop and releasing at the end, without
> a comment that explains the thought behind it.
>

So a better solution is "without err buffer _reset() and _release()" and ex=
plain
the reason for "not needing to be cleaned up" in the commit message?

Thanks.
--
ZheNing Hu
