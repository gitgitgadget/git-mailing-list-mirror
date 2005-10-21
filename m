From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-parse: pass on "--" flag when required
Date: Thu, 20 Oct 2005 17:24:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201720420.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510201711380.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 02:24:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkhh-0002a8-Oo
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJUAYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJUAYL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:24:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932481AbVJUAYK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:24:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L0O4FC003531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 17:24:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L0O3k9016566;
	Thu, 20 Oct 2005 17:24:04 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510201711380.10477@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10393>



On Thu, 20 Oct 2005, Linus Torvalds wrote:
> 
> If rev-parse output includes both flags and files, we should pass on any 
> "--" marker we see, so that the end result can also tell the difference 
> between a flag and a filename that begins with '-'.

Btw, if it wasn't obvious, this is also required to keep files and revs 
separate.

I don't think we have anything that cares right now, but I'm working on 
trying to get "git-rev-list" to limit its output to the files given on the 
command line, and then I want to be able to do

	gitk -- rev-list.c

and in my version of git-rev-list, the "--" is required to separate out 
the revs from the names (since otherwise it's just too error-prone).

That requires that git-rev-parse not only honor "--", but pass it through 
when the output can contain both revs/flags _and_ filenames.

			Linus
