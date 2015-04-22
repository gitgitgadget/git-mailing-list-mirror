From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2] refs.c: enable large transactions
Date: Wed, 22 Apr 2015 22:12:17 +0200
Message-ID: <553800A1.3010903@alum.mit.edu>
References: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>	<1429643171-27530-1-git-send-email-sbeller@google.com>	<5537AC00.5060208@alum.mit.edu> <CAGZ79kbb=UUVq8np-ndiMS_id5GaBHpDafDe9ZB3TvsK3xYe_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl10X-0003pF-Gp
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbDVUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:12:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52398 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754379AbbDVUMY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 16:12:24 -0400
X-AuditID: 1207440d-f79976d000005643-52-553800a43e84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 57.58.22083.4A008355; Wed, 22 Apr 2015 16:12:20 -0400 (EDT)
Received: from [192.168.69.130] (p4FC971D5.dip0.t-ipconnect.de [79.201.113.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3MKCHHv002613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 22 Apr 2015 16:12:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAGZ79kbb=UUVq8np-ndiMS_id5GaBHpDafDe9ZB3TvsK3xYe_g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLuEwSLUYMVEfouuK91MFg29V5gt
	Nm9uZ3Fg9liwqdTj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M+6/OMlY8JK/ovPmTbYGxkvc
	XYycHBICJhK3nl5lh7DFJC7cW8/WxcjFISRwmVHi4ctvrBDOBSaJSZ9/s4JU8QpoSxxobQfr
	YBFQlVjX0cQGYrMJ6Eos6mlmArFFBYIkWq9NZYSoF5Q4OfMJC4gtIqAmMXPVbLB6ZoEYiUdH
	usFmCgtYSJw/fxJq2TVGiW1TW8EaOAUCJfadeMgM0aAu8WfeJShbXqJ562zmCYwCs5DsmIWk
	bBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQoKXdwfj/3UyhxgF
	OBiVeHgDWM1DhVgTy4orcw8xSnIwKYnyev0HCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhTfkA
	lONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBWgAwVLEpNT61Iy8wp
	QUgzcXCCDOeSEilOzUtJLUosLcmIB0VrfDEwXkFSPEB7HUHaeYsLEnOBohCtpxgVpcR5F4Ik
	BEASGaV5cGNhKekVozjQl8K8yiBVPMB0Btf9CmgwE9DguG0mIINLEhFSUg2MxVqhPveO270q
	//DX9/jEHJMay3OtobZnQ0w7RCxOcNlxxSd6xW/nUhGfU7tZf2Z/08701bf2ZIgtLlylvy32
	gPz9NCtpRvaZL6UfLrHgrd5TzfM0+yl/ZqD0L98ojVV8yuXv7dKuGtvsUXF9ofxR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267635>

On 04/22/2015 09:09 PM, Stefan Beller wrote:
> On Wed, Apr 22, 2015 at 7:11 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> +     if (lock->lk->fd == -1)
>>> +             reopen_lock_file(lock->lk);
>>
>> You should check that reopen_lock_file() was successful.
> 
> ok
> 
> 
>>> @@ -3762,6 +3779,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>>                                   update->refname);
>>>                       goto cleanup;
>>>               }
>>> +             if (remaining_fds > 0)
>>> +                     remaining_fds--;
>>> +             else
>>> +                     close_lock_file(update->lock->lk);
>>
>> I consider this code a stopgap, and simplicity is more important than
>> optimization.
> 
> Can you explain a bit why you think this is a stopgap?

At the point the lockfile is created, we have all the information we
need to write the new SHA-1 to it and close it immediately. It seems
more straightforward to do it that way than the way it is done in the
current code, where the locking and writing are separated in time and
space and now there is the small extra complication of
maybe-closing-maybe-not. But getting to the final destination requires
more refactoring than would be prudent for the upcoming release.

In other words, I think your fix is OK but that the whole area of code
has still not reached its final form. I am working on a patch series
that does what I have in mind, but it's not ready yet. As I remember I
got stuck when I realized that the reflog for HEAD is updated somewhere
out of the blue without proper locking and I haven't gotten around to
sorting it out yet.

> [...]
>> But just for the sake of discussion, if we planned to keep
>> this code around, it could be improved by not wasting open file
>> descriptors for references that are only being verified or deleted, like so:
> 
> I'll pick that up for the resend.

OK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
