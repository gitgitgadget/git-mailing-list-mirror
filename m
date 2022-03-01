Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF7C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiCAPg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiCAPg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 10:36:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479EA996A
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 07:35:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g20so22519331edw.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 07:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dNiE+OfF18CEb7yubyBvZpeFfL0UhsVn+cKgVbrUvTI=;
        b=Coaq4djOa9MC2zG+R0wtzyqFtZPFPipmw4CS/jbhK9cZocNRLtaToBH72QLzqifPvJ
         Qu9fAWUzQBbuxnyM2dzflD4KBHhhKtw7M5rx4b3lbEm9zCDn016Wk0YpvhAZhXN93X2e
         g5HFCinr+Gbap2K3acQHX+uOlcGBQWo1MCBSwcPW0VQk1cq+4Y27ocQmzk4E2Cz1OHPR
         HE7P27PCEm5rVgz4LHGYVbmEErNtwTeE0QiQj0YCBMeRldzdrwPHIeL/Nzv5fxiLpUvw
         5GajoJ9Y1o9T9L0ibGGVSfoQS88F0Rv2/VtURHPlnT6TRYAH20/Jf5dpVTzgG7bHEWt9
         VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dNiE+OfF18CEb7yubyBvZpeFfL0UhsVn+cKgVbrUvTI=;
        b=vNG15P9mjYuVlVKSKquSeb0Sf3NTqnVl138ZxtOdAPylXwudxzpnWqanseqhUuQrfC
         SChOU15Xb4I+Vg4Nflg10IK6RQUynBj9YqhSatrraUPUZ2924c3g5asY9bS3FzuR9yUk
         k1L017ZyPFMiIBrofSfUJu2I9FBk7HpS5DjZ1atTKG4stW5phiuqyDOdIkgEuuQUvuRc
         xl8eFhovgZNxzbxu5MMXrfAueZxAJi8wmaduGbQRdEIRV72rgvLcHvQ6P3u+I8EzRH3w
         VAtAMrbtNWHENDrqKIgB2Tr19dPO4FDjDbFMK7oizILMLkoKxnzGmTagBk0ES0YaN8m5
         VkwQ==
X-Gm-Message-State: AOAM530f/RJLT5jjG0PcsyItqvZj67famJBwYZLuLv/6ncBjsHevLjCp
        3eDI0vU0sLll6LVc38OnriAnmBH5zO8=
X-Google-Smtp-Source: ABdhPJx+voTrwF79V5sFRrlx94sasaBpnDHCKNBmD8gNPUhrtbGOvqeOwD88fuLR7OrxQf1K1NQdfg==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id d25-20020a50fb19000000b00404eb5262cbmr24735601edq.363.1646148942081;
        Tue, 01 Mar 2022 07:35:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by10-20020a0564021b0a00b00412ddfc6d12sm7448353edb.0.2022.03.01.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:35:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nP4XM-002D17-ET;
        Tue, 01 Mar 2022 16:35:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Date:   Tue, 01 Mar 2022 15:29:10 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
 <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
 <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
 <220228.86ilsy3a8b.gmgdl@evledraar.gmail.com>
 <9b52fdd3-64fc-34b1-d4ee-660b4fb73f39@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9b52fdd3-64fc-34b1-d4ee-660b4fb73f39@github.com>
Message-ID: <220301.86y21tznw3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Derrick Stolee wrote:

