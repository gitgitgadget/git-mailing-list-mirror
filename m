From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v3] send-email: Improve format of smtp initialization
 error message
Date: Sun, 4 Jan 2015 15:39:52 +0600
Message-ID: <CANCZXo4OAjo8o95RoC-RXjOS1ZsMApaNQ46-shvoBOmVmV1uQQ@mail.gmail.com>
References: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqppb2z3w9.fsf@gitster.dls.corp.google.com>
	<87iogt4d53.fsf@gmail.com>
	<xmqqa925t8sl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 10:40:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7hfI-0006gx-2r
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 10:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbbADJjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 04:39:55 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:57688 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbADJjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 04:39:53 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so57532955obc.10
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qgr/lf19niCc0DV2h7F0buJ3ktHZsWfHE6OdBqdZfag=;
        b=Pot2eunGNB+E7DOMkfZbf9bgu+qPdIMfLm0cp/iDn/cAsWIou+jC8gTnesLxFNFBg+
         LjIdY0+NhaAA9EvdvHl9IGh0T0n15qPhgKoHQK4TO7aFYqRwwkeQNsek6RDlmJ2jaDRQ
         78PF71vtvjVADnEo524acvgK5gJM6QNKZ9JCCavPYuI5WQf7+fonu5eX18srEZu66YKo
         +0jksspO8TOTRfBH48E7vWgCGb6ssBxq2k4SJS6as45AniaY2/8QA1pyBKdRIk0VbkCX
         VAE1VYSio7D5m4ROYHnpL3BInouMyf136+UdQseefSGaYJGB8G4Beg7GBexfUBXL8tDT
         MTGQ==
X-Received: by 10.202.220.85 with SMTP id t82mr46876216oig.43.1420364392206;
 Sun, 04 Jan 2015 01:39:52 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Sun, 4 Jan 2015 01:39:52 -0800 (PST)
In-Reply-To: <xmqqa925t8sl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262004>

Yes, like this, but is it suitable for:

>>      die "msg\n",
>>             "\tvar1=val1\n",
>>             "\tvar2=val2\n",
>>             defined $var3 ? "\tvar3=val3\n" : "";

?

I finally got confused, how to print it...


2014-12-30 22:13 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Kuleshov <kuleshovmail@gmail.com> writes:
>
>> What's about output like this:
>>
>> Unable to initialize SMTP properly. Check config and use --smtp-debug.
>>
>> VALUES:
>>       server=smtp.gmail.com
>>       encryption=
>>       hello=localhost.localdomain
>>       port=587
>
> Hmmm, maybe I am being slow but what's about it?  I thought that was
> what you are trying to give with your patch since the first
> iteration.
>
> Puzzled...
>
>>
>> Junio C Hamano <gitster@pobox.com> @ 2014-12-30 00:50 QYZT:
>>
>>> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>>>
>>>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>>>> ---
>>>>  git-send-email.perl | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>>> index 82c6fea..60dcd8d 100755
>>>> --- a/git-send-email.perl
>>>> +++ b/git-send-email.perl
>>>> @@ -1275,10 +1275,10 @@ X-Mailer: git-send-email $gitversion
>>>>
>>>>             if (!$smtp) {
>>>>                     die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>>>> -                       "VALUES: server=$smtp_server ",
>>>> -                       "encryption=$smtp_encryption ",
>>>> -                       "hello=$smtp_domain",
>>>> -                       defined $smtp_server_port ? " port=$smtp_server_port" : "";
>>>> +                       "\nVALUES: \n\tserver=$smtp_server ",
>>>> +                       "\n\tencryption=$smtp_encryption ",
>>>> +                       "\n\thello=$smtp_domain",
>>>> +                       defined $smtp_server_port ? " \n\tport=$smtp_server_port" : "";
>>>
>>> It may be a good convention to have LF at the beginning of a new
>>> string (i.e. we terminate the old line only when we have something
>>> more to say), but that is true only when we want to end the sentence
>>> without the final newline.  I wonder if that is true in this case;
>>> do we want perl to say "at line # in file X" at the end?
>>>
>>> In any case, you have two output lines that ends with a trailing SP
>>> just before LF, which is probably not what you wanted.
>>>
>>> If we want to see all lines end with LF, it may be far easier to
>>> read this way:
>>>
>>>      die "msg\n",
>>>             "\tvar1=val1\n",
>>>             "\tvar2=val2\n",
>>>             defined $var3 ? "\tvar3=val3\n" : "";
>>>
>>> I dunno.
>>
>> --
>> Best regards.
>> 0xAX



-- 
_________________________
0xAX
