From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Mon, 25 Aug 2014 01:32:56 +0100
Message-ID: <53FA8438.5070107@ramsay1.demon.co.uk>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com> <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk> <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com> <53FA1050.2060309@ramsay1.demon.co.uk> <53FA41E2.9060907@web.de> <CAFKYj4eD8CXzafSC5LWpmaen=d6uw7yn0gZXFLG7VGLQwZdUWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tsuna <tsunanet@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 02:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLiDb-0004kU-A7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 02:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbaHYAdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 20:33:01 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:49076 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752575AbaHYAdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 20:33:01 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id C06B54008FE;
	Mon, 25 Aug 2014 01:32:50 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 76FA2400837;
	Mon, 25 Aug 2014 01:32:50 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Mon, 25 Aug 2014 01:32:50 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAFKYj4eD8CXzafSC5LWpmaen=d6uw7yn0gZXFLG7VGLQwZdUWA@mail.gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255817>

On 24/08/14 22:09, tsuna wrote:
> On Sun, Aug 24, 2014 at 12:49 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> On 2014-08-24 18.18, Ramsay Jones wrote:
>>> On 24/08/14 12:13, tsuna wrote:
>>>> On Sun, Aug 24, 2014 at 4:10 AM, Ramsay Jones
>>>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>>> Hmm, which version of OS X are we talking about?
>>>>
>>>> OS X 10.9.4:
>>>>
>>>> $ uname -a
>>>> Darwin damogran.local 13.3.0 Darwin Kernel Version 13.3.0: Tue Jun=
  3
>>>> 21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64
>>>
>>> Hmm, does 'uname -r' return 13.3.0 or 13.4.0? (or something else!)
>=20
> $ uname -r
> 13.3.0
>=20
>>>>> config.mak.uname contains this:
>>>>>
>>>>>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>>>>>                 NO_STRLCPY =3D YesPlease
>>>>>
>>>>> What does ./configure put in config.mak.autogen for NO_STRLCPY?
>>>>
>>>> NO_STRLCPY=3D
>>>
>>> OK, so I've got to my limit here! ;-) The conditional shown above
>>> (from config.mak.uname) should not have set NO_STRLCPY (assuming
>>> that 'uname -r' is returning 13.3.0 or 13.4.0). So, unless NO_STRLC=
PY
>>> is being set somewhere else (command-line, environment), this shoul=
d
>>> just work. puzzled. :(
>>>
>>>>
>>>> I guess I saw all the warnings because I did just a =E2=80=9Cgit p=
ull =E2=80=94rebase
>>>> && make -j8=E2=80=9D without running =E2=80=9Cmake configure && ./=
configure=E2=80=9D.
>>>>
>>>
>>> Yes, but use of configure is supposed to be optional ...
>>>
>>> Hopefully, someone who actually knows OS X can solve the mystery.
>>>
>>> ATB,
>>> Ramsay Jones
>>
>> I need to admit that I can not reproduce the warning here,
>> uname -r gives "13.3.0"
>>
>> Could it be that something is special on your machine ?
>> Something in the environment  ?
>=20
> Not that I can think of, the only "non-standard=E2=80=9D thing I have
> installed is Homebrew (http://brew.sh/), but otherwise it=E2=80=99s a=
ll the
> standard OS X stuff and Developer tools.  I write code on this machin=
e
> on a daily basis.
>=20
>> Does a fresh clone help ?
>=20
> A fresh clone doesn=E2=80=99t even build :-/
>=20
> $ git clone git://github.com/git/git.git
> Cloning into 'git'...
> remote: Counting objects: 176423, done.
> remote: Compressing objects: 100% (47201/47201), done.
> remote: Total 176423 (delta 127349), reused 176233 (delta 127209)
> Receiving objects: 100% (176423/176423), 64.05 MiB | 6.13 MiB/s, done=
=2E
> Resolving deltas: 100% (127349/127349), done.
> Checking connectivity... done.
> $ cd git
>=20
>                                                                    $
> make
> GIT_VERSION =3D 2.1.0
>     * new build flags
>     CC credential-store.o
> In file included from credential-store.c:1:
> In file included from ./cache.h:8:
> ./gettext.h:17:11: fatal error: 'libintl.h' file not found
> #       include <libintl.h>
>                 ^
> 1 error generated.
> make: *** [credential-store.o] Error 1

Again, I don't have access to an OS X system, so I don't know
which package provides libintl/gettext, but it seems to be missing
on your system.

You can avoid the build failure, without running configure, by
setting NO_GETTEXT=3DYesPlease in your config.mak file.

>=20
>=20
> I need to run configure first:
>=20
> $ make configure
>     GEN configure
> $ ./configure
> configure: Setting lib to 'lib' (the default)
> [=E2=80=A6]

So, presumably, configure has set NO_GETEXT=3DYesPlease in your
config.mak.autogen file.

ATB,
Ramsay Jones
