From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to prefix existing svn remotes?
Date: Fri, 23 Jan 2009 12:13:18 +0100
Message-ID: <4979A64E.6030608@drmicha.warpmail.net>
References: <20090122173211.GB21798@locahost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbiBNYXp5?= <melyadon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQKC3-0007nA-SO
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 12:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbZAWLZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 06:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZAWLZ6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 06:25:58 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54176 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754766AbZAWLZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2009 06:25:58 -0500
X-Greylist: delayed 757 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2009 06:25:58 EST
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.fastmail.fm (Postfix) with ESMTP id DE2732549FE;
	Fri, 23 Jan 2009 06:13:20 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Jan 2009 06:13:20 -0500
X-Sasl-enc: FKmFpsaEfoFid2+Rcd9baFr+oChgCJo4R9kSb0jKGZXx 1232709200
Received: from [139.174.44.165] (wagner.math.tu-clausthal.de [139.174.44.165])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 559A3CE38;
	Fri, 23 Jan 2009 06:13:20 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090122173211.GB21798@locahost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106873>

S=C3=A9bastien Mazy venit, vidit, dixit 22.01.2009 18:32:
> Hi all,
>=20
>=20
> I created a few months ago a git-svn repository using:
> git svn clone -s https://my_svn_repo .
>=20
> wich also created the following remotes:
> git branch -r
>   branch0
>   tags/tag0
>   trunk
>=20
> I would like to prefix theses remotes, so that it shows:
> git branch -r
>   prefix/branch0
>   prefix/tags/tag0
>   prefix/trunk
>=20
> Of course I should have used the -prefix back when creating the repo =
but
> it's too late. 'git help svn' doesn't explain how to achieve that and
> simply editing .git/config to add the missing prefix will cause the n=
ext
> 'git svn fetch' to download again the whole history (which in my case=
 is
> huge).
>=20
>=20
> Is it possible? Did I miss something obvious?

Yes! Depends!

The following works for me:

0) fetch to make sure you're current (optional)
1) edit .git/config and add the prefix (right hand side of the
refpsecs), or really rename in any way you want
2) rename the existing remote branches in the same way

The next git svn fetch will rebuild the map file (which is fast) but no=
t
refetch any svn revisions you already have.

Regarding the renaming: Either I'm dumb or current git branch can't
rename git svn branches. I guess it's because they are remotes but not
really. I had to resort to git update-ref. I'll look into that.

Michael
