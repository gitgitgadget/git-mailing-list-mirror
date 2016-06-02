From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 12:04:29 -0700
Message-ID: <CAGZ79ka3ku7x7BhBZJ_uHjS0pNLT7NFACUVqNKi=DvtOkSN_bg@mail.gmail.com>
References: <20160601235233.21040-1-sbeller@google.com> <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com> <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com> <57507DFD.6010800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:04:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Xv2-0002w6-9c
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbcFBTEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:04:32 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35827 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFBTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:04:31 -0400
Received: by mail-qg0-f52.google.com with SMTP id 93so1042183qgx.2
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5swj9wdVxIimeonMNIoNlJ6NHYw9dZ/myYjwjwU5kAI=;
        b=JpmvrSGsMwpdgP0YCwYwEAaIFKym8zMu3Q9IRUoJ93PcG5Ydn08y+dvMop2oXwfAjw
         ONwTDUF0ykTb9MfN5OV7h1Eh8HKuqD6YdFs+8uEr5R2EQmtfz0cCrC0GJJ8F/YKqi4OB
         S/jL8sxiRGLa4fQsDq1ig0FtZ/x9Ajw66XLqZQVDrQ4oGIR+pnE7qvFpvb2UL8ca6jur
         zPH8QglALcEhfLjdU11lRGFEhgw4AKqT1Kp3ZshlHx7Fmsfede3tPp+PWT/lsLm3vpFa
         jJ5vXHXg0bPFxd7qN4URajh0DUhPD8nEoXXFaE66tpwzqhgY5GD8puoAdJYaEw9kznrb
         LZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5swj9wdVxIimeonMNIoNlJ6NHYw9dZ/myYjwjwU5kAI=;
        b=P3JG0aUJqprcb42Bo4bSWu/Qrfj3AZH2sGNZ8OHbQJc1bverfQ/xZ7NG3ggynnBCCV
         7QhWB/MpRZE+SGmgj6ytLZ9tUU//49E3PB8lmd5NYNKjzbB2aE59yV7zaVWhFSe6HSF1
         9FvciWVPE6ow11vxZGc3JPt1lnziy2oL3Hpkcps08VyzEyq/Vrt6mnJm0XIur7reqddQ
         tPxm261rPT3Y65bdRS9p0sS3wRg7PNOtgLb5hmK8PO7TdTPCv7ppt3WSrnnwRUXvia/l
         PENBNb3AwX0QxkNfBTKmFCoMX3FuMcUtfsMYCU1NrMErDknreS/CDOLZRPyLne8S+BO+
         UQ/A==
X-Gm-Message-State: ALyK8tICq5cltSkHd6416MXph7sv3G1PGdhSHT+9is6Vk5uYEYKZsXJVQ+rrwX5daS6tWJsBKLCYRep28oLiKic/
X-Received: by 10.140.81.145 with SMTP id f17mr16521697qgd.84.1464894269908;
 Thu, 02 Jun 2016 12:04:29 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 12:04:29 -0700 (PDT)
In-Reply-To: <57507DFD.6010800@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296224>

On Thu, Jun 2, 2016 at 11:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 02/06/16 17:10, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> So, at risk of annoying you, let me continue in my ignorance a little
>>> longer and ask: even if you have to protect all of this 'magic' from
>>> the shell with '/" quoting, could you not use (nested) quotes to
>>> protect the <value> part of an <attr>? For example:
>>>
>>>     git ls-files ':(attr:whitespace="indent,trail,space",icase)'
>>
>> That would be workable, I would think.  Before attr:VAR=VAL
>> extention, supported pathspec <magic> were only single lowercase-ascii
>> alphabet tokens, so nobody would have used " as a part of magic.  So
>> quting with double-quote pair would work.
>
> I was thinking about both ' and ", so that you could do:
>
>    $ ./args ':(attr:whitespace="indent,trail,space",icase)'
>     1::(attr:whitespace="indent,trail,space",icase)
>
>    $ ./args ":(attr:whitespace='indent,trail,space',icase)"
>     1::(attr:whitespace='indent,trail,space',icase)
>
>    $ p=':(attr:whitespace="indent,trail,space",icase)'
>    $ ./args "$p"
>     1::(attr:whitespace="indent,trail,space",icase)
>
>    $ p=":(attr:whitespace=\"indent,trail,space\",icase)"
>    $ ./args "$p"
>     1::(attr:whitespace="indent,trail,space",icase)
>
> but limiting it to " would probably be OK too.
>
>> You'd need to come up with a way to quote a double quote that
>> happens to be a part of VAL somehow, though.
>
> Yes I was assuming \ quoting as well - I just want to reduce the
> need for such quoting (especially on windows).
>
>>                                              I think attribute
>> value is limited to a string with non-whitespace letters; even
>> though the built-in attributes that have defined meaning to the Git
>> itself may not use values with letters beyond [-a-zA-Z0-9,], end
>> users and projects can add arbitrary values within the allowed
>> syntax, so it is not unconceivable that some project may have a
>> custom attribute that lists forbidden characters in a path with
>>
>>       === .gitattributes ===
>>         *.txt forbidden=`"

We restrict the 'forbidden' to follow [-a-zA-Z0-9,], so we could enforce
it for the values, too.


>
>    $ ./args ":(attr:*.txt forbidden=\'\\\",icase)"
>     1::(attr:*.txt forbidden=\'\",icase)

You should lose the *.txt in there, but put it at the back

>  $ ./args ":(attr:forbidden=\'\\\",icase)*.txt"

>
>    $ ./args ':(attr:*.txt forbidden=\'\''\",icase)'
>     1::(attr:*.txt forbidden=\'\",icase)

I see, so quoting by " or ' is preferred. What if the user
wants to do a
    forbidden=',"

so we have to escape those in there, such as

    ./args ':(attr:"forbidden=\',\"")'

We need to escape both ' and ", one for the outer
shell and one for Git parsing.

Does that seem ok?
