X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 09:13:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 17:15:22 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061130164046.GB17715@thunk.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32778>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GppUm-0005jg-11 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030823AbWK3ROp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030824AbWK3ROo
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:14:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5868 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030820AbWK3ROn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:14:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUHDsjQ030304
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 09:13:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUHDqm0012063; Thu, 30 Nov
 2006 09:13:53 -0800
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Theodore Tso wrote:
>
> But then why is the default for "git commit" to commit the index, if
> the index is almost == HEAD?  And why is git-update-index given such
> prominence in the documentation?

The default is: commit everything that you ask for to be committed.

If you haven't marked anything to be committed (which you can do with "git 
add" too, or with simply being in the middle of a merge, or by having done 
something like "git pull -n" or similar that does everything _but_ 
commit), then git commit will say "nothing to do".

It has NOTHING to do with the index per se. 

I still don't understand why people are so hung up about the index.

So ignore the index entirely, and follow along with me:

	"git commit" with no parameters simply DOES NOT DO ANYTHING YOU 
	HAVEN'T ALREADY ASKED YOU TO DO.

It's that simple. It's that logical. Ignore the index. Ignore everything 
else. Just read that simple, straightforward, and logical sentence on its 
own. It all makes sense.

Then, the trivial follow-up is:

	If you want to commit _all_ dirty files, use "git commit -a". 
	Otherwise, name the files or subdirectories you want to commit 
	explicitly.

Again: THIS JUST MAKES SENSE.

Asking for "-a" to be the default behaviour is BAD.

For example, in "git commit --amend", it's _important_ that "-a" not be 
the default, because you may well want to just amend the commit _message_. 
No files updated AT ALL. You may have other state that is still dirty 
(because you didn't ask it to be committed last time), and they should NOT 
be committed, because the simple rule is:

	"git commit" with no parameters simply DOES NOT DO ANYTHING YOU 
	HAVEN'T ALREADY ASKED YOU TO DO.

Repeat the above sentence again. IT JUST MAKES SENSE.

So maybe the documentation shouldn't mention the "index" at all, because 
it apparently scares and confuses people. But the fact is, the 
documentation started out as _technical_ documentation, that explains the 
_technical_ side of git. We don't have lots of "end-user" docs. 

But the lack of such end-user documentation should not cause idiotic 
threads like this, where people blame "the index". 

Yeah, so the docs are too scary. But none of this has anything to do with 
"the index". It's all logical on its own, and the default behaviour to not 
commit anything you haven't asked to be committed is the right one.

Make "git commit" just say "You didn't say what you wanted to commit. 
Maybe you meant 'git commit -a'" if there's nothing to commit. How hard 
can that be? But don't change semantics now, and please DO NOT change them 
to something _worse_ than what we have now (and automatically adding the 
"-a" only in _certain_ circumstances is definitely much worse imnsho)

