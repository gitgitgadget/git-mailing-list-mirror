From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v3 21/28] git-remote-mediawiki: Put long code into a subroutine
Date: Wed, 12 Jun 2013 00:24:43 +0200
Message-ID: <51B7A3AB.5090803@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr> <1370816573-3808-22-git-send-email-celestin.matte@ensimag.fr> <7vli6gd582.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 00:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWzg-0002mc-J3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab3FKWYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 18:24:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52512 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3FKWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:24:44 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BMOcwr027381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 00:24:38 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BMOf3a024228;
	Wed, 12 Jun 2013 00:24:41 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BMOeto027155;
	Wed, 12 Jun 2013 00:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vli6gd582.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 00:24:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227570>

Oops, forgot to take this into account before sending v4 of my series o=
f
patch. I just noticed that, sorry...

Le 11/06/2013 17:42, Junio C Hamano a =C3=A9crit :
> I am guessing that the new sub, parse_command, uses a local @cmd and
> this is an attempt to avoid using the same name, but this renaming
> of the variable is not explained.

This is indeed what I intended to do.

> I also wonder if you need this global @cmd/@cmds.  Instead of
> passing cmdref, wouldn't it be simpler to have the helper split the
> line, i.e. something like...
>=20
> 	sub parse_command {
> 		my ($line) =3D @_;
>                 my @cmd =3D split(/ /, $line);
> 		unless (defined @cmd) {
> 	                return 0;
> 		}
>                 ... check capabilities, list, etc....
> 		return 1;
> 	}
>=20
>         while (<STDIN>) {
>         	chomp;
>                 if (!parse_command($_)) {
> 			unknown command, aborting
>                         last;
> 		}
> 	}
>=20
>=20


--=20
C=C3=A9lestin Matte
