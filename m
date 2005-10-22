From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Sat, 22 Oct 2005 02:35:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510220223100.13270@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtk6vlqz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510212134570.5542@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbr1iv9nz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 02:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET7MW-0002Mv-FU
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 02:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVJVAfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 20:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJVAfr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 20:35:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23721 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751273AbVJVAfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 20:35:46 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 432EB13F187; Sat, 22 Oct 2005 02:35:43 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 231F4B4E4E; Sat, 22 Oct 2005 02:35:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0200658EB8; Sat, 22 Oct 2005 02:35:43 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B1A0713F187; Sat, 22 Oct 2005 02:35:42 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr1iv9nz.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10456>

Hi,

On Fri, 21 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Yes. This makes it more simple, and is very efficient in the common case. 
> > How about increasing MAX_HAS to 64?
> 
> The other day I saw HPA tried to sneak in a change to increase
> it to 64, mingled with other changes.  I think increasing it
> makes sense.

Agree.

However, I do not see a way for upload-pack to force fetch-pack to send 
"have" lines. Maybe this would be an important change to the protocol? I 
imagine that I could craft a custom fetch-pack which DoS'es any 
current upload-pack.

> Now the question is, if we count MAX_HAS on the fetch-pack side,
> how would we coordinate that value with the real limit the other
> end uses.  I guess that would not matter too much.  It would not
> affect the correctness anyway.

Really, there should be a way for upload-pack to say that enough is 
enough, and it wants to send the pack now.

Ciao,
Dscho
