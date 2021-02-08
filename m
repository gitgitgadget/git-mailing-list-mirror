Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6008C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9892D64E88
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBHImH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhBHIjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 03:39:23 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AEC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 00:38:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q4so3797142otm.9
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 00:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGPG84tBEEGuS+RkGT9ugEIBAubYJSnPrTrFImNf354=;
        b=t+sm2tlYCGclKgFxLjH4H0kUfVVoRtNT2FIVJ7pi4oNHarly8k53ScpJ9pRvyufS9+
         ovEMbXA0akfh6olhbU7LE37Sorvd9WkBaetgllm5MnigZFCzUe8qJ+Qx+kHsf5X1clK/
         3AzUN8DjwGJ+py/IT/YOF6L5MugX1kWCO5JuH4HyBX3nLrNb6cbE+qf4KP9gP1wLzgg8
         I94kRgKfz+a2jmP+Q/biEV6nlkUqlM4K64uBpdaETngKort2dqsstnE1OnoPhRkSXkFu
         eBDaaMeipzgSMoS+Lq+zDAU836AUNyFRbpT1koN1DfKBFzEvghvWMmYnZRjzUA5AVDH7
         8IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGPG84tBEEGuS+RkGT9ugEIBAubYJSnPrTrFImNf354=;
        b=naVTwmTnglYi4B1pTqIzjcL1JYyZudwd5HWh1BsX8SZ/zUbnkR4CBhoQ++Iu9hqhi9
         G/YdLwr59weYAGtX8JGkGPsZeUHfo8vH1AuuJ0ckUDFb7eA3Ad60eRTVGgikMKQvzUV6
         0l6RFma8h7/5alQ9aGYT626uptUnAlzbfTiJCbfJ0uAbJzCvv8eLCqP7P7657X2pLiJL
         0lV8E/tbl/Zld4Xz5OfBaFTnqTymWsIKjNN3gP80l+GNzSU4Py3VtRD1rYzVn54C1A3v
         EjI7le394N4nidopdJpX0t5rii+27rdKJ5MPeT9NeI1Iva4Y42w1rsyLiT236MDGbUPZ
         BNOA==
X-Gm-Message-State: AOAM530dkZaQ4hE2qtob19LQkqBI+zMSXVnJCfeT00s3fzwGK+F+6fkj
        MCjfVjmKuX7sMqp2V28g64BMkF2LaQCpK6SWI34=
X-Google-Smtp-Source: ABdhPJwttl9x6ZhN+nNx4eLBAlCGCnTS/8cxHHLi2SRTi2sXrR6rMeiBPbawCnUiNaPnX5SUOrUecj9pGqKP+twTC9w=
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr9687462otr.316.1612773522976;
 Mon, 08 Feb 2021 00:38:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com> <xmqqsg677j2u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg677j2u.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 00:38:00 -0800
Message-ID: <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 11:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > Before I get too deep into reviewing these patches, I do want
> > to make it clear that the speed-up is coming at the cost of
> > a behavior change. We are restricting the "best match" search
> > to be first among files with common base name (although maybe
> > I would use 'suffix'?). If we search for a rename among all
> > additions and deletions ending the ".txt" we might find a
> > similarity match that is 60% and declare that a rename, even
> > if there is a ".txt" -> ".md" pair that has a 70% match.
>
> Yes, my initial reaction to the idea was that "yuck, our rename
> detection lost its purity".  diffcore-rename strived to base its
> decision purely on content similarity, primarily because it is one
> of the oldest part of Git where the guiding principle has always
> been that the content is the king.  I think my aversion to the "all
> of my neighbors are relocating, so should I move to the same place"
> (aka "directory rename") comes from a similar place, but in a sense
> this was worse.
>
> At least, until I got over the initial bump.  I do not think the
> suffix match is necessarily a bad idea, but it adds more "magically
> doing a wrong thing" failure modes (e.g. the ".txt" to ".md" example
> would probably have more variants that impact the real life
> projects; ".C" vs ".cc" vs ".cxx" vs ".cpp" immediately comes to
> mind), and a tool that silently does a wrong thing because it uses
> more magic would be a tool that is hard to explain why it did the
> wrong thing when it does.

Stolee explained a new algorithm different than what I have proposed,
I think based on the apparent different meanings of "basename" that
exist.  I tried to clarify that in response to his email, but I wanted
to clarify one additional thing here too:

diffcore-rename has not in the past based its decision solely on
content similarity.  It only does that when break detection is on.
Otherwise, 0% content similarity is trumped by sufficient filename
similarity (namely, with a filename similarity of 100%).  If the
filename similarity wasn't sufficiently high (anything less than an
exact match), then it completely ignored filename similarity and
looked only at content similarity.  It thus jumped from one extreme to
another.

My optimization is adding an in-between state.  When the basename (the
part of the path excluding the leading directory) matches the basename
of another file (and those basenames are unique on each side), then
compare content similarity and mark the files as a rename if the two
are sufficiently similar.  It is thus a position that considers both
filename similarity (basename match) and content similarity together.

> > This could be documented in a test case, to demonstrate that
> > we are making this choice explicitly.
>
> Yes.  I wonder if we can solve it by requiring a lot better than
> minimum match when trying the "suffix match" first, or something?

This may still be a useful idea, and was something I had considered,
but more in the context of more generic filename similarity
comparisons.  We could still discuss it even when basenames match, but
basenames matching seems strong enough to me that I wasn't sure extra
configuration knobs were warranted.

> Provided if we agree that it is a good idea to insert this between
> "exact contents match" and "full matrix", I have one question to
> Elijah on what the code does.
>
> To me, it seems that the "full matrix" part still uses the remaining
> src and dst candidates fully.  But if "A.txt" and "B.txt" are still
> surviving in the src/dst at that stage, shouldn't we be saying that
> "no way these can be similar enough---we've checked in the middle
> stage where only the ones with the same suffix are considered and
> this pair didn't turn into a rename"?

This is a very good point.  A.txt and B.txt will not have been
compared previously since their basenames do not match, but the basic
idea is still possible.  For example, A.txt could have been compared
to source/some-module/A.txt.  And I don't do anything in the final
"full matrix" stage to avoid re-comparing those two files again.
However, it is worth noting that A.txt will have been compared to at
most one other file, not N files.  And thus while we are wasting some
re-comparisons, it is at most O(N) duplicated comparisons, not O(N^2).
I thought about that, but decided to not bother, based on the
following thinking:

1) The most expensive comparison is the first one, because when we do
that one, we first have to populate the list of integers that lines in
the file hash to.  Subsequent comparisons are relatively cheap since
this list of integers has already been computed.

2) This would only save us from at most N comparisons in the N x M
matrix (since no file in this optimization is compared to more than
one other)

3) Checking if two files have previously been compared requires more
code, in what is already a tight nested loop.  My experience
attempting to modify that tight loop for extra conditions (e.g. don't
compare files that are too large), is that it's easy to accidentally
make the code slower.  In fact, this is in part what led to the
addition of the remove_unneed_paths_from_src() function.

4) There were plenty of other interesting ideas and maybe I was a tad lazy.  :-)

I think removing these already-compared cases could be done, but I
just avoided it.  If we were to do the "attempt to match files with
the same extension" optimization that Stolee outlines/invents above,
then we'd definitely need to consider it.  Otherwise, it's just a
minor additional optimization that someone could add to my patches.
