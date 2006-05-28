From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Remote git-cat-file?
Date: Sat, 27 May 2006 17:32:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271729440.5623@g5.osdl.org>
References: <loom.20060528T002420-957@post.gmane.org>
 <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 02:33:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk9DV-0004of-FN
	for gcvg-git@gmane.org; Sun, 28 May 2006 02:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWE1AdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 20:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWE1AdK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 20:33:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965008AbWE1AdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 20:33:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4S0W12g001389
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 17:32:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4S0W01j021434;
	Sat, 27 May 2006 17:32:01 -0700
To: Elrond <elrond+kernel.org@samba-tng.org>
In-Reply-To: <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20874>



On Sat, 27 May 2006, Linus Torvalds wrote:
> 
> Well, depending on just how much you know about the object, you can fake 
> it. For example, if you already know it's a commit, and you know the 
> parents, then yes, you can download it by basically saying that you want 
> that particular object and you already have the parents.

The other (similar) case is for tag objects. When you do "git ls-remote" 
on the remote repo, it will tell you both the tag object SHA and the 
object SHA of the thing it points to, so you can then do a git protocol 
exchange where you do a 

	for_each_tag
		"want <tagsha1>"

	for_each_tag
		"have <objectitpointstosha1>"

and you'll get just the tag object back.

		Linus
