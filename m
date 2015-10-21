From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: Re: [PATCH] git-p4: import the ctypes module
Date: Wed, 21 Oct 2015 10:23:43 +0200
Message-ID: <CAJA=mv7N=PmL69kgZRjq8P6J_qsfUbLx76WguhvqPrG2o1UFww@mail.gmail.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	<xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
	<1445369506.8543.10.camel@kaarsemaker.net>
	<xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com>
	<5626C79C.8060503@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoogZ-0007kf-48
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbbJUIXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 04:23:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37708 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbJUIXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 04:23:44 -0400
Received: by igbhv6 with SMTP id hv6so32682128igb.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8tSvfDA62UBfyIZtMn2aTPEj1uEm/V3SYYVZkHdm7G4=;
        b=TN1VS8bN3y+L4Ya5Thlbv9M+4Dwf7tGqlMsYx1rKlBtIxdYtPbnEw6YKi/EazXOywj
         cQ8XFzK6/U6/TL1zYRG4kdggA7fmroZJFIL9ogsSdOD1l62VGoyOib62gA4bAyesjNEF
         Ns54Cu+0Fq69v1qk7L4vcngAS5EaGbulqooiEelEaz+mFrPWvWlLsjwwt6/v0PEJ4lJG
         nvQB/3EY/iC7+7RpPLoT5c83E5ExDXvPEEmbCFW5nqcOsiQhBIW62EV75/b+A2VKWH1V
         +qxWHA2Rc3b3pXv+VLmsvJwNgA9Nwf2begr9k0jH05n9RBN5R07h/U+/Fjz0wmRK9J8y
         YSZg==
X-Received: by 10.50.50.137 with SMTP id c9mr28416301igo.23.1445415823792;
 Wed, 21 Oct 2015 01:23:43 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Wed, 21 Oct 2015 01:23:43 -0700 (PDT)
In-Reply-To: <5626C79C.8060503@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279976>

Hello,

I couldn't work further on this yesterday (but I read
Documentation/SubmittingPatches, which is a good start I guess). The
diff proposed by Dennis works on my machine, I'll try to figure out
why the original script worked with 2.7.10.

Thanks

2015-10-21 1:00 GMT+02:00 Luke Diamand <luke@diamand.org>:
> On 20/10/15 20:36, Junio C Hamano wrote:
>>
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>
>>>> I do not follow Python development, but does the above mean that
>>>> with recent 2.x you can say ctypes without first saying "import
>>>> ctypes"?  It feels somewhat non-pythonesque that identifiers like
>>>> this is given to you without you asking with an explicit 'import',
>>>> so I am puzzled.
>>>
>>>
>>> No, you cannot do that. The reason others may not have noticed this bug
>>> is that
>>> in git-p4.py, ctypes is only used on windows.
>>>
>>>   111     if platform.system() == 'Windows':
>>>   112         free_bytes = ctypes.c_ulonglong(0)
>>>   113
>>> ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()),
>>> None, None, ctypes.pointer(free_bytes))
>>>
>>> The fact that it works for the OP with 2.7.10 is puzzling (assuming that
>>> it's
>>> on the same system).
>>
>>
>> Exactly.  That is where my "I am puzzled" comes from.
>>
>> The patch looks obviously the right thing to do.  Luke?  Lars?
>
>
> It looks sensible to me, and works fine on Linux, thanks. ack.
>
> I can't test on Windows today but I can't see why it wouldn't work.
>
> Luke
>
>
