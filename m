From: Svenn Are Bjerkem <svenn.bjerkem@googlemail.com>
Subject: Re: After git svn clone master is tied to a branch in svn, howto set 
	master to trunk
Date: Wed, 11 Mar 2009 10:54:37 -0700 (PDT)
Message-ID: <137694e3-7e06-49cd-b4d4-a3e2d9fc4560@v15g2000yqn.googlegroups.com>
References: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com> 
	<49B7E7BB.2090803@drmicha.warpmail.net> <f07e780b-621f-4d2d-83dd-363716f9d507@d19g2000yqb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 18:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhSf2-0002zb-RH
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZCKRyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 13:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZCKRyk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 13:54:40 -0400
Received: from yw-out-2122.google.com ([74.125.46.26]:22081 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZCKRyj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 13:54:39 -0400
Received: by yw-out-2122.google.com with SMTP id 1so45599ywp.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 10:54:37 -0700 (PDT)
Received: by 10.101.70.14 with SMTP id x14mr992423ank.6.1236794077554; Wed, 11 
	Mar 2009 10:54:37 -0700 (PDT)
In-Reply-To: <f07e780b-621f-4d2d-83dd-363716f9d507@d19g2000yqb.googlegroups.com>
X-IP: 62.92.119.36
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) 
	Gecko/2008092814 Iceweasel/3.0.3 (Debian-3.0.3-3),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112962>

On Mar 11, 6:20=A0pm, Svenn Are Bjerkem <svenn.bjer...@googlemail.com>
wrote:
> On Mar 11, 5:32=A0pm, Michael J Gruber <g...@drmicha.warpmail.net>
> wrote:
>
>
>
> > Svenn Are Bjerkem venit, vidit, dixit 11.03.2009 16:17:
>
> > > Hi,
> > > after performing a
> > > $> git svn clonehttps://svnserver/svn/a/b/c-Ttrunk/current -t tag=
s -
> > > b branches
> > > I find that the git master has been tied to one of the branches. =
It
> > > turns out that the highest svn revision number in the repository =
was
> > > tied to that branch.
>
> > > For historical reasons we have subdirectories in trunk/ on svn, b=
ut I
> > > inspected .git/config
> > > [svn-remote "svn"]
> > > =A0 =A0 =A0 =A0 url =3Dhttps://svnserver/svn
> > > =A0 =A0 =A0 =A0 fetch =3D a/b/c/trunk/current:refs/remotes/trunk
> > > =A0 =A0 =A0 =A0 branches =3D a/b/c/branches/*:refs/remotes/*
> > > =A0 =A0 =A0 =A0 tags =3D a/b/c/tags/*:refs/remotes/tags/*
> > > And I assume it picked up the strange trunk correctly.
>
> > > I have been googling around for a while looking for instructions =
how
> > > to tell git that when I check out "master" it should be "trunk" f=
rom
> > > svn and not "branches/next_gen", or more precisely how to move ma=
ster
> > > to trunk from branches/next_gen.
>
> > > I guess I could solve the problem by modifying a file in trunk on=
 svn
> > > and commit so that the trunk will get the highest svn revision nu=
mber
> > > again and redo the clone.
>
> > I'm not quite sure what you mean by master being "tied" to an svn
> > branch. You mean you want master to track the svn trunk? Then
>
> When doing a git svn info in master right after the clone was
> finished, before any work was done, URL washttps://...../branches/nex=
t_gen.
> When deleting the git repository, modifying and commiting a file in
> trunk on svn and rerun the exact same clone operation, URL in git svn
> info becamehttps://....../trunk/current. During the first clone,
> branches/next_gen had the highest overall svn revision number and got
> automatically "tied" to master, while in the second clone run trunk
> had the highest overall svn revision number and git chose that master
> should track svn trunk.
>
>
>
> > git branch -D master
> > git checkout --track -b master trunk
>
> > should do (assuming you haven't worked on master yet).
>
> I will take a note of this advice and perform a commit to force a
> different branch than next_gen to have overall highest svn revision
> number when I do a clone next time. Reading up in the manuals on your
> suggestion seems to be what I intended to acheive.

I now had the opportunity to check your suggestion, and this time I
first performed a commit in branches/old_gen so branches/old_gen got
the overall highest svn revision number. When performing exactly the
same git svn clone as before, master was set to track branches/
old_gen. Now I tried your suggestion, and except for the fact that I
cannot delete master as long as I am in master, it works as expected.
I had to do a git checkout -b next_gen next_gen to get into next_gen
branch to be allowed to git branch -D master, but that was not a
really big surprise. Then checkout --track does the job nicely.

Good to know, thanks for your help,
Svenn
