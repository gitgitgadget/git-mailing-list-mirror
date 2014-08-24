From: tsuna <tsunanet@gmail.com>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 14:09:47 -0700
Message-ID: <CAFKYj4eD8CXzafSC5LWpmaen=d6uw7yn0gZXFLG7VGLQwZdUWA@mail.gmail.com>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
 <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk>
 <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com>
 <53FA1050.2060309@ramsay1.demon.co.uk> <53FA41E2.9060907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 24 23:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLf3N-00021Y-HZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 23:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbaHXVKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 17:10:09 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:50747 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbaHXVKI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2014 17:10:08 -0400
Received: by mail-oi0-f51.google.com with SMTP id v63so2125304oia.38
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cdsSIbgqoM9VOuYS22krikfKWfcZIVgnZ1N3yzcq7/8=;
        b=HV0FWhSfumoCOZZcvbRd51Moa6jRUuK0wis7lbwBfWaoz9dSAWVH5Hld1ybmMqCAvV
         nrrfplwRd+MQVnJJhDkJEwwky57C3eGPLsCILEvpHZ5xdrjk5ge2zyBlZs/e7rMTjjnJ
         gpXM1SRKCjZDK4/t56aAeL/qCHY+mbbeginv5rtgH2/p6eDNc+7mu7sfVZFo4UrlYODT
         mdK5SK75FRgfDz4koVVj8Cs3cCU3MQS241IYuSvfMbcBjgRjWse4UwNX8UHKH8bkysux
         ImOVSr9Io2X3v21i5R/prciMfmnaCoG/8AQ0nJBJfdMQr5ee8cFK5reY0NDerstRIjzT
         Anzw==
X-Received: by 10.182.51.229 with SMTP id n5mr17532972obo.47.1408914607440;
 Sun, 24 Aug 2014 14:10:07 -0700 (PDT)
Received: by 10.182.188.37 with HTTP; Sun, 24 Aug 2014 14:09:47 -0700 (PDT)
In-Reply-To: <53FA41E2.9060907@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255814>

On Sun, Aug 24, 2014 at 12:49 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2014-08-24 18.18, Ramsay Jones wrote:
>> On 24/08/14 12:13, tsuna wrote:
>>> On Sun, Aug 24, 2014 at 4:10 AM, Ramsay Jones
>>> <ramsay@ramsay1.demon.co.uk> wrote:
>>>> Hmm, which version of OS X are we talking about?
>>>
>>> OS X 10.9.4:
>>>
>>> $ uname -a
>>> Darwin damogran.local 13.3.0 Darwin Kernel Version 13.3.0: Tue Jun =
 3
>>> 21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64
>>
>> Hmm, does 'uname -r' return 13.3.0 or 13.4.0? (or something else!)

$ uname -r
13.3.0

>>>> config.mak.uname contains this:
>>>>
>>>>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>>>>                 NO_STRLCPY =3D YesPlease
>>>>
>>>> What does ./configure put in config.mak.autogen for NO_STRLCPY?
>>>
>>> NO_STRLCPY=3D
>>
>> OK, so I've got to my limit here! ;-) The conditional shown above
>> (from config.mak.uname) should not have set NO_STRLCPY (assuming
>> that 'uname -r' is returning 13.3.0 or 13.4.0). So, unless NO_STRLCP=
Y
>> is being set somewhere else (command-line, environment), this should
>> just work. puzzled. :(
>>
>>>
>>> I guess I saw all the warnings because I did just a =E2=80=9Cgit pu=
ll =E2=80=94rebase
>>> && make -j8=E2=80=9D without running =E2=80=9Cmake configure && ./c=
onfigure=E2=80=9D.
>>>
>>
>> Yes, but use of configure is supposed to be optional ...
>>
>> Hopefully, someone who actually knows OS X can solve the mystery.
>>
>> ATB,
>> Ramsay Jones
>
> I need to admit that I can not reproduce the warning here,
> uname -r gives "13.3.0"
>
> Could it be that something is special on your machine ?
> Something in the environment  ?

Not that I can think of, the only "non-standard=E2=80=9D thing I have
installed is Homebrew (http://brew.sh/), but otherwise it=E2=80=99s all=
 the
standard OS X stuff and Developer tools.  I write code on this machine
on a daily basis.

> Does a fresh clone help ?

A fresh clone doesn=E2=80=99t even build :-/

$ git clone git://github.com/git/git.git
Cloning into 'git'...
remote: Counting objects: 176423, done.
remote: Compressing objects: 100% (47201/47201), done.
remote: Total 176423 (delta 127349), reused 176233 (delta 127209)
Receiving objects: 100% (176423/176423), 64.05 MiB | 6.13 MiB/s, done.
Resolving deltas: 100% (127349/127349), done.
Checking connectivity... done.
$ cd git

                                                                   $
make
GIT_VERSION =3D 2.1.0
    * new build flags
    CC credential-store.o
In file included from credential-store.c:1:
In file included from ./cache.h:8:
=2E/gettext.h:17:11: fatal error: 'libintl.h' file not found
#       include <libintl.h>
                ^
1 error generated.
make: *** [credential-store.o] Error 1


I need to run configure first:

$ make configure
    GEN configure
$ ./configure
configure: Setting lib to 'lib' (the default)
[=E2=80=A6]
$ make
tsuna@damogran /tmp/git $ make
    * new build flags
    CC credential-store.o
    * new link flags
    CC abspath.o
[=E2=80=A6]

Then the build succeeds.

$ grep NO_STRLCPY config.mak.autogen
NO_STRLCPY=3D

$ which cc
/usr/bin/cc

$ cc --version
Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn)
Target: x86_64-apple-darwin13.3.0
Thread model: posix

--=20
Benoit "tsuna=E2=80=9D Sigoure
