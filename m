From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Add internationalization support to Git
Date: Sun, 30 May 2010 16:04:07 +0000
Message-ID: <AANLkTimI5xGiq_GNF_H2bOLECw0NxOiCPsnRqOS39H32@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<20100530014607.GA27387@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 18:04:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIkzo-0005QM-6B
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 18:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab0E3QEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 12:04:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63471 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0E3QEJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 12:04:09 -0400
Received: by iwn6 with SMTP id 6so345362iwn.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lodGpA7xWTVFprzGKIT+6ObloUooiuFI5kT3HLNxtsQ=;
        b=XKkYmzKvDY0nKXouii3qFp3WJhxm0FqJJ4u3O/GqxizVDh7pNUmdtUBVDOvGD+xloQ
         nA7yx5vAoiB/4Aglk/KJ5fPrZhm8GdGwO/K9sfY+7RevBst5OdhVMrxxQkzZ3UOD30j2
         /Qb/9ilCeKq7WQosEcdO2z3C5ZDzYNN5gvUVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fafSv4awcF29wYnHaN4lTo5V8YdM+6op3s/BYPXKIRqhp4LCjkOOYEErNpS16I/A6a
         /WUs980eMXeGhFkehC3WWT8zc+Y0/PfPp8ZYVCDRXBVQBla6WzDImlAz89vUwveW8AGd
         yEBAP4ST7i4Gh7sMUvX1m70VlZ5g5xR6Iw1mI=
Received: by 10.231.148.130 with SMTP id p2mr4218044ibv.11.1275235447123; Sun, 
	30 May 2010 09:04:07 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 30 May 2010 09:04:07 -0700 (PDT)
In-Reply-To: <20100530014607.GA27387@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148009>

On Sun, May 30, 2010 at 01:46, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi =C3=86var,

Hi, and thanks for taking the time to review this.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> =C2=A0 =C2=A0 I made three strings in git-pull.sh translatable as a =
proof of
>> =C2=A0 =C2=A0 concept. One problem that I ran into is that xgettext(=
1) seems
>> =C2=A0 =C2=A0 very particular when picking up translation strings. I=
t accepts
>> =C2=A0 =C2=A0 this:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext "hello world"; echo
>
> Does =E2=80=98gettext -s "hello world"=E2=80=99 work, too? =C2=A0(Jus=
t curious.)

No, that just makes "-s" translatable. Even options that gettext
accepts don't work either, you have to use eval_gettext "\$foo"
instead of gettext -e "\$foo". The xgettext program is quite na=C3=AFve
like that.

>> =C2=A0 =C2=A0 but not this:
> [...]
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext <<"END";
>> hello world
>> END
>>
>> =C2=A0 =C2=A0 Maybe there's a way to make it play nice. But I just u=
sed a large
>> =C2=A0 =C2=A0 multiline string as a workaround.
>
> Not so nice, but it seems that gettext expects a message id as
> an argument (i.e., it will only replace echo and not cat).

Yes. I mailed the maintainer about this. gettext would need to accept
text on STDIN and xgettext would need to find the messages for it to
work.

In the meantime we could just use multiline strings. It works for the
test suite.

>> =C2=A0 =C2=A0 I don't know what to do about
>> =C2=A0 =C2=A0 'die gettext' other than define a 'die_gettext' wrappe=
r function
>> =C2=A0 =C2=A0 and use `xgettext --keyword=3Ddie_gettext'.
>
> Sounds sensible.
>
>> One thing I haven't done is to try to go ahead and make massive
>> changes to the Git source code to make everything translatable.
>
> I am vaguely worried about performance. =C2=A0Suppose a function does
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 1000000; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(_("Some=
 interesting label: %s\n"), foo(i));
>
> Will this compile to the equivalent of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *s =3D _("Some interesting labe=
l: %s\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 1000000; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(s, foo(=
i));
>
> Suppose someone decides to make that change by hand (maybe the
> loop is too large for the compiler to notice the potential
> winnings). =C2=A0Then presumably gcc cannot be able to type-check the
> format any more. =C2=A0Is there some way around this that avoids
> both speed regressions and loss of type-safety?

Any level of indirection is of course going to be slower, there's no
way around that. I made two test programs to test this out:

test-in-loop.c:

    #include <stdio.h>
    #include <stdlib.h>
    #include <locale.h>
    #include <libintl.h>

    #define _(s) gettext(s)

    int foo(long int x) {
        return x * x;
    }

    int main(void) {
        const char *podir =3D "/usr/local/share/locale";
        if(!podir) puts("zomg error");
        char *ret =3D bindtextdomain("git", podir);
        ret =3D setlocale(LC_MESSAGES, "");
        ret =3D setlocale(LC_CTYPE, "");
        ret =3D textdomain("git");

        for (long int i =3D 0; i < 10000000; i++) {
            printf(_("Some interesting label: %ld\n"), foo(i));
        }

        return 0;
    }

test-outside-loop.c:

    #include <stdio.h>
    #include <stdlib.h>
    #include <locale.h>
    #include <libintl.h>

    #define _(s) gettext(s)

    int foo(long int x) {
        return x * x;
    }

    int main(void) {
        const char *podir =3D "/usr/local/share/locale";
        if(!podir) puts("zomg error");
        char *ret =3D bindtextdomain("git", podir);
        ret =3D setlocale(LC_MESSAGES, "");
        ret =3D setlocale(LC_CTYPE, "");
        ret =3D textdomain("git");

        const char *s =3D _("Some interesting label: %ld\n");
        for (long int i =3D 0; i < 10000000; i++)
            printf(s, foo(i));

        return 0;
    }

Note that I use 10 million iterations, not 1 million like in your
example.

Here's how they compile:

    $ gcc -std=3Dc99 -o test-in-loop test-in-loop.c ; gcc -std=3Dc99 -o
test-outside-loop test-outside-loop.c
    test-in-loop.c: In function =E2=80=98main=E2=80=99:
    test-in-loop.c:21: warning: format =E2=80=98%ld=E2=80=99 expects ty=
pe =E2=80=98long int=E2=80=99,
but argument 2 has type =E2=80=98int=E2=80=99

I.e. your concerns are valid. GCC won't catch an invalid format
specifier in this case.

And even though gettext tries to make cases like these fast
(http://www.gnu.org/software/hello/manual/gettext/Optimized-gettext.htm=
l)
it's still a lot slower than hardcoded English:

    perl -MBenchmark=3D:all -MData::Dump=3Ddump -E 'cmpthese(10, {
         outside =3D> sub { system "./test-outside-loop >/dev/null" },
         inside =3D>  sub { system "./test-in-loop >/dev/null" },
    });'

            s/iter  inside outside
    inside    13.4      --    -83%
    outside   2.26    495%      --

> Apologies if this was already answered in the earlier discussion.

What you can do (and this was covered) is to use msgfmt to check that
no translations use different format specifiers. But hopefully cases
where you have messages like these in tight loops and the message
lookup itself is a significant contributor to the program time will be
so rare as to not be an issue.
