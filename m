From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 05 Feb 2007 09:58:26 -0800
Message-ID: <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070201234706.GP17617@mellanox.co.il>
	<Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702051245050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 05 18:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE86q-0005mS-CZ
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 18:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXBER62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 12:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXBER62
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 12:58:28 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:52918 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752605AbXBER61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 12:58:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205175827.IIVW1306.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 12:58:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KtyS1W00D1kojtg0000000; Mon, 05 Feb 2007 12:58:26 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38763>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh? Well, to me, "clone" meant something like the genetics thing, i.e. get 
> a copy of the repository. Since a "branch" is not the complete repository, 
> but only part of it, I would have expected "engraft" instead of "clone" 
> there.
>
> But I can learn! So (post-1.5.0, maybe?) I'd be perfectly d'accord with 
> something like this
>
> 	git clone git://.../git.git#html
>
> to mean "just fetch the branch html, and check it out".

I agree that the word "clone" to me sounds like "copy the whole
repo", so a single branch cloning feels it is something
different from "clone", but I do not think it means wholeness
must be the only mode of operation.

Except that I do not particularly think the URL fragment
notation is such a "cool" syntax.

>> I think the logic to decide where to point remotes/$origin/HEAD to 
>> should be moved to "git-remote add -m" when we eventually rewrite 
>> "git-clone" to use "git-remote add -f".  And while we would do so, we 
>> can make a trivial extension to fetch-pack protocol to carry the HEAD 
>> symref information.  All will be good once that happens.
>
> Would you like this as a multi_ack-like extension?
>
> But then how to teach the dumb protocols in a backwards-compatible 
> fashion?

I am not talking about enhancing ls-remote output nor info/refs
file format.  I do not think we need to do anything special to
support it in backwards compatible way.

Look at what dumb protocols do in git-clone.  http already knows
where HEAD points at when it fetches HEAD with curl.  I do not
particularly care about rsync, but I suspect it can be handled
the same way.
