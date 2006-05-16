From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git add $ignored_file" fail
Date: Tue, 16 May 2006 15:28:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 17 00:28:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg81c-0008Qi-Bn
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWEPW2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWEPW2R
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:28:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932212AbWEPW2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:28:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GMSAtH021786
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 15:28:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GMS9Fl025777;
	Tue, 16 May 2006 15:28:10 -0700
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161507w3a27152dq@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20142>



On Wed, 17 May 2006, Santi wrote:
> 
>      When you try to add ignored files with the git-add command it
> fails because the call to:
> 
> git-ls-files -z \
>        --exclude-from="$GIT_DIR/info/exclude" \
>        --others --exclude-per-directory=.gitignore
> 
>      does not output this file because it is ignored. I know I can do it with:
> 
> git-update-index --add $ignored_file
> 
> I understand the behaviour of git-ls-files but I think it is no the
> expected for git-add, at least for me.

Well, the thing is, git-add doesn't really take a "file name", it takes a 
filename _pattern_.

Clearly we can't add everything that matches the pattern, because one 
common case is to add a whole subdirectory, and thus clearly the 
.gitignore file must override the pattern.

So it's consistent that it overrides it also for a single filename case, 
no?

		Linus
