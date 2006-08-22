From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 11:34:46 +0200
Organization: At home
Message-ID: <ecej3m$rv2$3@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org> <7vodudno88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 22 11:41:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFSkO-0006Nv-Uw
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 11:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWHVJke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Aug 2006 05:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWHVJke
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 05:40:34 -0400
Received: from main.gmane.org ([80.91.229.2]:39909 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751377AbWHVJkd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 05:40:33 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GFSjq-0006HT-SX
	for git@vger.kernel.org; Tue, 22 Aug 2006 11:40:03 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 11:40:02 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 11:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25848>

Junio C Hamano wrote:

> So the last part of the above should perhaps read:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0my @result =3D ();=20
> =A0 =A0 =A0 =A0 for (my $i =3D 0; $i < @mapping; $i +=3D 2) {
> =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0my ($name, $symbol) =3D ($map=
ping[$i], $mapping[$i+1]);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (defined $params{$=
name}) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0push @result, join('=3D', esc_param($symbol),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0esc_param($params{$name}));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0}

There is really no need to escape $symbol; we control this,
and it is CGI param safe.

BTW. why use join? The following

        push @result, "$symbol=3D" . esc_param($params{$name});=20

would be simplier... we could even use

        $href .=3D ($i > 0? ";" : "") . "$symbol=3D" . esc_param($param=
s{$name});

although probably this isn't best idea (worse readibility).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
