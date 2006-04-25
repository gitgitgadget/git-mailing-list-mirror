From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 04:34:36 -0400
Message-ID: <BAYC1-PASMTP097C0E667E1CBC8B3FC2BCAEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<e2kjul$ntq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 10:39:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJ4X-0005Tz-Ko
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 10:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWDYIi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWDYIi5
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 04:38:57 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:27588 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751445AbWDYIi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 04:38:56 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 01:40:25 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4B225644C28;
	Tue, 25 Apr 2006 04:38:54 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20060425043436.2ff53318.seanlkml@sympatico.ca>
In-Reply-To: <e2kjul$ntq$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 08:40:25.0875 (UTC) FILETIME=[E6132630:01C66843]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 09:43:33 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> Perhaps there should be an option to specify that the link is optional, and
> the object pointed can be gone missing. For example for cherrypick the
> original cherry-picked commit can either be removed completely, e.g. when
> the original branch is deleted, or it can be modified breaking link when we
> rewrite history up to original commit on original branch.
> 
> Also all other commands which show commit (commit messsage at least) should
> be considered for including "related" links...

If you're cherry-picking from a disposable branch, then you don't want to 
include a link to it in your new commit.  Once you include the link, the 
source commit should be protected from pruning just like any other piece 
of history.  Otherwise there's no way for fsck-objects to know if a missing 
object means corruption or not.  So you need a way at commit time to
request the explicit linkage.

This might be useful for bug tracking front ends that could automatically 
show a hot fix migrating from devel, to testing, to release branches.  With 
Junio's proposal, perhaps there's even a better keyword for these particular 
linkages.

Sean.
