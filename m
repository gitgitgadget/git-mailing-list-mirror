Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D023BC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 13:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiI1NWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI1NW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 09:22:28 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFA275F9
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:22:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g2so7831460qkk.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=D+szELUL2uJ8M9ANaI3jvOzCs5UFOk3eZT8T/rKB0+k=;
        b=Ijiz1HWvDnsqwVsrLYtO+uD7tvzu1NlKe/cvN1urrKYtvaGX+YnG26L5AXMpuWESzx
         J6FAW0gaRTjuMCS3NtmtQDk7No7+BqhTJaPqP3KzRez6Vdxk2SLy8RDlbUK7FMvCEmrk
         0R/M3PEbT6M/4q0e0EB8k4ImrHYdM2aPOzc28Ubr2xnqks9qgK8nvnykd3BjpiBadrSB
         QSmRSSJ4f1CCCe3yzDZa8A7yEB9RgIYqc9BNjHYMf13qG29/mVr7USp4JyIZSLBNTAog
         6Pc6wqjMCCA3E0NlsYxPJy+fgacgi52sdnWjyHmWe77XTNYjEBu8Z21eYHwfCs79I8U/
         0/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D+szELUL2uJ8M9ANaI3jvOzCs5UFOk3eZT8T/rKB0+k=;
        b=OkxnEqTP5IJFyUl1ccSjXxe1hl+fA/djYs3elZpE8IexU4kebYVog9nZ2NHb0fwwzi
         MnmtzI2/kAbj6RV3R3i7GJHaImsvUSrdAI2CB8VJkdr7HypMbc2RPSJKwHOf0vzFakKu
         uuKC1Z3AuvfWfRpv6JjGMiTzKIpKvTTCLLBAwzDE1E69GgsjPCvrzwWs0se7gWZ2HYIC
         qppzDKxOFu8w6AlPIqsy0qqURmQhORA8Y8ZANK3jQQPjUUgYUQUE6MyTH+dJeDPh9X2r
         41BkcpTFBvVUCzvt369H/pEcnAtcroVg9GCkbRGRC+qNvAh21mfEXJ3YRNecLTJmenNJ
         K4rQ==
X-Gm-Message-State: ACrzQf2x5ozteEWRIC2432UtE8PtzEuLrMIswl529Z0ATKE031UaCHCm
        68bxKqU5Q8/TtmIWIDlozD2j
X-Google-Smtp-Source: AMsMyM6biilT6/4wrphmQ55N6MEGuJQR/NshjT19+8i9GS0Xs997xNBjR5vOR0Bq7RfGnMmCfLgkkg==
X-Received: by 2002:a05:620a:f0e:b0:6cf:beb5:a28 with SMTP id v14-20020a05620a0f0e00b006cfbeb50a28mr3683877qkl.738.1664371345476;
        Wed, 28 Sep 2022 06:22:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7cc4:e6ac:5e8e:b74d? ([2600:1700:e72:80a0:7cc4:e6ac:5e8e:b74d])
        by smtp.gmail.com with ESMTPSA id d2-20020a05622a100200b0035bb8168daesm2969265qte.57.2022.09.28.06.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 06:22:25 -0700 (PDT)
Message-ID: <5d926706-6ca3-ce07-f8f2-771fe126450b@github.com>
Date:   Wed, 28 Sep 2022 09:22:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
 <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/22 1:38 AM, Elijah Newren wrote:
> On Tue, Sep 27, 2022 at 9:36 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 9/24/2022 8:09 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>
>>> +  (Behavior A) Users are _only_ interested in the sparse portion of the repo
>>> +
>>> +These folks might know there are other things in the repository, but
>>> +don't care.  They are uninterested in other parts of the repository, and
>>> +only want to know about changes within their area of interest.  Showing
>>> +them other results from history (e.g. from diff/log/grep/etc.) is a
>>> +usability annoyance, potentially a huge one since other changes in
>>> +history may dwarf the changes they are interested in.
>>
>> This idea of restricting the commit history to the sparse-checkout
>> definition (by default, with an escape hatch) seems like the most
>> radical of the things we've considered. I think it's interesting to
>> consider, but it might be better to think about things like diffstats,
>> grepping, and otherwise preventing out-of-cone adjustments by default.
>>
>> That said, the idea of restricting history is also the simplest to
>> describe as a user-visible change.
> 
> By "restricting commit history", are you thinking in terms of "git log
> -- PATHS" or more like some kind of special --filter to git-clone?
> 
> I get the feeling you might be thinking about the latter, whereas I
> was assuming users had all commits (and all trees), but log/diff would
> restrict output based on relevant paths.

