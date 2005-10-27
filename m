From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 08:12:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510270801560.4664@g5.osdl.org>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051026083658.GE30889@pasky.or.cz> <pan.2005.10.27.08.49.59.849081@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 17:16:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV9Qp-0005PM-GE
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 17:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVJ0PMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 11:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVJ0PMk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 11:12:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750995AbVJ0PMk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 11:12:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9RFCKFC020976
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Oct 2005 08:12:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9RFCJn6017227;
	Thu, 27 Oct 2005 08:12:19 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.27.08.49.59.849081@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10716>



On Thu, 27 Oct 2005, Matthias Urlichs wrote:
> 
> It'll fork a subshell, but if the $() is a builtin, it won't exec.
> 
> That being said, "echo $((1 + 2 + $((3 + 4))))" will not even fork.

Right. Don't confuse $(..) with $((..)).

They have absolutely nothing to do with each other, except for looking a 
bit similar. 

The $((..)) is shell-builtin arithmetic. I could imagine a broken shell 
forking and executing "dc" for it, but quite frankly, that sounds so 
unlikely as to be totally silly. So realistically, a shell either supports 
it or not. 

Oh - there's another similarity between $(..) and $((..)). They're both 
POSIX 1003.2 standard features, so any "modern" shell should support them. 
Although in practice I don't know if that means anything else than ksh 
(where both syntaxes came from, actually).

		Linus
