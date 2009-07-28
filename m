From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 16:22:19 +0200
Message-ID: <20090728142219.GA16168@vidovic>
References: <200907280513.59374.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Jul 28 16:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVnaZ-00031x-Rr
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 16:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbZG1OW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZG1OW0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 10:22:26 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42688 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbZG1OWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 10:22:25 -0400
Received: by ewy26 with SMTP id 26so57508ewy.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F9RupM03YSrlCjEgOp2N/WM08MTY9REiJb745oM2B2w=;
        b=R1GE8nWWJWoEQxLxWRpxlYjqcYwshHko38ejL6YCZ8tfcjB7QRYTtjuELX4PBz68I2
         fRP+bq01dHLgrN9KLh+Alqz+iEeFJZheqxpbkbVQOCLbXs29/hsGcLTrZjYQ0smgjBqI
         EBgC7uXHvPrtnvAs7qa48GC3kveVp/gOpEU5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iHA+5TYUtE7Ft0g653c/0RXnZW/ZvRkY+wv5dZneJZzZqK+s5qvU40DYcMVop6mroe
         tDVTFwfc3IT7hMxs8ku6t8I3TH4wzC2Cvhs/VPYV7ITJfKw21zVKGLyithZlAHqA8xdv
         m+/4G9d8pbKqDFEB30LFpMSrj0ThncIrJoYVk=
Received: by 10.210.141.9 with SMTP id o9mr6784850ebd.10.1248790944651;
        Tue, 28 Jul 2009 07:22:24 -0700 (PDT)
Received: from @ (91-165-131-3.rev.libertysurf.net [91.165.131.3])
        by mx.google.com with ESMTPS id 7sm249062eyb.22.2009.07.28.07.22.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 07:22:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907280513.59374.elendil@planet.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124252>

The 28/07/09, Frans Pop wrote:
>=20
> That's a very useful feature. However, on lkml there are frequently a=
lso=20
> mails with the following structure (example: [1]).
>=20
> [1] http://lkml.org/lkml/2009/7/10/49

This is an example of what not to do. Content after the '---' won't be
part of the commit message.

  $ man git-am
  <snip>
	The commit message is formed by the title taken from the "Subject: ",
  a blank line and the body of the message up to where the patch begins=
=2E
  Excess whitespace at the end of each line is automatically stripped.

  The patch is expected to be inline, directly following the
  message. Any line that is of the form:
   =B7   three-dashes and end-of-line, or
   =B7   a line that begins with "diff -", or
   =B7   a line that begins with "Index: "
  is taken as the beginning of a patch, and the commit log message
  is terminated before the first occurrence of such a line.
  <snip>

> <example>
> [Regular mail headers, including From: and Subject:]
>=20
> [Comments, quotes from previous messages, or some introduction]
>=20
> From: [email address]
> Subject: [patch short description]
> [patch long description]
>=20
> [patch diff]
> </example>
>=20
> Here the overruling pseudo-headers are not at the beginning of the=20
> message, which results in all the leading comments getting included i=
n=20
> the commit log and those have to be cleaned manually.
>=20
> Would it be possible to add an option to git-am to "reset" the commit=
 log=20
> when it encounters either a From: or Subject: pseudo header, so that =
only=20
> the intended patch short and long descriptions are used for the commi=
t=20
> log?

IMHO, a better way would be to ignore lines beginning with a defined
level of quotes in the commit message (the "level" beeing the number of
'>' or '> ' found at the beginning of a line. Something like

	--strip-quotes[=3DN]

where N is the level of quoted lines to remove (if "=3DN" is
not given, assume that the level is 1 and remove all the quotes).

Comments?

--=20
Nicolas Sebrecht
