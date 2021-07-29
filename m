Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280CC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193E2608FB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhG2UqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhG2UqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:46:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71792C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 13:46:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n16so3555835oij.2
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qf59NjsoflJ7X1t0eclZNe7I04B1ec71/twEcTIYbAs=;
        b=FJ1+6SdGfRyZSIE3EFkiKcWN3TEFsSlw6xCqcHvU8WYu/RqMs10Ia2tY+Guk19uPvR
         aEWluPh8fQHL8i/xtQW81Li0llu4X2sfy0sokIXwG/qQnM/XsqDoOtaLOGijbUzgP6+j
         ohk44f6njFUUqXADUUkhSsTZwpu75/bQDPJ15+hLUFm+U7xaU+Gh59oaqrZeqcQxqsPn
         cBBpTFnOvqyi+wFp8TdVZeM06QzO7WbRj6xhMdYyod1ENe5zki0InrlCJ1slRs+rbM4v
         8XcEdStM4fLhlP9r9vlWnNpC9D7DcSdH0Pr4WkPBUXiPrlOxE7AKlhZ1llWxmYj5htp5
         Tglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qf59NjsoflJ7X1t0eclZNe7I04B1ec71/twEcTIYbAs=;
        b=H9p22QKkY/3m+1b96w3a3QqphwFjFtTDcLHlETFvIRtorD/EABCJR+ku+C4m8h7jgn
         tLcuKk1M0vsinzeI0+Hgfvfz6kGB5DNa7BjwTqW5FzAVXlCwDkbOMPisbdeTMpCvmH8C
         BGBtIqRWg3wOvJyfYBVZGc0lr0e6dThD+JVFYoWsIq8u6l/ieY+bcxu5XILR0P1SQf6B
         HY9GU8wfGYvFm8qZC10GMzmiQJcmiIbZek0JmmrpCp0sAhX8o36ngOdKPC7fp03w2GXL
         Mqs3HjvYJqnZK7xuSVTr5m1Nhr1yp08c+uJDOoxlBskIlAOwsbWlT161c1EqVAyTTmGa
         qS/g==
X-Gm-Message-State: AOAM530Vjq/o9JFEcxGQut+TQYx2Mu56EKMsUf7h2LQR/qtoOHEld7Pg
        OHDJg0/DJIdmNK227Zaz//wP9EPkcoTm09+by+g=
X-Google-Smtp-Source: ABdhPJxTiew7nbf0pANLW52y850xdy7dxJoltmUWgxeI1XrShl7CMANgm5jRRBWE3O5Rbpl8MsOEcH9nOYMgpqICzVs=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr11125530oie.167.1627591574802;
 Thu, 29 Jul 2021 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com> <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
In-Reply-To: <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 14:46:03 -0600
Message-ID: <CABPp-BH2PQ_rHDPNBghdkhO=kaNfQBnU28UFh9c-sPBNUOM4gA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 10:20 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 29, 2021 at 03:58:34AM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > This series is more about strmaps & memory pools than merge logic. CC'i=
ng
> > Peff since he reviewed the strmap work[1], and that work included a num=
ber
> > of decisions that specifically had this series in mind.
>
> I haven't been following the other optimization threads very closely,
> but I'll try to give my general impressions.
>
> > =3D=3D=3D Basic Optimization idea =3D=3D=3D
> >
> > In this series, I make use of memory pools to get faster allocations an=
d
> > deallocations for many data structures that tend to all be deallocated =
at
> > the same time anyway.
> >
> > =3D=3D=3D Results =3D=3D=3D
> >
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28), =
the
> > changes in just this series improves the performance as follows:
> >
> >                      Before Series           After Series
> > no-renames:      204.2  ms =C2=B1  3.0  ms    198.3 ms =C2=B1  2.9 ms
> > mega-renames:      1.076 s =C2=B1  0.015 s    661.8 ms =C2=B1  5.9 ms
> > just-one-mega:   364.1  ms =C2=B1  7.0  ms    264.6 ms =C2=B1  2.5 ms
>
> Pretty good results for the mega-renames case. I do wonder how much this
> matters in practice. That case is intentionally stressing the system,
> though I guess it's not too far-fetched (it's mostly a big directory
> rename). However, just "git checkout" across the rename already takes
> more than a second. So on the one hand, 400ms isn't nothing. On the
> other, I doubt anybody is likely to notice in the grand scheme of
> things.

The mega-renames case was spurred by looking at a repository at
$DAYJOB and trying to generate a similar testcase on a well-known open
source repository with approximately the same number of files.  The
linux kernel was handy for that.  Technically, to make it match the
right number of renames, I would have needed to rename more toplevel
directories, but it was close enough and I liked it being a simple
testcase.  So, to me, the testcase is more unusual in the number of
patches being rebased rather than in the number of renames, but I
chose a long sequence of patches (with lots of different types of
changes) because that served as a good correctness case and even ended
up being good for spurring searches for tweaks to existing
optimizations.  And I added the just-one-mega to see how a simple
cherry-pick would work with the large number of renames.  It too has a
good relative speedup.

You make fair points about the absolute timings for rebase, but the
"grand scheme of things" involves usecases outside of traditional
rebases.  Some of those involve far more merges, making the relative
timings more important.  They also involve much less overhead -- not
only do they get to ignore the "git checkout" present in most rebases,
but they also get to exclude the index or worktree updating that are
present above.  Without that extra overhead, the relative improvement
from this patch is even greater. One particular example usecase that
is coming soon is the introduction of `git log --remerge-diff`; it
makes the timing of individual merges critical since it does so many
of them.  And it becomes even more important for users who change the
default from --diff-merges=3Doff to --diff-merges=3Dremerge-diff, because
then any `git log -p` will potentially remerge hundreds or thousands
of merge commits.  (I've got lots of users who have -p imply
--remerge-diff since last November.)

