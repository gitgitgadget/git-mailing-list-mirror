From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 13:51:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271347060.3952@g5.osdl.org>
References: <20060927204428.39120.qmail@web51014.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 22:52:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgNm-0006yR-E8
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 22:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWI0Uvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 16:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030825AbWI0Uvv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 16:51:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030822AbWI0Uvv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 16:51:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RKpfnW026240
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 13:51:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RKpd7K016324;
	Wed, 27 Sep 2006 13:51:40 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927204428.39120.qmail@web51014.mail.yahoo.com>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27931>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> 
> What is the difference between a merge and a "merge then pushed out"? There are at least some
> situations where a repo would prefer to know its local time of a merge or pulled in merge and
> anyway a local repo probably should not in any way be dependent on nor _trust_ all remote repos
> timestamps...?

Look into the ref-logging. It's exactly what you ask for.

The fact is, in a distributed system, you can _never_ make sense of 
"time". Just live with it. That's basic "distributed programming 101", and 
it's the one thing every such course should start with on the very first 
day.

So in short, you _cannot_ depend on time in a distributed environment. 
Really. Stop even asking. Please.

You can ask when some local reference was changed, and we support that 
already, and I pointed you to how to enable it in a repository you care 
about. But it's _always_ going to be just about your local repository, the 
whole question doesn't make sense any other way.

And no, it's _never_ going to tag individual merges or commits, since the 
same merge or commit can show up at DIFFERENT times in different branches, 
even within the same local repository.

So as long as you continue to ask for "commit times", you cannot get what 
you ask for. The _only_ commit time that makes sense is the time ON THE 
MACHINE that the commit was made. That's the time that git already saves 
in the commit itself. And if you don't trust that timeframe, then tough 
luck.

Git itself doesn't trust it, because git knows better. But it's there.

		Linus
