Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F0C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiB1WUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiB1WUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:20:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93DB0C
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:19:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h15so19584882edv.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KFC7X1+fuD3jyTNT/fwTzIMLxqoSnWdJH/ck+3Rp0CA=;
        b=X43EtquSx1AC4zT4qEHohoXj4tiNg4dKi/D5HUYbgr1kf9oErDwmcQ6SVFQbkCKGye
         WYHUDNMU/vWkYp+Mfa9CnTHA2x4ujnoXNF7sP7JyYkmleSWS0V9Qc+OZhnZRf+qXs045
         GbMUmMYnqIoFMXx8cJRrPgpygZJw80Z2gIpqCQpDKkmdIvOOjNHrZu67TOaO923pTbJj
         BsHBZ0HLoPmnsfbJucGak8HQv6b5J0DNOTSJNbIsOMMn3ssc3QQGiWbR3eQozav/gmwK
         TiFEwR6sbGuplkXkD1Semu4RtDw8rVDkK6488zyxgLae/qNrovAyyW8c7ic5+FL8GEoo
         JMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KFC7X1+fuD3jyTNT/fwTzIMLxqoSnWdJH/ck+3Rp0CA=;
        b=i7Sc266IUwGnff1IjTimdLHfsVvTJn4DImhrjN9cvWag57go/0HTMXw/Tvr5NyiJtZ
         EwxI1agGD6d4kT2xytce96sMLGVDf5AyM2AW2U/FLxbsFL+BdIc4iXrRZoaPSQSJm6Pf
         Rmb8z27PyBHKFs0ZybjnkoQnvLFxgAOq7uAroLC/QkuoyNmdftiMR+if6VYEH6hVN6xd
         FvKTJM7qYrtKqu2QJnZxMBb3UqOElKO+um9pf5n7Cxb1TRigdWr9i4CYZDfG9WgR6rGw
         egdPWkGtzaov6kgeJpgad4C3Hxdj1jplmX94E7XjI512FhihsPY6B8Ae4rWtTzHC0gJY
         PRKQ==
X-Gm-Message-State: AOAM532PQ7vpzUb0L6JxMpd3GQAbIG7DdsLV1B6/7dZnmh5j4XNseLwl
        HH/X1UbamL/u5zfli1P3LE8=
X-Google-Smtp-Source: ABdhPJwcuCBAYwJhMgpmxP0QL7fgMkZya0bVr9k9GWRDWbq5d7tSAkyLpZUceMvgiqkyDNlz7DoaJw==
X-Received: by 2002:a05:6402:2318:b0:413:7645:fa51 with SMTP id l24-20020a056402231800b004137645fa51mr16526371eda.201.1646086773434;
        Mon, 28 Feb 2022 14:19:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id me14-20020a170906aece00b006d6e43b3cb1sm134630ejb.44.2022.02.28.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:19:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOoMe-001cE1-1x;
        Mon, 28 Feb 2022 23:19:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Date:   Mon, 28 Feb 2022 22:14:16 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
 <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
 <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e74d72bc-b6f5-2e1c-63d1-d3a580f3dc11@github.com>
Message-ID: <220228.86ilsy3a8b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee wrote:

> On 2/28/2022 9:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Feb 28 2022, Derrick Stolee wrote:
>>=20
>>> On 2/25/2022 5:31 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>>> Or maybe they won't. I just found it surprising when reviewing this to
>>>> not find an answer to why that approach wasn't
>>>> considered.
>>>
>>> The point is to create a new format that can be chosen when deployed
>>> in an environment where older Git versions will not exist (such as
>>> a Git server). The new version is not chosen by default and instead
>>> is opt-in through the commitGraph.generationVersion config option.
>>>
>>> Perhaps in a year or two we would consider making this the new
>>> default, but there is no rush to do so.
>>=20
>> Looking into this a bit more I think that in either case this is less of
>> a big deal after my 43d35618055 (commit-graph write: don't die if the
>> existing graph is corrupt, 2019-03-25), which came out of some of those
>> discussions at the time of [1].
>>=20
>> I.e. now a client that only understands version N-1 will warn when
>> loading it, wheras it's only if a pre-v2.22.0 client (which has that
>> commit) reads the repository that we'd hard die on it, correct?
>>=20
>> But speaking of hyper-focus. I think that arguably applies to you in
>> this case when considering the trade-offs of these sorts of format
>> changes :)
>>=20
>> I.e. you're primarily considering cases of say a git server (presumably
>> running on GitHub) or another such deployment where it's easy to have
>> full control over all of your versions "in the wild".
>
> I'm thinking of servers, yes, but also 99% of clients who only upgrade
> (or _maybe_ downgrade to a recent, previous version occasionally).

