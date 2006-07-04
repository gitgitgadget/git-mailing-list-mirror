From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: git-cvsimport gets parents wrong for branches
Date: Tue, 4 Jul 2006 13:03:14 +0200
Message-ID: <20060704110313.GC24572@memak.tu-darmstadt.de>
References: <20060703215303.GA24572@memak.tu-darmstadt.de> <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com> <Pine.LNX.4.63.0607041007391.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:03:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxiga-0000mF-2Z
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWGDLDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGDLDR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:03:17 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de ([130.83.48.97]:8655
	"EHLO baerbel.mug.maschinenbau.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S1751272AbWGDLDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 07:03:16 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de (localhost [127.0.0.1])
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4) with ESMTP id k64B3EOb011262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jul 2006 13:03:14 +0200
Received: (from tacke@localhost)
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4/Submit) id k64B3E95011260;
	Tue, 4 Jul 2006 13:03:14 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Elrond <elrond+kernel.org@samba-tng.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607041007391.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: ClamAV 0.88.2/1582/Mon Jul  3 23:23:18 2006 on baerbel.mug.maschinenbau.tu-darmstadt.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23281>

On Tue, Jul 04, 2006 at 10:09:18AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 4 Jul 2006, Martin Langhoff wrote:
> 
> > It is pretty hard to get that one right in any case, as there are
> > cases where the new branch starts from something that is not a commit
> > in the parent (from GIT's perspective).
> 
> But it should be easy to introduce a faked commit, which just contains 
> those versions (and takes the newest commit touching any of these file 
> versions as branch point).

Of couye in theory, (if cvs was used sanely), the base of
each branch should be a commit on the parent-branch. But as
we all know, cvs allows pathologic cases.
(My script doesn't create such a case, it's sanely
representable in git without any fake commits.)


So now for the patholigic cases (when they're solved, the
main issue is solved too):

Of course, the base version for a branch can be turned into
a tree (should be easy: cvsps's first changeset of the
branch has the previous revisions of each file).
This tree can also be turned into a fake commit...
just which parent should our new fake commit have?

My current simple answer is: The commit on the parent
branch with the most matching number of files, so that
the diff, that the fake commit introduces has the least
number of files.

In the non-patholoc case, the fake commit would introduce
no diff at all and should be dropped.

Of couse I have no idea, how hard it would be to implement
this. And in reality, it would be cvsps's job to do that.


    Elrond
