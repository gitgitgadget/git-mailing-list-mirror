Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86567C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484EE23977
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbhANUTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhANUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:19:10 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F571C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 12:18:30 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 9so7272733oiq.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zA5gAjhFOqNeB9gQo2MVZbGIB2yc2D3wxlQ62SlFay4=;
        b=qc5r9TPc7IUN0G2SXlGRD0iCLEw2EfJ1xya/OCTPM4JhLrMIAPsO33JMAOm+cHVFex
         gGX3wSzGEfNWOnYWfw6eryWtMnCVXC+kDgQjH08nnMpO1QDAUoOsXKd0J0Qv1d63cOxu
         urQ1Q16qIu2hFdr1sJGFHmvZgZjxQtft6aaBNTIQP2Vg8eAYIPEXK/nexnKXgCGqGfGR
         bOt89g5gxce0RWnd8naL7YuulAKf7oU5QDGJmWhvx8Z/CtU9yatcX87gEzeQl7xPPDLW
         kcdiwY5Qpbu5QZOP0AQBIF8z1+kNH6WiO+kBXI1hC4AnrPyNniMCV2XXp4zM6RFjegmX
         vShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zA5gAjhFOqNeB9gQo2MVZbGIB2yc2D3wxlQ62SlFay4=;
        b=d1erxP+dQ3X0U3tny5hVv193u7GwerSNLuoTToS5H3M6sw2+G1ZsMFJ9Dgs2JTj0c5
         2R6Fp4lZjTVdXOed2YJvMiUqf4XXencGBVC4oDk4IYq0XmR2zCqJWQoIcnclvmL5f4ww
         uZYj5WCs7rbj6WyduOka9hmn0vxY6NygctN4H+Q8YgFm83YPpwG4rDijNSAG5KbGzpWc
         PCsAEYEESZX4TvnE/Uc/d5+DqBL77PYzyR4Ej4BESFhrNjB1gmPL82BTy4A312oURJDa
         r5g+i7hQ0laB9fvFI6mGJUGIznqv1as61efTtTg0DMJew4duwtEQqQyy9YlBhYQabjMQ
         CoFw==
X-Gm-Message-State: AOAM531vyeS5tJy9TCJIbKIP0xs1jabWwma2G8wVBixQe0OXBv2+6KJf
        EheXGPA/tGYalZyz1McYtCauN/NYraBH5t62xhI=
X-Google-Smtp-Source: ABdhPJxxu/8s5VK5Hivee+zqUs62VQ6E2qK43JN4KQF7NFOBAbsHKYq1sF8DVJZftcf94bNlte2L5kqHHu3/onI0itg=
X-Received: by 2002:a54:4185:: with SMTP id 5mr3635965oiy.31.1610655509464;
 Thu, 14 Jan 2021 12:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20210108205111.2197944-1-newren@gmail.com> <20210113221158.2869128-1-newren@gmail.com>
 <xmqqo8hrxrnh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8hrxrnh.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Jan 2021 12:18:17 -0800
Message-ID: <CABPp-BHhXXAX7QJeD6jGckozL9DHf5UZ=UXzaogyv-F4_xdYVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] And so it begins...merge/rename performance work
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Jan 14, 2021 at 11:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
> > and en/ort-directory-rename.
>
> Thanks.
>
> How ready is the foundation to accept this change?  This will depend
> on all of the above three topics and I am not sure what the status
> of them is---I think that I've read through the diffcore-rename one
> and it was a pleasant read, but I do not recall the reviewer
> reactions to the other two.

Good questions.  Let me go through the three in order:

