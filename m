Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D6C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiFFOx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiFFOxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 10:53:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC221B585D
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 07:53:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o73so6065752qke.7
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baller-tv.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=24ApUMflm8rUrHq99IQqkDmpNMHoKI9Zx3sIlcrXf38=;
        b=MYyRpJiqgRfxNWBTQWCZ7mh0+CAC9v1Uoj/x2hWyKizUp7boVBmEJnxKouIJ94gYxk
         lUivLCaAEDXVRsJjQJECsWfkhCFQVbKCGyI2i7+Hr0VRUDGKDxlYG/lBGtiI5yAAfGvr
         URpOluZxPN/sgH6U3mxPgXLn3/SeGXdSn2LH5p3sb5opiCI66NvxsTpzjgmEzNinE3y+
         jRLy82HrX1gbXbRgrh288rYvO2i7bk+zBv1XMJBvmEN1g0rCJ1kglN8jiFOohoAZkRi0
         Ab9Kwuum09f80op+gk0u0FDu5h90jtFaDUDWLXRb2m/fwM69CveihIIQhUaTh3b46JMV
         pfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=24ApUMflm8rUrHq99IQqkDmpNMHoKI9Zx3sIlcrXf38=;
        b=eTCTRQm1Fr1CvUvg1/Ho5WU2HsiN8InD0Ijfp4BmveGR9cCi17WSX9fMNoh0BM7oY1
         TArvUWPBBiCR5rk9UR4YPrnT9GMMZLEwS114e7+MX3V6jJgrn4PnS7qViOdXl6cMGaXh
         iS6hu9i4/jcchVsKFJKP6xiTJ5XuMrlRGeCijP+pR8jOnJRcwHnoWG+zs0x3N5iTZJ32
         hYrDRFy14UOWv8VL+KkxUpQ/LxLqh0Vql/pz/f1A+qQmpdSUIYSDnduwH6cO6hNyy2xe
         n+QmpwyyRu1Y/4QixuU243XFILE4Thc5dRRtm9RrOUm1aoRw2pTsmY+qusVbb6vvg/X5
         Dlvg==
X-Gm-Message-State: AOAM531nZ5qmYiIXzlp5D/ngRkLenpdUDI+mlEdSjndnuJMJASDHuqTH
        vTowwi7/ow4qnwEFl3xJ/V13kWi83BPIWZL+T1CqcGnMf2mjYA==
X-Google-Smtp-Source: ABdhPJxSD2rIMoLbcyRTonDlOc1XZgnN5jb8NSowT3du82Cv7dut3SPnlcSIxxDSasWtL3dy0bNlLoMSnSV7wEbDzio=
X-Received: by 2002:a05:620a:2a11:b0:6a5:8dff:76fa with SMTP id
 o17-20020a05620a2a1100b006a58dff76famr15589894qkp.3.1654527202445; Mon, 06
 Jun 2022 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us>
 <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email> <CAE9CXuiTDjbncEzWJpHN5N0CukcmXbhxQJtzDDhuy0er4Se2DA@mail.gmail.com>
 <547b245d-bdb2-5833-fe4d-15222ae32b57@iee.email> <000301d877b7$0fb1ca20$2f155e60$@nexbridge.com>
 <b767ee9f-5c93-0c82-f551-7c1673adcc62@iee.email> <003001d8782b$d207c100$76174300$@nexbridge.com>
 <cf143d14-2265-be7d-d7a9-a4b11ff0f6af@iee.email>
In-Reply-To: <cf143d14-2265-be7d-d7a9-a4b11ff0f6af@iee.email>
From:   Addison Klinke <addison@baller.tv>
Date:   Mon, 6 Jun 2022 08:53:11 -0600
Message-ID: <CAE9CXugMtYmq4XW+NZeMVYM2-7is7EECBQADSzGUwzAwgzQvUA@mail.gmail.com>
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
To:     Philip Oakley <philipoakley@iee.email>
Cc:     rsbecker@nexbridge.com, Jason Pyeron <jpyeron@pdinc.us>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Addison Klinke <agk38@case.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The key aspect is deciding which of the two storage systems (the Data &
the Code) will be the overall lead system that contains the linked
reference to the other storage system

