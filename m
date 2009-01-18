From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn clone -s was not prefixing 'branches/'
Date: Sat, 17 Jan 2009 17:24:39 -0800
Message-ID: <20090118012439.GA31969@dcvr.yhbt.net>
References: <1232050647-2870-1-git-send-email-snowblink@gmail.com> <20090117105427.GA15801@dcvr.yhbt.net> <751e526a0901170339m6471ac84tdb032a090d19d7c6@mail.gmail.com> <20090117120723.GA24549@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Lim <snowblink@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 02:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMQQ-00071k-Jd
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbZARBYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 20:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbZARBYk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:24:40 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42149 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168AbZARBYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 20:24:40 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D9F1F794;
	Sun, 18 Jan 2009 01:24:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090117120723.GA24549@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106126>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> On 2009.01.17 11:39:28 +0000, Jon Lim wrote:
> > Hi,
> >=20
> > Maybe this patch doesn't fix the problem I was having. I will attem=
pt
> > to describe it better here.
> >=20
> > I understand that a standard subversion setup is as follows:
> > trunk
> > branches
> > tags
> >=20
> > With the -s option, svn clone should expect this.
> >=20
> > Using the example subversion repository:
> > trunk
> > branches/RB_1.0
> > branches/RB_2.0
> > tags/REL_1.0
> > tags/REL_2.0
> >=20
> > Currently, using the -s option you get:
> > trunk
> > RB_1.0
> > RB_2.0
> > tags/REL_1.0
> > tags/REL_2.0
> >=20
> > I think it makes sense to have:
> > trunk
> > branches/RB_1.0
> > branches/RB_2.0
> > tags/REL_1.0
> > tags/REL_2.0
>=20
> Why? "trunk" is just a branch like any other branch, too. It's basica=
lly
> just a svn convention that it's not in branches/ but in its own
> "toplevel" directory. Once imported into git, it's just an ordinary
> remote tracking branch. It's already pretty well distiguishable from =
all
> the other branches due to its name.

Yup, you said it better than I could myself :)

> What _does_ make sense is to have a common prefix for all the stuff y=
ou
> got from svn, using for example --prefix=3Dsvn/. That way you get:
> svn/trunk
> svn/RB_1.0
> svn/RB_2.0
> svn/tags/REL_1.0
> svn/tags/REL_2.0
>=20
> The important part is that those names aren't ambiguous if you have
> local branch heads called, for example:
> trunk
> RB_1.0
> RB_2.0
>=20
> as the svn/ prefix is part of the shortname for the remote tracking
> branches. So "trunk" is the branch head and "svn/trunk" is the remote
> tracking branch.
>=20
> Btw Eric, is there any reason why there's no prefix used by default?
> Using the name for the svn-remote as the prefix would make a lot of
> sense to me.

Backwards compatibility; and that I've been lazy :)

But I do agree that prefixing "svn/" is preferred for tracking new
repos.  I seem to recall that git-svn was actually the first user of th=
e
"remotes/" namespace before it was adopted by the rest of git, and with
SVN, I didn't anticipate more than one remote.

--=20
Eric Wong