en/ort-conflict-handling: Has already been reviewed; v2 included the
fixes to the issues Stolee noted in v1 and Stolee was happy with v2
(https://lore.kernel.org/git/5f6d5428-36ce-3e91-4916-8968ac1b8686@gmail.com/)
as of a week and a half ago.  I am unaware of any issues; I think it's
ready as-is to merge down to next and then to master.

en/diffcore-rename: Taylor and you both reviewed it; Christian skimmed
over it and noted a typo.  I fixed up the issues all three of you
noted by v3 at the end of December.  I was assuming based on your
comments (at https://lore.kernel.org/git/xmqqwnwnglim.fsf@gitster.c.googlers.com/)
that you are happy with it now, which seems to be supported by the
fact that you've already merged it to next.  I think it's ready to
continue merging on to master.

en/ort-directory-rename: This one is the only question mark in my
mind.  Most of the ort patches I wanted folks to review because I'm
doing things significantly differently than merge-recursive.c does.
This series is an exception; patches 1-16 are just porting over the
exact same algorithm from merge-recursive.c using the new data
structures.  It's a lot of code, because directory rename detection
has a lot of logic to it, but there's not anything new or tricky to it
in relation to what's in merge-recursive.c.  However, even though the
algorithm is essentially just being copied, the differences in data
structures means there are lots of tiny changes all over that make a
direct comparison difficult (unless folks are familiar with the old
logic, but I think only Stefan Beller and I were).  Honestly, I'm not
so sure this series is worth reviewers' time given all those details,
with the exception of patch 17/17.  If folks can review everything,
that's great, but if we have limited review resources, I'd rather
people review the series before this one, and the performance related
ones I'll be posting later.  The testcases are pretty thorough in this
area, in part thanks to additional suggestions from Stefan a few years
back, and the similarity of the logic makes me less concerned about
this topic than any of the others in the merge-ort and diffcore-rename
work that I have and will be doing.


In summary:
  * en/ort-conflict-handling and en/diffcore-rename are ready to merge
down (and you already started on one of them)
  * I'm not sure if anyone will review en/ort-directory-rename (it's
been a week and a half with no review so far), but I'm tempted to
encourage people to save their review effort for other topics.
There's just not much different here than what's found in
merge-recursive.c.  (With the exception of patch 17...)

> It does not instill a lot of confidence in these topics that nobody
> commented on things like [v2 17/17] of en/ort-directory-rename
> (which fixes the code introduced in [v2 06/17] instead of fixing it
> at the source before 06/17 copies it from elsewhere [*1*]).  It
> looks to me like a sign that these collection of series are moving
> too fast than any reviewer to catch up.

I considered just moving 17/17 earlier, and even started that way, but
there are a couple problems with that:

1) The comparison of directory rename detection code between
merge-recursive.c and merge-ort.c, if folks want to compare the two,
is much easier if I first implement the same algorithm

2) 06/17 introduces the concept of counting renames from a directory
and picking the highest count; the idea is simple but but with the
extra complications from 17/17 the combined patch just looks too
obtuse to follow done all in one step.  Splitting 17/17 into a
separate later step was something that I felt would make it easier to
review.

3) 06/17 consists of well-understood code from merge-recursive.c.
17/17 is new.  If we ever want to port the fix from merge-ort to
merge-recursive, having it as a separate change will help with that.


So, although it may look weird, I intentionally changed from a
combined early commit, as you seem to be suggesting here, into
splitting it out this way.  I also considered removing 17/17 from the
series and then submitting it later.

> Thanks.
>
>
> [Footnote]
>
> *1* I do not particularly think [06/17] that copies and leaves the
>     recursive backend behind is necessarily bad.  What I find more
>     disturbing is that nobody seems to have a chance to give any
>     look to the two iterations of the series (as far as I can see,
>     v2 is just in name only---it removed 18/17 in v1 that were not
>     meant to be sent), and we are about to build on top of the
>     foundation that nobody knows how solid it is.

What if we dropped 17/17 from en/ort-directory-rename (the
merge/rename performance work doesn't depend upon it), and then merged
that series down?  Without 17/17, the series is just a port of code
that exists in merge-recursive.c that has been battle tested for
years.  I could submit the final patch separately later.
