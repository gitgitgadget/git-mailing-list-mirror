From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Tue, 15 Apr 2014 09:33:59 -0700
Message-ID: <CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<534CD376.7080108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 15 18:34:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa6JG-0000FY-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 18:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbaDOQeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 12:34:03 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:37141 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaDOQeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 12:34:00 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so9738094veb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bdAWZgbD/ocDLNN/kscfo2+29T074bh/4A/Zbbms7Tg=;
        b=EjWKzliTghoSp5R8cxtN7hpNCvFHcywUpEVZGlVv7gkDZ0zEh7tBaI4jG8oTj9qbsK
         nA1t2/6cAXINfdSqEwber3CCK8f5gvau4ovykTMu/WW/Q3/6mrtHv7IoeH4e0YW4+MOw
         IArm4Com0WSVR/VfX/+m220Y+6pgl9VpqmV2TzN6YV13MrpWbQPHPxYp4HHr1qDU9PwN
         ec7iUe0KiBbCDqb9gnoznhQAo6lhDGr6nXClHjq3p/Hvqz9LxeMlFPX1KEwpFttD8bym
         iomh06cfKvqJLkYJmifEiXa4McVbXmNWMsytp6Nse23XzQNSqir2FWlENiKN+pGz5MCO
         896Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bdAWZgbD/ocDLNN/kscfo2+29T074bh/4A/Zbbms7Tg=;
        b=BryfQsl6OUrP8GgDTlFBJRPQGFcfqzpsBaua5WsyTlyn/dIkbqqpYKIpq3MA6pw2LI
         fzw3XJ5MjhDR2YAcOyN5lJI4Xe+0CW+AV3YMXXaGyLlRhDQC4F8VW13MRGZB/Cf1IB3x
         bWR5J9EWHsaY5hxlzUG1iDpHo0qOIzpNyrs2AtRzhpTCtvVf+OXtSSmiXZX/yyQSPnl6
         Gd/V99e5Xvwi/D4aV8w0Iv/z6Sg3AO3c508M810rLLJ7KlS1MBJzb7UiCqNMYnyrExJc
         NoZ6v0w3c8lEJEdU6XDiaFRMCmjbp3YUCKgVNJ6dxF7YO2WlTR5B5SW/170LfmeTIhYO
         rL2Q==
X-Gm-Message-State: ALoCoQn4I9moAGYXN8Z2Vvvv2TDx7IUS5TS9Dp/oZ2+JXVGyQ0cDibb1EworRYAuw11Cli5DsXOf7DE9TfHWghD2YzfjKaIVcG6d8O9mH2KP7pEZNCjWSt0bP9P6o2vIBFE9HT7ko1sSYY6bpr8Pf7Lr2FPwu4Q72NVs/V0MEBd001+WsO3HT0NUE8NBy6yW6b7QYBWb7Xjh
X-Received: by 10.58.185.244 with SMTP id ff20mr733096vec.40.1397579639436;
 Tue, 15 Apr 2014 09:33:59 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 15 Apr 2014 09:33:59 -0700 (PDT)
In-Reply-To: <534CD376.7080108@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246288>

On Mon, Apr 14, 2014 at 11:36 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/14/2014 08:29 PM, Ronnie Sahlberg wrote:
>> refs.c:ref_transaction_commit() intermingles doing updates and checks with
>> actually applying changes to the refs in loops that abort on error.
>> This is done one ref at a time and means that if an error is detected that
>> will fail the operation partway through the list of refs to update we
>> will end up with some changes applied to disk and others not.
>>
>> Without having transaction support from the filesystem, it is hard to
>> make an update that involves multiple refs to guarantee atomicity, but we
>> can do a somewhat better than we currently do.
>
> It took me a moment to understand what you were talking about here,
> because the code for ref_transaction_commit() already seems
> superficially to do reference modifications in phases.  The problem is
> that write_ref_sha1() internally contains additional checks that can
> fail in "normal" circumstances.  So the most important part of this
> patch series is allowing those checks to be done before committing anything.

Yes.
This patch series is mainly focused on making ref_transaction_commit()
more atomic
so that it does more checks for failures before it starts doing
irreversible changes to the underlying files.

These patches change ref_transaction_commit() to do even more checks
before it starts applying the
actual changes to disk.


There are also changes to other users of write_ref_sha1() too but
those are mainly just to
reflect that this function no longer actually does the changes to the
underlying files any more.


>
>> These patches change the update and delete functions to use a three
>> call pattern of
>>
>> 1, lock
>> 2, update, or flag for deletion
>> 3, apply on disk  (rename() or unlink())
>>
>> When a transaction is commited we first do all the locking, preparations
>> and most of the error checking before we actually start applying any changes
>> to the filesystem store.
>>
>> This means that more of the error cases that will fail the commit
>> will trigger before we start doing any changes to the actual files.
>>
>>
>> This should make the changes of refs in refs_transaction_commit slightly
>> more atomic.
>> [...]
>
> Yes, this is a good and important goal.
>
> I wonder, however, whether your approach of changing callers from
>
>     lock = lock_ref_sha1_basic() (or varient of)
>     write_ref_sha1(lock)
>
> to
>
>     lock = lock_ref_sha1_basic() (or varient of)
>     write_ref_sha1(lock)
>     unlock_ref(lock) | commit_ref_lock(lock)
>
> is not doing work that we will soon need to rework.  Would it be jumping
> the gun to change the callers to
>
>     transaction = ref_transaction_begin();
>     ref_transaction_{update,delete,etc}(transaction, ...);
>     ref_transaction_{commit,rollback}(transaction, ...);
>
> instead?  Then we could bury the details of calling write_ref_sha1() and
> commit_lock_ref() inside ref_transaction_commit() rather than having to
> expose them in the public API.
>

I think you are right.

Lets put this patch series on the backburner for now and start by
making all callers use transactions
and remove write_ref_sha1() from the public API thar refs.c exports.

Once everything is switched over to transactions I can rework this
patchseries for ref_transaction_commit()
and resubmit to the mailing list.


Lets start preparing patches to change all external callers to use
transactions instead.
I am happy to help preparing patches for this. How do we ensure that
we do not create duplicate work
and work on the same functions?


regards
ronnie sahlberg


> I suspect that the answer is "no, ref transactions are not yet powerful
> enough to do everything that the callers need".  But then I would
> suggest that we *make* them powerful enough and *then* make the change
> at the callers.
>
> I'm not saying that we shouldn't accept your change as a first step [1]
> and do the next step later, but wanted to get your reaction about making
> the first step a bit more ambitious.
>
> Michael
>
> [1] Though I still need to review your patch series in detail.
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
