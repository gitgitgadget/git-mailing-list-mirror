From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: gettext CTYPE for libc
Date: Sat, 23 Nov 2013 09:15:50 +0700
Message-ID: <52900FD6.5020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git-malling-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 23 03:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk2lQ-0003UP-DL
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 03:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab3KWCP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 21:15:59 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44122 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab3KWCP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 21:15:58 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so2111803pbc.40
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=A6kre67qjtATNiKdOtqoXpdvZMLVhuGqJlXvoywy9LU=;
        b=HzfPRTuBFKWKDZeiIFbNyjUZywnLHI7SgqjLRs9qeq2XKewa8g5QrBbmM6ZawA4QOG
         iyiV99XotT35CmRbHgBqGS6FrJhRR/tUe67+rxilN8fsgGHAXG/ixETJpmqmnBQmYCmz
         3PfZVixCth1FkI2JC7W2lXg9A9hruM2x691hTHGtvLpZrXuTwjyJ+5QAzsyDJ274vZSL
         2FxjfnOH+x7GML0K9svdHpTjCa4XvsiBJej4IOqGlqkT99PU74yoKfZ+pVamljHXXJ1O
         JCT0n45dQ4cWJdnHVEImzylCSxfSQ49bQqgiSEWMJxwRNzor7AYlMshB5lBhIEudssrE
         Ipnw==
X-Received: by 10.68.163.33 with SMTP id yf1mr5638356pbb.143.1385172958235;
        Fri, 22 Nov 2013 18:15:58 -0800 (PST)
Received: from vnwildman.myftp.org ([113.168.211.105])
        by mx.google.com with ESMTPSA id vh3sm23215312pbc.8.2013.11.22.18.15.56
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Nov 2013 18:15:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238227>

Hello,

$ mkdir xyz
$ cd xyz
$ rmdir ../xyz
$ git status
fatal: Unable to read current working directory: Kh?ng c? t?p tin ho?c
th? m?c nh? v?y

So, somthing wrong with our charset.

$ strace git status 2>&1 | grep open
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
open("/lib/i386-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) =3D 3
open("/lib/i386-linux-gnu/libcrypto.so.1.0.0", O_RDONLY|O_CLOEXEC) =3D =
3
open("/lib/i386-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) =3D 3
open("/lib/i386-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
open("/lib/i386-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D 3
open("/dev/null", O_RDWR|O_LARGEFILE)   =3D 3
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) =
=3D 3
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =3D 3
open("/usr/share/locale/vi_VN/LC_MESSAGES/libc.mo", O_RDONLY) =3D -1
ENOENT (No such file or directory)
open("/usr/share/locale/vi/LC_MESSAGES/libc.mo", O_RDONLY) =3D -1 ENOEN=
T
(No such file or directory)
open("/usr/share/locale-langpack/vi_VN/LC_MESSAGES/libc.mo", O_RDONLY) =
=3D
-1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/vi/LC_MESSAGES/libc.mo", O_RDONLY) =3D=
 3
open("/usr/lib/i386-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) =3D=
 3

We will see, this string come from libc.mo
$ gettext --domain=3Dlibc "No such file or directory"
Kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin ho=E1=BA=B7c th=C6=B0 m=E1=BB=A5c nh=
=C6=B0 v=E1=BA=ADy

in git's gettext.c, it not allow CTYPE=3D"" for all domain, so we will =
set
this one individually. In this ex. I set it for libc:

$ git diff
diff --git a/gettext.c b/gettext.c
index 71e9545..abd3978 100644
--- a/gettext.c
+++ b/gettext.c
@@ -115,6 +115,7 @@ static void init_gettext_charset(const char *domain=
)
        setlocale(LC_CTYPE, "");
        charset =3D locale_charset();
        bind_textdomain_codeset(domain, charset);
+       bind_textdomain_codeset("libc", charset);
        setlocale(LC_CTYPE, "C");
 }

And it work as I expect!

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