I'd prefer git as the lead system since it's a standard everyone is
already used to. With so many variations on data VCS out there, I
think it would be difficult to find consensus

> I do not know of other (D)VCS systems that have the same level of trust a=
llowed in git - simultaneously PGP/SSH signing commits and potentially mult=
iple tags

I have not used signed commits/tags with git before since the majority
of machine learning work in industry is on private repositories with
internal teams. The Dolt issue thread that Philip referenced seems
quite interesting in this regard.

> It might be appropriate to disable commit.gpgsign if the underlying VCS c=
annot be an authority

Would it be reasonable to start working on submodule integrations and
design a way for signing to be added later on as it (hopefully)
becomes supported by each data VCS?

On Sun, Jun 5, 2022 at 3:52 PM Philip Oakley <philipoakley@iee.email> wrote=
:
>
> On 04/06/2022 16:57, rsbecker@nexbridge.com wrote:
> > On June 4, 2022 9:28 AM, Philip Oakley wrote:
> >> On 04/06/2022 03:01, rsbecker@nexbridge.com wrote:
> >>> On June 3, 2022 7:07 PM, Philip Oakley wrote:
> >>>> On 01/06/2022 13:44, Addison Klinke wrote:
> >>>>>> rsbecker: move code into a submodule from your own VCS system
> >>>>> into a git repository and the work with the submodule without the
> >>>>> git code-base knowing about this
> >>>>>
> >>>>>> Philip: uses a proper sub-module that within it then has
> >>>>> the single 'large' file git-lfs style that hosts the hash reference
> >>>>> for the data VCS
> >>>>>
> >>>>> The downside I see with both of these approaches is that translatin=
g
> >>>>> the native data VCS to git (or LFS) negates all the benefits of
> >>>>> having a VCS purpose-built for data. That's why the majority of dat=
a
> >>>>> versioning tools exist - because git (or LFS) are not ideal for
> >>>>> handling machine learning datasets
> >>>> The key aspect is deciding which of the two storage systems (the Dat=
a
> >>>> & the Code) will be the overall lead system that contains the linked
> >>>> reference to the other storage system to ensure the needed integrity=
.
> >>>> That is not really a technical question. Rather its somewhat of a
> >>>> social discussion (workflows, trust, style of integration, etc).
> >>>>
> >>>> It maybe that one of the systems does have less long-term integrity,
> >>>> as has been seen in many versioning systems over the last century
> >>>> (both manual and computer), but the UI is also important.
> >>>>
> >>>> IIRC Junio did note that having a suitable API to access the other
> >>>> storage system (to know its status, etc.) is likely to be core to th=
e
> >>>> ability to combine the two. It may  be that a top level 'gui' is use=
d
> >>>> control both systems and ensure synchronisation to hide the complexi=
ties of
> >> both systems.
> >>>> I'm still thinking that the "git-lfs like" style could be the one to
> >>>> use, but that is very dependant on the API that is available for
> >>>> capturing the Data state into the git entry that records that state,=
 whether that
