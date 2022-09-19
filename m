Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99541C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 04:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiISENW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 00:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiISENM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 00:13:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C2175BB
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 21:13:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o7so16088699qkj.10
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 21:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PiawD7UvylhV6qR+eElIjtKJcKVhpqN6jfit6QqxVTI=;
        b=CaUUxWeOlh2W2ui7fy873GzYjjdd1P2n9ECe0F8Cm2/WSg2YXORT3fEhnD/yNqDmv6
         y6/d5EPPGPSKzgkldpXQfmvigqnq1i0vc3eR91tAlCkhyuIvk1B/oFvp3gRhb79LEq5g
         QSmCt7XtVlUK74a8Q8WH5vHkIC1wtjM2rv+2Swt/WUf4tH66mxNDp7xje5hDT3tIzIqv
         K8d8mzNMqmUkK0Xp54BoACDvbvZZb1nnazetP168ky25xKzLj49mEnmogQkIBREbS6Rg
         VIBQWIl4RKmlJaVKLdGsnUH9ZM8L8TqXIdxFxii4NXxzNI4GZgNPgngR7wrurC/xC0p0
         WQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PiawD7UvylhV6qR+eElIjtKJcKVhpqN6jfit6QqxVTI=;
        b=gZMpbA5gpVipQO8kgzaRODQm+ZuFBlqqYK53IWAWiTpr0Fx2DUsid9tOc3NLV0GAjs
         N5CIV5PgESShfH0Dql8h4Y7u4ky1bZxdw1eZoklJpvbh7uoaKr7TOXaIe31PjHuGQ2JC
         ykhKMWx3jD8epu1eLDbf7IGyCTAllEZn4qbzKdpBLKeNWpVWtIg3f+V/UNs1EeT3D34M
         CNOv7t4iHJGmhJ1gvKmCE/8WdfcH+2s78ekqey6ltsDc9JGkl+BrX52lqNZIrycklogd
         a4HfiPncaQZ/D3hbX3tdahfu8V95y9P565yXbFEMCbGQCGvKzs7LbijXr71z0pzTpoHx
         ZrFQ==
X-Gm-Message-State: ACrzQf3IFyvJs4oPInLqbKNsqq/2icyRBymtcvgozkWvu8zCGX21qsqo
        aZvvRzZJ16wCgyLA1Q070b8=
X-Google-Smtp-Source: AMsMyM6PWzMNIDSORjhxftarOZ5LFg7bjTs3BGAh0AuJzzJX3k3oobyKqCEV9vilOlEI7+w+TIw+vg==
X-Received: by 2002:a05:620a:45a7:b0:6ce:9dca:f918 with SMTP id bp39-20020a05620a45a700b006ce9dcaf918mr11316907qkb.688.1663560788032;
        Sun, 18 Sep 2022 21:13:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:a1e5:4d99:81b9:c022? ([2600:1700:5a60:7720:a1e5:4d99:81b9:c022])
        by smtp.gmail.com with ESMTPSA id d4-20020ac80604000000b0035cebb79aaesm1041983qth.18.2022.09.18.21.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 21:13:07 -0700 (PDT)
Message-ID: <7c919389-e71b-451b-1d1f-7209fd489889@gmail.com>
Date:   Sun, 18 Sep 2022 21:13:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
 <fed3c401-6cba-c729-74a8-d0bf53e12699@gmail.com>
 <CABPp-BG4_JepP089uOwcRZVcnEM_C_-OvsUzAtPkZdAEyuJTHw@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <CABPp-BG4_JepP089uOwcRZVcnEM_C_-OvsUzAtPkZdAEyuJTHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/2022 9:24 PM, Elijah Newren wrote:
> On Fri, Sep 16, 2022 at 8:34 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>>
>>> I'm also curious whether there shouldn't be a config option for
>>> something like this, so folks don't have to specify it with every
>>> invocation.  In particular, while I certainly have users that want to
>>> just query git for information about the part of the history they are
>>> interested in, there are other users who are fully aware they are
>>> working in a bigger repository and want to search for additional
>>> things to add to their sparse-checkout and predominantly use grep for
>>> things like that.  They have even documented that `git grep --cached
>>> <TERM>` can be used in sparse-checkouts for this purpose...and have
>>> been using that for a few years.  (I did warn them at the time that
>>> there was a risk they'd have to change their command, but it's still
>>> going to be a behavioral change they might not expect.)  Further, when
>>> I brought up changing the behavior of commands during sparse-checkouts
>>> to limit to files matching the sparsity paths in that old thread at
>>> [1], Stolee was a bit skeptical of making that the default.  That
>>> suggests, at least, that two independent groups of users would want to
>>> use the non-sparse searching frequently, and frequently enough that
>>> they'd appreciate a config option.
>>
>> A config option sounds good. Though I think
>>
>> 1. If this option is for global behavior: users may better off turning
>> off sparse-checkout if they want a config to do things densely everywhere.
> 
> Sorry, it sounds like I haven't explained the usecases to you very
> well.  Let me try again.
> 
> There are people who want to do everything densely, as you say, and
> those folks can just turn off sparse-checkout or not use it in the
> first place.  Git has traditionally catered to these folks just fine.
> However, it's not a subset of interest for this discussion and wasn't
> what I was talking about.

