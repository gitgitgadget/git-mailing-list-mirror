From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Re: Darcs-git pulling from the Linux repo: a Linux VM question
Date: Fri, 29 Apr 2005 07:25:47 -0400
Message-ID: <20050429112541.GA15698@abridgegame.org>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr> <Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org> <7iu0lskyfb.fsf@lanthane.pps.jussieu.fr> <Pine.LNX.4.58.0504270910510.18901@ppc970.osdl.org> <20050428113947.GC9422@abridgegame.org> <7ir7guj4m6.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Fri Apr 29 13:25:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRTcb-0006Ll-JE
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 13:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVD2La4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 07:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVD2La4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 07:30:56 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:30511 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262286AbVD2Lav (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 07:30:51 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DRTcx-00045R-Av; Fri, 29 Apr 2005 07:25:47 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <7ir7guj4m6.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2005 at 05:36:01PM +0200, Juliusz Chroboczek wrote:
> > When we're desperate, we'll special-case the initial commit, but
> > currently I'm sure we can pretty easily adjust things by making the
> > git-tree-reading lazy,
> 
> Just to make it clear: reading the git tree is lazy.  The problem is
> somewhere in the higher layers, probably in pull_cmd.

I guess really that's the issue.  Get itself is a special case that we've
already optimized for the initial get.  You'll also run into trouble using
pull to grab an entire plain old darcs repository with a large initial
commit.  We can (and should) also optimize pull, but it's not going to ever
be as efficient as a get is, for the case where you start with an empty
repository.

> There's also another problem: reading the git tree takes 220MB.  Then
> Darcs allocates a further 500MB without calling my code at all.  (Some
> of it is doubtless due to linesPS, that should be more than a handful
> of megabytes.)

The output of linesPS actually does take a huge amount of space.
-- 
David Roundy
http://www.darcs.net
