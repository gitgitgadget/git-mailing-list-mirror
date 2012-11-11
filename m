From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sun, 11 Nov 2012 01:58:33 +0100
Message-ID: <CAMP44s3SSjDqA9cvG9T=-oVH0ADndbxi1MkWF6wR9gxcoCi_xg@mail.gmail.com>
References: <509E66B0.3040308@web.de>
	<CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com>
	<7v4nkxozep.fsf@alter.siamese.dyndns.org>
	<CAMP44s0dQ8EeCkHo8Lh3odG3qQoeLFModec+7doLeTHnZoJ_pg@mail.gmail.com>
	<509EEF09.6060109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 01:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXLsv-0007MQ-5O
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 01:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab2KKA6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 19:58:34 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39721 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2KKA6d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 19:58:33 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5213949obb.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 16:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Cxaxr2pk7oOieGxNOkjmV/ZaECroSgVrD29FXIWt4Oc=;
        b=iTVDtR0w0umuM+fWn/BPINSP+ySpEzSy72qRaDGpFcSk9LqzngZIptEh0jlLZ2gcd0
         cO03bnksHjACHBUIJok6jpvZbmG3NrTHkNL+hwI78g9v/p4lE+Tr7nQfsaJmbKgTNLgE
         JiZI7mdj5JdGCoa8DyFEB2q+6u1brMmQCM7k6z5Fyj9127ZWhT3TmA166ZCtD4kZPTkk
         mmXmYHoZiDWHVfUv21GsqK4oYx6DoL8Kz/rDsExADDzlyoBD92JmbWzWej5aA2bNecwB
         MQnNrIQJb+30PXHBz9/3WFUzmBVChFztOH2UTVk/CHSR9PxX1Er7OmqjIp9HeNrV7+XY
         Y3mg==
Received: by 10.182.116.6 with SMTP id js6mr11913530obb.82.1352595513127; Sat,
 10 Nov 2012 16:58:33 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 16:58:33 -0800 (PST)
In-Reply-To: <509EEF09.6060109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209318>

On Sun, Nov 11, 2012 at 1:19 AM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> On 11/11/2012 12:11 AM, Felipe Contreras wrote:
>> On Sat, Nov 10, 2012 at 11:39 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Sat, Nov 10, 2012 at 3:37 PM, Torsten B=C3=B6gershausen <tboegi=
@web.de> wrote:
>>>>> The short version:
>>>>> echo -n doesn't seem to be portable.
>>>>> The following works for me:
>>>>
>>>> Right, I was supposed to change that to:
>>>>
>>>>   true > marks-cur &&
>>>
>>> Please make it like so:
>>>
>>>         >marks-cur &&
>>>
>>> No command is necessary when creating an empty file or truncating a=
n
>>> existing file to empty, and no SP between redirection and its targe=
t.
>>
>> That hangs on zsh (presumably waiting for stdin).
>>
> Unless you set:
>
>     NULLCMD=3D:
>
> early in your test script.
>
> Or, to be extra-safe, you could steal this initialization code from
> autoconf:
>
>     # Be more Bourne compatible.
>     if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; =
then
>       emulate sh
>       NULLCMD=3D:
>       setopt NO_GLOB_SUBST
>       # Pre-4.2 versions of Zsh do word splitting on ${1+"$@"}, which
>       # is contrary to our usage.  Disable this feature.
>       alias -g '${1+"$@"}'=3D'"$@"'

It doesn't seem like zsh listens to that variable in sh mode:

% zsh -c 'emulate sh; NULLCMD=3Dfoobar; > content'

And it doesn't seem like NO_GLOB_SUBST is needed any more.

I think it doesn't hurt to do 'true > marks-cur', but whatever.

Cheers.

--=20
=46elipe Contreras
