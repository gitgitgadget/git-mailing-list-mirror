From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Wed, 16 Apr 2014 14:31:17 -0700
Message-ID: <CAL=YDWnHtPedxYmpycgSybZA=CmdD55XQAFdA-Bs_42bk2Z0Tg@mail.gmail.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<534CD376.7080108@alum.mit.edu>
	<CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
	<534D9741.3010404@alum.mit.edu>
	<CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com>
	<xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXQS-0000JU-J0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 23:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbaDPVbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 17:31:19 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:63732 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbaDPVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 17:31:18 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so11200077veb.24
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4X2eIhKpGBtyH/07HXIj3sEAn+mP71KAGvQs6Dts2WM=;
        b=T5WPo/SFxqbeAWqb//irCBsH9NZGrjaP0Qt7N8coWg1se3/KrxQzqHopHyvYTSuwis
         HRwAlsXvMo5C9JPJnjQRJQRta4Y4nMOVeWSYPYCPV6Y37BkxEeE0BtwLCJLafWDmWRIJ
         lFU5L2yIVWs2EMdkguugAtPvAaov4dyj601znPNQLfbQhZer2DBI0NIDbB3Aixu5slS9
         eEGQvjxhXIkwIXADxY7GrVhQBhRQsAoqOa+4K/oh79HH8daGbYLALspPDrCT8VjWzkBV
         EKd96ulAQD5hPEfIyUnxD8Qorp4Qjr6gXQCbut6KYfb9WI7kbiCpVSQU5JFeaYxI6Wcd
         9Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4X2eIhKpGBtyH/07HXIj3sEAn+mP71KAGvQs6Dts2WM=;
        b=ROtl32AU52N5/kD/On37sbN9XTXQODTJDTf3CxZnLpX57Wg0N7ujF3Gbw/MY9VCdFL
         s4qnky7VA3JkbL1dzeOCNQyzb/dSeJO9maxs7Vedh73DfOsXSywrqn7enXg2/9efwWB9
         NfgT1yvOQfuVzCNJGVGrhip5i87Fub7XlvmnwlU17pggUfqSN4Y5yL7kaPZxlk8grTiV
         GHmEgkIBA324t2VgkJ9gOJgqJJHXdJ31+08GQkEEl1vjYJ/wgO88yv2UoZ5BN0+jQRo+
         eUHJG1gCNSjHSyaywLItA/chp5gtzVApYB6Gde+3nv2Z7qvFhipBcfxlE7ZO8RkdWGsx
         ljQA==
X-Gm-Message-State: ALoCoQl6My9xWdmB5CVBxprLAKCZDjCKHX0u5wRJ+KO9mk7VPOd0ESJ/9BqKhY544Bo00X5fYfXQBM6pt8OI3xBWzbTGUqBQxwknKuiYiKUqs4BJx8T4CqRrQkrEmlFaPT9DbNA8fKMkFA+nmG+k+DD9fnp9B9VvjZe78hzdmUS5N7oUi3A1RYx/65W2gi837ycz096rPLxq
X-Received: by 10.220.191.134 with SMTP id dm6mr3945846vcb.16.1397683877912;
 Wed, 16 Apr 2014 14:31:17 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Wed, 16 Apr 2014 14:31:17 -0700 (PDT)
In-Reply-To: <xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246382>

On Wed, Apr 16, 2014 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Currently any locking of refs in a transaction only happens during the commit
>> phase. I think it would be useful to have a mechanism where you could
>> optionally take out locks for the involved refs early during the transaction.
>> So that simple callers could continue using
>> ref_transaction_begin()
>> ref_transaction_create|update|delete()*
>> ref_transaction_commit()
>>
>> but, if a caller such as walker_fetch() could opt to do
>> ref_transaction_begin()
>> ref_transaction_lock_ref()*
>> ...do stuff...
>> ref_transaction_create|update|delete()*
>> ref_transaction_commit()
>>
>> In this second case ref_transaction_commit() would only take out any locks that
>> are missing during the 'lock the refs" loop.
>>
>> Suggestion 1: Add a ref_transaction_lock_ref() to allow locking a ref
>> early during
>> a transaction.
>
> Hmph.
>
> I am not sure if that is the right way to go, or instead change all
> create/update/delete to take locks without adding a new primitive.

ack.

>
>> A second idea is to change the signatures for
>> ref_transaction_create|update|delete()
>> slightly and allow them to return errors early.
>> We can check for things like add_update() failing, check that the
>> ref-name looks sane,
>> check some of the flags, like if has_old==true then old sha1 should
>> not be NULL or 0{40}, etc.
>>
>> Additionally for robustness, if any of these functions detect an error
>> we can flag this in the
>> transaction structure and take action during ref_transaction_commit().
>> I.e. if a ref_transaction_update had a hard failure, do not allow
>> ref_transaction_commit()
>> to succeed.
>>
>> Suggestion 2: Change ref_transaction_create|delete|update() to return an int.
>> All callers that use these functions should check the function for error.
>
> I think that is a very sensible thing to do.
>
> The details of determining "this cannot possibly succeed" may change
> (for example, if we have them take locks at the point of
> create/delete/update, a failure to lock may count as an early
> error).
>
> Is there any reason why this should be conditional (i.e. you said
> "allow them to", implying that the early failure is optional)?

It was poor wording on my side. Checking for the ref_transaction_*()
return for error should be mandatory (modulo bugs).

But a caller could be buggy and fail to check properly.
It would be very cheap to detect this condition in
ref_transaction_commit() which could then do

  die("transaction commit called for errored transaction");

which would make it easy to spot this kind of bugs.


>
>> Suggestion 3: remove the qsort and check for duplicates in
>> ref_transaction_commit()
>> Since we are already taking out a lock for each ref we are updating
>> during the transaction
>> any duplicate refs will fail the second attempt to lock the same ref which will
>> implicitly make sure that a transaction will not change the same ref twice.
>
> I do not know if I care about the implementation detail of "do we
> have a unique set of update requests?".  While I do not see a strong
> need for one transaction to touch the same ref twice (e.g. create to
> point at commit A and update it to point at commit B), I do not see
> why we should forbid such a use in the future.
>

ack.