I'm most skeptical of the "git log -- <sparse-checkout-paths>"
restriction showing a simplified history graph. I get enough
complaints about "missing commits" from simplified file history
as it is. Adding this simplified history scoped to the sparse-
checkout is more likely to add confusion than help users, in my
opinion.

>>> +People might also end up wanting behavior B due to complex inter-project
>>> +dependencies.  The initial attempts to use sparse-checkouts usually
>>> +involve the directories you are directly interested in plus what those
>>> +directories depend upon within your repository.  But there's a monkey
>>> +wrench here: if you have integration tests, they invert the hierarchy:
>>> +to run integration tests, you need not only what you are interested in
>>> +and its dependencies, you also need everything that depends upon what
>>> +you are interested in or that depends upon one of your
>>> +dependencies...AND you need all the dependencies of that expanded group.
>>> +That can easily change your sparse-checkout into a nearly dense one.
>>
>> In my experience, the downstream dependencies are checked via builds in
>> the cloud, though that doesn't help if they are source dependencies and
>> you make a breaking change to an API interface. This kind of problem is
>> absolutely one of system architecture and I don't know what Git can do
>> other than to acknowledge it and recommend good patterns.
> 
> I was talking about (source) dependencies between
> modules/projects/whatever-you-want-to-call-the-subcomponents of your
> repository.  We have hundreds of modules, with various cross-module
> dependencies that evolve over time.
> 
> I get the feeling from your description that your intra-repository
> dependencies between modules/projects/whatever are much more static
> for you than what we deal with.  (Which is a good thing; it'd be nice
> if ours were more static.)

The internal monorepo I know the most about has a very strict project
system that has less granularity than other build systems, so the
projects themselves don't change dependencies very frequently (but
they have lots of internal build adjustments that they can make
without updating the sparse-checkout). This is probably atypical,
especially from what I've heard from companies working with a build
system like Bazel.

>> In a properly-organized project, 95% of engineers in the project can have
>> a small sparse-checkout, then 5% work on the common core that has these
>> downstream dependencies and require a large sparse-checkout definition.
> 
> "In a properly-organized project"?  I'm unsure if this is an
> indictment of some of the repositories I deal with in reality (and to
> be fair, it might be a totally fair indictment), or if your statement
> is starting to cross into "No true scotsman" territory.  ;-)

I should probably say things like "If system architects want to
optimize for Git performance for the majority of their engineers, then
this kind of dependency organization is desirable." Building projects
in a vacuum, ignoring Git entirely, there is still a benefit to
minimizing local build costs for individual engineers. I think that
most of the time those improvements to the build system will also
result in more efficient sparse-checkout definitions for engineers
working on a small set of components.

> I would probably lean towards the former (we know it's more messy than
> it should be), but I'm a bit puzzled that you'd just brush aside my
> mention of integration tests.  We have people who want to run
> integration tests locally, even when only modifying a small area of
> the codebase.  These users are not doing cross-tree work, rather they
> are doing cross-tree testing in conjunction with their work.

I include "this component is used tree-wide" as tree-wide work, even
if it doesn't mean they are modifying code across the entire tree.
I will still assert that the vast majority of engineers in a large
repository should not be doing work that has tree-wide implications
such as this.

I would still argue that the most efficient way for these engineers
to work would be to modify their component directly locally, relying
on project-specific tests that check their API boundary for expectations,
then rely on a distributed build system to verify their changes across
the tree. They can then pull in the component(s) that have failing tests
in order to re-run tests locally and verify the correct fix.
 
>> There's nothing Git can do to help those engineers that do cross-tree
>> work.
> 
> I'm going to partially disagree with this, in part because of our
> experience with many inter-module dependencies that evolve over time.
> Folks can start on a certain module and begin refactoring.  Being
> aware that their changes will affect other areas of the code, the can
> do a search (e.g. "git grep --cached ..." to find cases outside their
> current sparse checkout), and then selectively unsparsify to get the
> relevant few dozen (or maybe even few hundred) modules added.  They
> aren't switching to a dense checkout, just a less sparse one.  When
> they are done, they may narrow their sparse specification again.  We
> have a number of users doing cross-tree work who are using
> sparse-checkouts, and who find it productive and say it still speeds
> up their local build/test cycles.

This matches my expectation of how to engage selectively with
dependent components, where we expand the sparse-checkout selectively.
My only difference is that unless there is a breaking change to the
API boundary that this expansion happens reactively, not proactively.
(Expand to another project if it has failing tests due to changes to
the local components.)
 
