Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88628C433EF
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347946AbiFEVwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEVw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 17:52:29 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963025D8
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 14:52:26 -0700 (PDT)
Received: from host-89-242-71-63.as13285.net ([89.242.71.63] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nxyAZ-0007qt-5M;
        Sun, 05 Jun 2022 22:52:24 +0100
Message-ID: <cf143d14-2265-be7d-d7a9-a4b11ff0f6af@iee.email>
Date:   Sun, 5 Jun 2022 22:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
Content-Language: en-GB
To:     rsbecker@nexbridge.com, 'Addison Klinke' <addison@baller.tv>
Cc:     'Jason Pyeron' <jpyeron@pdinc.us>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Addison Klinke' <agk38@case.edu>
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us>
 <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email>
 <CAE9CXuiTDjbncEzWJpHN5N0CukcmXbhxQJtzDDhuy0er4Se2DA@mail.gmail.com>
 <547b245d-bdb2-5833-fe4d-15222ae32b57@iee.email>
 <000301d877b7$0fb1ca20$2f155e60$@nexbridge.com>
 <b767ee9f-5c93-0c82-f551-7c1673adcc62@iee.email>
 <003001d8782b$d207c100$76174300$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <003001d8782b$d207c100$76174300$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2022 16:57, rsbecker@nexbridge.com wrote:
> On June 4, 2022 9:28 AM, Philip Oakley wrote:
>> On 04/06/2022 03:01, rsbecker@nexbridge.com wrote:
>>> On June 3, 2022 7:07 PM, Philip Oakley wrote:
>>>> On 01/06/2022 13:44, Addison Klinke wrote:
>>>>>> rsbecker: move code into a submodule from your own VCS system
>>>>> into a git repository and the work with the submodule without the
>>>>> git code-base knowing about this
>>>>>
>>>>>> Philip: uses a proper sub-module that within it then has
>>>>> the single 'large' file git-lfs style that hosts the hash reference
>>>>> for the data VCS
>>>>>
>>>>> The downside I see with both of these approaches is that translating
>>>>> the native data VCS to git (or LFS) negates all the benefits of
>>>>> having a VCS purpose-built for data. That's why the majority of data
>>>>> versioning tools exist - because git (or LFS) are not ideal for
>>>>> handling machine learning datasets
>>>> The key aspect is deciding which of the two storage systems (the Data
>>>> & the Code) will be the overall lead system that contains the linked
>>>> reference to the other storage system to ensure the needed integrity.
>>>> That is not really a technical question. Rather its somewhat of a
>>>> social discussion (workflows, trust, style of integration, etc).
>>>>
>>>> It maybe that one of the systems does have less long-term integrity,
>>>> as has been seen in many versioning systems over the last century
>>>> (both manual and computer), but the UI is also important.
>>>>
>>>> IIRC Junio did note that having a suitable API to access the other
>>>> storage system (to know its status, etc.) is likely to be core to the
>>>> ability to combine the two. It may  be that a top level 'gui' is used
>>>> control both systems and ensure synchronisation to hide the complexities of
>> both systems.
>>>> I'm still thinking that the "git-lfs like" style could be the one to
>>>> use, but that is very dependant on the API that is available for
>>>> capturing the Data state into the git entry that records that state, whether that
>> is a file (git-lfs like) or a 'sub-module'
>>>> (directory as state ) style.  Either way it still need reifying (i.e.
>>>> coded to make the abstract concept into a concrete implementation).
>>>>
>>>> Which ever route is chosen, it still sounds to me like a worthwhile
>>>> enterprise. It's all still very abstract.
>>>>> On Tue, May 10, 2022 at 2:54 PM Philip Oakley <philipoakley@iee.email>
>> wrote:
>>>>>> On 10/05/2022 18:20, Jason Pyeron wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Junio C Hamano
>>>>>>>> Sent: Tuesday, May 10, 2022 1:01 PM
>>>>>>>> To: Addison Klinke <addison@baller.tv>
>>>>>>>>
>>>>>>>> Addison Klinke <addison@baller.tv> writes:
>>>>>>>>
>>>>>>>>> Is something along these lines feasible?
>>>>>>>> Offhand, I only think of one thing that could make it
>>>>>>>> fundamentally infeasible.
>>>>>>>>
>>>>>>>> When you bind an external repository (be it stored in Git or
>>>>>>>> somebody else's system) as a submodule, each commit in the
>>>>>>>> superproject records which exact commit in the submodule is used
>>>>>>>> with the rest of the superproject tree.  And that is done by
>>>>>>>> recording the object name of the commit in the submodule.
>>>>>>>>
>>>>>>>> What it means for the foreign system that wants to "plug into" a
>>>>>>>> superproject in Git as a submodule?  It is required to do two
>>>>>>>> things:
>>>>>>>>
>>>>>>>>   * At the time "git commit" is run at the superproject level, the
>>>>>>>>     foreign system has to be able to say "the version I have to be
>>>>>>>>     used in the context of this superproject commit is X", with X
>>>>>>>>     that somehow can be stored in the superproject's tree object
>>>>>>>>     (which is sized 20-byte for SHA-1 repositories; in SHA-256
>>>>>>>>     repositories, it is a bit wider).
>>>>>>>>
>>>>>>>>   * At the time "git chekcout" is run at the superproject level, the
>>>>>>>>     superproject will learn the above X (i.e. the version of the
>>>>>>>>     submodule that goes with the version of the superproject being
>>>>>>>>     checked out).  The foreign system has to be able to perform a
>>>>>>>>     "checkout" given that X.
>>>>>>>>
>>>>>>>> If a foreign system cannot do the above two, then it
>>>>>>>> fundamentally would be incapable of participating in such a
>>>>>>>> "superproject and submodule" relationship.
>>>>>> The sub-modules already have that problem if the user forgets
>>>>>> publish their sub-module (see notes in the docs ;-).
>>>>>>> The submodule "type" could create an object (hashed and stored)
>>>>>>> that
>>>> contains the needed "translation" details. The object would be hashed
>>>> using SHA1 or SHA256 depending on the git config. The format of the
>>>> object's contents would be defined by the submodule's "code".
>>>>>> Another way of looking at the issue is via a variant of Git-LFS
>>>>>> with a smudge/clean style filter. I.e. the DataVCS would be treated as a 'file'.
>>>>>>
>>>>>> The LFS already uses the .gitattributes to define a 'type', while
>>>>>> the submodules don't yet have that capability. There is just a
>>>>>> single special type within a tree object of "sub-module"  being a
>>>>>> mode 16000 commit (see https://longair.net/blog/2010/06/02/git-
>> submodules-explained/).
>>>>>> One thought is that one uses a proper sub-module that within it
>>>>>> then has the single 'large' file git-lfs style that hosts the hash
>>>>>> reference for the data VCS
>>>>>> (https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md). It
>>>>>> would be the regular sub-modules .gitattributes file that handles
>>>>>> the data conversion.
>>>>>>
>>>>>> It may be converting an X-Y problem into an X-Y-Z solution, or just
>>>>>> extending the problem.
>>> The most salient issue I have with this is that signatures cannot be validated
>> across VCS systems.
>>
>> I think I disagree, but let's be sure we are talking about the same 'signature'
>> aspect, I think there are (at least) three different signatures we could be talking
>> about
>>
>> 1. The hash verification 'signature' that can cascade down the trees. We verify
>> against a given hash.
>> 2. The 'Signed-off-by:' legal/copyright signature - important, but I don't think that's
>> the one being discussed.
>> 3. The (e.g.) PGP signature of a tag or commit. This provides a (web of) trust
>> mechanism for the _given_ hash in 1. Important in 'open systems', less so in more
>> closed systems where trust, and the _given_, is via side channels.
> The third is more my concern. I do not know of other (D)VCS systems that have the same level of trust allowed in git - simultaneously PGP/SSH signing commits and potentially multiple tags.

for reference of other readers, that's as discussed in
https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work esp. the
'Signing Commits' and 'Everyone Must Sign' sections at the end of the Ch 7.4
>> Note the shift from using a hash to using the PGP for the 'signature'.
>>
>>
>>> Within git, a submodule commit can be signed. This ensures that the contents of
>> the commit in the super-project can also be signed. If someone hacks an
>> underlying VCS that is not git, either:
>> Submodules are a remote VCS, it just happens to have the same hash validation
>> software as the super-project, which is nice.
>>> a) git can never sign a commit from an underlying VCS, or
>> Git-LFS is a similar hand off, though many accept it's capability.
>>> b) git can never trust a commit from an underlying VCS.
>>>
>>> This pollutes a fundamental capability of git, being multiple signers the contents
>> of a commit, and invalidates the integrity of the Merkel tree that underlies git
>> contents.
>>
>> The main issue is how to confirm the integrity the other VCS. Many of the Data
>> VCS systems are based on Git and it's hash integrity approach, so as long as the
>> DATA VCS has similar integrity guarantees, we maintain the level of trust in the
>> security of the whole system.
> This is exactly my concern and what I was trying to point out - although more briefly. I do not think (an|there are) underlying VCS can provide similar guarantees. It is all too easy to hack most VCS systems if you have an appropriate user id especially most non-distributed ones. We originally moved to git because we had hacks on two different VCS systems underlying files.
>
>>> I do not see that this concept contributes positively to the ecosystem. I do feel
>> strongly about this and hope my points are understood.
>>
>> I'd agree that there is a need to work out how to integrate the code VCS and data
>> VCS in a consistent way. Ignoring the Data VCS problem doesn't make it go away.
>>
>> Maybe if Addison was able to identify one or two lead contenders as the Data VCS
>> and how it/they offer their levels of security and integrity,

