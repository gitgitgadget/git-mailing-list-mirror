From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sun, 7 Feb 2016 14:33:36 +0530
Message-ID: <CAOLa=ZTd2bvhwkCmySWB06ng5hmNH4aRBcgTC+J1xHRZPxwgxA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
 <CAOLa=ZT6aHxT6C5jc9x=YT+AaeTq7=WCcsWHjAYeg3pWF9sVVA@mail.gmail.com> <CAPig+cQo---uvFJeiR1FRO3hmyHFV+on6ajwcmrAeYU4uScu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 10:04:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSLGS-0001oN-L4
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 10:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbcBGJEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 04:04:11 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34250 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcBGJEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 04:04:07 -0500
Received: by mail-vk0-f48.google.com with SMTP id e185so79650664vkb.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ru+RYTcNhtxxPXwkIczK3xKNAZy1f5MTaAVjHMjHysk=;
        b=x41ICdEQR8tzuQQaZtahuT3Dugsm4cYZF5HRjhN5GqBzhkMOryz9YDHpd7HFHEjlU7
         HxEvRSp9BkRZBfQlPWGWiBph23p6xFi3Hys/mgi7MV66jtAapBg6Iv8U/IVOF5kga6RV
         Zvin+U8BrgG79eLaNCwOMeIr1AmeFHSPXimCXHaax4J3MeQssb9IO0+tMGVOxVMxC8XD
         +7LIrW+bxRpSZLhitylzprXF3VSA73IrI7URbxagJ+aDASHgdNnVgO4MwIClIkAXeMyC
         MTm3bvnR4LozXLmZ4SpIlUVMB68KsTD4tOHNonRzuYh6OXDOqVehNRNN+TPKMcd5Dbwx
         wTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Ru+RYTcNhtxxPXwkIczK3xKNAZy1f5MTaAVjHMjHysk=;
        b=QRXphJM7vmn5ZbY3H7p3E59kXM6jAgSzaX3NweNSZkTEbaR+YfrumUliTyUC6UgUvp
         tcfZ1rtFfprchLEg9e1IfQKlwigTo9NaZCUFnnz/paJuOYy5Mk3UZHJNCFv5W0coND15
         KLFle8pVPbk1AcDbcOmBQvFf6yiRjxURQS7NAHDWO1PFJI3gZwmInmu/3XaYjpRauzkD
         nJO8YGUo1z41DZXb41pH/al+dtPAYWqDWfP3JOzV3viY1jVILs/jl83ZvAFmNkuzf7TD
         LCEulJK+j3Z1oB8ecskEKrJrXb677Q5BAHri5P20604xzseVcQxckc7kQ2tae7fs+0F2
         hJLg==
X-Gm-Message-State: AG10YOTEVUzZ2JSI0xeRS9/Ibyx8mdIj9lcBQmD1H+KyQegEBpZ4D2pmxHnhC1aUlrB0Rwxg0VXOlfOoreyE8w==
X-Received: by 10.31.16.218 with SMTP id 87mr14591119vkq.106.1454835845785;
 Sun, 07 Feb 2016 01:04:05 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sun, 7 Feb 2016 01:03:36 -0800 (PST)
In-Reply-To: <CAPig+cQo---uvFJeiR1FRO3hmyHFV+on6ajwcmrAeYU4uScu5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285723>

On Sun, Feb 7, 2016 at 12:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Feb 6, 2016 at 9:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Thu, Feb 4, 2016 at 3:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> -               const char *formatp = strchr(sp, ':');
>>>> -               if (!formatp || ep < formatp)
>>>> -                       formatp = ep;
>>>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>>>> +               arg = memchr(sp, ':', ep - sp);
>>>
>>> Why this change from strchr() to memchr()? I understand that you're
>>> taking advantage of the fact that you know the extent of the string
>>> via 'sp' and 'ep', however, was the original strchr() doing extra
>>> work? Even if this change is desirable, it seems somewhat unrelated to
>>> the overall purpose of this patch, thus might deserves its own.
>>>
>>> Aside from that, although the "expensive" strchr() / memchr() resides
>>> within the loop, it will always return the same value since it doesn't
>>> depend upon any condition local to the loop. This implies that it
>>> ought to be hoisted out of the loop. (This problem is not new to this
>>> patch; it's already present in the existing code.)
>>
>> I'm thinking I'll make a patch for that separately. i.e remove strchr()
>> and introduce memchr() outside the loop.
>
> I'd almost suggest making it two patches: (1) change strchr() to
> memchr(), and (2) hoist it outside the loop. However, it would be nice
> to see this series land with v5, and adding more refactoring patches
> could delay its landing if problems are found with those new patches.
> Consequently, it might make sense to forego any additional refactoring
> for now and just keep the patch as is, except for fixing the
> relatively minor issues (and bug or two) raised in the v4 review. If
> you take that approach, then hoisting memchr() out of the loop can be
> done as a follow-up patch after this series lands.
>

That makes sense too, I'll keep it the way it is in v4 and send a patch
post this series. Thanks

>>>> +               if ((!arg || len == arg - sp) &&
>>>> +                   !memcmp(valid_atom[i].name, sp, len))
>>>>                         break;
>>>>         }
>>>>
>>>> @@ -154,6 +155,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>>>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>>>>         used_atom[at].name = xmemdupz(atom, ep - atom);
>>>>         used_atom[at].type = valid_atom[i].cmp_type;
>>>> +       if (arg)
>>>> +               arg = used_atom[at].name + (arg - atom) + 1;
>>>
>>> This is a harder to understand than it ought to be because it's
>>> difficult to tell at first glance that you don't actually care about
>>> 'arg' in relation to the original incoming string, but instead use it
>>> only to compute an offset into the string which is ultimately stored
>>> in the newly allocated used_atom[]. Re-using 'arg' for a different
>>> purpose (in a manner of speaking) confuses the issue further.
>>>
>>> The intention might be easier to follow if you made it clear that you
>>> were interested in the *offset* of the argument in the string, rather
>>> than a pointer into the incoming string which you ultimately don't
>>> use. A variable named 'arg_offset' might go a long way toward
>>> clarifying this intention.
>>
>> I hope you mean something like this.
>>
>> if (arg) {
>>     int arg_offset;
>>
>>     arg_offset = (arg - atom) + 1;
>>     arg = used_atom[at].name + arg_offset;
>> }
>
> That's one way, but I was actually thinking about computing arg_offset
> earlier in the "is it a valid atom?" loop, which would make it clear
> that you care only about the offset at that point, rather than the
> pointer to the ':' in the original string (since that pointer is never
> itself used other than to compute the offset). However, having tried
> it myself, the code ends up being nosier, thus not necessarily a win,
> so maybe just leave this as is for now.

True, letting it be seems to make sense.

Thanks.

-- 
Regards,
Karthik Nayak
