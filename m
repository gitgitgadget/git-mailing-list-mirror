From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Support projects including other projects
Date: Wed, 11 May 2005 21:52:57 -0700
Message-ID: <7vk6m5kpue.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505112350420.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 06:46:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW5aK-0003k8-60
	for gcvg-git@gmane.org; Thu, 12 May 2005 06:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVELExO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 00:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVELExF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 00:53:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36326 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261336AbVELExA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 00:53:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512045257.CGAF19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 00:52:57 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505112350420.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 12 May 2005 00:23:40 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think that the core of your idea of recording "required
version" of the depended project (core GIT) in the depending
project (Cogito) is a very sound one.  GNU Arch folks do
something similar in their "package-framework" stuff.  

I however do not think that belongs to the core GIT nor even to
Cogito for that matter.  To me, it feels like this is a pure
build infrastructure issue.

I think you could arrange something like that with today's core
GIT tools, like this:

 - Tweak Cogito Makefile so that pure Cogito and core GIT are
   housed in separate subdirectories;

 - Add "required-git-pb" file to Cogito source as a tracked
   source file, and record the required version of git-pb there;

 - Arrange Cogito Makefile to make sure the subtree that has the
   core GIT side meets "required-git-pb" constraints.  The
   constraints could be "at least contains this one", "exactly
   this one".  The policy would be differnt from a depending
   project to another.  What happens if the requirements are not
   met is also up to the policy of that depending project.

