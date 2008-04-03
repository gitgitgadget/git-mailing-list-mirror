From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone.txt: Adjust note to --shared for new pruning
 behavior of git-gc
Date: Thu, 3 Apr 2008 22:01:48 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804032200310.4008@racer.site>
References: <47F52145.306@nrlssc.navy.mil> <alpine.LSU.1.00.0804032113280.4008@racer.site> <47F54342.1040901@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWZh-0002tL-LR
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbYDCVBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbYDCVBj
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:01:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:52409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755258AbYDCVBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 17:01:38 -0400
Received: (qmail invoked by alias); 03 Apr 2008 21:01:36 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp008) with SMTP; 03 Apr 2008 23:01:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LBaNMT62LrUzR+tcHB/CtWHNS+GItRUI0ql0PWZ
	K3we4a0KpCHHAQ
X-X-Sender: gene099@racer.site
In-Reply-To: <47F54342.1040901@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78778>

Hi,

On Thu, 3 Apr 2008, Brandon Casey wrote:

> Johannes Schindelin wrote:
> 
> > On Thu, 3 Apr 2008, Brandon Casey wrote:
> > 
> >> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> >> index 9758243..d3ab00b 100644
> >> --- a/Documentation/git-clone.txt
> >> +++ b/Documentation/git-clone.txt
> >> @@ -65,10 +65,12 @@ OPTIONS
> >>  +
> >>  *NOTE*: this is a possibly dangerous operation; do *not* use
> >>  it unless you understand what it does. If you clone your
> >> -repository using this option, then delete branches in the
> >> -source repository and then run linkgit:git-gc[1] using the
> >> -'--prune' option in the source repository, it may remove
> >> -objects which are referenced by the cloned repository.
> >> +repository using this option and then delete branches in the
> >> +source repository, some objects may become unreferenced (or dangling).
> >> +These objects may be removed by normal git operations (such as git-commit[1])
> >> +which automatically call git-gc[1]. If these objects are removed and
> >> +were referenced by the cloned repository, then the cloned repository
> >> +will become corrupt.
> > 
> > Please note that if you delete a branch _after_ running git-gc, the next 
> > git-gc would remove those objects anyway, since the first git-gc packed 
> > the objects, and they were therefore no longer dangling.
> 
> I thought they would be retained unless --prune was used. git-gc uses the
> -A option to repack when --prune is not used and -a when --prune is used.

Oh, you're right.  I forgot.

> But what I was really trying to point out in the documentation changes 
> was that now _other_ commands such as git-commit are also unsafe since 
> they call 'git-gc --auto' and could cause loose unreferenced objects to 
> be deleted. So it is not enough to just avoid calling git-gc when 
> dealing with a --shared repository.

Right.  Hmm.  I missed that completely when I thought about prune 
--expire.

Sorry,
Dscho
