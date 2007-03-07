From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 21:57:05 -0800
Message-ID: <7vy7m9iojy.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
	<7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com>
	<7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com>
	<Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EE36A1.30001@gmail.com>
	<Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 06:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOp9R-0007vy-4k
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 06:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXCGF5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 00:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXCGF5K
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 00:57:10 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65511 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbXCGF5J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 00:57:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307055707.KVYS2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 00:57:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xhx61W00E1kojtg0000000; Wed, 07 Mar 2007 00:57:06 -0500
In-Reply-To: <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Mar 2007 05:05:40 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41652>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> git-bundle create test.bdl HEAD --since=1.day.ago  ==>> pack with 1531
>> objects
>
> Did you test with "--since=1.day.ago HEAD", i.e. with the correct order? I 
> know you'd like the options to be interminglable, but "HEAD" really is not 
> an option, but an argument.

That is probably true but I do not think we have ever had date
limiter and --objects interact correctly.  It is understandable
as traditionally packs were to generate needed objects between
revisions, and unlimited but counted (--max-count) or timed
(--max-age) are unexpected uses for "rev-list --objects" (in
other words, nobody had done so and I am not surprised it does
not work as you expect -- rather I would be surprised if anybody
has even expectd the current code to work that way without
modification).

I am a bit too tired tonight so anybody is welcome to beat me to
fix this one, preferrably on top of 'next'.
