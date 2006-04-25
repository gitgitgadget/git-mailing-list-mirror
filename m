From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 12:00:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251155530.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
 <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
 <BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSlj-0000n5-TS
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWDYTAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDYTAL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:00:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWDYTAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 15:00:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PJ04tH019417
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 12:00:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PJ02Mq001251;
	Tue, 25 Apr 2006 12:00:02 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19168>



On Tue, 25 Apr 2006, sean wrote:
> 
> It's no different for a bug tracker or other 3rd party software that wants
> to interface with git, it's bad design to force them to parse a single
> free form text comment into individual pieces to extract their meta data.
> Especially when git could easily add the ability to add multple comments
> to each commit.  

Git _does_ make that easy. It's called the "tree". It's where you add any 
arbitrary files to a commit.

The point here is that core git should do one thing, and one thing only. 
You can then build up any policy you want on top of that. But in order for 
core git to be stable, it has to have nice rules about what it cares 
about, and what it does not.

And the rule is: git cares about the commit header, but not about the 
free-form. Which means that anything it doesn't care about, it goes into 
the free-form section, not into some "X-header" section.

Whatever you build on TOP of git can have its own rules in that free-form 
section. For example, the kernel project has this "X-header" thing called 
the "sign-off", and git itself picked it up. There's even some support to 
add it automatically to commits (the same way we add the "revert" info 
automatically to commits), but nobody claims that git should "parse" that 
information, or that it should be part of the "header".

		Linus
