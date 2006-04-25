From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 08:40:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 17:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYPeo-0002Gj-58
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 17:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWDYPkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 11:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDYPkc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 11:40:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751276AbWDYPkc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 11:40:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PFePtH011371
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 08:40:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PFePcp027579;
	Tue, 25 Apr 2006 08:40:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19150>



On Tue, 25 Apr 2006, Linus Torvalds wrote:
> 
> I want the git objects to have clear and unambiguous semantics. I want 
> people to be able to explain exactly what the fields _mean_. No "this 
> random field could be used this random way" crud, please.

Btw, if the whole point is a "leave random porcelain a field that they can 
use any way they want", then I say "Hell NO!".

Random porcelain can already just maintain their own lists of "related" 
stuff, any way they want: you can keep it in a file in ".git/porcelain", 
called "list-commit-relationships", or you could use a git blob for it and 
have a reference to it in .git/refs/porcelain/relationships or whatever. 

If it has no clear and real semantic meaning for core git, then it 
shouldn't be in the core git objects.

The absolute last thing we want is a "random out" that starts to mean 
different things to different people, groups and porcelains.

That's just crazy, and it's how you end up with a backwards compatibility 
mess five years from now that is totally unresolvable, because different 
projects end up having different meanings or uses for the fields, so 
converting the database (if we ever find a better format, or somebody 
notices that SHA1 can be broken by a five-year-old-with-a-crayon).

There's a reason "minimalist" actually ends up _working_. I'll take a UNIX 
"system calls have meanings" approach over a Windows "there's fifteen 
different flavors of 'open()', and we also support magic filenames with 
specific meaning" kind of thing.

			Linus
