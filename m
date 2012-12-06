From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Thu, 6 Dec 2012 02:23:04 +0100 (CET)
Message-ID: <1622149333.19335600.1354756984435.JavaMail.root@dewire.com>
References: <7vd2yojbw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 02:23:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgQBQ-0007Sh-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 02:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab2LFBXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 20:23:08 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:41592 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2LFBXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 20:23:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 40202825EF;
	Thu,  6 Dec 2012 02:23:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zw2bL7iU6VAr; Thu,  6 Dec 2012 02:23:04 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 7D5D482457;
	Thu,  6 Dec 2012 02:23:04 +0100 (CET)
In-Reply-To: <7vd2yojbw2.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211152>



----- Ursprungligt meddelande -----
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > If core.symlinks is set to copy then symbolic links in a git
> > repository
> > will be checked out as copies of the file it points to.
> 
> That all sounds nice on surface when the primary thing you care
> about is to fetch and check out other people's code and extract it
> to the working tree, but how well would that work on the checkin
> side?  What happens if I check out a symlink that points at a file
> (either in-tree or out-of-tree), make some changes that do not
> involve the symlink, and before I make the commit, an unrelated
> change is made to the file the symlink is pointing at?
> 
> > - git status - when do we report a diff.
> > 	- After checkout we should probably not
> > 	- if the "linked" files change?
> 
> Yeah, exactly.
> 
> > 	- if a change in the copied directory chsnges
> 
> That, too.
> 
> > 	- if a file in the copied diretory is added/removed
> > 	- update, should we update the copied structure automatically
> > 	  when the link target changes

Some of the questions have proposals in the includes test script. A 
little more dangerous than having real symlinks ofcourse, but regardless
of what one does with or without copied symlinks one can make mistakes
and I feel letting Git do the copying is way better than having real
copies in the git repository. Another crappy scm which the users are
converting from does this and it works. A difference to git is that
it (ok clearcase) makes all files read-only so there are fewer mays
of making mistakes with the copies.

> I personally do not think this is worth it.  It would be very useful
> on the export/checkout side, so it may make sense to add it to "git
> archive", though.

It makes sense, but it does not solve the problem at hand.

-- robin
