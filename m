From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Wed, 16 Apr 2014 10:11:21 -0700
Message-ID: <CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<534CD376.7080108@alum.mit.edu>
	<CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
	<534D9741.3010404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTMt-0008Ej-U6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaDPRLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:11:23 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:33543 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaDPRLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 13:11:22 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so11550114veb.28
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AVnkZO/Z3Sn6tIIICQ4pIPxCiVLC3mGcwDGdIkI2cgY=;
        b=CS3qOtAa3ksFUVxDMcEba5Acm9ooQzaf1tZUQVSF4/2MQ8FKjzePj1PTDWr8EZLSIo
         P8DAqKXVfaDYP/tYf+DZQiHBlSeoTk6EI5Rot5zyVRun1iF4ybscbZt2m5LTMTIRlhcv
         0fd4oNl3JT/vnfwTrcnWRaHGR8T1RKvTNBPZbjKwBlnE6m3wZtC2lM1CGja0BjjsO+Vh
         76+mCSGOrX2t3Mi4IZTYeKNd9pL/Ii4GmvBXhgcSMEJPIb5mrFIx9Od/SbZbP8H/j4ce
         /WIRuobSWWW8viUdi+qlJQyAXhz/mQXnwwgP2X6tHJMd6x8xXNLZivrAlEKjALZO9A0z
         OIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AVnkZO/Z3Sn6tIIICQ4pIPxCiVLC3mGcwDGdIkI2cgY=;
        b=Oo+U8CsMJJQfpSXIZ+gnxL9qbMnHd4iH2FI0hXQfdRibpbDe/+9YD2KsjuyI4Yt9lx
         sw62a265H4IiZIxVeKKEKKab0zvlWcICpoLet1x4E6JgHzT58w5I+3IKz4xrfe3aFpeo
         nWJlfTAKjAcHwUZjC6lXHClCHdArryvrIsljIqg3bVS56l/j0Eq2E9PQ3iA1NINoRdFQ
         jAF30mP47dEylyo/hthtIrAKKbDsMerIpcDLP7+04prcsokvW9nA928XM4GhZaybR4XR
         vbKb5OflM+tGymzqKVlKjzyygkRCagePDtVbtYyNYiMboWRCY37tJvMxBGzVYVw2hNdu
         kWoA==
X-Gm-Message-State: ALoCoQkBoWNzoBMHI2vgf8fFCgu508nHg5Y5Wqli+xbG15r3SesgU7qFzTbG2q2FdBfdyChvdwg0FLg1MOjuNzIafodGz40MbugScf+12FfeQsQvoKfkbdKIo01ORpUw1GjNnFNdxctF/s3BWVMqJ3ysxFD5MIAlA5ES03jG3AD4CFrhOFdT3qwvwOfXhWRLwXHO68syPhae
X-Received: by 10.52.65.132 with SMTP id x4mr1127022vds.36.1397668281484; Wed,
 16 Apr 2014 10:11:21 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Wed, 16 Apr 2014 10:11:21 -0700 (PDT)
In-Reply-To: <534D9741.3010404@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246348>

