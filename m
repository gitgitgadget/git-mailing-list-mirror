X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: multi-project repos
Date: Fri, 17 Nov 2006 23:31:42 -0800
Message-ID: <7vvelddxcx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<455CA2A8.5010700@xs4all.nl>
	<Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
	<20061117162605.GA32597@spearce.org>
	<7virhem0ps.fsf@assigned-by-dhcp.cox.net>
	<20061118060243.GB2125@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 07:31:54 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118060243.GB2125@spearce.org> (Shawn Pearce's message of
	"Sat, 18 Nov 2006 01:02:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31762>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlKfz-0002A3-Ro for gcvg-git@gmane.org; Sat, 18 Nov
 2006 08:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756234AbWKRHbp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 02:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbWKRHbp
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 02:31:45 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54515 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1756234AbWKRHbo
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 02:31:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118073143.MWMR20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Sat, 18
 Nov 2006 02:31:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o7Xq1V0061kojtg0000000; Sat, 18 Nov 2006
 02:31:50 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> > Although if you have reflog enabled on your current branch there
>> > is a 1 character shorter syntax:
>> >
>> > 	gitk HEAD@{1}..
>> 
>> Are you sure about this?  I've seen "next@{1}" to look at
>> history of the named branch, but never history of "HEAD".
>  
> Yes.  :-)
>
> If the ref name is a symref then we resolve the symref all the
> way down to the real ref before we open and walk the reflog.
> Therefore this works.

True, except if you did:

        $ git pull
        $ git checkout otherbranch
        $ git show HEAD@{1}

My real point was that I was wondering if it also makes sense
for ref-log to record switching branches for the symref itself.

But after sending that message I thought about it a bit more and
concluded that it is not an interesting information.  It is more
code that affects unrelated places even if we were to implement
it and without real gain, so let's not log symref itself and
keep the current implementation.


