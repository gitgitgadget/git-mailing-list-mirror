From: Keith Owens <kaos@sgi.com>
Subject: Re: Current state of GIT fetch/pull clients
Date: Fri, 16 Sep 2005 15:49:11 +1000
Message-ID: <8953.1126849751@kao2.melbourne.sgi.com>
References: <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, tony.luck@intel.com
X-From: git-owner@vger.kernel.org Fri Sep 16 07:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG96S-0004hF-6A
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 07:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbVIPFtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 01:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVIPFtg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 01:49:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24278 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030572AbVIPFtg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 01:49:36 -0400
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id j8G7pjW0020833;
	Fri, 16 Sep 2005 00:51:46 -0700
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA03034; Fri, 16 Sep 2005 15:49:11 +1000
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Thu, 15 Sep 2005 16:52:20 MST."
             <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8661>

On Thu, 15 Sep 2005 16:52:20 -0700, 
Junio C Hamano <junkio@cox.net> wrote:
>What this means is that using objects/info/alternates mechanism
>in your repository is a bit premature as things currently stand,
>if you intend your repository to be used by the general public.

Clients using rsync can use a workaround, although it is a bit clumsy.
I do rsync for selected /pub/scm/linux/kernel/git/ trees, including
torvalds and aegl.  At one point Tony Luck (aegl) was using alternates,
with objects/info/alternates containing
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects

As you described in your mail, rsync with alternates overwrites the
local file, so the local alternates ended up pointing at a local
directory that did not exist.  Creating a local symlink from
/pub/scm/linux/kernel/git to the local directory that contains the
torvalds and aegl directories worked around the problem.  git checkout
on the aegl tree was quite happy to follow the symlink and pick up most
of the files from torvalds.

No point in doing that now, Tony has reverted the aegl tree to a full
copy of Linus, instead of using alternates.