> And we're paying a non-trivial cost in code complexity to do it (though
> I do think you've done an admirable job of making that cost as low as
> possible). Dropping the USE_MEMORY_POOL flag and just always using a
> pool would make a lot of that complexity go away. I understand how it
> makes leak hunting harder, but I think simpler code would probably be
> worth the tradeoff (and in a sense, there _aren't_ leaks in an
> always-pool world; we're holding on to all of the memory through the
> whole operation).

Yeah, I had to keep the USE_MEMORY_POOL flag as I was rebasing my
sequence of optimization series to make sure I kept the intermediate
steps clean while upstreaming all the work.  I ended up just leaving
(a simplified form of) it in when I was all done, but it has probably
already served its purpose.  I'd be fine with dropping it.

> I assume your tests are just done using the regular glibc allocator. I

Yes.

> also wondered how plugging in a better allocator might fare. Here are
> timings I did of your mega-renames case with three binaries: one built
> with USE_MEMORY_POOL set to 0, one with it set to 1, and one with it set
> to 0 but adding "-ltcmalloc" to EXTLIBS via config.mak.
>
>   $ hyperfine \
>       -p 'git checkout hwmon-updates &&
>           git reset --hard fd8bdb23b91876ac1e624337bb88dc1dcc21d67e &&
>           git checkout 5.4-renames^0' \
>       -L version nopool,pool,tcmalloc \
>       './test-tool.{version} fast-rebase --onto HEAD base hwmon-updates'

Ooh, I didn't know about -L.

>   Benchmark #1: ./test-tool.nopool fast-rebase --onto HEAD base hwmon-upd=
ates
>     Time (mean =C2=B1 =CF=83):     921.1 ms =C2=B1 146.0 ms    [User: 843=
.0 ms, System: 77.5 ms]
>     Range (min =E2=80=A6 max):   660.9 ms =E2=80=A6 1112.2 ms    10 runs
>
>   Benchmark #2: ./test-tool.pool fast-rebase --onto HEAD base hwmon-updat=
es
>     Time (mean =C2=B1 =CF=83):     635.4 ms =C2=B1 125.5 ms    [User: 563=
.7 ms, System: 71.3 ms]
>     Range (min =E2=80=A6 max):   496.8 ms =E2=80=A6 856.7 ms    10 runs
>
>   Benchmark #3: ./test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-u=
pdates
>     Time (mean =C2=B1 =CF=83):     727.3 ms =C2=B1 139.9 ms    [User: 654=
.1 ms, System: 72.9 ms]
>     Range (min =E2=80=A6 max):   476.3 ms =E2=80=A6 900.5 ms    10 runs

That's some _really_ wide variance on your runs, making me wonder if
you are running other things on your (I presume) laptop that are
potentially muddying the numbers.  Would the tcmalloc case actually
have the fastest run in general, or was it just lucky to hit a "quiet"
moment on the laptop?

Or perhaps my pre-warming script helps reduce variance more than I thought.=
..

>   Summary
>     './test-tool.pool fast-rebase --onto HEAD base hwmon-updates' ran
>       1.14 =C2=B1 0.32 times faster than './test-tool.tcmalloc fast-rebas=
e --onto HEAD base hwmon-updates'
>       1.45 =C2=B1 0.37 times faster than './test-tool.nopool fast-rebase =
--onto HEAD base hwmon-updates'
>
> The pool allocator does come out ahead when comparing means, but the
> improvement is within the noise (and the fastest run was actually with
> tcmalloc).
>
> I was also curious about peak heap usage. According to massif, the pool
> version peaks at ~800k extra (out of 82MB), which is negligible. Plus it
> has fewer overall allocations, so it seems to actually save 4-5MB in
> malloc overhead (though I would imagine that varies between allocators;
> I'm just going from massif numbers here).

I did similar testing a year ago, before I even looked at memory
pools.  I was surprised by how big a speedup I saw, and considered
asking on the list if we could push to use a different allocator by
default.  Ultimately, I figured that probably wouldn't fly and
distributors might override our choices anyway.  It was at that point
that I decided to start tweaking mem-pool.[ch] (which ended up getting
merged at edab8a8d07 ("Merge branch 'en/mem-pool'", 2020-08-27)), and
then integrating that into strmap/strset/strintmap -- all in an effort
to guarantee that we realized the speedups that I knew were possible
due to my testing with the special allocators.

> So...I dunno. It's hard to assess the real-world impact of the speedup,
> compared to the complexity cost. Ultimately, this is changing code that
> you wrote and will probably maintain. So I'd leave the final decision
> for that tradeoff to you. I'm just injecting some thoughts and numbers. :=
)

It's nice to see others duplicate the results, and I appreciate the
sanity check on overall usefulness.  If it were just optimizing
rebase, I probably could have quit long ago when I had 15s rebases of
35 patches.  It was part stubbornness on my part wondering why it
couldn't be sub-second, and part knowing of other usecases that I
wanted to make attractive to others.  I want --remerge-diff to be
useful *and* practical.  I want rebasing/cherry-picking un-checked-out
branches to be useful and practical.  And I'd like to entice server
operators (GitHub, GitLab, etc.) to use the same merge machinery used
by end users so that reported merge-ability matches what end users see
when they try it themselves.

I think you make a good suggestion to drop the USE_MEMORY_POOL switch.
I think I'll do it as an additional patch at the end of the series,
just so it's easy for me to restore if by change it's ever needed.
