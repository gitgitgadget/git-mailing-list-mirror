From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 22:01:25 +0200
Organization: At home
Message-ID: <ecfnqj$5m9$1@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org> <7vodudno88.fsf@assigned-by-dhcp.cox.net> <86fyfohb4v.fsf@blue.stonehenge.com> <ecfnf0$4bg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 22 22:02:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFcRw-0000H1-MN
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHVUB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Aug 2006 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWHVUB6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 16:01:58 -0400
Received: from main.gmane.org ([80.91.229.2]:23184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751240AbWHVUB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 16:01:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFcRT-00009X-LD
	for git@vger.kernel.org; Tue, 22 Aug 2006 22:01:43 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 22:01:43 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 22:01:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25869>

<opublikowany i wys=B3any>

Jakub Narebski wrote:

> Randal L. Schwartz wrote:
>=20
>>>>>>> "Junio" =3D=3D Junio C Hamano <junkio@cox.net> writes:
>>=20
>> Junio>        my @result =3D ();=20
>> Junio>         for (my $i =3D 0; $i < @mapping; $i +=3D 2) {
>> Junio>                my ($name, $symbol) =3D ($mapping[$i], $mappin=
g[$i+1]);
>> Junio>                if (defined $params{$name}) {
>> Junio>                        push @result, "$symbol=3D$params{$name=
}";
>> Junio>                }
>> Junio>        }
>> Junio>         return "$my_uri?" . esc_param(join(';', @result));
>> Junio> }
>>=20
>> If you already depend on the LWP package, then the "URI" module
>> does precisely what you're reinventing.
>>=20
>> my $uri =3D URI->new("http://host/base/path")
>> $uri->query_form(\%params);
>> my $result =3D $uri->as_string;
>>=20
>> And I'd rely on Gisle Aas's experience about constructing these thin=
gs
>> far more than the thread I've just witnessed here. :)
>=20
> First, I'd rather not introduce new dependency to git (and I think Ju=
nio
> would agree). Second, more important, we do _parameters processing_,
> it means renaming parameters (e.g. 'file_name' in params is 'p' in CG=
I URI),
> in the future perhaps passing project via PATH_INFO not in query stri=
ng,
> and sorting the CGI parameters.
>=20
> So it wouldn't be as easy as writing=20
>         $uri->query_form(\%params);=20
>         return $uri->as_string;
> or as=20
>         return "$my_uri?" . esc_param(join(";", "$_=3D$params{$_}") k=
eys %params)'.

Third, read comment to esc_param:

        # quote unsafe chars, but keep the slash, even when it's not
        # correct, but quoted slashes look too horrible in bookmarks

I assume that URI module methods do not keep slash...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
