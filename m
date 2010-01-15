From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout -f: What am I missing?
Date: Fri, 15 Jan 2010 16:28:23 +0100
Message-ID: <4B508997.8030105@drmicha.warpmail.net>
References: <4B4F899C.7070800@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:41:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVoJ2-0005i6-7A
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 16:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0AOPlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 10:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378Ab0AOPlo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 10:41:44 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37271 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751737Ab0AOPln (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 10:41:43 -0500
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2010 10:41:43 EST
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5CECDCDF7D;
	Fri, 15 Jan 2010 10:30:12 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 15 Jan 2010 10:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TrbRHtvVr7tXjk58GwazkNFGmpY=; b=GrJtAotqbqGa9NCoSwIwL4mfd8GdVk3PsvuY7j0tWlA98uj3SoHjIaZQsjjz5yDPl6N8qAMkjZTxOu3dQ356qRKwG0Kcol36QjeuqjTxEuxjL0xwcUi+2OOb42CylP5NLyP59JtLZiEv/2ID0mE8rGhoKxqBCRDK9A+DI9S93LE=
X-Sasl-enc: z6wMT9BB/ZihpDMtpo7qWi/zV5eZOunxhnmU0LOaN3Vx 1263569411
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B7A019B55;
	Fri, 15 Jan 2010 10:30:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <4B4F899C.7070800@box.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137076>

Soham Mehta venit, vidit, dixit 14.01.2010 22:16:
> Hi,
> 
> I have a situation with git that I'm trying to understand:
> 
> Description:
> 1) GIT_DIR is set to /path/to/repo/.git
> 2) Repository is /not /a bare repo, and all files are nicely checked-out 
> in /path/to/repo/
> 3) Somebody pushes to that repo using ssh (any branch, checked-out or not)
> 4) Default post-receive hook runs (it is the only one +x) which sends 
> out an email 
> (http://repo.or.cz/w/git.git/blob/HEAD:/contrib/hooks/post-receive-email)
> 5) After it is done sending the email, I put "git checkout -f", at the 
> end in the same file, in case someone pushes to a checked-out branch
> 
> Problem:
> It runs "checkout -f" as if inside .git directory, instead of on the 
> parent. i.e. it gets all files from the parent and writes them inside 
> .git. Parent is left untouched.
> 
> Some more info:
> 0) We don't have GIT_DIR set in the environment. The hook does a 
> rev-parse to find it.
> 1) echo of $GIT_DIR right before the checkout -f line gives a "." .
> 2) It works as expected if I do this:  cd /path/to/repo && git 
> --git-dir=/path/to/repo/.git/ checkout -f
> 
> What I do know:
> 1) Pushing to a checked-out branch is not a git best-practice, and some 
> git behavior is undefined in that case. We already have plans to go away 
> from that.
> 2) Git tends to like full path names instead of relative ones
> 
> Can someone help me understand this behavior?

Does the thread
http://permalink.gmane.org/gmane.comp.version-control.git/136267
help by any chance?
You've found the solution, "cd .. && unset GIT_DIR" does it.

Michael
