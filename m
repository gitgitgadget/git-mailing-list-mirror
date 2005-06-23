From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 09:06:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506230833170.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
 <42BA6177.8060202@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 17:58:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlU5y-0002WJ-F3
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 17:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVFWQE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVFWQE3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 12:04:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262594AbVFWQEV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 12:04:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NG4GjA006933
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 09:04:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NG4FEl026761;
	Thu, 23 Jun 2005 09:04:15 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA6177.8060202@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> Chuckle.  What does one call a Freudian slip, in computer-land?

A "Knuthian slip"?

> WARNING:  You have previously called git-changes-script quite ugly (not 
> surprising), and this 'git log x..y' will probably replace it in my 
> usage, long term.

Even short-term, you could actually make it prettier. 

You can actually use git across multiple directories by setting the
GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable to point to the
alternate ones, so you should be able to do a "compare with remote" with 
something like this:

	export GIT_ALTERNATE_OBJECT_DIRECTORIES=$remote/.git/objects
	remote_head=$(cat $remote/.git/HEAD)
	git log $remote_head..

which should literally give a nice log of what is in your HEAD but not in 
$remote_head. And if you want to see it the other way? Just change the 
last line to

	git log HEAD..$remote_head

and voila, you're done.

The nice thing about this approach is that this works with other git
programs too, ie you can replace "git log" with "gitk", and suddenly you
see graphically the commits that are in your tree but not in the remote
HEAD or vice versa.

Yeah, yeah, totally untested and maybe I'm talking through by *ss, but it 
should work in theory.

		Linus
