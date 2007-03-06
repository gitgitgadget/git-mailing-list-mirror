From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 6 Mar 2007 02:40:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060236390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.36569.805689.922989@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
 <17900.39124.763603.695942@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
 <17900.42415.750335.329874@lisa.zopyra.com>
 <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.43487.947400.649777@lisa.zopyra.com>
 <Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87zm6rqlpn.fsf@graviton.dyn.troilus.org>
 <Pine.LNX.4.63.0703060119320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87wt1vqk9z.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOf8-0004nc-TZ
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933800AbXCFBkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933799AbXCFBkQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:40:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41243 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933800AbXCFBkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:40:15 -0500
Received: (qmail invoked by alias); 06 Mar 2007 01:40:14 -0000
X-Provags-ID: V01U2FsdGVkX1+3dPRb9Qa35FNXVM9ENkhCspDLRTjO6qBU0ufM49
	rscLTYlPMlWjuX
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87wt1vqk9z.fsf@graviton.dyn.troilus.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41523>

Hi,

On Mon, 5 Mar 2007, Michael Poole wrote:

> When I change configuration options (including which branch(es) go to 
> which remote(s)), I want to make that change in one $GIT_DIR rather than 
> in one $GIT_DIR for each branch.

This can be solved by symlinking the config to one designated repo (let's 
call it the "master" repo).

> As a lower priority, I would like a fetch on any of the branches to have 
> results that are visible to all my local copies without more network 
> traffic.

I'd just make a small script which I'd run from the "master" repo instead 
of saying "git pull":

-- snip --
git pull || exit
for branch in branch1 branch2 branch3; do
	cd $branch && git pull .. $branch && cd .. || exit
done
-- snap --

This assumes that you have named the side branches "branch1", "branch2" 
and "branch3", and that they are checked out in the subdirectories of the 
same name.

Hth,
Dscho
