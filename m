From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Wed, 2 Apr 2014 08:01:00 +0200
Message-ID: <CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.34477.chriscool@tuxfamily.org>
	<20140402003938.GE6851@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIo-0006sp-3O
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbaDBGBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:01:03 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:42715 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaDBGBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:01:01 -0400
Received: by mail-we0-f179.google.com with SMTP id x48so7397888wes.10
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 23:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3zs52OC234qK6GVjgViPpc/xk5HUXl7uCZYHz/8q470=;
        b=IQ0ypCL+xN6UEGJjVkxjwdaZeq7YNT4q6Txa+6oIONvFtHFfTAhqcwh71l2IJq5aAp
         9HG/luwIfAqfr3a7gcUoO3261RIPSO6uk2Wj8BglDkMYqFd/UFwfgYY54sft767FAI9r
         JbHnRBqwdEogd0x/qg38tb0PrYMes91BWcM5YPOAWPCSHdmKGRhYw7lPd10F0N5EIIwZ
         QP9Y4dsZUQ55nKIkANmR5h9ou0bQGLttSRrqzEsYPbnK73ccvfA+NTPcnJVlpQakKcoj
         U7zemHAPYz8OHQH7zqdAfaAsQ1sDznKoxrP1jAiP5vtuevBCf0cPEvozDAPWUQMrXkjy
         JHpw==
X-Received: by 10.180.188.229 with SMTP id gd5mr25575665wic.54.1396418460649;
 Tue, 01 Apr 2014 23:01:00 -0700 (PDT)
Received: by 10.216.174.68 with HTTP; Tue, 1 Apr 2014 23:01:00 -0700 (PDT)
In-Reply-To: <20140402003938.GE6851@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245694>

Hi,

On Wed, Apr 2, 2014 at 2:39 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (culling cc list)
> Hi,
>
> Christian Couder wrote:
>
>> [Subject: Documentation: add documentation for 'git interpret-trailers']
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> This should be squashed into the patch that introduces the
> interpret-trailers command, IMHO (or if it should be reviewed
> separately, it can be an earlier patch).  That way, someone looking at
> when the command was introduced and wanting to understand what it was
> originally meant to do has the information close by.

Well, the series is not very long, so this patch is quite close to the
beginning anyway.

> Thanks for picking up the 'git commit --fixes' topic and your steady
> work improving the series.
>
> [...]
>> --- /dev/null
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -0,0 +1,123 @@
>> +git-interpret-trailers(1)
>> +=========================
>> +
>> +NAME
>> +----
>> +git-interpret-trailers - help add stuctured information into commit messages
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git interpret-trailers' [--trim-empty] [(<token>[(=|:)<value>])...]
>> +
>> +DESCRIPTION
>> +-----------
>> +Help add RFC 822-like headers, called 'trailers', at the end of the
>> +otherwise free-form part of a commit message.
>> +
>> +This command is a filter. It reads the standard input for a commit
>> +message and applies the `token` arguments, if any, to this
>> +message. The resulting message is emited on the standard output.
>
> Do you have an example?  Does it work like this?
>
>         $ git interpret-trailers 'signoff=Jonathan Nieder <jrnieder@gmail.com>' <<EOF
>         > foo bar baz qux
>         > EOF
>         foo bar baz qux
>
>         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>         $

Yeah, that's the idea. But you need to run something like:

$ git config trailer.signoff.key "Signed-off-by:"

to configure it properly first.

By the way trying your example, I found that it is not currently
adding an empty line before the s-o-b.
I will have a look.

> A short EXAMPLES section could help.

Yeah, it is planned, but not yet implemented, as written in patch 0/11:

"The following features are planned but not yet implemented:
        - add more tests related to commands
        - add examples in documentation
        - integration with "git commit""

> If I am understanding it correctly, would a name like 'git add-trailers'
> work?

It could work but it can modify, not just add trailers.

> How do I read back the trailers later?

Why do you want to read them back?
Right now it should be used in hooks to modify commit messages.

> [...]
>> +By default, a 'token=value' or 'token:value' argument will be added
>> +only if
>
> Why support both '=' and ':'?  Using just one would make it easier to
> grep through scripts to see who is adding signoffs.

That was already discussed previously.
The reason is that people are used to "token=value" for command line
arguments, but trailers appears in the result as "token: value", so it
is better for the user if we support both.

Thanks,
Christian.
