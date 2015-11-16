From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Mon, 16 Nov 2015 11:25:13 -0800
Message-ID: <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
	<CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
	<564A279C.6000802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 20:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyPOz-0001pQ-5b
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 20:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbbKPTZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 14:25:16 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34382 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbKPTZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 14:25:14 -0500
Received: by ykfs79 with SMTP id s79so258423962ykf.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tpDgtCRrquTj2RD7zGW4eS7Lx+mLIB48W0XOzOUzvTI=;
        b=kUadw5e5eLEFqhZs/Z12F2fMvGl/S2aHiefBI7U+Cbv9wpmXG1sFPlfA9VRMuxXyrK
         Gsc9fqMcDC14T6RYG2HirFKL9mdO4EogtsBDa3Mklza84r5Y/it5XAXs6zytlK1x2ZxG
         w8Xp339MFLtnH4cGvhlPHH6rw6mVqWBrgpn0NtM/EkVDapinrs7qL2ScIK7Mtpg9bj+1
         iRveLfjucQTYPpxXwvCBQpyivQC99AFIFRi3MWQ83QpEm4FcDuoZ2Qb3lNDa9AY2eMNx
         1037IKe/+qsrjDHAtHCBhft1Xm/EU6zW8xhe/E7eNGiOcFvhydazaoenx5BbjBkIcjCi
         ZtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tpDgtCRrquTj2RD7zGW4eS7Lx+mLIB48W0XOzOUzvTI=;
        b=C80lGCrah0Vg6ioIzKBqRGgkLSVovM+wPil4FI5ETLkTiiYFLDfnbhKle+xhQ0d0Rh
         +yuXG60xf6yE0JitET87SCDD5dfYkUXiHJtM6kliNotqC95tqfnuqELXQ0Tp/flDjjEZ
         7qx5nqfCf7Zqy783KdDPXf1jRdTeTqnXDNI2c9+maaZV0Gu+2xzgEIQw9URc9E71rA8e
         QC+2dpXHebm2N/PFFgwlCZBvokTPiis1nSGFPPyPl4cRGkL2b9RVYTDobghy5JWecWEw
         MVkC/n+I5gNyViL0vrnglqmnQtvZeobc9pnp6ip5QPAQG4IWE/KjTRZJ81H54jquU8hq
         F7gg==
X-Gm-Message-State: ALoCoQmTqKzplX3CP23TO/snZFosiovqAujSuJrlbnVz84di5HXQ95kOArkLKzizJdiWQEcpklIq
X-Received: by 10.129.133.69 with SMTP id v66mr8162119ywf.68.1447701913799;
 Mon, 16 Nov 2015 11:25:13 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 16 Nov 2015 11:25:13 -0800 (PST)
In-Reply-To: <564A279C.6000802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281354>

On Mon, Nov 16, 2015 at 10:59 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 14.11.2015 um 01:10 schrieb Stefan Beller:
>>
>> On Fri, Nov 13, 2015 at 3:41 PM, Jeff King <peff@peff.net> wrote:
>>>
>>> On Fri, Nov 13, 2015 at 06:38:07PM -0500, Jeff King wrote:
>>>
>>>> On Fri, Nov 13, 2015 at 03:16:01PM -0800, Stefan Beller wrote:
>>>>
>>>>> Junio wrote on Oct 09, 2014:
>>>>>>
>>>>>> This is so non-standard a thing to do that I doubt it is worth
>>>>>> supporting with "git clone".  "git clone --branch", which is about
>>>>>
>>>>> "> I want to follow that particular branch", would not mesh well with
>>>>>>
>>>>>> "I want to see the history that leads to this exact commit", either.
>>>>>> You would not know which branch(es) is that exact commit is on in
>>>>>> the first place.
>>>>>
>>>>>
>>>>> I disagree with this. This is the *exact* thing you actually want to do
>>>>> when
>>>>> dealing with submodules. When fetching/cloning for a submodule, you
>>>>> want
>>>>> to obtain the exact sha1, instead of a branch (which happens to be
>>>>> supported
>>>>> too, but is not the original use case with submodules.)
>
>
> Yes, being able to fetch certain sha1s makes lots of sense for submodules
> (this has been discussed some time ago at a GitTogether). But - apart from
> the extra network load - it's rather helpful to get all the submodule
> branches too (though that could be limited to the branches the sha1 is on).

