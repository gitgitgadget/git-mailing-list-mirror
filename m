From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn clone duplicates content
Date: Thu, 13 Mar 2008 12:30:13 +0100
Message-ID: <20080313113013.GA31522@atjola.homenet>
References: <20080313095215.GA22241@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZleC-0003X3-Ay
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYCMLaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 07:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYCMLaR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:30:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751674AbYCMLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:30:15 -0400
Received: (qmail invoked by alias); 13 Mar 2008 11:30:14 -0000
Received: from i577ACFB7.versanet.de (EHLO atjola.local) [87.122.207.183]
  by mail.gmx.net (mp041) with SMTP; 13 Mar 2008 12:30:14 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+e5V9oXRGezbbDimzHAEQYccnBhOCqzmmyhLu4lN
	Uf2d7Rglo1A5Uj
Content-Disposition: inline
In-Reply-To: <20080313095215.GA22241@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77061>

On 2008.03.13 10:52:15 +0100, martin f krafft wrote:
> Hi list,
>=20
> if I
>=20
>   git-svn clone --stdlayout svn://svn.debian.org/svn/python-modules/p=
ackages/python-docutils
>=20
> then I get
>=20
>   drwx------ 3 madduck madduck 4096 2008-03-13 10:11 debian/
>   drwx------ 3 madduck madduck 4096 2008-03-13 10:11 trunk/
>   drwx------ 3 madduck madduck 4096 2008-03-13 10:11 trunk/debian/
>=20
> and the diff between the two debian directories is equivalent to the
> last commit to the trunk. If I create a new branch off the remote
> 'trunk' branch, then the trunk/ directory will be gone, as it
> should.
>=20
> I am a bit wary to dcommit off anything else than master though for
> I've already killed SVN repos with git-svn in the past. I'd rather
> not to that to Debian's python-modules repo, or else would have to
> spend the rest of my life hidden on some island.
>=20
> It seems that master is branched off a tag in this case.
> Does anyone have an idea what's going on?
> Is this something weird in the svn or with git-svn?

The "fetch" part of git-svn will create a master branch if it doesn't
exist(*) and makes it point to whatever branch was last fetched. In you=
r
case, it seems that the last change on the svn side was to create tag
0.4-5, so master pointed to that one.

As things are, a "git reset --hard remotes/trunk" (or wherever you want
your master to descend from) is pretty mandatory after git svn clone.
The example in the man page "kind of" mentions that. ;-)

Bj=F6rn

(*) Which can be a bit "surprising", because even if you don't want a
    master branch and deleted the original one, the next fetch will
    create a new one.
