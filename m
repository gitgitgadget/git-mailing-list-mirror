From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 10:10:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601121006040.3535@g5.osdl.org>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:11:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex6uL-0001h7-T8
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 19:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWALSKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWALSKn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 13:10:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932530AbWALSKm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 13:10:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0CIAaDZ001342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 10:10:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0CIAW3V029865;
	Thu, 12 Jan 2006 10:10:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14571>



On Thu, 12 Jan 2006, Junio C Hamano wrote:
> 
> Nevertheless, exposing the default behaviour of "git send-pack"
> to "git push" was probably a mistake.  I'd propose to require at
> least one refspec to be specified, either on the command line or
> via $GIT_DIR/remotes mechanism.  So my answer to the "Subject: "
> line question is "Barf".

Well, I don't have objections, but from ym usage schenario, I'd at least 
then want flags for "all tags" (--tags - like "pull") and "all branches" 
(--all).

Having to list all tags/branches is slightly painful. I currently push out 
all my tags with

	./push-all $(cd .git/refs ; find -type f tags)

which works but isn't exactly user-friendly ("push-all" is just a script 
that uses "git push" to push to multiple repositories).

> Unlike pull that can happen pretty much promiscuously, people
> will push into the same set of a limited number of remote
> repositories repeatedly over the life of the project, so it is
> reasonable to assume they would want to keep a $GIT_DIR/remotes/
> entry for those repositories to save typing.  Then always
> requiring one or more refspecs for push is not too much to ask
> for.

Well, especially if you want to use "git push" to basically back up your 
own repo, you do want the "--all" flag. Otherwise you will then forget to 
add a branch name to every remotes file whenyou create a new branch.

		Linus
