From: linux@horizon.com
Subject: Re: More merge questions
Date: 2 Dec 2005 16:56:58 -0500
Message-ID: <20051202215658.1731.qmail@science.horizon.com>
References: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net>
Cc: junkio@cox.net, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Dec 02 22:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiItw-0000K6-0a
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 22:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVLBV5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 16:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVLBV5A
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 16:57:00 -0500
Received: from science.horizon.com ([192.35.100.1]:56380 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750890AbVLBV47
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 16:56:59 -0500
Received: (qmail 1732 invoked by uid 1000); 2 Dec 2005 16:56:58 -0500
To: git@vger.kernel.org
In-Reply-To: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13129>

Just thinking about the difference between 2-way and 3-way merge...

*Mostly* a 2-way merge is just a 3-way merge where one of the ways
is taken from the index rather than from a tree.  But there
are some subtle differences.

This diffierence is what forces octopus merge to form intermediate tree
objects when doing its merges.  If there was a way to merge directly
into the index, octopus merge wouldn't have to make intermediate tree
objects that would have to be garbage-collected later.

(Indeed, I originally assumed that Octopus did all its merges in the
index; it's only when I traced the code that I saw it calls git-write-tree
multiple times.)

Is the time saved, and space not wasted, worth implementing a 2-way merge
that more exactly matches 3-way?  It should be fairly straightforward
to share the actual merging code.

Opinions solicited.