*nod*

>> And thus a three-phase rollout of something like a format change can be
>> done in a timely and predictable manner.
>>=20
>> But git is used by *a lot* of people in a bunch of different
>> scenarios. E.g.:
>>=20
>>  * A shared (hopefully read-only) NFS mounted by remote "unmanaged" clie=
nts.
>>  * A tarred-up directory including a .git, which may be transferred to
>>    a machine with a pre-v2.22.0 version.
>>=20
>> Or even softer cases of failure, such as:
>>=20
>>  * A cronjob causes an alert/incident somewhere because the server=20
>>    operator started writing a new version, but forgot about a set
>>    of machines that are still on the old version.
>
> It is important to continue supporting these cases, and this change does
> not cause any issues for them.

The issues in those cases will range from warnings on older versions
when loading the graph to errors if it's pre-v2.22.0, with the
performance benefits v3 placing them out of range of v2-only clients.

I think arguable that's OK/worth it, but it's "not [any] issues", no?

> However, this handful of corner cases should not block progress in the
> main cases.

What progress would be blocked?

I'm only talking about whether we choose to consider a "new graph" to be an:

    <existing version number>
    <existing chunk name (old content, possibly empty)>
    <new chunk name (new content)>

v.s.:

    <old/new version number>
    <existing chunk name old/new (incompatible) content>

I.e. the "progress" this series is about is in getting the data locality
with smaller data with the new content.

But that's also possible to get with a very low amount of fixed-overhead.

Per the referenced E-Mail an "empty" commit-graph file was ~1k bytes in
2019, I haven't re-checked. In terms of wasted space it's miniscule &
<1/4 of one FS page on Linux.

I'm not just trying to rehash the same points, I *think* the version
bump is just an aesthetic choice & we're not getting any performance
difference out of that.

But I'm not sure from the "block progress" etc., so maybe I'm still
missing something...

>> I think that even if it's less conceptually clean it's worth considering
>> being over backwards to be kinder to such use-cases, unless it's really
>> required for other reasons to break such in-the-wild use-cases.
>>=20
>> Or in this case, if it's thought to be worth it to help reviewers decide
>> by separating the performance improvement aspect from the changed
>> interaction between new graphs and older clients.
>>=20
>> As a further nit on the proposed end-state here: Do I understand it
>> correctly that commitGraph.generationVersion=3D[1|2] (i.e. on current
>> "master") will always result in a file that's compatible with older
>> versions, since the only thing "v2" there controls now is to write the
>> optional GDAT and GDOV chunks?
>>=20
>> Whereas going from commitGraph.generationVersion=3D2 to
>> commitGraph.generationVersion=3D3 in this series will impact older clien=
ts
>> as noted above, since we're bumping the version (of the file, to 2 if
>> the config is 3, which as Junio noted is a bit confusing).
>>=20
>> I think if you're set on going down the path of bumping the top-level
>> version that deserves to be made much clearer in the added
>> documentation. Right now the only hint to that is a passing mention that
>> for v3:
>>=20
>>     [it] will be incompatible with some old versions of Git
>>=20
>> Which if we're opting for breaking format changes really should note
>> some of the caveats above, that pre-v2.22.0 hard-dies, and probably
>> describe "some old versions of Git" a bit more clearly.
>>=20
>> It actually means once this gets released "the git version that was the
>> latest one you could download yesterday". Which a reader of the docs
>> probably won't expect when starting to play with this in mixed-version
>> environment.
>>=20
>> 1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/
>
> This documentation could be altered to be specific about versions,
> but such a specific change makes assumptions of the version that will
> include it. As of now, the generation number v2 fixes will _probably_
> get in for 2.36 and the format change would have enough time to cook
> for 2.37, so I'll update the docs to refer to that version explicitly.

...

> The pre-2.22.0 change might be helpful to mention, but it could also be
> noise to the reader. We can revisit this when these patches are
> submitted again in another thread. There's also concern about third-
> party tools like libgit2. I'd rather draw the line as "tread carefully
> here" than "here is so much information that a reader might think it
> is all they need to know".

In terms of concern about libgit2 or any other implementation (which I
haven't looked at) isn't "tread carefully" to do it with new chunks if
possible, which we've done before with BIDX/BDAT, v.s. a version bump we
haven't done?

I'd think it wouldn't be an issue either way for any reader of the
format, and libgit2 is more specialized & won't have someone on RHEL6 or
whatever trying to inspect a random repo.

It just seems like a win-win to have a performance improvement with
smooth backwards compatibility v.s. without, if that's possible.
