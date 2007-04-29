From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 28 Apr 2007 23:28:43 -0700
Message-ID: <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
	<7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704290152410.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2uA-0005Ue-4t
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 08:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXD2G2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 02:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754979AbXD2G2o
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 02:28:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57359 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbXD2G2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 02:28:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429062843.YYSM1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 02:28:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id suUj1W0031kojtg0000000; Sun, 29 Apr 2007 02:28:43 -0400
In-Reply-To: <Pine.LNX.4.64.0704290152410.28708@iabervon.org> (Daniel
	Barkalow's message of "Sun, 29 Apr 2007 02:01:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45816>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We're not pretending anything; remote has confirmed that the head that the 
> ref tracks has a particular new value (which we provided), so we should be 
> able to update the tracking ref to that value. I don't think it's 
> particularly important that we came by this information in the course of 
> an exchange that wasn't a fetch.
>

We are indeed pretending.  Consider:

 (1) You push, and push succeeds.

 (2) Somebody fetches your result, works on it and pushes back;
     this might happen in post-receive hook.

 (3) You fetch.  You should see somebody else's commit at the
     tip, not what you pushed in (1).

By not fetching but instead of storing what you pushed, you are
pretending that you re-fetched so fast that you gave no chance
to anybody to perform (2) quickly enough.

But my conclusion is that this does not matter in practice, and
I am agreeing with what you tried to do.  That does not change
the fact that we are pretending.
