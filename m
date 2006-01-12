From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 05:18:41 -0500 (EST)
Message-ID: <BAYC1-PASMTP099ED34B41FFA02EDEEF25AE270@CEZ.ICE>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, "Nick Hengeveld" <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 11:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwzXj-0005Gz-7J
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 11:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWALKSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 05:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWALKSo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 05:18:44 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:53966 "EHLO
	BAYC1-PASMTP09.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030341AbWALKSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 05:18:43 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP09.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 02:19:18 -0800
Received: by linux1.attic.local (Postfix, from userid 48)
	id 79A8E644C26; Thu, 12 Jan 2006 05:18:41 -0500 (EST)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 Jan 2006 05:18:41 -0500 (EST)
Message-ID: <56282.10.10.10.28.1137061121.squirrel@linux1>
In-Reply-To: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 12 Jan 2006 10:19:18.0609 (UTC) FILETIME=[A5B64410:01C61761]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, January 12, 2006 4:13 am, Junio C Hamano said:
> The underlying "git send-pack remote.host:path" pushes all the
> matching refs that both local and remote has, and "git push"
> blindly inherits this property.
[snip]
> Unlike pull that can happen pretty much promiscuously, people
> will push into the same set of a limited number of remote
> repositories repeatedly over the life of the project, so it is
> reasonable to assume they would want to keep a $GIT_DIR/remotes/
> entry for those repositories to save typing.  Then always
> requiring one or more refspecs for push is not too much to ask
> for.
>
> Opinions?

What about assuming a refspec of  "current-branch:current-branch" ?
That is, if the branch name that is currently checked out locally
also exists upstream, push into it (only if fast forward).

This should allow multiple branches to be updated locally, and pushed
upstream selectively.  If you force all push-refspecs to be listed
in a remotes file, they'll all be updated every time you push and
you'd lose the ability to push just one branch upstream without
resorting to multiple $GIT_DIR/remotes/ entries.

Sean
