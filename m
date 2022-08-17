Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED68C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 19:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiHQTGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbiHQTGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 15:06:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A575B069
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:06:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h21so11116171qta.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9jKwQeXOOJYEqG9EiZiAbGqeSN91isqTOIWlWyJiGcg=;
        b=KuYkKe2WOm8TxGIl3jqmrXBg33Ngcc3X7Av2ghjD7d8mbYhYYmCvRqY3MnvqE7kAof
         /XvhFJ1+f3Ak3JtRd+L/DS7zAGEZaeSRoDycpjFmVY5S4Pb/lW9JtcyDXrFcEW/b6zDo
         ap4Cs7CWa2QonVPtxWBwWJlaf05NJtYUgK2TdsWuFfyq3feXa66v+9OXeTTDYqgp3OuT
         Ymsy0dbyW6u1nfvQuvfLB/USEGOIrh+QCRtCrJvLpBbzwCm/bJZLqpXzxmagfEk5vc/Q
         hlU6h9nLDd5v2orCOgYCOLg9tgWhXeND4oO1w7QcbALCvwCJ0Yl0PlVgumcFxbllWymu
         i/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9jKwQeXOOJYEqG9EiZiAbGqeSN91isqTOIWlWyJiGcg=;
        b=BDutIS0Tj9So2y3x+TW+B94p8B2JbIK7PTna094GwXSTF+5Zo8aAFL6YdkXL9AxZRk
         Pw77rsYeznjDDWZhXVUa9pVf7hQCfe2T+5NUqROlSj4DCaY9nctulvH20UassiO0L8+d
         Zs7up4UYHBth/e/OXvaKMjgl9sFgDfA8F5JwSH4yPKDQgTmORFba23ftsNngTljf9pD9
         S7X2WXBa5/14O5BxpDRTkWjCYPYL+o5MJGU2INoDn4aJLLGZ6r1+60kq88seM1xPMijk
         Fuv2tGooeMWALPQ2zwG1Ar2fLGkCBAblvz++VWw84oUxSgY+3cslIAT0Wodsgl1uUz5Z
         vxSg==
X-Gm-Message-State: ACgBeo0UlFMx3kEh0LPEVBeJbu1JgNO+iBeEH7Q63ISYc1MCmg+EEqQV
        5dR+oMSO/tkMICWJ763MqTe6xbTE2w/o5aQXYeM=
X-Google-Smtp-Source: AA6agR7VSUCqYXpCLR9acR+ZrWLln1KIIs26IFnoXyJiTQyYKI5eS19pgX1+eBulJ+VoSMsNOulUPa/9TeGbIwQp3Pw=
X-Received: by 2002:ac8:5d88:0:b0:344:8185:d28a with SMTP id
 d8-20020ac85d88000000b003448185d28amr3795724qtx.259.1660763187134; Wed, 17
 Aug 2022 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
 <xmqqilmzkd7p.fsf@gitster.g> <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
 <xmqqedxgt1zx.fsf@gitster.g> <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
In-Reply-To: <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Aug 2022 12:06:16 -0700
Message-ID: <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

I share some of Junio's concerns, and feel your response is addressing
a tangent but not the actual issues.  Perhaps I can try to explain why
from a slightly different perspective...

On Wed, Aug 17, 2022 at 2:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Tue, 16 Aug 2022, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > I'm all in favor of adding such a good example there, but there is no
> > > reason to hold back `git merge-resolve` from being implemented in C.
> >
> > You did not address the primary point, i.e. why the particular
> > change is a bad one.  Sure, you lost a scripted porcelain or two
> > that are not used much, but in exchange for what?  That is _the_
> > issue and you skirt around it.
>
> In exchange for what I mentioned already in
> https://lore.kernel.org/git/qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr/,
> i.e. in the part you deleted from the quoted mail:
>
>         We reduce Git's reliance on POSIX shell scripting, we reduce the
>         number of programming languages contributors need to be familiar
>         with, we open up to code coverage/static analysis tools that
>         handle C but not shell scripts, just to name a few.
>
> To reiterate why reducing the reliance on POSIX shell scripting is a good
> thing:
>
> - we pay a steep price in the form of performance issues (you will recall
>   that merely rewriting the `rebase -i` engine in C and nothing else
>   improved the overall run time of p3404 5x on Windows, 4x on macOS and
>   still 3.5x on Linux, see
>   https://lore.kernel.org/git/cover.1483370556.git.johannes.schindelin@gmx.de/)
>
>   Yes, Linux sees such an incredible performance boost. Surprising, right?

Sure, scripts are slow *if* run.  Junio asked explicitly about that
"if" part, which you seem to be overlooking, and thus you are
answering a different question.

Is anyone, anywhere, ever running `-s resolve`?  Junio is doubting it,
and given that even some Git developers who were unaware of its
existence[1], I have to wonder too.

[1] https://public-inbox.org/git/kl6l7d58k535.fsf@chooglen-macbookpro.roam.corp.google.com/,
look for "today I learned..."

> - on Windows, even aside from the performance problems (which I deem
>   reason enough on their own to aim for Git being implemented purely in
>   C), users run into issues where anti-malware simply blocks shell
>   scripts, sometimes even quarantines entire parts of Git for Windows.

I'm not sure I'm following.  If users do attempt to run `git
{merge,rebase,cherry-pick,revert} --strategy resolve`, then
anti-malware disables other parts of Git for Windows?  Or is the mere
presence of git-merge-resolve enough to trigger such problems?  If the
latter, then I could agree that's really problematic and worth
addressing.  If the former, we may be back to that all important "if".
But I'm not sure it's one of those two; could you clarify a bit here?

> - have you ever attempted to debug a Git invocation that involves spawning
>   a shell script that in turn spawns the failing Git command, using `gdb`?
>   I have. It ain't pretty. And you know that there are easier ways to
>   abuse and deter new contributors than to ask them to do the same. In
>   particular when large amounts of data have to be passed between those
>   processes, typically via `stdio`.

Yes, that's very painful.  It's annoyed me many times.  It's a
problem, *if* you need to debug a script.  But again, you seem to be
presuming that git-merge-resolve is in use, which dodges the very
question Junio was asking.  Is it in use?

> - show me the equivalent of CodeQL/Coverity for POSIX shell scripting? ;-)
>
> - portability issues dictate that we're not just using your grand father's
>   POSIX shell scripting, but that we limit it to a subset that is opaque
>   to developers unfamiliar with Git project.
>
> - as a consequence, our shell scripts are highly opinionated, often using
>   unintuitive idioms such as `&&` chains instead of `set -e`, which makes
>   them unsuitable as examples how to script Git for regular users.
>
> - a decreasing number of software developers is familiar with the
>   intricacies of that language, leaving us with tech debt.

