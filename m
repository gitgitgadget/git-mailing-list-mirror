Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B6C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGARhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGARhq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 13:37:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7F377C9
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 10:37:45 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u24-20020a63d358000000b004119798494fso1487445pgi.18
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9XcJb0zw2zsoqBC+4aJI8MZJPmzTLdhsye9ylV9UotE=;
        b=RkVbT+kxj/dWoEodhr/hxXp1oCe7+SV3O1pCkguJb4vAwpgo7fKvxLJGKyfS6Zs6hR
         bjvayAg7JeXEmbjBn5V19Gjs8vpDkMWkQXf4CmwwGms/9DtOegJioumtHyvrbOrQyM+H
         nGhxZQQvI5jA1i9iHFfr189ApHpSWE+1GrDbaZ1DRiUGs6995LxNGwnZtSeMqrLN5LT8
         0V3aLzAzJlwIXKUWQd99OBjxRDPLkAPsiyIlFz6ws6iBEP8DifHmZV4K0NnEQn9X5kK/
         2m8WdIU2hwg/fre9L6f7lS4o1WPXFvfxP0YVIP8DZ72tHTfbojJazhfmSyOQPpUh3HGo
         JCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9XcJb0zw2zsoqBC+4aJI8MZJPmzTLdhsye9ylV9UotE=;
        b=C7BI3bHWFGR9QKO8Urn22TP2wZ0vKnvbR8VuV4BIzDu8BzokQXOT5XZc6A1HNgY6a8
         thTDRN+dWggFDD+eUhEuKEYSN0Bpsmfmw0tn/BFzPVolcYPYb9JI/0OhFHqToQu9SIJA
         yE31EMtsoNSmHX+aBgkVdMcHmak20+IlUEWxFpN8d43IK2e7yLP422U4RaRFAvp7KvFQ
         ha5kFB4c1pXE7/dB2MA6mWuWpelD9bQ5CqVTmAAyz79MMKub0HmlU53LWcdjIRNsaoyv
         lH5k24hmPLqXCyp0U6EU2FZgW2pzsvN852kh5lyvriwuLeHsexGL5uqCsmWNrU94DhIV
         XvlA==
X-Gm-Message-State: AJIora+m4TgP2cfY5z4Wi+HrVXo0M/8Y7ZGa4H0yvlojstcYAczKDNWR
        8haRHW4qWqyyBGZ+c7XMAVPdFN1TTInikA==
X-Google-Smtp-Source: AGRyM1tKyuwK9babmLM2Bl25I0xmMFRYApo2LiX53k33xP69UqdfpRGqEfAqJ3jFy9RgLhh+hTahzGoIXXIUXw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:f318:b0:1ec:b74b:9b82 with SMTP
 id ca24-20020a17090af31800b001ecb74b9b82mr17785998pjb.198.1656697064725; Fri,
 01 Jul 2022 10:37:44 -0700 (PDT)
Date:   Fri, 01 Jul 2022 10:37:43 -0700
In-Reply-To: <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lr134spi0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for weighing in :) Despite the different proposed approaches, I
think we actually are in broad agreement.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jun 30 2022, Glen Choo via GitGitGadget wrote:
>
>> This is a quick re-roll to address =C3=86var's comments on the tests (th=
anks!).
>
> Thanks!
>
>> =3D Description
>
> Just more generally on this series & approach. I know this is a v6 by
> now, but I haven't kept up with this topic, but to be fair I did mention
> pretty much this in:
> https://lore.kernel.org/git/220407.86lewhc6bz.gmgdl@evledraar.gmail.com/
>
> So...
>
>> There is a known social engineering attack that takes advantage of the f=
act
>> that a working tree can include an entire bare repository, including a
>> config file. A user could run a Git command inside the bare repository
>> thinking that the config file of the 'outer' repository would be used, b=
ut
>> in reality, the bare repository's config file (which is attacker-control=
led)
>> is used, which may result in arbitrary code execution. See [1] for a ful=
ler
>> description and deeper discussion.
>>
>> This series implements a simple way of preventing such attacks: create a
>> config option, discovery.bare, that tells Git whether or not to die when=
 it
>> finds a bare repository. discovery.bare has two values:
>>
>>  * "always": always allow bare repositories (default), identical to curr=
ent
>>    behavior
>>  * "never": never allow bare repositories
>>
>> and users/system administrators who never expect to work with bare
>> repositories can secure their environments using "never". discovery.bare=
 has
>> no effect if --git-dir or GIT_DIR is passed because we are confident tha=
t
>> the user is not confused about which repository is being used.
>
> I'm not insisting that the entire approach here should be changed, but
> in the above exchange you seemed to have performance concerns about the
> "just walk up in setup.c" approach I mentioned, but it's not clear if
> that's still the only thing that necessitates taking this approach.
>
> There may be security subtleties that I've missed, but from the
> description here it seems like that would work equally well, and
> wouldn't require configuration, except insofar as we'd need to opt-in to
> reading config from bare repositores *that also exist in a parent tree*.
>
> And it would be a more narrow & more secure solution, since it would
> e.g. allow you to intentionally navigate to /var/repos/git/git.git in a
> server setup and read the config there, which it could distinguish from
> a case of /var/repos/.git existing, and git/git.git being brought in as
> a part of that "parent" repo.

