From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 16:36:22 -0400
Message-ID: <CAPig+cRbRfOyyx7bx4hM9akN_cO5geZo=cy0+JAprBpnm6qQcw@mail.gmail.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
	<1E307B9A21744983970834F69116F358@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHHnY-0003VL-DC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 22:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbbGTUgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 16:36:24 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33128 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbbGTUgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 16:36:23 -0400
Received: by ykfw194 with SMTP id w194so68394854ykf.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yv9ZWM8zFJLUG2+AtaL4OSD525txEGyHxu1Vbu9GOTA=;
        b=A+qpkbdOoWOh7roBalQZOIyXaFJ58bFdX4mF0mJxcFDfa++xVHzaK7RDY0523HJUy3
         hwoAMEMP9QRkLxFPBiFHGu5bDYz2yXc1D9JNxz1/xFjhn2r3Qcn77Yfv3hWlSOa8+R4D
         hqIQux8VHfqsxTJ0g4WwL6vN/Wu3F/H6PyBeH86N+OhQ7EbEQ7lP3s4XJieG3zpLgei1
         frVUzpqaC0u3Oj6l6oXSld732OneeVoVznD+63G4NeIGZk0nMvaxJUtGU16Kv9ZQJM2V
         pbBM9sw/ZYN0lVqqqrNbP8+u/dQ7i3eOo+et09nfBQTEHhU5BDcY8Ts8saOf1oaQg1yX
         oinA==
X-Received: by 10.13.192.132 with SMTP id b126mr29846525ywd.163.1437424582987;
 Mon, 20 Jul 2015 13:36:22 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 13:36:22 -0700 (PDT)
In-Reply-To: <1E307B9A21744983970834F69116F358@PhilipOakley>
X-Google-Sender-Auth: 9CKAixdqFw57Jo4nknD-R5P40xo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274353>

On Mon, Jul 20, 2015 at 3:36 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>>> +       echo <<\EOF
>>> +       person1@example.com
>>> +       person2@example.com
>>> +       EOF
>>
>> I don't know if it deserves mention that the script must be executable
>> (chmod +x) or should we assume that readers are smart enough to
>> understand this implicitly? (It probably should be mentioned.)
>
> It's there, but it's after the wrap-around. Maybe
> s/(executable)/(must be executable: `chmod +x`)/
> to be fully pedantic.

I did see the "(executable)", but wasn't sure if it meant executable
in the 'chmod +x' sense or executable as another name for "program".

>> This entire above text about "cat $addressfile" seems awfully
>> inappropriate for a manual page, especially the bit about the terrible
>> "cat $file #" hack.
>
> Given that this invocation is why this all kicked off ...
> 'cat list.txt', being the most simple of commands and a first cargo-cult try
> for many, I definitely think it's worthwhile including somehow.
>
> Perhaps one needs to be more direct with the right invocation.
>
> "A simple `--cc-cmd='cat list.txt #'` is a quick-and-dirty way of using an
> address list, while ignoring the patch content."

It seems utterly sinful to promulgate this sort of hack to a wider
audience. If reading addresses from a file is likely to be a common
need, then perhaps it ought to have direct support in git-send-email
(via a new command-line option or something).

Also, this all may be moot once rl/send-email-aliases[1] lands in a
release since users will then be able to say:

    --cc="$(cat recipients.txt)"

provided that the email addresses in recipients.txt are
comma-separated and a POSIX-like shell is being used. Perhaps that
deserves an example in the documentation?

[1]: b1c8a11 (send-email: allow multiple emails using --cc, --to and
--bcc, 2015-06-30)
