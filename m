From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Make git_get_refs_list do work of git_get_references
Date: Thu, 21 Sep 2006 00:40:52 +0200
Message-ID: <200609210040.52886.jnareb@gmail.com>
References: <200609191430.51252.jnareb@gmail.com> <200609191433.22878.jnareb@gmail.com> <7veju6h0et.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 00:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAkb-00051o-7X
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWITWky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Sep 2006 18:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWITWky
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:40:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:11494 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932428AbWITWkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 18:40:53 -0400
Received: by ug-out-1314.google.com with SMTP id o38so58705ugd
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 15:40:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Yw0IB0/icZIaes5VF6zg8OJCSI32eTGDvPKuOl6k+1Hs5Io4sgMkoiTvm5u2/VATQ5CY9vOQYLeCuEllkhTRhTaZfGEOTVrdF+8qjdQwsMnskgDFsqirMm7+IB/DU2m/tRwvdry287hs81QvOw/bzcWU+W7TpGgtWU5Ot6bqgUA=
Received: by 10.67.89.5 with SMTP id r5mr8595696ugl;
        Wed, 20 Sep 2006 15:40:52 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id 55sm358234ugq.2006.09.20.15.40.50;
        Wed, 20 Sep 2006 15:40:51 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7veju6h0et.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27420>

Junio C Hamano wrote:
> Jakub Narebski wrote:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (=
! $4) { # unpeeled, direct reference
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0push @refs, { hash =3D> $1, name =3D> $3 }; # without=
 type
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} el=
sif ($3 eq $refs[-1]{'name'}) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0# most likely a tag is followed by its peeled
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0# (deref) one, and when that happens we know the
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0# previous one was of type 'tag'.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0$refs[-1]{'type'} =3D "tag";
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
>>...
>> -=A0=A0=A0=A0=A0return \@reflist;
>> +=A0=A0=A0=A0=A0return (\@reflist, \%refs);
>=20
> You are maintaining reflist (an array of hashrefs each element
> of which describes name, type, hash and other parse_ref()
> information for the ref) and refs (a hash that maps from name to
> hash) separatly. =A0I wonder if this really has the performance
> advantage over just compute and return reflist from here and
> have the callers who need the mapping to derive it from the list
> (i.e.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0my ($reflist) =3D git_get_refs_list();
> =A0=A0=A0=A0=A0=A0=A0=A0my %refs =3D map { $_->{name} =3D> $_->{hash}=
 } @$reflist;
> ).

The %refs hash contain also map from peeled (dereferenced) object
to ref name. The information about derefs is not present in @reflist.
So the answer is that you can't derive %refs from @reflist.=20
--=20
Jakub Narebski
ShadeHawk on #git
Poland
