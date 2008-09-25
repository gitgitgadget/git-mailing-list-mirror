From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list (templating)
Date: Fri, 26 Sep 2008 00:16:42 +0200
Message-ID: <200809260016.43173.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <200809251852.23315.jnareb@gmail.com> <20080925171029.GQ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:18:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KizA2-0004lH-Hg
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 00:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYIYWQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbYIYWQy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 18:16:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:55794 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbYIYWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 18:16:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so440076fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qty216TVUsJNuX1N/Ydg9ertjCTqLlO1F9DixPy+Hwg=;
        b=ZYqvUDI6Xavnq657daH3iOjkXq+cs0zC6qSHO3SQjOHRbd69Sx/r1U1yVWQAnuhOI1
         95LAjb8kgwnI3Jo+fl57/Fz6nQGT3uGSU8Y8RoIQmt1EbWzI3Xbla6dwnRkDkcsd4xP5
         9/pdjIxsO37etcQD7qfixidBCUYdjOXun+Pbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bF89Gox9s3QF78VLXzzhnHOf6vmlN2B1Ghv0hFuzwUV19FLDfulNE7w1hUHfH45tvp
         0RM4p4cP4xb9s8hvh7KEkOYq+cxYSNBTuVOgc+awmUntulls5BXgLydtCRdfnSd8qem7
         Hi2injaRLBsDrmXl1E1755rXcVnosHAdNEylc=
Received: by 10.180.244.19 with SMTP id r19mr321576bkh.94.1222381011209;
        Thu, 25 Sep 2008 15:16:51 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id 31sm1793305fkt.3.2008.09.25.15.16.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 15:16:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080925171029.GQ10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96810>

Dnia czwartek 25. wrze=B6nia 2008 19:10, Petr Baudis napisa=B3:
> On Thu, Sep 25, 2008 at 06:52:22PM +0200, Jakub Narebski wrote:
> >
> > I think that making gitweb use something like Gitweb::Template, whe=
re
> > action appearance is governed by templates, be it something like
> > git-for-each-ref --format or StGit *.tmpl files, or XSLT / XSL,
> > could be a good idea.  But I think _that_ would require almost writ=
ing
> > from scratch, certainly making it long-term gitweb fork, perhaps ev=
en
> > with different name (and not residing inside git.git repository).
> >=20
> > We can discuss this idea here in this subthread.  For example: do
> > create Gitweb::Template like HTML::Template or use Template Toolkit=
;
> > which parts put in template and which in "gitweb" driver, etc.
>=20
> Actually, my implementation works quite differently - the idea of the
> templates is that you just specify data from which files to show and
> whether to take them right away or tabulate them in some way - so it =
is
> something very abstract, and agnostic to _presentation_ layer, which =
is
> still provided by gitweb. An example of made-up template configuratio=
n
> file would look something like:
>=20
> [action "summary"]
> 	sections =3D metadata overview README shortlog forks
>=20
> [section "overview"]
> 	type =3D csv
> 	row =3D Project Title,(info.txt:title)
> 	row =3D Project Authors,(info.txt:authors)
> 	row =3D Bussiness Impact,(info.txt:bizimpact)
> 	row =3D Base Equation,[formula.png]
>=20
> [section "README"]
> 	type =3D html
> 	content =3D (README.html)

Gaaaah. I think this is heavy abuse of _configuration_ mini-language
git uses (extended ini-like syntax); it can be done, but it is IMVHO
on par of writing A.I. (Artificial Intelligence) in COBOL:
  http://ars.userfriendly.org/cartoons/?id=3D20001018

--=20
Jakub Narebski
Poland
