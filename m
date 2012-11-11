From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sun, 11 Nov 2012 01:19:21 +0100
Message-ID: <509EEF09.6060109@gmail.com>
References: <509E66B0.3040308@web.de> <CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com> <7v4nkxozep.fsf@alter.siamese.dyndns.org> <CAMP44s0dQ8EeCkHo8Lh3odG3qQoeLFModec+7doLeTHnZoJ_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 01:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXLH7-0007X5-6i
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 01:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab2KKATc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 19:19:32 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54276 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2KKATb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 19:19:31 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so2777625eek.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=TFslBO5qGSivittpopV76BWVAJK0EHukgrOwmWTnm3A=;
        b=j/UAgLLo7a7Hjo0ZQW6Zcke7fsbHM8Fi2cfihVVNm5WSowWjSCUD8JG7Y6QiDsOSme
         9pckmrHJ9e6iw1NlLn+7Z88IAvXxyrx6gBwXCe7hce2A/9zWHF6cysNhVJwi8gB7pIUD
         sQbOtfrePxZQXiMfqFyJ/jbz6Hr2ysUQbK3oD6ierfaTsFGO8xphPtEJ8PjFSxpqJElS
         kB395evNcHFJrfMrhtk5hfQuhNSfWd57vAlYkhm3/KIUtQ/XxgVwhq4t/l4waz6/m6ox
         Z2588o83nLUYFiWkNnmcX1ZGsK29h7kzP+YIJdgq5RF3NBbcEE26SCjWkLDaYu8Idc8C
         7HYQ==
Received: by 10.14.209.136 with SMTP id s8mr48918699eeo.33.1352593170555;
        Sat, 10 Nov 2012 16:19:30 -0800 (PST)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id o49sm6445790eep.5.2012.11.10.16.19.29
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Nov 2012 16:19:29 -0800 (PST)
In-Reply-To: <CAMP44s0dQ8EeCkHo8Lh3odG3qQoeLFModec+7doLeTHnZoJ_pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209316>

On 11/11/2012 12:11 AM, Felipe Contreras wrote:
> On Sat, Nov 10, 2012 at 11:39 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sat, Nov 10, 2012 at 3:37 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>>>> The short version:
>>>> echo -n doesn't seem to be portable.
>>>> The following works for me:
>>>
>>> Right, I was supposed to change that to:
>>>
>>>   true > marks-cur &&
>>
>> Please make it like so:
>>
>>         >marks-cur &&
>>
>> No command is necessary when creating an empty file or truncating an
>> existing file to empty, and no SP between redirection and its target=
=2E
>=20
> That hangs on zsh (presumably waiting for stdin).
>
Unless you set:

    NULLCMD=3D:

early in your test script.

Or, to be extra-safe, you could steal this initialization code from
autoconf:

    # Be more Bourne compatible.
    if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; th=
en
      emulate sh
      NULLCMD=3D:
      setopt NO_GLOB_SUBST
      # Pre-4.2 versions of Zsh do word splitting on ${1+"$@"}, which
      # is contrary to our usage.  Disable this feature.
      alias -g '${1+"$@"}'=3D'"$@"'
    else
      case `(set -o) 2>/dev/null` in *posix*) set -o posix ;; esac
    fi

All of this untested with the real Git testsuite, of course ;-)

Regards, and HTH,
  Stefano
