From: Junio C Hamano <junkio@cox.net>
Subject: Re: Date-based limits
Date: Mon, 31 Oct 2005 16:37:01 -0800
Message-ID: <7v1x21b3v6.fsf@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
	<Pine.LNX.4.64.0510311820060.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 01:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWk9E-0008Gh-22
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVKAAhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVKAAhE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:37:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31952 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751338AbVKAAhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 19:37:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101003640.VICK9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 19:36:40 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510311820060.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 31 Oct 2005 18:47:03 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10910>

Daniel Barkalow <barkalow@iabervon.org> writes:

> At some point, we might want to have a series of refs tracking changes to 
> the user's heads over time.

Hmph.  If you really want something like that, I think you could
add a hook support for git-fetch to implement this as
automatically created lightweight tags, stashed in
$GIT_DIR/fetch-history/, deriving their names from the time of
the fetch; clone would grab everything below refs/ but this is
deliberately placed outside that hierarchy and won't get copied.
By definition, these point at commits reachable from some of
your heads (unless the remote repository maintainer is stupid
enough to rewind public trees ;-), so fsck-object would not see
them but it should not be a problem.
