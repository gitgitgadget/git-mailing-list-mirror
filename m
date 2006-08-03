From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 03 Aug 2006 10:18:07 +0200
Organization: At home
Message-ID: <easbev$act$1@sea.gmane.org>
References: <20060803075403.GA5238@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 03 10:18:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8YP9-0005Et-4H
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 10:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHCIRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 Aug 2006 04:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWHCIRx
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 04:17:53 -0400
Received: from main.gmane.org ([80.91.229.2]:48061 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932393AbWHCIRw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 04:17:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8YOj-0005Ay-Ky
	for git@vger.kernel.org; Thu, 03 Aug 2006 10:17:41 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 10:17:41 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 10:17:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24711>

<opublikowany i wys=B3any>

Marc Singer wrote:


> I did some debugging on the latest repo version.  The lines
>=20
>   our $project =3D ($cgi->param('p') || $ENV{'PATH_INFO'});
>   if (defined $project) {
>      ...
>=20
> are being executed even though the url is
>=20
>   http://server/git
>=20
> I think that the problem is that Cherokee translates the request URL
> into
>=20
>   http://server/git/
>=20
> which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> being undefined.

Try changing

my $project =3D ($cgi->param('p') || $ENV{'PATH_INFO'});
if (defined $project) {
        $project =3D~ s|^/||; $project =3D~ s|/$||;

to

my $project =3D ($cgi->param('p') || $ENV{'PATH_INFO'});
$project =3D~ s|^/||; $project =3D~ s|/$||;
if (defined $project && $project) {    =20

(and send patch if it works, please).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
