From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 17:43:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv>  <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 02:44:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fctqx-0006Bo-Sp
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWEHAnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEHAnz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:43:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWEHAny (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:43:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k480hqtH022832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:43:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k480hpx7030304;
	Sun, 7 May 2006 17:43:51 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147048587.17371.13.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19733>



On Sun, 7 May 2006, Pavel Roskin wrote:
> 
> I'm only concerned that we would be hardcoding the word "branch".  We
> could need fancy section names for other things in the future.

Fair enough. We could have used some fake section name that you can't 
generate any other way (in fact, "Branch.$branchname" would be that), but 
the upside of using "branch" is exactly that you _can_ generate it with 
the old-style syntax that is acceptable to older git versions too.

So the common case (all-lowercase, no special characters branch names) 
wouldn't need to break.

Now, backwards competibility for the .git/config file isn't likely a huge 
issue, but it does matter if you want to do things like "git bisect" to 
bisect a totally unrelated bug, and part of the bisection is actually to 
install the older git version that you're testing for the bug..

(Which is probably an insane thing to do anyway - you should be able to 
test any bugs _without_ actually having to install the git version you're 
testing. But whatever..)

		Linus
