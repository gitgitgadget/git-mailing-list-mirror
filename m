From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 19/19] refs.c: pass **transaction to commit and have it
 clear the pointer
Date: Tue, 29 Apr 2014 11:58:41 -0700
Message-ID: <CAL=YDWmrWT_N8k19t86tfHoTNSbpKh6qRSh-XMUvO9u4fdGk=Q@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-20-git-send-email-sahlberg@google.com>
	<535B0C6F.509@alum.mit.edu>
	<CAL=YDWkSdiUd-6A60ncGaDrFV2pc5WtRMv8iCSHHqFLkKH=pfw@mail.gmail.com>
	<535F6FFD.90004@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:58:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDEt-0001yp-DE
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbaD2S6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:58:42 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:32911 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbaD2S6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:58:42 -0400
Received: by mail-ve0-f182.google.com with SMTP id jw12so838350veb.13
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=glsaMJekmJakSOzVeZSbXds/DiSThBVwMyBLixgxC2g=;
        b=kuphMSAgszuJC54WlGs7wxOtlPl5XFxmhCRF8RIdrqHbwq5SlpaX/MPpR1FyVZDMpT
         NUAfJtcLu+iheeLD8lQi5DR89dgP+2Y6PK6Fx+gpjBYZ9hydxCLDuA9Qzb3nUgl/K5Ie
         T9Il7LE1Bo3WZ4tuTYvLx/Iw8ZqVpE16R73WzjdAM12zA9lHVQF/Up/sdDsH0XkliWpt
         RhSket2Ng/t3wRE0ydl+OEY6A82fi7SGNNY23WZQ8IDZOABRBzrg8inigq2gj92W4ago
         0wdiP/vOR7Nc5p5pJb6gakv0mf2mQRBd4uEbUwir7uyZqoPGm2C5S0AGOcLSYebtHwDq
         rviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=glsaMJekmJakSOzVeZSbXds/DiSThBVwMyBLixgxC2g=;
        b=CTo/hN9ou3cZJVLetzSqcc4INh0cuaxv4aFaRP92wcJL6KNQ+wc8cDo790RlxxjvCA
         w3UPlnO4iiPPhLOibbrbavhYkNagCcLAz0GNekCZ9yoQLiIqczchY1rZ9oQWSGFGx3+w
         rL+2+aZ4GoYwv09zVdn+H9ZJjy48s6zJ8XALD/eRsTVVqaUx7OI+YDcImBzn9/QgOHbs
         4zHuqw/Wntd2nt3wBWFV6iXvQDUyucTUKcGwA7MinEn9YvB25Ki7IVhjgdbMidvzxc8d
         uo7bDCCYrlxFLo1EPYermmdp1A7ymB7ETYxmIkuHWC8Lm+WzmCGQ8FRIj27tM0SOjjqB
         Dabg==
X-Gm-Message-State: ALoCoQluYue6I9JdlMih5TNxGpv523MT5Va/TDhq08u226f+l2TItue1S+LamAVb1uMgm+6XgvVMfEblm7KSND4CNacKxJ4s71knMt6y+7JD+jeLkLE1dd4PJI3P0pPA++wnQhRHHTVpWJIlLrRo+d+MkIOYdV/I83GGJyZS9p7XFpYoAIWwp9Uuaq/6d84XDfTmybpsAyTf
X-Received: by 10.52.164.237 with SMTP id yt13mr26330755vdb.18.1398797921205;
 Tue, 29 Apr 2014 11:58:41 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 11:58:41 -0700 (PDT)
In-Reply-To: <535F6FFD.90004@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247602>

On Tue, Apr 29, 2014 at 2:25 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/28/2014 07:59 PM, Ronnie Sahlberg wrote:
>> On Fri, Apr 25, 2014 at 6:31 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>>>> Change ref_transaction_commit to take a pointer to a pointer for the
>>>> transaction. This allows us to clear the transaction pointer from within
>>>> ref_transaction_commit so that it becomes NULL in the caller.
>>>>
>>>> This makes transaction handling in the callers much nicer since instead of
>>>> having to write horrible code like :
>>>>       t = ref_transaction_begin();
>>>>       if ((!t ||
>>>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>>>                                  !!oldval)) ||
>>>>           (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
>>>>               ref_transaction_rollback(t);
>>>>
>>>> we can now just do the much nicer
>>>>       t = ref_transaction_begin();
>>>>       if (!t ||
>>>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>>>                                  !!oldval) ||
>>>>           ref_transaction_commit(&t, action, &err)) {
>>>>               ref_transaction_rollback(t);
>>>
>>> I understand the motivation for this change, but passing
>>> pointer-to-pointer is unconventional in a case like this.  Unfortunately
>>> I ran out of steam for the night before I could think about alternatives.
>>
>> I see.
>> Yes passing a pointer to pointer is not ideal.
>> But I still want to be able to use the pattern
>>        t = ref_transaction_begin();
>>        if (!t ||
>>            ref_transaction_update(t, ...) ||
>>            ref_transaction_commit(t, ...)) {
>>                ref_transaction_rollback(t);
>>
>> Maybe the problem is that ref_transaction_commit() implicitely also
>> frees the transaction.
>>
>>
>> What about changing ref_transaction_commit() would NOT free the
>> transaction and thus a caller would
>> always have to explicitely free the transaction afterwards?
>>
>> Something like this :
>>        t = ref_transaction_begin();
>>        if (!t ||
>>            ref_transaction_update(t, ...) ||
>>            ref_transaction_commit(&t, ...)) {
>
> You wouldn't need the "&" here then, right?
>
>>                ref_transaction_rollback(t);
>>        }
>>        ref_transaction_free(t);
>
> That sounds like a better solution.  We would want to make sure that
> ref_transaction_commit() / ref_transaction_rollback() leaves the
> ref_transaction in a state that if it is accidentally passed to
> ref_transaction_update() or its friends, the function calls die("BUG: ...").

Thanks!

Good idea.
I will add a transaction->status field that can track OPEN/CLOSED/ERROR
and die(BUG:...) appropriately in _commit/_create/_delete/_update if
it has the wrong value.


>
> Unless we want to make ref_transaction objects reusable.  But then we
> would need an explicit "allocation" step in the boilerplate code:
>
>     t = ref_transaction_alloc();
>     while (something) {
>             if (ref_transaction_begin(t) ||
>                  ref_transaction_update(t, ...) ||
>                  ref_transaction_commit(t, ...)) {
>                     ref_transaction_rollback(t);
>             }
>     }
>     ref_transaction_free(t);
>
> Note that ref_transaction_begin() should in this case be converted to
> return 0-on-OK, negative-on-error for consistency.
>
> This would bring us back to the familiar pattern alloc...use...free.
>
> I was going to say that the extra boilerplate is not worth it, and
> anyway reusing ref_transaction objects won't save any significant work.
>  But then it occurred to me that ref_transaction_alloc() might be a
> place to do more expensive work, like creating a connection to a
> database, so reuse could potentially be a bigger win.

ACK, but I don't think we need reusable transaction yet. Once the API
is cleaned up
it should be reasonably easy to add in the future if we see a need for it.
Sounds reasonable to you ?


>
> All in all, either way is OK with me.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