Yes, these are real issues for code written in shell being actively
developed and maintained, yes.  (shellcheck might help as a
CodeQL/Coverity-like thing for shell.)

However, that doesn't really apply here.  There have literally only
been two commits to git-merge-resolve.sh in the last decade, one from
me that copied a few lines verbatim from git-merge-octopus.sh, and the
other was a single character change 5 years ago.

> In short, there is not a single shred of doubt in my mind that avoiding
> shell scripted parts in Git is a really good goal to have for this
> project.

I think it's a good goal in general, especially for anything heavily
used.  I share Junio's concern about this one in particular.  I'm not
sure this script is even being used directly, the maintenance burden
for it is essentially zero, and the script does have both educational
and testing value.

> > The series makes us lose all strategies that are actively tested
> > that are spawned as a subprocess, which is the way all third-party
> > strategies will be used.
>
> Then have that even-simpler-than `git-merge-resolve.sh` example be tested
> as part of the test suite. That's what the test suite is for.

That simpler thing being a resurrection of git-merge-ours.sh from
a00a42ae33708caa742d9e9fbf10692cfa42f032^ ?

That would test that we shell out to another strategy.  But it
wouldn't really test as many of the cases in builtin/merge.c for
dealing with external strategies.  `-s resolve` can fail on
"interesting" changes, after making changes to the working tree and
index, and builtin/merge.c is expected to handle that -- using a
simpler example would lose that important testing.  (I kinda think
it's a bug that it doesn't clean up after itself and that we made
builtin/merge.c do the cleanup, but backward compatibility suggests we
at least need some way to keep testing that we handle that.)  We would
also need to be careful about testing the "preferred" strategy when
the user asks for multiple strategies, another thing covered in our
testsuite (though using two builtins might be good enough for that).
I'd have to look over the testsuite to check and see if there are
other important properties being tested too; -s resolve has been used
in a few dozen places.

> > After this, we have less test coverage of the codepaths we care about,
> > which is *not* a scripted "resolve" strategy, but the code that runs
> > third-party strategies as externals.
>
> It is better to leave the responsibility of test coverage to the test
> suite, avoiding to ship the corresponding support code to users.
>
> tl;dr your concerns are easy to address, without having to incur the price
> of keeping parts of Git implemented in shell.

There's also another concern you tried to address in your other email;
let me quote from that email here:

> If you want to have an easy example of a custom merge strategy, then let's
> have that easy example. `git-merge-resolve.sh` ain't that example.
>
> It would be a different matter if you had commented about
> `git-merge-ours.sh`:
> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-ours.sh
> That _was_ a simple and easy example.

...and it was _utterly useless_ as an example.  It only checked that
the user hadn't modified the index since HEAD.  It doesn't demonstrate
anything about how to merge differing entries, since that merge
strategy specifically ignores changes made on the other side.  Since
merging differing entries is the whole point of writing a strategy, I
see no educational value in that particular script.

`git-merge-resolve.sh` may be an imperfect example, but it's certainly
far superior to that.

> I would also have understood a lament about the absence of any good
> example in https://git-scm.com/docs/git-merge#_merge_strategies to help
> users develop their own custom merge strategies.
>
> I'm all in favor of adding such a good example there, but there is no
> reason to hold back `git merge-resolve` from being implemented in C.

If someone makes a better example (which I agree could be done,
especially if it added lots of comments about what was required and
why), and ensures we keep useful test coverage (maybe using Junio's
c-resolve suggestion in another email), then my concerns about
reimplementing git-merge-resolve.sh in C go away.

If that happens, then I still think it's a useless exercise to do the
reimplementation -- unless someone can provide evidence of `-s
resolve` being in use -- but it's not a harmful exercise and wouldn't
concern me.

If the better example and mechanism to retain good test coverage
aren't provided, then I worry that reimplementing is a bunch of work
for an at best theoretical benefit, coupled with a double whammy
practical regression.
