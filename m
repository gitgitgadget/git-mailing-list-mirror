From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rev-parse, unknown arguments and extended sha1's
Date: Fri, 24 Jun 2005 09:09:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506240904240.11175@ppc970.osdl.org>
References: <20050624122436.GA15182@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 18:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlqgY-00024O-Ig
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVFXQLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVFXQLO
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:11:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263146AbVFXQHj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:07:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OG7IjA012253
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 09:07:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OG7HPx029521;
	Fri, 24 Jun 2005 09:07:18 -0700
To: Sven Verdoolaege <skimo@liacs.nl>
In-Reply-To: <20050624122436.GA15182@pc117b.liacs.nl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Sven Verdoolaege wrote:
>
> Is git-rev-parse supposed to echo arguments it doesn't understand ?
> It currently does, but git-checkout-script seems to think it doesn't:
> 
>                 rev=$(git-rev-parse "$arg")   
>                 if [ -z "$rev" ]; then
>                         echo "unknown flag $arg"
>                         exit 1
>                 fi

Argh, there's a "--revs-only" thing that I was planning to use there, some 
remnant of an ealy plan (unimplemented) to use that to determine if it is 
a filename to be checked out, or a revision.

But then I never got around to do the "specify individual filenames" part 
of "git checkout".

Anyway, add the --revs-only, and the test against empty should make a bit 
more sense. In fact, it _should_ test that it's a SHA1 (and not a rev 
argument), but I couldn't come up with a good way to test that in shell.

		Linus
