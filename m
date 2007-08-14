From: Leandro Lucarella <llucax@gmail.com>
Subject: Re: [PATCH] Allow git-svnimport to take "" as the trunk directory.
Date: Tue, 14 Aug 2007 09:36:04 -0300
Message-ID: <20070814123604.GA10472@homero.springfield.home>
References: <11870641981207-git-send-email-albertito@gmail.com> <85vebi3bzv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 15:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKwPV-000754-9R
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 15:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbXHNNZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757608AbXHNNZd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 09:25:33 -0400
Received: from host102.190-136-120.telecom.net.ar ([190.136.120.102]:45255
	"EHLO burns.springfield.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756923AbXHNNZc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 09:25:32 -0400
X-Greylist: delayed 3063 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2007 09:25:31 EDT
Received: from homero.springfield.home ([10.10.10.2] helo=llucax.com.ar)
	by burns with smtp (Exim 4.67)
	(envelope-from <llucax@gmail.com>)
	id 1IKvby-0006Th-1g; Tue, 14 Aug 2007 09:35:02 -0300
Received: (nullmailer pid 10621 invoked by uid 1000);
	Tue, 14 Aug 2007 12:36:04 -0000
Content-Disposition: inline
In-Reply-To: <85vebi3bzv.fsf@lola.goethe.zz>
X-Paranoid: Just because you're paranoid, don't mean they're not after you.
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55831>

David Kastrup, el 14 de agosto a las 07:45 me escribiste:
> Alberto Bertogli <albertito@gmail.com> writes:
>=20
> > Some repositories started with the trunk in "/" and then moved it t=
o the
> > standard "trunk/" location.
> >
> > On these repositories, the correct thing would be to call
> > git-svnimport -T "",
>=20
> I would not call that the best solution: it makes the bad decision
> from the past impact useful work in the future.  I very much like git
> having a good toplevel directory structure.

Besides the example of a mutating trunk directory, I have repositories
where there is only trunk (in "/" directory) and it never changes. With=
out
this patch, I can't even import that kind of repositories.

With repositories with a mutating trunk directory, I used the options -=
s
and -l to incrementally import the repository. For example:
$ git svnimport -l 100 -T '' <repo>
and then
$ git svnimport -s 101 -T 'trunk' <repo>

> There are two approaches possible: one is to version the mapping
> trunk/tags/branches.  Another would be if one could tell git-svn wher=
e
> to stick stuff that does not sort into trunk/tags/branches.
> Incidentally, I've seen repositories that have something like a
> "support" or "vendor" directory, too.

The patch is for git-svnimport, not git-svn (but maybe git-svn has
the same problem). Anyways, a way to map trunk/tags/branches to differe=
nt
directories in different versions would be great, but is a different
problem than -T not supporting an empty string.

--=20
Leandro Lucarella (luca) | Blog colectivo: http://www.mazziblog.com.ar/=
blog/
 .---------------------------------------------------------------------=
---,
  \  GPG: 5F5A8D05 // F8CD F9A7 BF00 5431 4145  104C 949E BFB6 5F5A 8D0=
5 /
   '-------------------------------------------------------------------=
-'
Como un rinoceronte que lleva un p=C3=A1jaro en el lomo,
yo te alimento, no te veo ni te toco.
