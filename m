From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 00:59:49 +0200
Message-ID: <20050701225949.GA28011@pasky.ji.cz>
References: <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <20050701180944.GA14375@pasky.ji.cz> <42C58D83.9060107@zytor.com> <20050701214230.GA22003@pasky.ji.cz> <42C5BB33.5010304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 00:53:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoUNI-0002lY-CP
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 00:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVGAXAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 19:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGAXAL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 19:00:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31722 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261352AbVGAW7w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 18:59:52 -0400
Received: (qmail 31886 invoked by uid 2001); 1 Jul 2005 22:59:49 -0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <42C5BB33.5010304@zytor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 01, 2005 at 11:52:51PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> You're missing the whole point of the discussion.  Right now the only 
> thing that makes a global object store impossible is the potential for a 
> tag conflict, either intentional or accidental.

Ok, I was arguing about something a bit different here, sorry.

The point of refs/tags/ should be to just indicate tags which we have in
the current head (remember that this structure comes from the times
before Dave, when the repository:"master branch" mapping was 1:1), since
that are usually the only objects you have in _your_ repository.  What's
the point of having tag linux-1.0.4-ac128 when you don't have the
linux-1.0.4-ac branch whatsoever?  The distinction of "public" vs
"private" tags here is really only that the "public" tags should be
propagated to your head when you merge the remote head.  This way, each
head will have its own set of tags, and it will be only tags which
actually reference objects relevant to the head.

Now that we can have many branches in a repository, each with its own
set of tags, we should probably extend the tags hierarchy to
refs/tags/<head>/<tagname>. And see, you can actually have that in the
global object store, as long as the head names are unique. But heads
don't propagate in any way so that's a purely administrative issue on
the global store side.

BTW, I don't think many (most?) heads named "master" are big issue.
That's how the head is called locally, and noone says that's how the
head should be known at the other side too. It's fine to have a head
called "master" in your repository and when pushing to the global object
store call it "pasky/linux-l33t" over there. (If you are using Cogito,
you can add that branch using a URL
proto://global/obj/store#pasky/linux-l33t.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
