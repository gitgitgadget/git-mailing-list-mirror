From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Thu, 2 Feb 2006 19:44:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602021932450.16426@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602020113200.30910@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr76m36ge.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 19:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4jRB-0004o0-9H
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 19:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBBSoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWBBSoF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 13:44:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56276 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751172AbWBBSoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 13:44:04 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 19A61141809; Thu,  2 Feb 2006 19:44:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0BFD61D7A;
	Thu,  2 Feb 2006 19:44:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7B88143F08; Thu,  2 Feb 2006 19:44:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr76m36ge.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15515>

Hi,

On Wed, 1 Feb 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I think it would be trivial: just resolve ~A to the tree A points to:
> 
> <tired> Hmph.  I thought you meant "have-only A" to mean similar
> to "have A" but additionally "do not assume I have things behind
> A", and are going to extend rev-list to support ~A syntax to do
> that.  I am a bit surprised to see your "rev-list ~A" is to
> include A, not exclude A and not what are behind A.  Where is
> the connection between this and "have-only A"?  </tired> ;-)

<tired> My patch was wrong. You'd have to introduce a new flag saying: 
Traverse this commit, but mark its parents as uninteresting. </tired>

> > Now, is it possible that a fetch does something unintended, when there are 
> > grafts which are not cutoffs? I don't know yet, but I think so.
> 
> I think we are disagreeing, so "not Exactly".  I meant "grafts
> are grafts, there is no cutoffs, they are also just grafts".  So
> the answer to your question is "it does not matter".

Scenario: I have cvsimported a project. Using a graft, I told git that a 
certain commit is indeed a merge between two branches. That is, in 
addition to the parent the commit objects tells us about, it has another 
parent which was tip of another branch.

How would this graft be interpreted by the server we want to pull from? As 
if we had cut off the history. Which we did not. In effect, we could be 
sent many, many objects we already have.

Ciao,
Dscho
