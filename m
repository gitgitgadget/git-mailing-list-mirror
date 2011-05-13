From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Fri, 13 May 2011 10:21:26 +0200
Message-ID: <BANLkTikM-FaArEA8QTy_MB9cODzwV_ER_g@mail.gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
	<1304857280-14773-21-git-send-email-avarab@gmail.com>
	<4DCB9592.2090503@viscovery.net>
	<BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com>
	<4DCBECB5.5050502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 13 10:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKncw-0005Bn-GO
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 10:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab1EMIVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 04:21:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39011 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1EMIV2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 04:21:28 -0400
Received: by fxm17 with SMTP id 17so1604822fxm.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ITbx+/rwvkZfy0M38sn3/AyGYHlWg2TVHlZErGY+yxs=;
        b=aHKltWiSDCshXgBMUv2/VDk5YP6UvSKrrmEdOyzYtIuVegnJrvlZ/afNKTG/rve3Ge
         vo7B6CZ0inpm+uN1DvbcUvJkKUMKQ9H8drBQzXH2LxQO0PcjsZHjCwaVyNWZVaU9Hmde
         89TYIxyHIBmDHHWGD9EoDtBSxoSbCzbWZbIo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ELHij/FpHPrRGGSyM8wpYxSgP/ZUJ7CmWA7EgEbsc7B9hOuJ4aZrEDz8M2WeUD2xTj
         CzvFCeLY0fOCNX2R2baSiUysvSborsprKXOvdGOZ3JOnd/PloZwuYkr1uS0eNhFXX+1Q
         46vHyxW1RxE7wF/6McMIBOU4xQIkTJSCNjiZQ=
Received: by 10.223.127.210 with SMTP id h18mr1371927fas.67.1305274886571;
 Fri, 13 May 2011 01:21:26 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Fri, 13 May 2011 01:21:26 -0700 (PDT)
In-Reply-To: <4DCBECB5.5050502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173509>

On Thu, May 12, 2011 at 16:20, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 5/12/2011 15:48, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Thu, May 12, 2011 at 10:08, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
>>> Am 5/8/2011 14:20, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say "Submodule '$name'=
 ($url) registered for path '$path'"
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say "$(eval_gettext "S=
ubmodule '\$name' (\$url) registered for path '\$path'")"
>>>
>>> On Windows, we have a problem with messages like this (and many oth=
ers)
>>> that reference $path. eval_gettext has to export 'path', but on Win=
dows
>>> environment variables are case-insensitive. In the substitution, th=
is
>>> happens to pick the value of 'PATH' rather than of 'path'... Can yo=
u do
>>> something about this?
>>>
>>> Of course, the problem is not limited to 'path' at all, but it is a
>>> prominent example discovered by the test suite.
>>
>> I didn't know Windows had that limitation. We can easily work around
>> it by just renaming $path to something else (e.g. $filepath).
>>
>> Since we do:
>>
>> =C2=A0 =C2=A0 export PATH $(git sh-i18n--envsubst --variables "$1");
>>
>> I assume this problem only occurs with variables that match
>> /^path$/i. Or are there other problems on Windows?
>
> It is *not* limited to PATH. There can be other variables in the
> environment that are the same name as some that are exported in this
> statement. Here's a brief test:
>
> --- 8< ---
> $ cat git-test
> #!/bin/sh
>
> . git-sh-setup
> . git-sh-i18n
>
> AppData=3Dmyappdata
> username=3DmyUserName
> proMPT=3Dmyprompt
>
> echo "$(eval_gettext "AppData: '\$AppData'
> username: \$username
> proMPT: \$proMPT
> path: '\$path'")"
>
> $ git --exec-path=3D. test
> AppData: 'C:\Dokumente und Einstellungen\jsixt\Anwendungsdaten'
> username: jsixt
> proMPT: $P$G
> path:
> 'd:/Src/mingw-git/.;d:\Src\mingw-git;d:\Src\mingw-git\;d:\Src\mingw-g=
it;...snip...;.'
> --- 8< ---

That's interesting. I thought that the problem would only be with
PATH, since we'd clobber the other environment variables when we do
the export in git-sh-i18n.

But evidently not, but I don't quite grok why.

Anyway, this behavior seems un-POSIX compliant, and I'd been assuming
that our shell scripts were POSIX shellscripts when I wrote this.

But if we want to make this work on Windows I guess we can change
things like $path and $repo to $windows_me_harder_path and
$windows_me_harder_repo.
