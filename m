From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Next problem: empty ident  <joern@limerick.(none)> not allowed
Date: Tue, 18 Apr 2006 13:47:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181341000.3701@g5.osdl.org>
References: <20060418202525.GD25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2009567427-1145393037=:3701"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 22:47:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVx6f-0003l8-4v
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDRUr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWDRUr0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 16:47:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932338AbWDRUrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 16:47:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IKlOtH018409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 13:47:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IKlNTX024718;
	Tue, 18 Apr 2006 13:47:23 -0700
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418202525.GD25688@wohnheim.fh-wedel.de>
Content-ID: <Pine.LNX.4.64.0604181344020.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18880>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2009567427-1145393037=:3701
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0604181344021.3701@g5.osdl.org>



On Tue, 18 Apr 2006, Jörn Engel wrote:
> 
> And now I have some questions:
> 1. Why didn't the environment variables work?

They do. But they just described the _author_. Git wanted the _committer_ 
to be described too.

So if you had used GIT_COMMITTER_NAME/EMAIL, everything would have been 
fine.

Notice that if you don't give any author information, git will assume that 
the committer is the author, so if you give committer information, you 
don't actually need to give author information. It "knows" that the 
committer is you, and since you don't tell it otherwise, it will think 
that you're the author too.

So the committer is always the "default author".

But the reverse is _not_ true: even if you tell git who the author is, it 
will _not_ assume that the committer is the same one. It knows that the 
committer is you, but you didn't talk about yourself, you just talked 
about the author.

That non-symmetric behaviour does make a lot of sense, if you think about 
it a while. The author is _not_ the "default committer". 

Putting your name and email in the git config file solves the problem, 
because then git knows who the committer is (and by extension, the 
"default author").

> 2. Why is there a check for commit information when I pull from some
> tree?

Because you're going to create a merge commit. It wants to know who to 
attribute that merge to. Why the committer is, in other words.

		Linus
--21872808-2009567427-1145393037=:3701--
