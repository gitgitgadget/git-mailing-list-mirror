From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (version C) 1/2] gitweb: Prepare for splitting gitweb
Date: Sat, 12 Feb 2011 00:21:56 +0100
Message-ID: <201102120021.58250.jnareb@gmail.com>
References: <1296579016-13356-1-git-send-email-jnareb@gmail.com> <1296579016-13356-4-git-send-email-jnareb@gmail.com> <4D49AB9C.2050307@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "Alejandro R. =?utf-8?q?Sede=C3=B1o?=" <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 12 00:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po2Jg-0001aI-HO
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab1BKXWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 18:22:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58666 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab1BKXWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 18:22:11 -0500
Received: by fxm20 with SMTP id 20so3265946fxm.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 15:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bb5TxIARnvaP17KHYT0sy2ybU2mnVD5KttAg5qM9vGA=;
        b=YbqsoUY6Eq8L/XvlEfBKc+JIjLfHtoCtEC1Fsx2zad2RxWc3e5TU15XfVcN5/e6cT6
         L31JTiMpWbJNnT8hkMbqN55dFTYlwn0jgkXcLw7Tcq1k2X4RH5OSPPleI21mJO6iVdrc
         rZUwVRLl6V9qs79SGeSEr/I42J/BBX6jcfSWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vUZ+GDldcsOkXonmQLuzGGlrekDIX8f9FvvXESvUgRR8CBIrMJMlON4f7b+HG5mnc4
         I9nMY0EVm2Pyy2XB+wpBdRsiDhMc1tJSIr6UWZYhLaE8Iic7zt8hhnpUXOBNgseBlFcy
         /IHuP8U/piTHqw9rvX+ozy/BAVR/XlJ23mRuA=
Received: by 10.223.95.203 with SMTP id e11mr1187735fan.60.1297466529154;
        Fri, 11 Feb 2011 15:22:09 -0800 (PST)
Received: from [192.168.1.13] (abws241.neoplus.adsl.tpnet.pl [83.8.242.241])
        by mx.google.com with ESMTPS id 17sm658521far.43.2011.02.11.15.22.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 15:22:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D49AB9C.2050307@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166578>

On Wed, 2 Feb 2011, Alejandro R. Sede=C3=B1o wrote:
> On 2/1/2011 11:50 AM, Jakub Narebski wrote:
> >
> > Prepare gitweb for being split into modules that would be installed
> > in gitweblibdir, by default alongside gitweb in 'lib/' subdirectory=
=2E
> >=20
> > Gitweb would search first in 'lib/' subdirectory from where it is
> > installed, via
> >=20
> >   use lib __DIR__.'/lib';
> >=20
> > (This allow for tests to work with source version of gitweb without
> > changes.)  Then it searches in $(gitweblibdir) directory (set durin=
g
> > build time), by default "$(gitwebdir)/lib", via
> >=20
> >   use lib "++GITWEBLIBDIR++";
> >=20
> > "++GITWEBLIBDIR++" is set to appropriate value during build time
> > (generating gitweb.cgi).  This allows to select where to install
> > gitweb modules via 'gitweblibdir' build time configuration variable
>=20
> I would personally prefer to see this path taken, as it seems the mos=
t
> flexible and would fulfill a use case I have.
>=20
> I maintain a build of git in an AFS volume at MIT. One of its uses is
> symlinking to the current gitweb.cgi to instantly deploy a gitweb in =
a
> shared hosting environment (example: http://git.scripts.mit.edu/).
>=20
> __DIR__ would point to the directory containing a user symlink to
> gitweb, which would allow users to add their own libraries, while
> ++GITWEBLIBDIR++ would allow the standard gitweb libraries to be
> hosted at a common path without placing additional burdens on the
> user at upgrade time.

Note however that if you want __DIR__ version to take preference over
gitweblibdir version, then the 'use lib' statements have to be in=20
reverse order, i.e.:

  +use lib "++GITWEBLIBDIR++";
  +use lib __DIR__ . '/lib';

--=20
Jakub Narebski
Poland
