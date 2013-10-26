From: Olivier Revollat <revollat@gmail.com>
Subject: Re: GIT Hooks and security
Date: Sat, 26 Oct 2013 11:27:28 +0200
Message-ID: <CA+nXgrWBue1A9KBXaRwRPi7qFNsrz8CnoyLrdhbALeo=7xborQ@mail.gmail.com>
References: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
	<xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
	<CA+nXgrUcpfya+rTPzfRafzJbK1khNqtz-HsaKeGfdA86AepKEg@mail.gmail.com>
	<CAGyf7-HCEQy2hUnc6UvABDrwYatoUEiPnpXo-e9_8wtbhvN0mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 11:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va09m-00049G-KT
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 11:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab3JZJ1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 05:27:32 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55650 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3JZJ1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 05:27:30 -0400
Received: by mail-wi0-f170.google.com with SMTP id l12so1935984wiv.1
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4GaWuRZ9cbjWj3QZZQSScAjKuXv3Ursu5gSf2TKDnJQ=;
        b=MCAgsgkYgVKgxRIqKYwr2PCtc7zU3H0Qcc6KcF7wvi23m+J1RHxfh3PkMJAFTL5uoX
         MseOXr/VxHMJxgjyJKB4yCVgAQDnf9kNKPSoebGXJNq52DtBxVIangU3k2lI0MjXTZRQ
         Lg8qMphsBcq/CGrI0rK0XbWOsTWi7Pf2nmX/FT5/gBVVzR7h88fgdvDwEQOxrA04gTZ4
         1UKJuGaXil1vd87wMtT77aV/abP7LjUb0LTVckX1UxrckY+UQVOSHMEL+4CqEms6jW5C
         n/cZy776LYrPWbPgAM0hI3kyOGowxnCQK2iWpB8Vd73pRkmhczKdiJap0pF/9ZMQw5T3
         zjEA==
X-Received: by 10.180.185.203 with SMTP id fe11mr1796682wic.29.1382779648748;
 Sat, 26 Oct 2013 02:27:28 -0700 (PDT)
Received: by 10.216.33.3 with HTTP; Sat, 26 Oct 2013 02:27:28 -0700 (PDT)
In-Reply-To: <CAGyf7-HCEQy2hUnc6UvABDrwYatoUEiPnpXo-e9_8wtbhvN0mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236746>

Very helpful :) thanks !

2013/10/26 Bryan Turner <bturner@atlassian.com>:
> No, the .git/hooks directory in your clone is created from your local
> templates, installed with your Git distribution, not the remote hooks.
> On Linux distributions, these templates are often in someplace like
> /usr/share/git-core/templates (for normal packages), and on Windows
> with msysgit they are in share\git-core\templates under your
> installation directory. If you look in this directory you will see a
> hooks directory containing the sample hooks.
>
> Hooks from a remote repository are never cloned. As far as I'm aware,
> nothing from the .git directory (aside from refs and packs, of course)
> is cloned, including configuration. Your .git directory after a clone
> is completely new, assembled from scratch. There's nothing in the Git
> wire protocol (currently) for moving other data like configuration or
> hooks, and this sort of malicious code injection is one of the reasons
> I've seen discussed on the list for why that's the case.
>
> Hope this helps,
> Bryan Turner
>
>
> On 26 October 2013 09:25, Olivier Revollat <revollat@gmail.com> wrote:
>>
>> But when someone do a "clone" he don't have .git/hooks directory
>> downloaded to his local computer ? I thought so ...
>>
>> 2013/10/26 Junio C Hamano <gitster@pobox.com>:
>> > Olivier Revollat <revollat@gmail.com> writes:
>> >
>> >> I was wondering : What if I had a "malicious" GIT repository who can
>> >> "inject" code  via git hooks mechanism : someone clone my repo and
>> >> some malicious code is executed when a certain GIT hook is triggered
>> >> (for example on commit ("prepare-commit-msg' hook))
>> >
>> > In that somebody else's clone, you will not have _your_ malicious
>> > hook installed, unless that cloner explicitly does something stupid,
>> > like copying that malicious hook.
>>
>>
>>
>> --
>> Mathematics is made of 50 percent formulas, 50 percent proofs, and 50
>> percent imagination.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Mathematics is made of 50 percent formulas, 50 percent proofs, and 50
percent imagination.
