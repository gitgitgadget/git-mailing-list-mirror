From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Thu, 7 Oct 2010 01:46:35 +0200
Message-ID: <201010070146.35858.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-4-git-send-email-jnareb@gmail.com> <AANLkTi=DYHQLftyafoijzagTLmy76Uxsa0fiZ1ZO2wc=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dhA-0007JY-9s
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab0JFXqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:46:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46331 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0JFXql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:46:41 -0400
Received: by fxm4 with SMTP id 4so69564fxm.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+56uWWjSWfV7+ag1r5SQKGTtzfEmRmn4Omef03/KxRg=;
        b=FQ4URSn0P6kRdYWcnwLEeqaE+nnETUeoppGf7H3h3ufkFKRIcd6ZkvWaAY06vjpImg
         xRt0QG4ieNoMPk/jrxgWcOo90jyl/MiDZAQsSPb5/RLqPIH74u+CmIzHLOCvaBFNFWzy
         8DDBZrzg+9XTuyTdjxo0EFg4MWmGz5bhYiWvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g76pW2jiqbmK0HkoV+kXck9QnGe8Omoz96RF7PNdPe2WpLuvqodp+/3OPNBK4OoOpX
         /XpvEYYkpP9FN42pp1sPpqXC/r040QkMDR+KUeqtRFUN6DDtQePvl10miAHj07FQLEoy
         JY6ezgkeTFUyKdkjCjcJ8gcKgTtNEDeksjeM4=
Received: by 10.223.112.18 with SMTP id u18mr478567fap.11.1286408799961;
        Wed, 06 Oct 2010 16:46:39 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id k21sm626262faa.1.2010.10.06.16.46.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:46:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=DYHQLftyafoijzagTLmy76Uxsa0fiZ1ZO2wc=@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158357>

On Thu, 7 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote=
:
>=20
> > +sub new {
> > + =C2=A0 =C2=A0 =C2=A0 my ($proto, $p_options_hash_ref) =3D @_;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 my $class =3D ref($proto) || $proto;
> > + =C2=A0 =C2=A0 =C2=A0 my $self =C2=A0=3D {};
> > + =C2=A0 =C2=A0 =C2=A0 $self =3D bless($self, $class);
>=20
> You use:
>=20
>     my $class =3D ref($proto) || $proto;
>=20
> Throughout the new class definitions. Presumably that's just
> copy/pasted from some old docs and you don't actually want to support=
:
>=20
>     my $obj =3D Class->new;
>     my $obj2 =3D $obj->new;
>=20
> It's better just to:
>=20
>     sub new {
>         my ($class, $options) =3D @_:
>         my $self =3D bless {}, $class;
>=20
> Unless there's some reason for the ref($proto) that I've missed.

You are right, the 'my $class =3D ref($proto) || $proto;' dance is not
necessary; we would be always using Class->new().

Will fix.
--=20
Jakub Narebski
Poland
