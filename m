From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT and the current -stable
Date: Fri, 13 Apr 2007 23:24:19 -0700
Message-ID: <7vfy73bhik.fsf@assigned-by-dhcp.cox.net>
References: <46206842.80203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 08:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcbgP-0006E8-TC
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 08:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030746AbXDNGYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 02:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbXDNGYW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 02:24:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46523 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030746AbXDNGYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 02:24:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070414062420.LPBI1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Apr 2007 02:24:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id muQK1W00V1kojtg0000000; Sat, 14 Apr 2007 02:24:20 -0400
In-Reply-To: <46206842.80203@gmail.com> (Rene Herman's message of "Sat, 14 Apr
	2007 07:36:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44444>

Rene Herman <rene.herman@gmail.com> writes:

> Stumbling around with git here. I'd like to use git to efficiently
> track the current -stable as well as -current. Say, my local tree is a
> clone of Linus current:
>
> git clone \
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> local
>
> I then branch off a 2.6.20 branch:
>
> cd local
> git checkout -b v2.6.20 v2.6.20
>
> to now update to the current -stable I could do:
>
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git

I think adding these lines to .git/config would do the trick,
after you have done the "checkout -b v2.6.20 v2.6.20" step:

[branch "v2.6.20"]
	remote = stable
	merge = refs/heads/master
[remote "stable"]
	url = git://git.kernel.org/.../stable/linux-2.6.20.y.git
	fetch = refs/heads/master

provided if stable team forks v2.6.20.y history off of Linus's
v2.6.20.

With the above configuration, anytime you say "git pull" while
on your v2.6.20 branch will fetch from "stable" and merge their
'master' branch in your current branch (i.e. v2.6.20 branch).
