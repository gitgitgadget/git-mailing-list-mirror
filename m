From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Thu, 7 Oct 2010 01:00:31 +0200
Message-ID: <201010070100.33478.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-4-git-send-email-jnareb@gmail.com> <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:01:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cyp-0005jl-3w
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240Ab0JFXAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:00:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34967 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966Ab0JFXAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:00:41 -0400
Received: by fxm4 with SMTP id 4so53877fxm.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gIB1+/V68OhTN4qbJnIf67enyx0Xzk6uEAh/48/qiE4=;
        b=M3ajYc+fPnOTuqnTznhA/ZQO2pA0A5XPXEB646gCp2VcMAPT3+pDwMYfUJwowf1Wse
         xt3XGuk2Ryuzf91s6Em3b74iK82rcoGYC8463xFszuIZz/yh7fwajKYYH8JrSSrdvEzy
         AHe1vJqWZuT/WRDt2w2ubDxbb7w1KKCneuCMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HQcCpYVxWPB6h4lDJBSw2UZ34KhXy7Xggbp5g0JMESL/5Sd+CuynBlc8pxeuWqrPl5
         9GCdj/8IlWTFZArNahmm+55aqd4wdP6l0iEBug4yT8E1IuHWDSevdaJbFoBVWQR3EQVI
         IxGd82xMTVU1EDkePTNa0yqaXrfSAJ7kYkxhw=
Received: by 10.223.117.204 with SMTP id s12mr5091645faq.22.1286406039226;
        Wed, 06 Oct 2010 16:00:39 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id s20sm720489faa.28.2010.10.06.16.00.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:00:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158344>

Thank you very much for those comments on code.

On Thu, 7 Oct 2010, Thomas Adam wrote:
> On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:

> > +# creates get_depth() and set_depth($depth) etc. methods
> > +foreach my $i (qw(depth root namespace)) {
> > + =C2=A0 =C2=A0 =C2=A0 my $field =3D $i;
> > + =C2=A0 =C2=A0 =C2=A0 no strict 'refs';
>=20
> For each item, you'll set "no strict refs"?  This might be better off
> outside the loop.  It's still scoped appropriately inside the
> subroutine.

On the other hand this way scope where "no strict 'refs';" is active
is limited... but I guess having "no strict 'refs';" outside loop would
be better.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
> > + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $fi=
le);
>=20
> PBP (Perl Best Practises) will tell you that explicitly returning
> undef is discouraged -- "undef" should be reserved for those errors
> you cannot handle, not ones you don't want to.

Well, Perl Best Practices are practices; sometimes there is good reason
to not take them into account (though probably not in this case).

Explicitly returning undef is discouraged because in list context the
returned undef (or rather 1-element list with 'undef' as sole element)
is true-ish.

On the other hand

> > +# $cache->set($key, $data);
> > +#
> > +# Associates $data with $key in the cache, overwriting any existin=
g entry.
> > +# Returns $data.
> > +sub set {
> > +       my ($self, $key, $data) =3D @_;
> > +
> > +       return unless (defined $key && defined $data);
>=20
> return what?
=20
as you can see 'return' statement with no value looks rather cryptic
with statement modifier (conditional).

I should really have run gitweb, caching modules and tests through=20
perlcritic...

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last if $read_cn=
t =3D=3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $size_left -=3D =
$read_cnt;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #last if $size_l=
eft <=3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 close $read_fh
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn't=
 close file '$file' opened for reading: $!";
> > + =C2=A0 =C2=A0 =C2=A0 return $buf;
> > +}
>=20
> "use Carp;" would be more useful here, and hence croak() and confess(=
).

=46or a web application we usually do not want to have too detailed err=
or
message present to client (to web browser) to avoid leaking of sensitiv=
e
information.
=20
> > + =C2=A0 =C2=A0 =C2=A0 # ensure that directory leading to cache fil=
e exists
> > + =C2=A0 =C2=A0 =C2=A0 if (!-d $dir) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval { mkpath($d=
ir, 0, 0777); 1 }
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or die "Couldn't create leading directory '$dir' (mkpath): $=
!";
> > + =C2=A0 =C2=A0 =C2=A0 }
>=20
> Why is this eval()ed?  It will still return false and set $! appropri=
ately.

IIRC mkpath *dies on error*, rather than returning false.  For better
error handling we would need to use make_path, but File::Path 2.0+
is in [stable] core only since Perl 5.10.
=20
[...]
> > +# $data =3D $cache->compute($key, $code);
> > +#
> > +# Combines the get and set operations in a single call. =C2=A0Atte=
mpts to
> > +# get $key; if successful, returns the value. =C2=A0Otherwise, cal=
ls $code
> > +# and uses the return value as the new value for $key, which is th=
en
> > +# returned.
> > +sub compute {
> > + =C2=A0 =C2=A0 =C2=A0 my ($self, $key, $code) =3D @_;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 my $data =3D $self->get($key);
> > + =C2=A0 =C2=A0 =C2=A0 if (!defined $data) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $data =3D $code-=
>($self, $key);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $self->set($key,=
 $data);
> > + =C2=A0 =C2=A0 =C2=A0 }
>=20
> Can you guarantee $code here?

I don't want to code too defensively, but perhaps check for this is in
order... though what we should do if $code is not code reference?

>=20
> unless( defined $code and ref $code eq 'CODE' )

"ref($code) eq 'CODE'" would be enough; 'undef' is not reference, and
ref(undef) returns "".

> {
>         ....
> }
>=20
> Wouldn't it be easier to eval{} this and check $@?

So the answer is no.


Thanks again for your comments.
--=20
Jakub Narebski
Poland
