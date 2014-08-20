From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 16:52:50 +0200
Message-ID: <53F4B642.7020002@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>	<1403275409-28173-44-git-send-email-sahlberg@google.com>	<53BC07FC.8080601@alum.mit.edu>	<20140715180424.GJ12427@google.com>	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com> <CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 16:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK7GQ-0005Cs-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 16:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbaHTOwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 10:52:54 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47550 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861AbaHTOwx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 10:52:53 -0400
X-AuditID: 12074414-f79446d000001f1d-48-53f4b6445efd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 53.86.07965.446B4F35; Wed, 20 Aug 2014 10:52:52 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2242.dip0.t-ipconnect.de [93.219.34.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7KEqoxD028512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 20 Aug 2014 10:52:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1HXZ9iXYYNNjLouuK91MFm9vLmG0
	+DehxoHZY+esu+weCzaVenzeJBfAHMVtk5RYUhacmZ6nb5fAnfHq80/GghXSFf3dSQ2MZ0S7
	GDk5JARMJFoaXjBD2GISF+6tZ+ti5OIQErjMKLGnfw8ThHOOSWLtlCWsXYwcHLwC2hLbT4M1
	swioSrz+MZUdxGYT0JVY1NPMBGKLCgRJzP48DyzOKyAocXLmExYQW0QgQmL2382MIDazgL7E
	pz8HwOqFBRIkrnacZIXYdYpJ4uPNuWAXcQoESnzcu5cdZC+zgLrE+nlCEL3yEtvfzmGewCgw
	C8mKWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokRErQiOxiP
	nJQ7xCjAwajEw3tj0ZdgIdbEsuLK3EOMkhxMSqK8zVuAQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR4T2wAyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfDeBxkqWJSa
	nlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rS+GJgnIKkeID2sm8F2VtckJgLFIVoPcWo
	KCXOqwIyVwAkkVGaBzcWlopeMYoDfSnMKwTSzgNMY3Ddr4AGMwEN3rr4I8jgkkSElFQDYw6j
	R0Ds8vUrJC4ZHORwcrxhffDWRl3xGVHPHZ69XpaTzmt5rEK2QPthfucDEd0wb8XTl9Zlpmmq
	cBrx9SeE/NVMmJLAU76r9k7YN/3DnhdCuR5/PTxhMifv05usD35vqZtR/1J3a7tV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255571>

On 07/15/2014 10:58 PM, Ronnie Sahlberg wrote:
> On Tue, Jul 15, 2014 at 12:34 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> On Tue, Jul 15, 2014 at 11:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Michael Haggerty wrote:
>>>
>>>> So...I like the idea of enforcing refname checks at the lowest level
>>>> possible, but I think that the change you propose is too abrupt.  I
>>>> think it needs either more careful analysis showing that it won't hurt
>>>> anybody, or some kind of tooling or non-strict mode that people can use
>>>> to fix their repositories.
>>>
>>> The recovery code has been broken for a while, so I don't see harm
>>> in this change.
>>>
>>> How to take care of the recovery use case is another question.  FWIW I
>>> also would prefer if "git update-ref -d" or "git branch -D" could be
>>> used to delete corrupt refs instead of having to use fsck (since a
>>> fsck run can take a while), but that's a question for a later series.
>>>
>>> In an ideal world, the low-level functions would allow *reading* and
>>> *deleting* poorly named refs (even without any special flag) but not
>>> creating them.  Is that doable?
>>
>> That should be doable. Ill add these repairs as 3-4 new patches at the
>> end of the current patch series.
>>
>>> The main complication I can see is
>>> iteration: would iteration skip poorly named refs and warn, or would
>>> something more complicated be needed?

I think we can get away with not including broken refnames when
iterating.  After all, the main goal of tolerating them is to let them
be deleted, right?  Then as long as iteration is not needed to implement
the command "git update-ref -d", it seems to me that it is OK if
iterating over a reference with a broken name causes a die().

>> Right now,  "git branch"  will error and abort right away when it
>> finds the first bad ref. I haven't checked the exact spot it does this
>> yet but I suspect it is when building the ref-cache.
>> I will solve the cases for create and delete for now.
>>
>>
>> What/how to handle iterables will require more thought.
>> Right now, since these refs will be filtered out and never end up in
>> ref-cache, either from loose refs or from packed refs
>> it does mean that anyone that uses an iterator is guaranteed to only
>> get refs with valid names passed back to them.
>> We would need to audit all code that uses iterators and make sure it
>> can handle the case where the callback is suddenly
>> invoked with a bad refname.
>>
>>>
>>> Thanks,
>>> Jonathan
> 
> The following seems to do the trick to allow deleting a bad ref. We
> would need something for the iterator too.
> Since this touches the same areas that my ~100 other ref transaction
> patches that are queued up do, I
> would like to wait applying this patch until once the next few series
> are finished and merged.
> (to avoid having to do a lot of rebases and fix legio of merge
> conflicts that this would introduce in my branches).
> 
> 
> Treat this as an approximation on what the fix to repair git branch -D
> will look like once the time comes.

I'm a little worried that abandoning *all* refname checks could open us
up to somehow trying to delete a "reference" with a name like
"../../../../etc/passwd".  Either such names have to be prohibited
somehow, or we have to be very sure that they can only come from trusted
sources.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
