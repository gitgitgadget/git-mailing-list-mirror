Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9762FC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiJFUx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJFUx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:53:28 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904DE0C5
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:53:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e13-20020a17090ab38d00b0020b06ff019aso2016650pjr.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN6rcMaQsTqG0NXrdgE8BVDKiQ2lY/HLEpvaS45O/lM=;
        b=OGbHU4IpUF/2AHfns6JvL32Pd94tncW8l4DXhKin00oAEUEr70C9BcW1X2vYvbGr7L
         E3AnJtHMpHuyYdVeYEkcXgM18mDNTRtdNMbSIDaYZW4DpGrEGhM8eAmcmhbgRcFoqz2R
         +cje5+lUrnJ3RcUhvy8x4xLTiDylJx44yw6ZsCq7sSNzMXVHKR7/9fgKOs+MxlonMODo
         V2/u4DpXSGjOUASKPsr64v0TEhDql5cPgSSL0wdZFqYbTFS97IhIWYT6QfiJjWQeBDt+
         trQJDq5QZaOeQAe05rGYuTWyAQECxXfyrq281/DvHsrIsTMqfxiCHW/6OK5/8RL9ZGcb
         fPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lN6rcMaQsTqG0NXrdgE8BVDKiQ2lY/HLEpvaS45O/lM=;
        b=5NWn2NoJ4hzebiNfLaLCVyn3HM4ywFzSj1SpFsEAEp3F5U0bGJXKKXSqgsoJm9Gxkn
         MlNaDAhJAHK6B+e2bdjs2UPqm1VVLXxw/RISgiVO/hppxootjBebTiwhqyuvbbmfaA/y
         xxEa7spUaxPtiJIRKfruCscebtQmumgCS7FIqaKXeav55aT0leU8gzVc1pBTbn1uSLf9
         zbC3mSSv4Ol6bcfvFb7zU7do6Wv5cZXBrv0yKvaGofufJpYyBe+nl8T0WWcplf42rNab
         C+aOWHfVgw7oPB1vaTnrcENIaslw7SKdGmDB/47lED3VUR/PTP8JbAXbfjaNZT5R6yUk
         l8lA==
X-Gm-Message-State: ACrzQf30n7JpoDNSEzg/aJowJUBZAy6D+vaiD3nRQ2lUnQC5l5SP74bW
        JSFOp+gkEnYa1MIBx/O50GN13cwXFqIAwg==
X-Google-Smtp-Source: AMsMyM6f9B+TpEoLudTg3Pby7JUW+KHxkC90BBlV2Vk/4C037YdM62iY5VSlmvh61Yszn6wEXyRHv7+0lyX1dg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:188b:b0:20a:8fc8:60b8 with SMTP
 id mn11-20020a17090b188b00b0020a8fc860b8mr12579817pjb.37.1665089605765; Thu,
 06 Oct 2022 13:53:25 -0700 (PDT)
Date:   Thu, 06 Oct 2022 13:53:16 -0700
In-Reply-To: <CAN9+7XcYFa+Y9jsJSEmQhf29TUZADoz8=SzcNbjCH8ewqYriYg@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com> <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
 <CAN9+7XcYFa+Y9jsJSEmQhf29TUZADoz8=SzcNbjCH8ewqYriYg@mail.gmail.com>
Message-ID: <kl6ltu4gwu6b.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 01/10] technical doc: add a design doc for the evolve command
From:   Glen Choo <chooglen@google.com>
To:     Chris Poucet <poucet@google.com>,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        vdye@github.com, Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Chris!

Chris Poucet <poucet@google.com> writes:

> One thing that is not clear to me is whether this is the desired
> direction. I took at look at the git review notes but it was hard to
> get a sense of where people are at.

I'm really sorry, I meant to get back to this sooner with the takeaways
from Review Club. Hopefully this will still be useful.

You can find the Review Club notes here:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3s=
tCuS_w/edit?pli=3D1

> Would love input on the design.

Others have given a lot of input on the design, so instead, I'll focus
mostly on how to make the doc better on the mailing list.

>
> On Wed, Oct 5, 2022 at 4:59 PM Stefan Xenos via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Stefan Xenos <sxenos@google.com>
>>
>> This document describes what a change graph for
>> git would look like, the behavior of the evolve command,
>> and the changes planned for other commands.
>>
>> It was originally proposed in 2018, see
>> https://public-inbox.org/git/20181115005546.212538-1-sxenos@google.com/

This doc is quite well-thought-out and surprisingly readable despite its
length. That said, it is a lot to review in one sitting, and a reviewer
might get easily fatigued. I suspect that reviewers will find it hard to
keep up with the discussion if they have to review the entire doc on
every iteration.

As Victoria suggested in Review Club, it might be helpful to split up
the design over multiple patches to make feedback more focused. I think
this will make it easier for you (and others) to get a sense of how we
feel about each part of the design. e.g. here's one way to split up the
doc:

- Motivation, Background, High level idea of how a user would use this.=20

  (Roughly corresponding to the sections "Objective", "Status",
  "Background", "Goals", "Similar technologies", "Semi-related work")

