X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 11:55:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 19:56:57 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87hcwgu5t1.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32792>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gps1K-0003Gk-SR for gcvg-git@gmane.org; Thu, 30 Nov
 2006 20:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031202AbWK3T4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 14:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031005AbWK3T4Z
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 14:56:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:64450 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031202AbWK3T4X (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 14:56:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUJtYjQ006641
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 11:55:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUJtVIi017072; Thu, 30 Nov
 2006 11:55:31 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Carl Worth wrote:
> 
> If the "create file; git add; edit file; git commit" confusion isn't
> blisteringly obvious to the git maintainers then I think I have to
> give up here.
> 
> And this isn't just CVS-induced brain damage.

I'm sorry, but you are wrong.

It really _is_ CVS-induced brain damage, and I'm trying to teach you. You 
can give up, but that's really "refuse to see the damage that systems like 
RCS and CVS has done to the world"

The fundamental brain damage that CVS (and RCS, and SVN, and just about 
anything else) has had is thinking that "filenames" (and sometimes this is 
"fixed" to be "file ID's") are somehow special, and a totally separate 
thing from "file contents".

Really. It's a BUG. It's a deficiency in CVS and friends. And it's a 
deficiency that you have gotten so used to that you don't even see that 
it's simply obviously NOT TRUE.

You _cannot_ have a filename without the contents of that filename. That 
whole concept doesn't make sense, except in the twisted AND WRONG mental 
model of "files have identities even without content".

The whole point of git is that it is about "project state" and the history 
that binds those states together. People have kind of come to accept that, 
and a lot of people realize what it means, but I don't think you've really 
accepted what it means for something as simple as a "git add" command.

Again, totally ignore the index. Imagine that it doesn't exist. Imagine 
that you never actually learnt about it, and that none of the 
documentation ever mentions it, and just ask yourself:

	"What does 'adding a file' really mean?"

I mean _really_. It cannot be about the "filename", because a filename 
simply doesn't have any meaning alone. Remember what git is all about.

No, when you do a "git add", YOU DO NOT TALK ABOUT FILENAMES AT ALL.

	NOT EVEN CLOSE!

No. Git is, and has always been, all about tracking project content. The 
fact that CVS is crap, and thinks that "filenames" are special (and this 
causes major problems when you do renames), and the fact that SVN is crap, 
and things that "file identities" are special (and this causes major 
problems when you split a file or when two files join) is very much about 
THEIR F*CKING IDIOTIC FUNDAMENTAL BRAINDAMAGE!

So take five minutes to really think about that. Take an hour. Take a 
week. Ponder it.

What does it mean to "add" something to a project? It has _nothing_ to do 
with "filenames". Yeah, the filename obviously exists, but it's not 
something that exists on its own. You add the ONLY thing that git tracks. 

You add CONTENT.

When you do "git add file.c" you aren't adding a filename to the list of 
files that git knows about. Not even CLOSE. No. You are really adding 
_content_ to the project you are tracking. You haven't bound it to a 
commit yet, but it's there. It's there both conceptually, and very much in 
a real technical sense too (you've literally added the git object that 
that file describes to the object database - the "commit" and "tree" 
objects to tie it all together is just waiting to be added, but they 
really just expose it - the actual file object has already been created 
when you do "git add".)

So yes, you very much ARE talking about CVS braindamage. The reason why

	git add file.c
	echo New line >> file.c
	git commit

commits the _old_ content, is very much because git is ALL ABOUT THE 
CONTENT. It has _never_ been about filenames. And it _shouldn't_ be about 
filenames, because that would be BUGGY AND BROKEN.

Sorry for shouting, but as long as you think "git add" adds a filename, 
you're just not getting it. And I think it's really sad that you don't 
even seem to understand that yes, this _is_ braindamage that has been 
forced upon you by decades of mental rape done by bad source control 
systems.

Please. File identities are _bad_ in the SVN kind of setting. The CVS kind 
of "filename == file identity" is even _worse_, but it's still exactly the 
same disease. It's the disease of thinking that metadata is somehow 
"different" from real data, and that "files" have identities that are 
somehow separate from the data they contain.

Face it, git is consistent, and if it acted the way you seem to expect it 
to act, it would actually be a BUG. Exactly because you cannot and MUST 
NOT think that "filename" is something that has meaning without "file 
content" (or "file type" and "file permissions" - they all go together).

And notice? NONE OF THIS HAS ANYTHING AT ALL TO DO WITH 'INDEX'!! The 
explanation above is not "this is how the index works". It's a much more 
fundamnetal issue of getting the right mental model, where the only thing 
that matters is contents.

So even without an index, "git add" should work the way it works, once you 
can just let go of the broken model that is CVS.

Please. Join me, Luke. The power of the git side is stronger. I am your 
father. 

