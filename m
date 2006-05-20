From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dangling commits.
Date: Sat, 20 May 2006 16:19:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605201615270.3649@g5.osdl.org>
References: <20060520230531.GA27511@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 01:19:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhajE-0000hU-LC
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWETXTW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWETXTV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964827AbWETXTV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 19:19:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4KNJ8tH012109
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 20 May 2006 16:19:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4KNJ6Gg010577;
	Sat, 20 May 2006 16:19:07 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060520230531.GA27511@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20408>



On Sat, 20 May 2006, Dave Jones wrote:
>
> What's wrong here?

Nothing, except

 - you used rsync to fetch the thing (so you get all objects, regardless 
   of whether they are reachable or not)

 - junio re-bases his "pu" branch, and I just end up following him (I 
   should stop exporting git entirely, here's no point, really). Thus, 
   whenever "pu" gets reset to something else, the old head of pu gets 
   dropped on the floor and ends up as a "dangling" commit (no branch head 
   points to it any more).

The moral(s) of the story being that

 (a) dangling commits are normal if you reset branch heads (which includes 
     things like "git rebase", for example)

 (b) rsync is not a good transfer protocol, since it will just blindly 
     transfer objects that aren't needed - or worse - successfully clone a 
     corrupt repository.

but there's nothing to _worry_ about in this particular schenario.

		Linus
