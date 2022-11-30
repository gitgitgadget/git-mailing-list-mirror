Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D5C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 15:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiK3PRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiK3PQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 10:16:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1145B5D6A0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:16:55 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z131so1891888iof.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4q1uiPOucdNBNAhoMPq55u3royefdyb4te/RvkO6+8=;
        b=WgrJiHgjgsrSRUsuZoQU1J+b4ezUHXQmNLz8lcwbQ21LMnw3e1OldM81fsmpAgapiz
         cz8uN9WWHRAFhaibnamXfytHOZkkpvNQ1KfZojwLq6VE3nWrzPa942p7XFGrL0DCv4bi
         rufyEBpnp4dsYyWbUHw9JqQQvZ0g8TbXF2x5SFvqPFytX2cIPqOGEPiJ+NKU8gRzgo7M
         A5TUIHQdxPbRMIv/OaLHmtr++CTe+jZYtywIZaWCbNn9AeyTND/9zdOAnMeuPpTWc6Nc
         RjgkFZSeM0cu17u2mZeFj0KSkQvm1foXhnKkHKtQ1LkQCfNVLVQVueoQ+8z/wVs5dVwp
         eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4q1uiPOucdNBNAhoMPq55u3royefdyb4te/RvkO6+8=;
        b=sRMgGgOelbr31UJ964hK/yf+2+aYVLoDbpt5P3tcwpws3eQ4cHZZR/o0C1KeRadAoq
         d3IYzAtzcOSVzDeWEuavlTE+xxVBu/mbs31mGkhRXjWqoOhHU+iw48EAnzjhrqndlTaZ
         SJDqvt27OLsuBpc1tFgyKdzniB7CHQKrh36wLCw25J94FGLVmq0AhphDACJ05JKyYw5S
         /BX2uUYK0hDJQEa6sb3AlLnmFGBhlvsRd6IB3oT7cASUdVw09kIl6vYCqwF/6I/7N+S2
         WoDlDsay3StZsy6LKJDq4dZk4tWgg+QWcDLZ/GHPNqypM9NaHwscn6qQvwz5eBBVbdfd
         riiw==
X-Gm-Message-State: ANoB5pm24akUBPChhdmzkU/cY0FckgbFSf8ZGVE+mjd0XOw5xtBlnc+3
        KiV+hwVO5WK1T3y7nNZEkQqp
X-Google-Smtp-Source: AA0mqf6hb649Y6rJeg6MW5b4tqdEew0x6t1XDcqMjiPXm5sbILZ/VNhv8JbTSjmxng7CfTTpyBTWhQ==
X-Received: by 2002:a5d:88c3:0:b0:6d6:5fe4:8212 with SMTP id i3-20020a5d88c3000000b006d65fe48212mr29203763iol.180.1669821414071;
        Wed, 30 Nov 2022 07:16:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2d9d:31ee:c3ec:e9a5? ([2600:1700:e72:80a0:2d9d:31ee:c3ec:e9a5])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e0204c100b00300c4b978c9sm620356ils.29.2022.11.30.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:16:53 -0800 (PST)
Message-ID: <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
Date:   Wed, 30 Nov 2022 10:16:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Content-Language: en-US
To:     Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 1:56 PM, Han-Wen Nienhuys wrote:

Han-Wen,

Thanks for taking the time to reply. I was specifically hoping for your
perspective on the ideas here.

> On Mon, Nov 7, 2022 at 7:36 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> After carefully considering several options, it seemed that there are two
>> solutions that can solve this effectively:
>>
>>  1. Wait for reftable to be integrated into Git.
>>  2. Update the packed-refs backend to have a stacked version.
>>
>> The reftable work seems currently dormant. The format is pretty complicated
>> and I have a difficult time seeing a way forward for it to be fully
>> integrated into Git.
>
> The format is somewhat complicated, and I think it would have been
> possible to design a block-oriented sorted-table approach that is
> simpler, but the JGit implementation has set it in stone.

I agree that if we pursue reftable, that we should use the format as
agreed upon and implemented in JGit. I do want to say that while I admire
JGit's dedication to being compatible with repositories created by Git, I
don't think the reverse is a goal of the Git project.

> But, to put
> this in perspective, the amount of work for getting the format to
> read/write correctly has been completely dwarfed by the effort needed
> to make the refs API in git represent a true abstraction boundary.
> Also, if you're introducing a new format, one might as well try to
> optimize it a bit.

