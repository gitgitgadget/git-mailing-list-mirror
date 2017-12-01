Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4CE20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 01:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbdLAB2I (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 20:28:08 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46597 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdLAB2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 20:28:07 -0500
Received: by mail-wr0-f178.google.com with SMTP id x49so8448706wrb.13
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bGSc0hN3LdgcrXUTWOleIoT1ObFiRtIv2QusKpCNstM=;
        b=XoF6Q9hYMYImN6yhM+8tB4jdz29j1tKf39KYAaDBOTjkyVV8/CpYHlu0Ucsy62pOKp
         SAyx1dm6eBFCllpG9Y/MxxY0wRTyf0IV04HxpZxfLstFj3JEZTp1h5dLg8Xvian9uRYI
         CU9EV9TryXqMLo0qkhGS/z3KPZLrRDLbdyew0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bGSc0hN3LdgcrXUTWOleIoT1ObFiRtIv2QusKpCNstM=;
        b=JHrEi36ftDX/vUIHX8YRV7Ww8bnGT6astXzbg6KDMTNxhW5Jk/RZxlvz6v5fKckOjp
         zOiO+ONHspZeoO+4alI65M3z1S5tWm33HMvX70rDh7QuaJvDrAed9B245ib4FMMySQDI
         KvpMUGRzL8t7nm9zE44Y2SYqkEC+rU4uwQcYjW8VQxVIJSCoN4S4EmK9xkHznsHSjwvg
         SyXTp5WHzoPXmFaC5R7AOPhq8FyrlsA1Zaa09TqRmzoEH94TnCCsd8J1nw0lUEceP8xg
         bOdFXEPFHlLpbXBGOTAiyPz6uZKgWdyKpOBdBcIRCHK47p/Uqjv7wdfZrt5iyYpWPRvx
         7AtQ==
X-Gm-Message-State: AJaThX6LG9FdeyTYdTkxfPTov9OrvHv0y67VkOBRI7yL33N2pM922Vd6
        1k+kkOCfhvnkLfw/sgjdhQKMREC+jsLye6tzTqOa
X-Google-Smtp-Source: AGs4zMZD6o0A3eb+k3OU7HJ8mmaIWuCQu+jlx6hBrbjrfMAyBDwQUg5to/nKzT2sDKDhfIL3PG1LGAPu8sibhvf8BAQ=
X-Received: by 10.223.138.246 with SMTP id z51mr3615680wrz.152.1512091686129;
 Thu, 30 Nov 2017 17:28:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.213.12 with HTTP; Thu, 30 Nov 2017 17:27:45 -0800 (PST)
In-Reply-To: <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com> <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
From:   Vitaly Arbuzov <vit@uber.com>
Date:   Thu, 30 Nov 2017 17:27:45 -0800
Message-ID: <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan, thanks for references, that is super helpful, I will follow
your suggestions.

Philip, I agree that keeping original DVCS off-line capability is an
important point. Ideally this feature should work even with remotes
that are located on the local disk.
Which part of Jeff's work do you think wouldn't work offline after
repo initialization is done and sparse fetch is performed? All the
stuff that I've seen seems to be quite usable without GVFS.
I'm not sure if we need to store markers/tombstones on the client,
what problem does it solve?

On Thu, Nov 30, 2017 at 3:43 PM, Philip Oakley <philipoakley@iee.org> wrote=
:
> From: "Vitaly Arbuzov" <vit@uber.com>
>>
>> Found some details here: https://github.com/jeffhostetler/git/pull/3
>>
>> Looking at commits I see that you've done a lot of work already,
>> including packing, filtering, fetching, cloning etc.
>> What are some areas that aren't complete yet? Do you need any help
>> with implementation?
>>
>
> comments below..
>
>>
>> On Thu, Nov 30, 2017 at 9:01 AM, Vitaly Arbuzov <vit@uber.com> wrote:
>>>
>>> Hey Jeff,
>>>
>>> It's great, I didn't expect that anyone is actively working on this.
>>> I'll check out your branch, meanwhile do you have any design docs that
>>> describe these changes or can you define high level goals that you
>>> want to achieve?
>>>
>>> On Thu, Nov 30, 2017 at 6:24 AM, Jeff Hostetler <git@jeffhostetler.com>
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
>>>>>
>>>>>
>>>>> Hi guys,
>>>>>
>>>>> I'm looking for ways to improve fetch/pull/clone time for large git
>>>>> (mono)repositories with unrelated source trees (that span across
>>>>> multiple services).
>>>>> I've found sparse checkout approach appealing and helpful for most of
>>>>> client-side operations (e.g. status, reset, commit, etc.)
>>>>> The problem is that there is no feature like sparse fetch/pull in git=
,
>>>>> this means that ALL objects in unrelated trees are always fetched.
>>>>> It may take a lot of time for large repositories and results in some
>>>>> practical scalability limits for git.
>>>>> This forced some large companies like Facebook and Google to move to
>>>>> Mercurial as they were unable to improve client-side experience with
>>>>> git while Microsoft has developed GVFS, which seems to be a step back
>>>>> to CVCS world.
>>>>>
>>>>> I want to get a feedback (from more experienced git users than I am)
>>>>> on what it would take to implement sparse fetching/pulling.
>>>>> (Downloading only objects related to the sparse-checkout list)
>>>>> Are there any issues with missing hashes?
>>>>> Are there any fundamental problems why it can't be done?
>>>>> Can we get away with only client-side changes or would it require
>>>>> special features on the server side?
>>>>>
>
> I have, for separate reasons been _thinking_ about the issue ($dayjob is =
in
> defence, so a similar partition would be useful).
>
> The changes would almost certainly need to be server side (as well as cli=
ent
> side), as it is the server that decides what is sent over the wire in the
> pack files, which would need to be a 'narrow' pack file.
>
>>>>> If we had such a feature then all we would need on top is a separate
>>>>> tool that builds the right "sparse" scope for the workspace based on
>>>>> paths that developer wants to work on.
>>>>>
>>>>> In the world where more and more companies are moving towards large
>>>>> monorepos this improvement would provide a good way of scaling git to
>>>>> meet this demand.
>
>
> The 'companies' problem is that it tends to force a client-server, always=
-on
> on-line mentality. I'm also wanting the original DVCS off-line capability=
 to
> still be available, with _user_ control, in a generic sense, of what they
> have locally available (including files/directories they have not yet loo=
ked
> at, but expect to have. IIUC Jeff's work is that on-line view, without th=
e
> off-line capability.
>
> I'd commented early in the series at [1,2,3].
>
>
> At its core, my idea was to use the object store to hold markers for the
> 'not yet fetched' objects (mainly trees and blobs). These would be in a
> known fixed format, and have the same effect (conceptually) as the
> sub-module markers - they _confirm_ the oid, yet say 'not here, try
> elsewhere'.
>
> The comaprison with submodules mean there is the same chance of
> de-synchronisation with triangular and upstream servers, unless managed.
>
> The server side, as noted, will need to be included as it is the one that
> decides the pack file.
>
> Options for a server management are:
>
> - "I accept narrow packs?" No; yes
>
> - "I serve narrow packs?" No; yes.
>
> - "Repo completeness checks on reciept": (must be complete) || (allow nar=
row
> to nothing).
>
> For server farms (e.g. Github..) the settings could be global, or by repo=
.
> (note that the completeness requirement and narrow reciept option are not
> incompatible - the recipient server can reject the pack from a narrow
> subordinate as incomplete - see below)
>
> * Marking of 'missing' objects in the local object store, and on the wire=
.
> The missing objects are replaced by a place holder object, which used the
> same oid/sha1, but has a short fixed length, with content =E2=80=9CGitNar=
rowObject
> <oid>=E2=80=9D. The chance that that string would actually have such an o=
id clash is
> the same as all other object hashes, so is a *safe* self-referential devi=
ce.
>
>
> * The stored object already includes length (and inferred type), so we do
> know what it stands in for. Thus the local index (index file) should be a=
ble
> to be recreated from the object store alone (including the =E2=80=98promi=
sed /
> narrow / missing=E2=80=99 files/directory markers)
>
> * the =E2=80=98same=E2=80=99 as sub-modules.
> The potential for loss of synchronisation with a golden complete repo is
> just the same as for sub-modules. (We expected object/commit X here, but
> it=E2=80=99s not in the store). This could happen with a small user group=
 who have
> locally narrow clones, who interact with their local narrow server for
> =E2=80=98backup=E2=80=99, and then fail to push further upstream to a ser=
ver that mandates
> completeness. They could create a death by a thousand narrow cuts. Having=
 a
> golden upstream config reference (indicating which is the upstream) could
> allow checks to ensure that doesn=E2=80=99t happen.
>
> The fsck can be taught the config option of 'allowNarrow'.
>
> The narrowness would be defined in a locally stored '.gitNarrowIgnore' fi=
le
> (which can include the size constraints being developed elsewhere on the
> list)
>
> As a safety it could be that the .gitNarrowIgnore is sent with the pack s=
o
> that fold know what they missed, and fsck could check that they are local=
ly
> not narrower than some specific project .gitNarrowIgnore spec.
>
> The benefit of this that the off-line operation capability of Git continu=
es,
> which GVFS doesn=E2=80=99t quite do (accidental lock in to a client-serve=
r model aka
> all those other VCS systems).
>
> I believe that its all doable, and that Jeff H's work already puts much o=
f
> it in place, or touches those places
>
> That said, it has been just _thinking_, without sufficient time to delve
> into the code.
>
> Phil
>
>>>>>
>>>>> PS. Please don't advice to split things up, as there are some good
>>>>> reasons why many companies decide to keep their code in the monorepo,
>>>>> which you can easily find online. So let's keep that part out the
>>>>> scope.
>>>>>
>>>>> -Vitaly
>>>>>
>>>>
>>>>
>>>> This work is in-progress now.  A short summary can be found in [1]
>>>> of the current parts 1, 2, and 3.
>>>>
>>>>> * jh/object-filtering (2017-11-22) 6 commits
>>>>> * jh/fsck-promisors (2017-11-22) 10 commits
>>>>> * jh/partial-clone (2017-11-22) 14 commits
>>>>
>>>>
>>>>
>>>> [1]
>>>>
>>>> https://public-inbox.org/git/xmqq1skh6fyz.fsf@gitster.mtv.corp.google.=
com/T/
>>>>
>>>> I have a branch that contains V5 all 3 parts:
>>>> https://github.com/jeffhostetler/git/tree/core/pc5_p3
>>>>
>>>> This is a WIP, so there are some rough edges....
>>>> I hope to have a V6 out before the weekend with some
>>>> bug fixes and cleanup.
>>>>
>>>> Please give it a try and see if it fits your needs.
>>>> Currently, there are filter methods to filter all blobs,
>>>> all large blobs, and one to match a sparse-checkout
>>>> specification.
>>>>
>>>> Let me know if you have any questions or problems.
>>>>
>>>> Thanks,
>>>> Jeff
>
>
> [1,2]  [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing
> blobs")
> https://public-inbox.org/git/BC1048A63B034E46A11A01758BC04855@PhilipOakle=
y/
> Date: Tue, 25 Jul 2017 21:48:46 +0100
> https://public-inbox.org/git/8EE0108BA72B42EA9494B571DDE2005D@PhilipOakle=
y/
> Date: Sat, 29 Jul 2017 13:51:16 +0100
>
> [3] [RFC PATCH v2 2/4] promised-object, fsck: introduce promised objects
> https://public-inbox.org/git/244AA0848E9D46F480E7CA407582A162@PhilipOakle=
y/
> Date: Sat, 29 Jul 2017 14:26:52 +0100
>
