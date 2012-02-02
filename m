From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [RFC PATCH] gitweb: use CGI with -utf8
Date: Thu, 2 Feb 2012 21:38:16 +0100
Message-ID: <20120202213816.1eabe031@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m37h05c8c1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3QR-0003ER-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab2BBUi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:38:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34997 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab2BBUi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:38:26 -0500
Received: by eaah12 with SMTP id h12so1205406eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=/4lpCfUv9wvKELpoMizlTZ2/Xob8sRtTAi8PT4ZG4t4=;
        b=bn7H+qztigABVPfwwoL4QWTKjX/l5FlYul8IFnIPvHi0bQGsSN+8Gss/xfEiEbbNJT
         fWpOhNxq8YGYGkpuaB5EvGS6tKRYM/OWC9M2iqpwsDnKetAk9EbWJSCw/FKn3PeIYTZb
         W3itws2sHj3aXpY/tDk6bXHUq15q0MpIJZIWE=
Received: by 10.213.9.9 with SMTP id j9mr734184ebj.53.1328215103921;
        Thu, 02 Feb 2012 12:38:23 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e12sm13196766eea.5.2012.02.02.12.38.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:38:23 -0800 (PST)
In-Reply-To: <m37h05c8c1.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189701>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > I noticed that gitweb tries a lot to properly process UTF-8 data, f=
or
> > example it prints my name correctly in log and commit information, =
but
> > it echos junk in the search field. It looks like:
> >=20
> > 	Micha=C3=85=C2=82 Kiedrowicz
> >=20
> > I don't know CGI well and I never touched gitewb code, but I found =
this
> > on http://www.lemoda.net/cgi/perl-unicode/index.html:
> >=20
> > 	use CGI '-utf8';
> > 	my $value =3D params ('input');
> >=20
> > I tried it and that fixed my problem. I'm not sure about the
> > consequences, maybe someone more experienced in CGI might help?
>=20
> I have reworded this to form a proper commit message (see
> Documentation/SubmittingPatches) and I'll resend this as a reply to
> this email.

Thanks, your message is much better.

>=20
> > ---
> >  gitweb/gitweb.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index abb5a79..74d45b1 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -10,7 +10,7 @@
> >  use 5.008;
> >  use strict;
> >  use warnings;
> > -use CGI qw(:standard :escapeHTML -nosticky);
> > +use CGI qw(:standard :escapeHTML -nosticky -utf8);
> >  use CGI::Util qw(unescape);
> >  use CGI::Carp qw(fatalsToBrowser set_message);
> >  use Encode;
> > --=20
>=20
> Does this actually work for you?=20

Yes. It correctly displays "=C5=82" in the search form.

>  Because it doesn't work for me
> (perhaps I have too old CGI module: what CGI.pm and what Perl version
> do you use?).
>=20

$ perl --version

This is perl 5, version 12, subversion 4 (v5.12.4) built for x86_64-lin=
ux
(with 12 registered patches, see perl -V for more detail)

$ eix -e CGI -c
[I] perl-core/CGI (3.510@01.02.2012): Simple Common Gateway Interface C=
lass

> See other solution to this in other reply to this email.
>=20
