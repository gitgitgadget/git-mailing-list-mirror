From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 15:42:05 -0700
Message-ID: <7vzmfpf0w2.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 00:42:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxtav-0002gb-5N
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGDWmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWGDWmI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:42:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16371 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932330AbWGDWmG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 18:42:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704224206.XMAF27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 18:42:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 5 Jul 2006 00:25:04 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23324>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If that should be not true, you always could rely on topo order. Which 
> does not seem to solve the problem for you.

The computation of merge-base is about computing topo order
cheaply, so that is a recursive definition of the problem, not a
solution, I am afraid.  

With the generation counter, we know the clean-up phase needs to
parse and traverse unparsed parents with the same or higher
generation counter than the lowest we have in the result list,
which would limit our clean-up traversal.  In order to look at
the generation number of parent, we would need to parse it, so
we would end up parsing one level more than needed at the edge,
though.
