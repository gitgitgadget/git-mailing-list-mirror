From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Run hooks with a cleaner environment
Date: Tue, 06 Dec 2005 16:39:55 -0800
Message-ID: <7voe3tzqn8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:41:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjnLl-0007oC-Hp
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVLGAj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVLGAj6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:39:58 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25787 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932676AbVLGAj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 19:39:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207003906.UYST20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 19:39:06 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512061716030.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 6 Dec 2005 17:43:28 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13311>

Daniel Barkalow <barkalow@iabervon.org> writes:

> GIT_DIR is set to the repository that got the push,

That is done by receive-pack; it chdir()s into the repository
and does its thing, and the hooks are called from there; I'd
expect cwd to be the repository ('.git'), GIT_DIR to be dot
('.').

I think doing the "unset GIT_DIR" to be the first thing if you
want to access some other repository is documented somewhere but
if not please send a patch to document it.

As to file descriptors, I think duping the output to original
stderr might make sense, but I do not know what breaks, so
interested parties may want to test it out and submit a tested
patch for inclusion.