> >> is a file (git-lfs like) or a 'sub-module'
> >>>> (directory as state ) style.  Either way it still need reifying (i.e=
.
> >>>> coded to make the abstract concept into a concrete implementation).
> >>>>
> >>>> Which ever route is chosen, it still sounds to me like a worthwhile
> >>>> enterprise. It's all still very abstract.
> >>>>> On Tue, May 10, 2022 at 2:54 PM Philip Oakley <philipoakley@iee.ema=
il>
> >> wrote:
> >>>>>> On 10/05/2022 18:20, Jason Pyeron wrote:
> >>>>>>>> -----Original Message-----
> >>>>>>>> From: Junio C Hamano
> >>>>>>>> Sent: Tuesday, May 10, 2022 1:01 PM
> >>>>>>>> To: Addison Klinke <addison@baller.tv>
> >>>>>>>>
> >>>>>>>> Addison Klinke <addison@baller.tv> writes:
> >>>>>>>>
> >>>>>>>>> Is something along these lines feasible?
> >>>>>>>> Offhand, I only think of one thing that could make it
> >>>>>>>> fundamentally infeasible.
> >>>>>>>>
> >>>>>>>> When you bind an external repository (be it stored in Git or
> >>>>>>>> somebody else's system) as a submodule, each commit in the
> >>>>>>>> superproject records which exact commit in the submodule is used
> >>>>>>>> with the rest of the superproject tree.  And that is done by
> >>>>>>>> recording the object name of the commit in the submodule.
> >>>>>>>>
> >>>>>>>> What it means for the foreign system that wants to "plug into" a
> >>>>>>>> superproject in Git as a submodule?  It is required to do two
> >>>>>>>> things:
> >>>>>>>>
> >>>>>>>>   * At the time "git commit" is run at the superproject level, t=
he
> >>>>>>>>     foreign system has to be able to say "the version I have to =
be
> >>>>>>>>     used in the context of this superproject commit is X", with =
X
> >>>>>>>>     that somehow can be stored in the superproject's tree object
> >>>>>>>>     (which is sized 20-byte for SHA-1 repositories; in SHA-256
> >>>>>>>>     repositories, it is a bit wider).
> >>>>>>>>
> >>>>>>>>   * At the time "git chekcout" is run at the superproject level,=
 the
> >>>>>>>>     superproject will learn the above X (i.e. the version of the
> >>>>>>>>     submodule that goes with the version of the superproject bei=
ng
> >>>>>>>>     checked out).  The foreign system has to be able to perform =
a
> >>>>>>>>     "checkout" given that X.
> >>>>>>>>
> >>>>>>>> If a foreign system cannot do the above two, then it
> >>>>>>>> fundamentally would be incapable of participating in such a
> >>>>>>>> "superproject and submodule" relationship.
> >>>>>> The sub-modules already have that problem if the user forgets
> >>>>>> publish their sub-module (see notes in the docs ;-).
> >>>>>>> The submodule "type" could create an object (hashed and stored)
> >>>>>>> that
> >>>> contains the needed "translation" details. The object would be hashe=
d
> >>>> using SHA1 or SHA256 depending on the git config. The format of the
> >>>> object's contents would be defined by the submodule's "code".
> >>>>>> Another way of looking at the issue is via a variant of Git-LFS
> >>>>>> with a smudge/clean style filter. I.e. the DataVCS would be treate=
d as a 'file'.
> >>>>>>
> >>>>>> The LFS already uses the .gitattributes to define a 'type', while
> >>>>>> the submodules don't yet have that capability. There is just a
> >>>>>> single special type within a tree object of "sub-module"  being a
> >>>>>> mode 16000 commit (see https://longair.net/blog/2010/06/02/git-
> >> submodules-explained/).
> >>>>>> One thought is that one uses a proper sub-module that within it
> >>>>>> then has the single 'large' file git-lfs style that hosts the hash
> >>>>>> reference for the data VCS
> >>>>>> (https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md). It
> >>>>>> would be the regular sub-modules .gitattributes file that handles
> >>>>>> the data conversion.
> >>>>>>
> >>>>>> It may be converting an X-Y problem into an X-Y-Z solution, or jus=
t
> >>>>>> extending the problem.
> >>> The most salient issue I have with this is that signatures cannot be =
validated
> >> across VCS systems.
> >>
> >> I think I disagree, but let's be sure we are talking about the same 's=
ignature'
> >> aspect, I think there are (at least) three different signatures we cou=
ld be talking
> >> about
> >>
> >> 1. The hash verification 'signature' that can cascade down the trees. =
We verify
> >> against a given hash.
> >> 2. The 'Signed-off-by:' legal/copyright signature - important, but I d=
on't think that's
> >> the one being discussed.
> >> 3. The (e.g.) PGP signature of a tag or commit. This provides a (web o=
f) trust
> >> mechanism for the _given_ hash in 1. Important in 'open systems', less=
 so in more
> >> closed systems where trust, and the _given_, is via side channels.
> > The third is more my concern. I do not know of other (D)VCS systems tha=
t have the same level of trust allowed in git - simultaneously PGP/SSH sign=
ing commits and potentially multiple tags.
>
> for reference of other readers, that's as discussed in
> https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work esp. the
> 'Signing Commits' and 'Everyone Must Sign' sections at the end of the Ch =
7.4
> >> Note the shift from using a hash to using the PGP for the 'signature'.
> >>
> >>
> >>> Within git, a submodule commit can be signed. This ensures that the c=
ontents of
> >> the commit in the super-project can also be signed. If someone hacks a=
n
> >> underlying VCS that is not git, either:
> >> Submodules are a remote VCS, it just happens to have the same hash val=
idation
> >> software as the super-project, which is nice.
> >>> a) git can never sign a commit from an underlying VCS, or
> >> Git-LFS is a similar hand off, though many accept it's capability.
> >>> b) git can never trust a commit from an underlying VCS.
> >>>
> >>> This pollutes a fundamental capability of git, being multiple signers=
 the contents
