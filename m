From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 20:06:41 +0100
Message-ID: <3f4fd2640907251206n2c7f29a1r14204302d4b27cd4@mail.gmail.com>
References: <20090723160740.GA5736@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
	 <20090723195548.GA28494@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
	 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
	 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
	 <20090724234648.GA4616@Pilar.aei.mpg.de>
	 <20090725004122.GA28477@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
	 <20090725215739.d074e947.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUma5-0006g1-Pb
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbZGYTGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZGYTGm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:06:42 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:32905 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZGYTGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 15:06:41 -0400
Received: by qyk34 with SMTP id 34so1089152qyk.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3rVlEwoBATaCaofwd4SuPHoIXBL8/hwk/9ASkY2yBWQ=;
        b=EpOZRj+/ynvwuNmstKIvUbCNfSO9iqX8DP+QzM9bKjuWSknBOaPTpwoydMAG8Z2Tw9
         1NZACc1Pi2HSyWLrGMo5ETDaIDG4C/pX2rCMrlW/Tiyu+VkbsQ0DhALE4SC8KKdEG1LI
         Pi5mHZNOlmhK7f7yHD9CQaiQZ0MwXjA+THNJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OdsmTMnXL0E3m5ARS7VPpTh8Gv+68Dz2xqRm77+9H+KZkx49/Ia2trzKQ7wzXgpJH8
         k7DM1GlBFXm8ZJGBd8gYWGICFOX3ua/AmyFPwaI5+RXrd+yK6YOiOYRcjJXuRvSjngZR
         MzJGNDDEeH0QaO2BLRfgN4cjR2TleNHLyal/g=
Received: by 10.220.71.207 with SMTP id i15mr2960720vcj.77.1248548801156; Sat, 
	25 Jul 2009 12:06:41 -0700 (PDT)
In-Reply-To: <20090725215739.d074e947.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124056>

2009/7/25 Timo Hirvonen <tihirvon@gmail.com>:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> So curl really must die. It may not matter for the expensive operati=
ons,
>> but a lot of scripting is about running all those "cheap" things tha=
t just
>> add up over time.
>
> SELinux is the problem, not curl.
>
> On my Arch Linux machine:
>
> =A0 $ ldd bin/git
> =A0 =A0 =A0 =A0linux-vdso.so.1 =3D> =A0(0x00007fff42306000)
> =A0 =A0 =A0 =A0libcurl.so.4 =3D> /usr/lib/libcurl.so.4 (0x00007f87145=
32000)
> =A0 =A0 =A0 =A0libz.so.1 =3D> /usr/lib/libz.so.1 (0x00007f871431d000)
> =A0 =A0 =A0 =A0libcrypto.so.0.9.8 =3D> /usr/lib/libcrypto.so.0.9.8 (0=
x00007f8713f8f000)
> =A0 =A0 =A0 =A0libpthread.so.0 =3D> /lib/libpthread.so.0 (0x00007f871=
3d74000)
> =A0 =A0 =A0 =A0libc.so.6 =3D> /lib/libc.so.6 (0x00007f8713a21000)
> =A0 =A0 =A0 =A0librt.so.1 =3D> /lib/librt.so.1 (0x00007f8713819000)
> =A0 =A0 =A0 =A0libssl.so.0.9.8 =3D> /usr/lib/libssl.so.0.9.8 (0x00007=
f87135ca000)
> =A0 =A0 =A0 =A0libdl.so.2 =3D> /lib/libdl.so.2 (0x00007f87133c6000)
> =A0 =A0 =A0 =A0/lib/ld-linux-x86-64.so.2 (0x00007f8714778000)

It will depend on the dependencies of curl that are applied. BLFS
(http://www.linuxfromscratch.org/blfs/view/stable/basicnet/curl.html)
list the following dependencies:

    pkg-config-0.22
    OpenSSL-0.9.8g  or GnuTLS-1.6.3
    OpenLDAP-2.3.39
    libidn-0.6.14
    MIT Kerberos V5-1.6 or Heimdal-1.1
    krb4
    SPNEGO
    c-ares

and the dependencies of those packages and so forth.

On Ubuntu 9.04, I get:

$ ldd /usr/bin/git
	linux-gate.so.1 =3D>  (0xb80ae000)
	libcurl-gnutls.so.4 =3D> /usr/lib/libcurl-gnutls.so.4 (0xb805b000)
	libz.so.1 =3D> /lib/libz.so.1 (0xb8045000)
	libpthread.so.0 =3D> /lib/tls/i686/cmov/libpthread.so.0 (0xb802b000)
	libc.so.6 =3D> /lib/tls/i686/cmov/libc.so.6 (0xb7ec8000)
	libidn.so.11 =3D> /usr/lib/libidn.so.11 (0xb7e95000)
	liblber-2.4.so.2 =3D> /usr/lib/liblber-2.4.so.2 (0xb7e87000)
	libldap_r-2.4.so.2 =3D> /usr/lib/libldap_r-2.4.so.2 (0xb7e43000)
	librt.so.1 =3D> /lib/tls/i686/cmov/librt.so.1 (0xb7e39000)
	libgssapi_krb5.so.2 =3D> /usr/lib/libgssapi_krb5.so.2 (0xb7e0e000)
	libgnutls.so.26 =3D> /usr/lib/libgnutls.so.26 (0xb7d71000)
	libtasn1.so.3 =3D> /usr/lib/libtasn1.so.3 (0xb7d5f000)
	libgcrypt.so.11 =3D> /lib/libgcrypt.so.11 (0xb7cf6000)
	/lib/ld-linux.so.2 (0xb80af000)
	libresolv.so.2 =3D> /lib/tls/i686/cmov/libresolv.so.2 (0xb7ce0000)
	libsasl2.so.2 =3D> /usr/lib/libsasl2.so.2 (0xb7cc7000)
	libdl.so.2 =3D> /lib/tls/i686/cmov/libdl.so.2 (0xb7cc3000)
	libkrb5.so.3 =3D> /usr/lib/libkrb5.so.3 (0xb7c31000)
	libk5crypto.so.3 =3D> /usr/lib/libk5crypto.so.3 (0xb7c0d000)
	libcom_err.so.2 =3D> /lib/libcom_err.so.2 (0xb7c09000)
	libkrb5support.so.0 =3D> /usr/lib/libkrb5support.so.0 (0xb7bff000)
	libkeyutils.so.1 =3D> /lib/libkeyutils.so.1 (0xb7bfb000)
	libgpg-error.so.0 =3D> /lib/libgpg-error.so.0 (0xb7bf7000)

- Reece
