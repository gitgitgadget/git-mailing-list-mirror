Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF44320A40
	for <e@80x24.org>; Sat,  2 Dec 2017 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdLBSYx (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 13:24:53 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:54295 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdLBSYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 13:24:52 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LCT4enDQamITaLCT4eUx1B; Sat, 02 Dec 2017 18:24:50 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8
 a=w-CU6Wn9AAAA:8 a=nLb80tOXlheZeDQDFbcA:9 a=0hezZfIurhTfXKH7:21
 a=ZQeKv9cnkbvBdZ-Y:21 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22
Message-ID: <6C1247A43F8841F98E070C264045BF49@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Vitaly Arbuzov" <vit@uber.com>,
        "Jeff Hostetler" <git@jeffhostetler.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com> <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com> <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com> <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley> <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Date:   Sat, 2 Dec 2017 18:24:49 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfCR9MiFfxXOyQwN/0oIyN+G5weGlmpLfnTj6x3gUmTuRYcgAttcp/7C4aPnT+0TQCGh9rYDp0lb0TLUouAONlKB1ewc2T9ejJ4TxprrxMeef6BF2PvVu
 g2R3yypgpKzIb4V5arAW3NMHhUNa/xchTLZcSa1UBHwNmTR19kj7Fig7YY0a17Go79b8ykUb1KbT7tbiyS/rEfi20siIedZRCDIEEo0TKjOmtthI7RJ3smfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff Hostetler" <git@jeffhostetler.com>
Sent: Friday, December 01, 2017 5:23 PM
> On 11/30/2017 6:43 PM, Philip Oakley wrote:
>> From: "Vitaly Arbuzov" <vit@uber.com>
> [...]
>> comments below..
>>>
>>> On Thu, Nov 30, 2017 at 9:01 AM, Vitaly Arbuzov <vit@uber.com> wrote:
>>>> Hey Jeff,
>>>>
>>>> It's great, I didn't expect that anyone is actively working on this.
>>>> I'll check out your branch, meanwhile do you have any design docs that
>>>> describe these changes or can you define high level goals that you
>>>> want to achieve?
>>>>
>>>> On Thu, Nov 30, 2017 at 6:24 AM, Jeff Hostetler <git@jeffhostetler.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
> [...]
>>>>>>
>>
>> I have, for separate reasons been _thinking_ about the issue ($dayjob is 
>> in
>> defence, so a similar partition would be useful).
>>
>> The changes would almost certainly need to be server side (as well as 
>> client
>> side), as it is the server that decides what is sent over the wire in the 
>> pack files, which would need to be a 'narrow' pack file.
>
> Yes, there will need to be both client and server changes.
> In the current 3 part patch series, the client sends a "filter_spec"
> to the server as part of the fetch-pack/upload-pack protocol.
> If the server chooses to honor it, upload-pack passes the filter_spec
> to pack-objects to build an "incomplete" packfile omitting various
> objects (currently blobs).  Proprietary servers will need similar
> changes to support this feature.
>
> Discussing this feature in the context of the defense industry
> makes me a little nervous.  (I used to be in that area.)

I'm viewing the desire for codebase partitioning from a soft layering of 
risk view (perhaps a more UK than USA approach ;-)

> What we have in the code so far may be a nice start, but
> probably doesn't have the assurances that you would need
> for actual deployment.  But it's a start....

True. I need to get some of my collegues more engaged...
>
>>
>>>>>> If we had such a feature then all we would need on top is a separate
>>>>>> tool that builds the right "sparse" scope for the workspace based on
>>>>>> paths that developer wants to work on.
>>>>>>
>>>>>> In the world where more and more companies are moving towards large
>>>>>> monorepos this improvement would provide a good way of scaling git to
>>>>>> meet this demand.
>>
>> The 'companies' problem is that it tends to force a client-server, 
>> always-on
>> on-line mentality. I'm also wanting the original DVCS off-line capability 
>> to
>> still be available, with _user_ control, in a generic sense, of what they
>> have locally available (including files/directories they have not yet 
>> looked
>> at, but expect to have. IIUC Jeff's work is that on-line view, without 
>> the
>> off-line capability.
>>
>> I'd commented early in the series at [1,2,3].
>
> Yes, this does tend to lead towards an always-online mentality.
> However, there are 2 parts:
> [a] dynamic object fetching for missing objects, such as during a
>     random command like diff or blame or merge.  We need this
>     regardless of usage -- because we can't always predict (or
>     dry-run) every command the user might run in advance.

Making something "useful" happen here when off-line is an obvious goal.

> [b] batch fetch mode, such as using partial-fetch to match your
>     sparse-checkout so that you always have the blobs of interest
>     to you.  And assuming you don't wander outside of this subset
>     of the tree, you should be able to work offline as usual.
> If you can work within the confines of [b], you wouldn't need to
> always be online.

I feel this is the area that does need ensure a capability to avoid any 
perception of the much maligned 'Embrace, extend, and extinguish' by 
accidental lockout.

I don't think this should be viewed as a type of sparse checkout - it's just 
a checkout of what you have (under the hood it could use the same code 
though).

>
> We might also add a part [c] with explicit commands to back-fill or
> alter your incomplete view of the ODB (as I explained in response
> to the "git diff <commit1> <commit2>" comment later in this thread.
>
>
>> At its core, my idea was to use the object store to hold markers for the
>> 'not yet fetched' objects (mainly trees and blobs). These would be in a 
>> known fixed format, and have the same effect (conceptually) as the 
>> sub-module markers - they _confirm_ the oid, yet say 'not here, try 
>> elsewhere'.
>
> We do have something like this.  Jonathan can explain better than I, but
> basically, we denote possibly incomplete packfiles from partial clones
> and fetches as "promisor" and have special rules in the code to assert
> that a missing blob referenced from a "promisor" packfile is OK and can
> be fetched later if necessary from the "promising" remote.

The remote interaction is one area that may need thought, especially in a 
triangle workflow, of which there are a few.

>
> The main problem with markers or other lists of missing objects is
> that it has scale problems for large repos.  Suppose I have 100M
> blobs in my repo.  If I do a blob:none clone, I'd have 100M missing
> blobs that would need tracking.  If I then do a batch fetch of the
> blobs needed to do a sparse checkout of HEAD, I'd have to remove
> those entries from the tracking data.  Not impossible, but not
> speedy either.

** Ahhh. I see. That's a consequence of having all the trees isn't it. **

I've always thought that limiting the trees is at the heart of the Narrow 
clone/fetch problem.

OK so if you have flat, wide structures with 10k files/directories per tree 
then it's still a fair sized problem, but it should *scale logarithmically* 
for the part of the tree structure that's not being downloaded.

You never have to add a marker for a blob that you have no containing tree 
for. Nor for the tree that contained the blob's tree, all the way up to 
primary line of descent to the tree of concern. All those trees are never 
down loaded, there are few markers (.gitNarrowTree files) for those tree 
stubs, certainly no 100M missing blob markers.

>
>>
>> The comaprison with submodules mean there is the same chance of
>> de-synchronisation with triangular and upstream servers, unless managed.
>>
>> The server side, as noted, will need to be included as it is the one that
>> decides the pack file.
>>
>> Options for a server management are:
>>
>> - "I accept narrow packs?" No; yes
>>
>> - "I serve narrow packs?" No; yes.
>>
>> - "Repo completeness checks on reciept": (must be complete) || (allow 
>> narrow to nothing).
>
> we have new config settings for the server to allow/reject
> partial clones.
>
> and we have code in fsck/gc to handle these incomplete packfiles.

good

>>
>> For server farms (e.g. Github..) the settings could be global, or by 
>> repo.
>> (note that the completeness requirement and narrow reciept option are not
>> incompatible - the recipient server can reject the pack from a narrow
>> subordinate as incomplete - see below)
>
> For now our scope is limited to partial clone and fetch.  We've not
> considered push.

OK
>
>>
>> * Marking of 'missing' objects in the local object store, and on the 
>> wire.
>> The missing objects are replaced by a place holder object, which used the
>> same oid/sha1, but has a short fixed length, with content 
>> “GitNarrowObject
>> <oid>”. The chance that that string would actually have such an oid clash 
>> is
>> the same as all other object hashes, so is a *safe* self-referential 
>> device.
>
> Again, there is a scale problem here.  If I have 100M missing blobs,
> I can't afford to create 100M loose place holder files.  Or juggle
> a 2GB file of missing objects on various operations.

As above, I'm also trimming the trees, so in general, there would be no 
missing  blobs, just the content of the directory one was interested in.

That's not quite true if higher level trees have blob references in them 
that are otherwise unwanted - they may each need a marker. [Or maybe a 
special single 'tree-of-blobs' marker for them all thus only one marker per 
tree - over-thinking maybe...]
>
>>
>>
>> * The stored object already includes length (and inferred type), so we do
>> know what it stands in for. Thus the local index (index file) should be 
>> able
>> to be recreated from the object store alone (including the ‘promised /
>> narrow / missing’ files/directory markers)
>>
>> * the ‘same’ as sub-modules.
>> The potential for loss of synchronisation with a golden complete repo is
>> just the same as for sub-modules. (We expected object/commit X here, but 
>> it’s not in the store). This could happen with a small user group who 
>> have locally narrow clones, who interact with their local narrow server 
>> for ‘backup’, and then fail to push further upstream to a server that 
>> mandates completeness. They could create a death by a thousand narrow 
>> cuts. Having a golden upstream config reference (indicating which is the 
>> upstream) could allow checks to ensure that doesn’t happen.
>>
>> The fsck can be taught the config option of 'allowNarrow'.
>
> We've updated fsck to be aware of partial clones.
>
OK
>>
>> The narrowness would be defined in a locally stored '.gitNarrowIgnore' 
>> file
>> (which can include the size constraints being developed elsewhere on the
>> list)
>>
>> As a safety it could be that the .gitNarrowIgnore is sent with the pack 
>> so
>> that fold know what they missed, and fsck could check that they are 
>> locally
>> not narrower than some specific project .gitNarrowIgnore spec.
>
> Currently, we store the filter_spec used for the partial clone (or the
> first partial fetch) as a default for subsequent fetches, but we limit
> it there.  That is, for operations like checkout or blame or whatever,
> it doesn't matter why a blob is missing or what filter criteria was
> used to cause it to be omitted -- just that it is.  Any time we need
> a missing object, we have to go get it -- whether that is via dynamic
> or bulk fetching.

Deciding *if* we have to get it, while still being 'useful', is part of the 
question I raised above. In my world view, we already have the intersting 
blobs, so we shouldn't need to get anything. diff's, blame's, checkout's, 
simply go with the stub values and everything is cushty.
>
>>
>> The benefit of this that the off-line operation capability of Git 
>> continues,
>> which GVFS doesn’t quite do (accidental lock in to a client-server model 
>> aka
>> all those other VCS systems).
>
> Yes, there are limitations of GVFS and you must be online to use it.
> It essentially does a blob:none filter and dynamically faults in every
> blob.  (But it is also using a kernel driver and daemon to dynamically
> populate the file system when a file is first opened for writing --
> much like copy-on-write virtual memory.  And yes, these 2 operations
> are independent, but currently combined in the GVFS code.)
>
> And yes, there is work here to make sure that most normal
> operations can continue to work offline.


Magic.
>
>
>>
>> I believe that its all doable, and that Jeff H's work already puts much 
>> of
>> it in place, or touches those places
>>
>> That said, it has been just _thinking_, without sufficient time to delve
>> into the code.
>>
>> Phil
> [...]
>
> Thanks
> Jeff
>

Thanks for the great work.

Philip 

