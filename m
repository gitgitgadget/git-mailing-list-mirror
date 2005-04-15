From: Petr Baudis <pasky@ucw.cz>
Subject: Out-tree merges
Date: Fri, 15 Apr 2005 18:29:58 +0200
Message-ID: <20050415162957.GI19078@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:27:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMTeQ-0005kX-MW
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 18:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVDOQaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 12:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVDOQaD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 12:30:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33244 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261518AbVDOQ37 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 12:29:59 -0400
Received: (qmail 3838 invoked by uid 2001); 15 Apr 2005 16:29:58 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I've been thinking about it, and although it seemed Just Sensible
initially, I'm liking it less and less now that I'm actually doing
out-tree merges (git merge already supports it). What is the motivation
of doing things outside of your working directory?

  The only one I can imagine is that it could interfere with some local
changes in your directory. And I think that this does not make sense.
Either you are going to keep them and you should commit them, or you
don't and there's no reason for keeping them around. Is this really that
common for you?

  I have two counter-arguments. First, you likely can't build the thing
in your merge tree, so you can't check if it even compiles after the
merge went through. Second, you need to work quite differently when
working in a merge tree. You can't grep for stuff, you cannot (without
thinking about it and going to different directories) peek to header
files to check if this structure member is really __u32, etc. You might
do all of this when merging, let's say when solving weird conflicts.

  Of course being better off with your working directory assumes that
you have one. OTOH it is hardly imaginable for me that you would all of
sudden want to say "hey, now I want to take these two trees all of
sudden and void and merge them together". Not in any common real world
cases.  Or am I wrong?

  So, I'm thinking whether to just revert to the original behaviour of
doing the merges in the working tree, or make it optional (which would
make the scripts more complicated and convoluted).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
