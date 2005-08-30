From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: please pull ppc64-2.6.git
Date: Mon, 29 Aug 2005 17:20:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org> <17171.39652.237263.484079@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 02:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9trd-000100-6a
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVH3AUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 20:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVH3AUa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 20:20:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751426AbVH3AU3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 20:20:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U0KMjA008538
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 17:20:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U0KLnY000884;
	Mon, 29 Aug 2005 17:20:22 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17171.39652.237263.484079@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7931>



On Tue, 30 Aug 2005, Paul Mackerras wrote:
> 
> What can one put in the alternates file?  Just an absolute path, or
> does a relative path or a URL work too?

Only an absolute path.

URL's fundamentally do not work, and relative paths end up being parsed as
relative to where-ever the user happens to be (and some commands will 
"chdir()" into the .git directory, while others will not).

For a raw git directory like the ones on master.kernel.org, with a
relative pathname (relative to the main git directory itself) the
_pulling_ should actually happen to work, since that will be happening in
the xxx.git directory using "GIT_DIR=.".

But anything who uses GIT_DIR=<something else> from another directory
wouldn't be able to use it. That probably includes gitweb, btw.

So only do the absolute ones. Maybe we should define some well-specified 
meaning for relative ones, but it definitely isn't there now.

> > or similar. That also makes gitweb able to show diffs etc, something it 
> > can't do for a broken partial repository.
> 
> Gitweb still doesn't work; I think someone needs to update the git on
> *.kernel.org.

Hmm, yes. kernel.org is at 0.99.4, and the objects/info/alternates thing 
was done after that.

It's in 0.99.5, though, so next time kernel.org updates its git version, 
it will automagically start working.

(And I use my own git installation, so it works fine for me, and I just 
pulled the thing without problems).

			Linus
