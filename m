From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recent unresolved issues: shallow clone
Date: Sat, 15 Apr 2006 02:17:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604150211490.28913@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <87irpb7oma.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 02:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYTh-0001fl-Td
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWDOAR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWDOAR1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:17:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28647 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751442AbWDOAR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 20:17:26 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 08ABACF1;
	Sat, 15 Apr 2006 02:17:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id F06A2CBD;
	Sat, 15 Apr 2006 02:17:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CC971CAA;
	Sat, 15 Apr 2006 02:17:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87irpb7oma.wl%cworth@cworth.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18711>

Hi,

On Fri, 14 Apr 2006, Carl Worth wrote:

> I also read over some of your discussion of extending the protocol
> with a new "shallow" extension.
> 
> I'm wondering if the shallow clone support couldn't be achieved
> through a simpler tweak to the protocol semantics, (and no change to
> protocol syntax), that would avoid the problem above. Specifically,
> for shallow stuff, could we just do the same "want" and "have"
> conversation with tree objects rather than commit objects?

It would not help your problem at all. "have commit" really means that you 
have the commit and all its ancestors and their combined tree objects and 
the combined tree objects' blob objects.

If you have a cauterized history, you know that you are lacking some of 
them. But you don't know which ones.

Now, issuing a pull could mean to get an object which was present in an 
old revision, which you unfortunately do not have (because you have a cut 
off history). Boom.

I know, this is probably unlikely, but not at all *impossible*, so you 
have to take care of that case. And you need a protocol extension for 
that.

Hth,
Dscho