OK, reading...

> There are (at least) two different usecases for people wanting to use
> sparse-checkouts; I have users that fall under each category:
> 
> 
> 1) Working on a repository subset; users are _only_ interested in that subset.
> 
> This usecase is very poorly supported in Git right now, but I think
> you understand it so I'll only briefly describe it.
> 
> These folks might know there are other things in the repository, but
> don't care.  Not only should the working tree be sparse, but grep,
> log, diff, etc. should be restricted to the subset of the tree they
> are interested in.

Right, this is the usecase I am familiar with.

> Restricting operations to the sparsity specification is also important
> for marrying partial clones with sparse checkouts while allowing
> disconnected development.  Without such a restrict-to-sparsity-paths
> feature, the partial clones will attempt to download objects the first
> time they try to grep an old revision, or do log with a glob path.
> The download will fail, causing the operation to fail, and break the
> ability of the user to work in a disconnected manner.

OK, I'm still learning about partial clone, didn't get a chance to look
at it. Will try to figure out what this means :)

> 2) The working directory is sparse, but users are working in a larger whole.
> 
> Stolee described this usecase this way[2]:
> 
> "I'm also focused on users that know that they are a part of a larger
> whole. They know they are operating on a large repository but focus on
> what they need to contribute their part. I expect multiple "roles" to
> use very different, almost disjoint parts of the codebase. Some other
> "architect" users operate across the entire tree or hop between different
> sections of the codebase as necessary. In this situation, I'm wary of
> scoping too many features to the sparse-checkout definition, especially
> "git log," as it can be too confusing to have their view of the codebase
> depend on your "point of view."
> 
> [2] https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
> 
> I describe it very similarly, but I'd like to point out something
> additional around this usecase and how it can be influenced by
> dependencies.  The first cut for sparse-checkouts is usually the
> directories you are interested in plus what those directories depend
> upon within your repository.  But there's a monkey wrench here: if you
> have integration tests, they invert the hierarchy: to run integration
> tests, you need not only what you are interested in and its
> dependencies, you also need everything that depends upon what you are
> interested in or that depends upon one of your dependencies...AND you
> need all the dependencies of that expanded group.  That can easily
> change your sparse-checkout into a nearly dense one.  Naturally, that
> tends to kill the benefits of sparse-checkouts.  There are a couple
> solutions to this conundrum: either avoid grabbing dependencies (maybe
> have built versions of your dependencies pulled from a CI cache
> somewhere), or say that users shouldn't run integration tests directly
> and instead do it on the CI server when they submit a code review.  Or
> do both.  Regardless of whether you stub out your dependencies or stub
> out the things that depend upon you, there is certainly a reason to
> want to query and be aware of those other parts of the repository.
> Thus, sparse-checkouts can be used to limit what you directly build
> and modify, but these users do not want it to limit their queries of
> history.
> 
> 
> Once users pick either the first or the second usecase, they often
> stick within it.  For either group, regardless of what Git's default
> is, needing to specify an additional flag for *every*
> grep/log/diff/etc. they run would just be a total annoyance.  Neither
> wants a dense worktree, but one side wants a dense history query while
> the other wants a sparse one.  Different groups should be able to
> configure the default that works well for them, much like we allow
> users to configure whether they want "git pull" to rebase or merge.

OK, now I get it:

Case A: users only interested in a subset, so they need only sparse
history and a sparse worktree.

v.s.

Case B: users works within a subset but needs a larger context, so they
need a dense history/query (that's why we should let grep default to
--no-restrict, as you suggested?), though still a sparse worktree.

