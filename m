From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Tue, 15 Apr 2014 22:32:01 +0200
Message-ID: <534D9741.3010404@alum.mit.edu>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>	<534CD376.7080108@alum.mit.edu> <CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 22:32:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaA1c-0008RH-6f
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 22:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaDOUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 16:32:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64525 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913AbaDOUcE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 16:32:04 -0400
X-AuditID: 1207440c-f79656d000003eba-47-534d97434db2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 21.C6.16058.3479D435; Tue, 15 Apr 2014 16:32:03 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97015.dip0.t-ipconnect.de [79.201.112.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3FKW1gE031920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 15 Apr 2014 16:32:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqOs83TfYoKdDxKLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ2x4nYDU8FjyYpD30+wNDDeEuli5OSQEDCRuHi9
	kQnCFpO4cG89G4gtJHCZUaJ3Q2QXIxeQfZ5Jov3SM2aQBK+AtsTb091gNouAqkTvuglgDWwC
	uhKLepqBBnFwiAoESfw5qwhRLihxcuYTFhBbREBT4mb/abBdzAL6Ep/+HACzhQUsJFrmX2OG
	2LWcUeLQoovsIAlOgUCJLdc2sYDMlBAQl+hpDAIxmQXUJdbPE4IYIy+x/e0c5gmMgrOQbJuF
	UDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCFhy7OD8ds6mUOM
	AhyMSjy8M3J8g4VYE8uKK3MPMUpyMCmJ8t6aAhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwruh
	BSjHm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgnT0NqFGwKDU9tSIt
	M6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFLvxxcDoBUnxAO2dANLOW1yQmAsUhWg9xajLsWHb
	mkYmIZa8/LxUKXHeKSBFAiBFGaV5cCtgSeoVozjQx8K8KSBVPMAEBzfpFdASJqAlh8LBlpQk
	IqSkGhj9Y807U1bvDea9Hpv87N4j7VZB1fvzlwXpiJ5dyF10p+nzxoKHZx1lmqyur1ujZX5h
	KptywZcu/g3CPw8WNgXYCkTmF1xVe/S1PsJ5dzeD8WH5mRNXvOP4nBz+9q3PYcb3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246298>

On 04/15/2014 06:33 PM, Ronnie Sahlberg wrote:
> On Mon, Apr 14, 2014 at 11:36 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> I wonder, however, whether your approach of changing callers from
>>
>>     lock = lock_ref_sha1_basic() (or varient of)
>>     write_ref_sha1(lock)
>>
>> to
>>
>>     lock = lock_ref_sha1_basic() (or varient of)
>>     write_ref_sha1(lock)
>>     unlock_ref(lock) | commit_ref_lock(lock)
>>
>> is not doing work that we will soon need to rework.  Would it be jumping
>> the gun to change the callers to
>>
>>     transaction = ref_transaction_begin();
>>     ref_transaction_{update,delete,etc}(transaction, ...);
>>     ref_transaction_{commit,rollback}(transaction, ...);
>>
>> instead?  Then we could bury the details of calling write_ref_sha1() and
>> commit_lock_ref() inside ref_transaction_commit() rather than having to
>> expose them in the public API.
> 
> I think you are right.
> 
> Lets put this patch series on the backburner for now and start by
> making all callers use transactions
> and remove write_ref_sha1() from the public API thar refs.c exports.
> 
> Once everything is switched over to transactions I can rework this
> patchseries for ref_transaction_commit()
> and resubmit to the mailing list.

Sounds good.  Rewriting callers to use transactions would be a great
next step.  Please especially keep track of what new features the
transactions API still needs.  More flexible error handling?  The
ability to have steps in the transaction that are "best-effort" (i.e.,
don't abort the transaction if they fail)?  Different reflog messages
for different updates within the same transaction rather than one reflog
message for all updates?  Etc.

And some callers who currently change multiple references one at a time
might be able to be rewritten to update the references in a single
transaction.

> Lets start preparing patches to change all external callers to use
> transactions instead.
> I am happy to help preparing patches for this. How do we ensure that
> we do not create duplicate work
> and work on the same functions?

I have a few loose ends to take care of on my lockfile patch series, and
there are a few things I would like to tidy up internal to the
transactions implementation, so I think if you are working on the caller
side then we won't step on each other's toes too much in the near future.

I suggest we use IRC (mhagger@freenode) or XMPP (mhagger@jabber.org) for
small-scale coordination.  I also have a GitHub repo
(http://github.com/mhagger/git) to which I often push intermediate
results; I will try to push to that more regularly (warning: I often
rebase feature branches even after they are pushed to GitHub).  I think
you are in Pacific Time whereas I am in Berlin, so we will tend to work
in serial rather than in parallel; that should help.  It would be a good
habit to shoot each short status emails at the end of each working day.

Of course we should only use one-on-one communication for early work; as
soon as something is getting ripe we should make sure our technical
discussions take place here on the mailing list.

Sound OK?
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