> So, I'd say that ensuring Git supports behavior B well in
> sparse-checkouts, is something Git can do to help out both some of the
> engineers doing cross-tree work, and some of the engineers that are
> doing cross-tree testing.
> 
> (For full disclosure, we also have users doing cross-tree work using
> regular dense checkouts and I agree there's not a lot we can do to
> help them.)

Perhaps there are two different categories going on here:

 1. The engineer is building a component consumed by many others
    across the tree, but all edits are within that component.

 2. The engineer is editing code across many components across the
    tree.

>>> +  * Commands defaulting to --restrict-unless-conflicts
>>> +    * merge
>>> +    * rebase
>>> +    * cherry-pick
>>> +    * revert
>>
>> In my mind, --restrict-unless-conflicts doesn't provide any value unless
>> you want the --restrict mode to create an _error_ when trying to do
>> something outside of the sparse-checkout cone.
> 
> Are you assuming here I was suggesting command line flags?  If so, I
> apologize for my poor wording/descriptions.

Yes, I think that was my misunderstanding.

>> The only thing I can think about is that the diffstat might want to show
>> the stats for the conflicted files, in which case that's an important
>> perspective on the distinction from --restrict.
> 
> We only show the diffstat on a successful merge, so there's no
> diffstat to show if there are any conflicted files.

Thanks! TIL.

>>> +    * add
>>> +    * rm
>>> +    * mv
>>> +
>>> +    The defaults here perhaps make sense since they are nearly --restrict, but
>>> +    actually using --restrict could cause user confusion if users specify a
>>> +    specific filename, so they warn by default.  That logic may sound like
>>> +    --no-restrict should be the default, but that's prone to even bigger confusion:
>>> +      * `git add <somefile>` if honored and outside the sparse cone, can result in
>>> +     the file randomly disappearing later when some subsequent command is run
>>> +     (since various commands automatically clean up unmodified files outside
>>> +     the sparsity specification).
>>> +      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
>>> +     outside the range of the user's interest.  Much better to operate on the
>>> +     sparsity specification and give the user warnings if other files could have
>>> +     matched.
>>
>> The cost of checking for other files that might match is sometimes too large
>> (needing to expand the sparse index or walk trees to find those path names) that
>> I would not recommend warning that we _didn't_ do something. Perhaps an advice
>> that says "we did not look outside the sparse-checkout definition for matching
>> paths" when the pathspec is not an exact path or a prefix match.
> 
> Ah, good point, and a good idea to keep in mind.
> 
> However, I think advise_on_updating_sparse_paths() currently does what
> you're warning against.  Do you think there's a good chance this is
> the cause of the performance bug reported over at
> https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com
> ?

Perhaps. You're right that it is warning about all of the paths that
match. That method was created before the sparse index was established,
so 'git add' was already checking all of the paths in the index, so
adding the warning made sense as something not too difficult to do after
checking each of those paths.

In the sparse index world, things are much more expensive to do that
check, hence the work to add modes that focus the action only to the
paths in the sparse-checkout. In that world, we _may_ want to recognize
that the user ran 'git rm *.png' and we want to provide advice that
we didn't look for '*.png' files outside of the sparse-checkout definition.

This makes less sense for 'git add *.png' because it already would not do
anything for files outside of the sparse-checkout definition. 

>>> +  * Commands whose default for --restrict vs. --no-restrict should vary depending
>>> +    on Behavior A or Behavior B
>>> +    * diff (with --cached or REVISION arguments)
>>> +    * grep (with --cached or REVISION arguments)
>>> +    * show (when given commit arguments)
>>> +    * bisect
>>> +    * blame
>>> +      * and annotate
>>> +    * log
>>> +      * and variants: shortlog, gitk, show-branch, whatchanged
>>> +
>>> +    For now, we default to behavior B for these, which want a default of
>>> +    --no-restrict.
>>
>> I do feel pretty strongly that we'll want a --no-restrict default here
>> because otherwise we will present confusion. I'm not even sure if we would
>> want to make this available via a config setting, but likely a config
>> setting makes sense in the long term.
> 
> You've got me slightly confused.  You did say the same thing a long time ago:
> 
>     "But I also want to avoid doing this as a default or even behind a
> config setting."[A]
> 
> BUT, when Shaoxuan proposed making --restrict/--focus the default for
> one of these commands, you seemed to be on board[B].

