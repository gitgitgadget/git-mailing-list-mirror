Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02990611AD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhGLU0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhGLU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:26:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDDC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:23:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so20182653otp.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1yhJquqwxb3mf2MAKERPATK+5/wB596C2+6qxHHaTE=;
        b=KXQheejjRTvhaT+gd92nVOmvlm9my8v+jwkZtJo3YUz9UT5YB7gXsVrLx7nn2B3ui/
         HstuOnw4/hZLUimvhUwFDWYTEql2B36iKGKJH5VJNIYzr1jxVayjGrwJy4Nixnh7NOEV
         kkGLOdXETC7e5XXLTyHkYnB+cQI0paT+6xrZpLLSLeJiMrm63MGgdkLU10nZSnVukPGx
         ixY03B8gmWwV0xqaV9AFcg7DidQwc2yF6KPDmmxo7CeFTWEj8fgX6MSvohr4LDP+yf8Z
         hvFwWpvY4uDFuEUMUrjaWvlfFkW9TdaKIO8IhZcGiUg4U4XAL6aQyAAp4+RXEAvsxyl2
         n2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1yhJquqwxb3mf2MAKERPATK+5/wB596C2+6qxHHaTE=;
        b=RicEc/Ws1xuctcdktox58UIOGEY7xmXJ81N6ool7fMYWANzekigsMrU9Ccf/0q3ywQ
         gvQfSJAy3LnFOosj1in/ZErtLYoQ69OnAGR1KuHO2OMQMMmVCEzJjlaVJhXJz07I+pPv
         O7jVfukEyVXw4ICC3lfeFQdLn+XkXISuH2AJwTBAocy+WdWhwqReXIT4Br20dyFAPvys
         l6pC8ZDYAjv/rQmtJpfbKrhA8fhciEwT9N6BAXypfUYH7Gt9zNYTaAQaSg5g1N0DyewL
         GfbYYYOJwRURLqS54LELoSKYK/GvN9U3FPxkO3YaMucS0IHLlaiUG5q8xfOVI34Mp2DM
         Qd0A==
X-Gm-Message-State: AOAM533KmbNjYL1wmU1Mvrc4eA37uoBWS3+BfT3OWzAWfst0pu2jrML1
        9dfd3PWWgBkpfvJ+6uH6ojXCgvCAkqpWDitPR7I=
X-Google-Smtp-Source: ABdhPJx5kJnNQSgY8RIEfXf0U00FnXZAXGTFo2h5TEYT6YJJS54pvxoliPskN9lCuyag9BIG0BKpdNzD9S92HZICAzc=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr603334otp.316.1626121429320;
 Mon, 12 Jul 2021 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <YOx43fqGyQMy7+tR@coredump.intra.peff.net>
In-Reply-To: <YOx43fqGyQMy7+tR@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 13:23:38 -0700
Message-ID: <CABPp-BEdUmxXVCx=5pb0=LN-0YBtrEB-wngPC5vys6fjVctgaQ@mail.gmail.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 10:16 AM Jeff King <peff@peff.net> wrote:
>
> tl;dr Bumping the limit seems like a good idea to me.

:-)

> On Sat, Jul 10, 2021 at 05:28:43PM -0700, Elijah Newren wrote:
>
> > * My colleagues happily raised merge.renameLimit beyond 32767 when the
> >   artificial cap was removed.  10 minute waits were annoying, but much
> >   less so than having to manually cherry-pick commits (especially given
> >   the risk of getting it wrong).[13]
>
> One tricky thing here is that waiting 10 minutes may be worth it _if the
> rename detection finds something_. If it doesn't, then it's just
> annoying.
>
> I do think progress meters help a bit there, because then at least the
> user understands what's going on. I'll go into more detail in the
> sub-thread there. :)

Another thing that helps here (at least for merges rather than diffs)
is that we can determine a priori whether individual renames will have
no effect on the merge result and just exclude those particular
renames from the detection machinery.  Well, at least we can do this
with the new merge-ort backend.  That should dramatically reduce the
annoyance factor once we make it the default.