On Tue, Apr 15, 2014 at 1:32 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/15/2014 06:33 PM, Ronnie Sahlberg wrote:
>> On Mon, Apr 14, 2014 at 11:36 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> [...]
>>> I wonder, however, whether your approach of changing callers from
>>>
>>>     lock = lock_ref_sha1_basic() (or varient of)
>>>     write_ref_sha1(lock)
>>>
>>> to
>>>
>>>     lock = lock_ref_sha1_basic() (or varient of)
>>>     write_ref_sha1(lock)
>>>     unlock_ref(lock) | commit_ref_lock(lock)
>>>
>>> is not doing work that we will soon need to rework.  Would it be jumping
>>> the gun to change the callers to
>>>
>>>     transaction = ref_transaction_begin();
>>>     ref_transaction_{update,delete,etc}(transaction, ...);
>>>     ref_transaction_{commit,rollback}(transaction, ...);
>>>
>>> instead?  Then we could bury the details of calling write_ref_sha1() and
>>> commit_lock_ref() inside ref_transaction_commit() rather than having to
>>> expose them in the public API.
>>
>> I think you are right.
>>
>> Lets put this patch series on the backburner for now and start by
>> making all callers use transactions
>> and remove write_ref_sha1() from the public API thar refs.c exports.
>>
>> Once everything is switched over to transactions I can rework this
>> patchseries for ref_transaction_commit()
>> and resubmit to the mailing list.
>
> Sounds good.  Rewriting callers to use transactions would be a great
> next step.  Please especially keep track of what new features the
> transactions API still needs.  More flexible error handling?  The
> ability to have steps in the transaction that are "best-effort" (i.e.,
> don't abort the transaction if they fail)?  Different reflog messages
> for different updates within the same transaction rather than one reflog
> message for all updates?  Etc.
>
> And some callers who currently change multiple references one at a time
> might be able to be rewritten to update the references in a single
> transaction.

As an experiment I rewrite most of the callers to use transactions yesterday.
Most callers would translate just fine, but some callers, such as walker_fetch()
does not yet fit well with the current transaction code.

For example that code does want to first take out locks on all refs
before it does a
lot of processing, with the locks held, before it writes and updates the refs.


Some of my thoughts after going over the callers :

Currently any locking of refs in a transaction only happens during the commit
phase. I think it would be useful to have a mechanism where you could
optionally take out locks for the involved refs early during the transaction.
So that simple callers could continue using
ref_transaction_begin()
ref_transaction_create|update|delete()*
ref_transaction_commit()

but, if a caller such as walker_fetch() could opt to do
ref_transaction_begin()
ref_transaction_lock_ref()*
...do stuff...
ref_transaction_create|update|delete()*
ref_transaction_commit()

In this second case ref_transaction_commit() would only take out any locks that
are missing during the 'lock the refs" loop.

Suggestion 1: Add a ref_transaction_lock_ref() to allow locking a ref
early during
a transaction.


A second idea is to change the signatures for
ref_transaction_create|update|delete()
slightly and allow them to return errors early.
We can check for things like add_update() failing, check that the
ref-name looks sane,
check some of the flags, like if has_old==true then old sha1 should
not be NULL or 0{40}, etc.

Additionally for robustness, if any of these functions detect an error
we can flag this in the
transaction structure and take action during ref_transaction_commit().
I.e. if a ref_transaction_update had a hard failure, do not allow
ref_transaction_commit()
to succeed.

Suggestion 2: Change ref_transaction_create|delete|update() to return an int.
All callers that use these functions should check the function for error.


Suggestion 3: remove the qsort and check for duplicates in
ref_transaction_commit()
Since we are already taking out a lock for each ref we are updating
during the transaction
any duplicate refs will fail the second attempt to lock the same ref which will
implicitly make sure that a transaction will not change the same ref twice.

There are only two caveats I see with this third suggestion.
1, The second lock attempt will always cause a die() since we
eventually would end up
in lock_ref_sha1_basic() and this function will always unconditionally
die() if the lock failed.
But your locking changes are addressing this, right?
(all callers to lock_ref_sha1() or lock_any_ref_for_update() do check
for and handle if the lock
 failed, so that change to not die() should be safe)

2, We would need to take care when a lock fails here to print the
proper error message
so that we still show "Multiple updates for ref '%s' not allowed." if
the lock failed because
the transaction had already locked this file.




>
>> Lets start preparing patches to change all external callers to use
>> transactions instead.
>> I am happy to help preparing patches for this. How do we ensure that
>> we do not create duplicate work
>> and work on the same functions?
>
> I have a few loose ends to take care of on my lockfile patch series, and
> there are a few things I would like to tidy up internal to the
> transactions implementation, so I think if you are working on the caller
> side then we won't step on each other's toes too much in the near future.
>
> I suggest we use IRC (mhagger@freenode) or XMPP (mhagger@jabber.org) for
> small-scale coordination.  I also have a GitHub repo
> (http://github.com/mhagger/git) to which I often push intermediate
> results; I will try to push to that more regularly (warning: I often
> rebase feature branches even after they are pushed to GitHub).  I think
> you are in Pacific Time whereas I am in Berlin, so we will tend to work
> in serial rather than in parallel; that should help.  It would be a good
> habit to shoot each short status emails at the end of each working day.
>
> Of course we should only use one-on-one communication for early work; as
> soon as something is getting ripe we should make sure our technical
> discussions take place here on the mailing list.
>
> Sound OK?
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
