From: Svenn Are Bjerkem <svenn.bjerkem@googlemail.com>
Subject: Re: After git svn clone master is tied to a branch in svn, howto set 
	master to trunk
Date: Wed, 11 Mar 2009 10:20:12 -0700 (PDT)
Message-ID: <f07e780b-621f-4d2d-83dd-363716f9d507@d19g2000yqb.googlegroups.com>
References: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com> 
	<49B7E7BB.2090803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 18:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhS7l-00055P-QK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbZCKRUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZCKRUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 13:20:16 -0400
Received: from yw-out-2122.google.com ([74.125.46.24]:5283 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZCKRUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 13:20:15 -0400
Received: by yw-out-2122.google.com with SMTP id 1so39246ywp.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 10:20:12 -0700 (PDT)
Received: by 10.151.41.21 with SMTP id t21mr1338619ybj.11.1236792012390; Wed, 
	11 Mar 2009 10:20:12 -0700 (PDT)
In-Reply-To: <49B7E7BB.2090803@drmicha.warpmail.net>
X-IP: 62.92.119.36
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) 
	Gecko/2008092814 Iceweasel/3.0.3 (Debian-3.0.3-3),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112961>

On Mar 11, 5:32=A0pm, Michael J Gruber <g...@drmicha.warpmail.net>
wrote:
> Svenn Are Bjerkem venit, vidit, dixit 11.03.2009 16:17:
>
>
>
> > Hi,
> > after performing a
> > $> git svn clonehttps://svnserver/svn/a/b/c-T trunk/current -t tags=
 -
> > b branches
> > I find that the git master has been tied to one of the branches. It
> > turns out that the highest svn revision number in the repository wa=
s
> > tied to that branch.
>
> > For historical reasons we have subdirectories in trunk/ on svn, but=
 I
> > inspected .git/config
> > [svn-remote "svn"]
> > =A0 =A0 =A0 =A0 url =3Dhttps://svnserver/svn
> > =A0 =A0 =A0 =A0 fetch =3D a/b/c/trunk/current:refs/remotes/trunk
> > =A0 =A0 =A0 =A0 branches =3D a/b/c/branches/*:refs/remotes/*
> > =A0 =A0 =A0 =A0 tags =3D a/b/c/tags/*:refs/remotes/tags/*
> > And I assume it picked up the strange trunk correctly.
>
> > I have been googling around for a while looking for instructions ho=
w
> > to tell git that when I check out "master" it should be "trunk" fro=
m
> > svn and not "branches/next_gen", or more precisely how to move mast=
er
> > to trunk from branches/next_gen.
>
> > I guess I could solve the problem by modifying a file in trunk on s=
vn
> > and commit so that the trunk will get the highest svn revision numb=
er
> > again and redo the clone.
>
> I'm not quite sure what you mean by master being "tied" to an svn
> branch. You mean you want master to track the svn trunk? Then

When doing a git svn info in master right after the clone was
finished, before any work was done, URL was https://...../branches/next=
_gen.
When deleting the git repository, modifying and commiting a file in
trunk on svn and rerun the exact same clone operation, URL in git svn
info became https://....../trunk/current. During the first clone,
branches/next_gen had the highest overall svn revision number and got
automatically "tied" to master, while in the second clone run trunk
had the highest overall svn revision number and git chose that master
should track svn trunk.

>
> git branch -D master
> git checkout --track -b master trunk
>
> should do (assuming you haven't worked on master yet).

I will take a note of this advice and perform a commit to force a
different branch than next_gen to have overall highest svn revision
number when I do a clone next time. Reading up in the manuals on your
suggestion seems to be what I intended to acheive.

Thanks,
--
Svenn
