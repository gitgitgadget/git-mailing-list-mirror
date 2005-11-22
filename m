From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2.6.15-rc2 tag
Date: Tue, 22 Nov 2005 12:33:11 -0800
Message-ID: <7vlkzgctiw.fsf@assigned-by-dhcp.cox.net>
References: <20051121212549.GA23213@fieldses.org>
	<20051122193418.GC5628@fieldses.org>
	<Pine.LNX.4.64.0511221200340.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 21:35:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeepK-00051V-NC
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVKVUdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVKVUdN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:33:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37075 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965143AbVKVUdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 15:33:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122203212.WOI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 15:32:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511221200340.13959@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 22 Nov 2005 12:01:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12574>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 22 Nov 2005, J. Bruce Fields wrote:
>>
>> I'm still not getting a 2.6.15-rc2 tag with either git-clone or
>> git-fetch --tags.  Any ideas?  Is the problem with me or with the
>> repository?
>
> Try using 
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> instead. Does that help? 

It should.  And I think git:// should be encouraged over
http://, but some people (including me at work) can only come
from http://, so...

> I don't understand how http:// works (or doesn't), so..

The difference between git-ls-remote against your repository via
git:// and http:// would tell you.  Your info/refs in your repo
is stale; git http transport is designed to cope with webservers
without dirindex, and only uses info/refs to find out what refs
you have in that repository.  It does not fall back on "wget -r"
behaviour simply because it is a mess (you get all sorts of
useless links by doing dirindex in refs/ directory, like Name,
Last modified, Size, Parent Directory).

Mind enabling hooks/post-update on the master so that
update-server-info is run after you push into it?
