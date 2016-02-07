From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sun, 7 Feb 2016 02:03:19 -0500
Message-ID: <CAPig+cQo---uvFJeiR1FRO3hmyHFV+on6ajwcmrAeYU4uScu5Q@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
	<CAOLa=ZT6aHxT6C5jc9x=YT+AaeTq7=WCcsWHjAYeg3pWF9sVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 08:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSJO3-0008Q0-25
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 08:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbcBGHDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 02:03:21 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35326 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbcBGHDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 02:03:20 -0500
Received: by mail-vk0-f65.google.com with SMTP id e185so3676757vkb.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 23:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tDwD62pCMsO8CqxoqX2/83y8w8gdguBufpukpp3oHIk=;
        b=uqpcv5hqrgpTAvxrj/8BgElpx1HXOHr48tIp02KfleUVWj6aSZc2zOXqSxXodJL2QA
         OzTqE8D9CVJE8SZOoudseWuRYnbhj7gw9LiijJ/QJiK2N9awQsFfdmLdmQCxoH6wb5Lg
         n2n+6llnuQbGKMlKagMibXUJ7FVTAJD6/pWXzrbdyo/IWsxpZj4hq8gqcrPUolXYORyk
         g2BgQitTrBFCm3ZwKqqN0cM++c819qEaOgTyhMSeiVb4pfOnyzR4lmKm51vU2t64VO5V
         3I5TH/HQH57UbYCEkPVjQC4MGhU08wQM3UsBBqEN5qpFvwRb1NCJz9N7ogYuB3Py/dWq
         sE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tDwD62pCMsO8CqxoqX2/83y8w8gdguBufpukpp3oHIk=;
        b=MpPjCnhEJmEcwuOvmfddcjORXbO8PliGNXr9vHTXwSdwzXM48GlC9iLN1pNXnUTfEJ
         wRSmXt+P9ohx6on/S1xTSdeoJnttpLEvg/fJjxjrfNosQh5dYwJ56TlAdejLCkVhSL4G
         FN2s8FdzGuIHMb+e8S+JqGgheiY5C1RAP3mp5+n/GsALte2eY5GUbzG1QdX5pb7BKUYw
         aGtDal7AxgjiTHKs8eureBMdk1YwzuWlL8ganUlbbJQlDBONYJuf/HNI1UPRqIopgsHd
         qnucv5hA2Ovfy4k//FCau4fL2mrEYQE9u27yKyXcKi0cyEMCHnSwmk9B28uBSwoRjWI/
         WL4g==
X-Gm-Message-State: AG10YORVHZIAub/TnQgdGNgvjDuwiQaEP8xw6PTODvnX+e1eHuqz6lzdHMtcwZxxnqlBPzN+VgvhcXkT364ztg==
X-Received: by 10.31.150.76 with SMTP id y73mr15346365vkd.84.1454828599503;
 Sat, 06 Feb 2016 23:03:19 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 6 Feb 2016 23:03:19 -0800 (PST)
In-Reply-To: <CAOLa=ZT6aHxT6C5jc9x=YT+AaeTq7=WCcsWHjAYeg3pWF9sVVA@mail.gmail.com>
X-Google-Sender-Auth: TB6HunOPGncn4bptUcDWdRTmXSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285714>

On Sat, Feb 6, 2016 at 9:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Feb 4, 2016 at 3:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> -               const char *formatp = strchr(sp, ':');
>>> -               if (!formatp || ep < formatp)
>>> -                       formatp = ep;
>>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>>> +               arg = memchr(sp, ':', ep - sp);
>>
>> Why this change from strchr() to memchr()? I understand that you're
>> taking advantage of the fact that you know the extent of the string
>> via 'sp' and 'ep', however, was the original strchr() doing extra
>> work? Even if this change is desirable, it seems somewhat unrelated to
>> the overall purpose of this patch, thus might deserves its own.
>>
>> Aside from that, although the "expensive" strchr() / memchr() resides
>> within the loop, it will always return the same value since it doesn't
>> depend upon any condition local to the loop. This implies that it
>> ought to be hoisted out of the loop. (This problem is not new to this
>> patch; it's already present in the existing code.)
>
> I'm thinking I'll make a patch for that separately. i.e remove strchr()
> and introduce memchr() outside the loop.

I'd almost suggest making it two patches: (1) change strchr() to
memchr(), and (2) hoist it outside the loop. However, it would be nice
to see this series land with v5, and adding more refactoring patches
could delay its landing if problems are found with those new patches.
Consequently, it might make sense to forego any additional refactoring
for now and just keep the patch as is, except for fixing the
relatively minor issues (and bug or two) raised in the v4 review. If
you take that approach, then hoisting memchr() out of the loop can be
done as a follow-up patch after this series lands.

>>> +               if ((!arg || len == arg - sp) &&
>>> +                   !memcmp(valid_atom[i].name, sp, len))
>>>                         break;
>>>         }
>>>
>>> @@ -154,6 +155,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>>>         used_atom[at].name = xmemdupz(atom, ep - atom);
>>>         used_atom[at].type = valid_atom[i].cmp_type;
>>> +       if (arg)
>>> +               arg = used_atom[at].name + (arg - atom) + 1;
>>
>> This is a harder to understand than it ought to be because it's
>> difficult to tell at first glance that you don't actually care about
>> 'arg' in relation to the original incoming string, but instead use it
>> only to compute an offset into the string which is ultimately stored
>> in the newly allocated used_atom[]. Re-using 'arg' for a different
>> purpose (in a manner of speaking) confuses the issue further.
>>
>> The intention might be easier to follow if you made it clear that you
>> were interested in the *offset* of the argument in the string, rather
>> than a pointer into the incoming string which you ultimately don't
>> use. A variable named 'arg_offset' might go a long way toward
>> clarifying this intention.
>
> I hope you mean something like this.
>
> if (arg) {
>     int arg_offset;
>
>     arg_offset = (arg - atom) + 1;
>     arg = used_atom[at].name + arg_offset;
> }

That's one way, but I was actually thinking about computing arg_offset
earlier in the "is it a valid atom?" loop, which would make it clear
that you care only about the offset at that point, rather than the
pointer to the ':' in the original string (since that pointer is never
itself used other than to compute the offset). However, having tried
it myself, the code ends up being nosier, thus not necessarily a win,
so maybe just leave this as is for now.
