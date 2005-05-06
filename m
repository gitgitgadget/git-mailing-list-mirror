From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 09:13:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5Jw-0000f2-8u
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEFQLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEFQLl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:11:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:9626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVEFQLh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:11:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46GBZU3032166
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 09:11:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46GBYgK016076;
	Fri, 6 May 2005 09:11:34 -0700
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <427B3DB3.4000507@tuxrocks.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Frank Sorenson wrote:
> 
> Okay, I've got some "How can I?" questions.  I hope I'm not the only one
> still working to "git it".
> 
> How can I git a list of commits that have modified a particular file?
> For example, I'd like to do something like this:
> # git-file-revs Makefile
> f7eb55878f11575281add2a5726e483aed5e45bb
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

There has been at least two different scripts for this posted, and one C 
source code version.

I just haven't integrated them, because I'm an idiot, and too much choice 
makes me run around in small circles and clucking.

Guys - whoever wrote one of the scripts, can you please send out your 
current version to the git list and cc me, and explain why yours is 
superior to the other peoples version. Please?

But I might cook something up myself too. 

> How can I output a list of the filename(s) modified by a particular
> commit? (for example)
> # git-commit-info files 6741f3a7f9922391cd02b3ca1329e669497dc22f

You need to use "git-tree-diff", but it doesn't want one commit, it wants 
two.

In the case of "what did this one commit change", you need to look up its 
parents (there can be more than one! In fact, the current git repository 
has one entry with _five_ parents), and then you need to select one of 
them as the reference. In other words, if it's a merge, you need to select 
which side you care about.

> Can I use cg-log to output just the information about a particular
> commit?  (I don't need all the commits, just the one I'm interested in).

You don't even need cg-log for that. If you already know which commit 
you're interested in, just output that one commit:

	git-cat-file commit <commit-name-here>

> After doing a cg-update, can I cg-log just the changes since the last
> update?  Alternatively, how can I tell cg-log I'm caught up, and don't
> need anything historical?

I don't know how to do with with cg-update, but if you use the 
"git-pull-script" thing, you can do

	git-diff-tree -p ORIG_HEAD HEAD

which shows you what the pull brought in.

> Can I do these with git/cogito, or will I need to start diving deeper
> into the code?

Apart from finding the "which commit changed this", it's all trivially 
doable. And the "which commit" thing is also trivially doable if you just 
find the script..

		Linus