Ok, I did not attend that GitTogether ;)

>
>>>> I think this is already implemented in 68ee628 (upload-pack: optionally
>>>> allow fetching reachable sha1, 2015-05-21), isn't it?
>>>
>>>
>>> Note that this just implements the server side. I think to use this with
>>> submodules right now, you'd have to manually "git init && git fetch" in
>>> the submodule. It might make sense to teach clone to handle this, to
>>> avoid the submodule code duplicating what the clone code does.
>>
>>
>> Yes I want to add it to clone, as that is a prerequisite for making
>> git clone --recursive --depth 1 to work as you'd expect. (such that
>> the submodule can be cloned&checkout instead of rewriting that to be
>> init&fetch.
>
>
> Cool, that should help recursive fetch too.
>
>> Thanks for pointing out that we already have some kind of server support.
>>
>> I wonder if we should add an additional way to make fetching only some
>> sha1s possible. ("I don't want users to fetch any sha1, but only those
>> where superprojects point{ed} to", even if you force push a superproject,
>> you want to want to only allow fetching all sha1s which exist in the
>> current
>> superprojects branch.)
>
>
> Me thinks the restrictions for sha1-fetching could come from the branches
> these sha1s are found in the upstream submodule: if the client is allowed
> to fetch a branch, it should be able to fetch any sha1 on that branch.

I'd agree on that. The server side even with uploadpack.allowTipSHA1InWant
set, is not sufficient though.

To fetch an arbitrary sha1, you would need to check if that sha1 is part
of the history of any advertised branch and then allow fetching serverside,
which sounds like some work for the server, which we may want to avoid
by having smarter data structures there.

Instead of having to search all branches for the requested sha1, we could have
some sort of data structure to make it not an O(n) operation (n being
all objects
in the repo).

Maybe I overestimate the work which needs to be done, because the server has
bitmaps nowadays.

Maybe a lazy reverse-pointer graph can be established on the serverside.
So I guess when we add the feature to fetch arbitrary sha1s, reachable from
any branch, people using submodules will make use of the feature. (such as with
git fetch --recurse --depth 1 or via a new `git fetch --recursive
--up-to-submodule-tip-only`)

So once the server is asked for a certain sha1, it will do the
reachability check,
which takes some effort, but then stores the result in the form:
"If ${current tip sha} of ${branch} is reachable, so is requested $sha1."

So when the next fetch request for $sha1 arrives, the server only needs to
check for ${current tip sha} to be part of $branch, which is expected to be
a shorter revwalk from the tip. (Because it is nearer to the tip, a bitmap could
just tell you or at least shorten the walk even more)
If the ${branch} has changed, the next evaluation for $sha1 can update
the cache,
such that the reverse lookup is not expensive on expectation.

I assume this will mostly be used with submodules, so only a few sha1s need
this caching.

>
>> Maybe our emails crossed, but in the other mail I pointed out we could use
>> some sort of hidden ref (refs/superprojects/*) for that, which are
>> allowed to mark
>> any sort of sha1, which are allowed in the superproject/submodule context
>> to be fetched.
>>
>> So whenever you push to a superproject (a project that has a gitlink),
>> we would need to check serverside if that submodule is at us and mark the
>> correct sha1s in the submodule. Then you can disallow fetching most of the
>> sha1s
>> but still could have a correctly working submodule update mechanism.
>
>
> And what happens if the submodule isn't at us? Involving the serverside of
> a superproject in submodule fetching sounds wrong to me. Me thinks that
> the upstream of the submodule should always control if a sha1 is allowed
> to be fetched. Or did I understand you wrong?

Yes and no.
The serverside submodule repository should be responsible for the ultimate
decision if you are allowed to fetch that sha1. But maybe on pushing the
superproject, we can store a hint in the submodule, that this sha1 is legit.
Although I may be missguided in my thinking here as the superproject
should have no influence on the submodule.
