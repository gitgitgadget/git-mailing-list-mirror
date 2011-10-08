From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sat, 8 Oct 2011 23:37:41 +0200
Message-ID: <20111008213741.GA24409@goldbirke>
References: <1318107488.5865.46.camel@R0b0ty>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daly Gutierrez <daly.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 23:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCeaZ-0005zg-C1
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 23:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab1JHVhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 17:37:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:63380 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1JHVhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 17:37:40 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Mh8jt-1RQ4sF3vxx-00MsGW; Sat, 08 Oct 2011 23:37:39 +0200
Content-Disposition: inline
In-Reply-To: <1318107488.5865.46.camel@R0b0ty>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:+oGflpKHfBp1GbzrHTXoD1iDtL1JIPhMDFjyJGbJE1v
 aj2otia5ox7Kb3KvFvpw1zWhR2C/Dx1zzMyH0t/l+nlxOoXsMX
 CR7SBgLJ0ipiI7mI3KNXW7ScC8VDSOMpmDO0h4cSgT8qfFDRmL
 nqIdlkVhQA7NpS5P1H9QZpe/lgOIR0nWb8GgzB1JNtnDZAaqAd
 3ouTBygyHRnyXwj5GyPWsegu564Mj4ABdsPmfTnZGJULN8Pj4D
 T+DDMGamjqs1IOIGz6ZIu01oQ5bYz2P1owR7crfoQG7OHg1K9M
 AK/VSsIrynv5nuypi/9yKdVsxphpzMhT654j2ntX8zkQkIiRMX
 OGePMYFpEgUIi5pufkco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183176>

Hi,

On Sat, Oct 08, 2011 at 04:58:07PM -0400, Daly Gutierrez wrote:
> Is this possible after changing from the Detached Head branch to an
> existing branch?  How about if I don't remember the commit SHA1 ID?
>=20
> What I did, to the best of my knowledge:
> 1) Checked out a previous version:
> > git checkout 3a5bb38a83c00f7acab573f0ec836577143200aa
>=20
> 2) Modified file and committed the changes in the detached branch.
> > git log
>  commit 92aa5381b9f7229523dba42aa94735c30f173451
>  Author: Daly Gutierrez <Daly.Gutierrez@gmail.com>
>  Date:   Sat Oct 8 16:20:11 2011 -0400
>=20
>     Committing this in the Detached Head
>=20
> 3) For curiosity,
> > git branch
> * (no branch)
>   New_Branch
>   Second_New_Branch
>   master
>=20
> 4) Changed to 'New_Branch' branch...  I no longer see the detached
> branch...
>  > git branch
> * New_Branch
>   Second_New_Branch
>   master
>=20
> 5) Want to access the file with the changes I made in the Detached
> branch, but don't know how...  PLEASE HELP?

git reflog to the rescue.  For your example above it will output
something like this:

  deadbeef HEAD@{0}: checkout: moving from 92aa5381b9f7229523dba42aa947=
35c30f173451 to New_Branch
  92aa5381 HEAD@{1}: commit: Committing this in the Detached Head
  3a5bb38a HEAD@{2}: checkout: moving from master to 3a5bb38a83c00f7aca=
b573f0ec836577143200aa
  deafbabe HEAD@{3}: ...
  ...

There you see the first line of the commit message from your "lost"
commit, and you can do

  git checkout -b lost_detached_head 92aa5381

and you get a branch pointing to that commit you made while on
detached head, and you can work with it as usual.


Best,
G=E1bor