> 
>> 2. If this option is for a single subcommand (e.g. 'grep'): I don't have
>> much thoughts here. It certainly can be nice for users who need to do
>> non-sparse searching frequently. This design, if necessary, should
>> belong to a patch where this config is added for every single subcommand?
>>
>>> I also brought up in that old thread that perhaps we want to avoid
>>> adding a flag to every subcommand, and instead just having a
>>> git-global flag for triggering this type of behavior.  (e.g. `git
>>> --no-restrict grep --cached ...` or `git --dense grep --cached ...`).
>>
>> This looks more like the answer to me. It's a peace of mind for users if
>> they don't have to worry about whether a subcommand is sparse-aware, and
>> how may their behaviors differ. Though we still may need to update the
>> actual behavior in each subcommand over an extended period of time
>> (though may not be difficult?), which you mentioned above "seems like a
>> poor strategy".
>>
>>> [1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
>>> and the responses to that email>
>>>> Change the default behavior of 'git grep' to focus on the files within
>>>> the sparse-checkout definition. To enable the previous behavior, add a
>>>> '--sparse' option to 'git grep' that triggers the old behavior that
>>>> inspects paths outside of the sparse-checkout definition when paired
>>>> with the '--cached' option.
>>>
>>> I still think the flag name of `--sparse` is totally backwards and
>>> highly confusing for the described behavior.  I missed Stolee's email
>>> at the time (wasn't cc'ed) where he brought up that "--sparse" had
>>> already been added to "git-add" and "git-rm", but in those cases the
>>> commands aren't querying and I just don't see how they lead to the
>>> same level of user confusion.  This one seems glaringly wrong to me
>>> and both Junio and I flagged it on v1 when we first saw it.  (Perhaps
>>> it also helps that for the add/rm cases, that a user is often given an
>>> error message with the suggested flag to use, which just doesn't make
>>> sense here either.)  If there is concern that this flag should be the
>>> same as add and rm, then I think we need to do the backward
>>> compatibility dance and fix add and rm by adding an alias over there
>>> so that grep's flag won't be so confusing.
>>
>> I guess I'm using "--sparse" here because "add", "rm" and "mv" all imply
>> that "when operating on a sparse path, ignores/warns unless '--sparse'
>> is used". I take it as an analogy so "when searching a sparse path,
>> ignores/warns unless '--sparse' is used". As the idea that "Git does
>> *not* care sparse contents unless '--[no-]sparse' is specified" is sort
>> of established through the implementations in "add", "rm", or "mv", I
>> don't see a big problem using "--sparse" here.
> 
> Well, I do.
> 
> In addition to just being utterly backwards and confusing in the
> context of grep:
>   * Both `clone` and `ls-files` use `--sparse` to mean to limit things
> to the sparsity cone, so we're already kinda split-brained.

Agree.

>   * grep is more like ls-files (both being querying functions) than
> add/rm/mv, so should really follow its lead instead of the one from
> add/rm/mv.

Agree.

>   * There's another way to interpret `--sparse` for `add` and `rm`
> such that it makes sense (at least to me); see my other email to Junio
> in this thread.

According to the spirit of your points, I think they should be
defaulting to --restrict (a rename perhaps) right now.

>   * `mv` is indeed using it backward, but the `mv` change is new to
> this cycle (and undocumented) so I'm not sure it counts as much of a
> precedent yet.

Oops, I was making the modifications to `mv` and forgot to add
documentation to it. Though the --sparse of `mv` was not documented
before I touching it. Perhaps it can be added later if we are going to
rename --sparse/--dense to --restrict/--no-restrict.

>> I *think*, as long as the users are informed that the default is to
>> ignore things outside of the sparse-checkout definition, and they have
>> to do something (using "--sparse" or a potential better name) to
>> override the default, we are safe to use a name that is famous (i.e.
>> "--sparse") even though its literal meaning is not perfectly descriptive.
>>
>> One outlier I do find confusing though, is the "--sparse" option from
>> "git-ls-files". Without it, Git expands the index and show everything
>> outside of sparse-checkout definition, which seems a bit controversial.
> 
> Nah, that perfectly matches the expectation of users in the second
> usecase above -- querying (ls-files/grep/log/diff) defaults to
> non-restricted history, modifying (add/rm/mv) defaults to restricted
> paths but warns if the arguments could have matched something else,
> and the working tree is restricted to sparse paths.  It doesn't seem
> too controversial to me, even if it's not what we want for the
> long-term default.

OK. After the reasoning you gave above, now the --sparse of ls-files
looks good.

> 
> The defaults for the first usecase would be defaulting to restricted
> paths for everything, and perhaps not warn if arguments to a modifying
> command could have matched something else.
> 
> 
> Anyway, hope that helps you understand my perspective and framing.

Thanks for the explanations, now I get it and agree with your points :)

Thanks,
Shaoxuan
