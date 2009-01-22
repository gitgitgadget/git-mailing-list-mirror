From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved
    conflict
Date: Thu, 22 Jan 2009 10:17:12 +0100
Message-ID: <49783998.1040400@drmicha.warpmail.net>
References: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>	 <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nathan Yergler <nathan@creativecommons.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 10:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPvhz-0000Sl-VH
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 10:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbZAVJRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 04:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbZAVJRS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 04:17:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33380 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232AbZAVJRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 04:17:16 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0B243243800;
	Thu, 22 Jan 2009 04:17:15 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 22 Jan 2009 04:17:15 -0500
X-Sasl-enc: uVLZXesb+SWc6WBd4f8IEfeE3+UD6RTRIJ9b/3RfdsVs 1232615834
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2E1C8AED7;
	Thu, 22 Jan 2009 04:17:14 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106736>

Nathan Yergler venit, vidit, dixit 21.01.2009 22:46:
> Can you elaborate on why doing -i automatically is a bad idea in this
> case?  [It may really be, I don't pretend to have enough knowledge
> about git's internals to make a reasoned argument.]  This was
> unexpected behavior for me as I'd always experienced "git add path &&
> git commit" and "git commit path" as being equivalent and so I assumed
> they would work equivalently in this situation.

Because it makes it hard to follow the discussion.

Why shouldn't I?

Fist of all: Please don't top post.

;)

That being said: As Johannes 6t explained (in agreement with git help
commit), "git commit path" - which is synonymous with "git commit -o
path" is a way of bypassing the index. Think of "Oh wait, I wanted to
commit that before I commit what I'm preparing right now.". Now,
bypassing the index is no big deal, but bypassing a merge in progress
is, because a merge in progress leaves more traces than just the index
state (e.g. MERGE_HEAD). That's also why this use case is mentioned
explicitly in the man page... In fact, rereading that man page (and
testing things to be on the safe side) I have to correct myself: Out of

1) git add path && git commit
2) git commit path
3) git commit -i path

none are equivalent! 1) and 3) are equivalent if and only if "path" is
known to git already: git commit -i does not add new paths.
2) and 3) are equivalent if and only if the index is empty (no changes
staged). The question "When are 1) and 2)" equivalent is left as an
exercise in elementary logic. ;)

Cheers,
Michael
