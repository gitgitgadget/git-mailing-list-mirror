Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDD71F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbdGYUtC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:49:02 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:63570 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdGYUss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:48:48 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id a6l3dnLU50DqZa6l4dVt7W; Tue, 25 Jul 2017 21:48:46 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=PvPRVEE3 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=nB7UE9MOqSv0LP_chi8A:9
 a=3Y4qtisJh9rUc1XO:21 a=lPa1OFMUiV2rG90K:21 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <BC1048A63B034E46A11A01758BC04855@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Tan" <jonathantanmy@google.com>, <git@vger.kernel.org>,
        "Ben Peart" <peartben@gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley> <b928c073-6156-30f2-c850-993e59079ed1@gmail.com>
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
Date:   Tue, 25 Jul 2017 21:48:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170725-2, 25/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfM7LIbj1W/kjrc3+jLD08Rtd7FnRYqP2VqwMY1N3PBur5W52KUsd0KremooNHJm0TNH4jKKSCOZtXUud5XvilP3ofVY/5cJ7QMbNp0ii7gIbhM9KGUf0
 Ve2AKCUkMpWJU84PBRSa0aP6UkxsMkkDYjg5mY58Fb2EwwbzO2rj01AGt8xuq6EFZibfdjGnAgEtN5D14QHz523QNoW1RcSKxk36GgTvZccFsFRf14M+oOoq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the delay - been away...

From: "Ben Peart" <peartben@gmail.com>
Sent: Monday, July 17, 2017 6:43 PM
>
> On 7/16/2017 11:23 AM, Philip Oakley wrote:
>> From: "Jonathan Tan" <jonathantanmy@google.com>
>> Sent: Tuesday, July 11, 2017 8:48 PM
>>> These patches are part of a set of patches implementing partial clone,
>>> as you can see here:
>>>
>>> https://github.com/jonathantanmy/git/tree/partialclone
>>>
>>> In that branch, clone with batch checkout works, as you can see in the
>>> README. The code and tests are generally done, but some patches are
>>> still missing documentation and commit messages.
>>>
>>> These 3 patches implement the foundational concept - formerly known as
>>> "missing blobs" in the "missing blob manifest", I decided to call them
>>> "promised blobs". The repo knows their object names and sizes. It also
>>> does not have the blobs themselves, but can be configured to know how to
>>> fetch them.
>>>
>> If I understand correctly, this method doesn't give any direct user 
>> visibility of missing blobs in the file system. Is that correct?
>
> That is correct
>
>>
>> I was hoping that eventually the various 'on demand' approaches would 
>> still allow users to continue to work as they go off-line such that they 
>> can see directly (in the FS) where the missing blobs (and trees) are 
>> located, so that they can continue to commit new work on existing files.
>>
>
> This is a challenge as git assumes all objects are always available (that 
> is a key design principal of a DVCS) so any missing object is considered a 
> corruption that typically results in a call to "die."

My view/concept was more based on the fact that Git is happy to have missing 
'trees', as long as they are submodules ;-), so I was hoping to massage that 
so git could carry on working as if the whole 'tree' (or blob when they were 
omitted) was still present in as 'unchanged', so the oid's would stay as 
they were.

I see that you don't omit the trees, which would be more common in my type 
of environment (defence/security). I expect in an idealised BigWin repo the 
same would also be true - user only gets /Office/Excel if that's what they 
are working on ;-)

>
> The GVFS solution gets around this by ensuring any missing object is 
> retrieved on behalf of git so that it never sees it as missing.  The 
> obvious tradeoff is that this requires a network connection so the object 
> can be retrieved.