> >> of a commit, and invalidates the integrity of the Merkel tree that und=
erlies git
> >> contents.
> >>
> >> The main issue is how to confirm the integrity the other VCS. Many of =
the Data
> >> VCS systems are based on Git and it's hash integrity approach, so as l=
ong as the
> >> DATA VCS has similar integrity guarantees, we maintain the level of tr=
ust in the
> >> security of the whole system.
> > This is exactly my concern and what I was trying to point out - althoug=
h more briefly. I do not think (an|there are) underlying VCS can provide si=
milar guarantees. It is all too easy to hack most VCS systems if you have a=
n appropriate user id especially most non-distributed ones. We originally m=
oved to git because we had hacks on two different VCS systems underlying fi=
les.
> >
> >>> I do not see that this concept contributes positively to the ecosyste=
m. I do feel
> >> strongly about this and hope my points are understood.
> >>
> >> I'd agree that there is a need to work out how to integrate the code V=
CS and data
> >> VCS in a consistent way. Ignoring the Data VCS problem doesn't make it=
 go away.
> >>
> >> Maybe if Addison was able to identify one or two lead contenders as th=
e Data VCS
> >> and how it/they offer their levels of security and integrity,
>
> Looking back at Addison's original email, he did suggest:
>
> - [Dolt](https://www.dolthub.com/),
> - [LakeFS](https://lakefs.io/), and
> - [DVC](https://dvc.org/)
>
> as examples. They all imply git hash style validation of the individual
> data commits, by not mention of [PGP] signing, though it may available
> for some.
>
> I did see the Dolt issue [ Cryptographic signing of a changeset? #628
> ](https://github.com/dolthub/dolt/issues/628), so it looks like it's on
> their radar, though it's likely they'll need similar discussions about
> how to cross integrate with Git..
>
> However, we also need to note the shift to the cloud for these very
> large immobile data sets, where there maybe concerns as to the security
> and trustworthiness of the compute and storage platforms (cosmic rays,
> random glitches, hacks, etc).
>
> We are no longer importing code to our local machine that we need to be
> signed, rather we are exporting our code to their compute
> infrastructure, so the verification has to happen 'over-there'. So the
> integrity question is still very pertinent.
>
> >>  then it would be easier
> >> to see where in the Git model that may fit. Or whether Git is the unde=
rling VCS
> >> (because it has programmable API), and the Data VCS (esp because of sc=
ale and
> >> non-distributed nature) becomes the "authority", even if that has less=
 capability!
> > I agree as well. I want to see assurances that this level of integrity =
can be maintained - or that the user will have to accept the risks that git=
 signatures are no longer usable. It might be appropriate to disable commit=
.gpgsign if the underlying VCS cannot be an authority.
> >
> >
> I'd also worry, like yourself, about the cloud data sets, and how the
> data selection subsets are captured (e.g. if multiple individuals have
> used their right to be forgotten to make the old selection no longer
> accessible, then how to validate?). Interesting times.
> --
> Philip
