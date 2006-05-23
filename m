From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 12:36:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org>  <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
  <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>  <20060522214128.GE16677@kiste.smurf.noris.de>
  <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> 
 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> 
 <20060523065232.GA6180@coredump.intra.peff.net>  <20060523070007.GC6180@coredump.intra.peff.net>
 <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
 <Pine.LNX.4.64.0605230948280.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 21:37:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ficgv-0000w8-Ax
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWEWThF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEWThF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:37:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWEWThE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 15:37:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NJagtH023497
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 12:36:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NJabFu018147;
	Tue, 23 May 2006 12:36:39 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605230948280.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20622>



On Tue, 23 May 2006, Linus Torvalds wrote:
> 
> Hmm. Is it just me, or does the current "git cvsimport" have new problems:
> 
> 	[torvalds@merom git]$ git cvsimport -d ~/CVS gentoo-x86
> 
> causes
> 
> 	Committing initial tree 34bd3dcd4bfd79bad35ce3fb08b2e21108195db8
> 	Server has gone away while fetching BUGS-TODO 1.1, retrying...
> 	Retry failed at /home/torvalds/bin/git-cvsimport line 366, <GEN2656> line 9.
> 
> and that's it for the import.
> 
> I don't see what would have caused it in the changes, but it definitely 
> worked earlier..

Martin, that problem seems to go away when I initialize $res to 0 in 
_fetchfile. 

I don't know perl, and maybe local variables are pre-initialized to empty. 

It's entirely possible that the fact that it now seems to work for me is 
purely timing-related, since I also ended up using "-P cvsps-output" to 
avoid having a huge cvsps binary in memory at the same time.

		Linus "perl illiterate" Torvalds
