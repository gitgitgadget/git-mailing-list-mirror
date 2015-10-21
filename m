From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: Re: [PATCH] git-p4: import the ctypes module
Date: Wed, 21 Oct 2015 11:54:18 +0200
Message-ID: <CAJA=mv5ui6OLc=0OSJg+k5a6bgSxwX=waLmyxtV4=ikWBkXPQg@mail.gmail.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	<xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
	<1445369506.8543.10.camel@kaarsemaker.net>
	<xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com>
	<5626C79C.8060503@diamand.org>
	<CAJA=mv7N=PmL69kgZRjq8P6J_qsfUbLx76WguhvqPrG2o1UFww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 11:54:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoq6D-0002Hj-9L
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 11:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbbJUJyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 05:54:21 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34810 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbbJUJyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 05:54:19 -0400
Received: by igbni9 with SMTP id ni9so90212227igb.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=noBFSoTdhI3nwPpm9fjn9SYxn7tpzAX+twA6byAZnB4=;
        b=e9oWlj46F4rYRBHAnALHHJkyWbl4RnR+Vg8U9MuqRGQjjJoHJDQUT28LWvh1/TUqau
         kt+PG9R2jL1/6eH/iJWAU3Kl0Aa6etABksFb7hbkWO1IMIqJGWRearvnL69Eswvih0l8
         OFc7NZjcsBRwz/xVKVyNSIN2wPSBfcP54f+5ogzRUyKYzKmVPfiLJLnhFrAKmGvohnEl
         41WSOD9o7hwqNKJKo+Uldlk89jyH7O8gkrU9x1h9KuLYWnX9x0iK9QVpi+lF6VJIvbGr
         xnMN3VxGPOCMFMAliDfsyArGOmne1g/3338wBkXIBfFWCoXzQctIjAc1qmrNcwq35Dbz
         wTcw==
X-Received: by 10.50.79.133 with SMTP id j5mr18963556igx.86.1445421258885;
 Wed, 21 Oct 2015 02:54:18 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Wed, 21 Oct 2015 02:54:18 -0700 (PDT)
In-Reply-To: <CAJA=mv7N=PmL69kgZRjq8P6J_qsfUbLx76WguhvqPrG2o1UFww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279978>

I was wrong, the script doesn't work on my machine if ctypes is not
imported regardless of python version. I guess I was confused by using
a version of git-p4 before ctypes was introduced, the failing version
and the patched version, as well as several python versions.

Sorry for this misleading claim, and thanks for the quick fix.

2015-10-21 10:23 GMT+02:00 Etienne Girard <etienne.g.girard@gmail.com>:
> Hello,
>
> I couldn't work further on this yesterday (but I read
> Documentation/SubmittingPatches, which is a good start I guess). The
> diff proposed by Dennis works on my machine, I'll try to figure out
> why the original script worked with 2.7.10.
>
> Thanks
>
> 2015-10-21 1:00 GMT+02:00 Luke Diamand <luke@diamand.org>:
>> On 20/10/15 20:36, Junio C Hamano wrote:
>>>
>>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>>
>>>>> I do not follow Python development, but does the above mean that
>>>>> with recent 2.x you can say ctypes without first saying "import
>>>>> ctypes"?  It feels somewhat non-pythonesque that identifiers like
>>>>> this is given to you without you asking with an explicit 'import',
>>>>> so I am puzzled.
>>>>
>>>>
>>>> No, you cannot do that. The reason others may not have noticed this bug
>>>> is that
>>>> in git-p4.py, ctypes is only used on windows.
>>>>
>>>>   111     if platform.system() == 'Windows':
>>>>   112         free_bytes = ctypes.c_ulonglong(0)
>>>>   113
>>>> ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()),
>>>> None, None, ctypes.pointer(free_bytes))
>>>>
>>>> The fact that it works for the OP with 2.7.10 is puzzling (assuming that
>>>> it's
>>>> on the same system).
>>>
>>>
>>> Exactly.  That is where my "I am puzzled" comes from.
>>>
>>> The patch looks obviously the right thing to do.  Luke?  Lars?
>>
>>
>> It looks sensible to me, and works fine on Linux, thanks. ack.
>>
>> I can't test on Windows today but I can't see why it wouldn't work.
>>
>> Luke
>>
>>
