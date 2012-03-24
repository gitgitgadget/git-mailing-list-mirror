From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 1/8] gitweb: esc_html_hl_regions(): Don't create
 empty <span> elements
Date: Sun, 25 Mar 2012 00:38:54 +0100
Message-ID: <20120325003854.7a4e309c@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-2-git-send-email-michal.kiedrowicz@gmail.com>
	<201203241958.23835.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 00:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBaYa-0003GR-PN
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 00:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab2CXXi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 19:38:59 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42997 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab2CXXi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 19:38:58 -0400
Received: by wibhq7 with SMTP id hq7so3195925wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=j3Zr3CeUOdX2qUquXW5ksIj54e3QRZWOsiDjz1Two+4=;
        b=GdAx1hbaN5JY/MAO7yVrj6Weu0j+YackOKqDGahFtCKCcYmeMNN+NM5Gab9H9PTO+v
         dh/4tqXf8UDXHiZQ0KUPJv/mJM8aneJPWDaFAdxoQQxKPTt313uikLlN5IWxn+yd4PjC
         ADLPaADMMIaz+NezDLguD/UoptbaGwXF61ETePaEXvG8rS9256PwD/YPIsebjPVGKIRl
         jXJrAF6VXk3I5Sax2Nprbb5dBcVhjl7pFZ6Tg4YLuPPHHwfGwwyHv5E3lHYW8pgNc4p6
         MltQRtKgqYeL0pdOt8z+oxVAN+V53BTJ1eMAUw9noQxUVG1ftoC2EyJInULAPkEjl/bz
         KZ0Q==
Received: by 10.180.95.74 with SMTP id di10mr8847168wib.1.1332632336877;
        Sat, 24 Mar 2012 16:38:56 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e6sm26952178wix.8.2012.03.24.16.38.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 16:38:56 -0700 (PDT)
In-Reply-To: <201203241958.23835.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193851>

Jakub Narebski <jnareb@gmail.com> wrote:

> Note: all those minor issues can be fixed while applying, I think.
>=20
> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > if $s->[1] is equal to or less than $s->[0], esc_html_hl_regions()
>   ^^
> s/if/If/
>=20
> > generates an empty <span> element.  It normally shouldn't be visibl=
e in
> > the web broweser, but it doesn't look good when looking at page sou=
rce.
>           ^^^^^^^^=20
> s/broweser/browser/

Thanks.  I'm terribly sorry for these typos.  I really must tripple
check everything I write.

>=20
> > It also minimally increases generated page size for no special reas=
on.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >=20
> > I don't know if any code currently can produce empty <span> element=
s,
> > but diff refinement highlighning does it.
>=20
> I didn't want to make esc_html_hl_regions() paranoid and boggle it do=
wn
> with checking that gitweb called it with sane values of parameters,
> but this one is cheap and simple. =20
>=20
> It might be better to make esc_html_hl_regions() more robust instead
> of modifying future caller to skip empty regions.
>=20

Yeah, the caller is just

+$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len, @rem - =
$suffix_len], -nbsp=3D>1);
+$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len, @add - =
$suffix_len], -nbsp=3D>1);

Without this patch I would have to do (untested)

+# Create <span> only if there is anything to mark.
+if($prefix_len < @rem - $suffix_len) {
+	$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len, @rem -=
 $suffix_len], -nbsp=3D>1);
+} else {
+	$esc_rem =3D esc_html($rem, -nbsp=3D1);
+}
+if($prefix_len < @add - $suffix_len) {
+	$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len, @add -=
 $suffix_len], -nbsp=3D>1);
+} else {
+	$esc_add =3D esc_html($add, -nbsp=3D1);
+}

or something like that.

> I have not read the rest of this series; for the time being condition=
al
> ACK from me.
>=20
> >  gitweb/gitweb.perl |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index a8b5fad..af645e5 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1738,6 +1738,9 @@ sub esc_html_hl_regions {
> >  	my $pos =3D 0;
> > =20
> >  	for my $s (@sel) {
> > +		# Don't craete empty <span> elements.
>                         ^^^^^^
> s/craete/create/
>=20
> > +		next if $s->[1] <=3D $s->[0];
> > +
> >  		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
> >  			if ($s->[0] - $pos > 0);
> >  		$out .=3D $cgi->span({-class =3D> $css_class},
> > --=20
> > 1.7.8.4
> =20
> P.S. I wonder if it wouldn't be better if we created and used loop-lo=
cal
> variables with descriptive names, e.g.
>=20
>   my ($beg, $end) =3D @$s;
>=20
> and use $beg in place of $s->[0] and $end in place of $s->[1], which =
are
> a bit cryptic.
>=20
> This of course doesn't affect this patch.
>=20
