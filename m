From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH RFC] gettext: Support building on non-GNU with -lintl
Date: Sat, 5 Jun 2010 14:57:38 +0000
Message-ID: <AANLkTin5HPiXcgr3WKcbCSn-48BOHXUIL-E7Kw69ap6Q@mail.gmail.com>
References: <1275669370-6004-1-git-send-email-avarab@gmail.com>
	<m3aar9r9ek.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 16:57:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKuoj-0007et-CA
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 16:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423Ab0FEO5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 10:57:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45618 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933432Ab0FEO5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 10:57:40 -0400
Received: by iwn37 with SMTP id 37so2006761iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AlVO1dPq9zzY5Zjqryx9HSy3jXxUJ4xaLYHBQO5ISUk=;
        b=SK5i/kXP+thxt29Cl2R0vFQ3FPqxRFYB8mt4rAmFjCUJ7lzc2gR14mRknb0TXgftMG
         Nk2vAeuOo2RIMrAg9UimasFZ7EDarMQR7amImF0yyqqpxl987KST2mpKuOcfaJrL7Fdc
         X1WDOgTz+Ecjlq5NBha3lm3VK+WuXqShM4kdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b18nxmWkPYd9s27MstSEhUjP/FZK/53A31QH1AWM41V0Hl8/5Khxu/sA5BYazAH/T/
         bNBiPAyQNXwFn3MEI3msJE3ErwgJDN5XjoBAj5qykNoGBiCNSzLC4LKvHJbhykMwW8Am
         9AGjjCsY4Xuq/oTshIq2CsTmryt6V6az75Gd4=
Received: by 10.231.111.209 with SMTP id t17mr2220360ibp.182.1275749858658; 
	Sat, 05 Jun 2010 07:57:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 07:57:38 -0700 (PDT)
In-Reply-To: <m3aar9r9ek.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148474>

On Sat, Jun 5, 2010 at 11:42, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Change the build process on non-GNU systems to use -lintl if
>> NO_GETTEXT hasn't been set.
>>
>> Systems that use the GNU C Library don't need this, but on others th=
e
>> GNU libintl library is an externally install package, so we need to
>> explicitly link to it.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>
> [...]
>> diff --git a/Makefile b/Makefile
>> index 5169aec..1dfcd65 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -28,6 +28,15 @@ all::
>> =C2=A0# Define NO_EXPAT if you do not have expat installed. =C2=A0gi=
t-http-push is
>> =C2=A0# not built, and you cannot push using http:// and https:// tr=
ansports.
>> =C2=A0#
>> +# Define NO_GETTEXT if you don't have libintl installed, or don't w=
ant
>> +# to build Git with localization support.
>> +#
>> +# Define NEEDS_LIBINTL if you haven't defined NO_GETTEXT=3DYesPleas=
e,
>> +# but your system needs to be explicitly linked to -lintl. This is
>> +# defined automatically if we're building gettext support on system=
s
>> +# where we expect not to use glibc (which has libintl included in
>> +# libc).
>
> Could you add test for NEEDS_LIBINTL to configure.ac? =C2=A0Thanks in
> advance.

Done:

    $ uname -s ; (git clean -dxf; gmake configure  &&
CPPFLAGS=3D"-I/usr/local/include" ./configure) > /dev/null && egrep
"INTL|GETTEXT" config.mak.autogen
    FreeBSD
    GIT_VERSION =3D 1.7.0.4.732.ge63cf.dirty
    NO_GETTEXT=3D
    NEEDS_LIBINTL=3DYesPlease

The patch needed to get it working:

diff --git a/config.mak.in b/config.mak.in
index a15f3c1..c49072c 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -36,6 +36,7 @@ NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
+NEEDS_LIBINTL=3D@NEEDS_LIBINTL@
 NEEDS_LIBGEN=3D@NEEDS_LIBGEN@
 NO_SYS_SELECT_H=3D@NO_SYS_SELECT_H@
 NO_D_INO_IN_DIRENT=3D@NO_D_INO_IN_DIRENT@
diff --git a/configure.ac b/configure.ac
index 7bebfd8..74879b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -559,6 +559,12 @@ AC_CHECK_LIB([c], [basename],
 AC_SUBST(NEEDS_LIBGEN)
 test -n "$NEEDS_LIBGEN" && LIBS=3D"$LIBS -lgen"

+AC_CHECK_LIB([c], [gettext],
+[NEEDS_LIBINTL=3D],
+[NEEDS_LIBINTL=3DYesPlease])
+AC_SUBST(NEEDS_LIBINTL)
+test -n "$NEEDS_LIBINTL" && LIBS=3D"$LIBS -lintl"
+
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
 #
