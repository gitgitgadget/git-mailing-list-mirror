From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tracking branch for a rebase
Date: Fri, 04 Sep 2009 16:31:57 +0200
Message-ID: <4AA124DD.1030208@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjZps-0002Y2-AH
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 16:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbZIDOcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756847AbZIDOcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 10:32:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49340 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753083AbZIDOcI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 10:32:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7451A62530;
	Fri,  4 Sep 2009 10:32:09 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 04 Sep 2009 10:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=SlW0MbL7mjBF6Y2LuBJIOSYN2/Q=; b=gBcNjjK33icCcgk4aXV974d12NF8Mv3kVZdm9L5KVAlJA+dU+M8XSAlPpQfRqr6A33kWdUKDxwOc5vX6dxzj4zM+UnRGPl26pEMWxb86XJ71NkvUVVqnbU8GZp7VQ4zdHgEcn+pzfzKW1DQlAWui8B3sNqg7qpxzOPL9GPSAfrE=
X-Sasl-enc: ZeoqZwDXtjd256V/xkfwaEz8BAAc3LGK3/lCW5fN7476 1252074729
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C90182DD6;
	Fri,  4 Sep 2009 10:32:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090904135414.GA3728@honk.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127735>

Pete Wyckoff venit, vidit, dixit 04.09.2009 15:54:
> I received an interesting question today.
> 
> If "git pull" knows what remote tracking brach to pull from,
> why doesn't "git rebase" automatically know I want to rebase
> on top of my remote tracking branch?
> 
> He had done a "git remote update", reviewed the changes, and now
> wants to rebase his changes on top of the new upstream.
> 
> I told him about git pull --rebase, and branch.name.rebase,
> but didn't have an easy answer to the "what is my remote tracking
> branch" question in this case.

I guess he knows that branch if he reviewed it... More seriously,

git for-each-ref --format='%(upstream)' refs/heads/hisbranch

will return the upstream of hisbranch.

> 
> All the information is in git config branch.name.{remote,merge},
> but I can't find anything that just answers that question.  Nor
> did I have a good answer for why "git rebase" doesn't just default
> to rebasing the current branch on top of the tracking branch.

Maybe because nobody has cared. Doing a "git pull --rebase" is not
equivalent (it may fetch more refs), but close enough for many people.

There was an initiative by Dscho a while ago to introduce a shortcut for
the upstream, which was dwarfed by the lack reserved characters for
refnames. Maybe 1.7 time frame would be a good time to change this?

Making this the default for rebase without arguments may meet some
objections (oh no, I didn't mean to rebase), but I guess it's worth trying.

Michael
