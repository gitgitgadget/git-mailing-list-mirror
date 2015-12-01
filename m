From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] OS X El Capitan + Xcode ships without SSL header?!
Date: Tue, 1 Dec 2015 10:04:02 +0100
Message-ID: <7AD88D08-04E7-485E-9465-692F3043C445@gmail.com>
References: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com> <565B3036.8000604@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:04:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3grE-00038H-O7
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 10:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbbLAJEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 04:04:14 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37266 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbbLAJEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2015 04:04:06 -0500
Received: by wmww144 with SMTP id w144so3694034wmw.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 01:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QbyDrcfiF7UeZlx9bWA6UbfqYxlds+d+nqply6fzsgA=;
        b=v99DwSmZqX1RzAGvnSm7eZP7ZB+j1RuTqXdJpdpkPXW+Z5dTJBGAFhPY1pbYpsLY7t
         a7vmvPCA77dGUjThHPVcLtKmv6LSuvlTTU17FPIJiY2QtDiNd0i2YMqZZCvJzD9lfazM
         Fm9ZoAqFus7djEHchDgRgzJk/6pcf7spcxS8ivaTKxITf/vErP1vhLs7zgEPs+W7bvh7
         CAkV9pYFsLQmif+j2v2Q92daLiRXc09LHmuk231pmBPulEK3ad6Q64Exr/O5czZNfesf
         uqUuja5ANbwQNhvvPtgDG9vtQd/AkMw7mSf9RPCyrYfHQTVZjgDVtl3FYaaY57g+xPuQ
         ar5g==
X-Received: by 10.28.65.69 with SMTP id o66mr32311045wma.18.1448960645229;
        Tue, 01 Dec 2015 01:04:05 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB7751.dip0.t-ipconnect.de. [93.219.119.81])
        by smtp.gmail.com with ESMTPSA id a63sm25149283wmc.5.2015.12.01.01.04.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 01:04:04 -0800 (PST)
In-Reply-To: <565B3036.8000604@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281834>


On 29 Nov 2015, at 18:04, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 21/11/15 19:58, Lars Schneider wrote:
>> Hi,
>>=20
>> I cannot build Git on a clean machine with OS X El Capitan 10.11, Xc=
ode 7.1.1 and Xcode command line tools because of missing OpenSSL heade=
rs.
>>=20
>> It looks like as there are no OpenSSL headers at all. I only found t=
his weird non working version:
>> /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.x=
ctoolchain/usr/lib/swift-migrator/sdk/MacOSX.sdk/usr/include/openssl/ss=
l.h
>>=20
>> I installed OpenSSL with brew, added the include path and it works.
>>=20
>> Can anyone confirm?
>>=20
>> Thanks,
>> Lars
>>=20
> (Does it make sense that you send a patch which auto-detects brew sim=
ilar to fink or mac ports?)
I think that would make sense. I'll look into it if I find some free cy=
cles...

>=20
> After some proper updating of one test machine I ran into the same pr=
oblem.
> A possible patch may look like this:
>=20
>=20
> commit 5e7c16f3350e8e62bfdb181b0b5da7352945d046
> Author: Torsten B=F6gershausen <tboegi@web.de>
> Date:   Sun Nov 29 17:29:22 2015 +0100
>=20
>    Mac OS X 10.11: set NO_OPENSSL
>=20
>    There is no openssl/ directory any more in Mac OS X 10.11,
>    openssl is depracated since Mac OS X 10.7
>=20
>    Set NO_OPENSSL to YesPlease as default under Mac OS X, and make it
>    possible to override this and use openssl by defining DARWIN_OPENS=
SL
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index f34dcaa..a8a8b07 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -105,6 +105,12 @@ ifeq ($(uname_S),Darwin)
>        ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`"=
 -ge 11 && echo 1),1)
>                HAVE_GETDELIM =3D YesPlease
>        endif
> +       # MacOS 10.11  and higher
> +       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`=
" -ge 15 && echo 1),1)
> +               ifndef DARWIN_OPENSSL
> +                       NO_OPENSSL =3D YesPlease
> +               endif
> +       endif

That would propably do it. However, what are the ramifications here? Do=
es this affect `git clone` over HTTPS or even SSH? Sorry if this questi=
on sounds stupid but I am not too familiar with these systems. If there=
 are indeed these severe ramifications then I would probably print a li=
ttle tutorial how to install OpenSSL via brew.

Maybe one could use Apple's TLS implementation [1] on OS X alternativel=
y. However, I don't know how different the APIs are and the resulting "=
ifdefs" are probably undesired.

Cheers,
Lars

[1] https://developer.apple.com/library/mac/documentation/Security/Refe=
rence/secureTransportRef/


 