From: Willy Tarreau <w@1wt.eu>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 05:34:48 +0200
Message-ID: <20060810033448.GH8776@1wt.eu>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 05:51:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB1aF-0005vm-L9
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 05:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWHJDvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 23:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWHJDvo
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 23:51:44 -0400
Received: from 1wt.eu ([62.212.114.60]:46093 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932493AbWHJDvo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 23:51:44 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25152>

Hi Junio,

On Wed, Aug 09, 2006 at 06:29:30PM -0700, Junio C Hamano wrote:
> GIT 1.4.2-rc4
> 
> It's been a week since -rc3, so here it is.  The changes are
> really small fixes and nothing else.  Let's hope I can tag the
> real 1.4.2 this weekend.

I encountered a problem in 1.4.1 and 1.4-git about 2 weeks ago
(I've not tried 1.4.2-rc4 yet). When applying a git patch which
contains a symlink, the symlink created on the filesystem sometimes
has a wrong name with some chars appended to its end, such as if its
name was not zero-terminated. I always encountered this only when
there were several symlinks in the patch, eg: you create a symlink
first, then commit, then change its dest, then commit, then git-format-patch
and try to apply both patches (git-am -k -3) to another tree. Generally,
the second link will be broken. The index will be OK however, since git-status
will complain about it.

I've tried to find the reason for this problem in the code, but
failed to do so. I remember that the function which calls symlink()
(I don't remember its name, sorry) already gets an invalid name in
path->name or something like this.

That's all I could do because I was really too short in time, and I'm
sorry I really don't have enough time to track this further right now.
However, if you have some time to reproduce it and have questions, I'm
willing to respond you.

Thanks, and sorry again for the lack of information,
Willy