Performance is one major concern, yes, and I agree that your findings
show that the "just walk up" approach is cheap enough to consider doing.
Though in the few cases where it isn't cheap to walk, wouldn't it still
be useful to be able to opt out of it?

The other concern is simplicity and correctness. Are we confident that
we'll get the design of "just walk up" correct (including edge cases
like "bare repo in bare repo in non bare repo")? I'm 100% confident that
we'll get it right eventually, and that this approach will be a good
default for all users. But in comparison, "never" is so much easier to
understand and implement that I don't see why we shouldn't start by
presenting this option to the 0.1-1% of users who would find it useful.

And on the topic of simplicity, there's significant interest in
maintaining backwards-compatibility with repos with workflows that
absolutely depend on embedded bare repos, e.g. libgit2 and Git-LFS.
That's yet another special case that we'd have to get right. Stolee's
"no-embedded" proposal [1] pretty much covers that, but I don't see the
harm in simplifying the design space by making bare repo support a
non-goal.

[1] https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github=
.com

> The "more narrow" and "more secure" go hand-in-hand, since if you work
> on such servers you'd turn this to "always" because you want to read
> such config, but then be left vulnerable to the actual (and muche rarer)
> exploit we're trying to prevent.

The point that we're not defending bare repo users is fair, but maybe
the group we're trying to protect isn't really dedicated Git-serving
servers. This exploit requires you to have a bare repo inside the
working tree of a non-bare repo. So I think this is less of an issue for
a server, and more for "mixed-use" environments with both regular and
bare clones.

> Which, it seems...
>
>> This series does not change the default behavior, but in the long-run, a
>> "no-embedded" option might be a safe and usable default [2]. "never" is =
too
>> restrictive and unlikely to be the default.
>
> This series has (since v3?) been noting aspirations to have a
> "no-embedded" variant of this config, which your 5/5 here notes would be
> better, but isn't implemented by this series.
>
> But your 5/5 also notes:
>
>     but detecting if a repository is embedded is potentially
>     non-trivial, so this work is not implemented in this series.
>
> Hrm, well, the diff-stat isn't quite that trivial either :) :

Well.. a lot of it is refactoring :P

>> [...]
>>  upload-pack.c                       | 27 ++++++----
>>  12 files changed, 304 insertions(+), 47 deletions(-)
>
> In threads linked from the above ML link I linked to some POC code
> showing how to hack a second .git discovery walk into setup.c. This was
> as part of the "submodule parent dir" proposal, which is a different
> feature, but also needs such "find the parent" code:
> https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
>
> Now, obviously that's a dirty hack, but it's not that hard to just
> change the part of setup.c where we're satisfied that we've found the
> git dir, then walk up "$THAT_DIR/..", and start our search again.
>
> Then:
>
> 	if (first_dir_was_bare() && found_parent_dir())
>         	enforce_no_embedded();
>
> Isn't that what your proposed "no embedded" option would need to do?
> Well, maybe we'd also check if the "first dir" is in the index of the
> parent, as opposed to just being a bare .git somewhere in ~/Downloads,
> e.g. if you have a ~/.git and keep your dot-files in git.
>
> But I think for an initial implementation just doing the walk would be
> good enough, and would have a more narrow scope than this configuration
> setting.

A narrow scope is good, but I don't agree on this definition of
"narrow". My preference is to give an obvious solution to a 'narrow'
group of users, instead of a more tricky solution that affects all users
in a 'narrow' set of cases.

> AFAICT the performance concerns aren't supported by any data, in the
> case of the "submodule superproject" feature it turned out to not be the
> directory walk, but us shelling out in a loop in git-submodule.sh.
>
> Well, *maybe* that's not the case, I think I have managed to read
> between the lines of some of these past exchanges that there's some odd
> propriterary internal NFS-like setup at Google where *parent dirs* are
> auto-mounted and searched on access, so a "walk up" pattern would be
> much more expensive.
>
> I do worry a bit about us ending up with design choices in git that we
> wouldn't have ended up with, if not to cater to some in-house setup
> somwhere that 99.99% of git users will never see.

At the very least, I don't think you're saying that it's a bad idea to
have "never", just that we might not have come up with it if not for
some Google NFS thing.

Another use case I can think of is CI bots, which have no need for bare
repos. To some folks (maybe in very security-sensitive environments),
"never" might give more peace of mind than "no-embedded".

> But I don't have the full picture on the "submodule superproject"
> problem, or this one, and maybe I'm missing something. Just food for
> thought, and wondering where we're eventually taking this.
>
> Thanks!
