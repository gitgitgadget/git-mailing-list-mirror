From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Wed, 25 Jan 2012 23:02:04 +0100
Message-ID: <vpqr4ynzbj7.fsf@bauges.imag.fr>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
	<vpqwr8g8c03.fsf@bauges.imag.fr>
	<CAMP44s16L0GJUh4JcQgjBXUf4ftT7yQFgPy0p6zCNMnZjZGQww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 23:02:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqAv8-0005Fk-LE
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 23:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab2AYWCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 17:02:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51126 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2AYWCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 17:02:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q0PM04Os028161
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Jan 2012 23:00:04 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RqAur-0005uo-3W; Wed, 25 Jan 2012 23:02:05 +0100
In-Reply-To: <CAMP44s16L0GJUh4JcQgjBXUf4ftT7yQFgPy0p6zCNMnZjZGQww@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 25 Jan 2012 14:16:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Jan 2012 23:00:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0PM04Os028161
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1328133606.88797@B55akFNsNGwCj9J8ihuhWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189128>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>>> + =A0 =A0 =A0 =A0 =A0 =A0 typeset -h IFS
>>
>> No time to test right now, but is this not going to
>>
>> 1) leave IFS as hidden even outside the completion script, possibly
>> affecting unrelated scripts that would need to set IFS as local and =
keep
>> its special effect?
>
> What special effect?
>
> Unrelated scripts can still set IFS as local.

OK, I missed the fact that typeset -h had only local effect.

>> 2) break cases where strings are to be split on \n only (e.g. see
>> "foo bar\nboz" as three possible completions "foo", "bar", "boz" ins=
tead
>> of "foo bar" and "boz"?
>
> Those cases are already broken, which is what I reported to the zsh
> mailing list. You would get "foo\ bar" and "boz", and that's after
> 4.3.12; before, compgen -W would still break the completions in 3,
> because they did 'results+=3D( $words )', instead of 'results+=3D(
> "$words" )'.

Makes sense.

I still have a minor comment: maybe part of your commit message could g=
o
to a comment in the code as well, in particular the "Once zsh is fixed"
part, to help future contributors to actually disable the workaround
when possible in the future.

Tested-by: Matthieu Moy <Matthieu.Moy@imag.fr>

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
