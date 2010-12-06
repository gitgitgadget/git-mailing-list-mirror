From: Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@gmail.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Mon, 06 Dec 2010 06:39:38 +0100
Message-ID: <1291613978.4756.157.camel@yamato.local>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
	 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
	 <1291613304.3339.12.camel@fixed-disk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Dec 06 06:41:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPTp3-00011H-TA
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 06:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978Ab0LFFlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 00:41:08 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:35717 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0LFFlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 00:41:07 -0500
Received: by wwe15 with SMTP id 15so3434752wwe.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 21:41:05 -0800 (PST)
Received: by 10.216.15.20 with SMTP id e20mr4494447wee.8.1291614064377;
        Sun, 05 Dec 2010 21:41:04 -0800 (PST)
Received: from [172.28.8.1] (host249-252-static.95-94-b.business.telecomitalia.it [94.95.252.249])
        by mx.google.com with ESMTPS id x3sm2137700wes.22.2010.12.05.21.41.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 21:41:03 -0800 (PST)
In-Reply-To: <1291613304.3339.12.camel@fixed-disk>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162974>

Il giorno lun, 06/12/2010 alle 00.28 -0500, Anders Kaseorg ha scritto:
> This broke the build with NO_OPENSSL=3D1, so Debian will need to reve=
rt
> it:

I'll try a NO_OPENSSL build later on today and see to get it fixed.

> Also, the Makefile already has a NEEDS_CRYPTO_WITH_SSL flag that=E2=80=
=99s
> automatically set on Darwin, Windows, and MinGW.  We shouldn=E2=80=99=
t have two
> mechanisms for addressing the same problem; maybe we just need to ena=
ble
> the existing flag on more (or all) platforms?

No, these should be different issues; you may have a libssl (which uses
libcrypto) requiring libcrypto to be linked in, even if you only use
interfaces from libssl (and that's what NEEDS_CRYPTO_WITH_SSL seem to b=
e
designed to deal with), but in this case what you have is rather
imap-send using the libcrypto interfaces _as well as_ the libssl
interfaces.

I have blogged a detailed analysis of the problem, if you wish to see
the details:

http://blog.flameeyes.eu/2010/11/26/it-s-not-all-gold-that-shines-why-u=
nderlinking-is-a-bad-thing

--=20
Diego Elio Petten=C3=B2 =E2=80=94 =E2=80=9CFlameeyes=E2=80=9D
http://blog.flameeyes.eu/

If you found a .asc file in this mail and know not what it is,
it's a GnuPG digital signature: http://www.gnupg.org/
