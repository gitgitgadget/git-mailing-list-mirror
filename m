From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Remove bashism from t3210-pack-refs.sh
Date: Fri, 6 Oct 2006 09:33:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610060931160.3952@g5.osdl.org>
References: <20061006091054.15209.35068.stgit@leonov.stosberg.net>
 <81b0412b0610060635n51482e71wab02f9a11be4e619@mail.gmail.com>
 <eg5r9k$58c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 18:34:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVseI-0001Wu-VG
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWJFQeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWJFQeH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:34:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422697AbWJFQeE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:34:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k96GY0aX007930
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Oct 2006 09:34:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k96GXx24003135;
	Fri, 6 Oct 2006 09:33:59 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eg5r9k$58c$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.463 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28416>



On Fri, 6 Oct 2006, Jakub Narebski wrote:
> Alex Riesen wrote:
> 
> > On 10/6/06, Dennis Stosberg <dennis@stosberg.net> wrote:
> >> -     SHA1=$(< .git/refs/heads/a) &&
> >> +     SHA1=`cat .git/refs/heads/a` &&
> > 
> > Only "<" (the redirection part) is bashism. The "$()" is POSIX.
> 
> BTW. it is not packed-refs safe.

Well, since that seems to be a test-case for the packed-refs thing, that's 
probably not a problem ;)

In a real-life git script you should do something like

	SHA1=$(git-rev-parse --verify "refs/heads/$head^0") && ...

to get the SHA1 and verify that it's all good, but since that script is 
all about checking that packing does the right thing, I think it's fine to 
do it by hand there..

		Linus