...
> Yeah, it is definitely time to revisit the default numbers. I think at
> one point we talked about letting it run for N wallclock seconds before
> giving up, but we've been hesitant to introduce that kind of time-based
> limit, because it ends up with non-deterministic results (plus you don't
> realize you're not going to finish until you've already wasted a bunch
> of time, whereas the static limits can avoid even beginning the work).

Yeah, I'm kinda glad we didn't go that route; seems problematic to me.

...
> I don't remember my methodology at this point, but perhaps it was based
> on blobs in the graph, not just one tree, like:
>
>   $ git rev-list --objects v2.6.25 |
>     git cat-file --batch-check='%(objecttype) %(objectsize) %(rest)' |
>     awk '
>       /^blob/ { sum += $2; total += 1 }
>       END { print sum / total }
>     '
>   27535.8
>
> I suspect the difference versus a single tree is that there is a
> quadratic-ish property going on with file size: the bigger the file, the
> more likely it is to be touched (so total storage is closer to bytes^2).

Ah, gotcha.  That makes sense.

> Looking at single-tree blob sizes is probably better though, as rename
> detection will happen between two single trees.

Agreed.

> > * I think the median file size is a better predictor of rename
> >   performance than mean file size, and median file size is ~2.5x smaller
> >   than the mean[18].
>
> There you might get hit with the quadratic-update thing again, though.
> The big files are more likely to be touched, so could be weighted more
> (though are they more likely to have been added/delete/renamed? Who
> knows).

I'll agree that big files are more likely to be updated, but I don't
think renames are weighted towards bigger files.  In fact, I wrote a
quick script to look at the sizes of all the renamed files in the
history of v2.6.25, and the mean (8034.1) and median (3866) of the
renamed files sizes in that history are comparable to the mean
(11150.3) and median (4198) of the files sizes in the v2.6.25 tree.

I re-did the calculations using v5.5, and found that the mean
(12495.1) and median (3702) sizes of renames in all linux history up
to that point again were a bit less than the mean (13449.2) and median
(3860) file size of a file in the final v5.5 tree.

Granted, this is a bit hand-wavy (what about creations or deletions?
Is there too much bias from the fact that I did rename sizes over all
history (due to needing enough to get statistics) while just grabbing
regular file sizes just in the end tree?), but I think it provides
pretty good first order approximation suggesting that mean/median
sizes of files involved in rename detection will be similar to the
mean/median sizes of other files within the relevant trees.

> I don't think file size matters all _that_ much, though, as it has a
> linear relationship to time spent. Whereas the number of entries is
> quadratic. And of course the whole experiment is ball-parking in the
> first place. We're looking for order-of-magnitude approximations, I'd
> think.

I agree that the number of entries is what's important; in fact,
that's why I think the median file size is more important than the
mean file size:

In the case of the linux kernel, since the mean is 2.5x bigger than
the median file size...
  => diffcore-rename checks file sizes before comparing content
  => Files more than 2x different in size can't be more than 50% similar
  => Therefore, files of the mean size will not be compared to files
of the median size (or less)
  => Therefore, we automatically know that files of mean size will not
be compared to more than half the files.

> > * The feedback about the limit is better today than when we last changed
> >   the limits, and folks can configure a higher limit relatively easily.
> >   Many already have.
>
> I can't remember the last time I saw the limit kick in in practice, but
> then I don't generally work with super-large repos (and my workflows
> typically do not encourage merging across big segments of history).
> Nor do I remember the topic coming up on the list after the last bump.
> So maybe that means that people are happily bumping the limits
> themselves via config.

It might also mean that you're missing more emails than you used to,
or just forgot them.  :-)

e.g.:
https://lore.kernel.org/git/20171129201154.192379-1-jonathantanmy@google.com/
https://lore.kernel.org/git/20171113201600.24878-1-newren@gmail.com/

But I do certainly suspect it's come up less often than it would have before.

> But I don't think that's really an argument against at least a moderate
> bump. If it helps even a few people avoid having to learn about the
> config, that's time saved. And it's a trivial code change on our end.

:-)
