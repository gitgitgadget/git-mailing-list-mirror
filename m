X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Fri, 01 Dec 2006 23:54:38 -0800
Message-ID: <7vlklq20n5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
	<7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
	<87veku3i0j.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 07:54:50 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87veku3i0j.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	01 Dec 2006 22:54:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33003>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqPhs-0006Mq-FN for gcvg-git@gmane.org; Sat, 02 Dec
 2006 08:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162823AbWLBHym (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 02:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162825AbWLBHyl
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 02:54:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47338 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1162823AbWLBHyl
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 02:54:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061202075439.TWEN97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 2 Dec
 2006 02:54:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tjuo1V00P1kojtg0000000; Sat, 02 Dec 2006
 02:54:49 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

>> > +Contrary to other SCMs, with GIT you have to explicitly "add" all the
>> > +changed file content you want to commit together to form a changeset
>> > +with the 'add' command before using the 'commit' command.
>
> I think we can explain the git model in positive terms that stand on
> its own. People will learn the differences and appreciate how git is
> better. So I'd just drop "Contrary to other SCMs".

I already committed Nico's on 'master', because all he said in
his response made sense, but this comment made me rewind it.  I
agree that we do not have to start with a "we are harder to
learn, we are different from what you know, you have been
warned."  I'll queue it for 'next'.

> Wow, this index stuff sure takes a lot of explaining. Why are users
> better off having to grasp all of that stuff before they can
> successfully add; edit; #oops, add again; and commit their files?

Jumping the index is not about that sequence.  It is about being
interrupted while doing something else, and committing a smaller
trivial change first that is independent from what you have been
doing.  Beginners do not have to do that "interrupted work"
sequence.

>> I wonder if this sequence should do the same as "git rm -f foo":
>>
>> 	$ /bin/rm foo
>>      $ git add foo
>
> Argh. Please no. Update-index already exists. Let's not push all of
> its semantics onto "add". Let's use "add" for when the user _actually_
> wants to _add_ a file. Please? please?

I do agree "adding the deletion" is a funny terminology.  But
this is a illustration that this part of proposed update to the
tutorial could be further improved:

+But for instance it is best to only remember 'git add' + 'git commit'
+and/or 'git commit -a'.
+
+No special command is required when removing a file; just remove it,
+then tell `commit` about the file as usual.

We say "you should add modified state again if you edit it again
after you added it" in a section before these sentences, and
encourage users to consistently say 'git add'.  Since we supply
"git rm" and "git mv" to make it convenient to remove/rename
files and index entries at the same time, I think it would be
better to say "Use add/rm/mv", not "don't worry about rm".

By the way, aren't people disturbed that "git rm" does not
default to "-f" -- I rarely use the command myself but that
makes it feel even more awkward that "git rm foo" does not
remove the file "foo".

> PS. Is there a twelve-steps program for people who can't let a thread
> die? I really want to stop, and I keep telling myself I can stop
> anytime I want.

Well, I think at least we are converging.

