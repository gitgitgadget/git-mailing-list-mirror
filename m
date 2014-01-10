From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Fri, 10 Jan 2014 09:59:25 +0100
Message-ID: <52CFB66D.5070800@alum.mit.edu>
References: <20140107235631.GA10503@sigill.intra.peff.net> <20140107235850.GC10657@sigill.intra.peff.net> <20140108034733.GA17198@sigill.intra.peff.net> <52CD36AF.2080705@alum.mit.edu> <20140109214926.GA32069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 10 09:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1XwO-0004LF-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 09:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbaAJI7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 03:59:38 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58846 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752491AbaAJI7e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 03:59:34 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-c3-52cfb674ac93
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 40.B4.19161.476BFC25; Fri, 10 Jan 2014 03:59:33 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4DD4.dip0.t-ipconnect.de [79.221.77.212])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0A8xQqJ006986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Jan 2014 03:59:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140109214926.GA32069@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqFu67XyQQUeSxYGXT1ksuq50M1k0
	9F5htuie8pbR4kdLD7MDq8fOWXfZPZ717mH0uHhJ2ePZgZtsHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ8ydcIalYK92xYMpa5gaGD8pdTFycEgImEj0rwYyOYFMMYkL99azdTFycQgJXGaUmP/h
	KTOEc55J4uSWgywgVbwC2hKLD/1hArFZBFQlzu5axgxiswnoSizqaQaLiwoES6y+/ACqXlDi
	5MwnYLaIgKzE98MbGUGGMgtsYJQ49eceI0hCWMBPYu+ez6wQ254zSuyYdB8swSlgLXHr6lFW
	iFPFJXoag0BMZgF1ifXzhEAqmAXkJba/ncM8gVFwFpJ1sxCqZiGpWsDIvIpRLjGnNFc3NzEz
	pzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJOz5djC2r5c5xCjAwajEw1sw63yQEGtiWXFl7iFG
	SQ4mJVFe781AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8yzYC5XhTEiurUovyYVLSHCxK4rxq
	S9T9hATSE0tSs1NTC1KLYLIyHBxKErzGW4EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosS
	S0sy4kHxG18MjGCQFA/QXi+Qdt7igsRcoChE6ylGXY4VGz79YRRiycvPS5US5/27BahIAKQo
	ozQPbgUsyb1iFAf6WJiXHWQUDzBBwk16BbSECWiJaNg5kCUliQgpqQZG1wd196YdCUkTFLyp
	+PHOF8aM1pp7s8Slg9ViKjzu+B0NP+87R8vsQPw0T/9Py15mKr44dmfXmt8ZmUeS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240297>

On 01/09/2014 10:49 PM, Jeff King wrote:
> On Wed, Jan 08, 2014 at 12:29:51PM +0100, Michael Haggerty wrote:
> 
>>> Here's a fixed version of patch 3/5.
>>
>> v2 4/5 doesn't apply cleanly on top of v3 3/5.  So I'm basing my review
>> on the branch you have at GitHub peff/git "jk/cat-file-warn-ambiguous";
>> I hope it is the same.
> 
> Hrmph. I didn't have to do any conflict resolution during the rebase, so
> I would think it would apply at least with "am -3".

That may be; I didn't try with "-3".

> [...]
>>>  static int do_for_each_entry(struct ref_cache *refs, const char *base,
>>> -			     each_ref_entry_fn fn, void *cb_data)
>>> +			     each_ref_entry_fn fn, void *cb_data,
>>> +			     int flags)
>>>  {
>>>  	struct packed_ref_cache *packed_ref_cache;
>>>  	struct ref_dir *loose_dir;
>>
>> A few lines after this, do_for_each_entry() calls
>> prime_ref_dir(loose_dir) to ensure that all of the loose references that
>> will be iterated over are read before the packed-refs file is checked.
>> It seems to me that prime_ref_dir() should also get a flags parameter to
>> prevent it reading more loose references than necessary, something like
>> this:
> 
> Hmm. I hadn't considered that, but yeah, it definitely nullifies part of
> the purpose of the optimization.
> 
> However, is it safe to prime only part of the loose ref namespace? The
> point of that priming is to avoid the race fixed in 98eeb09, which
> depends on us caching the loose refs before the packed refs. But when we
> read packed-refs, we will be reading and storing _all_ of it, even if we
> do not touch it in this traversal. So it does not affect the race for
> this traversal, but have we setup a cache situation where a subsequent
> for_each_ref in the same process would be subject to the race?

prime_ref_dir() is called by do_for_each_entry(), which all the
iteration functions pass through.  It is always called before the
iteration starts, and it primes only the subtree of the refs hierarchy
that is being iterated over.  For example, if iterating over
"refs/heads" then it only primes references with that prefix.

This is OK, because if later somebody iterates over a broader part of
the refs hierarchy (say, "refs"), then priming is done again, including
re-checking the packed refs.  If the packed-refs file was changed
between the iterations, then the first iteration (if it is still
running) continues using the old packed-refs cache while the second
iteration uses the new packed-refs cache.  (So the first iteration will
have a stale, but self-consistent, view of the references.)

If do_for_each_entry() gets the DO_FOR_EACH_NO_RECURSE option, then it
knows that it will only traverse one level of the refs hierarchy.  So if
it passes the option to prime_ref_dir(), then the same level will be
primed.  If somebody later iterates over the same part of the hierarchy
without DO_FOR_EACH_NO_RECURSE, they will re-prime without
DO_FOR_EACH_NO_RECURSE then, if the packed-refs file has been changed,
load a new version of it.  So they will also get a self-consistent view
of the references and I think everything will be OK.

> I'm starting to wonder if this optimization is worth it.

It's true that this is quite a special-case optimization.

I think reference handling will have to move in the direction of
transactions, to remove one or two known race conditions.  That is why I
described the alternative of having the DWIM function do its lookups in
a ref cache.  It would move in the direction of consciously taking a
snapshot of the ref tree and using it for a whole "transaction", which I
think is a style that we will want to use in more places.  It's just
hard to judge whether this alternative would actually solve the
performance problem that you were originally trying to address--a point
that Junio discussed elsewhere in this thread.

(This is something I would be willing to work on if you feel like I am
pushing you to enlarge the scope of your work beyond what you are
interested in.)

>>> [...]
>>> @@ -1718,7 +1732,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
>>>  	data.fn = fn;
>>>  	data.cb_data = cb_data;
>>>  
>>> -	return do_for_each_entry(refs, base, do_one_ref, &data);
>>> +	return do_for_each_entry(refs, base, do_one_ref, &data, flags);
>>>  }
>>
>> This change makes the DO_FOR_EACH_NO_RECURSE option usable with
>> do_for_each_ref() (even though it is never in fact used).  It should
>> either be mentioned in the docstring or (if there is a reason not to
>> allow it) explicitly prohibited.
> 
> Hrm, yeah. I guess there are no callers, and there is no plan for any.
> So we could just pass "0" here, and then "flags" passed to
> do_for_each_ref really is _just_ for the callback data that goes to
> do_one_ref. That clears up the weird "combined namespace" stuff I
> mentioned in the commit message, and is a bit cleaner. I'll take it in
> that direction.

It would also be possible to swing in the other direction.  I don't
remember a particular reason why I left the DO_FOR_EACH_INCLUDE_BROKEN
handling at the do_for_each_ref() level rather than handling it at the
do_for_each_entry() level.  But now that you are passing the flags
parameter all the way down the call stack, it wouldn't cost anything to
support both of the DO_FOR_EACH flags everywhere and just document it
that way.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
