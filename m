From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Tue, 29 Apr 2014 11:35:23 +0200
Message-ID: <535F725B.5000102@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>	<1398442494-23438-17-git-send-email-sahlberg@google.com>	<535AECC5.3090100@alum.mit.edu> <CAL=YDWkJKOM7eo7cknMH4MAAYJ=Ds9PVjUvufHzrBu=neucf4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf4Ro-0003xL-6D
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314AbaD2Jf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:35:28 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59060 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756304AbaD2Jf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 05:35:26 -0400
X-AuditID: 12074412-f79d46d000002e58-9d-535f725d0da7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C7.D0.11864.D527F535; Tue, 29 Apr 2014 05:35:25 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96C32.dip0.t-ipconnect.de [79.201.108.50])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3T9ZNiK013530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 29 Apr 2014 05:35:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <CAL=YDWkJKOM7eo7cknMH4MAAYJ=Ds9PVjUvufHzrBu=neucf4g@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqBtbFB9scOItn0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTtjyZtnrAUN2hU/V81ia2C8KtfFyMkhIWAi8e7H
	RlYIW0ziwr31bF2MXBxCApcZJR6fvMAI4ZxnkrjVcYgdpIpXQFti54JGJhCbRUBVYt2W/8wg
	NpuArsSinmagOAeHqECQxJ+zihDlghInZz5hAbFFBDQlbvafBmtlFtCX+PTnAJgtLOAvsfbB
	U6jFDxklnt+eDnYRp0CgxJQpy9lAZkoIiEv0NAaBmMwC6hLr5wlBjJGX2P52DvMERsFZSLbN
	QqiahaRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQwBXawbj+pNwh
	RgEORiUeXoOouGAh1sSy4srcQ4ySHExKorwG2fHBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	862AcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErznCoEaBYtS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHRG18MjF+QFA/Q3myQdt7igsRcoChE6ylGXY4L
	DStamIRY8vLzUqXEec1AigRAijJK8+BWwNLUK0ZxoI+FedeAVPEAUxzcpFdAS5iAlgT7gi0p
	SURISTUwhkavPBuVwZ32RtT0XPnOJZtW1lVE6zXIHns8U3hqyUJtOetFObz/mR7oJpw7dSBw
	2v/CD/Y1SyJd38VVc256t/eVnFWiY9jc5BUh+TfeHVi2w/zxs/nJljtsm1VnVsnL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247556>

On 04/28/2014 09:16 PM, Ronnie Sahlberg wrote:
> On Fri, Apr 25, 2014 at 4:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>>> Change create_branch to use a ref transaction when creating the new branch.
>>> ref_transaction_create will check that the ref does not already exist and fail
>>> otherwise meaning that we no longer need to keep a lock on the ref during the
>>> setup_tracking. This simplifies the code since we can now do the transaction
>>> in one single step.
>>>
>>> If the forcing flag is false then use ref_transaction_create since this will
>>> fail if the ref already exist. Otherwise use ref_transaction_update.
>>>
>>> This also fixes a race condition in the old code where two concurrent
>>> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
>>> did not protect against the ref already existsing. I.e. one thread could end up
>>> overwriting a branch even if the forcing flag is false.
>>>
>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>> ---
>>>  branch.c | 39 +++++++++++++++++++++++++--------------
>>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/branch.c b/branch.c
>>> index 660097b..23cde1e 100644
>>> --- a/branch.c
>>> +++ b/branch.c
>>> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>>>                  int force, int reflog, int clobber_head,
>>>                  int quiet, enum branch_track track)
>>>  {
>>> -     struct ref_lock *lock = NULL;
>>>       struct commit *commit;
>>>       unsigned char sha1[20];
>>>       char *real_ref, msg[PATH_MAX + 20];
>>> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>>>               die(_("Not a valid branch point: '%s'."), start_name);
>>>       hashcpy(sha1, commit->object.sha1);
>>>
>>> -     if (!dont_change_ref) {
>>> -             lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
>>> -             if (!lock)
>>> -                     die_errno(_("Failed to lock ref for update"));
>>> -     }
>>> -
>>> -     if (reflog)
>>> -             log_all_ref_updates = 1;
>>> -
>>>       if (forcing)
>>>               snprintf(msg, sizeof msg, "branch: Reset to %s",
>>>                        start_name);
>>> @@ -301,13 +291,34 @@ void create_branch(const char *head,
>>>               snprintf(msg, sizeof msg, "branch: Created from %s",
>>>                        start_name);
>>>
>>> +     if (reflog)
>>> +             log_all_ref_updates = 1;
>>> +
>>> +     if (!dont_change_ref) {
>>> +             struct ref_transaction *transaction;
>>> +             char *err = NULL;
>>> +
>>> +             transaction = ref_transaction_begin();
>>> +             if (forcing) {
>>> +                     if (!transaction ||
>>> +                         ref_transaction_update(transaction, ref.buf, sha1,
>>> +                                                NULL, 0, 0) ||
>>> +                         ref_transaction_commit(transaction, msg, &err))
>>> +                       die_errno(_("%s: failed to write ref: %s"),
>>> +                                 ref.buf, err);
>>> +             } else {
>>> +                     if (!transaction ||
>>> +                         ref_transaction_create(transaction, ref.buf, sha1,
>>> +                                                0) ||
>>> +                         ref_transaction_commit(transaction, msg, &err))
>>> +                       die_errno(_("%s: failed to write ref: %s"),
>>> +                                 ref.buf, err);
>>> +             }
>>
>> You've got some indentation problems above.
>>
>> But actually, there seems like a lot of duplicated code here.  Couldn't
>> you instead do a single block with have_old set based on forcing:
>>
>>     ref_transaction_update(transaction, ref.buf, sha1,
>>                            null_sha1, 0, !forcing)
>>
>> ?
> 
> Done, thanks.
> 
> 
> I am not sure how I feel about using _update to create new refs
> since we already have ref_transaction_create for that purpose.
> 
> ref_transaction_update can either be used to update an existing ref
> or it can be used to create new refs, either by passing have_old==0
> or by passing old_sha1==null_sha1 and have_old==1

Hold onto your socks then, because I think in the future update() should
get a have_new parameter too.  That way it can also be used to verify
the current value of a reference by passing have_old=1, have_new=0
without also re-setting the reference unnecessarily like now.  Though I
admit, have_old=have_new=0 might *not* be so useful :-)

> Maybe the api would be cleaner if we would change it so that update
> and create does
> not overlap and thus change _update so that it can only modify refs
> that must already exist ?

I have no compunctions about using update() to create or delete a
reference.  My point of view is that update() is the general case, and
create() and delete() are special-cases that exist only for the
convenience of callers.  For example, our future pluggable backends
might only have to implement update(), and the other two functions could
delegate to it at the abstract layer.

Plus, making this stricter would make it impossible to eliminate
duplicate code like in the example above, which is itself evidence that
update() is a useful abstraction.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
