Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB88B1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeCZSyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:54:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:20828 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCZSyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:54:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DCC883F4053;
        Mon, 26 Mar 2018 14:54:36 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 672A93F4000;
        Mon, 26 Mar 2018 14:54:36 -0400 (EDT)
Subject: Re: Git Merge contributor summit notes
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        alexmv@dropbox.com, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com>
 <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
 <CAGZ79ka48UETCWDAj4FcBBnOFsPjjYGXrikqzSPv-uMcZ-N=wg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <37823e64-4964-732d-cc34-1ae77080c97d@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 14:54:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka48UETCWDAj4FcBBnOFsPjjYGXrikqzSPv-uMcZ-N=wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 1:56 PM, Stefan Beller wrote:
> On Mon, Mar 26, 2018 at 10:33 AM Jeff Hostetler <git@jeffhostetler.com>
> wrote:
> 
> 
> 
>> On 3/25/2018 6:58 PM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Sat, Mar 10 2018, Alex Vandiver wrote:
>>>
>>>> New hash (Stefan, etc)
>>>> ----------------------
>>>>    - discussed on the mailing list
>>>>    - actual plan checked in to
> Documentation/technical/hash-function-transition.txt
>>>>    - lots of work renaming
>>>>    - any actual work with the transition plan?
>>>>    - local conversion first; fetch/push have translation table
>>>>    - like git-svn
>>>>    - also modified pack and index format to have lookup/translation
> efficiently
>>>>    - brian's series to eliminate SHA1 strings from the codebase
>>>>    - testsuite is not working well because hardcoded SHA1 values
>>>>    - flip a bit in the sha1 computation and see what breaks in the
> testsuite
>>>>    - will also need a way to do the conversion itself; traverse and
> write out new version
>>>>    - without that, can start new repos, but not work on old ones
>>>>    - on-disk formats will need to change -- something to keep in mind
> with new index work
>>>>    - documentation describes packfile and index formats
>>>>    - what time frame are we talking?
>>>>    - public perception question
>>>>    - signing commits doesn't help (just signs commit object) unless you
> "recursive sign"
>>>>    - switched to SHA1dc; we detect and reject known collision technique
>>>>    - do it now because it takes too long if we start when the collision
> drops
>>>>    - always call it "new hash" to reduce bikeshedding
>>>>    - is translation table a backdoor? has it been reviewed by crypto
> folks?
>>>>      - no, but everything gets translated
>>>>    - meant to avoid a flag day for entire repositories
>>>>    - linus can decide to upgrade to newhash; if pushes to server that
> is not newhash aware, that's fine
>>>>    - will need a wire protocol change
>>>>    - v2 might add a capability for newhash
>>>>    - "now that you mention md5, it's a good idea"
>>>>    - can use md5 to test the conversion
>>>>    - is there a technical reason for why not /n/ hashes?
>>>>    - the slow step goes away as people converge to the new hash
>>>>    - beneficial to make up some fake hash function for testing
>>>>    - is there a plan on how we decide which hash function?
>>>>    - trust junio to merge commits when appropriate
>>>>    - conservancy committee explicitly does not make code decisions
>>>>    - waiting will just give better data
>>>>    - some hash functions are in silicon (e.g. microsoft cares)
>>>>    - any movement in libgit2 / jgit?
>>>>      - basic stuff for libgit2; same testsuite problems
>>>>      - no work in jgit
>>>>    - most optimistic forecast?
>>>>      - could be done in 1-2y
>>>>    - submodules with one hash function?
>>>>      - unable to convert project unless all submodules are converted
>>>>      - OO-ing is not a prereq
>>>
>>> Late reply, but one thing I brought up at the time is that we'll want to
>>> keep this code around even after the NewHash migration at least for
>>> testing purposes, should we ever need to move to NewNewHash.
>>>
>>> It occurred to me recently that once we have such a layer it could be
>>> (ab)used with some relatively minor changes to do any arbitrary
>>> local-to-remote object content translation, unless I've missed something
>>> (but I just re-read hash-function-transition.txt now...).
>>>
>>> E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
>>> remote server so that you upload a GPG encrypted version of all your
>>> blobs, and have your trees reference those blobs.
>>>
>>> Because we'd be doing arbitrary translations for all of
>>> commits/trees/blobs this could go further than other bolted-on
>>> encryption solutions for Git. E.g. paths in trees could be encrypted
>>> too, as well as all the content of the commit object that isn't parent
>>> info & the like (but that would have different hashes).
>>>
>>> Basically clean/smudge filters on steroids, but for every object in the
>>> repo. Anyone who got a hold of it would still see the shape of the repo
>>> & approximate content size, but other than that it wouldn't be more info
>>> than they'd get via `fast-export --anonymize` now.
>>>
>>> I mainly find it interesting because presents an intersection between a
>>> feature we might want to offer anyway, and something that would stress
>>> the hash transition codepath going forward, to make sure it hasn't all
>>> bitrotted by the time we'll need NewHash->NewNewHash.
>>>
>>> Git hosting providers would hate it, but they should probably be
>>> charging users by how much Michael Haggerty's git-sizer tool hates their
>>> repo anyway :)
>>>
> 
>> While we are converting to a new hash function, it would be nice
>> if we could add a couple of fields to the end of the OID:  the object
>> type and the raw uncompressed object size.
> 
> This would allow to craft invalid OIDs, i.e. the correct hash value with
> the wrong object type. (This is different field of "invalid" compared to
> today, where we either have or do not have the object named by the
> hash value. If we don't have it, it may be just unknown to us, but not
> "wrong".)

An invalid OID (such as a wrong object type) could be detected as soon
as we open the object and read the header -- just as the hash can be
verified when the object is read.

The hash value that we use to ask for an object came from somewhere.
Either we have the raw content and are asking if the ODB already has
a copy -or- we have a commit or tree object that references an OID
and we want to dive into objects it references, such as parent-commits,
sub-trees, or blobs.  In the former, we can compute the correct OID tuple
as we compute the OID-hash now.  In the latter, all of tho containing-objects
would have the augmented OID tuple.  And can ask the have/not-have question
as before on the OID tuple.  In all of those cases, we would not ask for
the object with the correct-hash-but-wrong-type.

If the containing-objects have the OID tuple, then the size/type is
explicitly baked into the hash of the parent object and we guard against
another form of collision/extension attack.

> 
>> If would be nice if we could extend the OID to include 6 bytes of data
>> (4 or 8 bits for the type and the rest for the raw object size), and
>> just say that an OID is a {hash,type,size} tuple.
> 
> My suspicion is that the size of the OID is directly proportional to
> the speed of lookup (actually worse than linear, due to CPU caches
> being finite), specifically given Stollees work on walking the DAG.
> Hence I would appreciate if an OID would not contain redundant
> information and have a high information density.
> 
>> There are lots of places where we open an object to see what type it is
>> or how big it is.  This requires uncompressing/undeltafying the object
>> (or at least decoding enough to get the header).  In the case of missing
>> objects (partial clone or a gvfs-like projection) it requires either
>> dynamically fetching the object or asking an object-size-server for the
>> data.
> 
> The commit graph could have these infos in another column, too?
> Then we would have to add the promised objects
> to that data structure as well, but that would look like
> a way better design IMHO.
> 
>> Just a thought.  While we are converting to a new hash it seems like
>> this would be a good time to at least discuss it.
> 
> I'd agree.
> 
> Stefan
> 

Thanks
Jeff
