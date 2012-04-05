From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 1/8] gitweb: Use descriptive names in
 esc_html_hl_regions()
Date: Thu, 5 Apr 2012 07:46:19 +0200
Message-ID: <20120405074619.39174f54@mkiedrowicz.ivo.pl>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1333569433-3245-2-git-send-email-michal.kiedrowicz@gmail.com>
	<7vwr5v6uts.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFfWm-0002FF-TY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 07:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab2DEFqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 01:46:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45141 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab2DEFqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 01:46:32 -0400
Received: by wejx9 with SMTP id x9so616625wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=wCDalmyYfe9B+nZs7IQnK0E4NtQMhYqQ9kfFyOs9d8Y=;
        b=rOL2GV75ZOJ5RKMEz1dW+oBm7p8se+KmIWNhcFdo6UIb2QyrjK86Qw8RvVj62s66LL
         uPQZ0BkccvP5rMfJAuP0ir03FoNJwybDFirXhxenOqXRAuuaZN5X1O7Wl0saLqOh2aPv
         mOyEUFPnCqCknN3ZifnweX/hLgKLe8JIkzsX03Whxe2R8416JAxbdWVdyKs7SbljQIGQ
         xJp1WL5fjDolNMr4ELb8VAKBwYaj4hz+yoox0hyhoAHr8S3Sf5EjZsji7QsEyq9Ko0MV
         PERIGQBwmEuBDyqJjDWz5QrxwmHcG+DBKrhF6TznAcTsLSQawYh/3xp3FCaKq7PY5+tT
         AP8Q==
Received: by 10.180.95.34 with SMTP id dh2mr1541036wib.15.1333604790567;
        Wed, 04 Apr 2012 22:46:30 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id n8sm12490672wix.10.2012.04.04.22.46.29
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 22:46:30 -0700 (PDT)
In-Reply-To: <7vwr5v6uts.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194760>

Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > The $s->[0] and $s->[1] variables look a bit cryptic.  Let's rename
> > them to $beg and $end so that it's clear what they do.
>=20
> Why not $begin and $end?

=46or no special reason.  I just took the names that Jakub proposed in

	http://article.gmane.org/gmane.comp.version-control.git/193839/
>=20
> >
> > Suggested-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index a8b5fad..a3754ff 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1738,12 +1738,14 @@ sub esc_html_hl_regions {
> >  	my $pos =3D 0;
> > =20
> >  	for my $s (@sel) {
> > -		$out .=3D esc_html(substr($str, $pos, $s->[0] -
> > $pos))
> > -			if ($s->[0] - $pos > 0);
> > +		my ($beg, $end) =3D @$s;
> > +
> > +		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
> > +			if ($beg - $pos > 0);
> >  		$out .=3D $cgi->span({-class =3D> $css_class},
> > -		                   esc_html(substr($str, $s->[0],
> > $s->[1] - $s->[0])));
> > +		                   esc_html(substr($str, $beg,
> > $end - $beg)));=20
> > -		$pos =3D $s->[1];
> > +		$pos =3D $end;
> >  	}
> >  	$out .=3D esc_html(substr($str, $pos))
> >  		if ($pos < length($str));
