From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 20:56:32 -0400
Message-ID: <BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 02:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSNjL-0002Lm-IB
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 02:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWI0A4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 20:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWI0A4h
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 20:56:37 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:6016 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932150AbWI0A4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 20:56:35 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 18:04:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSNiz-0004B2-SI; Tue, 26 Sep 2006 20:56:33 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Message-Id: <20060926205632.5d487cc9.seanlkml@sympatico.ca>
In-Reply-To: <20060927002745.15344.qmail@web51005.mail.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 01:04:40.0031 (UTC) FILETIME=[E8B5BEF0:01C6E1D0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 17:27:45 -0700 (PDT)
Matthew L Foster <mfoster167@yahoo.com> wrote:


> It's true I don't know much about git, what is the difference between a changeset and a snapshot?
> Are you saying timestamps should be tracked separately or tracked by an scm system built on top of
> git? Does/should git care about the when of a snapshot?
> 
> Perhaps my question is directed more toward gitweb.cgi, it seems to me the timestamp of when a
> snapshot was merged into this repository should somehow be tracked and that is what gitweb.cgi
> should default to display. For example, if someone wants to know if security bugfix X was merged
> into linus' kernel tree they also want to know when that happened, don't they? 

You are right that a "Merged Date:" in gitweb would be useful information to
show for each commit, but it's not straightforward given the design of git.

Each commit contains the date and time it was first created.  Because this value
is used as part of each commits' unique hash value, it can not be changed without
breaking a very fundamental part of Git.  This means that Git can not easily
answer the question of which date any particular commit was merged with the
local repository.

To help address this, the "reflog" feature was added (i believe by Shawn Pearce)
which records a local time stamp when pulling in changes from other repositories.
It should be possible to query this log to get the information you desire, but I
don't think it would be efficient enough to do in gitweb unless the values were
cached instead of queried each time.

Sean
