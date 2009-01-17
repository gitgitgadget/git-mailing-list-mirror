From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git svn clone -s was not prefixing 'branches/'
Date: Sat, 17 Jan 2009 13:07:23 +0100
Message-ID: <20090117120723.GA24549@atjola.homenet>
References: <1232050647-2870-1-git-send-email-snowblink@gmail.com> <20090117105427.GA15801@dcvr.yhbt.net> <751e526a0901170339m6471ac84tdb032a090d19d7c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jon Lim <snowblink@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 13:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO9yw-0001fn-1T
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 13:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZAQMHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 07:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbZAQMHa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 07:07:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:43934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751389AbZAQMH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 07:07:29 -0500
Received: (qmail invoked by alias); 17 Jan 2009 12:07:26 -0000
Received: from i577B88DA.versanet.de (EHLO atjola.local) [87.123.136.218]
  by mail.gmx.net (mp046) with SMTP; 17 Jan 2009 13:07:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/UGScXdYDUxe7J+/hfPmDo06nLrFCiwC0nFujrOT
	N6ik4KcbW21VYd
Content-Disposition: inline
In-Reply-To: <751e526a0901170339m6471ac84tdb032a090d19d7c6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106043>

On 2009.01.17 11:39:28 +0000, Jon Lim wrote:
> Hi,
>=20
> Maybe this patch doesn't fix the problem I was having. I will attempt
> to describe it better here.
>=20
> I understand that a standard subversion setup is as follows:
> trunk
> branches
> tags
>=20
> With the -s option, svn clone should expect this.
>=20
> Using the example subversion repository:
> trunk
> branches/RB_1.0
> branches/RB_2.0
> tags/REL_1.0
> tags/REL_2.0
>=20
> Currently, using the -s option you get:
> trunk
> RB_1.0
> RB_2.0
> tags/REL_1.0
> tags/REL_2.0
>=20
> I think it makes sense to have:
> trunk
> branches/RB_1.0
> branches/RB_2.0
> tags/REL_1.0
> tags/REL_2.0

Why? "trunk" is just a branch like any other branch, too. It's basicall=
y
just a svn convention that it's not in branches/ but in its own
"toplevel" directory. Once imported into git, it's just an ordinary
remote tracking branch. It's already pretty well distiguishable from al=
l
the other branches due to its name.

What _does_ make sense is to have a common prefix for all the stuff you
got from svn, using for example --prefix=3Dsvn/. That way you get:
svn/trunk
svn/RB_1.0
svn/RB_2.0
svn/tags/REL_1.0
svn/tags/REL_2.0

The important part is that those names aren't ambiguous if you have
local branch heads called, for example:
trunk
RB_1.0
RB_2.0

as the svn/ prefix is part of the shortname for the remote tracking
branches. So "trunk" is the branch head and "svn/trunk" is the remote
tracking branch.

Btw Eric, is there any reason why there's no prefix used by default?
Using the name for the svn-remote as the prefix would make a lot of
sense to me.

Bj=F6rn