- Local change tracking, Changes to existing commands, Meta-commits

  (The parts about the data format and their implications for GC,
  negotiation, etc. Maybe include the `change` subcommand if it helps
  reviewers visualize the impact.)

- How evolve works, e.g. convergence, divergence, merge base finding.
  CLI

- Sharing changes

Besides the design, here other sections that I would find useful:

- Glossary. I thought that terms like "change", "change branch" and
  "change graph" were underdefined. This would also be a useful
  reference during the implementation phase.

- Implementation Plan (you can find examples in
  Documentation/technical/bundle-uri.txt and
  Documentation/technical/sparse-index.txt). Making the concrete next
  steps visible has numerous benefits:
  - Reviewers of future patches know what problem is being tackled and
    value is being delivered.
  - The list gains confidence that the author can deliver the work being
    promised.
  - The shared direction makes it easier for others to contribute
    patches.

- Open questions (e.g. "Implementation questions" in [1]). It would be
  useful to know what questions can be answered later instead of right
  now. Also, since you are not the original author, perhaps you also
  have questions about the design that you want answered by reviewers.
  I also wouldn't mind this being in the cover letter or "---" section.

[1] https://lore.kernel.org/git/pull.1367.git.1664064588846.gitgitgadget@gm=
ail.com

As mentioned earlier, I'll comment only very lightly on the design.

>> +Similar technologies
>> +--------------------

I'd personally love to see "git evolve". If it helps to consider some
other tools, I use the following tools that implement similar workflows:

- git-branchless [2] features anonymous heads, obsolescence tracking,=20
  history manipulations and "git evolve". Having used this for a while,
  I'm of the opnion that having any of these features without the
  others is still very useful, and implementing them in phases=20
  will still deliver value without having to complete all of the work
  (granted, each of these features is incrementally dependent on the
  others).

  Case in point: I don't use the "evolve" equivalent of git-branchless
  (IIRC "restack); being able to see obsolescence and manually
  manipulating history is good enough for me.

- Jujutsu [3] also features anonymous heads, obsolescence tracking and
  advanced history manipulations. Instead of "evolve", descendents of an
  obsolete commit are automatically rebased on the obsoleting commit.

[2] https://github.com/arxanas/git-branchless
[3] https://github.com/martinvonz/jj

>> +Changes
>> +-------
>> +A branch of meta-commits describes how a commit was produced and what p=
revious
>> +commits it is based on. It is also an identifier for a thing the user i=
s
>> +currently working on. We refer to such a meta-branch as a change.
>> +
>> +Local changes are stored in the new refs/metas namespace. Remote change=
s are
>> +stored in the refs/remote/<remotename>/metas namespace.

I find this terminology of "changes" and "metas" more confusing than
necessary. A glossary would help, but it might be even better to also
use an appropriate ref namespace. "refs/changes/" is an obvious
candidate, though I assume this wasn't mentioned because Gerrit uses
that namespace extensively.

Maybe `refs/changelists`, `refs/change-requests`, `refs/proposals`? Idk.

>> +Sharing changes
>> +---------------
>> +Change histories are shared by pushing or fetching meta-commits and cha=
nge
>> +branches. This provides users with a lot of control of what to share an=
d
>> +repository implementations with control over what to retain.
>> +
>> +Users that only want to share the content of a commit can do so by push=
ing the
>> +commit itself as they currently would. Users that want to share an edit=
 history
>> +for the commit can push its change, which would point to a meta-commit =
rather
>> +than the commit itself if there is any history to share. Note that mult=
iple
>> +changes can refer to the same commits, so it=E2=80=99s possible to cons=
truct and push a
>> +different history for the same commit in order to remove sensitive or i=
rrelevant
>> +intermediate states.

I would not like to see the ability to share all intermediate states
with the server because this increases the risk of unintentional
disclosure by a lot.

How exactly we could tweak this can be an open discussion for later.
Some examples I can think of:
  - Asking the user to go through the obsolescence log and manually
    prune revisions (sounds too onerous for users IMO).
  - Push a truncated history consisting of only the latest version and
    commits that the server already knows (somewhat similar to Gerrit).

>> +Evolve
>> +------
>> +The evolve command performs the correct sequence of rebases such that n=
o change
>> +has an obsolete parent. The syntax looks like this:
>> +
>> +git evolve [upstream=E2=80=A6]
>> +
>> +It takes an optional list of upstream branches. All changes whose paren=
t shows
>> +up in the history of one of the upstream branches will be rebased onto =
the
>> +upstream branch before resolving obsolete parents.
>> +

This CLI is an example of something that can be reviewed largely
independently of the implementing data structures.

>> +Merge
>> +-----
>> +
>> +To select between these two behaviors, merge gets new =E2=80=9C--amend=
=E2=80=9D and =E2=80=9C--noamend=E2=80=9D
>> +options which select between the =E2=80=9Ccreate=E2=80=9D and =E2=80=9C=
modify=E2=80=9D behaviors respectively,
>> +with noamend being the default.

Ditto.

