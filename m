From: John Keeping <john@keeping.me.uk>
Subject: Re: how do I ignore a directory for diff
Date: Sun, 5 Apr 2015 15:58:25 +0100
Message-ID: <20150405145825.GF21452@serenity.lan>
References: <BLU168-W455AD13F694F68E77DFD0EB4FF0@phx.gbl>
 <20150405121705.GE21452@serenity.lan>
 <BLU436-SMTP49446C5C4D772905567D4B4FF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Lionel CHAZALLON <LongChair@hotmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:59:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yem0r-00058N-Qb
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 16:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbbDEO6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 10:58:33 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:40847 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbDEO6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2015 10:58:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A45AB2184B;
	Sun,  5 Apr 2015 15:58:31 +0100 (BST)
X-Quarantine-ID: <4fIwFILmIcka>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4fIwFILmIcka; Sun,  5 Apr 2015 15:58:30 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id D18682182B;
	Sun,  5 Apr 2015 15:58:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP49446C5C4D772905567D4B4FF0@phx.gbl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266808>

On Sun, Apr 05, 2015 at 04:19:50PM +0200, Lionel CHAZALLON wrote:
> > Le 5 avr. 2015 =E0 14:17, John Keeping <john@keeping.me.uk> a =E9cr=
it :
> >=20
> > On Sun, Apr 05, 2015 at 11:31:54AM +0000, LongChair . wrote:
> >> I have been looking into ignoring a subdirectory of my tree for
> >> diffing with upstream.  I'll explain the situation below :
> >>=20
> >> My tree is a fork of an upstream repo.  There is a specific direct=
ory
> >> in my tree lets call it foo/bar that i would like to ignore for di=
ff.
> >> This directory includes only files that i added to my repo and is
> >> therefore irrelevant for diffing (i know all files in there have b=
een
> >> added and are not in upstream). Having there in the diff is just
> >> making a lot of files to appear and that is confusing to see what =
is
> >> changed from upstream.
> >>=20
> >> I have read the docs and found a way mentioning that i should add =
a
> >> line to .gitattributes with : foo/bar/* -diff
> >>=20
> >> But this still lists the files in there when i'm diffing.
> >>=20
> >> Is there any way to achieve this ? i cant find any clear explanati=
on
> >> in the docs.
> >=20
> > Since git-diff takes a pathspec you can use the exclude magic to ex=
clude
> > certain directories like this:
> >=20
> > 	git diff upstream -- ':(top)' ':(exclude)foo/bar'
> >=20
> > or equivalently:
> >=20
> > 	git diff upstream -- :/ ':!foo/bar'
> >=20
> > The documentation for the pathspec syntax is in git-glossary(7).
>=20
> Thanks for the answer. I am also using some GUI client (smartgit). Is
> there any way to make this part of the repo attributes / configuratio=
n
> so that my git GUI would use it ?=20

I think you'll have to file a feature request with SmartGit if you want
support for this in their UI.

The standard way to set this up would be to create an alias that does
what you want, such as:

	git config alias.d 'diff -- :/ ":!foo/bar"'

and use "git d" instead of "git diff", but there is no way for other
programs to inherit that.
