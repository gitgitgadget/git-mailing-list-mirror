From: linux@horizon.com
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: 21 Nov 2005 22:20:14 -0500
Message-ID: <20051122032014.32539.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 04:21:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeOhh-00038n-42
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 04:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKVDUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 22:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKVDUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 22:20:16 -0500
Received: from science.horizon.com ([192.35.100.1]:52795 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750701AbVKVDUP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 22:20:15 -0500
Received: (qmail 32540 invoked by uid 1000); 21 Nov 2005 22:20:14 -0500
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12517>

> The main reason I don't like indentation is that it tends to have strange 
> rules for "tab". Some people (incorrectly, of course) think that tabs are 
> not at fixed 8-byte things, so deciding the indentation of a tab often 
> ends up either disallowing tabs altogether (bad) or having other strange 
> rules (disallowing spaces).
> 
> So I'm not religiously opposed to it, but I find it to be less than 
> optimal.

Actually, most indentation-sensitive languages have a simpler solution:
they don't try to convert whitespace strings to a number like "horizontal
position"; they just compare strings.

Each line must either have the same indentation string as some active
scope, or its indentation must have the current innermost scope as a
prefix, in which case it introduces a new scope.

This allows anything except for

foo		# No prefix
    bar		# 4 spaces prefix
	baz	# tab prefix: illegal!

The "baz" line would have to begin with 4 spaces to be legal.
They could be followed by 4 more spaces, or a tab, or any other
whitespace pattern.

It's also possible to combine the two, as Haskell does.  Haskell inserts
open braces automatically if there is no such punctuation between two
lines with differing indentation, but if you supply a brace explicitly,
you can do whatever indentation you like.  (And the close brace must be
explicit if the open brace is, of course.)
