From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Git (svn) merge - but ignore certain commits?
Date: Thu, 08 Jan 2009 18:49:22 +0100
Message-ID: <49663CA2.90102@sneakemail.com>
References: <49562749.9060705@sneakemail.com> <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Peter Harris git-at-peter.is-a-geek.org |Lists|" 
	<xtslkck8t30t@sneakemail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 18:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKz1u-0004Iq-IN
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 18:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbZAHRt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZAHRt0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 12:49:26 -0500
Received: from smtp20.orange.fr ([193.252.22.31]:23201 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZAHRtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 12:49:25 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2024.orange.fr (SMTP Server) with ESMTP id 732141C000B3;
	Thu,  8 Jan 2009 18:49:23 +0100 (CET)
Received: from [192.168.1.39] (ANice-157-1-29-28.w90-28.abo.wanadoo.fr [90.28.172.28])
	by mwinf2024.orange.fr (SMTP Server) with ESMTP id 274C31C000B9;
	Thu,  8 Jan 2009 18:49:23 +0100 (CET)
X-ME-UUID: 20090108174923161.274C31C000B9@mwinf2024.orange.fr
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104946>

=46irst, a well-overdue thanks to Peter for your post.

Peter Harris git-at-peter.is-a-geek.org |Lists| wrote:
> If your branch is so ugly that you want to toss many of the commits
> anyway, maybe "git merge --squash" is what you are looking for? Or
> maybe you want to "git rebase -i" before merging?

It isn't. The whole reason for the branch was that there were 4=20
"beta-level" commits on trunk/master along with a whole bunch of good=20
stuff. And we wanted to add a little more good stuff, exclude the beta=20
stuff and create a release.

>> How do I do this "properly"?
>=20
> Use many short-lived feature branches, not few long-lived generic
> "development" branches. Merge-and-delete is easier than herding
> reverts.

I don't understand this, I'm affraid. Our "newbranch" was very short=20
lived. 4 reverts and 5 commits.

What I ended up doing was to create two git branches off of svn=20
"newbranch": One with all the fixes but without the reverts, and one=20
with just the reverts. Do all the development on the one with the fixes=
,=20
and then "git merge" them to both master and "gitnewbranch", then one=20
with the reverts. And then git svn dcommit them both.

However *the* problem was with repeated merges: I later discovered a=20
problem on the branch and need to add a commit for it to both master an=
d=20
newbranch/gitnewbranch. Aside from git cherry-pick (where I take care o=
f=20
the repeated merge problem) I still haven't found a good solution.

I ended up using git cherry-pick, and diff and patch / git diff and git=
=20
apply. Sub-optimal. :-( But small commits! :-)

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
