From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 11:00:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141056170.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <87irrhvkyl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nicolas Vilz 'niv'" <niv@iaglans.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F95QK-0003Tr-Ag
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWBNTBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWBNTBD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:01:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030587AbWBNTBB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 14:01:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EJ0iDZ025360
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 11:00:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EJ0i14021841;
	Tue, 14 Feb 2006 11:00:44 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87irrhvkyl.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16157>



On Tue, 14 Feb 2006, Carl Worth wrote:
> 
> Oh, I'm blind. I didn't see git-checkout-index, (thanks Kenneth for
> mentioning it elsewhere in the thread). So now I've at least got the
> recipe I was after:
> 
> 	git-read-tree <revision>
> 	git-update-index --replace
> 	git-checkout-index -a -f -u

This is very very inefficient, because it will replace the old 
index without using the (valid) information that is there from before. 
Resulting in a lot of unnecessary IO..

You may not care for a small project, but for bigger stuff, you're better 
off using more subtle approaches.

Explore using "git-read-tree --reset <revision>" or, perhaps even more 
interesting is "git-read-tree -u -m <oldrev> <newrev>"

> And I think that would make for a dandy command to have in git. Any
> suggestions for a name?

I'd suggest "git reset" as a cool way to say that it "resets" the tree to 
another version ;)

		Linus
