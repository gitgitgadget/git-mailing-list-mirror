From: Junio C Hamano <junkio@cox.net>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 14:35:46 -0700
Message-ID: <7vfy6mstsd.fsf@assigned-by-dhcp.cox.net>
References: <200704261238.51234.andyparkins@gmail.com>
	<200704262228.46864.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBd1-0004ZD-PB
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbXDZVfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXDZVfs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:35:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36807 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbXDZVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:35:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426213546.FQPZ1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 17:35:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rxbm1W00b1kojtg0000000; Thu, 26 Apr 2007 17:35:47 -0400
In-Reply-To: <200704262228.46864.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 26 Apr 2007 22:28:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45663>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007, April 26, Andy Parkins wrote:
>
>> I'll report further as I come across any stumbling blocks; but here
>
> The submodule support requires the latest version of git right?  That's 
> going to cause trouble for people running different versions of git 
> (I've already experienced it in my own limited way - I had to upgrade 
> all the copies of git I have on my various computers before fetching 
> and pushing would work).  If the repository contains a submodule 
> reference it effectively becomes inaccessible by a version of git 
> without submodule support.
>
> I think that we might be able to avoid that problem though - am I right 
> in thinking that the problem is that all the tools need teaching not to 
> follow the gitlink object because that hash doesn't exist in _this_ 
> tree it is a reference to a commit in another tree.
>
> Wouldn't it be better if the gitlink reference pointed at an object in 
> this tree which in turn referred to the submodule commit?  That way the 
> old versions of git would still work with submodule objects in the 
> repository because they would just see submodules as pointing at a 
> blob.
>
> Have I oversimplified it in my head?

I think older tools do not expect to find anything but tree or
blob in a tree object to begin with.  Now your experimental
repository has a commit, which they do not expect to see and I
think they will be unhappy.

If you replace the commit objects in your trees with a new type
of object 'gitlink', your older tools will have exactly the same
problem, won't they?
