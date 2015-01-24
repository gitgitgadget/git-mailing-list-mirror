From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 16:22:57 -0800
Message-ID: <CAGZ79kYPCFBNNkYV0C_XeCEaqfz=Mh3Zy=L-vAWsmZBFgebqNQ@mail.gmail.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-6-git-send-email-sbeller@google.com>
	<xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEoVC-00076R-GU
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbbAXAW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:22:59 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47796 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbAXAW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:22:57 -0500
Received: by mail-ie0-f174.google.com with SMTP id vy18so394048iec.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=goSLLUM0gV/0+tHzIe0TTdwvqWh5UNLJX9cbfgUCeWc=;
        b=Wrjis9XnSkWd/9Jq32izh3DQCxgIWh2bn3GY5by/eccqas6D8uGsAfERWHy0B4SkEO
         G1DRWY6XuBsTguR6BYDhA2qFUnslxjUbsb2kRn2Y+yDLjzK9q6EkDmgHGDsiAWeBClT9
         GF55l2LCqrzcV9+aGwPc8RetRUvBLTAo2mxCf3dHfwPM+xlL52X2aSo4xCxeBwEUlRbI
         I7gtktVa38IGGezVWZEMVCBp12o3VxbxKkAlsXpa+tBa3PLqhYeU8ghpmQ3wPI823yKO
         06+cCZv4SF0U+P8OwRoOcIIMlXbkOsugOdJbkN3QYVfzcXauinu6Pw9cldXHEy5c5Yhj
         Uqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=goSLLUM0gV/0+tHzIe0TTdwvqWh5UNLJX9cbfgUCeWc=;
        b=KhrY0KkUI0f6Uq+qGa2ZsCWOuqtjSXZOzPCPR1kG14Y5Lr8tr6d1dKarsKvQPO0wRt
         V+anKGYo2dK8uGfJ2SrePtRvO2zNNv6ELH0EXtWKypHkAYRb1neBJKzWja9vjQ3U0Eqz
         8gBGHX8RW9w2510g69NgkpjF/RY2WCAD/lsHaxXOAlQXMyP5Q2MNNN10UXMS0adXqetl
         cD/pdEmFlR4SD1/iinDRuAMNZLP0XwBEqBlHreTpBgJ5PLLbrJu73LcrlbpORiwXU4TJ
         BEQTXlHSweIfZGdhfrQraJpYAL0yfmkHSrMuMD07IfWRY+h94mytr8fnf12V7KjyxMlG
         eWiA==
X-Gm-Message-State: ALoCoQlJExM3tOtAMKp0GTUh+HctPq+StzCgE1XX5gM/WBt25xm2/6gCR1uZaKV7Fco6orH3naY3
X-Received: by 10.107.128.79 with SMTP id b76mr6974575iod.73.1422058977127;
 Fri, 23 Jan 2015 16:22:57 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 16:22:57 -0800 (PST)
In-Reply-To: <xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262978>

On Fri, Jan 23, 2015 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> -static int commit_ref(struct ref_lock *lock)
>> +static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>>  {
>> +     if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>> +             return 0;
>>       if (commit_lock_file(lock->lk))
>>               return -1;
>>       return 0;
>> @@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>       }
>>       lock->force_write = 1;
>>       hashcpy(lock->old_sha1, orig_sha1);
>> -     if (write_ref_sha1(lock, orig_sha1, logmsg)) {
>> +     if (write_ref_sha1(lock, orig_sha1, logmsg)
>> +         || commit_ref(lock, orig_sha1)) {
>> +             unlock_ref(lock);
>
> This is not a new problem, but the two lines in pre-context of this
> patch look strange.

Which (not new) problem are you talking about here? Do you have
a reference?

> Regardless of what this particular caller does, I am not sure if the
> early-return codepath in commit_ref() is correct.  From the callers'
> point of view, it sometimes unlocks the ref (i.e. when a different
> SHA-1 is written or force_write is set) and sometimes keeps the ref
> locked (i.e. when early-return is taken).  Shouldn't these two cases
> behave identically?  Or am I wrong to assume that the early return
> using "hashcmp(lock->old_sha1, sha1)" is a mere optimization?
>

I assumed it was not just an optimization as the test suite fails if I
touch that line. I'll look into cleaning it up in a more obvious fashion.
