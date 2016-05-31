From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Tue, 31 May 2016 10:45:54 +0200
Message-ID: <574D4F42.3090807@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <xmqqr3ci7o73.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 10:46:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7fJP-0003i6-V4
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 10:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbcEaIqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 04:46:01 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52586 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756618AbcEaIp6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 04:45:58 -0400
X-AuditID: 12074412-51bff700000009f7-12-574d4f45b802
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.CC.02551.54F4D475; Tue, 31 May 2016 04:45:57 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V8jtoh004548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 31 May 2016 04:45:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqr3ci7o73.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqOvq7xtusPe1jMX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zA6vHzll32T2e9e5h9Lh4SdljwfP77B6fN8kFsEZx2yQllpQFZ6bn
	6dslcGdcXvCPreCgaMWfO1OZGhi3CnYxcnJICJhIfFryi6mLkYtDSGAro8T+/2cYIZwLTBK7
	5+9lBakSFnCQuPu5iQXEFhFQk5jYdogFomgno8TPy+vYQRxmgc2MErPPd7GBVLEJ6Eos6mlm
	ArF5BbQlzjw5CTaJRUBVYuWjf2A1ogIhEufXbWWFqBGUODnzCdgGTgFriZ4Tc9hBbGYBPYkd
	13+xQtjyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6aX
	m1mil5pSuokREtBCOxjXn5Q7xCjAwajEwxvR7RMuxJpYVlyZe4hRkoNJSZTX6jdQiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkghvvZdvuBBvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILU
	IpisDAeHkgSvoh9Qo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoLuOLgZEJkuIB
	2psC0s5bXJCYCxSFaD3FqMtxZP+9tUxCLHn5ealS4rxZvkBFAiBFGaV5cCtg6esVozjQx8K8
	aSCjeICpD27SK6AlTEBL4jN8QJaUJCKkpBoYN285+Hx6mpKZJb8H6/S1pkby6qpvF6RKZHxL
	MK3Ten16TtnX7VGdCjZXb1ysOCC+Vf9Sx/TuyCiHmeZ5T/88ev9sRrLQirC5YRlN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295965>

On 05/31/2016 08:10 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This commit introduces a new iteration primitive for references: a
>> ref_iterator. A ref_iterator is a polymorphic object that a reference
>> storage backend can be asked to instantiate. There are three functions
>> that can be applied to a ref_iterator:
>>
>> * ref_iterator_advance(): move to the next reference in the iteration
>> * ref_iterator_abort(): end the iteration before it is exhausted
>> * ref_iterator_peel(): peel the reference currently being looked at
> 
> This part looked somewhat strange in that it makes "peel" sound
> something very special.  Even though I understand why, it made me
> feel uneasy.  I do not think of another operation like peel that may
> want to have such a specialized helper, so I'll let it pass, but the
> primary uneasiness I felt comes from the fact that "iterator-peel"
> is not an essential service of the API that needs for correctness,
> but is a pure optimization (i.e. you could grab a ref from the
> normal iterator call, and then ask "please peel this ref" to the
> usual ref API that does not know anything about iteration).

I agree that this is inelegant. The underlying reason is that the
iterator embodies both the iteration and also the reference currently
being iterated over. So ref_iterator_advance() and ref_iterator_abort()
are really iterator methods, whereas ref_iterator_peel() is really a
method on the current reference. For that matter, the refname etc fields
are conceptually parts of the current reference, too, not of the iteration.

One of my many coding spikes tried to separate the two concepts by
having the iterator give back a separate object representing the
reference. That object would have had a peel() method. But I wasn't
happy with that approach:

* Anything that made it look like the reference object had a lifetime
independent of that of the iterator seemed like asking for trouble.

* The peel() method would probably have to be a real method that knows
where the reference came from (as opposed to a simple function) because
of things like prefix_ref_iterator, where the refname stored in the
ref_iterator might have had its prefix stripped off.

The complexity level was getting beyond what I felt was tenable in C, so
I made the compromise that you see.

If I had more time I'd do some benchmarking to see whether the "peeling"
optimization is really still needed. It comes from the days when
references were stored in giant lists. Now that we store refs in tries,
and each level gets sorted as part of the iteration anyway, the lookup
might be fast enough that nobody would care.

> [...]

Michael
