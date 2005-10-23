From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Server side programs
Date: Sat, 22 Oct 2005 17:42:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510221737300.10477@g5.osdl.org>
References: <435ABB99.5020908@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 23 02:42:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETTwT-0005ka-KU
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 02:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJWAmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 20:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJWAmP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 20:42:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbVJWAmO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2005 20:42:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9N0gBFC003093
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 22 Oct 2005 17:42:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9N0gA2e000813;
	Sat, 22 Oct 2005 17:42:10 -0700
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435ABB99.5020908@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10480>



On Sun, 23 Oct 2005, Andreas Ericsson wrote:
>
> Are git-receive-pack and git-upload-pack the only two binaries that get called
> directly over a SSH-tunnel?

With the normal pack thing, yes.

They will exec other programs (mainly git-rev-list and 
git-[un]pack-objects), and a client can ask for other programs 
(git-send-pack takes an "--exec=" argument, for example), but those two 
should be sufficient if you have a server-side special "restricted shell" 
that you want to run instead of a real one.

One more issue: you can't create a new archive or delete an old one (or do 
administration like repacking, fsck etc) with those interfaces, so if you 
want these limited users to be able to do that, then you'd need to add a 
few administration commands too.

		Linus
