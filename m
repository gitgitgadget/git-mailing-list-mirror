From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add config_int() method to the Git perl module
Date: Fri, 23 Nov 2007 21:57:20 +0100
Message-ID: <5B17707B-115E-45C8-895F-BD7020A3355A@wincent.com>
References: <200711231904.53551.jnareb@gmail.com> <7vabp4u40y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dan Zwell <dzwell@zwell.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivfbj-0006uz-0Z
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXKWU6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 15:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbXKWU6U
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:58:20 -0500
Received: from wincent.com ([72.3.236.74]:60844 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbXKWU6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 15:58:20 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANKvMS1020660;
	Fri, 23 Nov 2007 14:57:24 -0600
In-Reply-To: <7vabp4u40y.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65926>

El 23/11/2007, a las 20:59, Junio C Hamano escribi=F3:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Integer variables can have optional 'k', 'm' or 'g' suffix.
>> config_int() method will return simple decimal number, taking
>> care of those suffixes.
>
> Good.  I forgot about --int option to "git config" already.
>
> Maybe in a similar way, we might want to add --color to "git
> config" to return ANSI sequence, so that Git::config_color() can
> work without even loading Term::ANSIColor?

Or failing that, it would be very easy to remove the dependency on =20
Term::ANSIColor by adding something like this to Git.pm:

+my $COLOR =3D {
+       "reset"         =3D> "\e[0m",
+       "normal"        =3D> "",
+       "black"         =3D> "\e[30m",
+       "red"           =3D> "\e[31m",
+       "green"         =3D> "\e[32m",
+       "yellow"        =3D> "\e[33m",
+       "blue"          =3D> "\e[34m",
+       "magenta"       =3D> "\e[35m",
+       "cyan"          =3D> "\e[36m",
+       "white"         =3D> "\e[37m",
+       "bold"          =3D> "\e[1m",
+       "ul"            =3D> "\e[4m",
+       "blink"         =3D> "\e[5m",
+       "reverse"       =3D> "\e[7m",
+       "on_red"        =3D> "\e[41m",
+};
+
+sub color {
+       my $desired_color =3D shift;
+       return $COLOR->{$desired_color} || "";
+}

Cheers,
Wincent
