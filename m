From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot
	clone?
Date: Mon, 30 Jun 2008 13:50:26 +0200
Message-ID: <20080630115026.GA1336@atjola.homenet>
References: <200806301149.18115.J.Wielemaker@uva.nl> <m3r6afgrme.fsf@localhost.localdomain> <200806301230.38980.J.Wielemaker@uva.nl> <200806301326.12140.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Wielemaker <J.Wielemaker@uva.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:51:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHup-0007x6-Ka
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbYF3Lub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 07:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbYF3Lua
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:50:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:60812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754806AbYF3Lua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:50:30 -0400
Received: (qmail invoked by alias); 30 Jun 2008 11:50:28 -0000
Received: from i577B8452.versanet.de (EHLO atjola.local) [87.123.132.82]
  by mail.gmx.net (mp058) with SMTP; 30 Jun 2008 13:50:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/O9Ns8M93OtIgBQXTg13+ls+5ElHNKGqaGbuKGdb
	1R2DBNuJg3kQe8
Content-Disposition: inline
In-Reply-To: <200806301326.12140.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86909>

On 2008.06.30 13:26:10 +0200, Jakub Narebski wrote:
> Jan Wielemaker wrote:
> > On Monday 30 June 2008 12:10, Jakub Narebski wrote:
> >> Jan Wielemaker <J.Wielemaker@uva.nl> writes:
> >>>
> >>> I'm a bit puzzled. I have a bare repository, somehow without any =
files
> >>> in refs/heads.
> >>
> >> Do you have .git/packed-refs file?
> >=20
> > Its a bare repo, so I'll forget the .git.  Yes, I have that file an=
d
> > it contains nice references,  I checked a few by hand, and they hav=
e
> > the same SHA1 as the files I copied.
>=20
> That is where the refs are instead of being in individual files under
> refs/ - those are so called "packed refs".
>=20
>   When a ref is  missing from  the traditional $GIT_DIR/refs hierarch=
y,
>   it is looked up in $GIT_DIR/packed-refs and used if found.
>=20
> I'm not sure why branches are also packed, because git used to pack
> only tags and refs which were packed already.
>=20
> >> How do you have gc.packrefs set ("git config --get gc.packrefs")?
> >=20
> > This gives no output, so I guess the answer is 'no'.
>=20
> In git-config(1) you can find the following:
>=20
>   gc.packrefs::
>         `git gc` does not run `git pack-refs` in a bare repository by
>         default so that older dumb-transport clients can still fetch
>         from the repository.  Setting this to `true` lets `git
>         gc` to run `git pack-refs`.  Setting this to `false` tells
>         `git gc` never to run `git pack-refs`. The default setting is
>         `notbare`. Enable it only when you know you do not have to
>         support such clients.  The default setting will change to `tr=
ue`
>         at some stage, and setting this to `false` will continue to
>         prevent `git pack-refs` from being run from `git gc`.
>=20
> Unless something changed (and git Documentation was not updated) git
> should not pack refs by default.

I had a quick glance over the log for builtin-gc.c, and that changed
last year in:

56752391 Make "git gc" pack all refs by default

Bj=F6rn - who lacks time to provide a doc update patch :-(
