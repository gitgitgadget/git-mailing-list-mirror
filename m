From: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 08:56:55 +0100
Message-ID: <20090303075655.GB9875@lars.home.noschinski.de>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com> <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se> <200903021530.01165.trast@student.ethz.ch> <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePWG-0000Ed-MT
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbZCCH5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 02:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZCCH5A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:57:00 -0500
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:36514 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbZCCH47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:56:59 -0500
Received: from [87.78.70.62] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1LePUm-0006ay-4G; Tue, 03 Mar 2009 08:56:56 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1LePUl-0002cD-DA; Tue, 03 Mar 2009 08:56:55 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112018>

* Peter Krefting <peter@softwolves.pp.se> [09-03-02 21:41]:
> Indeed. It is unfortunate that this wasn't properly specified to star=
t with.=20
> It's mostly a minor issue since *most* people will not use non-ASCII =
file=20
> names. At least for most of the kind of projects that Git have attrac=
ted so=20
> far, so the problem is not that big. The problem is if Git is to attr=
act "the=20
> masses". Especially on Windows, where file names using non-ASCII are =
common,=20
> this needs to be addressed eventually.

Using no encoding for filenames was the obvious (and I would argue)
correct choice. Unix filenames are specified to be a sequence of bytes,
excluding '/' and '\0'. A lot of these sequences are not valid UTF-8.
=46urther, the encoding needed for filenames depends on the encoding us=
ed
in the source code for referencing these files. Again, for the unix fil=
e
handling functions, this means no encoding.

Changing the filename (on checkout), so that the user sees an =DC
regardless of his or her locale (instead of an \0xDC, which only
resolves to an =DC on latin-1) would be an absolutely broken concept he=
re.

> >[*] I'm _extremely_ tempted to write "people using non-broken OSes",=
 but let's=20
> >pretend to be neutral for a second.
>=20
> In most cases, I would most definitely agree with you on calling it t=
hat, but=20
> when it comes to Unicode support, Windows is one of the least broken =
OSes (with=20
> Symbian being my favourite).

IMHO having encoding specific open functions is begging for problems.

 - Lars.
