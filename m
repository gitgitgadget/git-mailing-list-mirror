From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack
 extension
Date: Tue, 25 Oct 2005 23:26:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510252323110.18248@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051025204754.GA8030@steel.home> <7vvezlcnpi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 23:29:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWJr-0006qY-CC
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVJYV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJYV0w
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:26:52 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16521 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932390AbVJYV0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 17:26:51 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4A19B13F1A2; Tue, 25 Oct 2005 23:26:50 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2C44F9ABA2; Tue, 25 Oct 2005 23:26:50 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0B1A79AB61; Tue, 25 Oct 2005 23:26:50 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D298C13F1A2; Tue, 25 Oct 2005 23:26:49 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvezlcnpi.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10619>

Hi,

On Tue, 25 Oct 2005, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Johannes Schindelin, Sun, Oct 23, 2005 03:40:13 +0200:
> >> This patch concludes the series, which makes 
> >> git-fetch-pack/git-upload-pack negotiate a potentially better set of 
> >> common revs. It should make a difference when fetching from a repository 
> >> with a few branches.
> >
> > This broke git-pull for me (the local one):
> 
> Is this the same problem I fixed with this commit, which sits at
> the tip on the "master" branch?
> 
> commit 7efc8e43508b415e2540dbcb79521bde16c51e0c
> tree 6234aa4f7095054a137e030030f914dc6633f809
> parent 40a10462498bdd23d4e49f02867b8be50eb78704
> author Junio C Hamano <junkio@cox.net> 1130061738 -0700
> committer Junio C Hamano <junkio@cox.net> 1130192018 -0700
> 
>     upload-pack: fix thinko in common-commit finder code.
> 
>     The code to check if we have the object the other side has was bogus
>     (my fault).
> 
>     Signed-off-by: Junio C Hamano <junkio@cox.net>

It looks to me like it is not. This looks more like upload-pack speaks 
multi_ack, but fetch-pack does not, since it gets the "got ack .. 
continue" too late.

I'll send out a patch implementing a first version of my "nasty" 
fetch-pack tests in a few minutes. This test showed me my error.

Ciao,
Dscho
