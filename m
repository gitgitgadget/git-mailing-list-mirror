From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 08:41:20 -0700
Message-ID: <7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
References: <20070509.020916.80034730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed May 09 17:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HloIA-0006x5-AW
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbXEIPlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbXEIPlW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:41:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37145 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbXEIPlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:41:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509154119.VDWD26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 11:41:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x3hL1W00Q1kojtg0000000; Wed, 09 May 2007 11:41:21 -0400
In-Reply-To: <20070509.020916.80034730.davem@davemloft.net> (David Miller's
	message of "Wed, 09 May 2007 02:09:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46732>

David Miller <davem@davemloft.net> writes:

> master.kernel.org just upgraded to git-1.5.1.4 and I notice
> that doing something like this:
>
> 	git clone --bare -n -l -s ../torvalds/linux-2.6.git test-2.6.git
>
> is no longer an instantaneous operation, it seems to be doing a lot
> of stuff now:
>
> Initialized empty Git repository in /home/davem/git/test-2.6.git/
> remote: Generating pack...
> remote: Done counting 480025 objects.
> remote: Deltifying 480025 objects.
> remote:  100% (480025/480025) done
> Indexing 480025 objects.
> remote: Total 480025 (delta 385878), reused 473265 (delta 379369)
>  100% (480025/480025) done
> Resolving 385878 deltas.
>  100% (385878/385878) done
>
> Is there a new way to get a quick clone?

There is something very wrong.  "-l -s" should never go to the
"remote: Generating pack..." codepath.  Is that reproducible?
Could you try "sh -x git-clone" it?