That's another reason why I was able to make an incremental improvement so
quickly in this RFC: I worked within the existing API, reducing the
overall impact of the change. It's easier to evaluate the performance
difference of packed-refs v2 versus packed-refs v1 because the change is
isolated.

That work to make the Git refs API work with the reftable library is
further ahead than I though (in your draft PR) but it is also completely
missing from the current Git tree, so that work still needs to be arranged
into a reviewable series before it is available to us. That does seem like
a substantial amount of work, but I might have been overestimating how
much work it will be compared to these changes I am advocating for.

> Here are some of the hard problems that I encountered

Thanks for including these.

> * Worktrees and the main repository have a separate view of the ref
> namespace. This is not explicit in the ref backend API, and there is a
> technical limitation that the packed-refs file cannot be in a
> worktree. This means that worktrees will always continue to use
> loose-ref storage if you only extend the packed-refs backend.

If I'm understanding it correctly [1], only the special refs (like HEAD or
REBASE_HEAD) are worktree-specific, and all refs under "refs/*" are
repository-scoped. I don't actually think of those special refs as "loose"
refs and thus they should still work under the "only packed-refs" value
for extensions.refFormat. I should definitely cover this in the
documentation, though. Also, [1] probably needs updating because it calls
HEAD a pseudo ref even though it explicitly is not [2].

[1] https://git-scm.com/docs/git-worktree#_refs
[2] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpseudorefapseudoref

> * Symrefs are refs too, but for some reason the packed-refs file
> doesn't support them. Does packed-refs v2 support symrefs too?  If you
> want to snapshot the state of refs, do you want to snapshot the value
> of HEAD too?

