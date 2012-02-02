From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] gitweb: use CGI with -utf8
Date: Thu, 02 Feb 2012 12:01:41 -0800 (PST)
Message-ID: <m37h05c8c1.fsf@localhost.localdomain>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?b?TWljaGHFgiBLaWVkcm93aQ==?= =?utf-8?b?Y3o=?= 
	<michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:01:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2r0-0003vK-7S
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617Ab2BBUBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:01:45 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61417 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933608Ab2BBUBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:01:43 -0500
Received: by eekc14 with SMTP id c14so898073eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Yl8yfIqxl6HHR9H8OvFOOADl0gKPcBp/EmDT8gEIGuc=;
        b=xANNDN2bIdGWuuldGlrIGeYNY0aHaxe9Hy3DAuUoEtW00oVDu0M7FaL/lwJAlO2kDZ
         YUn9YL36X0t6CLv6jr+Isel7lJauSAu3S5VZu1NxhJvtIlsrjzpCaN6JvjW84EeFyyxC
         63M/K6hQ9khTbFrX30NXso7ceeVA79qACDyn0=
Received: by 10.14.28.134 with SMTP id g6mr1375880eea.15.1328212901604;
        Thu, 02 Feb 2012 12:01:41 -0800 (PST)
Received: from localhost.localdomain (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id n17sm12856338eei.3.2012.02.02.12.01.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:01:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q12K2NgH017878;
	Thu, 2 Feb 2012 21:02:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q12K2MNa017875;
	Thu, 2 Feb 2012 21:02:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189687>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> I noticed that gitweb tries a lot to properly process UTF-8 data, for
> example it prints my name correctly in log and commit information, bu=
t
> it echos junk in the search field. It looks like:
>=20
> 	Micha=C3=85=C2=82 Kiedrowicz
>=20
> I don't know CGI well and I never touched gitewb code, but I found th=
is
> on http://www.lemoda.net/cgi/perl-unicode/index.html:
>=20
> 	use CGI '-utf8';
> 	my $value =3D params ('input');
>=20
> I tried it and that fixed my problem. I'm not sure about the
> consequences, maybe someone more experienced in CGI might help?

I have reworded this to form a proper commit message (see
Documentation/SubmittingPatches) and I'll resend this as a reply to
this email.

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index abb5a79..74d45b1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -10,7 +10,7 @@
>  use 5.008;
>  use strict;
>  use warnings;
> -use CGI qw(:standard :escapeHTML -nosticky);
> +use CGI qw(:standard :escapeHTML -nosticky -utf8);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser set_message);
>  use Encode;
> --=20

Does this actually work for you?  Because it doesn't work for me
(perhaps I have too old CGI module: what CGI.pm and what Perl version
do you use?).

See other solution to this in other reply to this email.

--=20
Jakub Narebski