I'm specifically talking about 'git log'. I think that having that be
in a restricted mode is extremely dangerous and will only confuse users.
This includes 'git show' (with commit arguments) and 'git bisect', I
think.

The rest, (diff, grep, blame) are worktree-focused, so having a restrict
mode by default makes sense to me.

> Personally, I thought that if anyone would object to some of these
> commands changing, that grep would be considered as among the riskier.
> For diff and log, printing a "Warning: restricting output to the
> sparse-checkout specification" would be pretty innocuous, but for grep
> that wouldn't be.

My main concern with 'git grep --cached' is its interaction with
partial clone. Perhaps a restrict mode for grep should be toggled with
partial clone and not sparse-checkout alone. But, that becomes more
confusing when the restrictions are applied or not.

> I was a little unsure about making `--restrict/--focus` the default
> for these commands, both based on your previous concerns and because
> of thinking about some of my behavior B users.  But then, it seemed
> like everyone else was pushing for not only having this behavior but
> making it the default[C,D,E,F].  I was beginning to wonder if even you
> had decided behavior B didn't matter anymore between your support of
> Shaoxuan's change at [B] and your diffstat comments at [G].  But now
> it sounds like you're not only against behavior A by default but even
> implementing it at all...even though I don't see how that squares with
> your previous comments on grep and diffstat.
> 
> Is it just a matter of presentation?  Is it specific subcommands you
> don't want changed?  Or am I either missing or misunderstanding
> something?

I think the biggest point is that the implications of behavior A
saying "I don't care about any changes outside of my sparse-checkout"
leading to changed history are unappealing to me. After removing that
kind of feature from consideration, I don't see any difference
between the behaviors.

> Anyway...I will note that without a configurable option to give these
> commands a behavior of `--restrict`, I think you make working in
> disconnected partial clones practically impossible.  I want to be able
> to do "git log -p", "git diff REV1 REV2", and "git grep TERM REV" in
> disconnected partial clones, and I've wanted that kind of capability
> for well over a decade[H].  So, don't be surprised if I keep bringing
> up a config option of some sort for these commands.  :-)

Now, if we're talking about "don't download extra objects" as a goal,
then we're thinking about things not just related to sparse-checkout
but even history within the sparse-checkout. Even if we make the
'backfill' command something that users could run, there isn't a
guarantee that users will want to have even that much data downloaded.
We would need a way to say "yes, I ran 'git blame' on this path in my
sparse-checkout, but please don't just fail if you can't get new objects,
instead inform me that the results are incomplete."

I think the sparse-checkout boundary is a good way to minimize the
number of objects downloaded by these commands, but to actually
remove the need for downloads at all we need a way to gracefully
return partial results.

>>> +  * clone: should we provide some mechanism for tying partial clones and
>>> +    sparse checkouts together better.  Maybe an option
>>> +     --sparse=dir1,dir2,...,dirN
>>> +    which:
>>> +       * Does initial fetch with `--filter=blob:none`
>>> +       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
>>> +       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
>>> +      fault in the missing blobs within the sparse
>>> +      specification...except that rev-list needs some kind of options
>>> +      to also get files from leading directories too.
>>> +       * Sets --restrict mode to allow focusing on the cone of interest
>>> +      (and to permit disconnected development)
>>
>> As mentioned, I think we should have the option to backfill the blobs in
>> the sparse-checkout definition, but 'git clone' should not do this by
>> default. It's something that can be launched in the background, maybe, but
>> not a blocking operation on being able to use the repository.
>>
>> 'scalar clone' is an excellent testing bed for these kinds of things,
>> like setting the --restrict mode by default.
> 
> Earlier in this same email you were against even making an option to
> request --restrict mode, but now you're suggesting to not only
> implement it but make it the default in scalar?

As I hope I've clarified earlier, there are some commands where I think
a --restrict mode is inadvisable, and turning it on by default is
dangerous. If we can configure the worktree commands to be restricted
by default and _not_ the history simplifyng ones, then that's what I
would want enabled in Scalar.
> I figured we'd have one or two places where all of us had some
> disagreements on the big picture, but more and more I'm finding we
> aren't even always thinking about the problems the same (e.g. the 3+
> different solutions to the `am` issues).  All the more reason that a
> document like this is important for us to discuss these details and
> work out a plan.

With such a massive doc and an ambitious plan, we are bound to have
misunderstandings and seem to self-contradict here and there. This
discussion is helping to drive clarity, and I appreciate all of your
work to drive towards mutual understanding.

Thanks,
-Stolee