> On 2/28/2022 4:14 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Feb 28 2022, Derrick Stolee wrote:
>>=20
>>> On 2/28/2022 9:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Mon, Feb 28 2022, Derrick Stolee wrote:
>>>>
>>>>> On 2/25/2022 5:31 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>>>>> Or maybe they won't. I just found it surprising when reviewing this =
to
>>>>>> not find an answer to why that approach wasn't
>>>>>> considered.
>>>>>
>>>>> The point is to create a new format that can be chosen when deployed
>>>>> in an environment where older Git versions will not exist (such as
>>>>> a Git server). The new version is not chosen by default and instead
>>>>> is opt-in through the commitGraph.generationVersion config option.
>>>>>
>>>>> Perhaps in a year or two we would consider making this the new
>>>>> default, but there is no rush to do so.
>>>>
>>>> Looking into this a bit more I think that in either case this is less =
of
>>>> a big deal after my 43d35618055 (commit-graph write: don't die if the
>>>> existing graph is corrupt, 2019-03-25), which came out of some of those
>>>> discussions at the time of [1].
>>>>
>>>> I.e. now a client that only understands version N-1 will warn when
>>>> loading it, wheras it's only if a pre-v2.22.0 client (which has that
>>>> commit) reads the repository that we'd hard die on it, correct?
>>>>
>>>> But speaking of hyper-focus. I think that arguably applies to you in
>>>> this case when considering the trade-offs of these sorts of format
>>>> changes :)
>>>>
>>>> I.e. you're primarily considering cases of say a git server (presumably
>>>> running on GitHub) or another such deployment where it's easy to have
>>>> full control over all of your versions "in the wild".
>>>
>>> I'm thinking of servers, yes, but also 99% of clients who only upgrade
>>> (or _maybe_ downgrade to a recent, previous version occasionally).
>>=20
>> *nod*
>>=20
>>>> And thus a three-phase rollout of something like a format change can be
>>>> done in a timely and predictable manner.
>>>>
>>>> But git is used by *a lot* of people in a bunch of different
>>>> scenarios. E.g.:
>>>>
>>>>  * A shared (hopefully read-only) NFS mounted by remote "unmanaged" cl=
ients.
>>>>  * A tarred-up directory including a .git, which may be transferred to
>>>>    a machine with a pre-v2.22.0 version.
>>>>
>>>> Or even softer cases of failure, such as:
>>>>
>>>>  * A cronjob causes an alert/incident somewhere because the server=20
>>>>    operator started writing a new version, but forgot about a set
>>>>    of machines that are still on the old version.
>>>
>>> It is important to continue supporting these cases, and this change does
>>> not cause any issues for them.
>>=20
>> The issues in those cases will range from warnings on older versions
>> when loading the graph to errors if it's pre-v2.22.0, with the
>> performance benefits v3 placing them out of range of v2-only clients.
>>=20
>> I think arguable that's OK/worth it, but it's "not [any] issues", no?
>
> What I mean is that this change does not enable the new graph version
> by default, so these users do not have any issues unless someone opts
> in to the feature while in this mixed scenario.

Indeed. FWIW I wasn't confused about that bit. I'm just commenting on
/how/ we do version upgrades, and if we can save users unnecessary
hassle relatively easily.

But I also think the writing is on the wall that you'll want to
(understandably) bump the default sooner than later, or if not for this
data for other future chunks.

>>> However, this handful of corner cases should not block progress in the
>>> main cases.
>>=20
>> What progress would be blocked?
>>=20
>> I'm only talking about whether we choose to consider a "new graph" to be=
 an:
>>=20
>>     <existing version number>
>>     <existing chunk name (old content, possibly empty)>
>>     <new chunk name (new content)>
>>=20
>> v.s.:
>>=20
>>     <old/new version number>
>>     <existing chunk name old/new (incompatible) content>
>>=20
>> I.e. the "progress" this series is about is in getting the data locality
>> with smaller data with the new content.
>>=20
>> But that's also possible to get with a very low amount of fixed-overhead.
>>=20
>> Per the referenced E-Mail an "empty" commit-graph file was ~1k bytes in
>> 2019, I haven't re-checked. In terms of wasted space it's miniscule &
>> <1/4 of one FS page on Linux.
>
> If you're talking "empty" data, then you need to have an empty Commit
> Data chunk _and_ and empty OID Lookup chunk in order to not have
> breakage. So you'd need duplicate versions of these chunks for the
> new "Commit Data 2" chunk. Then we need special-casing for all of this
> during parsing that is unnecessary complexity.

Why does it need to be special-cased? Don't we just call pair_chunk() on
the new chunk name, and if it doesn't exist fall back on the old
chunk. We'll then note what format we're parsing, just as this series
does.

> Finally, the end result becomes "older versions get slower without
> any warning" instead of "older versions get a message about not
> understanding the commit-graph file".

Sure, IF you want to write such an empty chunk. The point is that you
now have the option.

And this is the same edge case we already dealt with for
GDAT/GDOV. I.e. older readers who didn't understand it would be slower.

We can still have a feature to make older clients intentionally
break/warn, it seems to me that if you'd want such a thing you'd want it
aside from the specific mechanism of this proposed upgrade.

Or you could dual-write the data for older clients, which I think
probably isn't worth the hassle.

I.e. if you're worried about silent slowdown older clients happily
ignoring the BIDX and BDAT chunks are silently slower.

>> I'm not just trying to rehash the same points, I *think* the version
>> bump is just an aesthetic choice & we're not getting any performance
>> difference out of that.
>>=20
>> But I'm not sure from the "block progress" etc., so maybe I'm still
>> missing something...
>
> The fact that we have a Generation Data chunk instead of already
> bumping the file format version number is already a concession to
> this concern about backwards compatibility.

Sure, but not taking that version bumping route in the past shouldn't
bias us towards doing it now, should it?

> With the point above about empty Commit Data Chunks, the only way
> to properly conserve backwards compatibility is to have a full
> Commit Data Chunk as well as a second copy that contains the new
> offsets instead of topological levels. This is wasteful.

Empty chunks would be a handful of bytes, and not produce those
errors/warnings, and AFAICT without any downsides.

But that's me assuming that the overlap between people for whom the
commit-graph is critical for performance and those using wildly
different versions is pretty much zero.

