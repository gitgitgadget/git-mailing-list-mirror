From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: merging bare repository
Date: Mon, 6 Jun 2011 23:54:33 +0200
Message-ID: <20110606215433.GC29348@jpl.local>
References: <533718318.20110513145132@gmail.com>
 <20110513135348.GB10857@jpl.local>
 <1306807292356-6421097.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilya Basin <basinilya@gmail.com>
To: garyc618 <gary.carter@eigen.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 23:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QThl0-0004mg-AC
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 23:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab1FFVyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 17:54:38 -0400
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:51228 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758055Ab1FFVyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 17:54:37 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 899F3EA22A
	for <git@vger.kernel.org>; Mon,  6 Jun 2011 23:54:35 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhggALBL7U1T46eEPGdsb2JhbABTiRKOHY5hCwEBAQE3MohxwhWGIQSgNQ
X-IronPort-AV: E=Sophos;i="4.65,328,1304287200"; 
   d="scan'208";a="1737116535"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb4.telenor.se with ESMTP; 06 Jun 2011 23:54:34 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id CE6AF42323; Mon,  6 Jun 2011 23:54:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306807292356-6421097.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175173>

On Tuesday, May 31, 2011 at 04:01 CEST,
     garyc618 <gary.carter@eigen.com> wrote:

> Magnus B=E4ck-2 wrote:

[...]

> > To deal with upstreams like this I recommend you place the upstream
> > branch(es) in a separate namespace prefixed by <upstreamname>/, e.g=
=2E
> > github/master if your upstream is the master branch from the
> > official Github repo of the project. Example:
> >=20
> >    git fetch ssh://git@some.org/git/project.git
> >    git push ssh://git@server/git/project.git FETCH_HEAD:github/mast=
er
> >=20
> > If you mirror the upstream branches like this on your server merges
> > from upstream becomes trivial[*],
> >=20
> >    git merge origin/github/master
> >    git push ssh://git@server/git/project.git HEAD:master
> >=20
> > and can be done on any workstation plus it's easy for your users to
> > e.g. see what they've been up to compared to the upstream:
> >=20
> >    git log origin/github/master..origin/master
> > [...]
> >=20
>=20
> Could you explain more about how this works - where do I find the
> character string to use instead of "github".  It can't be arbitrary,
> I got an error message.

Can you be more specific about the error message? The string *is*
arbitrary. The only thing I can think of is that you need to specify
refs/heads/github/master rather than just github/master in the push
operation.

> When I did the fetch it said
> *branch HEAD -> FETCH_HEAD
> could you explain what this means in more detail?

Someone might need to correct my here, but I guess it means that the
local symbolic ref FETCH_HEAD has been updated with the contents of
the server-side symbolic ref HEAD. The important part to remember
here is that FETCH_HEAD is a useful shorthand that represent what you
got in the last fetch operation.

Come to think of it, the first example commands that you're commenting
might not necessarily do what you want. It's probably a good idea to
specify the ref explicitly instead of FETCH_HEAD, e.g. origin/master,
or just fetch the branch you want. I don't know what FETCH_HEAD contain=
s
when multiple refs are fetched.

> We enthusiasts-who-don't-have-time-to-become-git-masters really need
> some well explained examples if we're going to be able to convince
> management that git is not some super complicated tool that takes
> weeks to learn.

If you're the one who's going to be managing your source code
repositories, any tool for this task will take weeks if not months to
master sufficiently well. Learning how to use a source control system
like Git isn't just about learning the tool itself -- that part is
usually easy. Regardless of the choice of tool, you'll have to learn it=
s
ins and outs and how to apply it to your probably already established
processes, and/or how you should change your processes to adapt to the
tool (you probably need a little bit of both).

Any manager claiming that doing this properly is trivial with any tool
shouldn't be making decisions about this. Really.

> The particular use case described in this thread is the last sticking
> point I have to make work before I can show git doing everything we
> need it to do to my management.

Luckily integrating upstream development with your own is easy with Git
and probably all other distributed version control systems. I think it'=
s
one of their major strengths.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
