From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: use catfile() to concatenate files
Date: Tue, 14 Sep 2010 20:42:52 +0000
Message-ID: <AANLkTikEe_KNmXUmTtVSRjKy4QbhAmSJ9jXz2y0dO9Em@mail.gmail.com>
References: <1284490944-16964-1-git-send-email-avarab@gmail.com>
	<7v7hio86tz.fsf@alter.siamese.dyndns.org>
	<AANLkTim7y3qUqQ4TN4w9+5qwR-uLmCP=dTKnMUSnqUrP@mail.gmail.com>
	<m3iq28kqs4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:43:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvcLD-0000Is-4q
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0INUmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 16:42:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52097 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0INUmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 16:42:53 -0400
Received: by iwn5 with SMTP id 5so6347415iwn.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+85WPHtXxc++dWMG2sltGNdoP+6xTqLPXaKmDZj3C64=;
        b=Pe3+6nTK2gY3tB2zzl8AJN15rueqITSHAlKt9HzvZcPGxffZeE+Lk4gz/XHkr06ZfZ
         Mqgodg52VgC0kswnTO0v8WmMQx4MknRhoOWbw+EsuuLw/6R/wKj1LcEansIz8324RyVk
         8j1eJhlHyMyz0YVEOKbk/eMQ+A69yo2Y6J7Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PfCETGuU2O0L+Qa5SiWgWOV9NRLKpdzcnQs7QwZsZ6z3J+YKX2shi4tpjnJMIYG56h
         gGol9bAE5dHQzZBA6RXSpp2UYLnTZyWy754gqAmq4sB7IpJSHN8F4rbS3spjQQxosR/Z
         LEBxk2YB4Y2JzXR2A7xyb7zkjK1xXiFdcYWFQ=
Received: by 10.231.85.206 with SMTP id p14mr436104ibl.89.1284496972936; Tue,
 14 Sep 2010 13:42:52 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 14 Sep 2010 13:42:52 -0700 (PDT)
In-Reply-To: <m3iq28kqs4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156211>

On Tue, Sep 14, 2010 at 20:35, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> On Tue, Sep 14, 2010 at 19:26, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> Change send-email to use Perl's catfile() function instead of
>>>> "$dir/$file". If send-email is given a $dir that ends with a / we'=
ll
>>>> end up printing a double slashed path like "dir//mtfnpy.patch".
>>>>
>>>> This doesn't cause any problems since Perl's IO layer will handle =
it,
>>>> but it looks ugly.
>>>>
>>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
>>>
>>> If you mentioned in the proposed log message that File::Spec::Funct=
ions
>>> have been with us since Perl 5.6.1, it would have saved me (and oth=
ers)
>>> some time worrying about the portability issues.
>>
>> I thought you might trust me to write portable code by default :)
>>
>> Anyway, I forgot to mention it. But one can use the corelist(1)
>> program to see when what modules appeared in perl core:
>>
>> =C2=A0 =C2=A0 $ corelist File::Spec::Functions
>> =C2=A0 =C2=A0 File::Spec::Functions was first released with perl 5.0=
0504
>
> Also using File::Spec / File::Spec::Functions makes code more portabl=
e
> (with respect to things such as different directory separators, and
> volume portion of pathname) than using "$dir/$file".

Right, but perl mitigates that to some extent by converting Unix paths
on-the-fly
to whatever the native platform uses. But of course that falls down in
cases like Win32
volume labels.
