From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC (amend)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Thu,  6 Dec 2007 00:05:48 +0100
Message-ID: <1196895948-25115-1-git-send-email-jnareb@gmail.com>
References: <7vd4tkn5mk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J03Jy-0000yP-Lq
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 00:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXLEXGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 18:06:05 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbXLEXGE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 18:06:04 -0500
Received: from hu-out-0506.google.com ([72.14.214.231]:6441 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbXLEXGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 18:06:01 -0500
Received: by hu-out-0506.google.com with SMTP id 19so4163144hue
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y9jbUeiBJyV+XKLusRmqN3C/Hzgehl3QpeUQXVyegIc=;
        b=vkdl7yi7aOaOePr81Hq3RjF+lLQS86iNH9NgCDTJa1YGCEdAves4YS9ARx/sNigeeP4S1tqiZb3xF/FvlgDX9eXrt9mc0WShmfWkHmLwyhmeEg6xMpydwYbyIK1G7d9TBsAitqoSu5gp/ViOLILozNZcBoG1qj8hO+hx2Ce9XQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KPpFRD15qPThyKoVFgHTRtK8p2MOXVpgwLtfy5aLNu6HlHb8EYVIqC102JAVKZMIh0D1wO85bdYha+jxxUbHJF6s6lnqnhaFArxF+1RJK7euioMAvwjOo69VotPCq1mwPRXQsgvEcWKU+Rfcg/ynTER1EvjXhnvg4HnGs3C8iXo=
Received: by 10.78.200.20 with SMTP id x20mr1455082huf.1196895959618;
        Wed, 05 Dec 2007 15:05:59 -0800 (PST)
Received: from roke.D-201 ( [83.8.243.182])
        by mx.google.com with ESMTPS id e9sm163279muf.2007.12.05.15.05.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 15:05:58 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB5N5pZo025131;
	Thu, 6 Dec 2007 00:05:52 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB5N5mCR025129;
	Thu, 6 Dec 2007 00:05:48 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <7vd4tkn5mk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67209>

On Wed, 5 Dec 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>>> +AC_MSG_CHECKING([for old iconv()])
>>>> +AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
>>>> +	[AC_MSG_RESULT([no])],
>>>> +	[AC_MSG_RESULT([yes])
>>>> +	OLD_ICONV=3DYesPlease])
>>>> +AC_SUBST(OLD_ICONV)
>>>> =20
>>>=20
>>> Which result does COMPILE_IFELSE give for non error warnings?
>>> Ok, or Bad?
>>
>>  - Macro: AC_COMPILE_IFELSE (INPUT, [ACTION-IF-FOUND],
>>           [ACTION-IF-NOT-FOUND])
>>      Run the compiler and compilation flags of the current language
>>      (*note Language Choice::) on the INPUT, run the shell commands
>>      ACTION-IF-TRUE on success, ACTION-IF-FALSE otherwise.  The INPU=
T
>>      can be made by `AC_LANG_PROGRAM' and friends.
>>
>> And if I have checked correctly code which causes only warnings
>> returns Ok (in this case print 'no' after 'checking for old iconv().=
=2E. '
>> and do not set OLD_ICONV, which means it will be unset).
>=20
> Which means the real-life compilation will get the warning on type
> mismatch.  Wasn't OLD_ICONV about squelching that?

Gah, I don't know why I though OLD_ICONV was about compile errors, and
not about compile warnings. This version uses -Werror to check for
warnings; I hope it doesn't give false positives...


On Wed, 5 Dec 2007, Pascal Obry wrote:
> Jakub Narebski a =E9crit :
>> ---
>> This patch needs checking if it correctly sets OLD_ICONV
>> when needed.  I have checked only that it is not set when
>> with new iconv() declaration.  Could people using Cygwin
>> (and other with OLD_ICONV: Darwin) test it?
>=20
> Not working on Cygwin:
>=20
>    $ autoconf
>    $ ./configure --prefix=3D/usr/local --build=3Di686-pc-cygwin
>    ...
>    configure: CHECKS for header files
>    checking for old iconv()... no
>=20
> It should be yes above. And in config.mak.autogen we have:
>=20
>    OLD_ICONV=3D

Check out current version of patch. It should work correctly now
(I thought OLD_ICONV was about compile errors, and it is about
squelching compile warnings). It should give now:

  $ make configure
  $ ./configure --prefix=3D/usr/local --build=3Di686-pc-cygwin

  configure: CHECKS for header files
  checking for old iconv()... yes
=20
  $ cat config.mak.autogen
=20
  OLD_ICONV=3DUnfortunatelyYes

> Note also that you should remove all the hard-coded settings
> in Makefile anyway.

No, I should not. ./configure script is purely optional in git,
and compiling should work with reasonable defaults even if you
don't have autoconf installed and/or you don't want to run
=2E/configure script (because e.g. it is too slow).

-- >8 --
=46rom: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Add test for OLD_ICONV (squelching compiler =
warning)

Update configure.ac (and config.mak.in) to keep up with git
development by adding [compile] test whether your library has an old
iconv(), where the second (input buffer pointer) parameter is declared
with type (const char **) (OLD_ICONV).

Test-proposed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 11d256e..7d5df9b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -41,4 +41,5 @@ NO_STRTOUMAX=3D@NO_STRTOUMAX@
 NO_SETENV=3D@NO_SETENV@
 NO_MKDTEMP=3D@NO_MKDTEMP@
 NO_ICONV=3D@NO_ICONV@
+OLD_ICONV=3D@OLD_ICONV@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index 5f8a15b..196ab3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,30 @@ test -n "$NEEDS_SOCKET" && LIBS=3D"$LIBS -lsocket"
=20
=20
 ## Checks for header files.
+AC_MSG_NOTICE([CHECKS for header files])
+#
+# Define OLD_ICONV if your library has an old iconv(), where the secon=
d
+# (input buffer pointer) parameter is declared with type (const char *=
*).
+AC_DEFUN([OLDICONVTEST_SRC], [[
+#include <iconv.h>
+
+int main(void)
+{
+	iconv_t cd;
+	char *ibp, *obp;
+	size_t insz, outsz;
+	iconv(cd, &ibp, &insz, &obp, &outsz);
+}
+]])
+AC_MSG_CHECKING([for old iconv()])
+CFLAGS_ORIG=3D$CFLAGS
+CFLAGS=3D"$CFLAGS -Werror"
+AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+	[AC_MSG_RESULT([no])],
+	[AC_MSG_RESULT([yes])
+	OLD_ICONV=3DUnfortunatelyYes])
+CFLAGS=3D$CFLAGS_ORIG
+AC_SUBST(OLD_ICONV)
=20
=20
 ## Checks for typedefs, structures, and compiler characteristics.
--=20
1.5.3.7