Looking back at Addison's original email, he did suggest:

- [Dolt](https://www.dolthub.com/),
- [LakeFS](https://lakefs.io/), and
- [DVC](https://dvc.org/)

as examples. They all imply git hash style validation of the individual
data commits, by not mention of [PGP] signing, though it may available
for some.

I did see the Dolt issue [ Cryptographic signing of a changeset? #628
](https://github.com/dolthub/dolt/issues/628), so it looks like it's on
their radar, though it's likely they'll need similar discussions about
how to cross integrate with Git..

However, we also need to note the shift to the cloud for these very
large immobile data sets, where there maybe concerns as to the security
and trustworthiness of the compute and storage platforms (cosmic rays,
random glitches, hacks, etc).

We are no longer importing code to our local machine that we need to be
signed, rather we are exporting our code to their compute
infrastructure, so the verification has to happen 'over-there'. So the
integrity question is still very pertinent.

>>  then it would be easier
>> to see where in the Git model that may fit. Or whether Git is the underling VCS
>> (because it has programmable API), and the Data VCS (esp because of scale and
>> non-distributed nature) becomes the "authority", even if that has less capability!
> I agree as well. I want to see assurances that this level of integrity can be maintained - or that the user will have to accept the risks that git signatures are no longer usable. It might be appropriate to disable commit.gpgsign if the underlying VCS cannot be an authority.
>
>
I'd also worry, like yourself, about the cloud data sets, and how the
data selection subsets are captured (e.g. if multiple individuals have
used their right to be forgotten to make the old selection no longer
accessible, then how to validate?). Interesting times.
--
Philip