I forgot that loose refs under .git/refs/ can be symrefs. This definitely
is a limitation that I should mention. Again, pseudorefs like HEAD are not
included and are stored separately, but symrefs within refs/* are not
available in packed-refs (v1 or v2). That should be explicitly called out
in the extensions.refFormat docs.

I imagine that such symrefs are uncommon, and users can make their own
evaluation of whether that use is worth keeping loose refs or not. We can
still have the {files, packed[-v2]} extension value while having a
writing strategy that writes as much as possible into the packed layer.

> * By not changing reflogs, you are making things simpler. (if a
> transaction updates the branch that HEAD points to, the reflog for
> HEAD has to be updated too. Because reftable updates the reflog
> transactionally, this was some extra work)
> Then again, I feel the current way that reflogs work are a bit messy,
> because directory/file conflicts force reflogs to be deleted at times
> that don't make sense from a user-perspective.

I agree that reflogs are messy. I also think that reflogs have different
needs than the ref storage, so separating their needs is valuable.

> * There are a lot of commands that store SHA1s in files under .git/,
> and access them as if they are a ref (for example: rebase-apply/ ,
> CHERRY_PICK_HEAD etc.).

Yes, I think these pseudorefs are stored differently from usual refs, and
hence the {packed[-v2]} extension value would still work, but I'll confirm
this with more testing.

>> In this RFC, I propose a different model that allows for more customization
>> and incremental updates. The extensions.refFormat config key is multi-valued
>> and defaults to the list of files and packed. In the context of this RFC,
>> the intention is to be able to add packed-v2 so the list of all three values
>> would allow Git to write and read either file format version (v1 or v2). In
>> the larger scheme, the extension could allow restricting to only loose refs
>> (just files) or only packed-refs (just packed) or even later when reftable
>> is complete, files and reftable could mean that loose refs are the primary
>> ref storage, but the reftable format serves as a drop-in replacement for the
>> packed-refs file. Not all combinations need to be understood by Git, but
>
> I'm not sure how feasible this is. reftable also holds reflog data. A
> setting {files,reftable} would either not work, or necessitate hairy
> merging of data to get the reflogs working correctly.

In this setup, would it be possible to continue using the "loose reflog"
format while using reftable as the packed layer? I personally think this
combination of formats to be critical to upgrading existing repositories
to reftable.

(Note: there is a strategy that doesn't need this approach, but it's a bit
complicated. It would involve rotating all replicas to new repositories
that are configured to use reftable upon creation, getting the refs from
other replicas via fetches. In my opinion, this is prohibitively
expensive.)

>> Between using raw OIDs and storing the depth-2 prefixes only once, this
>> format compresses the file to ~60% of its v1 size. (The format allows not
>> writing the prefix chunks, and the prefix chunks are implemented after the
>> basics of the ref chunks are complete.)
>>
>> The write times are reduced in a similar fraction to the size difference.
>> Reads are sped up somewhat, and we have the potential to do a ref count by
>
> Do you mean 'enumerate refs' ? Why would you want to count refs by prefix?

Generally, I mean these kind of operations:

* 'git for-each-ref' enumerates all refs within a prefix.

* Serving the ref advertisement enumerates all refs.

* There was a GitHub feature that counted refs and tags, but wanted to
  ignore internal ref prefixes (outside of refs/heads/* or refs/tags/*).
  It turns out that we didn't actually need the full count but an
  existence indicator, but it would be helpful to quickly identify how
  many branches or tags are in a repository at a glance. Packed-refs v1
  requires scanning the whole file while packed-refs v2 does a fixed
  number of binary searches followed by a subtraction of row indexes.

>> I mentioned earlier that I had considered using reftable as a way to achieve
>> the stated goals. With the current state of that work, I'm not confident
>> that it is the right approach here.
>>
>> My main worry is that the reftable is more complicated than we need for a
>> typical Git repository that is based on a typical filesystem. This makes
>> testing the format very critical, and we seem to not be near reaching that
>> approach.
>
> I think the base code of reading and writing the reftable format is
> exercised quite exhaustively tested in unit tests. You say 'seem', but
> do you have anything concrete to say?

Our test suite is focused on integration tests at the command level. While
unit tests are helpful, I'm not sure if all of the corner cases would be
covered by tests that check Git commands only.

>> As mentioned, the current extension plan [6] only allows reftable or files
>> and does not allow for a mix of both. This RFC introduces the possibility
>> that both could co-exist. Using that multi-valued approach means that I'm
>> able to test the v2 packed-refs file format almost as well as the v1 file
>> format within this RFC. (More tests need to be added that are specific to
>> this format, but I'm waiting for confirmation that this is an acceptable
>> direction.) At the very least, this multi-valued approach could be used as a
>> way to allow using the reftable format as a drop-in replacement for the
>> packed-refs file, as well as upgrading an existing repo to use reftable.
>
> The multi-value approach creates more combinations of code of how
> different pieces of code can interact, so I think it actually makes it
> more error-prone.

As multiple values are added, it will be important to indicate which
values are not compatible with each other. However, the plan for the
packed-refs improvements do add values that are orthogonal to each other.
It does make testing all combinations more difficult.

Of course, if reftable is truly incompatible with loose refs, then Git can
say that {reftable} is the only set of values that can use reftable, and
make {files, reftable} an incompatible set (which could be understood by
a later version of Git, if those barriers are overcome). However, if we do
not specify the extension as multi-valued from the start, then we cannot
later add this multi-valued option without changing the extension name.

>> That might even help the integration process to allow the reftable format to
>> be tested at least by some subset of tests instead of waiting for a full
>> test suite update.
>
> I don't understand this comment. In the current state,
> https://github.com/git/git/pull/1215 already passes 922 of the 968
> test files if you set GIT_TEST_REFTABLE=1.
>
> See https://github.com/git/git/pull/1215#issuecomment-1329579459 for
> details. As you can see, for most test files, it's just a few
> individual test cases that fail.

My point is that to get those remaining tests passing requires a
significant update to the test suite. I imagined that the complexity of
that update was the blocker to completing the reftable work.

It seems that my estimation of that complexity was overly high compared to
what you appear to be describing.

>> I'm interested to hear from people more involved in the reftable work to see
>> the status of that project and how it matches or differs from my
>> perspective.
>
> Overall, I found that the loose/packed ref code hard to understand and
> full of arbitrary limitations (dir/file conflicts, deleting reflogs
> when branches are deleted, locking across loose/packed refs etc.).
> The way reftable stacks are setup (with both reflog and ref data
> including symrefs in the same file) make it much easier to verify that
> it behaves transactionally.

I believe you that starting with a new data model makes many of these
things easier to reason with.

> For deleting refs quickly, it seems that you only need to support
> $ZEROID in packed-refs and then implement a ref database as a stack of
> packed-ref files? If you're going for minimal effort and minimal
> disruption wouldn't that be the place to start?

I disagree that jumping straight to stacked packed-refs is minimal effort
or minimal disruption.

Creating the stack approach does require changing the semantics of the
packed-refs format to include $ZEROID, which will modify some meanings in
the iteration code. The use of a stack, as well as how layers are combined
during a ref write or also during maintenance, adds complications to the
locking semantics that are decently complicated.

By contrast, the v2 format is isolated to the on-disk format. None of the
writing or reading semantics are changed in terms of which files to look
at or write in which order. Instead, it's relatively simple to see from
the format exactly how it reduces the file size but otherwise has exactly
the same read/write behavior. In fact, since the refs and OIDs are all
located in the same chunk in a similar order to the v1 file, we can even
deduce that page cache semantics will only improve in the new format.

The reason to start with this step is that the benefits and risks are
clearly understood, which can motivate us to establish the mechanism for
changing the ref format by defining the extension.

> You're concerned about the reftable file format (and maybe rightly
> so), but if you're changing the file format anyway and you're not
> picking reftable, why not create a block-based, indexed format that
> can support storing reflog entries at some point in the future too,
> rather than build on (the limitations) of packed-refs?

My personal feeling is that storing ref tips and storing the history of a
ref are sufficiently different problems that should have their own data
structures. Even if they could be combined by a common format, I don't
think it is safe to transition every part of every ref operation to a new
format all at once.

Looking at reftable from the perspective of a hosting provider, I'm very
hesitant to recommend transitioning to it because of how it is an "all or
nothing" switch. It does not fit with my expectations for safe deployment
practices.

Yes, packed-refs have some limitations, but those limitations are known
and we are working within them right now. I'd rather make a change to
write smaller versions of the file with the same semantics as a first
step.

> Or is
> packed-refs v2 backward compatible with v1 (could an old git client
> read v2 files? I think not, right?).

No, it is not backward compatible. That's why the extension is needed.

> The reftable project has gotten into a slump because my work
> responsibilities have increased over the last 1.5 year squeezing down
> how much time I have for 'fun' projects. I chatted with John Cai, who
> was trying to staff this project out of Gitlab resources. I don't know
> where that stands, though.

I'll have my EM reach out to John to see where that stands to see how we
can coordinate in this space.

>> The one thing I can say is that if the reftable work had not already begun,
>> then this is RFC is how I would have approached a new ref format.
>>
>> I look forward to your feedback!
>
> Hope this helps.

It does help clarify where the reftable project currently stands as well
as some key limitations of the packed-refs format. You've given me a lot
to think about so I'll do some poking around in your branch (and do some
performance tests) to see what I can make of it.

Let me attempt to summarize my understanding, now that you've added
clarity:

* The reftable work needs its refs backend implemented, but your draft PR
  has a prototype of this and some basic test suite integration. There are
  54 test files that have one or more failing tests, and likely these just
  need to be adjusted to not care about loose references.

* The reftable is currently fundamentally different enough that it could
  not be used as a replacement for the packed-refs file underneath loose
  refs (primarily due to its integration with the reflog). Doing so would
  require significant work on top of your prototype.

* This further indicates that moving to reftable is an "all or nothing"
  transition, and even requires starting a repository from scratch with
  reftable enabled. This is a bit of a blocker for a hosting provider to
  transition to the format, and will likely be difficult for clients to
  adopt the feature.

* The plan established by this RFC does _not_ block reftable progress, but
  generally we prefer not having competing formats in Git, so it would be
  better to have only one, unless there is enough of a justification to
  have different formats for different use cases.

I'm going to take the following actions on my end to better understand the
situation:

1. I'll take your draft PR branch and do some performance evaluations on
   the speed of ref updates compared to loose refs and my prototype of a
   two-stack packed-ref where the second layer of the stack is only for
   deleted refs.

2. I'll consult with my peers to determine how expensive it would be to
   roll out reftable via a complete replacement of our hosted
   repositories. I'll also try to discover ways to roll out the feature to
   subsets of the fleet to create a safe deployment strategy.

3. My EM and I will reach out to John Cai to learn about plans to push
   reftable over the finish line.

4. I will split out the "skip_hash" part of this RFC into its own series,
   after adding the necessary details to fsck to understand a null
   trailing hash.

Please let me know if I'm missing anything I should be investigating here.

Thanks,
-Stolee
