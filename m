From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Thu, 13 Oct 2005 14:23:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com>
 <434EC07C.30505@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, users@kernel.org,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 23:26:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQAYi-0004B9-6t
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 23:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVJMVYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVJMVYN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 17:24:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbVJMVYM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 17:24:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DLNw4s023801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 14:23:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DLNvLx002901;
	Thu, 13 Oct 2005 14:23:57 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <434EC07C.30505@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10089>



On Thu, 13 Oct 2005, Jeff Garzik wrote:
> 
> Right now, things go through an expand-contract cycle:
> 
> * people base repos off of Marcelo or Linus's git repo, including using those
> pack files (saves download bandwidth, disk space through hardlinks).
> 
> * as 3rd parties and Marcelo/Linus merge stuff, .git/objects/* grows with
> individual files.
> 
> * once a month/release/whatever, Linus packs his repo, allowing all the repos
> following his to use those pack files, pruning a ton of objects off of
> kernel.org.
> 
> I have real users of my git repos who can't just download a 100MB pack file in
> an hour, it takes them many hours.

Argh.

Ok, I'm going to follow this up with three small patches that add a "-l" 
flag to "git repack", which does only a "local repack" (ie it will pack 
only objects that are _not_ in packs in alternate object directories).

That will hopefully mean that this usage case is supported too.

		Linus
