From: =?iso-8859-1?Q?=22Martin_Kr=FCger=22?= <martin.krueger@gmx.com>
Subject: Re: Merge two different repositories (v2.4 + v2.5) into the one (v2.4
 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 12:49:43 +0100
Message-ID: <20110111114943.40890@gmx.net>
References: <746745466.20110111134101@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?iso-8859-1?B?ItCQ0LvQtdC60YHQtdC5INCo0YPQvNC60LjQvSI=?= 
	<zapped@mail.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 12:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PccjX-0006Y8-T0
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 12:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab1AKLtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 06:49:47 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:48984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752142Ab1AKLtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 06:49:46 -0500
Received: (qmail 16843 invoked by uid 0); 11 Jan 2011 11:49:44 -0000
Received: from 213.39.246.106 by www049.gmx.net with HTTP;
 Tue, 11 Jan 2011 12:49:42 +0100 (CET)
In-Reply-To: <746745466.20110111134101@mail.ru>
X-Authenticated: #34047341
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1+f+IRgLUaf2B+arChlofxmF0tWutRODZn3Xy/YNW
 +3T4Wi82mzsJ4UK33Mhbv4sMZo6YAMPkh6eA== 
X-GMX-UID: gAdmCrFoa2AoVwmzMHYy2gc6OWhhakf9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164929>

> 
> Now I'd like to merge them as v2.5 was a continuos branch from v2.4,
> but without a rebasing (i.e. without a global changing of v2.5
> repository, which already has another branches)
> It must look like LAST commit of v2.4 should be a PARENT of FIRST commit
> of v2.5
> 
> Now there's a question: Is it possible to do so (no rebasing!), and If
> "yes" then how to?
> 
>
It's possible with a little arts an crafts. 
You have 2 friends:  git format-patch & git am .
With "git format-patch" you  will see what a branch really is:
a serie of patches.  With "git am"  you can apply these patches to a branch created on the correct point of the commit-history . E voila the branch is recreated in the repository.

In your case:

On the 2.5 repository master branch:
git format-patch  INITIAL_COMMITID

On the 2.4 repository master branch:
git branch 2.5
git checkout 2.4
git reset --hard  INITIAL_COMMITID 
cat *.patch | git am

E voila you habe both branches in a single repository.

Nearly  same procedure for every  branch of the  2.5 repository
git checkout branchname 
git format-patch master

In the 2.4(Contains now both branches.) respository:
git checkout 2.5
git branch branchname
git reset --hard CORRECT_BRANCHBASE
cat *.patch | git am

Best regards 
   martin



 