In my concept, the user would not have the opportunity to fetch the 
tree/blob, but could replace it in its entirety (we'd still have the meta 
data of the tree/blob name and it's old oid, but couldn't do a diff)
>
>> I had felt that some sort of 'gitlink' should be present (huma readable) 
>> as a place holder for the missing blob/tree. e.g. 'gitblob: 1234abcd' 
>> (showing the missing oid, jsut like sub-modules can do - it's no 
>> different really.
>>
>
> We explored that option briefly but when you have a large number of files, 
> even writing out some sort of place holder can take a very long time.  In 
> fact, since the typical source file is relatively small (a few kilobytes), 
> writing out a placeholder doesn't save much time vs just writing out the 
> actual file contents.
>
> Another challenge is that even if there is a placeholder written to disk, 
> you still need a network connection to retrieve the actual contents 
> if/when it is needed.

I was viewing the 'missing' tree/blobs to be part of a narrow clone concept, 
so the user would need to explicitly widen the narrow clone to get missing 
trees/blobs (which could have been omitted by age, size, name, style of a 
.gitNarrowIgnore spec etc)

>
>> I'm concerned that the various GVFS extensions haven't fully achieved a 
>> separation of concerns surrounding the DVCS capability for 
>> on-line/off-line conversion as comms drop in and out. The GVFS looks 
>> great for a fully networked, always on, environment, but it would be good 
>> to also have the sepration for those who (will) have shallow/narrow 
>> clones that may also need to work with a local upstream that is also 
>> shallow/narrow.
>>
>
> You are correct that this hasn't been tackled yet. It is a challenging 
> problem. I can envision something along the lines of what was done for the 
> shallow clone feature where there are distinct ways to change the set of 
> objects that are available but that would hopefully come in some future 
> patch series.

OK. That's good to know. If the GFVS could be expanded to create a type of 
Narrow Clone capability  so that the 'going off-line' problem easily 
transitions between being just a neat VFS and then to being a neat narrow 
clone, and  that it may solve two problems in one.

I had it in my mind that the missing blobs/trees could be simply stubbed out 
within the repo itself, as just the oid ref, or maybe the oid ref plus the 
length (given that size is one of the common causes on not wanting the 
content just yet). The repo could still be packed etc, as long as the format 
is understood.

--
Philip

>
>> -- 
>> Philip
>> I wanted to at least get my thoughts into the discussion before it all 
>> passes by.
>>
>>> An older version of these patches was sent as a single demonstration
>>> patch in versions 1 to 3 of [1]. In there, Junio suggested that I have
>>> only one file containing missing blob information. I have made that
>>> suggested change in this version.
>>>
>>> One thing remaining is to add a repository extension [2] so that older
>>> versions of Git fail immediately instead of trying to read missing
>>> blobs, but I thought I'd send these first in order to get some initial
>>> feedback.
>>>
>>> [1] 
>>> https://public-inbox.org/git/cover.1497035376.git.jonathantanmy@google.com/
>>> [2] Documentation/technical/repository-version.txt
>>>
>>> Jonathan Tan (3):
>>>  promised-blob, fsck: introduce promised blobs
>>>  sha1-array: support appending unsigned char hash
>>>  sha1_file: add promised blob hook support
>>>
>>> Documentation/config.txt               |   8 ++
>>> Documentation/gitrepository-layout.txt |   8 ++
>>> Makefile                               |   1 +
>>> builtin/cat-file.c                     |   9 ++
>>> builtin/fsck.c                         |  13 +++
>>> promised-blob.c                        | 170 
>>> +++++++++++++++++++++++++++++++++
>>> promised-blob.h                        |  27 ++++++
>>> sha1-array.c                           |   7 ++
>>> sha1-array.h                           |   1 +
>>> sha1_file.c                            |  44 ++++++---
>>> t/t3907-promised-blob.sh               |  65 +++++++++++++
>>> t/test-lib-functions.sh                |   6 ++
>>> 12 files changed, 345 insertions(+), 14 deletions(-)
>>> create mode 100644 promised-blob.c
>>> create mode 100644 promised-blob.h
>>> create mode 100755 t/t3907-promised-blob.sh
>>>
>>> -- 
>>> 2.13.2.932.g7449e964c-goog
>>>
>> 