The reason I mentioned it at all initially in
https://lore.kernel.org/git/220228.86pmn73toq.gmgdl@evledraar.gmail.com/
was in reference to trying to understand the context of the performance
gains, i.e. whether they'd be equivalent with a new chunk or dual-write
data.

>>>> I think that even if it's less conceptually clean it's worth consideri=
ng
>>>> being over backwards to be kinder to such use-cases, unless it's really
>>>> required for other reasons to break such in-the-wild use-cases.
>>>>
>>>> Or in this case, if it's thought to be worth it to help reviewers deci=
de
>>>> by separating the performance improvement aspect from the changed
>>>> interaction between new graphs and older clients.
>>>>
>>>> As a further nit on the proposed end-state here: Do I understand it
>>>> correctly that commitGraph.generationVersion=3D[1|2] (i.e. on current
>>>> "master") will always result in a file that's compatible with older
>>>> versions, since the only thing "v2" there controls now is to write the
>>>> optional GDAT and GDOV chunks?
>>>>
>>>> Whereas going from commitGraph.generationVersion=3D2 to
>>>> commitGraph.generationVersion=3D3 in this series will impact older cli=
ents
>>>> as noted above, since we're bumping the version (of the file, to 2 if
>>>> the config is 3, which as Junio noted is a bit confusing).
>>>>
>>>> I think if you're set on going down the path of bumping the top-level
>>>> version that deserves to be made much clearer in the added
>>>> documentation. Right now the only hint to that is a passing mention th=
at
>>>> for v3:
>>>>
>>>>     [it] will be incompatible with some old versions of Git
>>>>
>>>> Which if we're opting for breaking format changes really should note
>>>> some of the caveats above, that pre-v2.22.0 hard-dies, and probably
>>>> describe "some old versions of Git" a bit more clearly.
>>>>
>>>> It actually means once this gets released "the git version that was the
>>>> latest one you could download yesterday". Which a reader of the docs
>>>> probably won't expect when starting to play with this in mixed-version
>>>> environment.
>>>>
>>>> 1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/
>>>
>>> This documentation could be altered to be specific about versions,
>>> but such a specific change makes assumptions of the version that will
>>> include it. As of now, the generation number v2 fixes will _probably_
>>> get in for 2.36 and the format change would have enough time to cook
>>> for 2.37, so I'll update the docs to refer to that version explicitly.
>>=20
>> ...
>>=20
>>> The pre-2.22.0 change might be helpful to mention, but it could also be
>>> noise to the reader. We can revisit this when these patches are
>>> submitted again in another thread. There's also concern about third-
>>> party tools like libgit2. I'd rather draw the line as "tread carefully
>>> here" than "here is so much information that a reader might think it
>>> is all they need to know".
>>=20
>> In terms of concern about libgit2 or any other implementation (which I
>> haven't looked at) isn't "tread carefully" to do it with new chunks if
>> possible, which we've done before with BIDX/BDAT, v.s. a version bump we
>> haven't done?
>
> New chunks adding new information is part of the design. Changing
> the location of existing data is new here.

We've never bumped the top-level version number, and hard dying on "git
status" or whatever was also part of the initial design :)

I think it's legitimate to ask/argue that these version number bumps are
something we should be reserving for truly incompatible format bumps,
v.s. "new indexes".

I.e. this case is similar to us having a SQL database with N tables, and
we'd like to add a new table or index.

We could have a central "schema_version", or we could just add a new
table in a backwards-compatiable way. Older clients read older
data/tables, which is possibly empty.

The commit-graph is essentially such a key-value store when it comes to
top-level chunks, and we're already making decisions on what data to
load/use based on chunk existence.

>> I'd think it wouldn't be an issue either way for any reader of the
>> format, and libgit2 is more specialized & won't have someone on RHEL6 or
>> whatever trying to inspect a random repo.
>>=20
>> It just seems like a win-win to have a performance improvement with
>> smooth backwards compatibility v.s. without, if that's possible.
>
> You are right that it is _possible_, but I don't think that the
> side-effects are worth it. Those being:
>
> * "Empty CDAT Chunk": Silently slowing down older clients.
> * "Duplicate CDAT Chunk": Wasted data.
>
> Finally, I want to reiterate that by making this opt-in, users make
> the call about whether or not they are in a scenario where this
> compatibility issue is appropriate for them. This includes waiting
> to see if third-party tools like libgit2 are updated to understand
> this version.

I think we're probably not getting any further here & this back & forth,
it's certainly been interesting, and thanks a lot for your patience and
time.

I'll try to look at some of this once the "prep" patches land.

If you'll end up doing this via the version route I'm not going to
strongly object to it or anything, I was just trying to review this to
see if I understood the trade-offs & constraints involved. In particular
with reference to those changes in 2019 that I did to make
format/corruption/version transitions non-fatal.

Thanks!
